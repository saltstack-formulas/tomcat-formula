{% from "tomcat/map.jinja" import tomcat with context %}

{{ tomcat.postgresql-jdbc }}:
  pkg:
    - installed

/usr/share/{{ tomcat.name }}{{ tomcat.version }}/lib/{{ tomcat.postgresql-jar }}:
    file.symlink:
        - target: /usr/share/java/{{ tomcat.postgresql-jar }}
