--[[ function returning the max between two numbers --]]
myprint = function max(num1, num2)
  if num1 > num2 then
    result = num1
  else
    result = num2
  end

  return result
end

myprint(10)
add(2,5,myprint)

