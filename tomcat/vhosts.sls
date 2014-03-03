{% from "tomcat/map.jinja" import tomcat with context %}

/etc/{{ tomcat.name }}{{ tomcat.version }}/server.xml:
  file.managed:
    - source: salt://tomcat/files/server.xml
    - template: jinja
    - require:
      - pkg: {{ tomcat.name }}{{ tomcat.version }}

# TODO: Reload war files
