include:
  - tomcat
{% if grains.os != 'FreeBSD' %}
{% from "tomcat/map.jinja" import tomcat with context %}

# on archlinux tomcat manager is already in tomcat package
{% if grains.os != 'Arch' %}

{{ tomcat.manager_pkg }}:
  pkg.installed
{% endif %}

{{ tomcat.conf_dir }}/tomcat-users.xml:
    file.managed:
        - source: salt://tomcat/files/tomcat-users.xml
        - user: root
        - group: {{ tomcat.group }}
        - mode: '640'
        - template: jinja

{% endif %}

