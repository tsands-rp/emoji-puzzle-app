//
//  EmojigramGuesserViewController.swift
//  Emojigrams
//
//  Created by Trey Sands on 6/12/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import UIKit

class EmojigramGuesserViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryHeaderLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var emojigramLabel: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var hintLabel: UILabel!
    
    var currentEmojigram: Emojigram? {
        didSet {
            self.updatePage(with: self.currentEmojigram)
        }
    }
    
    let emojigramsList:EmojigramStore = EmojigramStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentEmojigram = self.emojigramsList.randomEmojigram()
    }
    
    func updatePage(with emojigram: Emojigram?) {
        if let _ = emojigram {
            let unoptionalEmojigram = emojigram!
            self.updatePage(with: unoptionalEmojigram)
        } else {
            let alertController = UIAlertController(title: "No more emojigrams!", message: "Sorry, but there's no more emojigrams left for you to conquer. Weep at your human limits.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            self.titleLabel.text = "You win!"
            self.categoryLabel.text = "Winners"
            self.emojigramLabel.text = nil
            self.guessTextField.text = nil
        }
    }
    
    func updatePage(with emojigram: Emojigram) {
        self.categoryLabel.text = emojigram.category
        self.emojigramLabel.text = emojigram.emoji
        self.guessTextField.placeholder = "What's your guess?"
        self.hintLabel.text = nil
        self.hintButton.setTitle("Need a hint?", for: .normal)
    }

    @IBAction func pressedGuessButton(_ sender: Any) {
        guard let emojigram = self.currentEmojigram, let guess = self.guessTextField.text else {
            let alertController = UIAlertController(title: "Whoopsy", message: "Whoa, not sure how you were able to guess when there's not emoji showing or when there's no text. That shouldn't have happened.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let isSuccessfulGuess = emojigram.answer.lowercased() == guess.lowercased()
        isSuccessfulGuess ? self.showSuccessfulGuess() : self.failedGuessHappened()
    }
    
    func showSuccessfulGuess() {
        let alertController = UIAlertController(title: "Congratulations!", message: "Correct! You got the right answer!", preferredStyle: .alert)
        let newEmojigramAction = UIAlertAction(title: "New Emojigram", style: .default) { alert in
            self.newEmojigram()
        }
        let quitAction = UIAlertAction(title: "Quit?", style: .default) { alert in
            self.quit()
        }
        alertController.addAction(newEmojigramAction)
        alertController.addAction(quitAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func newEmojigram() {
        self.currentEmojigram = self.emojigramsList.randomEmojigram()
    }
    
    func quit() {
        
    }
    
    @IBAction func tappedHintButton(_ sender: Any) {
        if let text = self.hintLabel.text, text.count > 0, let answer = self.currentEmojigram?.answer {
            let alertController = UIAlertController(title: "Another hint already?", message: "I already gave you a hint. Need more help? Would you like the first 1/3 of the answer to be filled in for you?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "YES PLZ", style: .default) { alert in
                let firstThirdAnswer = String(answer.prefix(answer.count/3))
                self.guessTextField.text = firstThirdAnswer
            }
            let noAction = UIAlertAction(title: "I don't need help", style: .default, handler: nil)
            alertController.addAction(yesAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        guard let hint = self.currentEmojigram?.hint else {
            let ac = UIAlertController(title: "On your own again", message: "No hint for you today", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            ac.addAction(okAction)
            self.present(ac, animated: true, completion: nil)
            return
        }
        self.hintLabel.text = hint
        self.hintButton.setTitle("Need yet more help?", for: .normal)
    }
    
    func failedGuessHappened() {
        let alertC = UIAlertController(title: "WRONG", message: "WRONG GUESS. TRY AGAIN WITH A BETTER ONE. MAYBE TAKE A HINT?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertC.addAction(okAction)
        self.present(alertC, animated: true, completion: nil)
    }
}

