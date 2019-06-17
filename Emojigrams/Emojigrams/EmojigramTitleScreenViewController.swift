//
//  EmojigramTitleScreenViewController.swift
//  Emojigrams
//
//  Created by Trey Sands on 6/14/19.
//  Copyright © 2019 Trey Sands. All rights reserved.
//

import UIKit

class EmojigramTitleScreenViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func tappedProgrammaticViewButton(_ sender: Any) {
        let vc = EmojigramGuessProgramaticLayoutViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
