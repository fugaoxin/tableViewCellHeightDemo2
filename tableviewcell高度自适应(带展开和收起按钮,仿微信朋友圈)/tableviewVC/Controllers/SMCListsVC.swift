//
//  SMCListsVC.swift
//  FullNetProficient
//
//  Created by admin on 2018/7/10.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class SMCListsVC: UIViewController {
    
    let appWidth = UIScreen.main.bounds.size.width
    let appHeight = UIScreen.main.bounds.size.height
    
    fileprivate var dataStr = [String]()
    fileprivate var heightArray = [CGFloat]()
    // 选择标识
    fileprivate var flags = [Bool]()
    
    fileprivate lazy var tableView: UITableView = {
        let table = UITableView.init(frame: CGRect(x: 0, y: 20, width: appWidth, height: appHeight - 20), style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = UIColor.white
        table.register(UINib.init(nibName: "SMCListsCell", bundle: nil), forCellReuseIdentifier: SMCListsCell.identifier)
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    func debugLog<T>(emoji: String? = "😁", _ object: T) {
        #if DEBUG
        print(emoji! + " " + String(describing: object))
        #endif
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        myData()
        
    }
    
    //生成假数据
    fileprivate func myData(){
        let testStr:NSMutableString = "Siri 让你能够利用语音来完成发送信息、安排会议、查看最新比分等更多事务。只要说出你想做的事，Siri 就能帮你办到。Siri 可以听懂你说的话、知晓你的心意，甚至还能有所回应。iOS 7 中的 Siri 拥有新外观、新声音和新功能。它的界面经过重新设计，以淡入视图浮现于任意屏幕画面的最上层。Siri 回答问题的速度更快，还能查询更多信息源，如维基百科。它可以承担更多任务，如回电话、播放语音邮件、调节屏幕亮度，以及更多。"
        debugLog("testStr.length===\(testStr.length)")
//        (0 ..< 5).forEach { _ in
//            let index = (arc4random().hashValue%(testStr.length / 20)) * 20
//            let str = testStr.substring(to: index)
//            debugLog("str===\(str)")
//            debugLog("index===\(index)")
//        }
        dataStr.append(testStr.substring(to: 100))
        dataStr.append(testStr.substring(to: 50))
        dataStr.append(testStr.substring(to: 200))
        dataStr.append(testStr.substring(to: 120))
        dataStr.append(testStr.substring(to: 10))
        debugLog("dataStr===\(dataStr)")
        
        heightArray.append(testStr.substring(to: 100).ga_heightForComment(fontSize: 17, width: appWidth - 30))
        heightArray.append(testStr.substring(to: 50).ga_heightForComment(fontSize: 17, width: appWidth - 30))
        heightArray.append(testStr.substring(to: 200).ga_heightForComment(fontSize: 17, width: appWidth - 30))
        heightArray.append(testStr.substring(to: 120).ga_heightForComment(fontSize: 17, width: appWidth - 30))
        heightArray.append(testStr.substring(to: 10).ga_heightForComment(fontSize: 17, width: appWidth - 30))
        debugLog("heightArray===\(heightArray)")
        
        (0 ..< 5).forEach { _ in
            flags.append(false)
        }
        debugLog("flags===\(flags)")
        
        tableView.reloadData()
    }
    
    fileprivate func configureUI() {
        view.backgroundColor = UIColor.white
        
        view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension String {
    func ga_widthForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.width)
    }
    
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.height)
    }
    
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
}

extension SMCListsVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        debugLog("111")
        //高度自适应
        //return UITableViewAutomaticDimension
        
        if flags[indexPath.item]{
            return 300 + heightArray[indexPath.item]
        }
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SMCListsCell.identifier) as! SMCListsCell
        cell.selectionStyle = .none
        cell.contentLabel.text = dataStr[indexPath.item]
        debugLog("222")
        cell.openButton.isSelected = flags[indexPath.item]
            
        cell.clickOpenAction = { [unowned self] isSelected in
            cell.openButton.isSelected = isSelected
            self.flags[indexPath.item] = isSelected
            self.debugLog("isSelected====\(isSelected)")
            //MARK: 局部刷新动画
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            //tableView.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugLog("\(indexPath.item)")
    }
}





