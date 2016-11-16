//
//  PopupFullImageCV.swift
//  BreakHeads
//
//  Created by Sandra Basquero on 16/11/16.
//  Copyright © 2016 SBS. All rights reserved.
//

import UIKit

class PopupFullImageCV: UIViewController {

    @IBOutlet weak var viewContentImage: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageFullView = UIImageView(image: Constants.sharer.preparedPuzzleImage())
        imageFullView.frame.origin.y = 60 //TODO: replace 60!
        self.viewContentImage.addSubview(imageFullView)
    }
    
    
    @IBAction func closeFullImage(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: false)
    }
    
}
