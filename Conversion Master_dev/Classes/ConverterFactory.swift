//
//  ConverterFactory.swift
//  Conversion Master_dev
//
//  Created by Seth Cohen on 1/8/17.
//  Copyright © 2017 Seth Cohen. All rights reserved.
//

enum ConverterType: Int {
  case GAIN = 0
  case GAIN_OFFSET
}

class ConverterFactory {
  static func create(dataMap: [String : Any], type: ConverterType) -> Converter {
    let converter: Converter;
    switch type {
    case .GAIN:
      converter = GainConverter(dataMap: dataMap)
    case .GAIN_OFFSET:
      converter = GainOffsetConverter(dataMap: dataMap)
    }
    
    return converter
  }
}
