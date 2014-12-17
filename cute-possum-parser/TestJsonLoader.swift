//
//  TestJsonLoader.swift
//  swippi
//
//  Created by Evgenii Neumerzhitckii on 29/08/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import Foundation

public class TestJsonLoader {
  public class func read(filename: String) -> String {
    let path = NSBundle.mainBundle().pathForResource(filename, ofType: nil)
    return String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
  }
}
