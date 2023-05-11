//
//  BookmarkModel.swift
//  fullAppBookmarkUIKit
//
//  Created by Тулеби Берик on 07.05.2023.
//

import UIKit

let userDefaults = UserDefaults.standard

// Create and Write Array of Strings


class Bookmark {
    var title: String
    var link: String
    
    init(title: String, link: String) {
        self.title = title
        self.link = link
    }
}
