//
//  Home.swift
//  BreakHeads
//
//  Created by Sandra Basquero on 20/10/16.
//  Copyright © 2016 SBS. All rights reserved.
//

import Foundation
import UIKit

class Home: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var levelBtns: [UIButton]!
    let popup:PopupImagesVC = PopupImagesVC(nibName:"PopupImagesVC", bundle: nil)
    @IBOutlet var imagesPickersBtns: [UIButton]!
    let picker = UIImagePickerController()
    
    //-----------------------------------------------------
    //Build
    //-----------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsStyles()
        picker.delegate = self
        
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
        
        /*for btn in imagesPickersBtns {
            btn.frame.size.width = 99
            btn.frame.size.height = 52
            let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
            blur.frame = btn.frame
            blur.isUserInteractionEnabled = false //This allows touches to forward to the button.
            btn.insertSubview(blur, at: 0)
        }*/
    }
    
    //****************************************************************
    // MARK: - NAVIGATION
    //****************************************************************
    
    //-----------------------------------------------------
    //Select level and start the game
    //-----------------------------------------------------
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
    
    //-----------------------------------------------------
    //Open app images gallery popup
    //-----------------------------------------------------
    @IBAction func showImagesPopup(_ sender: UIBarButtonItem) {
        navigationController?.pushViewController(popup, animated: false)
    }
    
    //-----------------------------------------------------
    //Open the device picker images
    //-----------------------------------------------------
    @IBAction func showGallery(_ sender: UIBarButtonItem) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
        picker.popoverPresentationController?.barButtonItem = sender
    }
    
    //****************************************************************
    // MARK: - DELEGATES
    //****************************************************************
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let imagePuzzle = UIImageView()
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePuzzle.contentMode = .scaleAspectFit
        imagePuzzle.image = chosenImage
        dismiss(animated:true, completion: nil)
        Constants.sharer.imagePuzzleSelected = imagePuzzle.image!
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}




