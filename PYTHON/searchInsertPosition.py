class Solution:
    def searchInsert(self, nums: List[int], target: int) -> int:
        cnt = 0 
        for i in nums :
            if i < target :
                cnt += 1
            else :
                 return cnt
