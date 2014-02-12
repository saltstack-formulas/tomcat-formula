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
    - name: /etc/rc.conf
    - text:
      - tomcat{{ tomcat.version }}_java_home="{{ salt['pillar.get']('java:home', '/usr') }}"
      - tomcat{{ tomcat.version }}_java_opts="-Djava.awt.headless=true -Xmx{{ salt['pillar.get']('java:Xmx', '3G') }} -XX:MaxPermSize={{ salt['pillar.get']('java:MaxPermSize', '256m') }}"
    {% else %}
    - name: /etc/default/tomcat{{ tomcat.version }}
    - text:
      - JAVA_HOME={{ salt['pillar.get']('java:home', '/usr') }}
      - JAVA_OPTS="-Djava.awt.headless=true -Xmx{{ salt['pillar.get']('java:Xmx', '3G') }} -XX:MaxPermSize={{ salt['pillar.get']('java:MaxPermSize', '256m') }}"
    {% endif %}

{% if grains.os != 'FreeBSD' %}
limits_conf:
  file.append:
    - name: /etc/security/limits.conf
    - text:
      - {{ tomcat.name }}{{ tomcat.version }} soft nofile {{ salt['pillar.get']('limit:soft', '64000') }}
      - {{ tomcat.name }}{{ tomcat.version }} hard nofile {{ salt['pillar.get']('limit:hard', '64000') }}
{% endif %}
