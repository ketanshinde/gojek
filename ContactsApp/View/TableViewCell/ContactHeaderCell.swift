//
//  ContactHeaderCell.swift
//  ContactsApp
//
//  Created by ketan shinde on 15/09/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import UIKit
import SDWebImage
import MessageUI

class ContactHeaderCell: UITableViewCell {
    
    @IBOutlet private weak var imgViewContact: UIImageView!
    @IBOutlet private weak var lblName: UILabel!
    
    @IBOutlet weak var btnMsg: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnFav: UIButton!
    
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var lblCall: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblFav: UILabel!
    
    @IBOutlet weak var viewBg: UIView!
    var contactDetails: ContactDetails!
    var topController: UIViewController?
    var favoriteHandler:((Bool?) -> Void)?
    var viewModel = ContactAddEditVM()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgViewContact.clipsToBounds = true
        imgViewContact.contentMode = .scaleAspectFill
        
        imgViewContact.layer.cornerRadius = (Utils.screenWidth()-127-127)/2
        imgViewContact.layer.borderColor = UIColor.white.cgColor
        imgViewContact.layer.borderWidth = 3
        
        lblMsg.applyAttributes("message", font: UIFont.customRegularFont(size: 12.0), textColor: UIColor.darkTextColor(), kerning: -0.5, alignment: .center)
        lblMsg.setLineSpacing(lineSpacing: 1.2)
        
        lblCall.applyAttributes("call", font: UIFont.customRegularFont(size: 12.0), textColor: UIColor.darkTextColor(), kerning: -0.5, alignment: .center)
        lblCall.setLineSpacing(lineSpacing: 1.2)
        
        lblEmail.applyAttributes("email", font: UIFont.customRegularFont(size: 12.0), textColor: UIColor.darkTextColor(), kerning: -0.5, alignment: .center)
        lblEmail.setLineSpacing(lineSpacing: 1.2)
       
        lblFav.applyAttributes("favourite", font: UIFont.customRegularFont(size: 12.0), textColor: UIColor.darkTextColor(), kerning: -0.5, alignment: .center)
        lblFav.setLineSpacing(lineSpacing: 1.2)
        viewBg.layer.insertSublayer(Utils.createLayerOfGradient(width: Utils.screenWidth(), height: 335), at: 0)
        
    }
    
    @IBAction func headerActions(_ sender: UIButton) {
        
        switch sender.tag {
        case 100:
            openMessage()
        case 200:
            callNumber()
        case 300:
            sendEmail()
        case 400:
            toggeFavorite()
        default:
            break
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    
    func loadData(item: ContactDetails) {
        contactDetails = item
        lblName.applyAttributes([item.firstName,item.lastName]
        .compactMap { $0 }
        .joined(separator: " "), font: UIFont.customBoldFont(size: 14.0), textColor: UIColor.darkTextColor(), kerning: -0.4, alignment: .center)
        //lblName.setLineSpacing(lineSpacing: 1.1)
        
        if let imgURL = item.profilePic {
            
            imgViewContact.sd_setImage(with: URL.init(string: imgURL), placeholderImage: UIImage(named: "placeholder_photo"))
        } else {
            imgViewContact.image = UIImage(named: "placeholder_photo")
        }
        
        if item.favorite! {
            btnFav.setImage(UIImage(named: "favourite_button_selected"), for: .normal)
        } else {
            btnFav.setImage(UIImage(named: "favourite_button"), for: .normal)
        }
        
        topController = Utils.getTopController()
     }
}

extension ContactHeaderCell: MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    
    
//MARK: - Message

    func openMessage() {
        
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self

        if let phNumber = contactDetails.phoneNumber {
            composeVC.recipients = [phNumber]
            
            if MFMessageComposeViewController.canSendText() {
                topController?.present(composeVC, animated: true, completion: nil)
            }
        }
        else {
            topController?.showAlertWithText(text: "Phone Number is Empty")
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled:
            print("message cancelled")
        case .failed:
            print("message failed")
        case .sent:
            print("message sent")
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
//MARK: - Call

    func callNumber() {
        
        if let phNumber = contactDetails.phoneNumber {
            
            if let phoneCallURL = URL(string: "telprompt://\(phNumber)") {

                      let application:UIApplication = UIApplication.shared
                      if (application.canOpenURL(phoneCallURL)) {
                          if #available(iOS 10.0, *) {
                              application.open(phoneCallURL, options: [:], completionHandler: nil)
                          } else {
                               application.openURL(phoneCallURL as URL)
                          }
                      }
                  }
        }
        else {
            topController?.showAlertWithText(text: "Phone Number is Empty")
        }
    }
    
//MARK: - Email
    
    func sendEmail() {
        
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        
        if let email = contactDetails.email {
            mail.setToRecipients([email])
            
            if MFMailComposeViewController.canSendMail() {
                topController?.present(mail, animated: true, completion: nil)
            }
        }
        else {
            topController?.showAlertWithText(text: "Email is Empty")
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
               case .cancelled:
                   print("mail cancelled")
               case .failed:
                   print("mail failed")
               case .sent:
                   print("mail sent")
               default:
                   break
               }
        controller.dismiss(animated: true)
    }
    
    func toggeFavorite() {
        var isFavo: Bool = false
        
        if !contactDetails.favorite! {
            isFavo = true
        }
        
        viewModel.updateFavorite(contactDetail: contactDetails, isFav: isFavo) { [weak self] (contact, error) in
            
            guard let strongSelf = self else {
                return
            }
            if error != nil {
                strongSelf.topController?.showAlertWithText(text: error!)
            } else {
                
                if (contact?.favorite)! {
                    strongSelf.btnFav.setImage(UIImage(named: "favourite_button_selected"), for: .normal)
                } else {
                    strongSelf.btnFav.setImage(UIImage(named: "favourite_button"), for: .normal)
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh_contacts"), object: nil)

            }
        }
    }
    
    
    
}
