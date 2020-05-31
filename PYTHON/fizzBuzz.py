##fizzBuzz 2 solutions
##1st
class Solution:
    def fizzBuzz(self, n):
        res = []
        for i in range(1,n+1):
            if i%3 == 0 and i%5 == 0:
                res.append("FizzBuzz")
            elif i%3 == 0:
                res.append("Fizz")
            elif i%5 == 0:
                res.append("Buzz")
            else:
                res.append(str(i))
        return res
##2nd
class Solution:
    def fizzBuzz(self, n: int) -> List[str]:
        final = []
        for i in range(1,n+1):
            if (i%3 == 0 and i%5 == 0) :
                final.append("FizzBuzz")
            elif(i%3 == 0 and i%5 != 0) :
                final.append("Fizz")
            elif (i%5 == 0 and i%3 !=0) :
                final.append("Buzz")
            else :
                final.append(str(i))
        return final
