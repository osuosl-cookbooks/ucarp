name             "ucarp"
maintainer       "Eric Heydrick"
maintainer_email "eheydrick@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures ucarp"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.3"

depends 'yum-epel','= 1.0.2'
depends 'apt'

supports 'debian'
supports 'ubuntu'
supports 'centos'
