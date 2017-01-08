//
//  GainOffsetConverter.swift
//  Conversion Master_dev
//
//  Created by Seth Cohen on 1/8/17.
//  Copyright © 2017 Seth Cohen. All rights reserved.
//

class GainOffsetConverter: Converter {
  var dataMap: [String : String]
  
  required init(dataMap: [String: Any]) {
    self.dataMap = dataMap as! [String : String]
  }
  
  func convert(value: Double, fromUnit: String, toUnit: String) -> Double {
    // Split the value to get factor and offset (string should be formatted "factor|offset")
    if let splitStringFrom: String = dataMap[fromUnit], let splitStringTo: String = dataMap[toUnit] {
      let fromComponents: [String] = splitStringFrom.components(separatedBy: "|")
      let toComponents: [String] = splitStringTo.components(separatedBy: "|")
     
      // convert value to basis
      var factor: Double = Double(fromComponents[0])!
      var offset: Double = Double(fromComponents[1])!
      let result1: Double = (value + offset) / factor
      
      // convert from base to final
      factor = Double(toComponents[0])!
      offset = Double(toComponents[1])!
      let result2: Double = result1 * factor - offset
      
      return result2
    } else {
      print("Unable to find unit \(fromUnit) or \(toUnit) in dataMap")
    }
    
    return 0
  }
}
