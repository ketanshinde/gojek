//
//  ContactAddEditHeader.swift
//  ContactsApp
//
//  Created by ketan shinde on 15/09/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import UIKit
import SDWebImage

class ContactAddEditHeader: UITableViewCell {
    
    @IBOutlet weak var imgViewContact: UIImageView!
    @IBOutlet weak var viewBg: UIView!
    let imagePicker = UIImagePickerController()
    var topController: UIViewController?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgViewContact.clipsToBounds = true
        imgViewContact.contentMode = .scaleAspectFill
        
        imgViewContact.layer.cornerRadius = (Utils.screenWidth()-127-127)/2
        imgViewContact.layer.borderColor = UIColor.white.cgColor
        imgViewContact.layer.borderWidth = 3
        
        viewBg.layer.insertSublayer(Utils.createLayerOfGradient(width: Utils.screenWidth(), height: 186), at: 0)
        topController = Utils.getTopController()

    }
    
    @IBAction func headerActions(_ sender: UIButton) {
        showImagePickerOptions()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
extension ContactAddEditHeader : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showImagePickerOptions() {
        
        let alert = UIAlertController(title: "Select Image", message: "Select source to get image", preferredStyle: .alert)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
            self.showCamera()
        }
        alert.addAction(cameraAction)
        
        let albumAction = UIAlertAction(title: "Photo Library", style: .default) { action in
            self.openPhotoAlbum()
        }
        alert.addAction(albumAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in }
        alert.addAction(cancelAction)
        
        topController?.present(alert, animated: true, completion: nil)
    }
    
    func showCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            topController?.present(imagePicker, animated: true, completion: nil)
        }
        else{
            topController?.showAlertWithText(text: "Camera not available")
        }
    }
    
    func openPhotoAlbum() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        topController?.present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerController Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        guard let getImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else {
            return
        }
        imgViewContact.image = getImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
