class ghebackups::user (
  $user = $ghebackups::params::user
) inherits ghebackups::params {

  if($user != 'root') {
    user { $user:
      ensure     => present,
      comment    => 'Github Backups',
      home       => "/home/${user}",
      managehome => true,
    }
  }
}
