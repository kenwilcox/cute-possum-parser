//
//  Created by Evgenii Neumerzhitckii on 4/03/2015.
//  Copyright (c) 2015 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit
import XCTest
import cute_possum_parser

struct MouseQuest {
  let description: String
  let difficulty: String
}

struct Mouse {
  let name: String
  let quest: MouseQuest?
}

class parseOptionalsTests: XCTestCase {

  func testParseOptional() {
    let json = TestJsonLoader.read("mouse_on_a_quest.json")

    let p = CutePossumParser(json: json)

    let model = Mouse(
      name: p.parse("name", miss: ""),
      quest: p.parseOptional("quest", parser: { p in
        return MouseQuest(
          description: p.parse("description", miss: ""),
          difficulty: p.parse("difficulty", miss: "")
        )
      })
    )

    XCTAssertEqual("Find another mouse", model.quest!.description)
    XCTAssert(p.success)
  }

  func testParseOptional_whenOptionalIsMissing() {
    let json = TestJsonLoader.read("mouse_with_no_quest.json")
    let p = CutePossumParser(json: json)

    let model = Mouse(
      name: p.parse("name", miss: ""),
      quest: p.parseOptional("quest", parser: { p in
        return MouseQuest(
          description: p.parse("description", miss: ""),
          difficulty: p.parse("difficulty", miss: "")
        )
      })
    )

    XCTAssert(model.quest == nil)
    XCTAssert(p.success)
  }
}