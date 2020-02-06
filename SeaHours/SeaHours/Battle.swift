//
//  Battle.swift
//  SeaHours
//
//  Created by 東谷　歩夢 on 2019/12/04.
//  Copyright © 2019 島袋太智. All rights reserved.
//

import Foundation

class Battle { //戦闘を管理するクラス
    
    var player : Player
    var enemy : Enemy
    let status = Status()
    
    private var logList : String = ""  //ログのリスト
    
    init(enemyName : String ) {
        
        //データベースからの修正済み
        self.player = Player(maxHitPoint:status.getHP(), defense:status.getDEF(), attack: status.getATK(), magickAttack:status.getINT(), maxSkillPoint:status.getSP())
        
        switch enemyName { //どの敵なのか？
            
        case "dragon" :
            self.enemy = Doragon()
            break
            
        case "slime" :
            self.enemy = Slime()
            break
            
        case "magickFish" :
            self.enemy = MagicFish()
            break
            
        default:
            self.enemy = Slime()
            break
        }

    }
    
    func battlePlayerTurn(tuchButtonName : String) {
        var log : String = ""
        //プレイヤー
        if (!player.getIsDead()) {
            log = player.skill_(enemy: enemy ,skillName: tuchButtonName)
            logList = log  + logList
            if (enemy.getIsDead()) {
              logList = "\n" + enemy.getName() + "は倒れた" + logList
            }
        }
    }
    
    func battleEnemyTurn() {
        var log : String = ""
        //エネミー
        if (!enemy.getIsDead()){
            log = enemy.skill(player: player)
            logList = log + logList
            if (player.getIsDead()) {
              logList = "\nプレイヤーは力尽きた" + logList
            }
        }
    }
    
    func getLogList() -> String {
        return logList
    }
}
