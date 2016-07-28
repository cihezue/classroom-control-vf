class nginx {
File {
 owner => 'root',
 group => 'root',
 mode  => '0644',
}

package { 'nginx':
ensure => present,
}
file { '/var/www':
ensure => directory,

}
file { '/var/www/index.html':
ensure => file,
source => 'puppet:///modules/nginx/index.html',
}
file { '/etc/nginx/nginx.conf':
ensure => file,
source => 'puppet:///modules/nginx/nginx.conf',
require => Package['nginx'],
notify => Service['nginx'],
}
file { '/etc/nginx/conf.d':
ensure => directory,

}
file { '/etc/nginx/conf.d/default.conf':
ensure => file,
source => 'puppet:///modules/nginx/default.conf',
require => Package['nginx'],
notify => Service['nginx'],
}
service { 'nginx':
ensure => running,
enable => true,
 }
 node default {
# This is where you can declare classes for all nodes.
# Example:
# class { 'my_class': }
if $::virtual != 'physical' {
$vmname = capitalize($::virtual)
notify { "This is a ${vmname} virtual machine.": }
 }
}

