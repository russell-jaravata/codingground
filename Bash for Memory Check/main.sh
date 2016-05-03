# Hello World Program in Bash Shell
TOTAL_MEMORY=`free | grep Mem: | awk '{ print $2 }'`
echo \"total = $TOTAL_MEMORY\"
USED_MEMORY=`free | grep Mem: | awk '{ print $3 }'`
echo \"used = $USED_MEMORY\"
myvar=`echo "$USED_MEMORY $TOTAL_MEMORY" | awk '{printf "%.3f \n", $1/$2}'`
echo $myvar
declare -i USED
USED=`echo "$myvar 100" | awk '{printf "%.0f \n", $1*$2}'`
echo %USED= $USED
#let myvar3=$USED+1
#echo myvar3 \"$myvar3\"
#myvar2=`echo - | awk '{print $USED_MEMORY / $TOTAL_MEMORY}'`
#myvar3=`awk 'BEGIN {printf "%.3f\n", $USED_MEMORY/$TOTAL_MEMORY}'`
#RESULT=$(awk "BEGIN {printf \"%.2f\",${USED_MEMORY}/${TOTAL_MEMORY}}")
#echo $RESULT
#echo $myvar3
#echo "Hello World!" 

declare -i CRIT
declare -i WARN

if [ $# -eq 0 ]; then
	echo "No parameters. Script requires 3 parameters: -c critical threshold(percentage) -w warning threshold(percentage) -e email address to send the report"
else 
	while getopts ":c:e:w:" opt; do
  case $opt in
    c)
      CRIT=$OPTARG
      echo "-c was triggered, Parameter: $OPTARG" >&2
      ;;
    w)
      WARN=$OPTARG
      echo "-w was triggered, Parameter: $OPTARG" >&2
      ;; 
    e)
      EMAIL=$OPTARG
      echo "-e was triggered, Parameter: $OPTARG" >&2
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
   echo "compute"
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
                        
                        exit 2
                #else
                 #       echo "Please make a choice between 1-3 !"
                fi   
        fi
    fi
fi
fi 
