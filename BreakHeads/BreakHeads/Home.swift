//
//  Home.swift
//  BreakHeads
//
//  Created by Sandra Basquero on 20/10/16.
//  Copyright © 2016 SBS. All rights reserved.
//

import Foundation
import UIKit

class Home: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func levelSelection(sender: UIButton) {
        print(sender.tag)
        switch sender.tag {
        case 1:
            Constants.sharer.numOfPieces = 9
        case 2:
            Constants.sharer.numOfPieces = 16
        case 3:
            Constants.sharer.numOfPieces = 25
        default:
            Constants.sharer.numOfPieces = 0
        }
    }
    
}

