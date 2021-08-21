//
//  ProfileViewModel.swift
//  AntPena
//
//  Created by Hevin Jant on 8/21/21.
//  Copyright © 2021 Hevin Jant. All rights reserved.
//

import Foundation

enum ProfileViewModelType {
    case info, logout
}

struct ProfileViewModel {
    let viewModelType: ProfileViewModelType
    let title: String
    let handler: (() -> Void)?
}
