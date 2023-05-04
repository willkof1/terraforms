# Terraforms (em contrução) #
## Este repo contem terraforms default para subir alguns recursos no AWS WebServices ##

 - Tenha as credencias da conta configuradas no seu ambiente, com as devidas permissões, somente desta forma será possível criar recursos na sua conta;
 - `provider.tf` tem as infos da sua cloud;
 - Utilize um arquivo `.tfvars` para passar as variaveis referenciadas no arquivo `variables.tf`
 - A pasta terrraform-vpc provisiona uma VPC e no arquivo `vpc.tf` é possível visualizar os recursos que vão ser criado;
 - É importante ter `backends.tf` ele é utilizado para guardar o estado da sua infra em um ambiente seguro e que poderá ser alterado por outras pessoas que tenham permissão. É uma boa pratica principalmente quando utilizamos numa esteira de pipeline. Existem outras formas leia mais [backends](https://developer.hashicorp.com/terraform/language/settings/backends/configuration). Se estiver começando. Não precisa;