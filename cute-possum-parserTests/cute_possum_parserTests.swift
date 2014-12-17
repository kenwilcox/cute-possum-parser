//
//  cute_possum_parserTests.swift
//  cute-possum-parserTests
//
//  Created by Evgenii Neumerzhitckii on 18/12/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit
import XCTest
import cute_possum_parser

class cute_possum_parserTests: XCTestCase {
  
    func testParseBrushtailPossum() {
      let json = TestJsonLoader.read("brushtail_possum.json.json")
      
      struct Possum {
        let species: String
      }
      
      let p = CutePossumParser(json: json)
      
      let model = Possum(
        species: p.
      )
      
      
      
      
      XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
