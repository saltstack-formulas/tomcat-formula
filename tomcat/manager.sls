{% if grains.os != 'FreeBSD' %}
{% from "tomcat/map.jinja" import tomcat with context %}

{{ tomcat.manager }}:
  pkg:
    - installed

/etc/{{ tomcat.name }}{{ tomcat.version }}/tomcat-users.xml:
    file.managed:
        - source: salt://tomcat/files/tomcat-users.xml
        - user: root
        - group: tomcat7
        - mode: 640
        - template: jinja
        - defaults:
            user: {{ pillar.get('tomcat-manager.user') }}
            passwd: {{ pillar.get('tomcat-manager.passwd') }}

{% endif %}
