//
//  PopupImagesVC.swift
//  BreakHeads
//
//  Created by Sandra Basquero on 16/11/16.
//  Copyright © 2016 SBS. All rights reserved.
//

import UIKit

class PopupImagesVC: UIViewController {

    @IBOutlet weak var imagesScroll: UIScrollView!
    var imagesBtnsArray:[UIButton] = []
    var yPoint:CGFloat = 0.0
    var xPoint:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagesScroll.frame = UIScreen.main.bounds
        //Render images/buttons in popup scrollview
        for i in 1...3 {
             let imageBtn = UIButton.init(frame:  CGRect(x: xPoint, y: yPoint, width: (self.imagesScroll.frame.width/2)-10, height: (self.imagesScroll.frame.width/2)+15))
            imageBtn.tag = i
            imageBtn.isUserInteractionEnabled = true
            fillBtns(btn: imageBtn)
            imageBtn.addTarget(self, action: #selector(imageSelected(btn:)), for: .touchUpInside)
            imagesBtnsArray.append(imageBtn)
            if xPoint > 0.0 {
                yPoint = yPoint + imageBtn.frame.size.height + 3
                xPoint = 0.0
            } else {
                xPoint = xPoint +  imageBtn.frame.size.width
            }
        }
        
        for btn in imagesBtnsArray {
            imagesScroll.addSubview(btn)
        }
    }

    
    func imageSelected(btn:UIButton) {
        print("btn seleccionado \(btn.tag)")
        Constants.sharer.imagePuzzleSelected = UIImage(named: "photo-\(btn.tag).png")!
        navigationController?.popViewController(animated:true)
    }
    
    //-----------------------------------------------------
    //Prepare images for buttons
    //-----------------------------------------------------
    func fillBtns(btn:UIButton) {
        var imagePuzzle = UIImage (named: "photo-\(btn.tag).png")
         self.imagesScroll.frame = UIScreen.main.bounds
         imagePuzzle = Constants.sharer.resizeImage(image: imagePuzzle!, toWidth: (self.imagesScroll.frame.width/2)-10)
         //Crop the full image
         let imageCg = imagePuzzle?.cgImage?.cropping(to: CGRect(x: 0, y: 0, width: (self.imagesScroll.frame.width/2)-10, height: (self.imagesScroll.frame.width/2)+10))
         let crop:UIImage = UIImage.init(cgImage: imageCg!)
         
         
         let imageView = UIImageView(image: crop)
         imageView.frame.origin.x = 0
         imageView.frame.origin.y = 0
         btn.addSubview(imageView)
        
        imagesScroll.contentSize.height = yPoint
    }
    
    
    //-----------------------------------------------------
    //Navigation
    //-----------------------------------------------------
    @IBAction func backToHome(_ sender: AnyObject) {
         navigationController?.popViewController(animated:false)
    }

}
