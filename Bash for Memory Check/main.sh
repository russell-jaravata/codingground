# Hello World Program in Bash Shell

declare -i CRIT
declare -i WARN

if [ $# -eq 0 ]; then
	echo "No parameters. Script requires 3 parameters: -c critical threshold(percentage) -w warning threshold(percentage) -e email address to send the report"
else 
	while getopts ":c:e:w:" opt; do
  case $opt in
    c)
      CRIT=$OPTARG
      ;;
    w)
      WARN=$OPTARG
      ;; 
    e)
      EMAIL=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done
if [ $CRIT -le $WARN ]; then
	echo "Critical Threshold is less than Warning Threshold. Script requires 3 parameters: -c critical threshold(percentage) -w warning threshold(percentage) -e email address to send the report"
else 
   TOTAL_MEMORY=`free | grep Mem: | awk '{ print $2 }'`
   echo \"total = $TOTAL_MEMORY\"
   USED_MEMORY=`free | grep Mem: | awk '{ print $3 }'`
   echo \"used = $USED_MEMORY\"
   myvar=`echo "$USED_MEMORY $TOTAL_MEMORY" | awk '{printf "%.3f \n", $1/$2}'`
   declare -i USED
   USED=`echo "$myvar 100" | awk '{printf "%.0f \n", $1*$2}'`
   echo %USED= $USED
   if [ $USED -lt $WARN ] ; then
        echo "Used Memory is less than Warning Threshold."
        exit 0
    else      
        if [ $USED -lt $CRIT ] && [ $USED -ge $WARN ] ; then
                 echo "Used Memory is less than Critical Threshold but greater than or equal to Warning Threshold."
                 exit 1
        else
                if [ $USED -ge $CRIT ] ; then
                        echo "Used Memory is greater than or equal to Critical Threshold."
                        DATE="$(date +'%Y%m%d')"
                        TIME="$(date +'%H'):$(date +'%M')"
                        SUBJECT="${DATE}_${TIME}_memory_check_-critical"
                        echo $SUBJECT
                        MESSAGE=`ps axo %mem,pid,euser,cmd | sort -nr | head -n 10`
                        mail -s $SUBJECT $EMAIL << EOF
Top 10 Processes using a lot of memory: 
$MESSAGE
EOF
                        exit 2
                fi   
        fi
    fi
fi
fi
