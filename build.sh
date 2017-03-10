#!/bin/bash

###
# Build Script
# Use this script to build theme assets,
# and perform any other build-time tasks.
##

# Clean up the working directory (useful when building from local dev files)
git clean -xdf

# Install PHP dependencies (WordPress, plugins, etc.)
composer install

# Add composer auth file
if [ ! -z $COMPOSER_USER ] && [ ! -z $COMPOSER_PASS ]
then
	cat <<- EOF >> auth.json
		{
			"http-basic": {
				"composer.wp.dsd.io": {
					"username": "$COMPOSER_USER",
					"password": "$COMPOSER_PASS"
				}
			}
		}
	EOF
fi

# Build theme assets
cd web/app/themes/imbmembers
npm install -g bower gulp-cli && echo "{ \"allow_root\": true }" > /root/.bowerrc
npm install && bower install
gulp --production

# Remove node_modules and bower_components to (drastically) reduce image size
rm -Rf node_modules bower_components auth.json
