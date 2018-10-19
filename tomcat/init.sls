{% from "tomcat/map.jinja" import tomcat with context %}
{% set tomcat_java_home = tomcat.java_home %}
{% set tomcat_java_opts = tomcat.java_opts %}

tomcat:
  pkg.installed:
    - name: {{ tomcat.pkg }}
    {% if tomcat.version is defined %}
    - version: {{ tomcat.version }}
    {% endif %}
  {%- if grains.os == 'MacOS' %}
   #Register as Launchd LaunchAgent for users
    - require_in: tomcat.file.managed
  cmd.run:
    - name: brew unlink tomcat && brew link tomcat
    - runas: {{ tomcat.user }}
    - unless: test -f /usr/local/opt/tomcat/{{ tomcat.service }}.plist
  file.managed:
    - name: /Library/LaunchAgents/{{ tomcat.service }}.plist
    - source: /usr/local/opt/tomcat/{{ tomcat.service }}.plist
    - group: wheel
    - require_in: tomcat.cmd.run
  {% endif %}
  service.running:
    - name: {{ tomcat.service }}
    - enable: {{ tomcat.service_enabled }}
    - watch:
      - pkg: tomcat
# To install haveged in centos you need the EPEL repository
# There is no haveged in MacOS
{% if tomcat.with_haveged and grains.os != 'MacOS' %}
  require:
    - pkg: haveged

haveged:
  pkg.installed: []
  service.running:
    - enable: {{ tomcat.haveged_enabled }}
    - watch:
       - pkg: haveged
{% endif %}

tomcat init whats tomcat status:
  cmd.run:
  - name: systemctl status tomcat8.service
  - onfail:
    - service: tomcat

