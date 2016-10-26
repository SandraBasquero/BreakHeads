//
//  Player.swift
//  BreakHeads
//
//  Created by Sandra Basquero on 20/10/16.
//  Copyright © 2016 SBS. All rights reserved.
//

import UIKit

class Player: UIViewController {
    
    //Variables
    @IBOutlet weak var contentPieces: UIView!
    let numOfPiecesPuzzle = Constants.sharer.numOfPieces
    var piecesArray:[Piece] = []
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var tempWidth:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillContentPieces()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Render puzzle ---------------------------------------
    func fillContentPieces() {
        var pointX:CGFloat = 0
        var pointY:CGFloat = 0
        
        // Add the Views
        for _ in 1...numOfPiecesPuzzle {
            let newPiece = Piece(frame: CGRectMake(pointX, pointY, Constants.sharer.boxSize(), Constants.sharer.boxSize()))
            self.contentPieces.addSubview(newPiece)
            piecesArray.append(newPiece)
            pointX = pointX + Constants.sharer.boxSize()
            tempWidth = tempWidth + Constants.sharer.boxSize()
            //Reset values in each new row
            if tempWidth >= screenSize.width {
                pointY = pointY + Constants.sharer.boxSize()
                tempWidth = 0
                pointX = 0
                tempWidth = 0
            }
        }
        //Fill the pieces array of each piece
        for piece in piecesArray {
            piece.pieces_array = piecesArray
        }
    }
    
    
    
    //****************************************************************
    // NAVIGATION
    //****************************************************************
    
    @IBAction func backHome(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
