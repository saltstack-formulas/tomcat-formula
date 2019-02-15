{% from "tomcat/map.jinja" import tomcat with context %}

tomcat clean packages:
  file.absent:
    - names:
      - /usr/local/opt/tomcat
  pkg.removed:
    - names:
      - {{ tomcat.native_pkg }}
      - {{ tomcat.pkg }}
      - haveged

