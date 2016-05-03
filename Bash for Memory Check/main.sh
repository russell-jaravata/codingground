# Hello World Program in Bash Shell
TOTAL_MEMORY=`free | grep Mem: | awk '{ print $2 }'`
echo \"total = $TOTAL_MEMORY\"
USED_MEMORY=`free | grep Mem: | awk '{ print $3 }'`
echo \"used = $USED_MEMORY\"
myvar=`echo "$USED_MEMORY $TOTAL_MEMORY" | awk '{printf "%.2f \n", $1/$2}'`
#myvar2=`echo - | awk '{print $USED_MEMORY / $TOTAL_MEMORY}'`
#myvar3=`awk 'BEGIN {printf "%.3f\n", $USED_MEMORY/$TOTAL_MEMORY}'`
#RESULT=$(awk "BEGIN {printf \"%.2f\",${USED_MEMORY}/${TOTAL_MEMORY}}")
#echo $RESULT

echo $myvar
#echo $myvar3
#echo "Hello World!" 
if [ $# -eq 0 ]; then
	echo "Script requires 3 parameters: -c critical threshold(percentage) -w warning threshold(percentage) -e email address to send the report"
else 
	while getopts ":c:e:w:" opt; do
  case $opt in
    c)
      echo "-c was triggered, Parameter: $OPTARG" >&2
      ;;
    e)
      echo "-e was triggered, Parameter: $OPTARG" >&2
      ;;
    w)
      echo "-w was triggered, Parameter: $OPTARG" >&2
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
fi 
