from fabric.api import env, cd, run, put

env.hosts = ['cloud01']

def upload():
    #run('mkdir /home/kveroneau/tech406/kdocs')
    #put('*.xsl', '/home/kveroneau/tech406/kdocs/')
    put('*.xml', '/home/kveroneau/tech406/kdocs/')
    #put('*.js', '/home/kveroneau/tech406/kdocs/')
    #put('Cardiac.png', '/home/kveroneau/tech406/kdocs/')
