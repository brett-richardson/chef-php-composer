#= Functions ===

def globalize_command
	if node['composer']['global']
		"mv composer.phar #{node['composer']['prefix']}/bin/composer"
	else
		''
	end
end


def install_command
	"curl -s #{node['composer']['url']} | php" + install_args
end


def install_args
	return '' if node['composer']['install_dir'].nil?
	" -- --install-dir=#{node['composer']['install_dir']}"
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
	not_if  'which composer'
end