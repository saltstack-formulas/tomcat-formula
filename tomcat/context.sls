{% from "tomcat/map.jinja" import tomcat with context %}

include:
  - tomcat

{% if tomcat.get('context', False) %}
{{ tomcat.conf_dir }}/context.xml:
  file.managed:
    - source: salt://tomcat/files/context.xml
    - user: root
    - group: {{ tomcat.group }}
    - mode: '640'
    - template: jinja
    - defaults:
      context_elements: {{ tomcat.get('context', {}) }}
      context_params: {}
    - require:
      - pkg: tomcat
    - require_in:
      - service: tomcat
    - watch_in:
      - service: tomcat
{% endif %}

{% for label, data in tomcat.get('other_contexts', {}).items() %}
{{ tomcat.conf_dir }}/Catalina/localhost/{{ data.get('context', label) }}.xml:
  file.managed:
    - source: salt://tomcat/files/context.xml
    - user: root
    - group: {{ tomcat.group }}
    - mode: '640'
    - template: jinja
    - defaults:
      context_elements: {{ data.get('elements', {}) }}
      context_params: {{ data.get('params', {}) }}
    - require:
      - pkg: tomcat
    - require_in:
      - service: tomcat
    - watch_in:
      - service: tomcat
{% endfor %}
