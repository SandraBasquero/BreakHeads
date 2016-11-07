//
//  Piece.swift
//  BreakHeads
//
//  Created by Sandra Basquero on 20/10/16.
//  Copyright © 2016 SBS. All rights reserved.
//

import UIKit

class Piece: UIView {

    var lastLocation:CGPoint = CGPoint(x: 0, y: 0)
    //let contants = Constants()
    var pieces_array:[Piece] = []
    
    //****************************************************************
    // BUILD
    //****************************************************************
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.purple
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor
        fourDirectionsGesture()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //****************************************************************
    // SWIPE MOVEMENTS
    //****************************************************************
    
    //Update Piece last location --------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        // Promote the touched view
        self.superview?.bringSubview(toFront: self)
        // Remember original location
        lastLocation = self.center
    }
    
    //Build and add to view gesture recognizer, the four directions --------------
    func fourDirectionsGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(Piece.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(Piece.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.addGestureRecognizer(swipeLeft)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(Piece.respondToSwipeGesture(_:)))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(Piece.respondToSwipeGesture(_:)))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.addGestureRecognizer(swipeUp)
    }
    
    //Move in all 4 directions --------------
    func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        var newLocation:CGPoint = CGPoint(x: 0,y: 0)
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                //print("Swiped right")
                newLocation = CGPoint(x: lastLocation.x + Constants.sharer.boxSize(), y: lastLocation.y)
                self.center.x = (takenPlace(newLocation)) ? lastLocation.x + Constants.sharer.boxSize() : lastLocation.x
            case UISwipeGestureRecognizerDirection.down:
                //print("Swiped down")
                newLocation = CGPoint(x: lastLocation.x, y: lastLocation.y + Constants.sharer.boxSize())
                self.center.y = (takenPlace(newLocation)) ? lastLocation.y + Constants.sharer.boxSize() : lastLocation.y
            case UISwipeGestureRecognizerDirection.left:
                //print("Swiped left")
                newLocation = CGPoint(x: lastLocation.x - Constants.sharer.boxSize(), y: lastLocation.y)
                self.center.x = (takenPlace(newLocation)) ? lastLocation.x - Constants.sharer.boxSize() : lastLocation.x
            case UISwipeGestureRecognizerDirection.up:
                //print("Swiped up")
                newLocation = CGPoint(x: lastLocation.x, y: lastLocation.y - Constants.sharer.boxSize())
                self.center.y = (takenPlace(newLocation)) ? lastLocation.y - Constants.sharer.boxSize() : lastLocation.y
            default:
                break
            }
        }
    }
    
    //Check if there are an other Piece in this position --------------
    func takenPlace(_ futureCenter: CGPoint) -> Bool {
        var canMove = false
        for piece in pieces_array {
            //print("Nuevo: \(futureCenter) - Lugar: \(piece.center)")
            if futureCenter == piece.center {
                canMove = false
                break
            } else if futureCenter != piece.center {
                canMove = true
            }
        }
        return canMove
    }
    
}




