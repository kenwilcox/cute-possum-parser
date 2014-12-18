//
//  TickTock.swift
//
//  Measures elapsed time
//
//  Usage:
//
//    let tick = TickTock()
//    ... code to measure execution time for
//    tick.formattedWithMs()
//
//    Output: [TOCK] 10.2 ms
//
//  Created by Evgenii Neumerzhitckii on 9/09/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import Foundation

class TegTickTock {
  var startTime:NSDate

  init() {
    startTime = NSDate()
  }

  func measure() -> Double {
    return Double(Int(-startTime.timeIntervalSinceNow * 10000)) / 10
  }

  func formatted() -> String {
    let elapsedMs = measure()
    return String(format: "%.1f", elapsedMs)
  }

  func formattedWithMs(message: String? = nil) -> String {
    let outputPrefix = message ?? "[TOCK]"
    return "\(outputPrefix) \(formatted()) ms"
  }

  func output(message: String? = nil) {
    println(formattedWithMs(message: message))
  }

  func outputView(message: String? = nil) {
    let text = formattedWithMs(message: message)
    TegQ.main { TegOutputView.show(text) }
  }
}
