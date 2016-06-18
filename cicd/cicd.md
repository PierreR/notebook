% CI/CD Guidelines
% Pierre Radermecker
% 2013


# General Objectives

The overall objective of the CI/CD is to reduce the risk associated to releasing software. It works on multiples angles such as automatic testing, machine provisioning or standard libraries/practices identification and thus aims at providing multiple benefits (rapid development cycle, devops, ...)

# Dev/Ops & Data

Meeting points between development and operation need to be discovered and defined precisely. Data are information needed by the system and the application to run correctly. It is crucial to be able to quicky search and indentify ownership and responsability for data.

  - Project information (project name)
  - Machine information (disk space, os name, ...)
  - "Middleware" information (database connection string, ...)
  - ...

# Attention points

  * Be careful with the word "BUILD" ! as configuring machine can be associated with a build process ...
  * Meeting points between development and operation need to be discovered and defined precisely. Data are information needed by the system and the application to run correctly. It is crucial to be able to quickly search and identify ownership and responsibility for data.


## Questions

* Hiera production/staging is then seperated -> Jules || Jules 3 is used to edit these hiera configuration
* Why does Jenkins have SSH PPK pair  ? -> because it needs to tag the source




