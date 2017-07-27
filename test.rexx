/*Select a data entry format - infix, post-fix, pre-fix.
X|Data entry is via the command line (unless you want to create a panel for data entry and display)
 |User can enter a calculation with numbers using the selected data entry format and get a result (an error message if the data entry was not acceptable)
X|Calculator must support addition, subtraction, multiplication and division
X|Calculator must support higher precedence for multiplication and division than addition and subtraction (parenthetical support could be added for extra credit)
 |A single number memory with a store and recall operators could be added for extra credit.
 |For extra credit provide online help*/

 /*SAY 'RULES:'
 SAY 'All calculations are done in an infix manner. For example, "3 - 5" not "+ 2 3" nor "7 5 -".'
 SAY 'Enter in your arguments with a space in between. For example, "2 + 2" not "2+2"'
 SAY 'You are able to add(+), subtract(-), multiply(*), and divide(/)!'
 SAY 'Have fun!'
*/

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

evaluate()


/*evaluate*/
evaluate:
  DO WHILE opFinder('(')\=0
    arithmetic('(', opFinder('('))
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
  if (datatype(array.n1Index) = "CHAR" | datatype(array.n2Index) = "CHAR") then
        SAY "Invalid format, make sure there is a space between each character or number!"
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
        count = count -2
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

/*findParenthesis
findPar:
  par1Count=0
  par2Count=0
  DO j = 1 to count
    if array.j = '('
      then par1Count=par1Count+1
    if array.j = ')'
      then par2Count=par2Count+1
  END
  if par1Count=par2Count
    then return par1Count
return "Missing or extra parenthesis!"*/
