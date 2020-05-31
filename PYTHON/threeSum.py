## threeSum

class Solution:
    def threeSum(self, nums: List[int]) -> List[List[int]]:
        nums.sort()
        result = []
        n = len(nums)
        for i in range(n):
            if i > 0 and nums[i] == nums[i-1]:
                continue
            head = i + 1
            end = n - 1
            while head < end:
                if nums[i] + nums[head] + nums[end] == 0:
                    result.append([nums[i], nums[head], nums[end]])
                    head += 1
                    while head < end and nums[head] == nums[head-1]:
                        head += 1
                    end -= 1
                    while head < end and nums[end] == nums[end+1]:
                        end -= 1
                elif nums[i] + nums[head] + nums[end] < 0:
                    head += 1
                    while head < end and nums[head] == nums[head-1]:
                        head += 1
                else:
                    end -= 1
                    while head < end and nums[end] == nums[end+1]:
                        end -= 1
        return result
