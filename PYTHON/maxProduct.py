class Solution:
    def maxProduct(self, words: List[str]) -> int:
        
        maxl=0
        
        for i in range(len(words)):
            for j in range(i+1,len(words)):
                for x in words[i] :
                    if x in words[j]:
                        break;
                else:
                    lenths=len(words[i])*len(words[j])
                    if maxl<lenths:
                        maxl=lenths
        return maxl
