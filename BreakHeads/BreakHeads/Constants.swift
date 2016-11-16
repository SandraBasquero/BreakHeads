//
//  Constants.swift
//  BreakHeads
//
//  Created by Sandra Basquero on 20/10/16.
//  Copyright © 2016 SBS. All rights reserved.
//

import UIKit


class Constants {

    let screenSize: CGRect = UIScreen.main.bounds
    
    //Singleton
    static var sharer = Constants()
    fileprivate init() {} //This prevents others from using the default '()' initializer for this class.
    var numOfPiecesPerRow:Int = 0
    var imagePuzzleSelected = UIImage()
    
    
    func boxSize() -> CGFloat {
        var box:CGFloat = 0 //square box size
        box = screenSize.width / CGFloat(numOfPiecesPerRow) //pieces in a row
        return round(box)
    }

    
    //****************************************************************
    // MARK: - PUZZLE IMAGES
    //****************************************************************
    
    //-----------------------------------------------------
    //Prepare the puzzle image
    //-----------------------------------------------------
    func preparedPuzzleImage() -> UIImage {
        var imagePuzzle:UIImage?
        //print(Constants.sharer.imagePuzzleSelected)
        if imagePuzzleSelected.size.width == 0.0 {
            imagePuzzle = UIImage (named: "photo-1.png") //Default image to play
        } else {
            imagePuzzle = imagePuzzleSelected
        }
        
        let imagePuzzleView = UIImageView (image: imagePuzzle)
        
        if imagePuzzleView.frame.size.width > imagePuzzleView.frame.size.height {
            imagePuzzleView.transform = CGAffineTransform(rotationAngle: CGFloat(90 * M_PI/180))
            imagePuzzle = imageRotatedByDegrees(oldImage: imagePuzzle!, deg: 90)
        }
        
        imagePuzzle = resizeImage(image: imagePuzzle!, toWidth: screenSize.width)
        
        return imagePuzzle!
    }
    
    //-----------------------------------------------------
    //Rotate an image according with given degrees
    //-----------------------------------------------------
    func imageRotatedByDegrees(oldImage: UIImage, deg degrees: CGFloat) -> UIImage {
        //Calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox: UIView = UIView(frame: CGRect(x:0, y:0, width:oldImage.size.width, height:oldImage.size.height))
        let t: CGAffineTransform = CGAffineTransform(rotationAngle: degrees * CGFloat(M_PI / 180))
        rotatedViewBox.transform = t
        let rotatedSize: CGSize = rotatedViewBox.frame.size
        //Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap: CGContext = UIGraphicsGetCurrentContext()!
        //Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        //Rotate the image context
        bitmap.rotate(by: (degrees * CGFloat(M_PI / 180)))
        //Now, draw the rotated/scaled image into the context
        bitmap.scaleBy(x: 1.0, y: -1.0)
        bitmap.draw(oldImage.cgImage!, in: CGRect(x:-oldImage.size.width / 2, y:-oldImage.size.height / 2, width:oldImage.size.width, height:oldImage.size.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    //-----------------------------------------------------
    //Resize the puzzle image keeping aspect ratio
    //-----------------------------------------------------
    func resizeImage(image:UIImage, toWidth:CGFloat) -> UIImage {
        let oldWidth = image.size.width
        let scaleFactor = toWidth/oldWidth
        
        let newHeight = image.size.height * scaleFactor
        let newWidth = oldWidth * scaleFactor
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x:0, y:0 ,width:newWidth, height:newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

