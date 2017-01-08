//
//  GainConverter.swift
//  Conversion Master_dev
//
//  Created by Seth Cohen on 1/8/17.
//  Copyright © 2017 Seth Cohen. All rights reserved.
//

class GainConverter: Converter {
  var dataMap: [String : Double]
  
  required init(dataMap: [String : Any]) {
    self.dataMap = dataMap as! [String : Double]
  }
  
  func convert(value: Double, fromUnit: String, toUnit: String) -> Double {
    // convert value to basis
    if let factor1: Double = dataMap[fromUnit], let factor2: Double = dataMap[toUnit] {
      let result1: Double = value / factor1
      let result2: Double = result1 * factor2
      
      return result2
    } else {
      print("Unable to find unit \(fromUnit) or \(toUnit) in dataMap")
    }
    
    return 0
  }
}
