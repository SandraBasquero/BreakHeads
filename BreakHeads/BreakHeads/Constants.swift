//
//  Constants.swift
//  BreakHeads
//
//  Created by Sandra Basquero on 20/10/16.
//  Copyright © 2016 SBS. All rights reserved.
//

import UIKit


class Constants {

    let screenSize: CGRect = UIScreen.main.bounds
    
    //Singleton
    static var sharer = Constants()
    fileprivate init() {} //This prevents others from using the default '()' initializer for this class.
    var numOfPiecesPerRow:Int = 0
    
    
    func boxSize() -> CGFloat {
        var box:CGFloat = 0 //square box size
        box = screenSize.width / CGFloat(numOfPiecesPerRow) //pieces in a row
        return round(box)
    }

}

