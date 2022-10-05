//
//  MarkViewController.swift
//  mySchoolLife
//
//  Created by Артём Коротков on 04.10.2022.
//

import UIKit

class MarkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MarkTableViewCell
        cell.subjLabel.text = subjects[indexPath.row]
        cell.markLabel.text = marks[indexPath.row]

        return cell
    }
    
    var subjects = ["Биология","Русский язык","Алгебра","Геометрия","Иностранный язык"]
    var marks = ["5,4,5,4,5","2,2,3,4,5","3,3,3,4,4","5,4,4,4,4","3,3,2,3,2"]

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return subjects.count
    
  

}
}
