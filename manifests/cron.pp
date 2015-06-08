class ghebackups::cron (
  $install_location,
  $cron_hour,
  $log_location,
  $log_backup,
  $log_restore,
  $restore,
) {

  $backup_exec = "${install_location}/bin/ghe-backup -v 1>>${log_location}/${log_backup}"
  $restore_exec = "${install_location}/bin/ghe-restore -c -v 1>>${log_location}/${log_restore}"

  cron { 'ghe_backups':
    command => $backup_exec,
    user    => root,
    hour    => $cron_hour,
    minute  => 0
  }

  if $restore {
    cron { 'ghe_restore':
      command => $restore_exec,
      user    => root,
      hour    => $cron_hour,
      minute  => 30
    }
  }
}
