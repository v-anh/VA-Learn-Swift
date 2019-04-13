




/*
 #Bitwise operations on integers(int)#
 Get the maximum integer
 */
var max = ~(1 << 31)
var max2 = (1 << 31) - 1
var max3 = (1 << -1) - 1


/*
 #Bitwise operations on integers(int)#
 Get the minimum integer
 */

var min = (1 << 31)
var min2 = (1 << -1)

/*
 Multiplied by 2
 */

print(8 << 1)

/*
 Divided by 2
 */

print(8 >> 1)


/*
 Multiplied by the m-th power of 2
 
 EX: m = 3 => 4 << m = 32
 */
print(4 << 3)


/*
 Divided by the m-th power of 2
 
 EX: m = 3 => 32 << m = 4
 */
print(32 >> 3)

/*
 Check odd number
 
 (n & 1) == 1;
 */
print(9 & 1)



//Exchange two values
var a = 5

var b = 10
a ^= b;
b ^= a;
a ^= b;
print(a,b)

//Get absolute value
var n = 1024 >> 2
(n ^ (n >> 31)) - (n >> 31)


var x = 3
var y = -1
(x ^ y)


n > 0 ? (n & (n - 1)) == 0 : false



//Determining if an integer is a power of 2
(n & (n - 1)) == 0

9 ^ 9 ^ 3 ^ 7 ^ 3 ^ 6

