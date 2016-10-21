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
    var piecesArray = [Piece?](count:3 , repeatedValue:nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
       /* for _ in 1...contants.numOfPieces {
            pointX = pointX + contants.boxSize
            let newPiece = Piece(frame: CGRectMake(pointX, pointY, contants.boxSize, contants.boxSize))
            self.contentPieces.addSubview(newPiece)
            piecesArray.append(newPiece)
        }*/
        
        for i in 0...piecesArray.count-1 {
            pointX = pointX + contants.boxSize
            piecesArray[i] = Piece(frame: CGRectMake(pointX, pointY, contants.boxSize, contants.boxSize), arrayPieces:piecesArray)
            self.contentPieces.addSubview(piecesArray[i]!)
        }
        print(piecesArray)
    }
    
    
    
    //Navigation -------------------------------------------
    @IBAction func backHome(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
