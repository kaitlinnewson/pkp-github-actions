#!/bin/bash

# @file actions/upgrade-pkp-application.sh
#
# Copyright (c) 2014-2025 Simon Fraser University
# Copyright (c) 2010-2025 John Willinsky
# Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
#
# Script to run a PKP application upgrade for testing purposes

set -e

export DBHOST=localhost # Database hostname
export DBNAME=${APPLICATION}-ci # Database name
export DBUSERNAME=${APPLICATION}-ci # Database username
export DBPASSWORD=${APPLICATION}-ci # Database password


source  $GITHUB_WORKSPACE/pkp-github-actions/.github/actions/ingest_datasets.sh
source  $GITHUB_WORKSPACE/pkp-github-actions/.github/actions/prepare-logs.sh


# The version check fetches the latest version from pkp.sfu.ca; don't fail the build when it's unavailable
timeout 60 php tools/upgrade.php check || echo "::warning::upgrade.php check failed; pkp.sfu.ca may be unavailable"
php tools/upgrade.php upgrade


if [[ "$TEST" == "pgsql" ]]; then

  sudo -u postgres psql -c "DROP DATABASE \"${DBNAME}\";" -U postgres
  sudo -u postgres psql -c "DROP USER \"${DBUSERNAME}\" ;" -U postgres

elif [[ "$TEST" == "mysql" ]]; then

  sudo mysql -u root -e "DROP DATABASE  \`${DBNAME}\` ";
  sudo mysql -u root -e "DROP USER \`${DBUSERNAME}\`@${DBHOST}";

fi
