{% from "tomcat/map.jinja" import tomcat with context %}

{{ tomcat.native }}:
  pkg:
    - installed
