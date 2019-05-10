#!/usr/bin/env bash

# Create the public_html folder and switch to it
mkdir public_html
cd public_html

# Download the WP core
wp core download
# Configure database settings
wp config create --dbname=dev --dbuser=root --dbpass=root
# Create the database
wp db create
# Install WP core
wp core install --url='http://wclos.dev' --title='WCLOS' --admin_user=admin --admin_password=admin --admin_email=admin@wclos.dev

# Change the website's description
wp option update blogdescription 'Just another WCLOS Website'
# Set the time zone
wp option update timezone_string 'America/Los_Angeles'

# Delete Akismet and Hello plugins
wp plugin delete akismet
wp plugin delete hello

# Install a theme from wordpress.org theme directory
wp theme install twentyten
# Create a child theme
wp scaffold child-theme my-theme --parent_theme=twentyten
# Activate the child theme
wp theme activate my-theme

# Trash the 'Hello world!' post
wp post delete 1
# Trash the 'Sample page'
wp post delete 2

# Create some pages
wp post create --post_type=page --post_title='Contact us' --post_status='publish'
wp post create --post_type=page --post_title='About us' --post_status='publish'

# Generate some posts with fetched content from loripsum.net.
curl http://loripsum.net/api/5 | wp post generate --post_content --count=10

# Create a menu
wp menu create 'Main Menu'
# Assign a location to the menu.
wp menu location assign main-menu primary
# Add all pages to the main menu
wp post list --post_type='page' --format=ids | xargs -d ' ' -I % wp menu item add-post main-menu %
