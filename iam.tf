resource "aws_iam_user" "aviatrix_iam_user" {
  name = "aviatrix-user"
  path = "/"
}

resource "aws_iam_access_key" "aviatrix_iam_user_access_key" {
  user = aws_iam_user.aviatrix_iam_user.name
  
  depends_on = [
    aws_iam_user.aviatrix_iam_user
  ]
}

resource "aws_iam_policy" "aviatrix_iam_policy" {
  name = "aviatrix-role-app"
  path        = "/"
  description = "Policy for the Aviatrix Controller Access"

  policy = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Effect": "Allow",
              "Action": [
                  "ec2:Describe*",
                  "ec2:Get*",
                  "ec2:Search*",
                  "elasticloadbalancing:Describe*",
                  "route53:List*",
                  "route53:Get*",
                  "sqs:Get*",
                  "sqs:List*",
                  "sns:List*",
                  "s3:List*",
                  "s3:Get*",
                  "iam:List*",
                  "iam:Get*",
                  "directconnect:Describe*",
                  "guardduty:Get*",
                  "guardduty:List*",
                  "ram:Get*",
                  "ram:List*",
                  "networkmanager:Get*",
                  "networkmanager:List*"
              ],
              "Resource": "*"
          },
          {
              "Effect": "Allow",
              "Action": [
                  "ec2:CreateVpc",
                  "ec2:DeleteVpc",
                  "ec2:ModifyVpcAttribute",
                  "ec2:CreateNetworkAclEntry",
                  "ec2:ReplaceNetworkAclEntry",
                  "ec2:DeleteNetworkAclEntry",
                  "ec2:AssociateVpcCidrBlock",
                  "ec2:AssociateSubnetCidrBlock",
                  "ec2:CreateSubnet",
                  "ec2:DeleteSubnet",
                  "ec2:ModifySubnetAttribute",
                  "ec2:*InternetGateway*",
                  "ec2:*Route*",
                  "ec2:*Instance*",
                  "ec2:*SecurityGroup*",
                  "ec2:*Address*",
                  "ec2:*NetworkInterface*",
                  "ec2:CreateKeyPair",
                  "ec2:DeleteKeyPair",
                  "ec2:CreateTags",
                  "ec2:DeleteTags",
                  "ec2:DeleteFlowLogs",
                  "ec2:CreateFlowLogs",
                  "ec2:DescribeFlowLogs",
                  "ec2:AssociateIamInstanceProfile",
                  "ec2:DisassociateIamInstanceProfile",
                  "ec2:DescribeIamInstanceProfileAssociations"
              ],
              "Resource": "*"
          },
          {
              "Effect": "Allow",
              "Action": [
                  "ec2:CreateCustomerGateway",
                  "ec2:DeleteCustomerGateway",
                  "ec2:CreateVpnConnection",
                  "ec2:DeleteVpnConnection",
                  "ec2:CreateVpcPeeringConnection",
                  "ec2:AcceptVpcPeeringConnection",
                  "ec2:DeleteVpcPeeringConnection",
                  "ec2:EnableVgwRoutePropagation",
                  "ec2:DisableVgwRoutePropagation"
              ],
              "Resource": "*"
          },
          {
              "Effect": "Allow",
              "Action": [
                  "ec2:AssociateTransitGatewayRouteTable",
                  "ec2:AcceptTransitGatewayVpcAttachment",
                  "ec2:CreateTransitGateway",
                  "ec2:CreateTransitGatewayRoute",
                  "ec2:CreateTransitGatewayRouteTable",
                  "ec2:CreateTransitGatewayVpcAttachment",
                  "ec2:DeleteTransitGateway",
                  "ec2:DeleteTransitGatewayRoute",
                  "ec2:DeleteTransitGatewayRouteTable",
                  "ec2:DeleteTransitGatewayVpcAttachment",
                  "ec2:DisableTransitGatewayRouteTablePropagation",
                  "ec2:DisassociateTransitGatewayRouteTable",
                  "ec2:EnableTransitGatewayRouteTablePropagation",
                  "ec2:ExportTransitGatewayRoutes",
                  "ec2:ModifyTransitGatewayVpcAttachment",
                  "ec2:RejectTransitGatewayVpcAttachment",
                  "ec2:ReplaceTransitGatewayRoute",
                  "ec2:ModifyTransitGateway",
                  "ec2:CreateTransitGatewayConnect",
                  "ec2:DeleteTransitGatewayConnect",
                  "ec2:CreateTransitGatewayConnectPeer",
                  "ec2:DeleteTransitGatewayConnectPeer",
                  "ec2:CreateVpcEndpoint",
                  "ec2:DeleteVpcEndpoints",
                  "ec2:CreateVpcEndpointServiceConfiguration",
                  "ec2:DeleteVpcEndpointServiceConfigurations",
                  "ec2:CreateNatGateway",
                  "ec2:DeleteNatGateway"
              ],
              "Resource": "*"
          },
          {
              "Effect": "Allow",
              "Action": [
                  "ram:CreateResourceShare",
                  "ram:DeleteResourceShare",
                  "ram:UpdateResourceShare",
                  "ram:AssociateResourceShare",
                  "ram:DisassociateResourceShare",
                  "ram:TagResource",
                  "ram:UntagResource",
                  "ram:AcceptResourceShareInvitation",
                  "ram:EnableSharingWithAwsOrganization"
              ],
              "Resource": "*"
          },
          {
              "Effect": "Allow",
              "Action": [
                  "directconnect:CreateDirectConnectGateway",
                  "directconnect:CreateDirectConnectGatewayAssociation",
                  "directconnect:CreateDirectConnectGatewayAssociationProposal",
                  "directconnect:DeleteDirectConnectGateway",
                  "directconnect:DeleteDirectConnectGatewayAssociation",
                  "directconnect:DeleteDirectConnectGatewayAssociationProposal",
                  "directconnect:AcceptDirectConnectGatewayAssociationProposal"
              ],
              "Resource": "*"
          },
          {
              "Effect": "Allow",
              "Action": [
                  "sqs:AddPermission",
                  "sqs:ChangeMessageVisibility",
                  "sqs:CreateQueue",
                  "sqs:DeleteMessage",
                  "sqs:DeleteQueue",
                  "sqs:PurgeQueue",
                  "sqs:ReceiveMessage",
                  "sqs:RemovePermission",
                  "sqs:SendMessage",
                  "sqs:SetQueueAttributes",
                  "sqs:TagQueue"
              ],
              "Resource": "*"
          },
          {
              "Effect": "Allow",
              "Action": [
                  "s3:CreateBucket",
                  "s3:DeleteBucket",
                  "s3:ListBucket",
                  "s3:PutObject",
                  "s3:DeleteObject",
                  "s3:PutBucketPolicy",
                  "s3:DeleteBucketPolicy"
              ],
              "Resource": "*"
          },
          {
              "Effect": "Allow",
              "Action": [
                  "logs:CreateLogDelivery",
                  "logs:DeleteLogDelivery"
              ],
              "Resource": "*"
          },
          {
              "Effect": "Allow",
              "Action": [
                  "servicequotas:GetAWSDefaultServiceQuota",
                  "servicequotas:GetServiceQuota",
                  "servicequotas:ListAWSDefaultServiceQuotas",
                  "servicequotas:ListServiceQuotas",
                  "servicequotas:ListServices"
              ],
              "Resource": "*"
          },
          {
              "Effect": "Allow",
              "Action": [
                  "iam:PassRole",
                  "iam:AddRoleToInstanceProfile",
                  "iam:CreateInstanceProfile",
                  "iam:DeleteInstanceProfile",
                  "iam:RemoveRoleFromInstanceProfile",
                  "iam:CreateServiceLinkedRole",
                  "iam:TagInstanceProfile"
              ],
              "Resource": "*"
          },
          {
              "Effect": "Allow",
              "Action": [
                  "iam:DeletePolicyVersion",
                  "iam:CreatePolicyVersion"
              ],
              "Resource": "*"
          },
          {
              "Effect": "Allow",
              "Action": [
                  "elasticloadbalancing:*",
                  "route53:ChangeResourceRecordSets",
                  "ec2:*Volume*",
                  "ec2:*Snapshot*",
                  "ec2:*TransitGatewayPeeringAttachment",
                  "guardduty:*",
                  "globalaccelerator:*",
                  "networkmanager:*"
              ],
              "Resource": "*"
          }
      ]
  }
    
  )
  depends_on = [
    aws_iam_user.aviatrix_iam_user
  ]
}

resource "aws_iam_user_policy_attachment" "aviatrix_iam_policy_attachment" {
  user = aws_iam_user.aviatrix_iam_user.name
  policy_arn = aws_iam_policy.aviatrix_iam_policy.arn

  depends_on = [
    aws_iam_policy.aviatrix_iam_policy,
    aws_iam_user.aviatrix_iam_user
  ]
}