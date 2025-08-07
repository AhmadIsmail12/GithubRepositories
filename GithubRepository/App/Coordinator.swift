//
//  Coordinator.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 04/08/2025.
//

import Foundation

protocol Coordinator {
    func push(_ path: AppRoute)
    func pop()
}
