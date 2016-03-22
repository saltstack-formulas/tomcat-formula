{% from "tomcat/map.jinja" import tomcat with context %}

{{ tomcat.name }}{{ tomcat.version }}:
  pkg:
    - installed
  service:
    - running
    - watch:
      - pkg: {{ tomcat.name }}{{ tomcat.version }}
      - file: tomcat_conf

{% if grains.os == 'Arch' %}
tomcat_env:
  file.managed:
    - name: /etc/conf.d/{{ tomcat.name }}{{ tomcat.version }}
{% endif %}

tomcat_conf:
  file.append:
    {% if grains.os == 'FreeBSD' %}
    - name: /etc/rc.conf
    - text:
      - tomcat{{ tomcat.version }}_java_home="{{ salt['pillar.get']('java:home', '/usr') }}"
      - tomcat{{ tomcat.version }}_java_opts="-Djava.awt.headless=true -Xmx{{ salt['pillar.get']('java:Xmx', '3G') }} -XX:MaxPermSize={{ salt['pillar.get']('java:MaxPermSize', '256m') }}"
    {% elif grains.os == 'Arch' %}
    - name: /etc/conf.d/{{ tomcat.name }}{{ tomcat.version }}
    - text:
      - JAVA_HOME={{ salt['pillar.get']('java:home', '/usr/lib/jvm/java-7-openjdk') }}
      - JAVA_OPTS="-Djava.awt.headless=true -Xmx{{ salt['pillar.get']('java:Xmx', '3G') }} -XX:MaxPermSize={{ salt['pillar.get']('java:MaxPermSize', '256m') }}"
      {% if salt['pillar.get']('java:UseConcMarkSweepGC') %}
      - JAVA_OPTS="$JAVA_OPTS {{ salt['pillar.get']('java:UseConcMarkSweepGC') }}"
      {% endif %}
      {% if salt['pillar.get']('java:CMSIncrementalMode') %}
      - JAVA_OPTS="$JAVA_OPTS {{ salt['pillar.get']('java:CMSIncrementalMode') }}"
      {% endif %}
      {% if salt['pillar.get']('tomcat:security') %}
      - TOMCAT{{ tomcat.version }}_SECURITY={{ salt['pillar.get']('tomcat:security', 'no') }}
      {% endif %}
    - require:
      - file: tomcat_env
    {% else %}
    - name: /etc/default/tomcat{{ tomcat.version }}
    - text:
      - JAVA_HOME={{ salt['pillar.get']('java:home', '/usr') }}
      - JAVA_OPTS="-Djava.awt.headless=true -Xmx{{ salt['pillar.get']('java:Xmx', '3G') }} -XX:MaxPermSize={{ salt['pillar.get']('java:MaxPermSize', '256m') }}"
      {% if salt['pillar.get']('java:UseConcMarkSweepGC') %}
      - JAVA_OPTS="$JAVA_OPTS {{ salt['pillar.get']('java:UseConcMarkSweepGC') }}"
      {% endif %}
      {% if salt['pillar.get']('java:CMSIncrementalMode') %}
      - JAVA_OPTS="$JAVA_OPTS {{ salt['pillar.get']('java:CMSIncrementalMode') }}"
      {% endif %}
      {% if salt['pillar.get']('java:log4jconfig') %}
      - JAVA_OPTS="$JAVA_OPTS -Dlog4j.configuration=file:{{ salt['pillar.get']('java:log4jconfig') }}"
      {% endif %}
      {% if salt['pillar.get']('tomcat:security') %}
      - TOMCAT{{ tomcat.version }}_SECURITY={{ salt['pillar.get']('tomcat:security', 'no') }}
      {% endif %}
    {% endif %}

{% if grains.os != 'FreeBSD' %}
limits_conf:
  file.append:
    - name: /etc/security/limits.conf
    - text:
      - {{ tomcat.name }}{{ tomcat.version }} soft nofile {{ salt['pillar.get']('limit:soft', '64000') }}
      - {{ tomcat.name }}{{ tomcat.version }} hard nofile {{ salt['pillar.get']('limit:hard', '64000') }}
{% endif %}
