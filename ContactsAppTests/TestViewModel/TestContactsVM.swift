//
//  TestContactsVM.swift
//  ContactsAppTests
//
//  Created by Ketan on 10/10/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import XCTest
@testable import ContactsApp

class TestContactsVM: XCTestCase {
    
    private var sut: ContactsVM!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ContactsVM()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIndexingContacts() {
        
        // Given
        var contactSectionTitles = [String]()
        var contactDictionary = [String: [Contacts]]()
        
        var testArrayContacts: [Contacts] = []
        let contact = Contacts(id: 1234, firstName: "ketan", lastName: "shinde",
                               profilePic: "/missing", favorite: false, url: "https://some_url")
        testArrayContacts.append(contact)
        
        sut.arrayContacts = testArrayContacts
        XCTAssertEqual(sut.arrayContacts, testArrayContacts)
        
        // When
        let exp = expectation(description: "Check If Index Array Created")
        sut.indexingContacts {  (contactDict, sectionTitle) in
            
            contactSectionTitles = sectionTitle
            contactDictionary = contactDict
            exp.fulfill()
        }

        // Then
        waitForExpectations(timeout: 3) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertEqual(contactDictionary, ["k":  testArrayContacts])
            XCTAssertEqual(contactSectionTitles, ["k"])
        }
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
