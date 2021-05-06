//
//  WordApiModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/05/03.
//

import Foundation

struct TodayWordModel: Codable {
  let result_code: Int
  let status: String
  let description: String
  let data: RawWord
}

struct TodayWord {
  var word: RawWord
  var added: Bool = false
  var folder: Int = 0
  var playing: Bool = false
}

struct WordOfPlaceModel: Codable {
  let result_code: Int
  let status: String
  let description: String
  let data: WordOfPlaceInfo

}

struct WordOfPlaceInfo: Codable {
  let user_id: Int
  let place_id: Int
  let word_list: [WordDetail]
}


struct WordDetail: Codable {
  let word_status: String
  let word_id: Int
  let word_kor: String
  let word_eng: String
  let meaning_kor1: String
  let meaning_kor2: String
  let meaning_eng1: String
  let meaning_eng2: String

  let pronunciation_eng: String
  let pronunciation_kor: String
  let word_image: String
  let word_audio: String
}

/*
 struct AddingWordList {
   let word_list: [AddingWord]
 }*/

/*
struct AddingWord {
  let word: RawWord

  var added: Bool = false
  var folder: Int = 0
  var playing: Bool = false

  init(word: RawWord) {
    self.word = word
  }
}
*/
// word list 총 개수 등
struct MainWordListModel: Codable {
  let result_code: Int
  let status: String
  let description: String
  let data: WordFolderInfo
  struct WordFolderInfo: Codable {
    let my_word_folder_id: Int
    let now_word_count: Int
    let my_word_list: [InMyListWord]
  }
}

struct InMyListWord: Codable {
  let id: Int
  let word_eng: String
  let word_kor: String
  let meaning_eng1: String
  let meaning_eng2: String
  let meaning_kor1: String
  let image: String
  var audio: String = ""
  let pronunciation_eng: String
  let my_word_status: String
}

struct AddResponse: Codable {
  let result_code: Int
  let status: String
  let description: String
  let data: AfterAddInfo
  struct AfterAddInfo: Codable {
    let my_word_folder_id: Int
    let previous_word_count: Int
    let now_word_count: Int
  }
}

struct DeleteResponse: Codable {
  let result_code: Int
  let status: String
  let description: String
  let data: AfterDeleteInfo

  struct AfterDeleteInfo: Codable {
    let user_id: Int
    let my_word_folder_id: Int
    let previous_word_count: Int
    let now_word_count: Int
  }
}

struct LearningWordList {
  let word_list: [LearningWord]
}

struct LearningWord {
  let word: RawWord

  var added: Bool = false
  var folder: Int = 0
  var playing: Bool = false

  init(word: RawWord) {
    self.word = word
  }
}

struct TestWordList: Codable {
  let result_code: Int
  let status: String
  let description: String
  let data: QuizList

  struct QuizList: Codable {
    let quiz_type: String
    let folder_id: Int
    let quiz_list: [Quiz]

    struct Quiz: Codable {
      let selected_word: TestWord
      struct TestWord: Codable {
        let id: Int
        let word_kor: String
        let word_eng: String
        let image: String
      }

      let word_choice_list: [ChoiceWord]
      struct ChoiceWord: Codable {
        let id: Int
        let word_kor: String
        let word_eng: String
        let meaning_kor1: String
      }
    }
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
