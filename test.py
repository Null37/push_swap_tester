import random
import sys

arg = int(sys.argv[1])
stack_a = []
stack_a = random.sample(range(-1 * arg * 20, arg * 20), arg)
print(' '.join([str(i) for i in stack_a]))
#ARG=$(python3 ./test.py); echo $ARG; ./push_swap $ARG | wc -l; ./push_swap $ARG | ./checker_MAC $ARG