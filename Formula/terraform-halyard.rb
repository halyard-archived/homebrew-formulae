class TerraformHalyard < Formula
  desc "Tool to build, change, and version infrastructure"
  homepage "https://www.terraform.io/"
  version "0.11.0"
  url "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_darwin_amd64.zip"
  sha256 "0d5f7ffcfd34fe58ed25fe48650f1c9ac1d9e15983af43deaeffc6d0a88ba346"

  def install
    bin.install "terraform"
  end

  test do
    minimal = testpath/"minimal.tf"
    minimal.write <<-EOS.undent
      variable "aws_region" {
          default = "us-west-2"
      }

      variable "aws_amis" {
          default = {
              eu-west-1 = "ami-b1cf19c6"
              us-east-1 = "ami-de7ab6b6"
              us-west-1 = "ami-3f75767a"
              us-west-2 = "ami-21f78e11"
          }
      }

      # Specify the provider and access details
      provider "aws" {
          access_key = "this_is_a_fake_access"
          secret_key = "this_is_a_fake_secret"
          region = "${var.aws_region}"
      }

      resource "aws_instance" "web" {
        instance_type = "m1.small"
        ami = "${lookup(var.aws_amis, var.aws_region)}"
        count = 4
      }
    EOS
    system "#{bin}/terraform", "graph", testpath
  end
end
