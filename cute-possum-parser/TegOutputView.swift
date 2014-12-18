//
//  OutputView.swift
//  swippi
//
//  Created by Evgenii Neumerzhitckii on 18/09/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class TegOutputView {
  class func show(text: String) {
    if let viewConctroller = TegVisibleViewController.visibleViewController as? ViewControllerWithDebugOutputProtocol {
      viewConctroller.outputLabel.text = text
      viewConctroller.outputLabel.hidden = false
    }
  }
}

@objc
protocol ViewControllerWithDebugOutputProtocol {
  weak var outputLabel: UILabel! { get set } // Show debug output on screen with OutputView class
}
