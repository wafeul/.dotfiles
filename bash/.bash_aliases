#######   USEFULL COMMANDS   #######
alias dir='dir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ls='lsd'
alias ll='lsd -lhrth'
alias la='lsd -lhrtAh'


alias ps='ps -ceao ppid,pid,%cpu,%mem,bsdtime,user,pri,args'
alias mc='~/minio-binaries/mc'

#######   SERVERS CONNECTIONS   #######
alias sshInext='ssh -X rbourgeas@inext1.htx-inext.embl.fr'
alias sshInextcr='ssh -X crimsrobot@inext1.htx-inext.embl.fr'
alias sshProc1='ssh -X rbourgeas@htxproc1.htx-inext.embl.fr'
alias sshProc1cr='ssh -X crimsrobot@htxproc1.htx-inext.embl.fr'
alias sshrad='ssh -X root@raphaeldev.htx-web.embl.fr'
alias sshgd='ssh root@gaeldev.htx-web.embl.fr'
alias sshmplier='ssh hotline@crims.cbs.cnrs.fr'
alias sshtest2='ssh root@test2.htx-web.embl.fr'
alias sshtest1='ssh root@test1.htx-web.embl.fr'
alias sshhamb='ssh rbourgeas@guldan.embl-hamburg.de'
alias sshdt3='ssh datatransfer3.embl.fr'
#Heidelberg
alias sshdth='ssh -X rbourgeas@datatransfer.embl.de'
alias sshdph='ssh -X rbourgeas@login1.cluster.embl.de'
alias sshcrh='ssh -X root@itgr-crims01.embl.de'
alias sshcrhh='ssh -X rbourgeas@ithh-crims01.embl.de'

#######  OTHERS   #######
alias ifconfig='ip addr'


#######  DOCKER  #######

alias dxlw='docker exec -it ligands-backend bash'
alias dxldb='docker exec -it ligands-postgres bash'
alias dxdpw='docker exec -it dataproc-backend bash'
alias dxdpdb='docker exec -it dataproc-postgres bash'
alias dxbw='docker exec -it busterweb bash'
alias dxbdb='docker exec -it buster-db bash'
alias dxdmw='docker exec -it dataset_manager-backend bash'
alias dxdmdb='docker exec -it dataset_manager-postgres bash'
alias dxddw='docker exec -it dataset_downloader-backend bash'
alias dxdddb='docker exec -it dataset_downloader-postgres bash'
alias dxicw='docker exec -it ispyb_checker-backend bash'
alias dxicdb='docker exec -it ispyb_checker-postgres bash'
alias dxscw='docker exec -it sls_checkerweb bash'
alias dxscdb='docker exec -it sls_checkerdatabase bash'
alias dxhuw='docker exec -it hd_uploaderweb bash'
alias dxhudb='docker exec -it hd_uploaderdatabase bash'
alias dxcw='docker exec -it xtals-backend bash'
alias dxcdb='docker exec -it xtals-postgres bash'
alias dxaw='docker exec -it agility-backend bash'
alias dxadb='docker exec -it agility-postgres bash'
alias dxpw='docker exec -it passport-backend bash'
alias dxpdb='docker exec -it passport-postgres bash'
alias dxbpw='docker exec -it projects-backend bash'
alias dxbpdb='docker exec -it projects-postgres bash'
alias dxfw='docker exec -it lift-backend bash'
alias dxk='docker exec -it kong_kong_1 /bin/sh'
alias dxlnw='docker exec -it ligands-backend-neo4j sh'
alias dxndpw='docker exec -it dataproc-service bash'
alias dxhw='docker exec -it --user root hexagods bash'
alias dx='docker exec -it'

alias dup='docker compose up'
alias ddown='docker compose down --remove-orphans'
alias dc='docker compose'
alias dps='docker ps --format "table {{.ID}}\t{{.Command}}\t{{.RunningFor}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'
alias dpsi='docker ps --format "table {{.ID}}\t{{.Command}}\t{{.RunningFor}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}\t{{.Image}}"'


#######  PATHS    #######
alias cdSource='cd ~/Labo/Projects/CRIMS/Source'
alias cdib='cd ~/Labo/Projects/CRIMS/Source/images_builder'
alias cdGPhL='cd ~/Labo/Projects/CRIMS/Source/GPhL'
alias cdDev='cd /home/rbourgeas/Labo/Projects/CRIMS/Source/Dev'
alias cddm='cd ~/Labo/Projects/CRIMS/Source/Data_Manager/archiving-backend/data_manager'
alias cddd='cd ~/Labo/Projects/CRIMS/Source/Data_Manager/archiving-backend/data_downloader'
alias cdic='cd ~/Labo/Projects/CRIMS/Source/Data_Manager/archiving-backend/ispyb_checker'
alias cdf='cd ~/Labo/Projects/CRIMS/Source/Dev/frontend/php-fpm/lift-api/public/crims'



# PSI passwd trishAv8trishAv8$

alias vi='/usr/local/bin/nvim'
alias vimdiff='/usr/local/bin/nvim -d'
alias tmi=tmuxifier
