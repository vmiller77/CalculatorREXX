/*Select a data entry format - infix, post-fix, pre-fix.*/

/*Grabbing argument from command line*/
arg input
i = input
count = 1
valid = true

/* Storage into array*/
DO WHILE length(input)>1
  parse var input n1 o n2
  array.count = n1
  count = count + 1
  array.count = o
  count = count + 1
  input = n2
END
array.count = input


/*evaluate*/
evaluate:
  DO WHILE opFinder('E')\=0
    arithmetic('E', opFinder('E'))
  END
  DO WHILE opFinder('*')\=0
    arithmetic('*', opFinder('*'))
  END
  DO WHILE opFinder('/')\=0
    arithmetic('/', opFinder('/'))
  END
  DO WHILE opFinder('+')\=0
    arithmetic('+', opFinder('+'))
  END
  DO WHILE opFinder('-')\=0
    arithmetic('-', opFinder('-'))
  END
  print()
return ""

/*arithmetic*/
arithmetic:
  parse arg op, index
  if index=""
    then index = 0
  n1Index = index-1
  n2Index = index+1
  if datatype(array.n1Index) \= "CHAR" & datatype(array.n2Index) \= "CHAR" then
   do
       if op = 'E'
         then result = array.n1Index**array.n2Index
       if op = '*'
         then result = array.n1Index*array.n2Index
       if op = '/'
         then result = array.n1Index/array.n2Index
       if op = '+'
         then result = array.n1Index+array.n2Index
       if op = '-'
         then result = array.n1Index-array.n2Index
       array.n1Index = result
       newStartIndex = n1Index+1
       DO i = n2Index+1 to count
         array.newStartIndex = array.i
         newStartIndex = newStartIndex+1
       END
       count = count - 2
   end
   else
   do i = 1 to 1
   SAY "Bad format! RULES:"
   SAY 'All calculations are done in an infix manner.'
   SAY 'For example, "3 - 5" not "+ 2 3" nor "7 5 -".'
   SAY 'Enter in your arguments with a space in between.'
   SAY 'For example, "2 + 2" not "2+2"'
   SAY 'You are able to add(+), subtract(-), multiply(*), and divide(/)!'
   SAY 'You are also able to use exponents: "2 E 2" will result in 4'
   SAY 'Only use numbers and operators(+,-,/,*,E)'
   SAY 'You can use negative and fractional numbers'
   SAY 'For example, "2 / -9" or "2 + .75"'
   SAY 'Be aware, fractions are only in decimal format'
      count = 0
   end
return ""

/* op index finder */
opFinder:
  parse arg myOp
  DO i = 1 to count
    if array.i = myOp
      then return i
  END
return 0

/*Printing out array*/
print:
  DO j = 1 to count
    SAY array.j
  END
return ""
