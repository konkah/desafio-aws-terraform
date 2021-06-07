resource "aws_key_pair" "bastion_key" {
  key_name   = "bastion_key_pub"
  public_key = file("../Keys/bastion_key.pub")
}