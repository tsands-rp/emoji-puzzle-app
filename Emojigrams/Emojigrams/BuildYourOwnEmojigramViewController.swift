//
//  BuildYourOwnEmojigramViewController.swift
//  Emojigrams
//
//  Created by Trey Sands on 6/19/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import UIKit

class BuildYourOwnEmojigramViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate  {
    lazy var titleLabel: UILabel! = {
        let label = UILabel()
        label.text = "Build-an-Emojigram Werkshop"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emojigramTextView: UITextView! = {
        let textView = UITextView()
        textView.text = "Emojigram"
        textView.textColor = .gray
        textView.textAlignment = .center
        textView.font = UIFont.systemFont(ofSize: 30)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var answerTextField: UITextField! = {
        let textField = UITextField()
        textField.placeholder = "Answer"
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var categoryTextField: UITextField! = {
        let textField = UITextField()
        textField.placeholder = "Category"
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var hintTextField: UITextField! = {
        let textField = UITextField()
        textField.placeholder = "Hint (optional)"
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var addEmojigramButton: UIButton! = {
        let button = UIButton()
        button.setTitle("Add emojigram", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.addTarget(self, action: #selector(self.pressedAddEmojigramButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        return button
    }()
    
    let emojigramsStore: EmojigramStore
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .white
        super.loadView()
    }
    
    init(store: EmojigramStore) {
        self.emojigramsStore = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubviewsToView()
        self.view.backgroundColor = .white
        self.setupProgrammaticAutoLayout()
        self.enableAddEmojigramButton()
        self.emojigramTextView.delegate = self
        self.answerTextField.delegate = self
        self.categoryTextField.delegate = self
        self.hintTextField.delegate = self
    }
    
    func addSubviewsToView() {
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.emojigramTextView)
        self.view.addSubview(self.answerTextField)
        self.view.addSubview(self.categoryTextField)
        self.view.addSubview(self.hintTextField)
        self.view.addSubview(self.addEmojigramButton)
    }
    
    func setupProgrammaticAutoLayout() {
        for unconstrainedView in [self.titleLabel, self.emojigramTextView, self.answerTextField, self.categoryTextField, self.hintTextField, self.addEmojigramButton] {
            self.setupProgrammaticAutoLayout(for: unconstrainedView!)
        }
        
        self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        self.emojigramTextView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20).isActive = true
        self.emojigramTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.emojigramTextView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 40).isActive = true
        self.answerTextField.topAnchor.constraint(equalTo: self.emojigramTextView.bottomAnchor, constant: 18).isActive = true
        self.categoryTextField.topAnchor.constraint(equalTo: self.answerTextField.bottomAnchor, constant: 40).isActive = true
        self.hintTextField.topAnchor.constraint(equalTo: self.categoryTextField.bottomAnchor, constant: 40).isActive = true
        self.addEmojigramButton.topAnchor.constraint(equalTo: self.hintTextField.bottomAnchor, constant: 40).isActive = true
    }
    
    func setupProgrammaticAutoLayout(for unconstrainedView:UIView) {
        unconstrainedView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        unconstrainedView.leftAnchor.constraint(greaterThanOrEqualTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        unconstrainedView.rightAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
    }
    
    func enableAddEmojigramButton() {
        self.addEmojigramButton.isEnabled = self.shouldEnableAcceptButton()
    }
    
    func shouldEnableAcceptButton() -> Bool {
        guard let emoji = self.emojigramTextView.text, let category = self.categoryTextField.text, let answer = self.answerTextField.text else { return false }
        return emoji.count > 0 && category.count > 0 && answer.count > 0
    }
    
    
    @objc func pressedAddEmojigramButton() {
        guard let emoji = self.emojigramTextView.text, let category = self.categoryTextField.text, let answer = self.answerTextField.text else { return }
        let emojigram = Emojigram(emoji: emoji, hint: self.hintTextField.text, category: category, answer: answer)
        self.emojigramsStore.add(emojigram: emojigram)
        self.showEmojigramAddedAlert()
    }
    
    func showEmojigramAddedAlert() {
        let alert = UIAlertController(title: "Successfully added emojigram!"
            , message: nil, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Awesome!", style: .default, handler: nil)
        alert.addAction(okayAction)
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil
        textView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Emojigram"
            textView.textColor = .gray
            return
        }
        self.enableAddEmojigramButton()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.enableAddEmojigramButton()
    }

}
