//
//  CutePossumParser.swift
//  SwippiDetails
//
//  Created by Evgenii Neumerzhitckii on 18/12/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import Foundation

public class CutePossumParser {
  var parent: CutePossumParser?
  private let data: NSDictionary
  
  public init(json: String) {
    var encoded = json.dataUsingEncoding(NSUTF8StringEncoding)
    
    if let parsed = NSJSONSerialization.JSONObjectWithData(encoded!,
      options: .MutableContainers, error: nil) as? NSDictionary {
        
        data = parsed
    } else {
      data = NSDictionary()
      successfull = false
    }
  }
  
  init(data: NSDictionary, parent: CutePossumParser? = nil) {
    self.data = data
    self.parent = parent
  }
  
  // Returns possum parser for the child data with 'name'
  subscript(name: String) -> CutePossumParser {
    if let subData = data[name] as? NSDictionary {
      return CutePossumParser(data: subData, parent: self)
    } else {
      successfull = false
      return CutePossumParser(data: NSDictionary(), parent: self)
    }
  }
  
  private var amISuccessfull = true
  var successfull: Bool {
    get {
      if let currentParent = parent {
        return currentParent.successfull
      }
      return amISuccessfull
    }
    
    set {
      if let currentParent = parent {
        currentParent.successfull = newValue
        return
      }
      amISuccessfull = newValue
    }
  }
  
  public func parse<T>(name: String, miss: T, optional: Bool = false) -> T {
    if !successfull { return miss }
    
    if let parsed = data[name] as? T {
      return parsed
    } else {
      if !optional { successfull = false }
    }
    
    return miss
  }
  
  func parseOptional<T>(name: String, miss: T? = nil) -> T? {
    if !successfull { return miss }
    
    if let parsed = data[name] as? T {
      return parsed
    }
    
    return miss
  }
  
  func parseArray<T: CollectionType>(name: String, miss: T, optional: Bool = false,
    parser: (CutePossumParser)->(T.Generator.Element)) -> T {
      
    var value: AnyObject? = data[name]
      
    if let items = value as? [NSDictionary] {
      var parsedItems = Array<T.Generator.Element>()
      
      for item in items {
        let itemParser = CutePossumParser(data: item, parent: self)
        let parsedValue = parser(itemParser)
        
        if successfull {
          parsedItems.append(parsedValue)
        } else {
          if !optional { successfull = false }
          return miss
        }
      }
      
      if let result = parsedItems as? T { return result }
      
    } else {
      
      if !optional { successfull = false }
      
    }
    
    return miss
  }
}
