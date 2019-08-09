//
//  EmojigramGuesserBaseViewController.swift
//  Emojigrams
//
//  Created by Trey Sands on 6/18/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import UIKit

class EmojigramGuesserBaseViewController: UIViewController {
    // MARK: Navigation Methods
    
    func quit() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Alert Presentation Methods
    
    func presentNoMoreEmojigramsAlert() {
        let alertController = UIAlertController(title: "No more emojigrams!", message: "Sorry, but there's no more emojigrams left for you to conquer. Weep at your human limits.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentGuessWithoutEmojigramOrTextAlert() {
        let alertController = UIAlertController(title: "Whoopsy", message: "Whoa, not sure how you were able to guess when there's not emoji showing or when there's no text. That shouldn't have happened.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentSuccessfulGuessAlert(withNewEmojigramAction emojigramAction: @escaping () -> (), andQuitAction quitAction: @escaping () -> ()) {
        let alertController = UIAlertController(title: "Congratulations!", message: "Correct! You got the right answer!", preferredStyle: .alert)
        let newEmojigramAction = UIAlertAction(title: "New Emojigram", style: .default) { alert in
            emojigramAction()
        }
        let quitAction = UIAlertAction(title: "Quit?", style: .default) { alert in
            quitAction()
        }
        alertController.addAction(newEmojigramAction)
        alertController.addAction(quitAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentExtraHintAlert(withExtraHintAction extraHintAction: @escaping () -> ()) {
        let alertController = UIAlertController(title: "Another hint already?", message: "I already gave you a hint. Need more help? Would you like the first 1/3 of the answer to be filled in for you?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "YES PLZ", style: .default) { alert in
            extraHintAction()
        }
        let noAction = UIAlertAction(title: "I don't need help", style: .default, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentNoHintAvailableAlert(withNoHintAction noHintAction: @escaping () -> ()) {
        let ac = UIAlertController(title: "On your own again", message: "No hint for you today", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { alert in
            noHintAction()
        }
        ac.addAction(okAction)
        self.present(ac, animated: true, completion: nil)
    }
    
    func presentFailedGuessAlert() {
        let alertC = UIAlertController(title: "WRONG", message: "WRONG GUESS. TRY AGAIN WITH A BETTER ONE. MAYBE TAKE A HINT?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertC.addAction(okAction)
        self.present(alertC, animated: true, completion: nil)
    }

}
