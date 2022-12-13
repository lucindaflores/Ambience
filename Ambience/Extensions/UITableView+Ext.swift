//
//  UITableView+Ext.swift
//  Ambience
//
//  Created by Lucy Flores on 25/06/2021.
//

import UIKit

extension UITableView {

    // extra in case needed
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }

}
