class ghebackups::install (
  $ghe_backup_utils_repo,
  $install_location,
) {

  vcsrepo { $install_location:
    ensure   => latest,
    provider => git,
    source   => $ghe_backup_utils_repo,
    revision => 'master',
  }
}
