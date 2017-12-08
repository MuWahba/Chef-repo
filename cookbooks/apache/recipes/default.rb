#the basic configuration 
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

if node['platform_family'] == "rhel" 
	package = "httpd"
elsif node['platform_family'] == "debian"
	package = "apache2"
end


package 'apache' do 
	package_name package
	action :install
end

template '/var/www/html' do
	source 'index.html.erb'
	action :create
end

user 'user1' do
	comment 'user1'
	uid '111'
	shell 'bin/bash'
end


bash 'run list' do
	user 'user1'
	code './script.sh'
end
execute 'run a script' do 
	user 'root'
	command <<-EOH
 setenforce 0
EOH
only_ if '$getenforce==1'
end

 
service 'apache' do
	service_name 'httpd'
	action [ :enable, :start ]
end














