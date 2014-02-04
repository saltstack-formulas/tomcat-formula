{% from "tomcat/map.jinja" import tomcat with context %}

{{ tomcat.postgresql }}:
  pkg:
    - installed

/usr/share/{{ tomcat.name }}{{ tomcat.version }}/lib/{{ tomcat.postgresql_jdbc }}:
    file.symlink:
        - target: /usr/share/java/{{ tomcat.postgresql_jdbc }}
