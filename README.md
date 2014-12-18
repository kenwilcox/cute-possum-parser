# JSON parser for iOS written in Swift

This parser is designed to convert JSON into Swift variable, structs or classes.

## Example

Suppose we want to parse the following JSON file:

```JSON
{
  "name": "Cutie the possum",
  "lengthCM": 31,
  "weightKG": 2.2,
  "likes": ["leaves", "carrots", "strawberries"],
  "plans": null,
  "spouse": "Mikrla the possum",
  "home": {
    "planet": "Earth"
  },
  
  "friends": [
    {
      "name": "Pinky the wombat",
      "likesLeaves": true
    },
    {
      "name": "Fluffy the platypus",
      "likesLeaves": false
    }
  ]
}
```

Swift stucts:

```Swift
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
```
