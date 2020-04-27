
Changelog
=========

`0.17.2 <https://github.com/saltstack-formulas/tomcat-formula/compare/v0.17.1...v0.17.2>`_ (2020-04-27)
-----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **config.sls:** ensure catalina_tmpdir created with correct permissions (\ `4b5387f <https://github.com/saltstack-formulas/tomcat-formula/commit/4b5387f412766558962ea92d1f9fd9a852562c2a>`_\ )
* **debian:** define catalina_* variables for Debian based OSes (\ `7062834 <https://github.com/saltstack-formulas/tomcat-formula/commit/706283490bb52eda7b191f458efd0ef7cbadd55b>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **gemfile.lock:** add to repo with updated ``Gemfile`` [skip ci] (\ `479c014 <https://github.com/saltstack-formulas/tomcat-formula/commit/479c0147bedb57cca8d670e92387fa806fe5dbfc>`_\ )

Tests
^^^^^


* **yaml_dump:** update tests for changed catalina_* variables (\ `20cbcb8 <https://github.com/saltstack-formulas/tomcat-formula/commit/20cbcb82c6d81ef07bef6d24936b420d096fafea>`_\ )

`0.17.1 <https://github.com/saltstack-formulas/tomcat-formula/compare/v0.17.0...v0.17.1>`_ (2020-04-21)
-----------------------------------------------------------------------------------------------------------

Code Refactoring
^^^^^^^^^^^^^^^^


* standardise structure from the ``template-formula`` (\ `db49764 <https://github.com/saltstack-formulas/tomcat-formula/commit/db49764ef1af145e9469f5dcd888a2b2779b04f3>`_\ )
* **map.jinja:** use ``template-formula`` structure & add ``debian-10`` (\ `d1bb84f <https://github.com/saltstack-formulas/tomcat-formula/commit/d1bb84fdf0c788044ff6b72d45c7dc033346aac6>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **travis+inspec:** test ``debian-10`` as well (\ `9b2bab5 <https://github.com/saltstack-formulas/tomcat-formula/commit/9b2bab530575f90ce9070bd4e64ecc026ac73d1c>`_\ )

`0.17.0 <https://github.com/saltstack-formulas/tomcat-formula/compare/v0.16.0...v0.17.0>`_ (2020-04-20)
-----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **rubocop:** fix (or exclude) all violations (\ `ead2d21 <https://github.com/saltstack-formulas/tomcat-formula/commit/ead2d21b12ce97a58f0108ca8027667c1027bd4e>`_\ )
* **salt-lint:** fix all violations (\ `579ea68 <https://github.com/saltstack-formulas/tomcat-formula/commit/579ea689936c50b5b11b3e621ef044d69bb5c5b0>`_\ )
* **yamllint:** fix (or ignore) all errrors (\ `d50126a <https://github.com/saltstack-formulas/tomcat-formula/commit/d50126a333511f77ae6645357cdf0a5611a2ecaa>`_\ )

Documentation
^^^^^^^^^^^^^


* **readme:** apply standard structure (\ `a1365ef <https://github.com/saltstack-formulas/tomcat-formula/commit/a1365ef0ebea176e9892fb06730493ddd09b6e33>`_\ )

Features
^^^^^^^^


* **semantic-release:** implement for this formula (\ `7e4ced7 <https://github.com/saltstack-formulas/tomcat-formula/commit/7e4ced79821cb78d0dc1bc996c2d7c193e19281f>`_\ )

Tests
^^^^^


* add tests for packages and services (\ `d1b4f3a <https://github.com/saltstack-formulas/tomcat-formula/commit/d1b4f3ae67b3be3a2fb5302f1c8c0dd549ed8c97>`_\ )
* **yaml_dump:** add to ``tomcat_install`` suite (\ `c948f8b <https://github.com/saltstack-formulas/tomcat-formula/commit/c948f8b1eb7017c8c3d08e9d4023f573309908c6>`_\ )
