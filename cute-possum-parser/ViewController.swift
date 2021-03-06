//
//  ViewController.swift
//  cute-possum-parser
//
//  Created by Evgenii Neumerzhitckii on 18/12/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ViewControllerWithDebugOutputProtocol {

  @IBOutlet weak var outputLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    outputLabel.text = ""
  }

  @IBAction func onParseJsonFileTapped(sender: AnyObject) {
    let json = TestJsonLoader.read("people.json")
    
    let tick = TegTickTock()
    let people = PeopleParser.parse(json)
    tick.outputView(message: "Parsed in")
  }
}

