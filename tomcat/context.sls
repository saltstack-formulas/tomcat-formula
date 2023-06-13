{% from "tomcat/map.jinja" import tomcat with context %}

include:
  - tomcat

{% if tomcat.get('sites', False) %}

# Tomcat fails if pillar-defined webapps are not deployed yet.
# Create the missing 'appBase' directories so Tomcat works!

    {% for id, data in tomcat.get('sites', {}).items() %}
      {% for k, v in data.items() %}
        {% if k == 'appBase' %}
tomcat {{ tomcat.catalina_home }}/{{ data['appBase'] }}:
  file.directory:
    - name: {{ tomcat.catalina_home }}/{{ data['appBase'] }}
   {% if grains.os != 'MacOS' %}
    # Inherit logged-on user permissions on Darwin
    - user: root
    - group: {{ tomcat.group }}
   {% endif %}
    - mode: 775
    - makedirs: True
    - require_in:
      - file: tomcat {{ tomcat.conf_dir }}/context.xml

          {% if tomcat.catalina_base != tomcat.catalina_home %}
# Tomcat fails if pillar-defined appBase are not deployed yet.
# Create the missing 'appBase' directories so Tomcat works!
tomcat {{ tomcat.catalina_base }}/{{ data['appBase'] }}:
  file.directory:
    - name: {{ tomcat.catalina_base }}/{{ data['appBase'] }}
   {% if grains.os != 'MacOS' %}
    #Inherit logged-on user permissions on Darwin
    - user: {{ tomcat.user }}
    - group: {{ tomcat.group }}
   {% endif %}
    - mode: 775
    - makedirs: True
    - require_in:
      - file: tomcat {{ tomcat.conf_dir }}/context.xml
          {% endif %}

        {% endif %}
      {% endfor %}
    {% endfor %}
{% endif %}

{% if tomcat.get('context', False) %}
tomcat {{ tomcat.conf_dir }}/context.xml:
  file.managed:
    - name: {{ tomcat.conf_dir }}/context.xml
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
      - pkg: tomcat package installed and service running
    - require_in:
      - service: tomcat package installed and service running
    - watch_in:
      - service: tomcat package installed and service running

{% endif %}

{% if tomcat.get('other_contexts', False) %}

#Target directory for 'other-contexts.xml' must exist.
tomcat {{ tomcat.conf_dir }}/Catalina/localhost:
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
tomcat {{ tomcat.conf_dir }}/Catalina/localhost/{{ data.get('context', label) }}.xml:
  file.managed:
    - name: {{ tomcat.conf_dir }}/Catalina/localhost/{{ data.get('context', label) }}.xml
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
      - pkg: tomcat package installed and service running
      - file: {{ tomcat.conf_dir }}/Catalina/localhost
    - require_in:
      - service: tomcat package installed and service running
    - watch_in:
      - service: tomcat package installed and service running
  {% endfor %}
{% endif %}
