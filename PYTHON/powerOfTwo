#power of two
##first option
   def isPowerOfTwo(self, n: int) -> bool:
     return n > 0 and not (n & n-1)

##second option
    def isPowerOfTwo(self, n: int) -> bool:
        if n <= 0:
            return False
        power = 1
        while n >= power:
            if n == power:
                return True
            power *= 2
        return False
