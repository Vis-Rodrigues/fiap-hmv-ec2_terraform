# EC2 Terraform
[![Generic badge](https://img.shields.io/badge/Infra-Terraform-purple.svg)](https://www.terraform.io/)
[![Generic badge](https://img.shields.io/badge/Provider-AWS-orange.svg)](https://aws.amazon.com/pt/)

Provisionar na AWS um EC2 para o projeto HMV da Fiap.

## Como executar

Para executar o terraform rode os comandos abaixo:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

:exclamation: Quando não quiser mais o recurso execute o comando abaixo:
```bash
$ terraform destroy
```