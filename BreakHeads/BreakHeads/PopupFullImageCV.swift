//
//  PopupFullImageCV.swift
//  BreakHeads
//
//  Created by Sandra Basquero on 16/11/16.
//  Copyright © 2016 SBS. All rights reserved.
//

import UIKit

class PopupFullImageCV: UIViewController {

    @IBOutlet weak var viewContentImage: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageFullView = UIImageView(image: Constants.sharer.preparedPuzzleImage())
        imageFullView.frame.origin.y = 60 //TODO: replace 60!
        self.viewContentImage.addSubview(imageFullView)
    }
    
    /*
    func preparedPuzzleImage() -> UIImage {
        var imagePuzzle:UIImage?
        print(Constants.sharer.imagePuzzleSelected)
        if Constants.sharer.imagePuzzleSelected.size.width == 0.0 {
            imagePuzzle = UIImage (named: "photo-1.png") //Default image to play
        } else {
            imagePuzzle = Constants.sharer.imagePuzzleSelected
        }
        
        let imagePuzzleView = UIImageView (image: imagePuzzle)
        
        if imagePuzzleView.frame.size.width > imagePuzzleView.frame.size.height {
            imagePuzzleView.transform = CGAffineTransform(rotationAngle: CGFloat(90 * M_PI/180))
            imagePuzzle = Constants.sharer.imageRotatedByDegrees(oldImage: imagePuzzle!, deg: 90)
        }
        
        imagePuzzle = Constants.sharer.resizeImage(image: imagePuzzle!, toWidth: UIScreen.main.bounds.width)
        
        return imagePuzzle!
    }*/
    
    @IBAction func closeFullImage(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: false)
    }
    
}
