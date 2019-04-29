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
        let marquee = LzMarqueeView(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 60))
        marquee.backgroundColor = UIColor.orange
        self.view.addSubview(marquee)
        marquee.reloadData(datas: createModels(count: 11))
    }
}

extension ViewController : LzMarqueeViewProtocol {
    func clickOnCurrentModel(marquee: LzMarqueeView, model: Person) {
        print(model.name + String(model.age))
    }
    
    func createModels(count : Int) -> Array<Person> {
        var array = Array<Person>()
        for i in 1...count {
            let p = Person(name: "第 \(i) 个人", age: (i+20))
            array.append(p)
        }
        return array
    }
}
