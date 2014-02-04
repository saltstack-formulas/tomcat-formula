{% from "tomcat/map.jinja" import tomcat with context %}

{{ tomcat.mysql }}:
  pkg:
    - installed

/usr/share/{{ tomcat.name }}{{ tomcat.version }}/lib/{{ tomcat.mysql_jdbc }}:
    file.symlink:
        - target: /usr/share/java/{{ tomcat.mysql_jdbc }}
