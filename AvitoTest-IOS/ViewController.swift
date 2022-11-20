//
//  ViewController.swift
//  AvitoTest-IOS
//
//  Created by Anna Shuryaeva on 16.11.2022.
//

import UIKit
import Network

final class ViewController: UIViewController {

    // MARK: - Properties
    let network = NetworkManager(memoryCapacity: Constants.memoryCapacity, diskCapacity: Constants.diskCapacity, diskPath: Constants.diskPath)
    var employees = [Employee]()
    var companyName = ""
    let monitor = NWPathMonitor()

    private lazy var table: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.backgroundColor = .white
        return tableView
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTable()

        // start loader
        network.getData(dataURL: URL(string: Constants.urlString)!) { [weak self] result in
            guard let self = self else { return }
            // stop loader
            switch result {
                case let .success(company):
                    self.companyName = company.name
                    self.employees = company.employees.sorted(by: { $0.name < $1.name })
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                case .failure:
                    print(NetworkErrors.invalidData)
                    break
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        checkConnection()
        let loader = self.loader()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.stopLoader(loader: loader)
        }
    }

    // MARK: - Actions
    private func registerTable() {

        table.register(TableViewCell.self, forCellReuseIdentifier: Constants.cellID)
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false

        let horizontalConstraint = table.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = table.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = table.widthAnchor.constraint(equalToConstant: view.bounds.width)
        let heightConstraint = table.heightAnchor.constraint(equalToConstant: view.bounds.height)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])

        self.table.reloadData()
    }

    private func checkConnection() {
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
        } else {
            print("Internet connection FAILED")
            let alert = UIAlertController(title: "Warning", message: "No internet connection", preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
}

// MARK: - Extensions
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employees.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Company: \(companyName)"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath) as? TableViewCell
        cell?.fillData(for: employees[indexPath.row])

        return cell ?? UITableViewCell()
    }

}

extension ViewController {
    func loader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        return alert
    }

    func stopLoader(loader: UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
}

extension ViewController {
    func showAllertError() -> UIAlertController {
        let alert = UIAlertController(title: "Warning", message: "Something is wrong", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        return alert
    }
}

