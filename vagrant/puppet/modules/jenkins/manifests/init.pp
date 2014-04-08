class jenkins($rpm_repo,$rpm_key) {

  file { "${rpm_repo}":
    path => "/etc/yum.repos.d/${rpm_repo}",
    ensure => file,
    mode => 440,
    owner => root,
    group => root,
    source => "puppet:///modules/jenkins/${rpm_repo}",
  }

  file { "${rpm_key}":
    path => "/tmp/${rpm_key}",
    ensure => file,
    mode => 440,
    owner => root,
    group => root,
    source => "puppet:///modules/jenkins/${rpm_key}"
  }

  exec { "jenkins-rpm-key-install":
    command => "rpm --import /tmp/${rpm_key}",
    require => File["${rpm_key}"],
  }

  package { "jenkins" :
    ensure => installed,
    require => Exec["jenkins-rpm-key-install"],
  }

}