from fabric.api import *

env.hosts = [
          'marinedejean.site',
	  ]
env.user = "admin"
env.key_filename = '~/id_rsa22'

def pack(local_dir = '~/github'):
    local('tar czf %s.tar.gz -C %s %s' % (name, local_dir, name))

def deploy():
    put("~/index.html", "var/www/html")
    put("~twitter-clone.css", "var/www/html")

def hostname():
    run("hostname")
    
