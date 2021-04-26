# Hello world

"Hello world!" print

# Factorial

factorial := method(n, if(n == 1, 1, n * factorial(n - 1)))
99 bottles of beer

bottle := method(i,
     if(i == 0, return "no more bottles")
     if(i == 1, return "1 bottle")
     return "" .. i .. " bottles"
)

for(i, 99, 1,
     writeln(current, " of beer on the wall, ", current, " of beer,\n",
          "take one down, pass it around,\n",
          bottle(i - 1), " of beer on the wall.\n")
)

# Create a simple object and show how to use it

Account := Object clone
Account balance := 0
Account deposit  := method(v, balance = balance + v)
Account withdraw := method(v, balance = balance - v)
Account show := method(
  writeln("Account balance: $", balance)
)

myAccount := Account clone
myAccount show
"Depositing $10\n" print
myAccount deposit(10)
myAccount show

# Concurrency example - the following will print "112233"

o1 := Object clone
o1 test := method(for(n, 1, 3, n print; yield))
o2 := o1 clone

// @ means send an asynchronous message
o1 @test; o2 @test 

// wait for the messages to get processed
while(Scheduler activeActorCount > 1, yield) 

# Look up a class/prototype given its name as a string

Lobby getSlot("PrototypeName")

# Execute a method given its name as a string

anObject perform("SomeMethodName", arg1, arg2)

# Find out if a method with a given name (again a string) exists

anObject hasSlot("SomeMethodName")

# Given an arbitrary reference to a class/prototype, instantiate it

newInstance := objectRef clone

# Add a method to a primitive

Number double := method(self * 2)
1 double
==> 2

# Subclass a primitive

MyList := List clone // Same as creating an instance

# Iterate through an inheritance hierarchy

Object printAllSlots := method(  
  self slotNames foreach(i, slotName, 
    writeln(slotName)
    if(self hasSlot("proto"), self proto printAllSlots
  )
)
Object printAllSlots

# Implement a generic proxy

Proxy = Object clone
Proxy forward := method(
  methodName := thisMessage name
  args := thisMessage argsEvaluatedIn(sender)

  // When an unrecognized message is received,
  // this method will be invoked.
  // Do what you like with the message here -
  // such as send it over a network, etc.
)

# Implement a singleton

Foo := Object clone
Foo clone := Foo

# Print the source code of a method

myMethod := method(return testing(1+2+3))
getSlot("myMethod") code print
==> "return(testing(1+(2)+(3)))"

# Add an operator method to an object

MyObject := Object clone
MyObject setSlot("+",  method(n, write("adding ", n, "\n")))
MyObject + 123
==> "adding 123"

# Mixins and Aspects

a := Object clone

Mix := Object clone
Mix logData := Buffer clone
Mix init := method(logData = logData clone)
Mix log := method(s, logData append(s))

a parent := Mix clone // Now a also inherits the state and behavior of Mix

b := Object clone
b parent := Mix clone // Now multiple objects use it so it's an "aspect"

# An auto source file importer

Object searchPaths = List clone add(launchPath)

Object forward := method(
  methodName := thisMessage name
  if (methodName characterAt(0) isUpperCase,
    searchPaths foreach(i, searchPath,
      fileName := searchPath appendPath(methodName .. ".io")
      sourceFile := File clone setPath(fileName)
      if (sourceFile exists) then (
        Lobby doFile(path)
        return Lobby getSlot(methodName)
      )
    )
  )
  raiseException("Importer", "Could not find slot for " .. methodName)
)

# A simple whois client

whois := method(host,
  socket := Socket clone setHostName("rs.internic.net") setPort(43) 
  socket connect write(host, "\n")
  while(socket readNextChunk, nil) // socket read auto yields to other coroutines
  return socket readBuffer
)

# An echo server

Echo := Object clone
Echo handleSocket := method(socket,
  while(socket isOpen, 
    if(socket read, socket write(socket readBuffer))
    socket readBuffer empty
  )
)

EchoServer := Server clone setPort(8456) 
EchoServer handleSocket := method(socket,
  Echo clone @handleSocket(socket) 
  // async message so it's handled in separate coroutine
)
EchoServer start