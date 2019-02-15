{% from "tomcat/map.jinja" import tomcat with context %}
{% set tomcat_java_home = tomcat.java_home %}
{% set tomcat_java_opts = tomcat.java_opts %}

tomcat package installed and service running:
  pkg.installed:
    - name: {{ tomcat.pkg }}
    {% if tomcat.version is defined %}
    - version: {{ tomcat.version }}
    {% endif %}
  {%- if grains.os == 'MacOS' %}
   #Register as Launchd LaunchAgent for users
    - require_in:
      - file: tomcat package installed and service running
  file.managed:
    - name: /Library/LaunchAgents/{{ tomcat.service }}.plist
    - source: /usr/local/opt/tomcat/{{ tomcat.service }}.plist
    - group: wheel
    - require_in:
      - cmd: tomcat package installed and service running
  cmd.run:
    - name: brew unlink tomcat && brew link tomcat
    - runas: {{ tomcat.user }}
    - unless: test -f /usr/local/opt/tomcat/{{ tomcat.service }}.plist
  {% endif %}
  service.running:
    - name: {{ tomcat.service }}
    - enable: {{ tomcat.service_enabled }}
    - watch:
      - pkg: tomcat package installed and service running
# To install haveged on centos you need the EPEL repository. There is no haveged in MacOS
{% if tomcat.with_haveged and grains.os != 'MacOS' %}
  require:
    - pkg: tomcat haveged package installed and service running

tomcat haveged package installed and service running:
  pkg.installed:
    - name: haveged
  service.running:
    - enable: {{ tomcat.haveged_enabled }}
    - watch:
       - pkg: tomcat haveged package installed and service running
{% endif %}

tomcat init whats tomcat status:
  cmd.run:
  - name: systemctl status {{ tomcat.service }}
  - onfail:
    - service: tomcat package installed and service running

