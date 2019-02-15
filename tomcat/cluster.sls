{% from "tomcat/map.jinja" import tomcat with context %}

include:
  - tomcat.config

tomcat 600_server_xml:
  file.accumulated:
    - filename: {{ tomcat.conf_dir }}/server.xml
    {% if tomcat.cluster is defined %}
    - text: {{ tomcat.cluster }}
    {% endif %}
    - require_in:
      - file: tomcat server_xml
    - unless: test "`uname`" = "Darwin"
