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
    {% if grains.os == 'FreeBSD' %}
    - name: /usr/local/apache-tomcat-{{tomcat.version}}.0
    {% else %}
    - name: /etc/default/tomcat{{ tomcat.version }}
    {% endif %}
    - text:
      - JAVA_HOME={{ pillar.get('java_home', '/usr') }}
      - JAVA_OPTS="-Djava.awt.headless=true -Xmx{{ pillar.get('java_opt_Xmx', '3G') }} -XX:MaxPermSize={{ pillar.get('java_opt_MaxPermSize', '256m') }}"

limits_conf:
  file.append:
    - name: /etc/security/limits.conf
    - text:
      - soft: {{ tomcat.name }}{{ tomcat.version }} soft nofile {{ pillar.get('limit', '64000') }}
      - hard: {{ tomcat.name }}{{ tomcat.version }} hard nofile {{ pillar.get('limit', '64000') }}
