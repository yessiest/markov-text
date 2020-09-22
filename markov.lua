local markov = {}

local function node(relations)
   local node = {}
   local total = 0
   for k,v in pairs(relations) do
     total = total + v
   end
   for k,v in pairs(relations) do
     node[k] = v/total
   end
   return node
end

local function escape(str)
  return str:gsub("([%%%*%(%)%^%.%[%]%+%-%$%?])","%%%1")
end

local function register_words(str)
   local word_list = {}
   str:gsub("%S+",function(word)
      if not word_list[word] then
         word_list[word] = {}
         local current_word = word_list[word]
         str:gsub(escape(word) .. "%s+(%S+)",function(word2)
           if not current_word[word2] then
             current_word[word2] = 1
           else
             current_word[word2] = current_word[word2] + 1
           end
         end)
      end
   end)
   for k,v in pairs(word_list) do
     word_list[k] = node(v)
   end
   return word_list
end

local table_length = function(tab)
  local len = 0
  for k,v in pairs(tab) do
    len = len + 1
  end
  return len
end

function markov.walk(self,start)
  local random = math.random(0,1e7)/1e7
  local highest = 0
  local words = {}
  words.count = 0
  local word = nil
  if self.net[start] then
    while (words.count < 1) and (table_length(self.net[start]) > 0) do
      for k,v in pairs(self.net[start]) do
        if (random <= v) then
          words.count = words.count + 1
          table.insert(words,k)
        end
      end
      random = math.random(0,1e7)/1e7
    end
  end
  if words.count > 0 then
    word = words[math.random(1,#words)]
  end
  return word
end

function markov.new(str)
   local self = setmetatable({},{__index = markov})
   self.net = register_words(str)
   return self
end

a = (markov.new([[]]))

local b = ""
local s = ""
while b do
  s = s..(b.." ")
  b = a:walk(b)
  local _,length = s:gsub("(%s+)","%1")
  if length > 100 then
    s = s.."..."
    break
  end
end
print(s)
