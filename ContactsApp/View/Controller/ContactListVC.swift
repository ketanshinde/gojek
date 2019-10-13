//
//  ContactListVC.swift
//  ContactsApp
//
//  Created by ketan shinde on 15/09/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import UIKit
import SVProgressHUD

class ContactListVC: UIViewController {
    
    @IBOutlet private weak var tableViewContacts : UITableView!
    
    fileprivate var viewModel = ContactsVM()
    fileprivate let tableProtocol = ContactTableProtocol()
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
                
        title = "Contact"
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"plusIcon"), style: .plain, target: self, action: #selector(addContactClicked))
        rightBarButtonItem.tintColor = UIColor.seaGreenColor()
        navigationItem.rightBarButtonItem = rightBarButtonItem

        let leftBarButtonItem = UIBarButtonItem(title: "Group", style: .plain, target: self, action: #selector(groupClicked))
        leftBarButtonItem.tintColor = UIColor.seaGreenColor()
        navigationItem.leftBarButtonItem = leftBarButtonItem

        NotificationCenter.default.addObserver(self, selector: #selector(fetchContactsFromViewModel), name: NSNotification.Name(rawValue: "refresh_contacts"), object: nil)

        tableViewContacts.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier:ContactTableViewCell.identifier)
        tableViewContacts.backgroundColor = UIColor.backgroundColor()
        
        tableViewContacts.delegate = tableProtocol
        tableViewContacts.dataSource = tableProtocol

        bindViewModel()
        fetchContactsFromViewModel()
    }
    
    // MARK: - HELPERS
    
    @objc func fetchContactsFromViewModel() {
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.clear)
        viewModel.fetchContacts()
    }
    
   private func bindViewModel() {
        viewModel.fetchHandler = { [weak self] (err) in
            
            SVProgressHUD.dismiss()
            guard let strongSelf = self else {
                return
            }

            if err != nil {
                strongSelf.showAlertWithText(text: err!)
            }
            else {
                strongSelf.createIndxedList()
            }
        }
    }
    
    
    private func createIndxedList() {
        
        viewModel.indexingContacts { [weak self] (contactDict, sectionTitle) in
            guard let strongSelf = self else {
                return
            }
          strongSelf.tableProtocol.contactDictionary = contactDict
          strongSelf.tableProtocol.contactSectionTitles = sectionTitle

          strongSelf.tableViewContacts.reloadData()
        }
    }
    
    //MARK: - ACTIONS
    @objc func addContactClicked() {
        let addEditVC = AppDelegate.mainStoryboard.instantiateViewController(withIdentifier: "ContactAddEditVC") as! ContactAddEditVC
        
        addEditVC.updateHandler = { [weak self]  in
            guard let strongSelf = self else {
                return
            }
            strongSelf.viewModel.fetchContacts()
        }
        self.navigationController?.pushViewController(addEditVC, animated: true)
    }
    
    @objc func groupClicked() {
    }

}

