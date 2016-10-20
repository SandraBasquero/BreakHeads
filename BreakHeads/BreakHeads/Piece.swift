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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(Piece.detectPan(_:)))
        self.gestureRecognizers = [panRecognizer]
        self.backgroundColor = UIColor.purpleColor()
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Detect and move piece ---------------------------------
    func detectPan(recognizer:UIPanGestureRecognizer) {
        let translation  = recognizer.translationInView(self.superview!)
        print("Moving... " + String(translation))
        print("Last location: " + String(lastLocation))
        //self.center = CGPointMake(lastLocation.x + translation.x, lastLocation.y + translation.y)
        
        // Figure out where the user is trying to drag the view.
        var newCenter:CGPoint = CGPointMake(lastLocation.x,
                                        self.center.y + translation.y);
        
        print(newCenter.y)
        // See if the new position is in bounds.
        if (newCenter.y >= lastLocation.y-50 && newCenter.y <= lastLocation.y+50) {
            if newCenter.y > lastLocation.y {
                newCenter.y = lastLocation.y + 50
            } else {
                newCenter.y = lastLocation.y - 50
            }
            self.center = newCenter;
            recognizer .setTranslation(CGPointZero, inView: self)
        }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        // Promote the touched view
        self.superview?.bringSubviewToFront(self)
        
        // Remember original location
        lastLocation = self.center
    }
}
