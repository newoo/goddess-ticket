//
//  Int+Extension.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/16.
//

import Foundation

extension Int {
  var decimalText: String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    return numberFormatter.string(from: NSNumber(value: self)) ?? ""
  }
}
