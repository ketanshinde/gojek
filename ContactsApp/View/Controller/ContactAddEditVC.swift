//
//  ContactAddEditVC.swift
//  ContactsApp
//
//  Created by ketan shinde on 15/09/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import UIKit
import SVProgressHUD

class ContactAddEditVC: UIViewController {
    
    @IBOutlet private weak var tableViewAddEdit : UITableView!
    
    var contactID: Int = 0
    fileprivate var viewModel = ContactAddEditVM()
    fileprivate let tableProtocol = ContactAddTableProtocol()
    fileprivate let tableEditProtocol = ContactEditTableProtocol()

    var contactDetails: ContactDetails?
    var isEdit: Bool = false
    var updateHandler:(() -> Void)?

    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpBarButtonItems()
        
        tableViewAddEdit.tableFooterView = UIView()
        tableViewAddEdit.register(UINib(nibName: "ContactAddEditHeader", bundle: nil), forCellReuseIdentifier:ContactAddEditHeader.identifier)
        tableViewAddEdit.register(UINib(nibName: "ContactAddEditCell", bundle: nil), forCellReuseIdentifier:ContactAddEditCell.identifier)

        tableViewAddEdit.backgroundColor = UIColor.backgroundColor()
        
        if isEdit {
            tableViewAddEdit.dataSource = tableEditProtocol
            tableViewAddEdit.delegate = tableEditProtocol
        } else {
            tableViewAddEdit.dataSource = tableProtocol
            tableViewAddEdit.delegate = tableProtocol
        }

        bindViewModel()
        getDataSource()
    }
    // MARK: - UI
    
    private func setUpBarButtonItems() {
        
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineSpacing = 1.2
        
        let rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClicked))
        rightBarButtonItem.tintColor = UIColor.seaGreenColor()
        rightBarButtonItem.setTitleTextAttributes([
                .font: UIFont.customRegularFont(size: 17.0),
                .foregroundColor: UIColor.seaGreenColor(),
                .kern: -0.4,
                .paragraphStyle: paraStyle
        ], for: .normal)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClicked))
        leftBarButtonItem.tintColor = UIColor.seaGreenColor()
        leftBarButtonItem.setTitleTextAttributes([
                .font: UIFont.customRegularFont(size: 17.0),
                .foregroundColor: UIColor.seaGreenColor(),
                .kern: -0.4,
                .paragraphStyle: paraStyle
        ], for: .normal)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.seaGreenColor()
        navigationController?.navigationBar.tintColor = UIColor.seaGreenColor()
    }
    
    // MARK: - HELPERS
    
    private func getDataSource() {
        
        if isEdit {
            tableEditProtocol.editableContact = contactDetails
            tableEditProtocol.imageURLStr = contactDetails?.profilePic ?? ""
            tableEditProtocol.arrayDetails = viewModel.configureDataForTable(contactDetail: contactDetails!)
        } else {
            tableProtocol.arrayDetails = viewModel.createDataSource()
        }
        tableViewAddEdit.reloadData()
    }
    
    private func bindViewModel() {
    }
    
    private func validateNewContact() -> Bool {
        if tableProtocol.newContact.first_name.isEmpty {
            showAlertWithText(text: "First Name Cannot Be Empty.")
            return false
        } else if tableProtocol.newContact.last_name.isEmpty {
            showAlertWithText(text: "Last Name Cannot Be Empty.")
            return false
        } else if tableProtocol.newContact.email.isEmpty {
            showAlertWithText(text: "Email Cannot Be Empty.")
            return false
        } else if tableProtocol.newContact.phone_number.isEmpty {
            showAlertWithText(text: "Phone Number Cannot Be Empty.")
            return false
        }
        return true
    }
    
    func addNewContact() {
        if validateNewContact() {
                   
                   SVProgressHUD.show()
                   SVProgressHUD.setDefaultMaskType(.clear)

                   viewModel.postNewContact(newContact: tableProtocol.newContact) { [weak self] (contact, error) in
                       
                       SVProgressHUD.dismiss()
                       guard let strongSelf = self else {
                           return
                       }
                       if error != nil {
                           strongSelf.showAlertWithText(text: error!)
                       } else {
                           strongSelf.updateHandler?()
                           strongSelf.navigationController?.popViewController(animated: true)
                       }
                   }
               }
    }
    
    func editNewContact() {
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.clear)

        viewModel.updateContact(contactDetail: tableEditProtocol.editableContact) { [weak self] (contact, error) in
            
            SVProgressHUD.dismiss()
            guard let strongSelf = self else {
                return
            }
            
            if error != nil {
                strongSelf.showAlertWithText(text: error!)
            } else {
                strongSelf.updateHandler?()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                  strongSelf.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    //MARK: - ACTIONS
    @objc func doneClicked() {
        
        if isEdit {
            self.editNewContact()
        } else {
            self.addNewContact()
        }
    }
    
    @objc func cancelClicked() {
        navigationController?.popViewController(animated: true)
    }
}

