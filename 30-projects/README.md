# 30-projects
This code is in charge of managing projects in the environments. The [projects](modules/projects) module is in charge of
creating service projects or floating projects.

The environments are defined in [envs](envs) folder. By default every environment will have:
1. One basic service project attached to the basic shared VPC
2. One restricted service project attached to the restricted shared VPC and added to the appropriate access level in VPC Service Controls
3. One floating project not attached to any shared VPC