# == Class: ghebackups
#
# Full description of class ghebackups here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'ghebackups':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class ghebackups (
  $install_location = $ghebackups::params::install_location,
  $log_location = $ghebackups::params::log_location,
  $log_backup = $ghebackups::params::log_backup,
  $log_restore = $ghebackups::params::log_restore,
  $restore = $ghebackups::params::restore,
  $cron_hour = $ghebackups::params::cron_hour,
  $ghe_hostname = $ghebackups::params::ghe_hostname,
  $ghe_data_dir = $ghebackups::params::ghe_data_dir,
  $ghe_num_snapshots = $ghebackups::params::ghe_num_snapshots,
  $ghe_restore_host = $ghebackups::params::ghe_restore_host,
  $ghe_extra_ssh_opts = $ghebackups::params::ghe_extra_ssh_opts,
  $ghe_backup_utils_repo = $ghebackups::params::ghe_backup_utils_repo,
) inherits ghebackups::params {

  class {'ghebackups::install':
    install_location      => $ghebackups::install_location,
    ghe_backup_utils_repo => $ghebackups::ghe_backup_utils_repo,
  } ->

  class {'ghebackups::config':
    install_location   => $ghebackups::install_location,
    ghe_hostname       => $ghebackups::ghe_hostname,
    ghe_data_dir       => $ghebackups::ghe_data_dir,
    ghe_num_snapshots  => $ghebackups::ghe_num_snapshots,
    ghe_restore_host   => $ghebackups::ghe_restore_host,
    ghe_extra_ssh_opts => $ghebackups::ghe_extra_ssh_opts,
  } ->

  class {'ghebackups::cron':
    install_location => $ghebackups::install_location,
    log_location     => $ghebackups::log_location,
    log_backup       => $ghebackups::log_backup,
    log_restore      => $ghebackups::log_restore,
    cron_hour        => $ghebackups::cron_hour,
    restore          => $ghebackups::restore,
  }
}
