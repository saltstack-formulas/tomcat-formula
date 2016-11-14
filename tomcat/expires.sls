{% from "tomcat/map.jinja" import tomcat with context %}

100_web_xml:
  file.accumulated:
    - filename: {{ tomcat.conf_dir }}/web.xml
{% if tomcat.expires %}
    - text: {{ tomcat.expires }}
{% endif %}
    - require_in:
      - file: web_xml

web_xml:
  file.managed:
    - name: {{ tomcat.conf_dir }}/web.xml
    - source: salt://tomcat/files/web.xml
    - user: {{ tomcat.user }}
    - group: {{ tomcat.group }}
    - mode: '644'
    - template: jinja
