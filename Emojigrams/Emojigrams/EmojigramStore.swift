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
    var currentEmojigram: Emojigram?
    
    override init() {
        super.init()
        self.startNewGame()
        // Spoilers/Answers at the very end of this file in the addDefaultEmojigrams function.
        // DO NOT READ unless you want to cheat.
    }
    
    func randomEmojigram() -> Emojigram? {
        let emojigramCount = self.emojigrams.count
        guard emojigramCount > 0 else {
            self.currentEmojigram = nil
            return self.currentEmojigram
        }
        self.currentEmojigram = emojigrams.remove(at: Int.random(in: 0..<emojigramCount))
        return self.currentEmojigram
    }
    
    func add(emojigram: Emojigram) {
        self.emojigrams.append(emojigram)
        self.save(emojigram: emojigram)
    }
    
    func startNewGame() {
        self.currentEmojigram = nil
        self.emojigrams = self.loadEmojigrams()
    }
    
    private func save(emojigram: Emojigram) {
        do {
            var savedEmojigrams = self.loadEmojigrams()
            savedEmojigrams.append(emojigram)
            let data = try NSKeyedArchiver.archivedData(withRootObject: savedEmojigrams, requiringSecureCoding: false)
            try data.write(to: Emojigram.ArchiveURL)
        } catch {
            NSLog("OH NO!")
        }
    }
    
    private func loadEmojigrams() -> [Emojigram] {
        do {
            let data = try Data(contentsOf: Emojigram.ArchiveURL)
            guard let savedEmojigrams = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Emojigram] else {
               return self.defaultEmojigrams()
            }
            return savedEmojigrams
        } catch {
            return self.defaultEmojigrams()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // SPOILERS
    
    fileprivate func defaultEmojigrams() -> [Emojigram] {
        var emojigrams:[Emojigram] = []
        emojigrams.append(Emojigram(emoji: "🤡", hint: "Based on a Stephen King novel", category: "Movie", answer: "It"))
        emojigrams.append(Emojigram(emoji: "📞👇🤷🏻‍♀️", hint: "Carly Rae Jepsen song", category: "Pop song", answer: "Call Me Maybe"))
        emojigrams.append(Emojigram(emoji: "☕️", hint: nil, category: "Language", answer: "Java"))
        emojigrams.append(Emojigram(emoji: "😡🙎🏻‍♂️🙎🏽‍♂️", hint: "They're not THAT angry despite the name", category: "TV Shows", answer: "Mad Men"))
        emojigrams.append(Emojigram(emoji: "🗼🦍\n🗼  \n🗼  \n🗼  \n🗼  ", hint: "'Twas Beauty that killed the Beast", category: "Movie", answer: "King Kong"))
        emojigrams.append(Emojigram(emoji: "💚🚽👷🏻‍♂️👻🏯", hint: "Mario's brother finally gets his starring role. Don't use an apostrophe", category: "Video Game", answer: "Luigis Mansion"))
        emojigrams.append(Emojigram(emoji: "🦂🤜🤛❄️❄️❄️", hint: "Either kontinue guessing or suffer a fatality", category: "Video Games", answer: "Mortal Kombat"))
        emojigrams.append(Emojigram(emoji: "🇺🇸💧🇨🇦\n\u{3000}💧\n\u{3000}💧\n\u{3000}💧\n\u{3000}💧\n\u{3000}💧\n\u{3000}💧", hint: "Angel may be taller, but can't beat the location", category: "Place", answer: "Niagara Falls"))
        emojigrams.append(Emojigram(emoji: "💋💋💥💥", hint: "I think it takes place at Christmas? Shane Black's stuff usually does", category: "Movies", answer: "Kiss Kiss Bang Bang"))
        emojigrams.append(Emojigram(emoji: "👽📞🏠", hint: "A bag of Reese's Pieces if you can get it", category: "Movies", answer: "E.T."))
        return emojigrams
    }
}
