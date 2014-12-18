//
//  CutePossumParser.swift
//  
//  Json parser for Swift. Handy for converting JSON into Swift structs.
//
//  Demo and examples:
//
//  https://github.com/exchangegroup/cute-possum-parser
//
//  Created by Evgenii Neumerzhitckii on 18/12/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import Foundation

private let cutePossumArrayKey = "kutePossumArrayKey#&"

public class CutePossumParser {
  var parent: CutePossumParser?
  private let data: NSDictionary
  
  public init(json: String) {
    let encoded = json.dataUsingEncoding(NSUTF8StringEncoding)
    let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(encoded!,
      options: .MutableContainers, error: nil)
    
    if let parsed = parsedObject as? NSDictionary {
      data = parsed
    } else {
      if let parsed = parsedObject as? NSArray { // handle array in json
        data = [cutePossumArrayKey: parsed]
      } else {
        data = NSDictionary()
        reportFailure()
      }
    }
  }
  
  init(data: NSDictionary, parent: CutePossumParser? = nil) {
    self.data = data
    self.parent = parent
  }
  
  // Returns parser for the attribute
  public subscript(name: String) -> CutePossumParser {
    if let subData = data[name] as? NSDictionary {
      return CutePossumParser(data: subData, parent: self)
    } else {
      reportFailure()
      return CutePossumParser(data: NSDictionary(), parent: self)
    }
  }
  
  private var amISuccessfull = true
  
  // Was parsing successfull?
  public var successfull: Bool {
    get {
      if let currentParent = parent {
        return currentParent.successfull
      }
      return amISuccessfull
    }
  }
  
  private func reportFailure() {
    parent?.reportFailure()
    amISuccessfull = false
  }
  
  // Parses primitive value: String, Int, [String] etc.
  public func parse<T>(name: String, miss: T, canBeMissing: Bool = false) -> T {
    if !successfull { return miss }
    
    if let parsed = data[name] as? T {
      return parsed
    } else {
      if !canBeMissing { reportFailure() }
    }
    
    return miss
  }
  
  // Parses a value that is assigned to a Swift optional.
  public func parseOptional<T>(name: String, miss: T? = nil) -> T? {
    if !successfull { return miss }
    
    if let parsed = data[name] as? T {
      return parsed
    }
    
    return miss
  }
  
  // Parses an array of primitive values: String, Int, [String] etc.
  public func parseArray<T: CollectionType>(miss: T, canBeMissing: Bool = false) -> T {
    if !successfull { return miss }
    
    return parse(cutePossumArrayKey, miss: miss, canBeMissing: canBeMissing)
  }
  
  // Parses an array of items. Each item is parsed with supplied function.
  public func parseArray<T: CollectionType>(miss: T, canBeMissing: Bool = false,
    parser: (CutePossumParser)->(T.Generator.Element)) -> T {
    
    return parseArray(cutePossumArrayKey, miss: miss, parser: parser)
  }
  
  // Parses an array of items. Each item is parsed with supplied function.
  public func parseArray<T: CollectionType>(name: String, miss: T, canBeMissing: Bool = false,
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
          if !canBeMissing { reportFailure() }
          return miss
        }
      }
      
      if let result = parsedItems as? T { return result }
      
    } else {
      
      if !canBeMissing { reportFailure() }
      
    }
    
    return miss
  }
}
