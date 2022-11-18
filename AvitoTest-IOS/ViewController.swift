//
//  ViewController.swift
//  AvitoTest-IOS
//
//  Created by Anna Shuryaeva on 16.11.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Properties
    let urlString = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
    let cellID = "cellTypeIdentifier"
    var employees = [Employee]()
    
    private lazy var table: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTable()
        
        self.loadData(url: urlString) { (result) in
           switch result {
           case .success(let data):
               self.parse(jsonData: data)
           case .failure(let error):
               print(error)
           }
        }
        print(employees)
    }
    
    // MARK: - Actions
    private func registerTable() {
        
        table.register(TableViewCell.self, forCellReuseIdentifier: cellID)
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = table.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = table.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = table.widthAnchor.constraint(equalToConstant: view.bounds.width)
        let heightConstraint = table.heightAnchor.constraint(equalToConstant: view.bounds.height)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        self.table.reloadData()
    }
    
    private func parse(jsonData: Data) -> [Employee] {
        let decoder = JSONDecoder()
        if let json = try? decoder.decode(Company.self, from: jsonData) {

            employees = json.company.employees.sorted(by: { $0.name < $1.name })
        
        }
        return employees
    }
    
    private func loadData(url: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: url) {
            
//            let request = URLRequest(url: url)
            let sessionDataTask = URLSession(configuration: .default).dataTask(with: url)
            {
                (data, response,error) in
                if let data = data {
                    completion(.success(data))
                }
                if let error = error {
                    completion(.failure(error))
                }
            }
            sessionDataTask.resume()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TableViewCell
//        cell.fillDataForEmployee(employee: employees[indexPath.row])

        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}

