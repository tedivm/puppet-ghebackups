class ghebackups::config (
  $install_location,
  $ghe_hostname,
  $ghe_data_dir,
  $ghe_num_snapshots,
  $ghe_restore_host,
  $ghe_extra_ssh_opts,
) {

  file { "${install_location}/backup.config":
    content => template('ghebackups/backup.config.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Vcsrepo[$install_location],
  }

}
