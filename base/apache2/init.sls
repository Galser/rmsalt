{% if grains['os'] == 'RedHat' %}
  {% set apache_name = 'httpd' %}
  {% set apache_config_name = 'redhat' %}
  {% set apache_config_path = '/etc/http2/http2.conf' %}
{% elif grains['os'] == 'Ubuntu' %}
  {% set apache_name = 'apache2' %}
  {% set apache_config_name = 'ubuntu' %}
  {% set apache_config_path = '/etc/apache2/apache2.conf' %}
{% endif %}
{% if 'modsec' in grains['roles'] %}
  {% set apache_config_name = apache_config_name+'_modsec' %}
{% endif %}
{% set apache_config_name = apache_config_name+'.conf' %}

apache2:
  pkg:
    - installed
  service:
    - running
    - watch:
      - pkg: apache2
      - file: Apache2_config

Apache2_config:
  file.managed:
    - name: {{ apache_config_path }}
    - source: salt://apache2/files/{{ apache_config_name }}
    - user: root
    - group: root
    - mode: 644


{% if 'modsec' in grains['roles'] %}
libapache2-modsecurity:
  pkg:
    - installed

Enable mod_secure module:
  apache_module.enabled:
    - name: security2

Enable mod_headers module:
  apache_module.enabled:
    - name: headers
{% endif %}

