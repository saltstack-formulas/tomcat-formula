{% from "tomcat/map.jinja" import tomcat with context %}
{% set tomcat_java_home = tomcat.java_home %}
{% set tomcat_java_opts = '-' ~ tomcat.java_opts | join(' -') %}

include:
  - tomcat

tomcat_conf:
  {% if grains.os == 'FreeBSD' %}
  file.append:
    - name: {{ tomcat.main_config }}
    - text:
      - tomcat{{ tomcat.ver }}_java_home="{{ tomcat_java_home }}"
      - tomcat{{ tomcat.ver }}_java_opts="{{ tomcat_java_opts }}"
  {% else %}
  file.managed:
    - name: {{ tomcat.main_config }}
    - source: {{ tomcat.main_config_template }}
    - template: jinja
    - defaults:
        tomcat: {{ tomcat }}
  {% endif %}
    - require:
      - pkg: tomcat
    - require_in:
      - service: tomcat
    - watch_in:
      - service: tomcat

100_server_xml:
  file.accumulated:
    - filename: {{ tomcat.conf_dir }}/server.xml
    - text: {{ tomcat.connectors }}
    - require_in:
      - file: server_xml

500_server_xml:
  file.accumulated:
    - filename: {{ tomcat.conf_dir }}/server.xml
    - text: {{ tomcat.resources }}
    - require_in:
      - file: server_xml

# Jasper Listener deprecated in tomcat >= 8
# https://tomcat.apache.org/tomcat-8.0-doc/changelog.html
{% if tomcat.ver < 8 %}
400_server_xml:
  file.accumulated:
    - filename: {{ tomcat.conf_dir }}/server.xml
    - text: enabled
    - require_in:
      - file: server_xml
{% endif %}

server_xml:
  file.managed:
    - name: {{ tomcat.conf_dir }}/server.xml
    - source: salt://tomcat/files/server.xml
    - user: {{ tomcat.user }}
    - group: {{ tomcat.group }}
    - mode: '644'
    - template: jinja
    - require_in:
      - service: tomcat
    - watch_in:
      - service: tomcat

{% if grains.os != 'FreeBSD' %}
limits_conf:
  {% if grains.os == 'Arch' %}
  file.append:
    - name: /etc/security/limits.conf
    - text:
  {% else %}
  file.managed:
    - name: /etc/security/limits.d/tomcat{{ tomcat.ver }}.conf
    - contents:
  {% endif %}
      - {{ tomcat.user }} soft nofile {{ tomcat.limit.soft }}
      - {{ tomcat.user }} hard nofile {{ tomcat.limit.hard }}
    - require:
      - pkg: tomcat
    - require_in:
      - service: tomcat
    - watch_in:
      - service: tomcat
{% endif %}

