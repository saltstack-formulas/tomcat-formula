{% from "tomcat/map.jinja" import tomcat with context %}
{% set tomcat_java_home = tomcat.java_home %}
{% set tomcat_java_opts = tomcat.java_opts %}

    {%- if grains.os == 'MacOS' %}
tomcat ensure keg is linked on macos if already installed:
  cmd.run:
    - names:
      - /usr/local/bin/brew unlink tomcat || True
      - /usr/local/bin/brew link tomcat || True
    - runas: {{ tomcat.user }}
    - require_in:
      - pkg: tomcat package installed and service running
    - onlyif:
      - test -d /usr/local/Cellar/tomcat
    {%- endif %}

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
  cmd.run:
    - names:
      - /usr/local/bin/brew unlink tomcat || True
      - /usr/local/bin/brew link tomcat || True
    - runas: {{ tomcat.user }}
    - unless: test -f /usr/local/opt/tomcat/{{ tomcat.service }}.plist
  file.managed:
    - name: /Library/LaunchAgents/{{ tomcat.service }}.plist
    - source: /usr/local/opt/tomcat/{{ tomcat.service }}.plist
    - group: wheel
    - onlyif: test -f /usr/local/opt/tomcat/{{ tomcat.service }}.plist
    - require_in:
      - cmd: tomcat package installed and service running
  {%- endif %}
  service.running:
    - onlyif: {{ tomcat.service_running }}    ##Set False for Travis CI
    - name: {{ tomcat.service }}
    - enable: {{ tomcat.service_enabled }}
    - watch:
      - pkg: tomcat package installed and service running
   {% if grains.os == 'MacOS' %}
    - unless: {{tomcat.ver|int > 8 }}         ##no plist file shipped with Tomcat9
   {% elif tomcat.with_haveged %}
         # To install haveged in centos you need the EPEL repository
         # There is no haveged in MacOS

tomcat haveged package installed and service running:
  pkg.installed:
    - name: haveged
  service.running:
    - name: haveged
    - enable: {{ tomcat.haveged_enabled }}
    - watch:
       - pkg: tomcat haveged package installed and service running
    - require_in:
       - service: tomcat package installed and service running 
   {% endif %}
