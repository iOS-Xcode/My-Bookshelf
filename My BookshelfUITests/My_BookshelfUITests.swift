
//
//  My_BookshelfUITests.swift
//  My BookshelfUITests
//
//  Created by Seokhyun Kim on 2021-02-15.
//

import XCTest
import My_Bookshelf

@testable import My_Bookshelf

class My_BookshelfUITests: XCTestCase {
    
    override func setUp() {
        continueAfterFailure = false
    }
    func testBookshelfUI() {
        XCUIApplication().launch()
        
        let app = XCUIApplication()
        let myBookshelfNavigationBar = app.navigationBars["My Bookshelf"]
        myBookshelfNavigationBar.buttons["Search"].tap()
        myBookshelfNavigationBar/*@START_MENU_TOKEN@*/.staticTexts["Cancel"]/*[[".staticTexts.matching(identifier: \"My Bookshelf\")",".buttons[\"Cancel\"].staticTexts[\"Cancel\"]",".staticTexts[\"Cancel\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let tablesQuery = app.tables
        let tablesQuery2 = tablesQuery
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Kotlin Cookbook").element/*[[".cells.containing(.staticText, identifier:\"$34.99\").element",".cells.containing(.staticText, identifier:\"9781492046677\").element",".cells.containing(.staticText, identifier:\"Kotlin Cookbook\").element"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery2/*@START_MENU_TOKEN@*/.buttons["URL : https://itbook.store/books/9781492046677"]/*[[".cells.buttons[\"URL : https:\/\/itbook.store\/books\/9781492046677\"]",".buttons[\"URL : https:\/\/itbook.store\/books\/9781492046677\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.statusBars/*@START_MENU_TOKEN@*/.buttons["breadcrumb"]/*[[".buttons[\"Return to My Bookshelf\"]",".buttons[\"breadcrumb\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"ISBN10 : 1492046671").element/*[[".cells.containing(.staticText, identifier:\"Rating : 4\/5\").element",".cells.containing(.staticText, identifier:\"ISBN13 : 9781492046677\").element",".cells.containing(.button, identifier:\"COMMENT\").element",".cells.containing(.staticText, identifier:\"Comment\").element",".cells.containing(.button, identifier:\"URL : https:\/\/itbook.store\/books\/9781492046677\").element",".cells.containing(.staticText, identifier:\"Price : $34.99\").element",".cells.containing(.staticText, identifier:\"ISBN10 : 1492046671\").element"],[[[-1,6],[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"ISBN10 : 1492046671")/*[[".cells.containing(.staticText, identifier:\"Rating : 4\/5\")",".cells.containing(.staticText, identifier:\"ISBN13 : 9781492046677\")",".cells.containing(.button, identifier:\"COMMENT\")",".cells.containing(.staticText, identifier:\"Comment\")",".cells.containing(.button, identifier:\"URL : https:\/\/itbook.store\/books\/9781492046677\")",".cells.containing(.staticText, identifier:\"Price : $34.99\")",".cells.containing(.staticText, identifier:\"ISBN10 : 1492046671\")"],[[[-1,6],[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .other).element(boundBy: 0).swipeUp()
        tablesQuery2/*@START_MENU_TOKEN@*/.buttons["COMMENT"]/*[[".cells.buttons[\"COMMENT\"]",".buttons[\"COMMENT\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let elementsQuery = app.alerts.scrollViews.otherElements
        elementsQuery.buttons["Set 3+1 Rating"].tap()
        elementsQuery.collectionViews/*@START_MENU_TOKEN@*/.textFields["Let me know your experience"]/*[[".cells.textFields[\"Let me know your experience\"]",".textFields[\"Let me know your experience\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        elementsQuery.buttons["Yes"].tap()
        

    }
}
