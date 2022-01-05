#!/bin/bash
mirrorlinks=("https://alpha.de.repo.voidlinux.org/" "https://repo-fi.voidlinux.org/" "https://mirrors.servercentral.com/voidlinux/" "https://repo-us.voidlinux.org/" "https://mirror.ps.kz/voidlinux/" "https://mirrors.bfsu.edu.cn/voidlinux/" "https://mirrors.cnnic.cn/voidlinux/" "https://mirrors.tuna.tsinghua.edu.cn/voidlinux/" "https://mirror.sjtu.edu.cn/voidlinux/" "https://void.webconverger.org/" "https://mirror.aarnet.edu.au/pub/voidlinux/" "https://ftp.swin.edu.au/voidlinux/" "https://void.cijber.net/" "http://ftp.dk.xemacs.org/voidlinux/" "https://mirrors.dotsrc.org/voidlinux/" "https://quantum-mirror.hu/mirrors/pub/voidlinux/" "https://voidlinux.mirror.garr.it" "https://mirror.fit.cvut.cz/voidlinux/" "http://ftp.debian.ru/mirrors/voidlinux/" "https://mirror.yandex.ru/mirrors/voidlinux/" "https://cdimage.debian.org/mirror/voidlinux/" "https://ftp.acc.umu.se/mirror/voidlinux/" "https://ftp.lysator.liu.se/pub/voidlinux/" "https://ftp.sunet.se/mirror/voidlinux/" "https://void.sakamoto.pl/" "https://mirror.clarkson.edu/voidlinux/")
mirrors=("alpha.de.repo.voidlinux.org" "repo-fi.voidlinux.org" "mirrors.servercentral.com" "repo-us.voidlinux.org" "mirror.ps.kz" "mirrors.bfsu.edu.cn" "mirrors.cnnic.cn" "mirrors.tuna.tsinghua.edu.cn" "mirror.sjtu.edu.cn" "void.webconverger.org" "mirror.aarnet.edu.au" "ftp.swin.edu.au" "void.cijber.net" "ftp.dk.xemacs.org" "mirrors.dotsrc.org" "quantum-mirror.hu" "voidlinux.mirror.garr.it" "mirror.fit.cvut.cz" "ftp.debian.ru" "mirror.yandex.ru" "cdimage.debian.org" "ftp.acc.umu.se" "ftp.lysator.liu.se" "ftp.sunet.se" "void.sakamoto.pl" "mirror.clarkson.edu")
a=$(ping -c 1 ${mirrors[0]} | grep "rtt" | cut -d / -f 5 | cut -d . -f 1)
for i in ${!mirrors[@]}
do
b=$(ping -c 1  ${mirrors[$i]} | grep "rtt" | cut -d / -f 5 | cut -d . -f 1)
if [[ -z "$b" ]]
then
echo "${mirrors[$i]}: down"
continue
fi
echo "${mirrors[$i]}: ${b}ms"
if [[ $b -lt $a ]]
then
a=$b
mirror=${mirrors[$i]}
index=$i
fi
done
echo $a
echo $mirror
repository=${mirrorlinks[$index]}
if [[ ! -d "/etc/xbps.d/" ]]
then
sudo mkdir -p /etc/xbps.d
fi
if [[ -f "/etc/xbps.d/*-repository-*.conf" ]]
then
sudo cp /usr/share/xbps.d/*-repository-*.conf /etc/xbps.d/
fi
sudo sed -i 's|https://alpha.de.repo.voidlinux.org|$repository|g' /etc/xbps.d/*-repository-*.conf
