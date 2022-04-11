# -*- coding: utf-8 -*-
# vim: ft=yaml
---
tomcat:
  java_opts:
    - 'Djava.awt.headless=true'
    - 'Xmx128m'
    # Change paths to correct locations
    - 'Dlog4j.configuration=file:/tmp/log4j.properties'
    - 'Dlogback.configurationFile=/tmp/logback.xml'
