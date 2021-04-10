//
//  WordViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/05.
//

import Foundation
import IGListKit

class OneWord : ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return (word_kor) as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        <#code#>
    }
    
    
    let word_kor:String
    let word_eng:String
    init(){
        self.word_kor = ""
        self.word_eng = ""
    }
}


class Vocab : ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return (vocabTitle) as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        <#code#>
    }
    
    let vocabTitle: String
    let vocabTotalCount: Int
    let vocabCompleteCount: Int
    
    init(){
        self.vocabTitle = ""
        self.vocabTotalCount = 0
        self.vocabCompleteCount = 0
    }
    
}


final class WordBox: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        <#code#>
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        <#code#>
    }
    
    let audio:String
    init() {
        self.audio = ""
    }
    
}


final class imageViewModel{
    
}
final class word_korViewModel{
    
}
final class word_engViewModel{
    
}
