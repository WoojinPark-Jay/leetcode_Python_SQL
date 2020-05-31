##reverse string one-liner code
class Solution :
  def reverseString(self, s : List[str]) -> None:
    s[0:len(s)] = reversed(s[:len(s)])
        
