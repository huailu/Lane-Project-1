#print ("Hello")

#val = input("Enter your value: ") 
#print(val, type(val))

'''
try:
   val_int = int(val)
   print("Input is an integer number. Number = ", val_int)
except ValueError:
  try:
    val_float = float(val)
    print("Input is a float  number. Number = ", val_float)
  except ValueError:
      print("No.. input is not a number. It's a string")
'''


number_list=[]
max_turn=0

while True:
    val = input("Enter your value: ")
    try:
        val_int = int(val)
        print("Input is an integer number. Number = ", val_int)
        break
    except ValueError:
        if val == "quit":
            break
        else: 
            print ("Input must be an integer number, please try again. OR input quit to exit")

def isHappy(num):
    global max_turn
    square_sum=0
    l_num=str(num)
    for i in range(len(l_num)):
        square_sum=square_sum+int(l_num[i])**2
    max_turn+=1
    if square_sum==1:
        number_list.append(square_sum)
        return 1
    elif square_sum in number_list:
        return 0
    elif max_turn==100:
        return 3
    else:
        number_list.append(square_sum)
        return isHappy(square_sum)

x=isHappy(val_int)
print(x)
print(number_list)


      




# backlog codes:
# print(val[i])
# number_list.append(val[i])
# print(len(number_list))
 