//
//  EmojigramStore.swift
//  Emojigrams
//
//  Created by Trey Sands on 6/13/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation

class EmojigramStore: NSObject {
    fileprivate var emojigrams:[Emojigram] = []
    
    override init() {
        super.init()
        // Spoilers/Answers at the very end of this file in the addDefaultEmojigrams function.
        // DO NOT READ unless you want to cheat.
        self.addDefaultEmojigrams()
        
    }
    
    func randomEmojigram() -> Emojigram {
        return emojigrams.remove(at: Int.random(in: 0..<self.emojigrams.count))
    }
    
    func add(emojigram: Emojigram) {
        self.emojigrams.append(emojigram)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // SPOILERS
    
    fileprivate func addDefaultEmojigrams() {
        self.add(emojigram: Emojigram(emoji: "🤡", hint: "Based on a Stephen King novel", category: "Movie", answer: "It"))
        self.add(emojigram: Emojigram(emoji: "📞👇🤷🏻‍♀️", hint: "Carly Rae Jepsen song", category: "Pop song", answer: "Call Me Maybe"))
        self.add(emojigram: Emojigram(emoji: "☕️", hint: nil, category: "Language", answer: "Java"))
        self.add(emojigram: Emojigram(emoji: "😡🙎🏻‍♂️🙎🏽‍♂️", hint: "They're not THAT angry despite the name", category: "TV Shows", answer: "Mad Men"))
        self.add(emojigram: Emojigram(emoji: "🗼🦍\n🗼  \n🗼  \n🗼  \n🗼  ", hint: "'Twas Beauty that killed the Beast", category: "Movie", answer: "King Kong"))
        self.add(emojigram: Emojigram(emoji: "💚🚽👷🏻‍♂️👻🏯", hint: "Mario's brother finally gets his starring role. Don't use an apostrophe", category: "Video Game", answer: "Luigis Mansion"))
        self.add(emojigram: Emojigram(emoji: "🦂🤜🤛❄️❄️❄️", hint: "Either kontinue guessing or suffer a fatality", category: "Video Games", answer: "Mortal Kombat"))
        self.add(emojigram: Emojigram(emoji: "🇺🇸💧🇨🇦\n\u{3000}💧\n\u{3000}💧\n\u{3000}💧\n\u{3000}💧\n\u{3000}💧\n\u{3000}💧", hint: "Angel may be taller, but can't beat the location", category: "Place", answer: "Niagara Falls"))
        self.add(emojigram: Emojigram(emoji: "💋💋💥💥", hint: "I think it takes place at Christmas? Shane Black's stuff usually does", category: "Movies", answer: "Kiss Kiss Bang Bang"))
        self.add(emojigram: Emojigram(emoji: "👽📞🏠", hint: "A bag of Reese's Pieces if you can get it", category: "Movies", answer: "E.T."))
    }
}
