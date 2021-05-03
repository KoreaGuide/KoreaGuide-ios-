//
//  WordApiModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/05/03.
//

import Foundation

struct TodayWordModel: Codable{
  let result_code: Int
  let status: String
  let description: String
  let data: RawWord
  
  var added: Bool = false
  var folder: Int = 0
  var playing: Bool = false
}

struct TodayWord {
  let word_id: Int
  let word_kor: String
  let word_eng: String
  let meaning_kor1: String
  let meaning_kor2: String
  let meaning_eng1: String
  let meaning_eng2: String
  let pronunciation_eng: String
  let image: String

  var added: Bool = false
  var folder: Int = 0
  var playing: Bool = false

  init(word: RawWord) {
    word_id = word.word_id
    word_kor = word.word_kor
    word_eng = word.word_eng
    meaning_kor1 = word.meaning_kor1
    meaning_kor2 = word.meaning_kor2
    meaning_eng1 = word.meaning_eng1
    meaning_eng2 = word.meaning_eng2
    pronunciation_eng = word.pronunciation_eng
    image = word.image
  }
}

struct WordOfPlaceModel: Codable {
  let result_code: Int
  let data: WordOfPlaceList

  struct WordOfPlaceList: Codable {
    let user_id: Int
    let place_id: Int
    let word_list: [RawWord]
  }
}

struct AddingWord {
  let word_id: Int
  let word_kor: String
  let word_eng: String
  let meaning_kor1: String
  let meaning_kor2: String
  let meaning_eng1: String
  let meaning_eng2: String
  let pronunciation_eng: String
  let image: String

  var added: Bool = false
  var folder: Int = 0
  var playing: Bool = false

  init(word: RawWord) {
    word_id = word.word_id
    word_kor = word.word_kor
    word_eng = word.word_eng
    meaning_kor1 = word.meaning_kor1
    meaning_kor2 = word.meaning_kor2
    meaning_eng1 = word.meaning_eng1
    meaning_eng2 = word.meaning_eng2
    pronunciation_eng = word.pronunciation_eng
    image = word.image
  }
}

//word list 총 개수 등
struct MainWordCountModel: Codable {
  let result_code: Int
  let data: WordFolderInfo
  struct WordFolderInfo: Codable {
    let my_word_folder_id: Int
    let now_word_count: Int
  }
}



struct LearningWord {
  let word_id: Int
  let word_kor: String
  let word_eng: String
  let meaning_kor1: String
  let meaning_kor2: String
  let meaning_eng1: String
  let meaning_eng2: String
  let pronunciation_eng: String
  let image: String

  var added: Bool = false
  var folder: Int = 0
  var playing: Bool = false

  init(word: RawWord) {
    word_id = word.word_id
    word_kor = word.word_kor
    word_eng = word.word_eng
    meaning_kor1 = word.meaning_kor1
    meaning_kor2 = word.meaning_kor2
    meaning_eng1 = word.meaning_eng1
    meaning_eng2 = word.meaning_eng2
    pronunciation_eng = word.pronunciation_eng
    image = word.image
  }
}


struct TestWord {
  let word_id: Int
  let word_kor: String
  let word_eng: String
  let meaning_kor1: String
  let meaning_kor2: String
  let meaning_eng1: String
  let meaning_eng2: String
  let pronunciation_eng: String
  let image: String

  var added: Bool = false
  var folder: Int = 0
  var playing: Bool = false

  init(word: RawWord) {
    word_id = word.word_id
    word_kor = word.word_kor
    word_eng = word.word_eng
    meaning_kor1 = word.meaning_kor1
    meaning_kor2 = word.meaning_kor2
    meaning_eng1 = word.meaning_eng1
    meaning_eng2 = word.meaning_eng2
    pronunciation_eng = word.pronunciation_eng
    image = word.image
  }
}

struct RawWord: Codable {
  enum CodingKeys: String, CodingKey {
    case word_id = "id"
    case word_kor
    case word_eng
    case meaning_kor1
    case meaning_kor2
    case meaning_eng1
    case meaning_eng2
    case pronunciation_eng
    case image
  }

  let word_id: Int
  let word_kor: String
  let word_eng: String
  let meaning_kor1: String
  let meaning_kor2: String
  let meaning_eng1: String
  let meaning_eng2: String
  let pronunciation_eng: String
  let image: String
}

/*
 struct TodayWordModel: Codable {
   enum CodingKeys: String, CodingKey {
     case word_id
   }

   let word_id: Int // home read

   // let wordInfo: WordInfo // myWordRead

   init(from decoder: Decoder) throws {
     let container = try decoder.container(keyedBy: CodingKeys.self)
     word_id = try container.decode(Int.self, forKey: CodingKeys.word_id)
   }
 }
 */

