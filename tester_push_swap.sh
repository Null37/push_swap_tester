#!/bin/bash
RESET="\033[0m"
BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"

#g ../push_swap.c
cp ../push_swap .
cp ../checker_Mac .
function push_swap()
{
	TEST1=$(./push_swap $@ | ./checker_Mac $@)
	LENINC=$(./push_swap $@ | wc -l)

	if [ "$TEST1" == "OK" ]
	then
		printf " $BLUE%s\n$RESET" "================="
		printf " $GREEN%s$@\n$RESET\n"
		printf "$GREEN\n%s$RESET" "stats = OK"
		printf "\n%s %d\n$RESET" "operations ==" $LENINC
		printf " $BLUE%s\n$RESET" "================="
	elif [ "$TEST1" == "KO" ]
	then
		echo "$TEST1"
		printf "$RED%s$RESET\n" "============="
		printf "$RED%s$@$RESET\n" "stats = KO in ==> "
		printf "$RED%s$RESET\n" "============="
	elif [ "$TEST1" == "Error" ]
	then
		printf "$RED%s$RESET\n" "============="
		printf "$RED%s$@\n$RESET" "ERROR"
		printf "$RED%s$RESET\n" "============="
	fi
}
function test_push
{
	i="0"
	while [ $i != $1 ]; 
	do
		ARG=$(python3 ./test.py $2)
		printf "$YELLOW%s%d$RESET\n" "test for ===> " "$2"
		push_swap $ARG
		i=$[$i+1]; 
	done
}
#argument  1 = how much while loop and arg2 how much number gnrate
function test_all()
{
	echo "<=======================> start $2 number <=================>"
	test_push $1 $2
	echo "<=======================> end $2 number <===================>"
}
#test_all $1 $2

ALL=$(test_all $1 $2 | cat)
echo "$ALL"
SUCSS=$(echo "$ALL" | grep "stats = OK" | wc -l | awk -F ' ' '{print}' | xargs echo)
printf "$YELLOW how many success == > ✓ $GREEN%d$RESET\n" "$SUCSS"
FAIL=$(echo "$ALL" | grep "stats = KO" | wc -l |  awk -F ' ' '{print}' | xargs echo)
printf "$YELLOW how many fail    == > ✗ $RED%d$RESET\n" "$FAIL"
FAIL_E=$(echo "$ALL" | grep "ERROR" | wc -l |  awk -F ' ' '{print}' | xargs echo)
printf "$YELLOW how many ERRORS  == > ✗ $RED%d$RESET\n" "$FAIL_E"
NUMBER=$(echo "$ALL" | grep "operations == " | grep -Eo '[0-9]+'| awk -F '\n' '{print}'| xargs | cat)

printf "$YELLOW ======>  result <==== $RESET  \n"
for n in $NUMBER;
do
     ((max < n)) && max=$n
done
printf "$MAGENTA ======>  max number you have  ===> || ==> %d <==||$RESET\n" "$max"