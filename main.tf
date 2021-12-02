resource "aws_vpc" "aws-vpc-demo-de" {
  cidr_block = "10.71.1.0/24"
  enable_dns_hostnames = true
  enable_dns_support = true
  
  tags = {
      Name = "aws-vpc-demo-de"
  }
}

resource "aws_subnet" "aws-sn-demo-public-de-01" {
  vpc_id     = aws_vpc.aws-vpc-demo-de.id
  cidr_block = "10.71.1.0/27"
  availability_zone = "${var.region}a"

  tags = {
    Name = "aws-sn-demo-public-de-01"
  }
  depends_on = [ aws_vpc.aws-vpc-demo-de ]
}

resource "aws_subnet" "aws-sn-demo-public-de-02" {
  vpc_id     = aws_vpc.aws-vpc-demo-de.id
  cidr_block = "10.71.1.32/27"
  availability_zone = "${var.region}b"

  tags = {
    Name = "aws-sn-demo-public-de-02"
  }
  depends_on = [ aws_vpc.aws-vpc-demo-de ]
}


resource "aws_subnet" "aws-sn-demo-private-de-01" {
  vpc_id     = aws_vpc.aws-vpc-demo-de.id
  cidr_block = "10.71.1.64/27"
  availability_zone = "${var.region}a"

  tags = {
    Name = "aws-sn-demo-private-de-01"
  }
  depends_on = [ aws_vpc.aws-vpc-demo-de ]
}

resource "aws_subnet" "aws-sn-demo-private-de-02" {
  vpc_id     = aws_vpc.aws-vpc-demo-de.id
  cidr_block = "10.71.1.96/27"
  availability_zone = "${var.region}b"

  tags = {
    Name = "aws-sn-demo-private-de-02"
  }
  depends_on = [ aws_vpc.aws-vpc-demo-de ]
}

resource "aws_internet_gateway" "aws-igw-demo" {
  vpc_id  = aws_vpc.aws-vpc-demo-de.id

  tags = {
    Name = "aws-igw-demo"
  }

  depends_on = [ aws_vpc.aws-vpc-demo-de ]
}

resource "aws_route_table" "aws-rt-demo-public-01" {
  vpc_id = aws_vpc.aws-vpc-demo-de.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws-igw-demo.id
  }

  lifecycle {
    ignore_changes = [ route ]
  }

  tags = {
    Name = "aws-rt-demo-public-01"
  }

  depends_on = [ aws_vpc.aws-vpc-demo-de, aws_internet_gateway.aws-igw-demo ]
}

resource "aws_route_table" "aws-rt-demo-public-02" {
  vpc_id = aws_vpc.aws-vpc-demo-de.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws-igw-demo.id
  }

  lifecycle {
    ignore_changes = [ route ]
  }

  tags = {
    Name = "aws-rt-demo-public-02"
  }

  depends_on = [ aws_vpc.aws-vpc-demo-de, aws_internet_gateway.aws-igw-demo ]
}

resource "aws_route_table" "aws-rt-demo-private-01" {
  vpc_id = aws_vpc.aws-vpc-demo-de.id

  lifecycle {
    ignore_changes = [ route ]
  }

  tags = {
    Name = "aws-rt-demo-private-01"
  }
  depends_on = [ aws_vpc.aws-vpc-demo-de ]
}

resource "aws_route_table" "aws-rt-demo-private-02" {
  vpc_id = aws_vpc.aws-vpc-demo-de.id

  lifecycle {
    ignore_changes = [ route ]
  }
  tags = {
    Name = "aws-rt-demo-private-02"
  }
  depends_on = [ aws_vpc.aws-vpc-demo-de ]
}


resource "aws_route_table_association" "aws-rta-demo-public-01" {
  subnet_id = aws_subnet.aws-sn-demo-public-de-01.id
  route_table_id = aws_route_table.aws-rt-demo-public-01.id

  depends_on = [ aws_route_table.aws-rt-demo-public-01, aws_subnet.aws-sn-demo-public-de-01 ]
}

resource "aws_route_table_association" "aws-rta-demo-public-02" {
  subnet_id = aws_subnet.aws-sn-demo-public-de-02.id
  route_table_id = aws_route_table.aws-rt-demo-public-02.id

  depends_on = [ aws_route_table.aws-rt-demo-public-02, aws_subnet.aws-sn-demo-public-de-02 ]
}

resource "aws_route_table_association" "aws-rta-demo-private-01" {
  subnet_id = aws_subnet.aws-sn-demo-private-de-01.id
  route_table_id = aws_route_table.aws-rt-demo-private-01.id

  depends_on = [ aws_route_table.aws-rt-demo-private-01, aws_subnet.aws-sn-demo-private-de-01 ]
}

resource "aws_route_table_association" "aws-rta-demo-private-02" {
  subnet_id = aws_subnet.aws-sn-demo-private-de-02.id
  route_table_id = aws_route_table.aws-rt-demo-private-02.id

  depends_on = [ aws_route_table.aws-rt-demo-private-02, aws_subnet.aws-sn-demo-private-de-02 ]
}

resource "aviatrix_account" "aws-demo" {
  account_name = "aws-demo"
  aws_account_number = var.account_number
  aws_iam = false
  aws_access_key = var.access_key
  aws_secret_key = var.secret_access_key
  cloud_type = 1

  depends_on = [ aws_iam_user_policy_attachment.aviatrix_iam_policy_attachment ]
}
resource "aviatrix_spoke_gateway" "aws-avx-spoke-demo-de" {
  gw_name = "aws-avx-spoke-demo-de"
  vpc_id = aws_vpc.aws-vpc-demo-de.id
  cloud_type = 1
  vpc_reg = var.region
  enable_active_mesh = true
  gw_size = "t3.small"
  manage_transit_gateway_attachment = false
  account_name = aviatrix_account.aws-demo.account_name
  subnet = aws_subnet.aws-sn-demo-public-de-01.cidr_block
  enable_encrypt_volume = true
  ha_subnet = aws_subnet.aws-sn-demo-public-de-02.cidr_block
  ha_gw_size = "t3.small"

  depends_on = [
                  aws_route_table_association.aws-rta-demo-public-01,
                  aws_route_table_association.aws-rta-demo-public-02,
                  aviatrix_account.aws-demo
  ]
}

resource "aviatrix_spoke_transit_attachment" "aws_demo_spoke_attachment" {
  spoke_gw_name   = aviatrix_spoke_gateway.aws-avx-spoke-demo-de.gw_name
  transit_gw_name = var.avx_transit_gw

  depends_on = [
    aviatrix_spoke_gateway.aws-avx-spoke-demo-de
  ]
}

resource "aviatrix_transit_firenet_policy" "aws_demo_spoke_firenet_inspection" {
  transit_firenet_gateway_name = "var.avx_transit_gw"
  inspected_resource_name      = "SPOKE:${aviatrix_spoke_gateway.aws-avx-spoke-demo-de.gw_name}"

  depends_on = [ aviatrix_spoke_transit_attachment.aws_demo_spoke_attachment ]
}