#./virtualenv/bin/teuthology-lock --lock-many 3 --desc 'test multisite' --machine-type plana

#./virtualenv/bin/teuthology-lock --list-target

#$MACHINE_TYPES=" plana,burnupi,mira"
./virtualenv/bin/teuthology-suite --suite upgrade:hammer-x --suite-branch master --email owasserm@redhat.com --ceph wip-rgw-new-multisite --machine-type vps --dry-run 
