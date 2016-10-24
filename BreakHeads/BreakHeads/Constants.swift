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
    var numOfPiecesEasy = 9 //number of piece in the puzzle
    var numOfPiecesMedium = 16 //number of piece in the puzzle
    var numOfPiecesHard = 25 //number of piece in the puzzle
    //var numOfPieces:Int?
    //var level:String = ""
    
    
    
    
    func boxSize() -> CGFloat {
        var box:CGFloat = 0 //square box size
        box = screenSize.width / CGFloat(sqrt(CGFloat(numOfPiecesMedium))) //pieces in a row
        return round(box)
    }
    
    /*func setLevel() -> Int {
        switch level {
        case "easy":
            numOfPieces = 9
        case "medium":
            numOfPieces = 16
        case "hard":
            numOfPieces = 25
        default:
            numOfPieces = -1 //OJOOOO!!!!
        }
        return numOfPieces!
    }*/
}

