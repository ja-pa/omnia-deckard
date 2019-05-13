#!/bin/bash

if [ -z "$IP" ]; then
	IP=192.168.1.1
fi

if [ -f ".ssh_passwd" ]; then
	echo "Copy files to $IP"
	sshpass -f .ssh_passwd	ssh root@$IP 'mkdir -p /usr/lib/lua/luci/controller/dns-diagnostics'
	sshpass -f .ssh_passwd	ssh root@$IP 'mkdir -p /usr/lib/lua/luci/view/dns-diagnostics'
	sshpass -f .ssh_passwd	ssh root@$IP 'mkdir -p /usr/lib/lua/luci/model/cbi/dns-diagnostics'
	sshpass -f .ssh_passwd  ssh root@$IP 'mkdir -p /usr/libexec/rpcd/'

	sshpass -f .ssh_passwd scp src/new_tab.lua root@$IP:/usr/lib/lua/luci/controller/dns-diagnostics/
	sshpass -f .ssh_passwd scp src/view_tab.htm root@$IP:/usr/lib/lua/luci/view/dns-diagnostics/
	sshpass -f .ssh_passwd scp src/cbi_tab.lua root@$IP:/usr/lib/lua/luci/model/cbi/dns-diagnostics/
	sshpass -f .ssh_passwd scp src/cbi_file root@$IP:/etc/config/
	sshpass -f .ssh_passwd scp src/xml_parser.py root@$IP:/usr/libexec/rpcd/


	sshpass -f .ssh_passwd ssh root@$IP '/etc/init.d/lighttpd restart'
	echo "Copy done!"
else
	echo "Error - password file not found!"
	echo "Please make file .ssh_passwd with ssh password"
fi

