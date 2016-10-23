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
    let contants = Constants()
    var piecesArray:[Piece] = []
    
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
        for _ in 1...contants.numOfPieces {
            let newPiece = Piece(frame: CGRectMake(pointX, pointY, contants.boxSize(), contants.boxSize()))
            self.contentPieces.addSubview(newPiece)
            piecesArray.append(newPiece)
            pointX = pointX + contants.boxSize()
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
