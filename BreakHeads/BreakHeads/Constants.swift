//
//  Constants.swift
//  BreakHeads
//
//  Created by Sandra Basquero on 20/10/16.
//  Copyright © 2016 SBS. All rights reserved.
//

import UIKit


class Constants {

    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var numOfPieces = 4 //number of piece in the puzzle
    
    
    func boxSize() -> CGFloat {
        var box:CGFloat = 0 //square box size
        box = screenSize.width / CGFloat(numOfPieces)
        return round(box)
    }
}

