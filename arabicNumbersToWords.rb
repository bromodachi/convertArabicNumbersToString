#handles numbers in the single digits
class ToSingleDigits
  def self.convertToString(value = 0)
    return ["", "one", "two", "three", "four", "five", "six", "seven", "eight","nine"][value]
  end
end
#handles numbers in the teens
class TeenDigits
  @@teenNums = ["ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen","nineteen"]
  def self.convertToString(value = 0)
    return @@teenNums[value % 10]
  end
end
#handles numbers twenty and above
class OverTwenty
  @@overTwenty = ["twenty", "thrity", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
  def self.convertToString(value = 0)
    return @@overTwenty [(value / 10) - 2]
  end
end
