{% from "tomcat/map.jinja" import tomcat with context %}

{{ tomcat.name }}{{ tomcat.version }}:
  pkg:
    - installed
  service:
    - running
    - watch:
      - pkg: {{ tomcat.name }}{{ tomcat.version }}
      - file.append: tomcat_conf
tomcat_conf:
  file.append:
    - name: /etc/default/tomcat{{ tomcat.version }}
    - text: export JAVA_HOME={{ pillar.get('java_home', '/usr') }}
