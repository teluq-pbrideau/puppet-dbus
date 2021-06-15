# dbus

[![Build Status](https://img.shields.io/github/workflow/status/bodgit/puppet-dbus/Test)](https://github.com/bodgit/puppet-dbus/actions?query=workflow%3ATest)
[![Codecov](https://img.shields.io/codecov/c/github/bodgit/puppet-dbus)](https://codecov.io/gh/bodgit/puppet-dbus)
[![Puppet Forge version](http://img.shields.io/puppetforge/v/bodgit/dbus)](https://forge.puppetlabs.com/bodgit/dbus)
[![Puppet Forge downloads](https://img.shields.io/puppetforge/dt/bodgit/dbus)](https://forge.puppetlabs.com/bodgit/dbus)
[![Puppet Forge - PDK version](https://img.shields.io/puppetforge/pdk-version/bodgit/dbus)](https://forge.puppetlabs.com/bodgit/dbus)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with dbus](#setup)
    * [Beginning with dbus](#beginning-with-dbus)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

This module manages D-Bus.

RHEL/CentOS, Ubuntu, Debian and OpenBSD are supported using Puppet 5 or
later.

## Setup

### Beginning with dbus

In the very simplest case, you can just include the following:

```puppet
include dbus
```

## Usage

To add the oddjob daemon to the system bus:

```puppet
include dbus

dbus::system { 'oddjob':
  content => file('oddjob/oddjob.conf'),
}
```

## Reference

The reference documentation is generated with
[puppet-strings](https://github.com/puppetlabs/puppet-strings) and the latest
version of the documentation is hosted at
[https://bodgit.github.io/puppet-dbus/](https://bodgit.github.io/puppet-dbus/)
and available also in the [REFERENCE.md](https://github.com/bodgit/puppet-dbus/blob/main/REFERENCE.md).

## Limitations

This module has been built on and tested against Puppet 5 and higher.

The module has been tested on:

* Red Hat/CentOS Enterprise Linux 6/7/8
* Ubuntu 16.04/18.04/20.04
* Debian 9/10
* OpenBSD 6.9

## Development

The module relies on [PDK](https://puppet.com/docs/pdk/1.x/pdk.html) and has
both [rspec-puppet](http://rspec-puppet.com) and
[Litmus](https://github.com/puppetlabs/puppet_litmus) tests. Run them
with:

```
$ bundle exec rake spec
$ bundle exec rake litmus:*
```

Please log issues or pull requests at
[github](https://github.com/bodgit/puppet-dbus).
