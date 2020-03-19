# CHANGE LOG

## 2.1.1 - 03/19/2020 - Levon Becker
* Renamed repo from inspec_bonusbits_base to bonusbits_base_inspec
* Updated min inspec version to 4.18.85
* Moved ToDo list to TODO.md
* Cleaned up Gemfile
    * Updated to rubocop 0.75.1
    * Removed unused gems
    * Added Ruby version 2.6.5
* Cleaned up rubocop config and eliminated warnings by adding department to each rule that was missing it
* Updated Readme with renamed repo name

## 2.1.0 - 01/06/2020 - Levon Becker
* Removed string to boolean input syntax. Found it was giving odd false positive results.
* Switched to ruby 2.6.5 container instead of chefdk for CircleCI
* I tried combining all the logic to one call for the json node attributes, but the converge order is screwy and couldn't get it to work reliably.
* Added gem_source control
* Added bash_profile control
* Added chef control

## 2.0.0 - 12/09/2019 - Levon Becker
* Updated CircleCI Config to v2.1
* Updated Gemfile to ChefDK v4.5.0 Gems
* Switched attributes to inputs (new syntax & backwards breaking)
* Added node_attributes methods (requires writing chef attributes to json done by bonusbits_base)
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
* Merged inspec_bootstrap inspec profile into this profile to deprecate bootstrap profile (chef control)
* Added bash_profile control
* Added gem_source control (not tested yet)

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