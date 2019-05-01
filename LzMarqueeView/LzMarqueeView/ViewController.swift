//
//  ViewController.swift
//  LzMarqueeView
//
//  Created by mc on 2019/4/25.
//  Copyright © 2019年 lxf. All rights reserved.
//

import UIKit

/**
 *********************************************************
 为什么 Timer 和点击手势无效？？？ 是我的Timer写错了？？？？
 *********************************************************
 */

/**
 * 数据源创建
 */
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


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        测试一个item 点击手势有效
//        testOneItem()
        
//        测试一个item的上下轮播，点击手势无效！！！！！猜测LzMarqueeView类写的有问题-经检验是计时器的问题
//        addMarquee()
        
//        测试没有计时器的两个item 是否可以点击。发现可以点击
//       testTestView()
        
//        既然里面都不可以点击，那么就在vc中给view添加点击事件 , 发现还是无效
        testAutoScrollView()

//      最终解决方案：不适用 Timer， 使用 dispatchSourceTimer 代替 发现可以解决该问题。
        
        
//        addMarquee2()

//        testTapGes()
//
        
        
    }
}

extension ViewController {
    /**
     * 添加手势
     */
    func testTapGes()  {
        let pView = UIView.init(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        pView.backgroundColor = UIColor.blue
        view.addSubview(pView)
        
        let subView = UIView.init(frame: CGRect(x: 25, y: 25, width:50, height: 50))
        subView.backgroundColor = UIColor.red
        pView.addSubview(subView)
        
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        lbl.text = "哈哈哈"
        lbl.textAlignment = NSTextAlignment.center
        subView.addSubview(lbl)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickOnView))
        pView.addGestureRecognizer(tap)
        print(tap)
    }
    /**
     * 这是手势方法
     */
    @objc func clickOnView(){
        let alertVC = UIAlertController.init(title: title, message: "点击图片", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction.init(title: "sure", style: UIAlertAction.Style.default, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
    
}

/**
 * 测试，既然里面都不可以点击，那么就在vc中给view添加点击事件 , 发现还是无效
 */
extension ViewController : LzAutoScrollViewDelegate {
    func testAutoScrollView(){
        let autoView = LzAutoScrollView(frame: CGRect(x: 10, y: 100, width: 320, height: 60))
        autoView.delegate = self
//        autoView.isUserInteractionEnabled = true
//        let t = UITapGestureRecognizer.init(target: self, action: #selector(tapAction(tap:)))
//        autoView.addGestureRecognizer(t)
        view.addSubview(autoView)
    }
    @objc func tapAction(tap : UITapGestureRecognizer){
        var index : Int = 1
        if tap.view is LzAutoScrollView {
            let autoView = tap.view as! LzAutoScrollView
            index = autoView.dataIndex
        }
        var myTitle = "点击了第 1 个"
        if index == 2 {
            myTitle = "点击了第 2 个"
        }
        let alertVC = UIAlertController.init(title: myTitle, message: "点击手势有效！！！", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction.init(title: "sure", style: UIAlertAction.Style.default, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
    func lzAutoScrollViewClicked(view: LzAutoScrollView, index: Int) {
        var myTitle = "点击了第 1 个"
        if index == 2 {
            myTitle = "点击了第 2 个"
        }
        let alertVC = UIAlertController.init(title: myTitle, message: "点击手势有效！！！", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction.init(title: "sure", style: UIAlertAction.Style.default, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}


/**
 * 测试 testview
 */
extension ViewController : TestViewDelegate {

    func testTestView (){
        let testView = TestView(frame: CGRect(x: 0, y: 199, width: 320, height: 120))
        testView.delegate = self
        view.addSubview(testView)
    }
    func clickOnTestView(view: TestView, model: Person) {
        let alertVC = UIAlertController.init(title: model.name, message: "点击手势有效！！！", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction.init(title: "sure", style: UIAlertAction.Style.default, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}





/**
 * 测试2个item的上下轮播
 */
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

/**
 * 测试一个个item上下跑马灯
 */
extension ViewController : LzMarqueeViewDelegate {
    
    func addMarquee(){
        let marquee = LzMarqueeView.init(frame: CGRect(x: 0, y: 100, width: view.frame.size.width, height: 60))
        marquee.backgroundColor = UIColor.orange
        marquee.delegate = self
        view.addSubview(marquee)
        marquee.reloadData(datas: createModels(count: 2))
    }
    
    func clickOnMarqueeView(view: LzMarqueeView, model: Person) {
        print(model.name + String(model.age))
        let title = model.name + String(model.age)
        let alertVC = UIAlertController.init(title: title, message: "点击了单个item的跑马灯", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction.init(title: "sure", style: UIAlertAction.Style.default, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }

}

/**
 * 测试一个item
 */
extension ViewController : LzMarqueeItemDelegate {
    func testOneItem(){
        let itemOne = LzMarqueeItem.init(frame: CGRect(x: 10, y: 200, width: 320, height: 60))
        itemOne.delegate = self
        itemOne.backgroundColor = UIColor.red
        itemOne.displayModel(Person(name: "狗蛋儿", age: 23))
        view.addSubview(itemOne)
    }
    func clickOnMarqueeItem(itemView: LzMarqueeItem, model: Person) {
        let alertVC = UIAlertController.init(title: model.name, message: "点击手势有效！！！", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction.init(title: "sure", style: UIAlertAction.Style.default, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}
