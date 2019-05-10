#!/bin/sh
result=${PWD##*/} 
wp core download
wp core config --dbname=$result --dbuser=root --dbpass=root --extra-php <<PHP 
define( 'WP_DEBUG', true ); 
define( 'WP_DEBUG_LOG', true );
PHP

wp db create
wp core install --url="http://localhost/$result" --title=$result --admin_user=orion --admin_password=orion123Go --admin_email=freelance@orionorigin.com