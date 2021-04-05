//
//  ApiModel2.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/06.
//

import Foundation

struct word: Codable {
    let word_kor: String
    let word_eng: String
    let pronun: String
    let meaning_kor: String
    let meaning_eng: String
    let image: String
    let audio: String
}

enum vocab_type: Int, Codable {
    case added = 1
    case learning = 2
    case complete = 3
}

struct vocab: Codable {
    let type: vocab_type
    let count: Int
}

// struct for quiz question and answer
