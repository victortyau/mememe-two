//
//  ListDetailController.swift
//  mememe-two
//
//  Created by Victor Tejada Yau on 07/31/21.
//

import UIKit

class ListDetailController: UIViewController {

    var meme: Meme!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.name.text = meme.top+" "+meme.bottom
        self.image!.image = meme.memeImage
    }
}
