/*Select a data entry format - infix, post-fix, pre-fix.
Data entry is via the command line (unless you want to create a panel for data entry and display)
User can enter a calculation with numbers using the selected data entry format and get a result (an error message if the data entry was not acceptable)
Calculator must support addition, subtraction, multiplication and division
Calculator must support higher precedence for multiplication and division than addition and subtraction (parenthetical support coiuld be added for extra credit)
A single number memory with a store and recall operators could be added for extra credit.
For extra credit provide online help*/


arg input

SAY 'RULES:'
SAY 'All calculations are done in an infix manner. For example, "3 - 5" not "+ 2 3" nor "7 5 -".'
SAY 'Enter in your arguments with a space in between. For example, "2 + 2" not "2+2"'
SAY 'You are able to add(+), subtract(-), multiply(*), and divide(/)!'
SAY 'Have fun!'
parse var input num1 op num2

SAY num1
SAY op
SAY num2

SAY "This is the method operator:" operator(op)

operator:
parse arg myArg
if myArg = '+'
  then return 'PLUS'
if myArg = '-'
  then return 'MINUS'
if myArg = '/'
  then return 'DIVIDE'
if myArg = '*'
  then return 'MULTIPLY'
if myArg = ""
  then return 'You need to use more than one number, at least one operator, and you need spaces between each!'
