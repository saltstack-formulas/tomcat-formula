{% from "tomcat/map.jinja" import tomcat with context %}

{{ tomcat.name }}{{ tomcat.version }}:
  pkg:
    - installed
  service:
    - running
    - watch:
      - pkg: {{ tomcat.name }}{{ tomcat.version }}
      - ini_manage: /etc/default/{{ tomcat.name }}{{ tomcat.version }}
/etc/default/{{ tomcat.name }}{{ tomcat.version }}:
  file:
    - exists
    - require:
      - pkg: {{ tomcat.name }}{{ tomcat.version }}
  ini_manage:
    - options_present
    - sections:
        DEFAULT_IMPLICIT:
          JAVA_HOME: {{ pillar.get('java_home', '/usr') }}
    - require:
        - file: '/etc/default/{{ tomcat.name }}{{ tomcat.version }}'