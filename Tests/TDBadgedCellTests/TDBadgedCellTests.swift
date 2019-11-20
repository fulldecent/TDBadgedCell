//
//  File.swift
//  
//
//  Created by Yaroslav Zhurakovskiy on 19.11.2019.
//

import XCTest
import TDBadgedCell

class TDBadgedCellTests: XCTestCase {
    func testSmoke() {
        let cell: UITableViewCell = TDBadgedCell()
        
        XCTAssertNotNil(cell)
    }
}
