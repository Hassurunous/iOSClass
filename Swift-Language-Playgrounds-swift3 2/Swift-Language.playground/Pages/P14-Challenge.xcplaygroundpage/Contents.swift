/*:
 ![Make School Banner](./swift_banner.png)
# Challenge!
To cap things off, here's a challenge that will require you to use many of the concepts you've learned so far. You're going to be creating a simple card game, in which you (the player) draw a card against the computer. The highest card wins! What an exciting game!
*/
/*:
## Card Class
To start we'll make a simple card class. In fact, instead of a class, it might be even better to create a card `struct`. A `struct` is a little bit better for a couple reasons:
 
1. We don't expect to inherit from the card class, so `struct`s lack of inheritance is okay
2. A `struct` will be a little bit more performant, because of the small amount of memory our card will occupy.
 
 If all that seems a little vague or weird, that's okay! Choosing a `struct` instead of a `class` or vice-versa won't actually matter too much in any case.
 
 Our card class will have two properties: `rank` and `suit`. There are 13 ranks: Ace, King, Queen, Jack and Ten through Two. And, of course, the 4 suits are Spades, Clubs, Diamonds and Hearts.
 
 There's a couple of ways we could represent this information. For example, we could use an `Int` to represent the rank, Two would be `2`, Ten would be `10`, Jack would be `11`, etc. Or maybe we could use strings, like: `"Ace"`, `"Queen"`, `"Diamonds"`. But we shouldn't do either of those things - there's a better way! Can you think of what it is?

Hopefully the answer you came up with is *enumerations*. Go ahead and use the following code to create your enumerations:
 
    enum Rank {
        case two, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace
        
        static func allValues() -> [Rank] {
            return [two, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace]
        }
    }

    enum Suit {
        case spades, hearts, diamonds, clubs
        
        static func allValues() -> [Suit] {
            return [spades, hearts, diamonds, clubs]
        }
    }
 
Both enumerations come with an `allValues()` function, which returns an array containing each of the enumeration values. This function will be helpful later, when you create your `Deck` class.

 
So now, using the above `enum` code (you'll have to type it out below), create a Card `struct` with `suit` and `rank` properties, and an initializer that accepts `suit` and `rank` parameters.
*/
/* Place your code here! */
enum Rank: Int {
    case two = 1, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace
    
    static func allValues() -> [Rank] {
        return [two, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace]
    }
}

enum Suit: Int {
    case spades = 4, hearts = 3, diamonds = 2, clubs = 1
    
    static func allValues() -> [Suit] {
        return [spades, hearts, diamonds, clubs]
    }
}

struct Card {
    
    let suit:Suit
    let rank:Rank
    
    init(suit:Suit, rank:Rank) {
        self.suit = suit
        self.rank = rank
    }
    
}


/*:
## Deck Class
 
Now that you've created your card class, it's time to create a `Deck` to hold them. A standard 52 card deck has one card of each rank and suit pair. The cards in a deck must also be ordered: can you think of a data structure to hold them?
 
To start, your deck should have an empty initializer. Inside the initializer, create all 52 cards, and place them in the ordered data structure.
*/
/* Place your code here! */
Suit.allValues()

import Foundation

class Deck {
    var deckList: [Card] = []
    init() {
        for suits in Suit.allValues() {
            for ranks in Rank.allValues() {
                var appendCard: Card
                appendCard = Card(suit: suits, rank: ranks)
                self.deckList.append(appendCard)
            }
        }
    }
    func drawOne() -> Card? {
        let deckLength = deckList.count
        print(deckLength)
        if deckLength == 0 {
            return nil
        } else {
            let randomNum = Int(arc4random_uniform(UInt32(deckLength)))
            //print("Rank of: " + (deckList[randomNum].rank) + "; Suit of: " + (deckList[randomNum].rank))
            let cardPull = deckList[randomNum]
            deckList.remove(at: randomNum)
            return cardPull
        }
    }
}

/*:
Now that you have a `Deck` it's time to add some functionality. Create a a function in your `Deck` class above called `drawOne()`. `drawOne()` should return a random card from the deck. Don't forget to remove that card from your internal deck data structure! 
 
 To help draw a random card, you'll probably want to use the built-in `arc4random_uniform()` function. `arc4random_unform(upperBound)` will generate a number from 0 up to but less than `upperBound`. One caveat is that `arc4random_uniform()` only likes to work with unsigned 32-bit integers (`UInt32`). So you'll need to do some casting between `UInt32` and `Int` to make it work. To access `arc4random_uniform()` you'll first need to `import Foundation`.
 
Once you've implemented `drawOne()`, uncomment the following code to test it out! You can show the debug area (⇧⌘Y) to see what's printed.
*/
func printCard(card: Card?) {
    if let card = card {
        print("The random card is the \(card.rank) of \(card.suit)")
    } else {
        print("That's not a card!")
    }
}

let testDeck = Deck()

for _ in 1...55 {
    let card = testDeck.drawOne()
    printCard(card: card)
}
/*:
- important:
 Does the test code above create an error?  If so, it's likely because you forgot to account for the case where there's no cards left in the deck to draw! Change your `drawOne()` method so that it returns `nil` if there's no cards left to draw.
 */
/*:
## A Simple Game
 Now it's time to make a simple game. Create a deck, and draw one card for you (the player) and one card for the computer. The highest card wins! In this game, a Two is the lowest card and Ace is the highest card. If both players draw the same rank card, then suit is used to determine the winner. Spades is the best suit, followed by Hearts, Diamonds, then Clubs.
 
 You should print out the result of the game like this:
    
>The (_player_ or _computer_) won with the _rank_ of _suit_!
 
 So, an example of the output might be:
 
    The player won with the King of Clubs!
 
 
 Here's some hints:
 
 It's best to make your code reusable. One way to do that is to place it into functions. I suggest you create a function to compare two cards to determine which one is the winner. It would also be good to have a function that prints the result of the game!
 
 You can make comparing the cards easier if you assign _raw values_ to the enumerations. Check out the [enumerations playground](P10-Enumerations) for a refresher on how to do that.
 */
/* Place your code here! */
var cardDeck = Deck()
var deckLength = cardDeck.deckList.count
var playerWins = 0
var aiWins = 0

func highCard(deckSize : Int) {
    
    var counter = 0
    while counter < deckSize {
        counter += 2
        let playerCard = cardDeck.drawOne()
        let playerRank = playerCard!.rank
        let playerSuit = playerCard!.suit

        let aiCard = cardDeck.drawOne()
        let aiRank = aiCard!.rank
        let aiSuit = aiCard!.suit


        if playerRank.rawValue > aiRank.rawValue {
            print("You've beat the computer with a \(playerRank) of \(playerSuit)!")
            playerWins += 1
        } else if aiRank.rawValue > playerRank.rawValue {
            print("The computer beat you with a \((aiRank)) of \(aiSuit)!")
            aiWins += 1
        } else if aiRank.rawValue == playerRank.rawValue {
            if playerSuit.rawValue > aiSuit.rawValue {
                print("You've beat the computer with a \(playerRank) of \(playerSuit)!")
                playerWins += 1
            } else if aiSuit.rawValue > playerSuit.rawValue {
                print("The computer beat you with a \((aiRank)) of \(aiSuit)!")
                aiWins += 1
            }
        } else {
            print("There appears to be some kind of error! You pulled: \(playerRank) of \(playerSuit). AI pulled: \(aiRank) of \(aiSuit).")
        }
    }
    print("You won \(playerWins) times. The computer won \(aiWins) times!")

}

highCard(deckSize : deckLength)
/*:
 - important:
 Once you're done, have your instructor check your code!
 */
/*:
[Previous](@previous) | [Table of Contents](P00-Table-of-Contents) | [Advanced Topics](@next)
 */
