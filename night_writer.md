# Night Writer

* Braille uses a two-by-three grid of dots to represent characters.
* The 0 represents a raised dot and the period is an unraised space.
* Braille file most only be 80 characters wide.

## Development Process

1. How will you know when the problem is solved?
* We will know when the problem is solved when we give our program a file
containing plain text in english and it creates a file containing the braille
output correctly.

2. How will it be used? It's interface? What do you put in and what do you get
out?
* The way it will be used is that we will give our "machine" the file containing
the plain english text. Our program will take in the file, do its work, then
create a file containing the braille version of the original file.

3. What is the most trivial use case? (mvp-mvp)
* The most trivial use case would be that we feed our machine an empty txt file
and it gives us back an empty txt file.

4. What's the minimum work case?
* The minimum work case would be that we feed our machine a txt file containing
a single english character. The machine would do its work, then created a text
file with the single character converted to braille.

5. What's the next most complex case?
* The next most complex case would be to have a txt file containing 2 english
characters and it returns the braille version correctly.

5. What's the next most complex case?
* The next most complex case would be to have a txt file containing 2 english
characters and it returns the braille version correctly.

5. What's the next most complex case?
* The next most complex case would be to have a txt file containing an english
word and it returns the braille version correctly.

5. What's the next most complex case?
* The next most complex case would be to have a txt file containing multiple
words with spaces and it returns the braille version correctly.

5. What's the next most complex case?
* The next most complex case would be to have a txt file containing words with
capitals and it returns the braille version correctly.

6. Sketch an algorithm in pseudocode.
  1. Take in a string containing the letter we will be converting.
  2. Using the letter, find the corresponding braille version found in a set.
  3. Pull out that braille version and place it into a string
  4. Return the braille version
