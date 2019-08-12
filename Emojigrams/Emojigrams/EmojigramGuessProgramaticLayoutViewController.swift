//
//  EmojigramGuessProgramaticLayoutViewController.swift
//  Emojigrams
//
//  Created by Trey Sands on 6/17/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import UIKit

class EmojigramGuessProgramaticLayoutViewController: EmojigramGuesserBaseViewController {
    lazy var titleLabel: UILabel! = {
        let label = UILabel()
        label.text = "Guess the Emojigram"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var categoryHeaderLabel: UILabel! = {
        let label = UILabel()
        label.text = "Category is"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var categoryLabel: UILabel! = {
        let label = UILabel()
        label.text = "Category is"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emojigramLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var guessTextField: UITextField! = {
        let textField = UITextField()
        textField.text = "TEST"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        textField.delegate = self
        return textField
    }()
    
    lazy var guessButton: UIButton! = {
        let button = UIButton()
        button.setTitle("Got it?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.pressedGuessButton), for: .touchUpInside)
        return button
    }()
    
    lazy var hintButton: UIButton! = {
        let button = UIButton()
        button.setTitle("Need a hint?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.pressedHintButton), for: .touchUpInside)
        return button
    }()
    
    lazy var hintLabel: UILabel! = {
        let label = UILabel()
        label.text = "TEST"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var giveUpButton: UIButton! = {
        let button = UIButton()
        button.setTitle("Give up?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.pressedGiveUpButton), for: .touchUpInside)
        return button
    }()
    
    let emojigramsList:EmojigramStore
    
    init(store: EmojigramStore) {
        self.emojigramsList = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .white
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubviewsToView()
        self.view.backgroundColor = .white
        self.setupProgramaticAutolayout()
        self.updatePage()
    }
    
    // MARK: View Updates
    
    func addSubviewsToView() {
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.categoryHeaderLabel)
        self.view.addSubview(self.categoryLabel)
        self.view.addSubview(self.emojigramLabel)
        self.view.addSubview(self.guessTextField)
        self.view.addSubview(self.guessButton)
        self.view.addSubview(self.hintButton)
        self.view.addSubview(self.hintLabel)
        self.view.addSubview(self.giveUpButton)
    }
    
    func updatePage() {
        guard let emojigram = emojigramsList.randomEmojigram() else {
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
    
    func configurePage() {
        if true {
            self.guessTextField.autocorrectionType = .no
        }
    }
    
    func setupProgramaticAutolayout() {
        self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.categoryHeaderLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.categoryLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.emojigramLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.hintLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.hintButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.giveUpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.emojigramLabel.leftAnchor.constraint(greaterThanOrEqualTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        self.emojigramLabel.rightAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        self.guessTextField.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        self.guessTextField.rightAnchor.constraint(equalTo: self.guessButton.leftAnchor, constant: -8).isActive = true
        self.guessButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -8).isActive = true
        self.guessButton.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        
        self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        self.categoryHeaderLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20).isActive = true
        self.categoryLabel.topAnchor.constraint(equalTo: self.categoryHeaderLabel.bottomAnchor, constant: 18).isActive = true
        self.emojigramLabel.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 40).isActive = true
        self.guessTextField.topAnchor.constraint(equalTo: self.emojigramLabel.bottomAnchor, constant: 40).isActive = true
        self.guessButton.centerYAnchor.constraint(equalTo: self.guessTextField.centerYAnchor, constant: 1).isActive = true
        self.hintButton.topAnchor.constraint(equalTo: self.guessTextField.bottomAnchor, constant: 40).isActive = true
        self.hintLabel.topAnchor.constraint(equalTo: self.hintButton.bottomAnchor, constant: 20).isActive = true
        self.giveUpButton.topAnchor.constraint(equalTo: self.hintLabel.bottomAnchor, constant: 20).isActive = true
    }
    
    
    // MARK: Button Actions
    
    @objc func pressedGuessButton() {
        guard let emojigram = self.emojigramsList.currentEmojigram, let guess = self.guessTextField.text else {
            self.presentGuessWithoutEmojigramOrTextAlert()
            return
        }
        let isSuccessfulGuess = emojigram.answer.lowercased() == guess.lowercased()
        isSuccessfulGuess ? self.presentSuccessfulGuessAlert(withNewEmojigramAction: self.updatePage, andQuitAction: self.quit): self.presentFailedGuessAlert()
    }
    
    @objc func pressedHintButton() {
        if hasHintBeenShown() {
            self.presentExtraHintAlert(withExtraHintAction: self.fillOutFirstThirdAnswer)
            return
        }
        
        guard let hint = self.emojigramsList.currentEmojigram?.hint else {
            self.presentNoHintAvailableAlert(withNoHintAction: self.showGiveUpButton)
            return
        }
        
        self.hintLabel.text = hint
        self.hintButton.setTitle("Need yet more help?", for: .normal)
    }
    
    @objc func pressedGiveUpButton() {
        self.updatePage()
    }
    
    // MARK: Helper Functions
    
    func hasHintBeenShown() -> Bool {
        guard let text = self.hintLabel.text else { return false }
        return text.count > 0
    }
    
    func fillOutFirstThirdAnswer() {
        guard let answer = self.emojigramsList.currentEmojigram?.answer else { return }
        let firstThirdAnswer = String(answer.prefix(answer.count/3))
        self.guessTextField.text = firstThirdAnswer
        self.showGiveUpButton()
    }
    
    func showGiveUpButton() {
        self.giveUpButton.isHidden = false
    }
}
