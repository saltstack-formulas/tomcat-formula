{% from "tomcat/map.jinja" import tomcat with context %}

/etc/{{ tomcat.name }}{{ version }}/server.xml:
    file.managed:
        - source: salt://tomcat/files/server.xml
        - user: {{ tomcat.name }}{{ version }}
        - group: {{ tomcat.name }}{{ version }}
        - mode: 644
        - template: jinja
        - defaults:
            port: {{ salt['pillar.get']('tomcat:connector:port', 8080) }}
            protocol: {{ salt['pillar.get']('tomcat:connector:protocol', 'HTTP/1.1') }}
            connectionTimeout: {{ salt['pillar.get']('tomcat:connector:connectionTimeout', 20000) }}
            URIEncoding: {{ salt['pillar.get']('tomcat:connector:URIEncoding', 'UTF-8') }}
            redirectPort: {{ salt['pillar.get']('tomcat:connector:redirectPort', 8443) }}
            maxHttpHeaderSize: {{ salt['pillar.get']('tomcat:connector:maxHttpHeaderSize', 8192) }}
            maxThreads: {{ salt['pillar.get']('tomcat:connector:maxThreads', 150) }}
            minSpareThreads: {{ salt['pillar.get']('tomcat:connector:minSpareThreads', 25) }}
            maxSpareThreads: {{ salt['pillar.get']('tomcat:connector:maxSpareThreads', 75) }}
            enableLookups: {{ salt['pillar.get']('tomcat:connector:enableLookups', 'false') }}
            disableUploadTimeout: {{ salt['pillar.get']('tomcat:connector:disableUploadTimeout', 'true') }}
            acceptCount: {{ salt['pillar.get']('tomcat:connector:acceptCount', 100) }}
            scheme: {{ salt['pillar.get']('tomcat:connector:scheme', 'http') }}
            {% if salt['pillar.get']('tomcat:connector:SSLEnabled') %}
            secure: {{ salt['pillar.get']('tomcat:connector:secure') }}
            SSLEnabled: {{ salt['pillar.get']('tomcat:connector:SSLEnabled') }}
            clientAuth: {{ salt['pillar.get']('tomcat:connector:clientAuth', 'false') }}
            sslProtocol: {{ salt['pillar.get']('tomcat:connector:sslProtocol', 'TLS') }}
            keyAlias: {{ salt['pillar.get']('tomcat:connector:keyAlias') }}
            keystoreFile: {{ salt['pillar.get']('tomcat:connector:keystoreFile') }}
            keypass: {{ salt['pillar.get']('tomcat:connector:keypass', '') }}
            {% endif %}

