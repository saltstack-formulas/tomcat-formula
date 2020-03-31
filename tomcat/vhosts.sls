{% from "tomcat/map.jinja" import tomcat with context %}

include:
  - tomcat.config

tomcat 300_server_xml:
  file.accumulated:
    - name: 300_server_xml
    - filename: {{ tomcat.conf_dir }}/server.xml
    {% if tomcat.sites is defined %}
    - text: {{ tomcat.sites }}
    {% endif %}
    - require_in:
      - file: tomcat server_xml
