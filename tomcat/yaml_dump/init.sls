# -*- coding: utf-8 -*-
# vim: ft=sls
---
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import tomcat as map with context %}

{%- set output_file = '/tmp/salt_yaml_dump.yaml' %}

yaml-dump-{{ tplroot }}:
  file.managed:
    - name: {{ output_file }}
    - source: salt://{{ tplroot }}/yaml_dump/yaml_dump.jinja
    - template: jinja
    - context:
        map: {{ map | yaml }}
