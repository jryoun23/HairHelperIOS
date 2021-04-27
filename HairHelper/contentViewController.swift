//
//  contentViewController.swift
//  HairHelper
//
//  Created by Joseph Young on 4/10/21.
//

import UIKit

class contentViewController: UIViewController {

    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var length: UILabel!
    @IBOutlet weak var texture: UILabel!
    @IBOutlet weak var density: UILabel!
    @IBOutlet weak var elasticity: UILabel!
    @IBOutlet weak var api: UILabel!
    
    var selectedProfile:HairProfile?
    let key:String = "05e4f63e3b476801b6da5f2ce5f82dd8"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileName.text = selectedProfile?.profileName
        color.text = selectedProfile?.hairColor
        length.text = selectedProfile?.hairLength
        texture.text = selectedProfile?.hairTexture
        density.text = selectedProfile?.hairDensity
        elasticity.text = selectedProfile?.hairElasticity
        self.title = selectedProfile?.profileName
        var search:String = (selectedProfile?.hairColor)!.replacingOccurrences(of: " ", with: "-") + "-" + (selectedProfile?.hairLength)!.replacingOccurrences(of: " ", with: "-") + "-" + (selectedProfile?.hairTexture)!.replacingOccurrences(of: " ", with: "-") + "-" + (selectedProfile?.hairDensity)!.replacingOccurrences(of: " ", with: "-") + "-" + (selectedProfile?.hairElasticity)!.replacingOccurrences(of: " ", with: "-")
        
        let apiCall:String = "https://gnews.io/api/v4/\(search)?token=\(key)"
        api.text = apiCall
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setToolbarHidden(false, animated: true)
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
