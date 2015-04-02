LOG=wip-2712-fail
rm -rf /tmp/$LOG

PYTHONPATH=/home/owasserm/ceph-qa-suite \
	   ./virtualenv/bin/teuthology -v --archive /tmp/$LOG --owner owasserm@owasserm.redhat.com mine.yaml $LOG.yaml
