{% from "tomcat/map.jinja" import tomcat with context %}

{{ tomcat.conf_dir }}/server.xml:
    file.managed:
        - source: salt://tomcat/files/server.xml
        - user: {{ tomcat.user }}
        - group: {{ tomcat.group }}
        - mode: '644'
        - template: jinja
        - defaults:
            tomcat: {{ tomcat }}

