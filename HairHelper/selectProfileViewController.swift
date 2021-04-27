//
//  selectProfileViewController.swift
//  HairHelper
//
//  Created by Joseph Young on 4/10/21.
//

import UIKit
import CoreData

class selectProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var results:[HairProfile] = []
    
    override func viewDidAppear(_ animated: Bool) {
        
        getZeData()
        print(results.count)
        profileView.reloadData()
    }
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var profileView: UITableView!
    
    override func viewDidLoad() {
        navigationController?.setToolbarHidden(false, animated: true)
        super.viewDidLoad()
        getZeData()
        profileView.delegate = self
        profileView.dataSource = self
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "profileImage.png")
        
        


        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getZeData()
    {
        let request = NSFetchRequest<HairProfile>(entityName: "HairProfile")
        
        do{
            results = try managedObjectContext.fetch(request)
        }catch{
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if(results.count == 0)
        {
            //donothing
        }else{
            cell.textLabel?.text = results[indexPath.row].profileName
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "contentViewControllerSegue")
        {
            let index: IndexPath = self.profileView.indexPath(for: sender as! UITableViewCell)!
            let sendSelectedProfile = results[index.row]
            if let viewContoller : contentViewController = segue.destination as? contentViewController{
                viewContoller.selectedProfile = sendSelectedProfile
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}




