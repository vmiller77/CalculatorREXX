/*Grabbing argument from command line*/
arg input
i = input
count = LENGTH(input)

SAY count
opFinder(input,'+')
opFinder(input,'-')

/* op index finder */
opFinder:
  parse arg str, myOp
  DO i = 1 to count
    
    if SUBSTR(str,i,i) = myOp
      then return i
  END
return 0
