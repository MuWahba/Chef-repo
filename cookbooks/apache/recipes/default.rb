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


service 'apache' do
	service_name 'httpd'
	action [ :enable, :start ]
end














