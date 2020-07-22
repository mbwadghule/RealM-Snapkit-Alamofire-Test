//
//  ViewController.swift
//  AxxessDemo
//
//  Created by Augment Deck Technologies on 19/07/20.
//  Copyright © 2020 Augment Deck Technologies. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import SnapKit
class ViewController: UIViewController {
    var SampleData: [String] = []
    var tableView: UITableView!
    var dataValues  = [RootClass]()
    var items: [Displayable] = []
    var selectedItem: Displayable?
    let realm = try! Realm()
    
    
    var todoList: Results<WebItem> {
        get {
            return realm.objects(WebItem.self)
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      deleteData()
      tableView = UITableView(frame: .zero)
      self.view.addSubview(tableView)
      tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      }
      tableView.register(TestCell.self, forCellReuseIdentifier: TestCell.identifier)
      tableView.dataSource = self
      tableView.delegate = self
      tableView.estimatedRowHeight = 100
        
        
      fetchUrl()
      readDataFromRealM()
        
   //     Print realm file path so that we can go to path and open the file using terminal using open filepath command
        
       print(Realm.Configuration.defaultConfiguration)
    
        
         
    }
    

// fetch data using URLSession (optional)
    func fetchData() {
        let url = URL(string: "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                if error == nil {
                    self.dataValues = try JSONDecoder().decode([RootClass].self, from: data!)
                }
                
                for main in self.dataValues {
                    print(main.date ?? "")
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    // Fetch Data from web server using alamofire
    func fetchUrl() {
        AF.request("https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json").response {
            response in
            if let data = response.data {
                do {
                    self.dataValues = try JSONDecoder().decode([RootClass].self, from: data)
                    for main in self.dataValues {
                        let item = WebItem()
                        item.itemId = UUID().uuidString
                         item.data = main.data ?? ""
                         item.date = main.date ?? ""
                         item.id = main.id ?? ""
                         item.type = main.type ?? ""
                         self.tableView.reloadData()
                         let realm = try! Realm()

                         try! realm.write {
                             realm.add(item)
                            
                         }
                    }
                    
                }
                catch  let err{
                    print(err.localizedDescription)
                }
            }
        }
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return todoList.count
    }
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: TestCell.identifier, for: indexPath) as! TestCell
    let item = todoList[indexPath.row]
    cell.idLabel.text = item.id
    cell.typeLable.text = item.type
    cell.dataTxt.text = item.data
            return cell
        }

}
class TestCell: UITableViewCell {
    
    static let identifier: String = "Cell"
    var idLabel: UILabel!
    var typeLable: UILabel!
    var dataTxt: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }

    func configure() {
        idLabel = UILabel(frame: .zero)
        self.contentView.addSubview(idLabel)
        idLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-90)
        }
            typeLable = UILabel(frame: .zero)
            self.contentView.addSubview(typeLable)
            typeLable.snp.makeConstraints {
                $0.left.equalToSuperview().offset(10)
                $0.right.equalToSuperview().offset(-10)
                $0.top.equalToSuperview().offset(60)
                $0.bottom.equalToSuperview().offset(-70)
        }
                dataTxt = UILabel(frame: .zero)
                self.contentView.addSubview(dataTxt)
                dataTxt.snp.makeConstraints {
                    $0.left.equalToSuperview().offset(10)
                    $0.right.equalToSuperview().offset(-10)
                    $0.top.equalToSuperview().offset(100)
                    $0.bottom.equalToSuperview().offset(-50)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

 // Read from Realm database

private func readDataFromRealM() {
   
    let realm = try! Realm()
    print("Read from Realm")
    let data = realm.objects(WebItem.self)
    
    print("my datafrom realm\(data)")
}
 // Delete data from realM Database.

private func deleteData() {
    let realm = try! Realm()
    try! realm.write {
      realm.deleteAll()
    }
   
}
//End main class

/*
extension ViewController {
  func fetchData() {
     print("hiii222")
   let request = Alamofire.request("https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json")
    
    request.responseDecodable(of: [Datas].self) { (response) in
         print("Get response =->\(response)")
      guard let films = response.value else { return }
        //self.items = films.Data
      print(films)
        print("hiii333")
    ///}
      //self.tableView.reloadData()
    }
        
        /*
         let item = WebItem()
         item.itemId = UUID().uuidString
          item.data = "data"
          item.date = "date"
          item.id = "id"
          item.type = "type"
         
          let realm = try! Realm()

          try! realm.write {
              realm.add(item)
          }
 */
    //}
  }
}
*/

