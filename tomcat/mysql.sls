{% from "tomcat/map.jinja" import tomcat with context %}

{{ tomcat.mysql-jdbc }}:
  pkg:
    - installed

/usr/share/{{ tomcat.name }}{{ tomcat.version }}/lib/{{ tomcat.mysql-jar }}:
    file.symlink:
        - target: /usr/share/java/{{ tomcat.mysql-jar }}
