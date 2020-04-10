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
square_sum=0

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

def isHappy(num)
    for i in range(len(num)):
    square_sum=square_sum+int(val[i])**2
    if square_sum==1:
        return 1
    elif max=100:
        return 3
    else:
        isHappy(sqare_sum)
         

print(square_sum)



# backlog codes:
# print(val[i])
# number_list.append(val[i])
# print(len(number_list))
 