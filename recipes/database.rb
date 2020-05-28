package 'mysql-server'

template '/home/vagrant/dbconfig.sql' do
  source 'dbconfig.sql.erb'
end

template '/home/vagrant/createdata.sql' do
  source 'createdata.sql.erb'
end

bash 'create_table' do
  user 'vagrant'
  # cwd::File.dirname(/home/vagrant)
  code <<-EOH
        cd "/home/vagrant"
        sudo mysql < createdata.sql
    EOH
end

bash 'grant permissions' do
  user 'vagrant'
  code <<-EOH
        cd "/home/vagrant"
        sudo mysql < dbconfig.sql
        sudo mysql --bind-address=0.0.0.0 "test_db"
    EOH
end
