#!/bin/sh
#as runserver can only access at localhost
#so I add a proxy
#run.sh extra
#eg.extra=remote, run with remote settings.
version=0.2.0
port=1394
addr2="127.0.0.1"
port2=8000
run="./manage.py runserver "
extra=
help=
Ver=
default=

if [ -n "$1" ];then
    port2=$1
fi

#usage
function usage
{
echo "$0 [setting..] [options..]"
cat <<EOF

setting:
    -p|--port, proxy port.
    -l|--local, local port.
    -a|--addr: local addr/ip.
    -r|--run: local server.
    -e|--extra: extra options.
options:
    -D|--default: run as default.
others:
    -h|--help: show help list.
    -V|--version: show version.
EOF
echo "version $version"
cat <<EOF
quick start:
    django site: 
    # run.sh
    hyde site:
    # run.sh -p320 -l8080 -Dr"hyde serve"
EOF
}

#parse option and arguments.
ARGS=`getopt -o p:l:a:r:e:DhV --long port:,local:,addr:,run:,extra:,default,help,version -- "$@"`

if [ $? != 0 ]; then echo "Terminating...";exit 1;fi

eval set -- "${ARGS}"

while true
do
    case "$1" in
        -p|--port)
            port=$2
            shift 2
            ;;
        -l|--local)
            port2=$2
            shift 2
            ;;
        -a|--addr)
            addr2=$2
            shift 2
            ;;
        -r|--run)
            run=$2
            shift 2
            ;;
        -e|--extra)
            extra=$2
            shift 2
            ;;
        -D|--default)
            default=y
            shift
            ;;
        -h|--help)
            help=y
            shift
            break
            ;;
        -V|--version)
            Ver=y
            shift
            break
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Internal error!"
            exit 1;;
    esac
done
#handle help&&version
if [ "$help" == "y" ]; then
    usage
    exit 0;
fi
if [ "$Ver" == "y" ]; then
    echo $version
    exit 0;
fi

proxy_cmd0="proxyd $port $addr2 "
proxy_cmd="$proxy_cmd0""$port2"
proxy_pid=$(ps aux|grep "${proxy_cmd0}"|grep -v "grep"|awk 'NR==1{print $2}')
if [ -n "$proxy_pid" ];then
    pre_port2=$(ps aux|grep "${proxy_cmd0}"|grep -v "grep"|awk 'NR==1{print $14}')
    if [ "${pre_port2}" != "${port2}" ];then
        echo "kill proxyd."
        kill -9 $proxy_pid
        while [ $? -ne 0 ]
        do
            echo "kill proxyd faild, try again."
            kill -9 $proxy_pid
        done
        proxy_pid=""
    fi
fi

if [ -z "$proxy_pid" ];then
    echo "start $proxy_cmd"
    eval $proxy_cmd
fi

#add extra
run="$run""$extra "
#add port
if [ "$default" != "y" ];then
    run="$run""$port2"
fi
#run
eval $run

