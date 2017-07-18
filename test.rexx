arg input

i = input

SAY 'Length of input ' || length(input)

count = 1

/* Storage into Array*/
DO WHILE length(input)>1
  parse var input n1 o n2
  array.count = n1
  count = count + 1
  array.count = o
  count = count + 1
  input = n2
END
array.count = input
SAY count

/*Printing out array*/
DO j = 1 to count
  SAY array.j
END
