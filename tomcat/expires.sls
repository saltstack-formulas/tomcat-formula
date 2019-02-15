{% from "tomcat/map.jinja" import tomcat with context %}

include:
  - tomcat

tomcat web_xml:
  file.managed:
    - name: {{ tomcat.conf_dir }}/web.xml
    - source: salt://tomcat/files/web.xml
    - user: {{ tomcat.user }}
    - group: {{ tomcat.group }}
    - mode: '644'
    - template: jinja
    - defaults:
        expires_when: {{ salt['pillar.get']('tomcat:expires_when') }}
