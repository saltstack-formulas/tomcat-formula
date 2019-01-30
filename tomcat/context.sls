{% from "tomcat/map.jinja" import tomcat with context %}

include:
  - tomcat

{% if tomcat.get('sites', False) %}

#Tomcat fails if pillar-defined webapps are not deployed yet.
#Create the missing 'appBase' directories so Tomcat works!

    {% for id, data in tomcat.get('sites', {}).items() %}
      {% for k, v in data.items() %}
        {% if k == 'appBase' %}
{{ tomcat.catalina_home }}/webapps/{{ data['appBase'] }}:
  file.directory:
   {% if grains.os != 'MacOS' %}
    #Inherit logged-on user permissions on Darwin
    - user: root
    - group: {{ tomcat.group }}
   {% endif %}
    - mode: 775
    - makedirs: True
    - require_in:
      - file: {{ tomcat.conf_dir }}/context.xml
        {% endif %}
      {% endfor %}
    {% endfor %}
{% endif %}

{% if tomcat.get('context', False) %}
{{ tomcat.conf_dir }}/context.xml:
  file.managed:
    - source: salt://tomcat/files/context.xml
   {% if grains.os != 'MacOS' %}
    #Inherit logged-on user permissions on Darwin
    - user: root
    - group: {{ tomcat.group }}
   {% endif %}
    - mode: '640'
    - template: jinja
    - defaults:
      context_elements: {{ tomcat.get('context', {})|yaml }}
      context_params: {}
    - require:
      - pkg: tomcat
    - require_in:
      - service: tomcat
    - watch_in:
      - service: tomcat

{% endif %}

{% if tomcat.get('other_contexts', False) %}

#Target directory for 'other-contexts.xml' must exist.
{{ tomcat.conf_dir }}/Catalina/localhost:
  file.directory:
    - name: {{ tomcat.conf_dir }}/Catalina/localhost
   {% if grains.os != 'MacOS' %}
    #Inherit logged-on user permissions on Darwin
    - user: root
    - group: {{ tomcat.group }}
   {% endif %}
    - mode: 775
    - makedirs: True

  {% for label, data in tomcat.get('other_contexts', {}).items() %}
{{ tomcat.conf_dir }}/Catalina/localhost/{{ data.get('context', label) }}.xml:
  file.managed:
    - source: salt://tomcat/files/context.xml
   {% if grains.os != 'MacOS' %}
    #Inherit logged-on user permissions on Darwin
    - user: root
    - group: {{ tomcat.group }}
   {% endif %}
    - mode: '640'
    - template: jinja
    - defaults:
      context_elements: {{ data.get('elements', {})|yaml }}
      context_params: {{ data.get('params', {})|yaml }}
    - require:
      - pkg: tomcat
      - file: {{ tomcat.conf_dir }}/Catalina/localhost
    - require_in:
      - service: tomcat
    - watch_in:
      - service: tomcat
  {% endfor %}
{% endif %}
