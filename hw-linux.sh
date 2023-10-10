LOGS="LOGS.csv"
PID_KEEPER="PIDKEEPER.txt"

command=$1

case $command in
"START")
	if [ -e $PID_KEEPER ];
	then
		pkill -F $PID_KEEPER
		rm -rf $PID_KEEPER
	fi
	while true
	do
	time=$(date +%T)
        cpuInfo=$(ps -Ao pcpu | awk '{s+=$1} END {print s}')
        memInfo=$(ps -Ao pmem | awk '{s+=$1} END {print s}')
            
        log="$time;$cpuInfo;$memInfo"
	echo $log >> $LOGS
	sleep 600
	done&
	echo $! > $PID_KEEPER
        echo | cat $PID_KEEPER
	;;
"STATUS")
	if [ -e $PID_KEEPER ]
	then
		echo "Running"
	else
		echo "Not running"
	fi
	;;
"STOP")
	pkill -F $PID_KEEPER
	rm $PID_KEEPER
esac
