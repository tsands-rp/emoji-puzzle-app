//
//  EmojigramGuesserViewController.swift
//  Emojigrams
//
//  Created by Trey Sands on 6/12/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import UIKit

class EmojigramGuesserViewController: EmojigramGuesserBaseViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryHeaderLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var emojigramLabel: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var giveUpButton: UIButton!
    
    var emojigramsList:EmojigramStore?
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updatePage()
    }
    
    // MARK: View Updates
    
    func updatePage() {
        guard let emojigram = emojigramsList?.randomEmojigram() else {
            self.updatePageWithoutEmojigram()
            return
        }
        self.updatePage(with: emojigram)
    }
    
    func updatePageWithoutEmojigram() {
        self.presentNoMoreEmojigramsAlert()
        self.titleLabel.text = "You win!"
        self.categoryLabel.text = "Winners"
        self.emojigramLabel.text = nil
        self.guessTextField.text = nil
        self.giveUpButton.isHidden = true
    }
    
    func updatePage(with emojigram: Emojigram) {
        self.categoryLabel.text = emojigram.category
        self.emojigramLabel.text = emojigram.emoji
        self.guessTextField.placeholder = "What's your guess?"
        self.guessTextField.text = nil
        self.hintLabel.text = nil
        self.hintButton.setTitle("Need a hint?", for: .normal)
        self.giveUpButton.isHidden = true
    }
    
    // MARK: IB Actions

    @IBAction func pressedGuessButton(_ sender: Any) {
        guard let emojigram = self.emojigramsList?.currentEmojigram, let guess = self.guessTextField.text else {
            self.presentGuessWithoutEmojigramOrTextAlert()
            return
        }
        let isSuccessfulGuess = emojigram.answer.lowercased() == guess.lowercased()
        isSuccessfulGuess ? self.presentSuccessfulGuessAlert(withNewEmojigramAction: self.updatePage, andQuitAction: self.quit): self.presentFailedGuessAlert()
    }
    
    @IBAction func pressedHintButton(_ sender: Any) {
        if hasHintBeenShown() {
            self.presentExtraHintAlert(withExtraHintAction: self.fillOutFirstThirdAnswer)
            return
        }
        
        guard let hint = self.emojigramsList?.currentEmojigram?.hint else {
            self.presentNoHintAvailableAlert(withNoHintAction: self.showGiveUpButton)
            return
        }
        
        self.hintLabel.text = hint
        self.hintButton.setTitle("Need yet more help?", for: .normal)
    }
    
    @IBAction func pressedGiveUpButton(_ sender: Any) {
        self.updatePage()
    }
    
    // MARK: Helper Functions
    
    func hasHintBeenShown() -> Bool {
        guard let text = self.hintLabel.text else { return false }
        return text.count > 0
    }
    
    func fillOutFirstThirdAnswer() {
        guard let answer = self.emojigramsList?.currentEmojigram?.answer else { return }
        let firstThirdAnswer = String(answer.prefix(answer.count/3))
        self.guessTextField.text = firstThirdAnswer
        self.showGiveUpButton()
    }
    
    func showGiveUpButton() {
        self.giveUpButton.isHidden = false
    }
}

