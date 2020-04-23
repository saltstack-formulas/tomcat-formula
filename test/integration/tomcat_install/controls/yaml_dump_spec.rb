# frozen_string_literal: true

control 'Tomcat `map.jinja` YAML dump' do
  title 'should contain the lines'

  yaml_dump = "---\n"
  yaml_dump +=
    case platform[:family]
    when 'debian'
      case platform[:release]
      when /^10/
        conf_dir = '/etc/tomcat9'
        group = 'tomcat'
        main_config = '/etc/default/tomcat9'
        manager_pkg = 'tomcat9-admin'
        pkg = 'tomcat9'
        service = 'tomcat9'
        user = 'tomcat'
        ver = 9
        catalina_base = '/var/lib/tomcat9'
        catalina_home = '/usr/share/tomcat9'
        catalina_pid = '/var/run/tomcat9.pid'
        catalina_tmpdir = '/var/cache/tomcat9/temp'
      else
        conf_dir = '/etc/tomcat8'
        group = 'tomcat8'
        main_config = '/etc/default/tomcat8'
        manager_pkg = 'tomcat8-admin'
        pkg = 'tomcat8'
        service = 'tomcat8'
        user = 'tomcat8'
        ver = 8
        catalina_base = '/var/lib/tomcat8'
        catalina_home = '/usr/share/tomcat8'
        catalina_pid = '/var/run/tomcat8.pid'
        catalina_tmpdir = '/var/cache/tomcat8/temp'
      end
      <<~YAML_DUMP.chomp
        arch: amd64
        authbind: 'no'
        catalina_base: #{catalina_base}
        catalina_home: #{catalina_home}
        catalina_pid: #{catalina_pid}
        catalina_tmpdir: #{catalina_tmpdir}
        cluster:
          simple: true
        conf_dir: #{conf_dir}
        connectors:
          example_connector:
            port: 8443
            protocol: org.apache.coyote.http11.Http11Protocol
            connectionTimeout: 20000
            URIEncoding: UTF-8
            redirectPort: 8443
            maxHttpHeaderSize: 8192
            maxThreads: 150
            minSpareThreads: 25
            enableLookups: 'false'
            disableUploadTimeout: 'true'
            acceptCount: 100
            scheme: https
            secure: 'true'
            clientAuth: 'false'
            sslProtocol: TLS
            SSLEnabled: 'false'
            keystoreFile: /path/to/keystoreFile
            keystorePass: somerandomtext
        context:
          Environment:
            env.first:
              name: env.first
              value: first.text
              type: java.lang.String
              override: true
            env.second:
              name: env.second
              value: second.value
              type: some.other.type
              override: false
          Listener:
            first:
              className: org.apache.catalina.security.SecurityListener
            second:
              className: org.apache.catalina.core.AprLifecycleListener
              SSLEngine: 'on'
          Resource:
            jdbc:
              name: jdbc/__postgres
              auth: Container
              type: javax.sql.DataSource
              driverClassName: org.postgresql.Driver
              url: jdbc:postgresql://db.server/dbname
              user: dbuser
              password: aycaramba!
              maxActive: 20
              maxIdle: 10
              maxWait: -1
          ResourceLink:
            any_name_here_will_be_ignored:
              name: linkToGlobalResource
              global: simpleValue
              type: java.lang.Integer
        expires_when: 2 weeks
        group: #{group}
        haveged_enabled: true
        id:
        - example.com
        - example.net
        java_home: /usr/lib/jvm/default-java
        java_opts:
        - Djava.awt.headless=true
        - Xmx128m
        - XX:MaxPermSize=256m
        - Dlog4j.configuration=file:/tmp/log4j.properties
        - Dlogback.configurationFile=/tmp/logback.xml
        jsp_compiler: javac
        jvm_tmp: /tmp/tomcat
        limit:
          hard: 64000
          soft: 64000
        logfile_compress: 1
        logfile_days: 14
        main_config: #{main_config}
        main_config_template: salt://tomcat/files/tomcat-default-Debian.template
        manager:
          roles:
          - manager-gui
          - manager-script
          - manager-jmx
          - manager-status
          users:
            saltuser1:
              passwd: RfgpE2iQwD
              roles: manager-gui,manager-script,manager-jmx,manager-status
            saltuser2:
              passwd: RfgpE2iQwD
              roles:
              - manager-gui
              - manager-script
              - manager-jmx
              - manager-status
        manager_pkg: #{manager_pkg}
        native_pkg: libtcnative-1
        other_contexts:
          other-contexts:
            params:
              docBase: /path/to/webapp
              debug: 1
              reloadable: 'true'
              crossContext: 'true'
            elements:
              Resource:
                jdbc:
                  name: jdbc/__postgres
                  auth: Container
                  type: javax.sql.DataSource
                  driverClassName: org.postgresql.Driver
                  url: jdbc:postgresql://db.server/dbname
                  user: dbuser
                  password: aycaramba!
                  maxActive: 20
                  maxIdle: 10
                  maxWait: -1
              Resources:
                PostResources:
                  className: org.apache.catalina.webresources.DirResourceSet
                  base: /var/lib/tomcat8/appconfig
                  webAppMount: /WEB-INF/classes
        pkg: #{pkg}
        resources: {}
        security: 'no'
        service: #{service}
        service_enabled: true
        service_running: false
        sites:
          example.com:
            name: tomcat-server
            appBase: ../webapps/myapp
            path: ''
            docBase: ../webapps/myapp
            alias: www.example.com
            host_parameters:
              unpackWARs: 'true'
              autoDeploy: 'true'
              deployXML: 'false'
            reloadable: 'true'
            debug: 0
          example.net:
            appBase: ../webapps/myapp2
            path: ''
            docBase: ../webapps/myapp2
            alias: www.example.net
            host_parameters:
              unpackWARs: 'true'
              autoDeploy: 'true'
            reloadable: 'true'
            debug: 0
            valves:
            - className: org.apache.catalina.valves.AccessLogValve
              directory: logs
              prefix: localhost_access_log.
              fileDateFormat: yyyy-MM-dd-HH
              suffix: .log
              pattern: '%h %l %u %t &quot;%m http://%v%U %H&quot; %s %b &quot;%{Referer}i&quot;
                &quot;%{User-Agent}i&quot; %D'
            - className: org.apache.catalina.authenticator.SingleSignOn
        user: #{user}
        ver: #{ver}
        with_haveged: true
      YAML_DUMP
    when 'redhat', 'fedora'
      case platform[:family]
      when 'redhat'
        ver = 7
      when 'fedora'
        ver = 9
      end
      <<~YAML_DUMP.chomp
        arch: amd64
        authbind: 'no'
        catalina_base: /usr/share/tomcat
        catalina_home: /usr/share/tomcat
        catalina_pid: /var/run/tomcat.pid
        catalina_tmpdir: /var/cache/tomcat/temp
        cluster:
          simple: true
        conf_dir: /etc/tomcat
        connectors:
          example_connector:
            port: 8443
            protocol: org.apache.coyote.http11.Http11Protocol
            connectionTimeout: 20000
            URIEncoding: UTF-8
            redirectPort: 8443
            maxHttpHeaderSize: 8192
            maxThreads: 150
            minSpareThreads: 25
            enableLookups: 'false'
            disableUploadTimeout: 'true'
            acceptCount: 100
            scheme: https
            secure: 'true'
            clientAuth: 'false'
            sslProtocol: TLS
            SSLEnabled: 'false'
            keystoreFile: /path/to/keystoreFile
            keystorePass: somerandomtext
        context:
          Environment:
            env.first:
              name: env.first
              value: first.text
              type: java.lang.String
              override: true
            env.second:
              name: env.second
              value: second.value
              type: some.other.type
              override: false
          Listener:
            first:
              className: org.apache.catalina.security.SecurityListener
            second:
              className: org.apache.catalina.core.AprLifecycleListener
              SSLEngine: 'on'
          Resource:
            jdbc:
              name: jdbc/__postgres
              auth: Container
              type: javax.sql.DataSource
              driverClassName: org.postgresql.Driver
              url: jdbc:postgresql://db.server/dbname
              user: dbuser
              password: aycaramba!
              maxActive: 20
              maxIdle: 10
              maxWait: -1
          ResourceLink:
            any_name_here_will_be_ignored:
              name: linkToGlobalResource
              global: simpleValue
              type: java.lang.Integer
        expires_when: 2 weeks
        group: tomcat
        haveged_enabled: false
        id:
        - example.com
        - example.net
        java_home: /usr/lib/jvm/jre
        java_opts:
        - Djava.awt.headless=true
        - Xmx128m
        - XX:MaxPermSize=256m
        - Dlog4j.configuration=file:/tmp/log4j.properties
        - Dlogback.configurationFile=/tmp/logback.xml
        jsp_compiler: javac
        jvm_tmp: /tmp/tomcat
        limit:
          hard: 64000
          soft: 64000
        logfile_compress: 1
        logfile_days: 14
        main_config: /etc/sysconfig/tomcat
        main_config_template: salt://tomcat/files/tomcat-default-CentOS.template
        manager:
          roles:
          - manager-gui
          - manager-script
          - manager-jmx
          - manager-status
          users:
            saltuser1:
              passwd: RfgpE2iQwD
              roles: manager-gui,manager-script,manager-jmx,manager-status
            saltuser2:
              passwd: RfgpE2iQwD
              roles:
              - manager-gui
              - manager-script
              - manager-jmx
              - manager-status
        manager_pkg: tomcat-admin-webapps
        native_pkg: tomcat-native
        other_contexts:
          other-contexts:
            params:
              docBase: /path/to/webapp
              debug: 1
              reloadable: 'true'
              crossContext: 'true'
            elements:
              Resource:
                jdbc:
                  name: jdbc/__postgres
                  auth: Container
                  type: javax.sql.DataSource
                  driverClassName: org.postgresql.Driver
                  url: jdbc:postgresql://db.server/dbname
                  user: dbuser
                  password: aycaramba!
                  maxActive: 20
                  maxIdle: 10
                  maxWait: -1
              Resources:
                PostResources:
                  className: org.apache.catalina.webresources.DirResourceSet
                  base: /var/lib/tomcat8/appconfig
                  webAppMount: /WEB-INF/classes
        pkg: tomcat
        resources: {}
        security: 'no'
        service: tomcat
        service_enabled: true
        service_running: false
        sites:
          example.com:
            name: tomcat-server
            appBase: ../webapps/myapp
            path: ''
            docBase: ../webapps/myapp
            alias: www.example.com
            host_parameters:
              unpackWARs: 'true'
              autoDeploy: 'true'
              deployXML: 'false'
            reloadable: 'true'
            debug: 0
          example.net:
            appBase: ../webapps/myapp2
            path: ''
            docBase: ../webapps/myapp2
            alias: www.example.net
            host_parameters:
              unpackWARs: 'true'
              autoDeploy: 'true'
            reloadable: 'true'
            debug: 0
            valves:
            - className: org.apache.catalina.valves.AccessLogValve
              directory: logs
              prefix: localhost_access_log.
              fileDateFormat: yyyy-MM-dd-HH
              suffix: .log
              pattern: '%h %l %u %t &quot;%m http://%v%U %H&quot; %s %b &quot;%{Referer}i&quot;
                &quot;%{User-Agent}i&quot; %D'
            - className: org.apache.catalina.authenticator.SingleSignOn
        user: tomcat
        ver: #{ver}
        with_haveged: false
      YAML_DUMP
    when 'suse'
      <<~YAML_DUMP.chomp
        arch: amd64
        authbind: 'no'
        catalina_base: /usr/share/tomcat
        catalina_home: /usr/share/tomcat
        catalina_pid: /var/run/tomcat.pid
        catalina_tmpdir: /var/cache/tomcat/temp
        cluster:
          simple: true
        conf_dir: /etc/tomcat
        connectors:
          example_connector:
            port: 8443
            protocol: org.apache.coyote.http11.Http11Protocol
            connectionTimeout: 20000
            URIEncoding: UTF-8
            redirectPort: 8443
            maxHttpHeaderSize: 8192
            maxThreads: 150
            minSpareThreads: 25
            enableLookups: 'false'
            disableUploadTimeout: 'true'
            acceptCount: 100
            scheme: https
            secure: 'true'
            clientAuth: 'false'
            sslProtocol: TLS
            SSLEnabled: 'false'
            keystoreFile: /path/to/keystoreFile
            keystorePass: somerandomtext
        context:
          Environment:
            env.first:
              name: env.first
              value: first.text
              type: java.lang.String
              override: true
            env.second:
              name: env.second
              value: second.value
              type: some.other.type
              override: false
          Listener:
            first:
              className: org.apache.catalina.security.SecurityListener
            second:
              className: org.apache.catalina.core.AprLifecycleListener
              SSLEngine: 'on'
          Resource:
            jdbc:
              name: jdbc/__postgres
              auth: Container
              type: javax.sql.DataSource
              driverClassName: org.postgresql.Driver
              url: jdbc:postgresql://db.server/dbname
              user: dbuser
              password: aycaramba!
              maxActive: 20
              maxIdle: 10
              maxWait: -1
          ResourceLink:
            any_name_here_will_be_ignored:
              name: linkToGlobalResource
              global: simpleValue
              type: java.lang.Integer
        expires_when: 2 weeks
        group: tomcat
        haveged_enabled: false
        id:
        - example.com
        - example.net
        java_home: /usr/lib/jvm/jre
        java_opts:
        - Djava.awt.headless=true
        - Xmx128m
        - XX:MaxPermSize=256m
        - Dlog4j.configuration=file:/tmp/log4j.properties
        - Dlogback.configurationFile=/tmp/logback.xml
        jsp_compiler: javac
        jvm_tmp: /tmp/tomcat
        limit:
          hard: 64000
          soft: 64000
        logfile_compress: 1
        logfile_days: 14
        main_config: /etc/sysconfig/tomcat
        main_config_template: salt://tomcat/files/tomcat-default-CentOS.template
        manager:
          roles:
          - manager-gui
          - manager-script
          - manager-jmx
          - manager-status
          users:
            saltuser1:
              passwd: RfgpE2iQwD
              roles: manager-gui,manager-script,manager-jmx,manager-status
            saltuser2:
              passwd: RfgpE2iQwD
              roles:
              - manager-gui
              - manager-script
              - manager-jmx
              - manager-status
        manager_pkg: tomcat-admin-webapps
        native_pkg: libtcnative-1-0
        other_contexts:
          other-contexts:
            params:
              docBase: /path/to/webapp
              debug: 1
              reloadable: 'true'
              crossContext: 'true'
            elements:
              Resource:
                jdbc:
                  name: jdbc/__postgres
                  auth: Container
                  type: javax.sql.DataSource
                  driverClassName: org.postgresql.Driver
                  url: jdbc:postgresql://db.server/dbname
                  user: dbuser
                  password: aycaramba!
                  maxActive: 20
                  maxIdle: 10
                  maxWait: -1
              Resources:
                PostResources:
                  className: org.apache.catalina.webresources.DirResourceSet
                  base: /var/lib/tomcat8/appconfig
                  webAppMount: /WEB-INF/classes
        pkg: tomcat
        resources: {}
        security: 'no'
        service: tomcat
        service_enabled: true
        service_running: false
        sites:
          example.com:
            name: tomcat-server
            appBase: ../webapps/myapp
            path: ''
            docBase: ../webapps/myapp
            alias: www.example.com
            host_parameters:
              unpackWARs: 'true'
              autoDeploy: 'true'
              deployXML: 'false'
            reloadable: 'true'
            debug: 0
          example.net:
            appBase: ../webapps/myapp2
            path: ''
            docBase: ../webapps/myapp2
            alias: www.example.net
            host_parameters:
              unpackWARs: 'true'
              autoDeploy: 'true'
            reloadable: 'true'
            debug: 0
            valves:
            - className: org.apache.catalina.valves.AccessLogValve
              directory: logs
              prefix: localhost_access_log.
              fileDateFormat: yyyy-MM-dd-HH
              suffix: .log
              pattern: '%h %l %u %t &quot;%m http://%v%U %H&quot; %s %b &quot;%{Referer}i&quot;
                &quot;%{User-Agent}i&quot; %D'
            - className: org.apache.catalina.authenticator.SingleSignOn
        user: tomcat
        ver: 8
        with_haveged: false
      YAML_DUMP
    end

  describe file('/tmp/salt_yaml_dump.yaml') do
    its('content') { should include yaml_dump }
  end
end
