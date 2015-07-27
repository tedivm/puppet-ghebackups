# ghebackups

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What ghebackups affects](#what-ghebackups-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with ghebackups](#beginning-with-ghebackups)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)

## Overview

This module installs and configures the Github Enterprise Backup Utilities.

## Module Description

The fine folks at Github have a set of tools for [backing up Github Enterprise
installations](https://github.com/github/backup-utils). This tool is available
in a git repository.

This module installs this tools and keeps it up to date. It creates the needed
configuration files as well as the cronjobs that run the backups. It also
provides sane default configurations to make backups more reliable.

## Setup

### What ghebackups affects

* A git repository will be installed and kept up to date.
* Cronjobs to run the backups will be added to the system.

### Setup Requirements

* This module requires that rsync be installed to properly run.
* The backup user's SSH key needs to be installed on the GHE instance to run.


### Beginning with ghebackups

This module is rather simple to use- simply include the 'ghebackups' file and
the default settings should work (assuming your local GHE instance is named
'github' and dns is working).

```puppet
class { 'ghebackups': }
```

A more complete example including custom hostname would look like this.

```puppet
class { 'ghebackups':
  ghe_hostname      => 'github.example.net',
  ghe_data_dir      => '/backups/github',
  ghe_num_snapshots => 72,
}
```

## Reference

####`install_location`
    Defines the location to install the ghe-backup-utils repository.
    Defaults to '/opt/ghe-backup-utils'

####`log_location`
    Defines the directory to place log files in.
    Defaults to '/opt/ghe-backup-utils'.

####`log_backup`
    Defines the name of the backup log file.
    Defaults to 'backup.log'

####`log_restore`
    Defines the name of the restore log file.
    Defaults to 'restore.log'

####`restore`
    If true backups will be synced to a standby host (ghe_restore_host).
    Defaults to false.

####`user`
    The user that the script will run as. Must have write access to ghe_data_dir.
    Defaults to root.

####`cron_hour`
    Defines the time to run backups. This takes the cron format.
    Defaults to '\*', which means it runs hourly.

####`ghe_hostname`
    Defines the host to backup.
    Defaults to 'github'.

####`ghe_data_dir`
    Defines the location to store backups.
    Defaults to the "data" directory in the install_location.

####`ghe_num_snapshots`
    Defines the number of snapshots to keep.
    Defaults to 48.

####`ghe_restore_host`
    Defines the host to restore to.
    Defaults to null.

####`ghe_extra_ssh_opts`
    Defines any custom ssh settings, such as disabling host key checks.
    Defaults to '-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

####`ghe_backup_utils_repo`
    Defines the location of the backup-utils repository.
    Defaults to https://github.com/github/backup-utils.git.


## Development

Contributions are always welcome! Please visit this module's home on
[Github](https://github.com/tedivm/puppet-ghebackups).
