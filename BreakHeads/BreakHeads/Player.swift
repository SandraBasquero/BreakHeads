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
    let numOfPiecesInRow = Constants.sharer.numOfPiecesPerRow
    let pieceSize = Constants.sharer.boxSize()
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
    
    
    //****************************************************************
    // RENDERING THE PUZZLE
    //****************************************************************
    
    //-----------------------------------------------------
    //Render pieces
    //-----------------------------------------------------
    func fillContentPieces() {
        var pointX:CGFloat = 0
        var pointY:CGFloat = 0
        var counter = 1
        
        //Adding news rows
        while pointY + pieceSize <= (screenSize.height-60) {  //TODO: replace 60!
            //Filling each row with Pieces
            for _ in 1...numOfPiecesInRow {
                let newPiece = Piece(frame: CGRectMake(pointX, pointY, pieceSize, pieceSize))
                newPiece.tag = counter
                counter = counter+1
                self.contentPieces.addSubview(newPiece)
                piecesArray.append(newPiece)
                fillingEachPiece(newPiece)
                pointX = pointX + pieceSize
                tempWidth = tempWidth + pieceSize
                //Reset values in each new row
                if tempWidth >= screenSize.width {
                    pointY = pointY + pieceSize
                    tempWidth = 0
                    pointX = 0
                }
            }
        }
        
        //Delete the last Piece in Puzzle in order to can move the others
        piecesArray.removeLast()
        self.contentPieces.subviews[self.contentPieces.subviews.count - 1].removeFromSuperview()
        
        //Bounding top and bottom pieces
        topPiecesBound()
        bottomPiecesBound(pointY)
        
        //Fill the pieces array of each piece
        for piece in piecesArray {
            piece.pieces_array = piecesArray
        }
    }
    
    //-----------------------------------------------------
    //Render a top line of pieces to limit up movements
    //-----------------------------------------------------
    func topPiecesBound() {
        var topX:CGFloat = 0
        for _ in 1...numOfPiecesInRow {
            let newPiece = Piece(frame: CGRectMake(topX, 0 - pieceSize, pieceSize, pieceSize))
            self.contentPieces.addSubview(newPiece)
            piecesArray.append(newPiece)
            topX = topX + pieceSize
            //Avoid to move those top pieces
            newPiece.gestureRecognizers?.forEach(newPiece.removeGestureRecognizer)
            //Make them invisibles
            newPiece.backgroundColor = UIColor.clearColor()
            newPiece.layer.borderWidth = 0
        }
    }
    
    //-----------------------------------------------------
    //Render a last bottom line of pieces to limit down movements
    //-----------------------------------------------------
    func bottomPiecesBound(bottomY:CGFloat) {
        var bottomX:CGFloat = 0
        for _ in 1...numOfPiecesInRow {
            let newPiece = Piece(frame: CGRectMake(bottomX, bottomY, pieceSize, pieceSize))
            self.contentPieces.addSubview(newPiece)
            piecesArray.append(newPiece)
            bottomX = bottomX + pieceSize
            //Avoid to move those last pieces
            newPiece.gestureRecognizers?.forEach(newPiece.removeGestureRecognizer)
            //Make them invisibles
            newPiece.backgroundColor = UIColor.clearColor()
            newPiece.layer.borderWidth = 0
        }
    }

    
    func fillingEachPiece(piece:UIView) {
        let labelText = UILabel(frame: CGRectMake(0, 0, piece.frame.size.width, piece.frame.size.height))
        labelText.backgroundColor = UIColor.orangeColor()
        labelText.text = String(piece.tag)
        labelText.textAlignment = NSTextAlignment.Center
        piece.addSubview(labelText)
    }
    
    
    //****************************************************************
    // NAVIGATION
    //****************************************************************
    
    @IBAction func backHome(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
