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
      - tomcat{{ tomcat.version }}_java_home="{{ pillar.get('java_home') }}"
      - tomcat{{ tomcat.version }}_java_opts="-Djava.awt.headless=true -Xmx{{ pillar.get('java_opt_Xmx', '3G') }} -XX:MaxPermSize={{ pillar.get('java_opt_MaxPermSize', '256m') }}"
    {% else %}
    - name: /etc/default/tomcat{{ tomcat.version }}
    - text:
      - JAVA_HOME={{ pillar.get('java_home', '/usr') }}
      - JAVA_OPTS="-Djava.awt.headless=true -Xmx{{ pillar.get('java_opt_Xmx', '3G') }} -XX:MaxPermSize={{ pillar.get('java_opt_MaxPermSize', '256m') }}"
    {% endif %}

{% if grains.os != 'FreeBSD' %}
limits_conf:
  file.append:
    - name: /etc/security/limits.conf
    - text:
      - {{ tomcat.name }}{{ tomcat.version }} soft nofile {{ pillar.get('soft_limit', '64000') }}
      - {{ tomcat.name }}{{ tomcat.version }} hard nofile {{ pillar.get('hard_limit', '64000') }}
{% endif %}
