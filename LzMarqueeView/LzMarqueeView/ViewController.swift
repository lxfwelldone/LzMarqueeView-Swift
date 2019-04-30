//
//  ViewController.swift
//  LzMarqueeView
//
//  Created by mc on 2019/4/25.
//  Copyright © 2019年 lxf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

extension ViewController {
    
    func setUI() {
        addMarquee()
//        addMarquee2()
    }
}

extension ViewController {
    func createModels(count : Int) -> Array<Person> {
        var array = Array<Person>()
        for i in 1...count {
            let p = Person(name: "第 \(i) 个人", age: (i+20))
            array.append(p)
        }
        return array
    }
}

//extension ViewController : LzMarqueeView2Protocol {
//
//    func addMarquee2(){
//        let marquee2 = LzMarqueeView2(frame: CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 120))
//        marquee2.backgroundColor = UIColor.cyan
//        view.addSubview(marquee2)
//        marquee2.delegate = self
//        marquee2.reloadData(data: createModels(count: 9))
//    }
//
//    func lzMarqueeView2ClickedModel(model: Person) {
//        print(model.name + String(model.age))
//        let title = model.name + String(model.age)
//        let alertVC = UIAlertController.init(title: title, message: "点击了一对item的跑马灯", preferredStyle: UIAlertController.Style.alert)
//        let action = UIAlertAction.init(title: "sure", style: UIAlertAction.Style.default, handler: nil)
//        alertVC.addAction(action)
//        present(alertVC, animated: true, completion: nil)
//    }
//}

extension ViewController : LzMarqueeViewProtocol {
    
    func addMarquee(){
        let marquee = LzMarqueeView(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 60))
        marquee.backgroundColor = UIColor.orange
        view.addSubview(marquee)
        marquee.delegate = self
        marquee.reloadData(datas: createModels(count: 11))
    }
    
    func clickOnCurrentModel(model: Person) {
        print(model.name + String(model.age))
        let title = model.name + String(model.age)
        let alertVC = UIAlertController.init(title: title, message: "点击了单个item的跑马灯", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction.init(title: "sure", style: UIAlertAction.Style.default, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}
