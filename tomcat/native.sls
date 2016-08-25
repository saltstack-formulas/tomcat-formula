{% from "tomcat/map.jinja" import tomcat with context %}

{{ tomcat.native_pkg }}:
  pkg.installed

200_server_xml:
  file.accumulated:
    - filename: {{ tomcat.conf_dir }}/server.xml
    - text: enabled
    - require_in:
      - file: server_xml        