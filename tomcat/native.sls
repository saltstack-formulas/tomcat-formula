{% from "tomcat/map.jinja" import tomcat with context %}

include:
  - tomcat.config

{{ tomcat.native_pkg }}:
  pkg.installed

200_server_xml:
  file.accumulated:
    - filename: {{ tomcat.conf_dir }}/server.xml
    - text: enabled
    - require_in:
      - file: server_xml

{% if grains.get('oscodename') == 'trusty' %}
/usr/lib/{{grains['cpuarch']}}-linux-gnu/libtcnative-1.so:
  file.symlink:
    - target: /usr/lib/libtcnative-1.so
{% endif %}