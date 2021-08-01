//
//  ListController.swift
//  mememe-two
//
//  Created by Victor Tejada Yau on 07/31/21.
//

import UIKit

class ListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "list_item")!
        // let villain = self.allVillains[(indexPath as NSIndexPath).row]
        
        // cell.textLabel?.text = villain.name
        // cell.imageView?.image = UIImage(named: villain.imageName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // let detailController = self.storyboard!.instantiateViewController(withIdentifier: "ListDetailController") as! ListDetailController
        // detailController.villain = self.allVillains[(indexPath as NSIndexPath).row]
        // self.navigationController!.pushViewController(detailController, animated: true)
    }
}
