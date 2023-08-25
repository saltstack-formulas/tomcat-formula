{% from "tomcat/map.jinja" import tomcat with context %}
{% set tomcat_java_home = tomcat.java_home %}
{% set tomcat_java_opts = '-' ~ tomcat.java_opts | join(' -') %}

include:
  - tomcat

tomcat tomcat_conf:
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
    - makedirs: True
    - template: jinja
    - defaults:
        tomcat: {{ tomcat|yaml }}
  {% endif %}
    - require:
      - pkg: tomcat package installed and service running
    - require_in:
      - service: tomcat package installed and service running
    - watch_in:
      - service: tomcat package installed and service running

{% if tomcat.catalina_tmpdir|d('') %}
catalina tmpdir:
  file.directory:
    - name: {{ tomcat.catalina_tmpdir }}
    - user: {{ tomcat.user }}
    - group: {{ tomcat.group }}
    - mode: '755'
    - makedirs: True
    - require_in:
      - service: tomcat package installed and service running
{% endif %}

tomcat 100_server_xml:
  file.accumulated:
    - name: 100_server_xml
    - filename: {{ tomcat.conf_dir }}/server.xml
    - text: {{ tomcat.connectors }}
    - require_in:
      - file: tomcat server_xml

tomcat 110_server_xml:
  file.accumulated:
    - name: 110_server_xml
    - filename: {{ tomcat.conf_dir }}/server.xml
    - text: {{ tomcat.realm }}
    - require_in:
      - file: tomcat server_xml

tomcat 500_server_xml:
  file.accumulated:
    - name: 500_server_xml
    - filename: {{ tomcat.conf_dir }}/server.xml
    - text: {{ tomcat.resources }}
    - require_in:
      - file: tomcat server_xml

# Jasper Listener deprecated in tomcat >= 8
# https://tomcat.apache.org/tomcat-8.0-doc/changelog.html
tomcat 400_server_xml:
  file.accumulated:
    - name: 400_server_xml
    - filename: {{ tomcat.conf_dir }}/server.xml
    - text: enabled
    - require_in:
      - file: tomcat server_xml
    - onlyif: test {{ tomcat.ver }} -lt 8

tomcat server_xml:
  file.managed:
    - name: {{ tomcat.conf_dir }}/server.xml
    - source: salt://tomcat/files/server.xml
   {% if grains.os != 'MacOS' %}
    #Inherit logged-on user permissions on Darwin
    - user: {{ tomcat.user }}
    - group: {{ tomcat.group }}
   {% endif %}
    - mode: '644'
    - template: jinja
    - require_in:
      - service: tomcat package installed and service running
    - watch_in:
      - service: tomcat package installed and service running

tomcat limits_conf:
  {% if grains.os == 'Arch' %}
  file.append:
    - name: /etc/security/limits.conf
    - text:
      - {{ tomcat.user }} soft nofile {{ tomcat.limit.soft }}
      - {{ tomcat.user }} hard nofile {{ tomcat.limit.hard }}
  {% else %}
  file.managed:
    {%- if grains.os == 'MacOS' %}
    - name: /Library/LaunchDaemons/limit.maxfiles.plist
    - source: salt://tomcat/files/limit.maxfiles.plist
    - context:
      soft_limit: {{ tomcat.limit.soft }}
      hard_limit: {{ tomcat.limit.hard }}
    - group: wheel
    {%- else %}
    - name: /etc/security/limits.d/tomcat{{ tomcat.ver }}.conf
    - contents:
      - {{ tomcat.user }} soft nofile {{ tomcat.limit.soft }}
      - {{ tomcat.user }} hard nofile {{ tomcat.limit.hard }}
    {%- endif %}
  {% endif %}
    - require:
      - pkg: tomcat package installed and service running
    - require_in:
      - service: tomcat package installed and service running
    - watch_in:
      - service: tomcat package installed and service running
    - unless: test "`uname`" = "FreeBSD"

