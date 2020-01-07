# InSpec Bonus Bits Base Cookbook Profile
[![Project Release](https://img.shields.io/badge/release-v2.1.0-blue.svg)](https://github.com/bonusbits/inspec_bonusbits_base)
[![CircleCI](https://circleci.com/gh/bonusbits/inspec_bonusbits_base.svg?style=shield)](https://circleci.com/gh/bonusbits/inspec_bonusbits_base)
[![Join the chat at https://gitter.im/bonusbits](https://badges.gitter.im/bonusbits/bonusbits.svg)](https://gitter.im/bonusbits?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![GitHub issues](https://img.shields.io/github/issues/bonusbits/inspec_bonusbits_base.svg)](https://github.com/bonusbits/inspec_bonusbits_base/issues)

Used to run integration tests for when using the [bonusbits_base](https://github.com/bonusbits/bonusbits_base) Chef Cookbook. 

## Standalone Usage

This Compliance Profile requires [InSpec](https://github.com/chef/inspec) for execution:

```
$ git clone https://github.com/bonusbits/inspec_bonusbits_base.git
$ inspec exec inspec_bonusbits_base
```

You can also execute the profile directly from Github:

```
$ inspec exec https://github.com/bonusbits/inspec_bonusbits_base
```

## Kitchen Usage
Add the InSpec Profile to your test suites in the Test Kitchen configuration.

```yaml
verifier:
  name: inspec
  
suites:
  - name: default
    run_list:
      - recipe[blah]
    verifier:
      inspec_tests:
        - name: bonusbits_base
          git: https://github.com/bonusbits/inspec_bonusbits_base.git
          release: 2.1.0
      attributes:
        debug: false
        inside_aws: true
```

## Attributes
| Control         | Attribute                 | Type     | Default       | Options                |
| :-------------- | :------------------------ |:-------- | :------------ | :--------------------- |
| all             | debug                     | Boolean  | false         | true/false             |
| aws             | inside_aws                | Boolean  | false         | true/false             |
| aws             | configure_aws_profile     | Boolean  | true          | true/false             |
| backups         | test_backups              | Boolean  | false         | true/false             |
| bash_profile    | test_bash_profile         | Boolean  | true          | true/false             |
| chef            | test_chef                 | Boolean  | true          | true/false             |
| cloudwatch      | test_cloudwatch           | Boolean  | false         | true/false             |
| cloudwatch_logs | inside_aws                | Boolean  | false         | true/false             |
| cloudwatch_logs | test_cloudwatch_logs      | Boolean  | true          | true/false             |
| gem_source      | test_gem_source           | Boolean  | true          | true/false             |
| java            | test_java                 | Boolean  | false         | true/false             |
| java            | java_package_name         | String   | java-1.8.0-openjdk | N/A               |
| java            | java_specify_version      | Boolean  | false         | true/false             |
| java            | java_version              | String   | 1.8.0.151-1.b12.35.amzn1 | N/A         |
| node_info       | configure_node_info       | Boolean  | true          | true/false             |
| packages        | install_packages          | Boolean  | true          | true/false             |
| packages        | amazon_packages           | Array    | long list     | array of package names |
| packages        | redhat_packages           | Array    | long list     | array of package names |
| packages        | debian_packages           | Array    | long list     | array of package names |
| packages        | suse_packages             | Array    | long list     | array of package names |
| packages        | windows_packages          | Array    | short list    | array of package names |
| proxy           | configure_proxy           | Boolean  | false         | true/false             |
| selinux         | configure_selinux         | Boolean  | true          | true/false             |
| sudoers         | configure_sudoers         | Boolean  | false         | true/false             |
