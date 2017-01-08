//
//  Converter.swift
//  Conversion Master_dev
//
//  Created by Seth Cohen on 1/8/17.
//  Copyright © 2017 Seth Cohen. All rights reserved.
//

protocol Converter {
  init(dataMap: [String: Any])
  
  func convert(value: Double, fromUnit: String, toUnit: String) -> Double
}
