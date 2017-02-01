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


