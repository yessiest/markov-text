# markov-text

A (WIP) Lua text generator library using markov chains 

## Features

- State saving (TODO)
- Chain expansion

## Usage
Using this library is as simple as loading it, creating a new instance of the generator, and then using the ``run`` method

```lua
local markov = require("markov") --load the lib
local instance = markov.new("Your text here") --create a new instance of the generator
local output = instance:run() --run the generator once
print(output) 
```

Additional methods are

- ``instance:walk(word)`` - Looks up the next word in the chain
- ``instance:run(starting_word,stop_after)`` - Walks repeatedly, recording the output into a string. ``stop_after`` specifies how much words can the output contain
- ``instance:expand_vocabulary(text)`` - Adds words from the string ``text`` to the chain
- ``instance:save_state()`` - Returns the current markov chain as a table
- ``instance:load_state(state)`` - Replace the current markov chain with a compatible one

