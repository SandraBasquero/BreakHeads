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
    var mixed = false
    var showTagNumbers = false
    let popupImage:PopupFullImageCV = PopupFullImageCV(nibName:"PopupFullImageCV", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillContentPieces(image: Constants.sharer.preparedPuzzleImage())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //****************************************************************
    // MARK: - RENDERING THE PUZZLE
    //****************************************************************
    
    //-----------------------------------------------------
    //Render pieces
    //-----------------------------------------------------
    func fillContentPieces(image:UIImage) {
        var pointX:CGFloat = 0
        var pointY:CGFloat = 0
        var counter = 1
        
        //Adding news rows
        while pointY + pieceSize <= (screenSize.height-60) {  //TODO: replace 60!
            //Filling each row with Pieces
            for _ in 1...numOfPiecesInRow {
                //Crop the full image
                let imageCg = image.cgImage?.cropping(to: CGRect(x: pointX, y: pointY, width: pieceSize, height: pieceSize))
                let crop:UIImage = UIImage.init(cgImage: imageCg!)
                //Build each piece
                let newPiece = Piece(frame: CGRect(x: pointX, y: pointY, width: pieceSize, height: pieceSize))
                newPiece.tag = counter
                counter = counter+1
                self.contentPieces.addSubview(newPiece)
                piecesArray.append(newPiece)
                correctCenters.append(newPiece.center)
                fillingEachPiece(piece: newPiece, image: crop)
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
            //Avoid pieces to move until they are mixed
            piece.gestureRecognizers?.forEach(piece.removeGestureRecognizer)
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
    //In each piece, its tag number and a cropped image
    //-----------------------------------------------------
    func fillingEachPiece(piece:UIView, image:UIImage) {
        piece.addSubview(UIImageView(image: image))
        
        let labelText = UILabel(frame: CGRect(x: 0, y: 0, width: piece.frame.size.width, height: piece.frame.size.height))
        //labelText.backgroundColor = UIColor.orange
        labelText.textColor = UIColor.clear
        labelText.text = String(piece.tag)
        labelText.textAlignment = NSTextAlignment.center
        piece.addSubview(labelText)
    }
    
    
    //****************************************************************
    // MARK: - MIXING PIECES
    //****************************************************************
    
    //-----------------------------------------------------
    //Change center pieces to change the sort
    //-----------------------------------------------------
    @IBAction func mixPieces(_ sender: UIButton) {
        var currentCenters:[CGPoint] = []
        //Save the current center of the pieces
        for piece in piecesArray {
            if piece.tag != 0 {
                currentCenters.append(piece.center)
                piece.fourDirectionsGesture() //Pieces can move now
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
        mixed = true
    }
    
    //-----------------------------------------------------
    //Check, everytime a piece moves, if the sort is correct
    //-----------------------------------------------------
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var win:Bool = false
        var currentCenters:[CGPoint] = []
        
        for piece in piecesArray {
            if piece.tag != 0 {
                //print("pieza \(piece.tag) está en \(piece.center)")
                currentCenters.append(piece.center)
            }
        }
        
        if currentCenters.count == correctCenters.count {
            for i in 0..<correctCenters.count {
                //print("Correcto: \(correctCenters[i]) - Actual: \(currentCenters[i])")
                if correctCenters[i] == currentCenters[i] {
                    win = true
                } else {
                    win = false
                    break
                }
            }
        }
        //Show alerts
        if mixed && win {
            winMessage()
        } else if !mixed && win {
            mixerMessage()
        }
    }
    
 
    //****************************************************************
    // MARK: - NAVIGATION
    //****************************************************************
    
    @IBAction func backHome(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showFullImage(_ sender: AnyObject) {
        navigationController?.pushViewController(popupImage, animated: false)
    }
    
    //****************************************************************
    // MARK: - UTILS
    //****************************************************************
    
    //-----------------------------------------------------
    //Show or hide the number in each piece  
    //-----------------------------------------------------
    @IBAction func showNumbers(_ sender: AnyObject) {
        showTagNumbers = showTagNumbers ? false : true
        let colorNums = showTagNumbers ? UIColor.white : UIColor.clear
        
        for piece in piecesArray {
            if piece.tag != 0 {
                for label:UIView in piece.subviews {
                    if label.isKind(of: UILabel.self) {
                        let lab = label as! UILabel
                        lab.textColor = colorNums
                    }
                }
            }
        }
    }
    
    //****************************************************************
    // MARK: - ALERT MESSAGES
    //****************************************************************
    
    //-----------------------------------------------------
    //Show a popup message when you win
    //-----------------------------------------------------
    func winMessage() {
        let alert = UIAlertController(title: "YOU WIN!!", message: "You're sooo smart!", preferredStyle: UIAlertControllerStyle.alert)
        self.present(alert, animated: true, completion: nil)
        
        // change to desired number of seconds (in this case 5 seconds)
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    //-----------------------------------------------------
    //Show a popup message to recall mixing the pieces before start
    //-----------------------------------------------------
    func mixerMessage() {
        let alert = UIAlertController(title: "", message: "Mix the pieces to start the game", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        // change to desired number of seconds (in this case 5 seconds)
        let when = DispatchTime.now() + 8
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
