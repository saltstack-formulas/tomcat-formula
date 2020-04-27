{% from "tomcat/map.jinja" import tomcat with context %}

include:
  - tomcat.config

tomcat {{ tomcat.native_pkg }}:
  {%- if grains.get('osfinger', '') == 'Amazon Linux-2' %}
  pkgrepo.managed:
    - name: epel
    - humanname: Extra Packages for Enterprise Linux 7 - $basearch
    - mirrorlist: https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch
    - enabled: 1
    - gpgcheck: 1
    - gpgkey: https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
    - failovermethod: priority
    - require_in:
      - pkg: tomcat {{ tomcat.native_pkg }}
  {%- endif %}
  pkg.installed:
    - name: {{ tomcat.native_pkg }}

tomcat 200_server_xml:
  file.accumulated:
    - name: 200_server_xml
    - filename: {{ tomcat.conf_dir }}/server.xml
    - text: enabled
    - require_in:
      - file: tomcat server_xml

{% if grains.get('oscodename') == 'trusty' %}
tomcat /usr/lib/libtcnative-1.so:
  file.symlink:
    - name: /usr/lib/libtcnative-1.so
    - target: /usr/lib/{{ grains['cpuarch'] }}-linux-gnu/libtcnative-1.so
{% endif %}
