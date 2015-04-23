name             'dse-nativex'
maintainer       'NativeX'
maintainer_email 'derek.bromenshenkel@nativex.com'
license          'All rights reserved'
description      'Installs/Configures DataStax Enterprise'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.4.0'

depends "java"
depends "yum"
depends "limits"
depends "line"
depends "ohai-nativex"
