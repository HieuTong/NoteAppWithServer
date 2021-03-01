//
//  UIViewController.swift
//  NoteApp
//
//  Created by HieuTong on 3/1/21.
//

import UIKit

extension UIViewController {
    func push(_ controller: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func pop() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
