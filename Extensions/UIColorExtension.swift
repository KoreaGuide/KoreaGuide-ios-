//
//  UIColorExtension.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/05/02.
//

import Foundation
import UIKit
public extension UIColor {
  convenience init?(hex: String) {
    var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

    var r: CGFloat = 0.0
    var g: CGFloat = 0.0
    var b: CGFloat = 0.0
    var a: CGFloat = 1.0
    if hexSanitized.count == 6 {
      let scanner = Scanner(string: hexSanitized)
      var hexNumber: UInt64 = 0

      if scanner.scanHexInt64(&hexNumber) {
        r = CGFloat((hexNumber & 0xFF00_0000) >> 16) / 255
        g = CGFloat((hexNumber & 0x00FF_0000) >> 8) / 255
        b = CGFloat(hexNumber & 0x0000_FF00) / 255

        self.init(red: r, green: g, blue: b, alpha: a)
        return
      }

    }
    if hexSanitized.count == 8 {
      let scanner = Scanner(string: hexSanitized)
      var hexNumber: UInt64 = 0

      if scanner.scanHexInt64(&hexNumber) {
        r = CGFloat((hexNumber & 0xFF00_0000) >> 24) / 255
        g = CGFloat((hexNumber & 0x00FF_0000) >> 16) / 255
        b = CGFloat((hexNumber & 0x0000_FF00) >> 8) / 255
        a = CGFloat(hexNumber & 0x0000_00FF) / 255

        self.init(red: r, green: g, blue: b, alpha: a)
        return
      }
    }
    return nil
  }

  func toHexString(alpha: Bool) -> String? {
    guard let components = cgColor.components else {
      return nil
    }
    let r = Float(components[0])
    let g = Float(components[1])
    let b = Float(components[2])
    var a = Float(1.0)
    if components.count >= 4 {
      a = Float(components[3])
    }
    if alpha {
      return String(format: "#%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
    } else {
      return String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
    }
  }
}
