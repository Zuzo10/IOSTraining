//
//  data.swift
//  FinalProject
//
//  Created by Consultant on 7/5/22.
//

import Foundation

struct listSports: Codable {
    let key, group, title, sportDescription: String?
    let active, hasOutrights: Bool?

    enum CodingKeys: String, CodingKey {
        case key, group, title
        case sportDescription = "description"
        case active
        case hasOutrights = "has_outrights"
    }
}
