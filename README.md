# Info

Identity manager midPoint with [MIT Kerberos connector](https://github.com/CESNET/kerberos-connector) and local KDC server for testing.

More information: [https://github.com/valtri/docker-midpoint](https://github.com/valtri/docker-midpoint)

# Launch

    docker pull valtri/docker-midpoint-kerberos
    docker run -itd --name midpoint-kerberos valtri/docker-midpoint-kerberos

After midPoint launch, Kerberos resource needs to be "recomputed":

1. select "*Resources/List resources*"
2. select "*Edit XML*" on "*Kerberos*" resource settings
3. switch on "*Reevaluate search filters*"
4. click "*Save*"

"*Test connection*" in the Kerberos resource should work now.
