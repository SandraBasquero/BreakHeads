//
//  Piece.swift
//  BreakHeads
//
//  Created by Sandra Basquero on 20/10/16.
//  Copyright © 2016 SBS. All rights reserved.
//

import UIKit

class Piece: UIView {

    var lastLocation:CGPoint = CGPointMake(0, 0)
    let contants = Constants()
    
    
    //****************************************************************
    // BUILD
    //****************************************************************
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.purpleColor()
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.blackColor().CGColor
        fourDirectionsGesture()
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //****************************************************************
    // SWIPE MOVEMENTS
    //****************************************************************
    
    //Update Piece last location --------------
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        // Promote the touched view
        self.superview?.bringSubviewToFront(self)
        // Remember original location
        lastLocation = self.center
    }
    
    //Build and add to view gesture recognizer, the four directions --------------
    func fourDirectionsGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(Piece.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(Piece.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.addGestureRecognizer(swipeLeft)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(Piece.respondToSwipeGesture(_:)))
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(Piece.respondToSwipeGesture(_:)))
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.addGestureRecognizer(swipeUp)
    }
    
    //Move in all 4 directions --------------
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                //print("Swiped right")
                self.center.x = lastLocation.x + contants.boxSize
            case UISwipeGestureRecognizerDirection.Down:
                //print("Swiped down")
                self.center.y = lastLocation.y + contants.boxSize
            case UISwipeGestureRecognizerDirection.Left:
                //print("Swiped left")
                self.center.x = lastLocation.x - contants.boxSize
            case UISwipeGestureRecognizerDirection.Up:
                //print("Swiped up")
                self.center.y = lastLocation.y - contants.boxSize
            default:
                break
            }
        }
    }
    
}
