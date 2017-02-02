# Default tools and mini-tools 

sys.packages:
  pkg.installed:
    - pkgs:
      - htop
      - multitail
      - colortail
      - iftop
      - iotop
      - mc
# yep no fun, sometimes it is usefull
      - tcpdump
      - screen
      - pbzip2

# --- atop
atop:
  pkg:
    - installed
  service:
    - running
    - watch:
      - pkg: atop
      - file: /etc/default/atop

/etc/default/atop:
  file:
    - managed
    - source: salt://tools/files/atop
    - user: root
    - group: root
    - mode: 644

# --- postfix
postfix:
  pkg:
   - installed
  service:
   - running
   - watch:
      - pkg: postfix
      - file: /etc/postfix/main.cf

/etc/postfix/main.cf:
  file:
    - managed
    - source: salt://tools/files/postfix_main_cf
    - user: root
    - group: root
    - mode: 644

