# CHANGE LOG

## 1.1.0 - 10/07/2019 - Levon Becker
* Updated CircleCI Config to v2.1
* Updated Gemfile to ChefDK v4.3.13 Gems

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