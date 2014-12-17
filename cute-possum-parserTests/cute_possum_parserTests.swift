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
    let json = TestJsonLoader.read("cutie_possum.json")
    
    struct Possum {
      let name: String
      let species: String
      let lengthCM: Int
      let weightKG: Double
      let likes: [String]
      let home: PossumAddress
    }
    
    struct PossumAddress {
      let planet: String
    }
    
    let p = CutePossumParser(json: json)
    
    let model = Possum(
      name: p.parse("name", miss: ""),
      species: p.parse("species", miss: "", canBeMissing: true),
      lengthCM: p.parse("lengthCM", miss: 0),
      weightKG: p.parse("weightKG", miss: 0),
      likes: p.parse("likes", miss: []),
      
      home: PossumAddress(
        planet: p["home"].parse("planet", miss: "")
      )
    )
    
    XCTAssertTrue(p.successfull)
    
    XCTAssertEqual("Cutie", model.name)
    XCTAssertEqual("", model.species) // missing in JSON
    XCTAssertEqual(31, model.lengthCM)
    XCTAssertEqual(2.2, model.weightKG)
    XCTAssertEqual(["leaves", "carrots", "strawberries"], model.likes)
    XCTAssertEqual("Earth", model.home.planet)
  }
  
  func testPerformanceExample() {
      // This is an example of a performance test case.
      self.measureBlock() {
          // Put the code you want to measure the time of here.
      }
  }
    
}
