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
    
    //Singleton
    static var sharer = Constants()
    private init() {}
    var numOfPieces:Int = 0
    
    
    func boxSize() -> CGFloat {
        var box:CGFloat = 0 //square box size
        box = screenSize.width / CGFloat(sqrt(CGFloat(numOfPieces))) //pieces in a row
        return round(box)
    }

}

