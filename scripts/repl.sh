# recursive edit
# apt install rpl
#
rpl -R  "image::" "image::" .
rpl -R  ":imagesdir: /images" ":imagesdir: /images" .
rpl -R  "link:/docs" "link:/docs" .
rpl -R  "http://wiki.linuxcnc.org/" "http://wiki.linuxcnc.org/" .
