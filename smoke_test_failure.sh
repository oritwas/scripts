#!/bin/bash -x

bin=${1:-"./bin"}

$bin/radosgw-admin  user create --uid bar.client.0 --display-name 'Mr. bar.client.0' --access-key PGPIGVJGBBRZGVMTHHQW --secret XyzW7XfnZAfZYfxfBJ1Lfxo7SLErNpn26JLsM9YaBmGU1zb3Y2cYMw== --email bar.client.0+test@test.test

$bin/radosgw-admin user create --uid foo.client.0 --display-name 'Mr. foo.client.0' --access-key PYIKMDUQTMLELCSWUBOU --secret GBrWb47mhGXLAnkITl3jRnoouHCsPf78VElnZUZuNZNpqVRrmNZ0gw==  --email foo.client.0+test@test.test

~/scripts/run_s3_tests.sh foo.conf

$bin/radosgw-admin user rm --uid bar.client.0 --purge-data
$bin/radosgw-admin user rm --uid foo.client.0 --purge-data
