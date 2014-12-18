# JSON parser for iOS written in Swift

This parser is designed to convert JSON into Swift variable, structs or classes.

## Example

JSON
```
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
