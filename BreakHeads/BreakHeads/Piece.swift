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
    // MARK: - BUILD
    //****************************************************************
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor.black.cgColor
        fourDirectionsGesture()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //****************************************************************
    // MARK: - SWIPE MOVEMENTS
    //****************************************************************
    
    //Update Piece last location --------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        // Promote the touched view
        self.superview?.bringSubview(toFront: self)
        super.touchesBegan(touches, with: event) //allows detect pieces events from the superview
        // Remember original location
        lastLocation = self.center
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Promote the touched view
        self.superview?.bringSubview(toFront: self)
        super.touchesEnded(touches, with: event) //allows detect pieces events from the superview
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.superview?.bringSubview(toFront: self)
        super.touchesMoved(touches, with: event) //allows detect pieces events from the superview
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.superview?.bringSubview(toFront: self)
        super.touchesMoved(touches, with: event) //allows detect pieces events from the superview
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
        let screenSize: CGRect = UIScreen.main.bounds
        
        for piece in pieces_array {
            //print("Nuevo: \(futureCenter) - Lugar: \(piece.center)")
            if futureCenter == piece.center {
                canMove = false //true  to test
                break
            } else if futureCenter != piece.center && (futureCenter.x > 0 && futureCenter.x < screenSize.width) {
                canMove = true
            }
        }
        return canMove
    }
    
}




