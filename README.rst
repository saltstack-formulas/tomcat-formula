======
tomcat
======

Formula to set up and configure tomcat webserver

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``tomcat``
----------

Installs Tomcat and starts the service. The main configuration files are
not changed, and the distro's defaults are preserved as they come in the
package.

``tomcat.config``
------------------

Configures the configuration file. Sane defaults are provided for the major
Linux distros (Debian, RedHat, Arch) and their derivatives.

``tomcat.native``
-----------------

Installs Apache Portable Runtime for Tomcat. Depends on ``tomcat.config``
to manage the configuration.

``tomcat.manager``
-----------------

Installs the host-manager and manager web applications for Apache Tomcat.

``tomcat.vhosts``
------------------

Configures Tomcat name-based virtual hosts using data from Pillar.

``tomcat.expires``
------------------

Configures Tomcat simple TCP cluster using data from Pillar.

``tomcat.cluster``
------------------

Enables Tomcats' ExpiresFilter using data from Pillar.

``tomcat.context``
------------------

Configures context element in the ``$CATALINA_BASE/conf/context.xml`` file:
the information in this file will be loaded by all web applications.
(Check the ``context`` examples in the ``pillar.example`` file for more information.
