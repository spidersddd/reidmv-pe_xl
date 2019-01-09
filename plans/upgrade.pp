# This plan exists as an entry point to upgrading plans.
# It is meant to execute one of two plans either ha_upgrade or
# nonha_upgrade.
plan pe_xl::upgrade (
  String[1]           $master_host,
  String[1]           $puppetdb_database_host,
  Optional[String[1]] $master_replica_host = undef,
  Optional[String[1]] $puppetdb_database_replica_host = undef,

  String[1] $version = '2018.1.5',

  String[1] $stagingdir = '/tmp',
  String[1] $pe_source  = "https://s3.amazonaws.com/pe-builds/released/${version}/puppet-enterprise-${version}-el-7-x86_64.tar.gz",
) {

  # If master_replica_host is not set assume a nonha_upgrade
  if $master_replica_host {
    run_plan('pe_xl::ha_upgrade',
      master_host                    => $master_host,
      puppetdb_database_host         => $puppetdb_database_host,
      master_replica_host            => $master_replica_host,
      puppetdb_database_replica_host => $puppetdb_database_replica_host,
      version                        => $version,
      stagingdir                     => $stagingdir,
    )
  } else {
    run_plan('pe_xl::nonha_upgrade',
      master_host            => $master_host,
      puppetdb_database_host => $puppetdb_database_host,
      version                => $version,
      stagingdir             => $stagingdir,
    )
  }

}
