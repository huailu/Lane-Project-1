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

