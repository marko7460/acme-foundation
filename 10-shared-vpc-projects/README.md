# 10-shared-vpc-projects
This code will create shared VPC projects per environment. The module in charge of creating shared vpc project is in
[modules/shared_vpc_project](modules/shared_vpc_project/README.md).

Environments are defined in [envs](envs) folder. By default every environment will have two shared VPC projects, one for
basic project and one restricted project. The restricted project will have VPC Service Controls enabled.