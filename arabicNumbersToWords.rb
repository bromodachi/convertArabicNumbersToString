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

class HandleHundred
  #ruby isnt like swift...so i didnt use this...
  module TypeOfPower
    one = 0
    ten = 1
    hundred = 2
    thousand = 3
    million = 4
    billion = 5
    trillion = 6
    quadrillion = 7
    quintillion = 8
  end
  def typeOfPowerConvert(convert)

  end
  def self.grabPower(num)
    if num != 0
      return Math.log10(num).to_i
    else
      return 0
    end
  end
  def self.handleTens(num)
    @english = ""
    if num < 20
      @english = TeenDigits.convertToString(num)
    else
      @english = OverTwenty.convertToString(num)
      if num % 10 != 0
        @english += "-" + ToSingleDigits.convertToString(num % 10)
      end
    end
    return @english
  end
  def self.handleHundred(num)
    @singleNumber = num / 100
    @tens = num % 100
    @power = grabPower(@tens)
    @appendString = ""
    if @power == 1
      @appendString = " " + handleTens(@tens)
    else
      if @tens != 0
        @appendString = " " + ToSingleDigits.convertToString(@tens)
      end
    end
    return ToSingleDigits.convertToString(@singleNumber) + " hundred" + @appendString
  end
  def self.computeHundreds(forValue = 0)
    @convert = forValue
    @power = 0
    @english = ""
    if @convert != 0
      @power = Math.log10(@convert).to_i
    else
      @power = 0
    end
    case @power
      when 0
        return ToSingleDigits.convertToString(@convert)
      when 1
        return self.handleTens(@convert.to_i)
      when 2
        return self.handleHundred(@convert)
      else
        return "should never happen"
    end

  end
end

class Converter
  @@maxSupportedStrings = ["", "thousand", "million", "billion", "trillion", "quadrillion", "quintillion", "sextillion"]
  def self.convert(numberToConvert)
    if !checkIfNumbersOnly(numberToConvert)
      return "Not supported"
    end
    @numberToConvert = numberToConvert
    @lengthOfString = numberToConvert.length
    @finalString = ""
    if @lengthOfString >= 22
      return "Not supported...No details specification were given to support this large of a number"
    end
    if @lengthOfString > 3
      @untilWeHaveNoChars = @lengthOfString
      while @untilWeHaveNoChars > 0
        @until = @untilWeHaveNoChars % 3
        @partial = ""
        if @until == 0
          @partial = @numberToConvert[0..2]
          puts "is zero"
          puts @partial
        else
          @partial = @numberToConvert[0..@until - 1]
          puts "else"
          puts @partial
        end
        @numberToConvert = @numberToConvert.sub(@partial, "")
        if @partial.to_i == 0
          @untilWeHaveNoChars -= @until == 0 ? 3 : @until
          next
        end
        @finalString += HandleHundred.computeHundreds(@partial.to_i)
        @division = @untilWeHaveNoChars <= 3 ? 0 : @untilWeHaveNoChars % 3 == 0 ? @untilWeHaveNoChars / 3 - 1 : @untilWeHaveNoChars / 3
        @finalString += " " + @@maxSupportedStrings[@division] + " "
        @untilWeHaveNoChars -= @until == 0 ? 3 : @until
      end
    else
      if @numberToConvert.to_i == 0
        return "zero"
      end
      return HandleHundred.computeHundreds(@numberToConvert.to_i)
    end
    return @finalString

  end
  def self.checkIfNumbersOnly(value)
    return !!(value =~ /^[0-9]+$/i)
  end
end
puts Converter.convert(ARGV[0])