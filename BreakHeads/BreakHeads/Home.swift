//
//  Home.swift
//  BreakHeads
//
//  Created by Sandra Basquero on 20/10/16.
//  Copyright © 2016 SBS. All rights reserved.
//

import Foundation
import UIKit

class Home: UIViewController {
    
    @IBOutlet var levelBtns: [UIButton]!
    let popup:PopupImagesVC = PopupImagesVC(nibName:"PopupImagesVC", bundle: nil)
    @IBOutlet weak var imagePopupBtn: UIButton!
    
    //-----------------------------------------------------
    //Build
    //-----------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsStyles()
    }
    
    //****************************************************************
    // MARK: - UTILS
    //****************************************************************
    
    //-----------------------------------------------------
    //Buttons styles
    //-----------------------------------------------------
    func buttonsStyles() {
        //Level buttons styles
        for btn in levelBtns {
            btn.frame.size.width = 250 //UIScreen.main.bounds.width //220
            btn.frame.size.height = 49
            let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
            blur.frame = btn.frame
            blur.isUserInteractionEnabled = false //This allows touches to forward to the button.
            btn.insertSubview(blur, at: 0)
        }
        
        //Image popup button style
        imagePopupBtn.frame.size.width = 250
        imagePopupBtn.frame.size.height = 52
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
        blur.frame = imagePopupBtn.frame
        blur.isUserInteractionEnabled = false //This allows touches to forward to the button.
        imagePopupBtn.insertSubview(blur, at: 0)
    }
    
    //****************************************************************
    // MARK: - NAVIGATION
    //****************************************************************
    
    @IBAction func levelSelection(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            Constants.sharer.numOfPiecesPerRow = 2
        case 2:
            Constants.sharer.numOfPiecesPerRow = 3
        case 3:
            Constants.sharer.numOfPiecesPerRow = 4
        default:
            Constants.sharer.numOfPiecesPerRow = 0
        }
    }
    

    @IBAction func showImagesPopup(_ sender: AnyObject) {
        navigationController?.pushViewController(popup, animated: false)
    }
    
}

