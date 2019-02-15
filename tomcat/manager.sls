{% from "tomcat/map.jinja" import tomcat with context %}

include:
  - tomcat

# on archlinux/MacOS family tomcat manager is already in tomcat package
{% if grains.os_family not in ('Arch','MacOS') %}
tomcat {{ tomcat.manager_pkg }}:
  pkg.installed:
    - name: {{ tomcat.manager_pkg }}
    - require:
      - pkg: tomcat package installed and service running
{% endif %}

tomcat {{ tomcat.conf_dir }}/tomcat-users.xml:
  file.managed:
    - name: {{ tomcat.conf_dir }}/tomcat-users.xml
    - source: salt://tomcat/files/tomcat-users.xml
    - user: root
    - group: {{ tomcat.group }}
    - mode: '640'
    - template: jinja
    - defaults:
      tomcat: {{ tomcat|yaml }}
    - require:
      - pkg: tomcat package installed and service running
    - require_in:
      - service: tomcat package installed and service running
    - watch_in:
      - service: tomcat package installed and service running
    - unless: test "`uname`" = "FreeBSD"

