class ghebackups::install (
  $ghe_backup_utils_repo,
  $install_location,
  $user,
) {

  vcsrepo { $install_location:
    ensure   => latest,
    user     => $user,
    provider => git,
    source   => $ghe_backup_utils_repo,
    revision => 'master',
  }
}
