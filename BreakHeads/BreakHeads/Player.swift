//
//  Player.swift
//  BreakHeads
//
//  Created by Sandra Basquero on 20/10/16.
//  Copyright © 2016 SBS. All rights reserved.
//

import UIKit

extension Array {
    /** Randomizes the order of an array's elements. */
    mutating func shuffle() {
        for _ in 0..<6 {
            //print(i)
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

class Player: UIViewController {
    
    //Variables
    @IBOutlet weak var contentPieces: UIView!
    let numOfPiecesInRow = Constants.sharer.numOfPiecesPerRow
    let pieceSize = Constants.sharer.boxSize()
    var piecesArray:[Piece] = []
    let screenSize: CGRect = UIScreen.main.bounds
    var tempWidth:CGFloat = 0
    var correctCenters:[CGPoint] = []
    var currentCenters:[CGPoint] = []
    
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
                let newPiece = Piece(frame: CGRect(x: pointX, y: pointY, width: pieceSize, height: pieceSize))
                newPiece.tag = counter
                counter = counter+1
                self.contentPieces.addSubview(newPiece)
                piecesArray.append(newPiece)
                correctCenters.append(newPiece.center)
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
        correctCenters.removeLast()
        
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
            let newPiece = Piece(frame: CGRect(x: topX, y: 0 - pieceSize, width: pieceSize, height: pieceSize))
            self.contentPieces.addSubview(newPiece)
            piecesArray.append(newPiece)
            topX = topX + pieceSize
            //Avoid to move those top pieces
            newPiece.gestureRecognizers?.forEach(newPiece.removeGestureRecognizer)
            //Make them invisibles
            newPiece.backgroundColor = UIColor.clear
            newPiece.layer.borderWidth = 0
        }
    }
    
    //-----------------------------------------------------
    //Render a last bottom line of pieces to limit down movements
    //-----------------------------------------------------
    func bottomPiecesBound(_ bottomY:CGFloat) {
        var bottomX:CGFloat = 0
        for _ in 1...numOfPiecesInRow {
            let newPiece = Piece(frame: CGRect(x: bottomX, y: bottomY, width: pieceSize, height: pieceSize))
            self.contentPieces.addSubview(newPiece)
            piecesArray.append(newPiece)
            bottomX = bottomX + pieceSize
            //Avoid to move those last pieces
            newPiece.gestureRecognizers?.forEach(newPiece.removeGestureRecognizer)
            //Make them invisibles
            newPiece.backgroundColor = UIColor.clear
            newPiece.layer.borderWidth = 0
        }
    }

    //-----------------------------------------------------
    //In each piece, its tag number
    //-----------------------------------------------------
    func fillingEachPiece(_ piece:UIView) {
        let labelText = UILabel(frame: CGRect(x: 0, y: 0, width: piece.frame.size.width, height: piece.frame.size.height))
        labelText.backgroundColor = UIColor.orange
        labelText.text = String(piece.tag)
        labelText.textAlignment = NSTextAlignment.center
        piece.addSubview(labelText)
    }
    
    
    //****************************************************************
    // MIXING PIECES
    //****************************************************************
    
    @IBAction func mixPieces(_ sender: UIButton) {
        //Save the current center of the pieces
        for piece in piecesArray {
            if piece.tag != 0 {
                currentCenters.append(piece.center)
            }
        }
        //Mix the center of the pieces
        currentCenters.shuffle()
        
        //Set new center to each piece
        var counter = 0
        for piece in piecesArray {
            if piece.tag != 0 {
                piece.center = currentCenters[counter]
                counter = counter+1
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        print("nos movemos??")
        var win:Bool?
        
        print("Correcto: \(correctCenters.count) - Actual: \(currentCenters.count)")
        
        if currentCenters.count == correctCenters.count {
            for i in 0..<correctCenters.count {
                print("Correcto: \(correctCenters[i]) - Actual: \(currentCenters[i])")
                if correctCenters[i] == currentCenters[i] {
                    win = true
                } else {
                    win = false
                    break
                }
            }
        }
         print("YOU WIN? -> \(win)")
    }
    
    
    //****************************************************************
    // NAVIGATION
    //****************************************************************
    
    @IBAction func backHome(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
