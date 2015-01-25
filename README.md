WaWision Cookbook
=================

The Chef WaWision cookbook installs and configures the ERP/CRM [WaWision]
according to the [installation instruction] of the Open-Source version
(*OSS testing*).

## CI Status

[![Build Status](https://travis-ci.org/lipro-cookbooks/wawision.svg?branch=master)](https://travis-ci.org/lipro-cookbooks/wawision)

### Known Issues and Things TODO

**This Chef cookbook has state of WORK IN PROGRESS!** There is something
to do now. It is not (yet) ready for final use. See the list below.

- [ ] WaWision application
  - [ ] Support different installation methods:
    - [X] ~~Remote TAR file extraction from [SourceForge]~~
    - [ ] Remote Git/SVN extraction
          (**Where is the original source code repository?**)
  - [ ] Database setup and migration
- [ ] WEB Server integration:
  - [ ] Support for Apache 2
  - [ ] Support for NginX
- [ ] Database Server integration:
  - [ ] Support for MariaDB (aka. MySQL)

## Requirements

TODO: List your cookbook requirements. Be sure to include any requirements
this cookbook has on platforms, libraries, other cookbooks, packages,
operating systems, etc.

### Platform

The following platforms are supported and protected by integration tests:

* Ubuntu: 14.04
* CentOS: 6.5

The following platforms are supported and protected by unit tests:

* Debian:       jessie/sid, 7.6, 7.5, 7.4, 7.2, 7.1, 7.0, 6.0.5
* Ubuntu:       14.10, 14.04, 13.10, 13.04, 12.04, 10.04
* RHEL/CentOS:  7.0, (6.6), 6.5, 6.4, 6.3, (6.2, 6.1), 6.0, (5.11), 5.10, 5.9,
                5.8, (5.7, 5.6)
* Oracle Linux: 6.5, 5.10
* Amazon Linux: 2014.09, 2014.03, 2013.09, 2012.09

Other Debian and RHEL family distributions are assumed to work.

The following platforms are **unsupported** and protected as such systems
by unit tests:

* Fedora:       21, 20, 19, 18
* SEL/SUSE:     12.0, 11.3, 11.2, 11.1
* OpenSUSE:     13.1, 12.3
* ARCH Linux:   3.10.5-1-ARCH
* Gentoo Linux: 2.1
* Slackware:    14.1
* FreeBSD:      10.0, 9.2, 9.1, 8.4
* OpenBSD:      5.4
* OmniOS:       151008, 151006, 151002
* SmartOS:      5.11
* Solaris2:     5.11
* AIX:          7.1, 6.1
* MacOSX:       10.10, 10.9.2, 10.8.2, 10.7.4, 10.6.8
* Windows:      2012R2, 2012, 2008R2, 2003R2

### Cookbooks

- `tar` - WaWision needs tar to download and extract archives.

## Attributes

### WaWision

TODO: List your cookbook attributes here.

#### wawision::default
e.g.
<table>
  <tr>
    <th>Key</th>
    <th>Default</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>['wawision']['foobar']</tt></td>
    <td><tt>true</tt></td>
    <td>Boolean</td>
    <td>whether to include foobar</td>
  </tr>
</table>

## Usage

### WaWision

TODO: Write usage instructions for each cookbook.

#### wawision::default
e.g.

Just include `wawision` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[wawision]"
  ]
}
```

## Contributing


1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Authors: TODO: List authors

## News and Website

All about WaWision ERP/CRM can be found on the project [website].

[WaWision]: http://www.wawision.de/
[website]: http://www.wawision.de/
[installation instruction]: http://www.wawision.de/installationsanleitung-open-source-version-von-wawision/
[SourceForge]: http://sourceforge.net/projects/wawision/files/
