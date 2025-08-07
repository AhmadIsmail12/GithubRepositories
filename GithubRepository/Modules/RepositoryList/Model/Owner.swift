//
//  Owner.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 07/08/2025.
//

//
//  Owner.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 07/08/2025.
//

import Foundation

struct Owner: Codable, Hashable {
    let login: String
    let avatarURL: URL

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}

extension Owner {
    static func mock(
        login: String = "google",
        avatarURL: URL = URL(string: "https://avatars.githubusercontent.com/u/1342004?v=4")!
    ) -> Owner {
        return Owner(login: login, avatarURL: avatarURL)
    }
}
