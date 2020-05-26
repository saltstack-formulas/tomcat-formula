.. _readme:

tomcat
======

|img_travis| |img_sr|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/tomcat-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/saltstack-formulas/tomcat-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release

Formula to set up and configure tomcat webserver

.. contents:: **Table of Contents**

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_.

If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``,
which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.

See `Formula Versioning Section <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

If you need (non-default) configuration, please pay attention to the ``pillar.example`` file and/or `Special notes`_ section.

Contributing to this repo
-------------------------

**Commit message formatting is significant!!**

Please see `How to contribute <https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst>`_ for more details.

Special notes
-------------

None

Available states
----------------

.. contents::
   :local:

``tomcat``
^^^^^^^^^^

Installs Tomcat and starts the service. The main configuration files are
not changed, and the distro's defaults are preserved as they come in the
package.

``tomcat.config``
^^^^^^^^^^^^^^^^^

Configures the configuration file. Sane defaults are provided for the major
Linux distros (Debian, RedHat, Arch) and their derivatives.

``tomcat.native``
^^^^^^^^^^^^^^^^^

Installs Apache Portable Runtime for Tomcat. Depends on ``tomcat.config``
to manage the configuration.

``tomcat.manager``
^^^^^^^^^^^^^^^^^^

Installs the host-manager and manager web applications for Apache Tomcat.

``tomcat.vhosts``
^^^^^^^^^^^^^^^^^

Configures Tomcat name-based virtual hosts using data from Pillar.

``tomcat.expires``
^^^^^^^^^^^^^^^^^^

Enables Tomcats' ExpiresFilter using data from Pillar.

``tomcat.cluster``
^^^^^^^^^^^^^^^^^^

Configures Tomcat simple TCP cluster using data from Pillar.

``tomcat.context``
^^^^^^^^^^^^^^^^^^

Configures context element in the ``$CATALINA_BASE/conf/context.xml`` file:
the information in this file will be loaded by all web applications.
(Check the ``context`` examples in the ``pillar.example`` file for more information.

Testing
-------

Linux testing is done with ``kitchen-salt``.

Requirements
^^^^^^^^^^^^

* Ruby
* Docker

.. code-block:: bash

   $ gem install bundler
   $ bundle install
   $ bin/kitchen test [platform]

Where ``[platform]`` is the platform name defined in ``kitchen.yml``,
e.g. ``debian-9-2019-2-py3``.

``bin/kitchen converge``
^^^^^^^^^^^^^^^^^^^^^^^^

Creates the docker instance and runs the ``TEMPLATE`` main state, ready for testing.

``bin/kitchen verify``
^^^^^^^^^^^^^^^^^^^^^^

Runs the ``inspec`` tests on the actual instance.

``bin/kitchen destroy``
^^^^^^^^^^^^^^^^^^^^^^^

Removes the docker instance.

``bin/kitchen test``
^^^^^^^^^^^^^^^^^^^^

Runs all of the stages above in one go: i.e. ``destroy`` + ``converge`` + ``verify`` + ``destroy``.

``bin/kitchen login``
^^^^^^^^^^^^^^^^^^^^^

Gives you SSH access to the instance for manual testing.

