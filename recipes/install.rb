#= Calculations ===

globalize_command = if node['composer']['global']
	"mv composer.phar #{node['composer']['prefix']}/bin/composer"
else
	''
end


install_args = if node['composer']['install_dir'].nil?
	''
else
	" -- --install-dir=#{node['composer']['install_dir']}"
end


install_command = "curl -s #{node['composer']['url']} | php" + install_args


not_if_condition = if node['composer']['global']
	'which composer'
elsif node['composer']['install_dir']
	"ls #{node['composer']['install_dir']}/composer.phar"
else
	'ls composer.phar'
end


#= Dependencies ===

include_recipe 'php'

package 'curl' do
	action :upgrade
end


#= Install Composer ===

execute 'composer_install' do
	user    'root'
	cwd     Chef::Config[:file_cache_path]
	command [ install_command, globalize_command ].join '&&'
	not_if  not_if_condition
end