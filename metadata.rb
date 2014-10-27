name             'dse-nativex'
maintainer       'NativeX'
maintainer_email 'derek.bromenshenkel@nativex.com'
license          'All rights reserved'
description      'Installs/Configures DataStax Enterprise'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "java", "~> 1.14"
depends "yum", "~> 3.0"
depends "limits"
depends "ohai-nativex"
