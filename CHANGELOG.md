# Changelog

## [0.19.5](https://github.com/saltstack-formulas/tomcat-formula/compare/v0.19.4...v0.19.5) (2021-03-04)


### Bug Fixes

* resolve configuration and tests for Ubuntu 16.04 ([4e8016f](https://github.com/saltstack-formulas/tomcat-formula/commit/4e8016f2767c8131162de0b4ddf3a59892713fcc))
* resolve configuration and tests for Ubuntu 18.04 ([ec35e9b](https://github.com/saltstack-formulas/tomcat-formula/commit/ec35e9bfb294b27bd944b8c65e76cc06e7d31d48))


### Code Refactoring

* **debian:** centralise between `osfamily` & `osfinger` map files ([d467166](https://github.com/saltstack-formulas/tomcat-formula/commit/d467166e4341b58b0995a0e34be2eb9835a3146a))


### Continuous Integration

* **gemfile+lock:** use `ssf` customised `kitchen-docker` repo [skip ci] ([3e571a6](https://github.com/saltstack-formulas/tomcat-formula/commit/3e571a6cf9d76587af1bf019e7c4ac35f94154de))
* **kitchen+gitlab-ci:** use latest pre-salted images [skip ci] ([e56f6df](https://github.com/saltstack-formulas/tomcat-formula/commit/e56f6dfdde71fed2743051e5fcab4a56a42a5554))
* **pre-commit:** update hook for `rubocop` [skip ci] ([3e9ba8e](https://github.com/saltstack-formulas/tomcat-formula/commit/3e9ba8e39aff06c46f9f6742bc8d5a083fdda46d))


### Tests

* **_mapdata:** add verification file for Oracle Linux 8 ([833e72c](https://github.com/saltstack-formulas/tomcat-formula/commit/833e72c1b2a5c82569bb2e054d85b6078a2827d3))
* **config_spec:** disable `server.xml` control where Python < 3.6 ([5bd95fc](https://github.com/saltstack-formulas/tomcat-formula/commit/5bd95fcf0a15f3c5fd45b2543928d87e78b64f25))
* add for openSUSE Tumbleweed ([3b2a979](https://github.com/saltstack-formulas/tomcat-formula/commit/3b2a97992e685c3b5eb25bc9091ebb900bd77b73))
* add for Oracle Linux 7 ([9f1ff44](https://github.com/saltstack-formulas/tomcat-formula/commit/9f1ff4463a24302a466bd5d33ee723213262c4ba))
* remove `_spec` suffix from filenames ([ac90357](https://github.com/saltstack-formulas/tomcat-formula/commit/ac90357d914cc33ba694f29ceffd3553eabafa23))
* update for Arch Linux ([20d4499](https://github.com/saltstack-formulas/tomcat-formula/commit/20d4499b4d8f71050e6a359fcdc9ba1b38d46dcd))
* update for Fedora 33 ([39d7c2a](https://github.com/saltstack-formulas/tomcat-formula/commit/39d7c2a92b5564e7ceb8cf0b87083fd51f208a29))
* **share:** standardise with latest changes [skip ci] ([fe78ab9](https://github.com/saltstack-formulas/tomcat-formula/commit/fe78ab9d9fb037c1c886573294f85e0048cbcf95))

## [0.19.4](https://github.com/saltstack-formulas/tomcat-formula/compare/v0.19.3...v0.19.4) (2021-01-14)


### Bug Fixes

* **_mapdata:** ensure map data is directly under `values` ([0ffaa37](https://github.com/saltstack-formulas/tomcat-formula/commit/0ffaa37f62d09e0fc4cbb197701ff337e49d7beb))


### Tests

* **_mapdata:** update for `_mapdata/init.sls` change ([c869918](https://github.com/saltstack-formulas/tomcat-formula/commit/c869918446861cb002f57a2c25b28f0cfdd4ebd6))

## [0.19.3](https://github.com/saltstack-formulas/tomcat-formula/compare/v0.19.2...v0.19.3) (2020-12-27)


### Continuous Integration

* **commitlint:** ensure `upstream/master` uses main repo URL [skip ci] ([41a15f9](https://github.com/saltstack-formulas/tomcat-formula/commit/41a15f9b16de4b2c411b1451888c5bcd3297c9d0))
* **gitlab-ci:** add `rubocop` linter (with `allow_failure`) [skip ci] ([d805414](https://github.com/saltstack-formulas/tomcat-formula/commit/d80541452bc36535aa79d1d7804ad4635a9df5a5))


### Tests

* **_mapdata:** generate verification files ([dbed9c1](https://github.com/saltstack-formulas/tomcat-formula/commit/dbed9c1440a3bd6a671487dc740d33bfbdc405a4))
* **comparison_files:** refactor to use InSpec profile directory ([901188d](https://github.com/saltstack-formulas/tomcat-formula/commit/901188d49d5b175168a41084f4a5aa78a51110c3))
* **config_spec:** avoid use of `HOSTNAME_PLACEHOLDER` ([8d4ced7](https://github.com/saltstack-formulas/tomcat-formula/commit/8d4ced7fb00a0951d8a7c344020ba410c58b2245))
* **map:** verify `map.jinja` dump using `_mapdata` state ([dd792fb](https://github.com/saltstack-formulas/tomcat-formula/commit/dd792fb17d44572cadc476dcc9661afea8b2baca))

## [0.19.2](https://github.com/saltstack-formulas/tomcat-formula/compare/v0.19.1...v0.19.2) (2020-12-18)


### Bug Fixes

* **osfingermap:** reinstate values for `Debian-9` after regression ([5170561](https://github.com/saltstack-formulas/tomcat-formula/commit/517056194d41e117179405c4471aa68eb66f152e)), closes [#119](https://github.com/saltstack-formulas/tomcat-formula/issues/119)

## [0.19.1](https://github.com/saltstack-formulas/tomcat-formula/compare/v0.19.0...v0.19.1) (2020-12-16)


### Continuous Integration

* **gitlab-ci:** use GitLab CI as Travis CI replacement ([c99d984](https://github.com/saltstack-formulas/tomcat-formula/commit/c99d98431a41a9a118a34c692923a9c80942f75d))
* **kitchen:** use `saltimages` Docker Hub where available [skip ci] ([b4c10cf](https://github.com/saltstack-formulas/tomcat-formula/commit/b4c10cfd33e386fff5fdd521a2fcf236013b589a))
* **pre-commit:** add to formula [skip ci] ([eb14b1f](https://github.com/saltstack-formulas/tomcat-formula/commit/eb14b1f32fd73afb0545e7ac30b296053f5fc5bf))
* **pre-commit:** enable/disable `rstcheck` as relevant [skip ci] ([82e157e](https://github.com/saltstack-formulas/tomcat-formula/commit/82e157e0362ee86cc2b23c02eea5f9299bdef102))
* **pre-commit:** finalise `rstcheck` configuration [skip ci] ([ed06e07](https://github.com/saltstack-formulas/tomcat-formula/commit/ed06e07f3a01c9c46b3cbadcfaab2d42e0841352))


### Tests

* **yaml_dump_spec:** update with `common_pkg` from PR [#119](https://github.com/saltstack-formulas/tomcat-formula/issues/119) [skip ci] ([29db014](https://github.com/saltstack-formulas/tomcat-formula/commit/29db014282d8c80050cdf1114115dccc77bd7ae9))

# [0.19.0](https://github.com/saltstack-formulas/tomcat-formula/compare/v0.18.0...v0.19.0) (2020-05-28)


### Continuous Integration

* **kitchen+travis:** add new platforms [skip ci] ([91e57b5](https://github.com/saltstack-formulas/tomcat-formula/commit/91e57b5672e2a9f93fe9cf8f216ce513ba89b613))
* **kitchen+travis:** adjust matrix to add `3000.2` & remove `2018.3` [skip ci] ([fea7a6c](https://github.com/saltstack-formulas/tomcat-formula/commit/fea7a6c07f4ca7e7273b9c0d406941f5d53bcb09))
* **kitchen+travis:** adjust matrix to add `3000.3` [skip ci] ([b378533](https://github.com/saltstack-formulas/tomcat-formula/commit/b378533a10cc11e339c81e40d7ef39a13f137870))
* **kitchen+travis:** remove `master-py2-arch-base-latest` [skip ci] ([7ee2926](https://github.com/saltstack-formulas/tomcat-formula/commit/7ee2926402e291243edf301b8733f24d80a22518))
* **kitchen+travis:** use new platforms ([2fd6f92](https://github.com/saltstack-formulas/tomcat-formula/commit/2fd6f92a7976b42b61a21687b67a425b0ca5f54e))
* **travis:** add notifications => zulip [skip ci] ([65a5733](https://github.com/saltstack-formulas/tomcat-formula/commit/65a5733198495632fc08da803fce832b4adc81ca))
* **workflows/commitlint:** add to repo [skip ci] ([2451442](https://github.com/saltstack-formulas/tomcat-formula/commit/2451442b07659439ade466a0f2626482f24514f8))


### Features

* support new platforms (`ubuntu-20.04` & `fedora-32`) ([fce35a5](https://github.com/saltstack-formulas/tomcat-formula/commit/fce35a522d8effc99f0d1e03e0ed63518c114530))

# [0.18.0](https://github.com/saltstack-formulas/tomcat-formula/compare/v0.17.2...v0.18.0) (2020-04-27)


### Bug Fixes

* **cluster:** set accumlator name ([51f2968](https://github.com/saltstack-formulas/tomcat-formula/commit/51f2968ed0014079d392b52fc613e181bce3501f))
* **fedora:** use `ver: 9` (Jasper Listener deprecated in tomcat >= 8) ([ba9cbf1](https://github.com/saltstack-formulas/tomcat-formula/commit/ba9cbf12f79702b18eb0b5c95b62f219281f44fc))
* **native:** use EPEL repo for `amazonlinux-2` ([242f063](https://github.com/saltstack-formulas/tomcat-formula/commit/242f06378e4e9772be9f3ebffbe26ed3ca45bdb3))
* **server.xml:** replace tabs with spaces ([58d65f9](https://github.com/saltstack-formulas/tomcat-formula/commit/58d65f91e46aa2174985f4728da69e5efcd9c4ce))


### Continuous Integration

* **kitchen+travis+inspec:** merge test suites into single `default` suite ([429c56e](https://github.com/saltstack-formulas/tomcat-formula/commit/429c56e9b940e03f0b24ecb93540961fd450737b))


### Documentation

* **readme:** switch mixed-up state descriptions ([d43958f](https://github.com/saltstack-formulas/tomcat-formula/commit/d43958fe613312d74b5f78c973081a31c8a923f1))


### Features

* **osfingermap:** add settings for `debian-8` ([7c86d80](https://github.com/saltstack-formulas/tomcat-formula/commit/7c86d801ef492dc210ad8dc396502d9b60e0129b))


### Tests

* update and fix all tests (inc. provide files for comparison) ([50262c3](https://github.com/saltstack-formulas/tomcat-formula/commit/50262c3c012b0ebdb86810edd04793c31d2a0a79))

## [0.17.2](https://github.com/saltstack-formulas/tomcat-formula/compare/v0.17.1...v0.17.2) (2020-04-27)


### Bug Fixes

* **config.sls:** ensure catalina_tmpdir created with correct permissions ([4b5387f](https://github.com/saltstack-formulas/tomcat-formula/commit/4b5387f412766558962ea92d1f9fd9a852562c2a))
* **debian:** define catalina_* variables for Debian based OSes ([7062834](https://github.com/saltstack-formulas/tomcat-formula/commit/706283490bb52eda7b191f458efd0ef7cbadd55b))


### Continuous Integration

* **gemfile.lock:** add to repo with updated `Gemfile` [skip ci] ([479c014](https://github.com/saltstack-formulas/tomcat-formula/commit/479c0147bedb57cca8d670e92387fa806fe5dbfc))


### Tests

* **yaml_dump:** update tests for changed catalina_* variables ([20cbcb8](https://github.com/saltstack-formulas/tomcat-formula/commit/20cbcb82c6d81ef07bef6d24936b420d096fafea))

## [0.17.1](https://github.com/saltstack-formulas/tomcat-formula/compare/v0.17.0...v0.17.1) (2020-04-21)


### Code Refactoring

* standardise structure from the `template-formula` ([db49764](https://github.com/saltstack-formulas/tomcat-formula/commit/db49764ef1af145e9469f5dcd888a2b2779b04f3))
* **map.jinja:** use `template-formula` structure & add `debian-10` ([d1bb84f](https://github.com/saltstack-formulas/tomcat-formula/commit/d1bb84fdf0c788044ff6b72d45c7dc033346aac6))


### Continuous Integration

* **travis+inspec:** test `debian-10` as well ([9b2bab5](https://github.com/saltstack-formulas/tomcat-formula/commit/9b2bab530575f90ce9070bd4e64ecc026ac73d1c))

# [0.17.0](https://github.com/saltstack-formulas/tomcat-formula/compare/v0.16.0...v0.17.0) (2020-04-20)


### Bug Fixes

* **rubocop:** fix (or exclude) all violations ([ead2d21](https://github.com/saltstack-formulas/tomcat-formula/commit/ead2d21b12ce97a58f0108ca8027667c1027bd4e))
* **salt-lint:** fix all violations ([579ea68](https://github.com/saltstack-formulas/tomcat-formula/commit/579ea689936c50b5b11b3e621ef044d69bb5c5b0))
* **yamllint:** fix (or ignore) all errrors ([d50126a](https://github.com/saltstack-formulas/tomcat-formula/commit/d50126a333511f77ae6645357cdf0a5611a2ecaa))


### Documentation

* **readme:** apply standard structure ([a1365ef](https://github.com/saltstack-formulas/tomcat-formula/commit/a1365ef0ebea176e9892fb06730493ddd09b6e33))


### Features

* **semantic-release:** implement for this formula ([7e4ced7](https://github.com/saltstack-formulas/tomcat-formula/commit/7e4ced79821cb78d0dc1bc996c2d7c193e19281f))


### Tests

* add tests for packages and services ([d1b4f3a](https://github.com/saltstack-formulas/tomcat-formula/commit/d1b4f3ae67b3be3a2fb5302f1c8c0dd549ed8c97))
* **yaml_dump:** add to `tomcat_install` suite ([c948f8b](https://github.com/saltstack-formulas/tomcat-formula/commit/c948f8b1eb7017c8c3d08e9d4023f573309908c6))
