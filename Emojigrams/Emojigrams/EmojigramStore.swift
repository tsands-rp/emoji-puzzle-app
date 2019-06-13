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
        self.add(emojigram: Emojigram(emoji: "🤡", hint: "Based on a Stephen King novel", category: "Movies", answer: "It"))
        self.add(emojigram: Emojigram(emoji: "📞👇🤷🏻‍♀️", hint: "Carly Rae Jepsen song", category: "Pop song", answer: "Call Me Maybe"))
        self.add(emojigram: Emojigram(emoji: "☕️", hint: nil, category: "Language", answer: "Java"))
        self.add(emojigram: Emojigram(emoji: "😡🙎🏻‍♂️🙎🏽‍♂️", hint: "They're not THAT angry despite the name", category: "TV Shows", answer: "Mad Men"))
        self.add(emojigram: Emojigram(emoji: "🗼🦍\n🗼  \n🗼  \n🗼  \n🗼  ", hint: "'Twas Beauty that killed the Beast", category: "Movie", answer: "King Kong"))
    }
    
    func randomEmojigram() -> Emojigram {
        return emojigrams.remove(at: Int.random(in: 0..<self.emojigrams.count))
    }
    
    func add(emojigram: Emojigram) {
        self.emojigrams.append(emojigram)
    }
}
