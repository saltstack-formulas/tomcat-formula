{% from "tomcat/map.jinja" import tomcat with context %}

include:
  - tomcat

{{ tomcat.conf_dir }}/context.xml:
  file.managed:
    - source: salt://tomcat/files/context.xml
    - user: root
    - group: {{ tomcat.group }}
    - mode: '640'
    - template: jinja
    - defaults:
      tomcat: {{ tomcat }}
    - require:
      - pkg: tomcat
    - require_in:
      - service: tomcat
    - watch_in:
      - service: tomcat

