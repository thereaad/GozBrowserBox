# /etc/gbb/manifests/localbrowser.pp
#

Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }

import "/etc/gbb/manifests/classes/*"

include basesettings
include googlechrome
include ssh
include ratpoison

exec { '/usr/lib/lightdm/lightdm-set-defaults -s browser -m false -l false':
    require		=> File['/usr/share/xsessions'],
    unless		=> [ "test `cat /etc/lightdm/lightdm.conf | grep 'user-session=browser'` && test `cat /etc/lightdm/lightdm.conf | grep 'allow-guest=false'` && test `cat /etc/lightdm/lightdm.conf | grep 'greeter-show-manual-login=false'`"]
}

file { '/usr/share/xsessions':
    ensure          => directory,
    recurse          => true,
    purge           => true,
    force           => true,
    owner           => "root",
    group           => "root",
    mode            => 755,
    source          => "/etc/gbb/files/localbrowserxsessions",
}