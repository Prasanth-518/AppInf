# installing g++ and mysql connector

bash 'apt-update' do
  code <<-EOH
  sudo apt update
  EOH
end

package 'g++'
package 'libmysqlcppconn-dev'

# installing apache server
package 'apache2' do
  action :install
end

# enabling cgi in apache server
bash 'enable cgi' do
  user 'vagrant'
  code <<-EOH
    sudo a2enmod cgi
EOH
end

# configuring .conf file
template '/etc/apache2/sites-available/000-default.conf' do
  source '000-default.conf.erb'
end

# creating cgi-bin dir and giving file permissions
bash 'create cgi-bin' do
  user 'vagrant'
  code <<-EOH
  sudo mkdir /var/www/cgi-bin
  sudo chmod -R 755 /var/www/cgi-bin
  sudo chown root.root /var/www/cgi-bin
 EOH
end

# restarting apache
service 'apache2' do
  action :restart
end

template '/var/www/cgi-bin/dbconnect.cpp' do
  source 'dbconnect.cpp.erb'
end
