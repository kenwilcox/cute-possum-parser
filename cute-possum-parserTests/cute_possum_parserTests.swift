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
      let plans: [String]?
      let spouse: String?
      let bio: String?
      let home: Address
      let friends: [Friend]
    }
    
    struct Address {
      let planet: String
    }
    
    struct Friend {
      let name: String
      let likesLeaves: Bool
    }
    
    let p = CutePossumParser(json: json)
    
    let model = Possum(
      name: p.parse("name", miss: ""),
      species: p.parse("species", miss: "", canBeMissing: true),
      lengthCM: p.parse("lengthCM", miss: 0),
      weightKG: p.parse("weightKG", miss: 0),
      likes: p.parse("likes", miss: []),
      plans: p.parseOptional("plans"),
      spouse: p.parseOptional("spouse"),
      bio: p.parseOptional("bio"),
      
      home: Address(
        planet: p["home"].parse("planet", miss: "")
      ),
      
      friends: p.parseArray("friends", miss: [], parser: { p in

        return Friend(
          name: p.parse("name", miss: ""),
          likesLeaves: p.parse("likesLeaves", miss: true)
        )
        
      })
    )
    
    XCTAssertTrue(p.successfull)
    
    XCTAssertEqual("Cutie the possum", model.name)
    XCTAssertEqual("", model.species) // missing in JSON
    XCTAssertEqual(31, model.lengthCM)
    XCTAssertEqual(2.2, model.weightKG)
    XCTAssertEqual(["leaves", "carrots", "strawberries"], model.likes)
    XCTAssertTrue(model.plans == nil) // 'null' in JSON
    XCTAssertEqual("Mikrla the possum", model.spouse!)
    XCTAssertTrue(model.bio == nil) // missing in JSON
    XCTAssertEqual("Earth", model.home.planet)
    
    XCTAssertEqual(2, model.friends.count)
    
    // Friend one
    let friend1 =  model.friends[0]
    XCTAssertEqual("Pinky the wombat", friend1.name)
    XCTAssertEqual(true, friend1.likesLeaves)
    
    // Friend two
    let friend2 =  model.friends[1]
    XCTAssertEqual("Fluffy the platypus", friend2.name)
    XCTAssertEqual(false, friend2.likesLeaves)
  }
  
  func testParseArray() {
    let json = TestJsonLoader.read("array.json")
    
    struct StrangeThing {
      let name: String
      let spin: Bool
    }
    
    let p = CutePossumParser(json: json)
    
    let things: [StrangeThing] = p.parseArray([], parser: { p in
      return StrangeThing(
        name: p.parse("name", miss: ""),
        spin: p.parse("spin", miss: false)
      )
    })
    
    XCTAssertEqual(2, things.count)
    
    // First thing
    let thing1 = things[0]
    XCTAssertEqual("Zora", thing1.name)
    XCTAssertEqual(true, thing1.spin)
    
    // Second thing
    let thing2 = things[1]
    XCTAssertEqual("Quwa", thing2.name)
    XCTAssertEqual(false, thing2.spin)
  }
  
  func testParsePeople() {
    let json = TestJsonLoader.read("people.json")
    
    let people = PeopleParser.parse(json)
    
    XCTAssertEqual(100, people.count)
    
    // Person
    // -----------------
    
    let person = people[4]
    XCTAssertEqual(5, person.id)
    XCTAssertEqual("Alston West", person.name)
  }
  
  func testPerformanceExample() {
      // This is an example of a performance test case.
      self.measureBlock() {
          // Put the code you want to measure the time of here.
      }
  }
    
}
