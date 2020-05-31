##singleNumberDetection
##using Counter()

from collections import Counter

## 1st
class Solution:
    def singleNumber(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        from collections import Counter
        xdict = Counter(nums)
        for k, v in xdict.items():
            if v == 1:
                return k

## 2nd
class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        
        cnt = Counter(nums)
        for key,value in cnt.items() :
            if (value == 1) : 
                return key
