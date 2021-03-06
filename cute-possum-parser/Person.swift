//
//  PersonModel.swift
//  cute-possum-parser
//
//  Created by Evgenii Neumerzhitckii on 18/12/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import Foundation

public struct Person {
  public let id: Int
  public let name: String
  public let age: Int
  public let latitude: Double
  public let longitude: Double
  public let tags: [String]
  public let friends: [Friend]
}
