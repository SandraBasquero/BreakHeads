//
//  Player.swift
//  BreakHeads
//
//  Created by Sandra Basquero on 20/10/16.
//  Copyright © 2016 SBS. All rights reserved.
//

import UIKit

class Player: UIViewController {
    //Elements
    @IBOutlet weak var contentPieces: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.blueColor()
        fillContentPieces()
        
        
        let halfSizeOfView = 25.0
        let maxViews = 2
        let insetSize = CGRectInset(self.view.bounds, CGFloat(Int(2 * halfSizeOfView)), CGFloat(Int(2 * halfSizeOfView))).size
        // Add the Views
        for i in 0..<maxViews {
            var pointX = CGFloat(UInt(arc4random() % UInt32(UInt(insetSize.width))))
            var pointY = CGFloat(UInt(arc4random() % UInt32(UInt(insetSize.height))))
            
            var newView = Piece(frame: CGRectMake(pointX, pointY, 50, 50))
            self.view.addSubview(newView)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Render puzzle ---------------------------------------
    func fillContentPieces(){
        let littleBox = UIView(frame: CGRectMake(0, 0, 80, 80))
        littleBox.backgroundColor = UIColor.greenColor()
        self.contentPieces.addSubview(littleBox)
    }
    
    
    //Navigation -------------------------------------------
    @IBAction func backHome(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
