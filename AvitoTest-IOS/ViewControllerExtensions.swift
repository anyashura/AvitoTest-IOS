//
//  ViewControllerExtensions.swift
//  AvitoTest-IOS
//
//  Created by Anna Shuryaeva on 19.11.2022.
//

import Foundation
import UIKit

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath) as! TableViewCell
//        cell.fillDataForEmployee(employee: Employees[indexPath], indexPath: indexPath)

        return cell
    }

}

extension ViewController: UITableViewDelegate {

}
