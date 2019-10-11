# CHANGE LOG

## 2.0.1 - TODO List - Levon Becker
* Get jUnit test results working for rubocop rake task

## 2.0.0 - 10/11/2019 - Levon Becker
* Updated CircleCI Config to v2.1
* Updated Gemfile to ChefDK v4.3.13 Gems
* Updated default to value attributes
* Remove yum_cron
* Wrapped logic with control syntax. Can now call specific controls and ignore inspec attributes.
* Removed inspec from Gemfile
* Removed EPEL test controls
* Renamed some attributes so it's not backwards compatible hence the major version rev
* Added stub attrs.yml
* Removed Windows support
* Added Inspec Version check to inspec.yml
* Updated os method calls to work with newer version and discover Amazon Linux correctly again

## 1.1.0 - 10/27/2017 - Levon Becker
* Added Backups Tests
* Added CloudWatch Tests
* Simplified configure args local variable to be named the same
* Added Gemfile.lock to keep CircleCI in-line for testing
* Added Java Install Tests

## 1.0.5 - 04/17/2017 - Levon Becker
* Switch attribute/arg for inside_aws to discovery method.

## 1.0.4 - 04/06/2017 - Levon Becker
* Added aws profile test
* Changed proxy to look for profile.d/proxy.sh instead of /etc/environment setup

## 1.0.3 - 04/05/2017 - Levon Becker
* Added logic for dealing with string as boolean attributes
* Added debug attribute that will trigger output of all the attributes.

## 1.0.2 - 04/04/2017 - Levon Becker
* Fixed configure_sudoers attribute

## 1.0.1 - 04/04/2017 - Levon Becker
* Added some more conditions to tests
* Changed software package lists to attributes so they can be over-road
* Added a few more package list types, but not all tested out yet.
* Switched os-family unix to linux
* Added support os-family windows
* Added support platform aws

## 1.0.0 - 04/03/2017 - Levon Becker
* Initial Release

---