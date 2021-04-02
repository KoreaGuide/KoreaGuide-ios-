//
//  PasswordEncoder.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/03/13.
//

import Foundation
import CryptoKit

class PasswordEncoder {
    func encode(password: String?)->String? {
        guard let data = password?.data(using: .utf8) else {
            return nil
        }
        let bytes = SHA512.hash(data: data)
        let encodedPassword = Data(bytes).base64EncodedString()
        return encodedPassword
    }
}
