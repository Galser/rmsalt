{% set apache = salt['grains.filter_by']({
    'Debian': {'pkg': 'apache2', 'srv': 'apache2', 'config_path' : '/etc/apache2/apache2.conf', 'modsec_pkg' : 'libapache2-modsecurity', 'config_name' : 'ubuntu' },
    'RedHat': {'pkg': 'httpd', 'srv': 'httpd', 'config_path ' : '/etc/http2/http2.conf', 'modsec_pkg' : 'mod_security', 'config_name' : 'redhat'},
}, default='Debian') %}
{% if 'modsec' in grains['roles'] %}
  {% set apache.config_name = apache.config_name+'_modsec' %}
{% endif %}
{% set apache.config_name = apache.config_name+'.conf' %}


Apache2:
  pkg.installed:
    - name: {{ apache.pkg }}
  service.running:
    - name: {{ apache.srv }}
    - watch:
      - pkg: Apache2
      - file: Apache2_config


Apache2_config:
  file.managed:
    - name: {{ apache.config_path }}
    - source: salt://apache2/files/{{ apache.config_name }}
    - user: root
    - group: root
    - mode: 644

{% if 'modsec' in grains['roles'] %}
Apache2 modsecurity:
  pkg.installed:
    - name : {{ apache.modsec_pkg }}

Enable mod_secure module:
  apache_module.enabled:
    - name: security2

Enable mod_headers module:
  apache_module.enabled:
    - name: headers
{% endif %}

