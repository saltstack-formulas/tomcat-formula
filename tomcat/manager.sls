{% from "tomcat/map.jinja" import tomcat with context %}

include:
  - tomcat

{% if grains.os != 'FreeBSD' %}

# on archlinux tomcat manager is already in tomcat package
{% if grains.os != 'Arch' %}
{{ tomcat.manager_pkg }}:
  pkg.installed:
    - require:
      - pkg: tomcat
{% endif %}

{{ tomcat.conf_dir }}/tomcat-users.xml:
  file.managed:
    - source: salt://tomcat/files/tomcat-users.xml
    - user: root
    - group: {{ tomcat.group }}
    - mode: '640'
    - template: jinja
    - defaults:
      tomcat: {{ tomcat }}
    - require:
      - pkg: tomcat
    - require_in:
      - service: tomcat
    - watch_in:
      - service: tomcat
{% endif %}

