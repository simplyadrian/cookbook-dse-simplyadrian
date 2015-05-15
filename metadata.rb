name             'dse-simplyadrian'
maintainer       'simplyadrian'
maintainer_email 'simplyadrian@gmail.com'
license          'All rights reserved'
description      'Installs/Configures DataStax Enterprise'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.4.0'

depends "java"
depends "yum"
depends "limits"
depends "line"
depends "ohai-simplyadrian"
