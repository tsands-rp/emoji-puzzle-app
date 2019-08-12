//
//  EmojigramTitleScreenViewController.swift
//  Emojigrams
//
//  Created by Trey Sands on 6/14/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import UIKit

class EmojigramTitleScreenViewController: UIViewController {
    let emojigramStore = EmojigramStore()
    
    override func viewWillAppear(_ animated: Bool) {
        guard let _ = self.navigationController else { return }
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func tappedProgrammaticViewButton(_ sender: Any) {
        self.emojigramStore.startNewGame()
        let vc = EmojigramGuessProgramaticLayoutViewController(store: self.emojigramStore)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func tappedBuildYourOwnViewButton(_ sender: Any) {
        let vc = BuildYourOwnEmojigramViewController(store: self.emojigramStore)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.emojigramStore.startNewGame()
        guard let vc: EmojigramGuesserViewController = segue.destination as? EmojigramGuesserViewController else { return }
        vc.emojigramsList = self.emojigramStore
    }
}
