{% from "tomcat/map.jinja" import tomcat with context %}

tomcat stop services and clean packages:
  service.dead:
    - names:
      - {{ tomcat.service }}
      - haveged
    - unless: {{ grains.os == 'MacOS' and tomcat.ver|int < 9 }}   ####no macOS plist file for tomcat9
  file.absent:
    - names:
      - /usr/local/opt/tomcat
  pkg.removed:
    - names:
      - {{ tomcat.native_pkg }}
      - {{ tomcat.pkg }}
      - haveged
