#! /bin/bash -e

REALM=EXAMPLE.COM

if [ ! -f /etc/krb5kdc/principal ]; then
	cat > /etc/krb5.conf <<EOF
[libdefaults]
    default_realm = $REALM

[realms]
    $REALM = {
        kdc = `hostname -f`
        admin_server = `hostname -f`
    }
EOF

	touch pass.txt
	chmod 0600 pass.txt

	# master key
	pass="`dd if=/dev/random bs=1 count=15 2>/dev/null | base64`"
	echo "K/M@${REALM} $pass" >> pass.txt
	(echo "$pass"; echo "$pass") | kdb5_util create -r $REALM -s

	# admin
	echo "ank -randkey admin/admin@$REALM" | kadmin.local -r $REALM
	echo "ktadd -k /etc/tomcat8/idm.keytab admin/admin@$REALM" | kadmin.local -r $REALM
	chmod 0640 /etc/tomcat8/idm.keytab
	chown :tomcat8 /etc/tomcat8/idm.keytab
fi

service krb5-admin-server start
service krb5-kdc start

. /docker-entry-base.sh
