//
//  ViewController.swift
//  tableview
//
//  Created by 榮門　祐斗 on 2019/12/11.
//  Copyright © 2019 yuto. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

let iteminf = Item()
let userDefaults = UserDefaults.standard
//var namearray = iteminf.MakeStringArray(dicname: "itemname")
//var havearray = iteminf.MakeIntArray(dicname: "itemhave")
//var pricearray = iteminf.MakeIntArray(dicname: "itemprice")
var namearray: [String] = userDefaults.array(forKey: "itemname") as! [String]
var havearray: [Int] = userDefaults.array(forKey: "itemhave") as! [Int]
var pricearray: [Int] = userDefaults.array(forKey: "itemprice") as! [Int]

class ShopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var bukinum1 = userDefaults.integer(forKey: "bukinumber1")
    var bukinum2 = userDefaults.integer(forKey: "bukinumber2")
    var bougunum1 = userDefaults.integer(forKey: "bougunumber1")
    var bougunum2 = userDefaults.integer(forKey: "bougunumber2")

    var number = 0
    var exp = 0
    var shopkey = "item"
    @IBOutlet weak var tld: UILabel!
    @IBOutlet weak var fild: UIButton!
    @IBOutlet weak var nextlabel: UIButton!
    @IBOutlet weak var backlabel: UIButton!
    @IBOutlet weak var buylabel: UIButton!
    @IBOutlet weak var shop: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var exps: UILabel!
    
    @IBOutlet weak var minutelabel: UILabel!
    
    @IBOutlet weak var secondlabel: UILabel!
    let timer = TimerController()
    var labelTimer:Timer!
    var count:Int = 0
    
    //labelset関数を1秒ごとに行う処理を行っている
    func labeltimer(){
        labelTimer = Timer.scheduledTimer(timeInterval:1,target:self,selector:#selector(self.labelset),userInfo: nil,repeats:true)

    }
    
    //labelを更新するための処理
    @objc func labelset(){
        minutelabel.text = timer.getStrMinute()
        secondlabel.text = timer.getStrSecond()
        if (timer.getCount() == 0) {
             self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //時間のラベルと関数
        minutelabel.text = String("\(count/60) 分")
        secondlabel.text = String("\(count%60) 秒")
        
        timer.setCount(count: count)
        timer.createTimer()
        labeltimer()
        //ボタン装飾
        fild.layer.borderWidth = 1
        fild.layer.borderColor = UIColor.white.cgColor
        tld.layer.borderWidth = 1
        tld.layer.borderColor = UIColor.white.cgColor
        Description.layer.borderWidth = 1
        Description.layer.borderColor = UIColor.white.cgColor
        shop.layer.borderWidth = 1
        shop.layer.borderColor = UIColor.white.cgColor
        buylabel.layer.borderWidth = 1
        buylabel.layer.borderColor = UIColor.white.cgColor
        backlabel.layer.borderWidth = 1
        backlabel.layer.borderColor = UIColor.white.cgColor
        nextlabel.layer.borderWidth = 1
        nextlabel.layer.borderColor = UIColor.white.cgColor
        price.layer.borderWidth = 1
        price.layer.borderColor = UIColor.white.cgColor
        exps.layer.borderWidth = 1
        exps.layer.borderColor = UIColor.white.cgColor
        
        // 説明の表示
        switch shopkey {
        case "item":
            Description.text = iteminf.itemdescription[number]
        case "buki":
            Description.text = iteminf.bukidescription[number]
        case "bougu":
            Description.text = iteminf.bougudescription[number]
        default:
            Description.text = iteminf.itemdescription[number]
        }
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    //↓tableviewの表示

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namearray.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor(red: 19/255, green: 144/255, blue: 250/255, alpha: 1.0)
        tableView.backgroundColor = UIColor.black
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch shopkey {
        case "item":
            namearray = iteminf.MakeStringArray(dicname: "itemname")
        case "buki":
            namearray = iteminf.MakeStringArray(dicname: "bukiname")
        case "bougu":
            namearray = iteminf.MakeStringArray(dicname: "bouguname")
        default:
            namearray = iteminf.MakeStringArray(dicname: "itemname")
        }
        cell.textLabel!.text = namearray[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 30)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //セルの選択解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        //ここに処理を書く
        number = indexPath.row
        switch shopkey {
        case "item":
            Description.text = iteminf.itemdescription[number]
            let pice = iteminf.itemprice[number]!
            let strprice = String(pice)
            price.text = "値段：\(strprice)EXP"
            let ex = userDefaults.integer(forKey:"EXPs")
            let strexp = String(ex)
            exps.text = "所持EXP：\(strexp)"
        case "buki":
            Description.text = iteminf.bukidescription[number]
            let pice = iteminf.bukiprice[number]!
            let strprice = String(pice)
            price.text = "値段：\(strprice)EXP"
            let ex = userDefaults.integer(forKey:"EXPs")
            let strexp = String(ex)
            exps.text = "所持EXP：\(strexp)"
        case "bougu":
            Description.text = iteminf.bougudescription[number]
            let pice = iteminf.bouguprice[number]!
            let strprice = String(pice)
            price.text = "値段：\(strprice)EXP"
            let ex = userDefaults.integer(forKey:"EXPs")
            let strexp = String(ex)
            exps.text = "所持EXP：\(strexp)"
        default:
            Description.text = iteminf.itemdescription[number]
        }
        print(number)
    }
    
    //ボタン押してからの処理

    @IBAction func buy(_ sender: Any) {
        exp = userDefaults.integer(forKey:"EXPs")
        print(exp)
        print(pricearray)
        switch shopkey {
        case "item":
            pricearray = iteminf.MakeIntArray(dicname: "itemprice")
            if exp >= pricearray[number] {
                exp = exp - pricearray[number]
                havearray[number] += 1
                userDefaults.set(exp, forKey: "EXPs")
                userDefaults.set(havearray,forKey: "itemhave")
                print(userDefaults.array(forKey: "itemhave") as Any)
                let ex = userDefaults.integer(forKey:"EXPs")
                let strexp = String(ex)
                exps.text = "所持EXP：\(strexp)"
                print("アイテム")
            }
            else {
                print("miss")
            }
        case "buki":
            pricearray = iteminf.MakeIntArray(dicname: "bukiprice")
            if exp >= pricearray[number] {
                if havearray[number] == 0 {
                    exp = exp - pricearray[number]
                    havearray[number] += 1
                    bukinum1 = bukinum2
                    bukinum1 = iteminf.bukinumber[number]!
                    userDefaults.set(bukinum2, forKey: "bukinumber2")
                    userDefaults.set(bukinum1, forKey: "bukinumber1")
                    userDefaults.set(exp, forKey: "EXPs")
                    userDefaults.set(havearray,forKey: "bukihave")
                    print(userDefaults.array(forKey: "bukihave") as Any)
                    let ex = userDefaults.integer(forKey:"EXPs")
                    let strexp = String(ex)
                    exps.text = "所持EXP：\(strexp)"
                    print("武器")
                }
                else{
                    Description.text = "あなたはすでにこの武器を持っています"
                }
            }
            else {
                Description.text = "経験値が足りません"
            }
        case "bougu":
            pricearray = iteminf.MakeIntArray(dicname: "bouguprice")
            if exp >= pricearray[number] {
                if havearray[number] == 0 {
                    exp = exp - pricearray[number]
                    havearray[number] += 1
                    bougunum1 = bougunum2
                    bougunum1 = iteminf.bougunumber[number]!
                    userDefaults.set(bougunum2, forKey: "bougunumber2")
                    userDefaults.set(bougunum1, forKey: "bougunumber1")
                    userDefaults.set(exp, forKey: "EXPs")
                    userDefaults.set(havearray,forKey: "bouguhave")
                    print(userDefaults.array(forKey: "bouguhave") as Any)
                    let ex = userDefaults.integer(forKey:"EXPs")
                    let strexp = String(ex)
                    exps.text = "所持EXP：\(strexp)"
                    print("防具")
                }
                else {
                    Description.text = "あなたはすでにこの防具を持っています"
                }
            }
            else {
                Description.text = "経験値が足りません"
            }
        default:
            print("miss")
        
        }
    }
    
    @IBAction func fild(_ sender: Any) {
        timer.time.invalidate()
        labelTimer.invalidate()
        UserDefaults.standard.set(1, forKey:"tag")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func back(_ sender: Any) {
        if shopkey == "item" {
            shopkey = "bougu"
        }
        else if shopkey == "buki"{
            shopkey = "item"
        }
        else if shopkey == "bougu"{
            shopkey = "buki"
        }
        switch shopkey {
        case "item":
            namearray = iteminf.MakeStringArray(dicname: "itemname")
            havearray = userDefaults.array(forKey: "itemhave") as! [Int]
        case "buki":
            namearray = iteminf.MakeStringArray(dicname: "bukiname")
            havearray = userDefaults.array(forKey: "bukihave") as! [Int]
        case "bougu":
            namearray = iteminf.MakeStringArray(dicname: "bouguname")
            havearray = userDefaults.array(forKey: "bouguhave") as! [Int]
        default:
            namearray = iteminf.MakeStringArray(dicname: "itemname")
            havearray = userDefaults.array(forKey: "itemhave") as! [Int]
        }
        namearray = iteminf.MakeStringArray(dicname: "itemname")
        print(namearray)
        print(shopkey)
        tableView.reloadData()
    }


    @IBAction func next(_ sender: Any) {
        if shopkey == "item" {
            shopkey = "buki"
        }
        else if shopkey == "buki"{
            shopkey = "bougu"
        }
        else if shopkey == "bougu"{
            shopkey = "item"
        }
        switch shopkey {
        case "item":
            namearray = iteminf.MakeStringArray(dicname: "itemname")
            havearray = userDefaults.array(forKey: "itemhave") as! [Int]
        case "buki":
            namearray = iteminf.MakeStringArray(dicname: "bukiname")
            havearray = userDefaults.array(forKey: "bukihave") as! [Int]
        case "bougu":
            namearray = iteminf.MakeStringArray(dicname: "bouguname")
            havearray = userDefaults.array(forKey: "bouguhave") as! [Int]
        default:
            namearray = iteminf.MakeStringArray(dicname: "itemname")
            havearray = userDefaults.array(forKey: "itemhave") as! [Int]
        }
        namearray = iteminf.MakeStringArray(dicname: "itemname")
        print(namearray)
        print(shopkey)
        tableView.reloadData()
    }
}
