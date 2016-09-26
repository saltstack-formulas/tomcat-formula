{% from "tomcat/map.jinja" import tomcat with context %}

300_server_xml:
  file.accumulated:
    - filename: {{ tomcat.conf_dir }}/server.xml
    {% if tomcat.sites is defined %}
    - text: {{ tomcat.sites }}
    {% endif %}
    - require_in:
      - file: server_xml

