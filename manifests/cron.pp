class ghebackups::cron (
  $install_location,
  $user,
  $cron_hour,
  $log_location,
  $log_backup,
  $log_restore,
  $restore,
) {


  $backup_exec = "${install_location}/bin/ghe-backup -v 1>>${log_location}/${log_backup} 2>&1"
  $restore_exec = "${install_location}/bin/ghe-restore -c -v 1>>${log_location}/${log_restore} 2>&1"

  cron { 'ghe_backups':
    command => $backup_exec,
    user    => $user,
    hour    => $cron_hour,
    minute  => fqdn_rand(59, "github_backups_${::fqdn}")
  }

  if $restore {
    cron { 'ghe_restore':
      command => $restore_exec,
      user    => $user,
      hour    => $cron_hour,
      minute  => fqdn_rand(59, "github_restore_${::fqdn}")
    }
  }
}
