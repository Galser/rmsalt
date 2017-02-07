{% set mysqlserver = salt['grains.filter_by']({
    'Debian': {'pkg': 'mysql-server', 'srv': 'mysql', 'config_path' : '/etc/mysql/my.cnf', 'config_name' : 'ubuntu' },
    'RedHat': { 'pkg': 'mysql-server', 'srv': 'mysql', 'config_path' : '/etc/my.cnf', 'config_name' : 'redhat'},
}, default='Debian') %}

MySQL-Server:
  pkg.installed:
    - name: {{ mysqlserver.pkg }}
  service.running:
    - name: {{ mysqlserver.srv }}
    - watch:
      - pkg: MySQL-Server
      - file: MySQL_config


MySQL_config:
  file.managed:
    - name: {{ mysqlserver.config_path }}
    - source: salt://mysqlserver/files/{{ mysqlserver.config_name }}.cnf
    - user: root
    - group: root
    - mode: 644
