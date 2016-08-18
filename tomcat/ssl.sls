{% from "tomcat/map.jinja" import tomcat with context %}

include:
  - tomcat
  - tomcat.vhosts

{{ tomcat.service }}-ssl:
  service.running:
    - name: {{ tomcat.service }}
    - watch:
      - file: {{ tomcat.conf_dir }}/server.xml

