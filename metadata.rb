name             'php-composer'
maintainer       'Brett Richardson'
maintainer_email 'brett.Richardson.nz@gmail.com'
license          'MIT'
description      'Installs/Configures Composer'
long_description IO.read File.join( File.dirname( __FILE__ ), 'README.md' )
version          '0.0.1'


%w{ debian ubuntu redhat centos fedora scientific amazon }.each do |os|
	supports os
end


depends 'php'


recipe 'install', 'Installs composer.'