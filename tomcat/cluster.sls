{% from "tomcat/map.jinja" import tomcat with context %}

include:
  - tomcat.config

600_server_xml:
  file.accumulated:
    - filename: {{ tomcat.conf_dir }}/server.xml
    {% if tomcat.cluster is defined %}
    - text: {{ tomcat.cluster }}
    {% endif %}
    - require_in:
      - file: server_xml
    - unless: test "`uname`" = "Darwin"
