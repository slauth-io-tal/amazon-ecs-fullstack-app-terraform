# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

/*==================================================
      AWS Networking for the whole solution
===================================================*/

# ------- VPC Creation -------
resource "aws_vpc" "aws_vpc" {
  cidr_block           = var.cidr[0]
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name      = "vpc_${var.name}"
    yor_trace = "0d5f6499-6aee-4499-a214-c918c8457808"
  }
}

# ------- Get Region Available Zones -------
data "aws_availability_zones" "az_availables" {
  state = "available"
}

# ------- Subnets Creation -------

# ------- Public Subnets -------
resource "aws_subnet" "public_subnets" {
  count                   = 2
  availability_zone       = data.aws_availability_zones.az_availables.names[count.index]
  vpc_id                  = aws_vpc.aws_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.aws_vpc.cidr_block, 7, count.index + 1)
  map_public_ip_on_launch = true
  tags = {
    Name      = "public_subnet_${count.index}_${var.name}"
    yor_trace = "bb9ea046-d927-4a78-83b8-28596b0a4f38"
  }
}

# ------- Private Subnets -------
resource "aws_subnet" "private_subnets_client" {
  count             = 2
  availability_zone = data.aws_availability_zones.az_availables.names[count.index]
  vpc_id            = aws_vpc.aws_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.aws_vpc.cidr_block, 7, count.index + 3)
  tags = {
    Name      = "private_subnet_client_${count.index}_${var.name}"
    yor_trace = "76a26b55-e9a0-4e18-86c1-7dbf867dc144"
  }
}

resource "aws_subnet" "private_subnets_server" {
  count             = 2
  availability_zone = data.aws_availability_zones.az_availables.names[count.index]
  vpc_id            = aws_vpc.aws_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.aws_vpc.cidr_block, 7, count.index + 5)
  tags = {
    Name      = "private_subnet_server_${count.index}_${var.name}"
    yor_trace = "f385a48c-d176-444d-b8f6-5574ca139d1a"
  }
}

# ------- Internet Gateway -------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.aws_vpc.id
  tags = {
    Name      = "igw_${var.name}"
    yor_trace = "86ea4d49-7708-42c0-932b-fb93e15a7233"
  }
}

# ------- Create Default Route Public Table -------
resource "aws_default_route_table" "rt_public" {
  default_route_table_id = aws_vpc.aws_vpc.default_route_table_id

  # ------- Internet Route -------
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name      = "public_rt_${var.name}"
    yor_trace = "f137ae03-f4e1-436c-b3c5-e1a61c393074"
  }
}

# ------- Create EIP -------
resource "aws_eip" "eip" {
  vpc = true
  tags = {
    Name      = "eip-${var.name}"
    yor_trace = "a4750025-6590-4efa-bfcf-0a9d97a6385d"
  }
}

# ------- Attach EIP to Nat Gateway -------
resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnets[0].id
  tags = {
    Name      = "nat_${var.name}"
    yor_trace = "5a5dd6be-757d-487c-8506-0f5ab128d1d4"
  }
}

# ------- Create Private Route Private Table -------
resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.aws_vpc.id

  # ------- Internet Route -------
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name      = "private_rt_${var.name}"
    yor_trace = "12826a58-767d-4b63-aa70-224a29b12be4"
  }
}

# ------- Private Subnets Association -------
resource "aws_route_table_association" "rt_assoc_priv_subnets_client" {
  count          = 2
  subnet_id      = aws_subnet.private_subnets_client[count.index].id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "rt_assoc_priv_subnets_server" {
  count          = 2
  subnet_id      = aws_subnet.private_subnets_server[count.index].id
  route_table_id = aws_route_table.rt_private.id
}

# ------- Public Subnets Association -------
resource "aws_route_table_association" "rt_assoc_pub_subnets" {
  count          = 2
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_vpc.aws_vpc.main_route_table_id
}