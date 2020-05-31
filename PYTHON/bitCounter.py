##bit counter
##number of 1 bit

class Solution:
    def hammingWeight(self, n: int) -> int:
        count = 0
        while n:
            count = count + n % 2
            n = n // 2  ## will only have floor 
        return count
