# InSpec Bonus Bits Base Cookbook Profile
[![CircleCI](https://circleci.com/gh/bonusbits/inspec_bonusbits_base.svg?style=shield)](https://circleci.com/gh/bonusbits/inspec_bonusbits_base)
[![Join the chat at https://gitter.im/bonusbits/inspec_bonusbits_base](https://badges.gitter.im/bonusbits/inspec_bonusbits_base.svg)](https://gitter.im/bonusbits/inspec_bonusbits_base?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

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
      attributes:
        inside_aws: true
```

## Attributes
| Control         | Attribute             | Type     | Default       | Options     |
| :-------------- | :-------------------- |:-------- | :------------ | :---------  |
| cloudwatch_logs | inside_aws            | Boolean  | false         | true/false  |
| epel            | configure_epel        | Boolean  | false         | true/false  |
| epel            | install_epel_packages | Boolean  | false         | true/false  |
| firewall        | configure_firewall    | Boolean  | false         | true/false  |
| packages        | install_software      | Boolean  | true          | true/false  |
| proxy           | configure_proxy       | Boolean  | false         | true/false  |
| sudoers         | configure_sudoers     | Boolean  | false         | true/false  |
