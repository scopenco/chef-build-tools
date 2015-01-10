# Cookbook Name:: build-tools
# Recipe:: default

include_recipe 'simple_iptables::redhat'

# Add EPEL repository
yum_repository 'epel' do
  mirrorlist 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-5&arch=$basearch'
  description 'Extra Packages for Enterprise Linux 5 - $basearch'
  failovermethod 'priority'
  enabled true
  gpgcheck true
  gpgkey 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-5'
end

# Add CreateRepo repository
remote_file '/etc/yum.repos.d/createrepo.repo' do
  source 'http://createrepo.com/pub/centos/createrepo.repo'
end

# Install yum group Development tools and Libraries
bash 'yum groupinstall Development tools' do
  user 'root'
  group 'root'
  code <<-EOC
    yum groupinstall 'Development tools' -y
  EOC
  not_if "yum grouplist installed | grep 'Development tools'"
end

bash 'yum groupinstall Development Libraries' do
  user 'root'
  group 'root'
  code <<-EOC
    yum groupinstall 'Development Libraries' -y
  EOC
  not_if "yum grouplist installed | grep 'Development Libraries'"
end

package 'build-tools'
