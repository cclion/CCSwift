//
//  ShortCutVC.swift
//  CCSwift
//
//  Created by job on 2019/2/14.
//  Copyright © 2019 我是花轮. All rights reserved.
//

/*
 1、在项目的 Project Settings 中选择 Capabilities，启用 Siri
 2、添加.entitlements文件
 3、捷径实现查看AppDelegate.swift
 */

import UIKit
import IntentsUI
class ShortCutVC: UIViewController,
INUIAddVoiceShortcutButtonDelegate,
INUIAddVoiceShortcutViewControllerDelegate,
INUIEditVoiceShortcutViewControllerDelegate{

    var titleLabel = UILabel.init()
    let customButton = UIButton.init()
    lazy var shortcut:INShortcut = {
        var intent = CClionIntent.init()
        intent.suggestedInvocationPhrase = "这里是建议词语"
        intent.cotent = "这里是参数哦"
        let shortCut = INShortcut.init(intent: intent)
        return shortCut!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        titleLabel.text = "有两种方式可以设置捷径\n1、采用原生Siri捷径按钮\n2、判断捷径是否存在,自定义设置UI"
        titleLabel.frame = CGRect.init(x: 20, y: 60, width: 200, height: 100)
        self.view.addSubview(titleLabel)
    
        // 1、原生按钮
        let shortcutButton = INUIAddVoiceShortcutButton.init(style: .blackOutline)
        shortcutButton.shortcut = self.shortcut
        shortcutButton.translatesAutoresizingMaskIntoConstraints = true
        shortcutButton.delegate = self
        shortcutButton.frame = CGRect.init(x: 20, y: 150, width: 170, height: 45)
        self.view.addSubview(shortcutButton)
        // 2、自定义UI按钮
        customButton.layer.backgroundColor = UIColor.black.cgColor
        customButton.layer.cornerRadius = 10
        customButton.setTitle("Add to Siri", for: .normal)
        customButton.setTitle("Added to Siri", for: .selected)
        customButton.setImage(UIImage.init(named: "icon_shortCut_add"), for: .normal)
        customButton.setImage(UIImage.init(named: "icon_shortCut_ok"), for: .selected)
        customButton.frame = CGRect.init(x: 20, y: 210, width: 170, height: 45)
        customButton.addTarget(self, action: #selector(customButtonClick), for: .touchUpInside)
        self.view.addSubview(customButton)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 查找当前捷径是否存在
        self.find(CClionIntent.self) { (bool, voiceShortcut) in
            self.customButton.isSelected = bool
        }
    }
    
    /// 查找本地是否已经设置某个捷径类型 简单实现 项目中可根据需求深度优化
    ///
    /// - Parameters:
    ///   - intent: 查找的捷径
    ///   - completionHandler: 返回Bool和找到的捷径
    func find(_ intent:AnyClass, completion completionHandler: @escaping (Bool, INVoiceShortcut?) -> Void) {
        INVoiceShortcutCenter.shared.getAllVoiceShortcuts { (shortCuts, error) in
            
            DispatchQueue.main.async(execute: {
                if shortCuts == nil{
                    completionHandler(false, nil)
                }
                var exist = false;
                var voiceShortcut: INVoiceShortcut?
                for item in shortCuts!{
                    if item.shortcut.intent!.isKind(of: intent){
                        exist = true;
                        voiceShortcut = item
                    }
                }
                completionHandler(exist, voiceShortcut)
            })
        }
    }
    
    @objc func customButtonClick() {
        
        self.find(CClionIntent.self) { (bool, voiceShortcut) in
            // 跳转设置Siri
            if bool {
                let editVoiceShortcutViewController = INUIEditVoiceShortcutViewController.init(voiceShortcut: voiceShortcut!)
                editVoiceShortcutViewController.delegate = self
                self.present(editVoiceShortcutViewController, animated: true, completion: {
                    
                })
            }else{
                // 跳转添加Siri
                let addVoiceShortcutViewController = INUIAddVoiceShortcutViewController.init(shortcut: self.shortcut)
                addVoiceShortcutViewController.delegate = self
                self.present(addVoiceShortcutViewController, animated: true, completion: {
                    
                })
            }
        }
        
    }
    
    // MARK: INUIEditVoiceShortcutViewControllerDelegate
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true) {
        }
    }
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true) {
        }
    }
    
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true) {
        }
    }
    
    // MARK: INUIAddVoiceShortcutViewControllerDelegate
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true) {
        }
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true) {
        }
    }
    
    // MARK: INUIAddVoiceShortcutButtonDelegate
    func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        addVoiceShortcutViewController.delegate = self   //来实现cancel代理方法
        self.present(addVoiceShortcutViewController, animated: true) {
        }
    }
    
    func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        editVoiceShortcutViewController.delegate = self   //来实现cancel代理方法
        self.present(editVoiceShortcutViewController, animated: true) {
        }
    }
    
    
    
}
