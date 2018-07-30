name             "ucarp"
maintainer       "Eric Heydrick"
maintainer_email "eheydrick@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures ucarp"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.3"
issues_url       "https://github.com/osuosl-cookbooks/ucarp/issues"
source_url       "https://github.com/osuosl-cookbooks/ucarp"

depends 'yum-epel','< 3.0'

supports 'centos'
