# A script printing hello world
print('Hello world!')
print('I am a sentient machine')
(1 < 2) & (3 >= 3)

## Workshop 2

# Regular expressions not only allow you to look for specific characters, words or phrases, but can also look for complex text patterns.

sentence <- c('By','the','time','they', 'got', 'back,', 'the', 'lights', 'were', 'all', 'out', 'and', 'everybody', 'was', 'asleep.', 'Everybody,', 'that', 'is,', 'except', 'for', 'Guih', 'Kyom', 'the', 'dung', 'beetle.', 'He', 'was', 'wide', 'awake', 'and', 'on', 'duty,', 'lying', 'on', 'his', 'back', 'with', 'his', 'legs', 'in', 'the', 'air', 'to', 'save', 'the', 'world', 'in', 'case', 'the', 'heavens', 'fell.')

# to find out where is the word the
grep_out <- grep(pattern = 'the', x = sentence)
grep_out

#We have defined two function arguments; pattern and 'x'. The first is the pattern that we want to look for in our text, the second is the character vector to search through (our sentence object we created above).

sentence[grep_out]

# it also returned they in the output, to avoid this change pattern to pattern = '^the$'
grep_out <- grep(pattern = '^the$', x = sentence)
grep_out
 
#my own sentence
sentence2 <- c('I', 'am', 'going', 'to', 'be', 'the', 'best', 'coder', 'known', 'to', 'man')
grep_out <- grep(pattern = 'coder', x = sentence2)
sentence2[grep_out]

# to check for capital letters 
grep_out <- grep(pattern = '[A-Z]', x = sentence)
grep_out

# '.' comes into play when used with other characters
#if we search for 'a.e' we are looking for matches where there is an 'a' and an 'e' separated by any character.
grep_out <- grep(pattern = 'a.e', x = sentence)
sentence[grep_out]

## 3.3 Quantifiers
# quantifiers allow the user to specify how many of a character (or set of characters) grep() is matching to. The three main symbols are ‘?’, ‘*’ and ‘+’.
# ‘?’ denotes 0 or 1 instances.
#‘*’ denotes 0 or more instances.
#‘+’ denotes 1 or more instances.

sentence[grep(pattern = 'e.?e', x = sentence)]
sentence[grep(pattern = 'e.*e', x = sentence)]
sentence[grep(pattern = 'e.+e', x = sentence)]

##3.4 The gsub() Function
# This searches for the text in same way as grep but will subsitute matched text to whatever we want it to change too

gsub_out <- gsub(pattern = 'a.e', x = sentence, replacement = '!!!')
gsub_out

gsub_out <- gsub(pattern = 't', x = sentence, replacement = '??')
