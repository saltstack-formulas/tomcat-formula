{% from "tomcat/map.jinja" import tomcat with context %}

include:
  - tomcat.config

100_web_xml:
  file.accumulated:
    - filename: {{ tomcat.conf_dir }}/web.xml
{% if tomcat.expires %}
    - text: {{ tomcat.expires }}
{% endif %}
    - require_in:
      - file: web_xml
