//
//  StressTestParser.swift
//  cute-possum-parser
//
//  Created by Evgenii Neumerzhitckii on 18/12/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import Foundation

public class PeopleParser {
  public class func parse(json: String) -> [Person] {
    let p = CutePossumParser(json: json)
    
    return p.parseArray([], parser: { p in
      return Person(
        id: p.parse("id", miss: 0),
        name: p.parse("name", miss: ""),
        age: p.parse("age", miss: 0),
        latitude: p.parse("latitude", miss: 0),
        longitude: p.parse("longitude", miss: 0),
        tags: p.parse("tags", miss: []),
        
        friends: p.parseArray("friends", miss: [], parser: { p in
          return Friend(
            id: p.parse("id", miss: 0),
            name: p.parse("name", miss: "")
          )
        })
      )
    })
  }
}
