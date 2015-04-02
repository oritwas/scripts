rm -rf teu_log
./virtualenv/bin/teuthology -v \
  --suite-path $HOME/ceph-qa-suite \
  --owner owasserm@owasserm.redhat.com targets.yaml \
  $HOME/ceph-qa-suite/suites/rgw/singleton/overrides.yaml \
  $HOME/ceph-qa-suite/suites/rgw/singleton/all/radosgw-admin.yaml \
  $HOME/ceph-qa-suite/suites/rgw/singleton/frontend/civetweb.yaml \
  $HOME/ceph-qa-suite/suites/rgw/singleton/rgw_pool_type/ec-profile.yaml

#  $HOME/ceph-qa-suite/suites/rgw/verify/overrides.yaml \
#  $HOME/ceph-qa-suite/suites/rgw/verify/clusters/fixed-2.yaml \
#  $HOME/ceph-qa-suite/suites/rgw/verify/frontend/civetweb.yaml \
#  $HOME/ceph-qa-suite/suites/rgw/verify/rgw_pool_type/ec-profile.yaml \
#  $HOME/ceph-qa-suite/suites/rgw/verify/tasks/rgw_s3tests_multiregion.yaml

#  $HOME/ceph-qa-suite/suites/rgw/singleton/overrides.yaml \
#  $HOME/ceph-qa-suite/suites/rgw/singleton/all/radosgw-admin.yaml \
#  $HOME/ceph-qa-suite/suites/rgw/singleton/frontend/apache.yaml \
#  $HOME/ceph-qa-suite/suites/rgw/singleton/rgw_pool_type/ec.yaml

#  $HOME/ceph-qa-suite/suites/rgw/singleton/all/radosgw-admin-data-sync.yaml \
#  $HOME/ceph-qa-suite/suites/rgw/singleton/frontend/apache.yaml \
#  $HOME/ceph-qa-suite/suites/rgw/singleton/rgw_pool_type/ec-cache.yaml

#  $HOME/ceph-qa-suite/suites/rgw/singleton/all/radosgw-admin-multi-region.yaml \
#  $HOME/ceph-qa-suite/suites/rgw/singleton/frontend/civetweb.yaml \
#  $HOME/ceph-qa-suite/suites/rgw/singleton/rgw_pool_type/replicated.yaml
