{% from "tomcat/map.jinja" import tomcat with context %}

include:
  - tomcat.config

tomcat {{ tomcat.native_pkg }}:
  pkg.installed:
    - name: {{ tomcat.native_pkg }}

tomcat 200_server_xml:
  file.accumulated:
    - filename: {{ tomcat.conf_dir }}/server.xml
    - text: enabled
    - require_in:
      - file: tomcat server_xml

{% if grains.get('oscodename') == 'trusty' %}
tomcat /usr/lib/libtcnative-1.so:
  file.symlink:
    - name: /usr/lib/libtcnative-1.so
    - target: /usr/lib/{{grains['cpuarch']}}-linux-gnu/libtcnative-1.so
{% endif %}
