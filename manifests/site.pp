node default {
  include golang
  include google_chrome

  class { 'packer': install_dir => '/usr/local/bin', version => '0.7.5' }
  class { 'people': user   => jbruce }
  class { 'rbenv':  latest => true }
  class { 'vagrant': }
  class { 'nodejs':
    version      => 'v0.12.2',
    make_install => false,
  }
  class { 'docker':
    tcp_bind    => 'tcp://0.0.0.0:4243',
    socket_bind => 'unix:///var/run/docker.sock',
  }

  rbenv::plugin { 'sstephenson/ruby-build': }
  rbenv::build { '2.1.2': global => true }

  package { 'steroids':
    ensure   => present,
    provider => 'npm',
    require  => Class['nodejs'],
  }
  package {
    [
      'ack-grep',
      'findutils',
      'tar',
      'tmux',
      'openssh-server',
      'tig'
    ]:
  }
}
