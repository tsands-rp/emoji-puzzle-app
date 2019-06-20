//
//  Emojigram.swift
//  Emojigrams
//
//  Created by Trey Sands on 6/12/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import Foundation

class Emojigram: NSObject, NSCoding {
    // MARK: - Properties
    let emoji: String
    let hint: String?
    let category: String
    let answer: String
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("emojigrams")
    
    
    // MARK: - Types
    struct PropertyKeys {
        static let emoji: String = "emoji"
        static let hint: String = "hint"
        static let category: String = "category"
        static let answer: String = "answer"
    }
    
    init(emoji: String, hint: String? = nil, category: String, answer: String) {
        self.emoji = emoji
        self.hint = hint
        self.answer = answer
        self.category = category
        super.init()
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.emoji, forKey: PropertyKeys.emoji)
        aCoder.encode(self.hint, forKey: PropertyKeys.hint)
        aCoder.encode(self.category, forKey: PropertyKeys.category)
        aCoder.encode(self.answer, forKey: PropertyKeys.answer)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let emoji = aDecoder.decodeObject(forKey: PropertyKeys.emoji) as? String, let category = aDecoder.decodeObject(forKey: PropertyKeys.category) as? String, let answer = aDecoder.decodeObject(forKey: PropertyKeys.answer) as? String else {
            return nil
        }
        let hint: String? = aDecoder.decodeObject(forKey: PropertyKeys.hint) as? String
        self.init(emoji: emoji, hint: hint, category: category, answer: answer)
    }
    
}
