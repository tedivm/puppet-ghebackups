# == Class: ghebackups
#
# This module installs and configures the Github Enteprise Backup Utilities.
#
# === Parameters
#
# [*install_location*]
#   Defines the location to install the ghe-backup-utils repository.
#   Defaults to '/opt/ghe-backup-utils'
#
# [*log_location*]
#   Defines the directory to place log files in.
#   Defaults to '/opt/ghe-backup-utils'.
#
# [*log_backup*]
#   Defines the name of the backup log file.
#   Defaults to 'backup.log'
#
# [*log_restore*]
#   Defines the name of the restore log file.
#   Defaults to 'restore.log'
#
# [*restore*]
#   If true backups will be synced to a standby host (ghe_restore_host).
#   Defaults to false.
#
# [*cron_hour*]
#   Defines the time to run backups. This takes the cron format.
#   Defaults to '*/6'.
#
# [*ghe_hostname*]
#   Defines the host to backup.
#   Defaults to 'github'.
#
# [*ghe_data_dir*]
#   Defines the location to store backups.
#   Defaults to the "data" directory in the install_location.
#
# [*ghe_num_snapshots*]
#   Defines the number of snapshots to keep.
#   Defaults to 10.
#
# [*ghe_restore_host*]
#   Defines the host to restore to.
#   Defaults to null.
#
# [*ghe_extra_ssh_opts*]
#   Defines any custom ssh settings, such as disabling host key checks.
#   Defaults to '-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
#
# [*ghe_backup_utils_repo*]
#   Defines the location of the backup-utils repository.
#   Defaults to https://github.com/github/backup-utils.git.
#
# === Examples
#
#  class { 'ghebackups':
#    ghe_hostname      => 'github.example.net',
#    ghe_data_dir      => '/backups/github',
#    ghe_num_snapshots => 48,,
#    cron_hour         => '*'
#  }
#
# === Authors
#
# Robert Hafner <tedivm@tedivm.com>
#
# === Copyright
#
# Copyright 2015 Robert Hafner
#
class ghebackups (
  $install_location = $ghebackups::params::install_location,
  $log_location = $ghebackups::params::log_location,
  $log_backup = $ghebackups::params::log_backup,
  $log_restore = $ghebackups::params::log_restore,
  $restore = $ghebackups::params::restore,
  $user = $ghebackups::params::user,
  $cron_hour = $ghebackups::params::cron_hour,
  $ghe_hostname = $ghebackups::params::ghe_hostname,
  $ghe_data_dir = $ghebackups::params::ghe_data_dir,
  $ghe_num_snapshots = $ghebackups::params::ghe_num_snapshots,
  $ghe_restore_host = $ghebackups::params::ghe_restore_host,
  $ghe_extra_ssh_opts = $ghebackups::params::ghe_extra_ssh_opts,
  $ghe_backup_utils_repo = $ghebackups::params::ghe_backup_utils_repo,
) inherits ghebackups::params {

  class {'ghebackups::user':
    user => $ghebackups::user
  } ->

  class {'ghebackups::install':
    install_location      => $ghebackups::install_location,
    ghe_backup_utils_repo => $ghebackups::ghe_backup_utils_repo,
    user                  => $ghebackups::user
  } ->

  class {'ghebackups::config':
    install_location   => $ghebackups::install_location,
    user               => $ghebackups::user
    ghe_hostname       => $ghebackups::ghe_hostname,
    ghe_data_dir       => $ghebackups::ghe_data_dir,
    ghe_num_snapshots  => $ghebackups::ghe_num_snapshots,
    ghe_restore_host   => $ghebackups::ghe_restore_host,
    ghe_extra_ssh_opts => $ghebackups::ghe_extra_ssh_opts,
  } ->

  class {'ghebackups::cron':
    install_location => $ghebackups::install_location,
    user             => $ghebackups::user
    log_location     => $ghebackups::log_location,
    log_backup       => $ghebackups::log_backup,
    log_restore      => $ghebackups::log_restore,
    cron_hour        => $ghebackups::cron_hour,
    restore          => $ghebackups::restore,
  }
}
