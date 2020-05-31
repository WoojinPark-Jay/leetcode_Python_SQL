##twoSum

class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        sumed = [] 
        point = 1
        tf = False
        for i in range(len(nums)):
            for j in range(i+point,len(nums)):
                if(nums[i]+nums[j]==target):
                    sumed.append(i)
                    sumed.append(j)
                    tf = True
                    break
        if(tf==False):            
            point+=1
            
        return sumed
