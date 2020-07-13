//
//  CategoryData.swift
//  TriviaGame
//
//  Created by Bailey Search on 08/07/2020.
//  Copyright © 2020 Bailey Search. All rights reserved.
//

import Foundation

struct CateogoryData: Decodable {
    var trivia_categories: [Category]
}

struct Category: Decodable {
    let id: Int
    let name: String
}


struct CategoryStats: Decodable {
    let category_id: Int
    var category_question_count: category_question_count
}
struct category_question_count: Decodable {
    let total_question_count: Int
    let total_easy_question_count: Int
    let total_medium_question_count: Int
    let total_hard_question_count: Int
}
