import random

words = ["beach", "squid", "laugh", "grape", "round"]


def select_random_word_from_words(words):
    return random.choice(words)


def guess_the_letter():
    return input("make a guess: ")


def get_index_of_guess(guess, word):
    index = 0
    for item in word:
        if guess != item:
            index += 1
        else:
            break

    return index


def display_hangman(number_of_guesses):
    if number_of_guesses == 0:
        return """
 +---+
 |   |    
 0   |
/|\\  |
/ \\  |
     |
======
    """
    elif number_of_guesses == 1:
        return """
 +---+
 |   |    
 0   |
/|\\  |
/    |
     |
======
    """
    elif number_of_guesses == 2:
        return """
 +---+
 |   |    
 0   |
/|\\  |
     |
     |
======
    """
    elif number_of_guesses == 3:
        return """
 +---+
 |   |    
 0   |
/|   |
     |
     |
======
    """
    elif number_of_guesses == 4:
        return """
 +---+
 |   |    
 0   |
/    |
     |
     |
======
    """
    elif number_of_guesses == 5:
        return """
 +---+
 |   |    
 0   |
     |
     |
     |
======
    """
    elif number_of_guesses == 6:
        return """
 +---+
 |   |    
     |
     |
     |
     |
======
    """


def display_word_progress(word_progress):
    for item in word_progress:
        print(item, end=" ")
    print()


def display_num_of_chances_remaining(number_of_guesses):
    print(f"you have {number_of_guesses} chances remaining!")


def run_hangman():

    number_of_guesses = 6
    guess_history = []
    word = select_random_word_from_words(words)
    print(word)
    word_progress = ["_", "_", "_", "_", "_"]

    while number_of_guesses > 0:
        display_word_progress(word_progress)
        print(display_hangman(number_of_guesses))
        guess = guess_the_letter()
        index = get_index_of_guess(guess, word)

        if guess not in guess_history and guess in word:
            word_progress[index] = guess

            separator = ''
            if separator.join(word_progress) == word:
                print(f"congrats you won queen! the word is {word.upper()}!")
                break

        elif guess not in word or (guess in guess_history and guess in word):
            number_of_guesses -= 1

        guess_history.append(guess)
        display_num_of_chances_remaining(number_of_guesses)

    if number_of_guesses == 0:
        print(display_hangman(number_of_guesses))
        print("sorry you failed queen. hangman is dead")
        print(f"the word was: {word.upper()}")



if __name__ == "__main__":
    print("WELCOME! YOU HAVE 6 CHANCES TO GUESS THE WORD!")
    print("_______________________________________________")
    run_hangman()