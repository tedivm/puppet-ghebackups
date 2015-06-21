class ghebackups::params {
  $ghe_backup_utils_repo = 'https://github.com/github/backup-utils.git'
  $install_location = '/opt/ghe-backup-utils'
  $log_location = $install_location
  $log_backup = 'backup.log'
  $log_restore = 'restore.log'
  $restore = false
  $cron_hour = '*/6'
  $ghe_hostname = 'github'
  $ghe_data_dir = 'data'
  $ghe_num_snapshots=10
  $ghe_restore_host=''
  $ghe_extra_ssh_opts='-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
  $user = 'root'
  $packages = [
    'git',
    'rsync'
  ]
}
