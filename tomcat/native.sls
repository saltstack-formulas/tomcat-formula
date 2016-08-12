{% from "tomcat/map.jinja" import tomcat with context %}

{{ tomcat.native_pkg }}:
  pkg.installed

