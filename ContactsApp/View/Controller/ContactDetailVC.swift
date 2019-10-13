//
//  ContactDetailVC.swift
//  ContactsApp
//
//  Created by ketan shinde on 15/09/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import UIKit
import SVProgressHUD

class ContactDetailVC: UIViewController {
    
    @IBOutlet private weak var tableViewContactsDetail : UITableView!
    
    var contactID: Int = 0
    fileprivate var viewModel = ContactDetailVM()
    fileprivate let tableProtocol = ContactDetailTableProtocol()
    var refreshControl = UIRefreshControl()

    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        refreshControl.addTarget(self, action: #selector(fetchContactsFromViewModel), for: UIControl.Event.valueChanged)
        tableViewContactsDetail.addSubview(refreshControl)

        setUpBarButtonItem()
        
        tableViewContactsDetail.tableFooterView = UIView()
        tableViewContactsDetail.register(UINib(nibName: "ContactHeaderCell", bundle: nil), forCellReuseIdentifier:ContactHeaderCell.identifier)
        tableViewContactsDetail.register(UINib(nibName: "ContactDetailsCell", bundle: nil), forCellReuseIdentifier:ContactDetailsCell.identifier)

        tableViewContactsDetail.backgroundColor = UIColor.backgroundColor()
        
        tableViewContactsDetail.dataSource = tableProtocol
        tableViewContactsDetail.delegate = tableProtocol
        
        bindViewModel()
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.clear)
        fetchContactsFromViewModel()
    }
    
    func setUpBarButtonItem() {
        
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineSpacing = 1.2
        
        let rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(EditClicked))
        rightBarButtonItem.tintColor = UIColor.seaGreenColor()
        rightBarButtonItem.setTitleTextAttributes([
            .font: UIFont.customRegularFont(size: 17.0),
            .foregroundColor: UIColor.seaGreenColor(),
            .kern: -0.4,
            .paragraphStyle: paraStyle
            ],
                                                  for: .normal)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.leftBarButtonItem?.tintColor = UIColor.seaGreenColor()
        navigationController?.navigationBar.tintColor = UIColor.seaGreenColor()
    }
    
    // MARK: - HELPERS
    
    @objc private func fetchContactsFromViewModel() {
        viewModel.fetchContactDetails(contactId: contactID)
    }
    
   private func bindViewModel() {
        viewModel.fetchHandler = { [weak self] (err) in
            SVProgressHUD.dismiss()
            guard let strongSelf = self else {
                return
            }
            strongSelf.refreshControl.endRefreshing()

            if err != nil {
                strongSelf.showAlertWithText(text: err!)
            }
            else {
                let otherArray = strongSelf.viewModel.configureDataForTable()
                strongSelf.tableProtocol.arrayDetails = otherArray
                strongSelf.tableViewContactsDetail.reloadData()
            }
        }
    
    }
    
    //MARK: - ACTIONS
    
    @objc func EditClicked() {
        
        let addEditVC = AppDelegate.mainStoryboard.instantiateViewController(withIdentifier: "ContactAddEditVC") as! ContactAddEditVC
        addEditVC.isEdit = true
        addEditVC.contactDetails = viewModel.contactDetail
        addEditVC.updateHandler = { [weak self]  in
                   guard let strongSelf = self else {
                       return
                   }
                   strongSelf.fetchContactsFromViewModel()
               }
        self.navigationController?.pushViewController(addEditVC, animated: true)
    }
}

