//
//  Dragon.swift
//  SeaHours
//
//  Created by 東谷　歩夢 on 2019/12/04.
//  Copyright © 2019 島袋太智. All rights reserved.
//

import Foundation

class Doragon : Enemy {
    init() {
        super.init(name : "ドラゴン", maxHitPoint: 3000, defense: 100, attack: 300, magickAttack: 500)
    }
}
