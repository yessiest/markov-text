local markov = require("markov")
a = markov.new([[Basically, you feed in a bunch of sentences, and even though it has no understanding of the meaning of the text, it picks up on patterns like "word A is often followed by word B". Then when you want to generate a new sentence, it "walks" its way through from the start of a sentence to the end of one, picking sequences of words that it knows are valid based on that initial analysis. So generally short sequences of words in the generated sentences will make sense, but often not the whole thing.]])
print(a:run())
