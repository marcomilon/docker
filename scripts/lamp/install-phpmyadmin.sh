#!/bin/sh

BASEDIR=$(dirname "$0")

$BASEDIR/../../bin/composer create-project phpmyadmin/phpmyadmin $IDT_APACE_DOCUMENT_ROOT/phpmyadmin --repository-url=https://www.phpmyadmin.net/packages.json --no-dev
