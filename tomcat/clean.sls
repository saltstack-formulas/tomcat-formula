{% from "tomcat/map.jinja" import tomcat with context %}

tomcat stop services and clean packages:
  service.dead:
    - names:
      - {{ tomcat.service }}
      - haveged
    - unless: {{ grains.os == 'MacOS' and tomcat.ver|int < 9 }}   ####no macOS plist file for tomcat9
  pkg.purged:
    - names:
      - {{ tomcat.manager_pkg }}
      - {{ tomcat.native_pkg }}
      - {{ tomcat.common_pkg }}
      - libtomcat{{ tomcat.ver }}
      - libtomcat{{ tomcat.ver }}-java
      - {{ tomcat.pkg }}
      - haveged
  file.absent:
    - names:
      - /usr/local/opt/tomcat
      - /usr/local/opt/tomcat{{ tomcat.ver }}
      - /usr/local/opt/tomcat{{ tomcat.ver }}-admin
      - /usr/local/opt/tomcat{{ tomcat.ver }}-common
      - /usr/local/opt/tomcat{{ tomcat.ver|int -1 }}
      - /usr/local/opt/tomcat{{ tomcat.ver|int -1 }}-admin
      - /usr/local/opt/tomcat{{ tomcat.ver|int -1 }}-common
      - /usr/share/tomcat{{ tomcat.ver }}
      - /usr/share/tomcat{{ tomcat.ver }}-admin
      - /usr/share/tomcat{{ tomcat.ver }}-common
      - /usr/share/tomcat{{ tomcat.ver|int -1 }}
      - /usr/share/tomcat{{ tomcat.ver|int -1 }}-admin
      - /usr/share/tomcat{{ tomcat.ver|int -1 }}-common
