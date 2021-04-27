//
//  ViewController.swift
//  HairHelper
//
//  Created by Joseph Young on 4/9/21.
//

import UIKit

class ViewController: UIViewController{
    
    let hairColors:[String] = ["Brown" , "Blonde", "Dirty Blonde", "Red", "Black", "Dark Brown", "Blue", "Pink", "Green", "Rainbow"]
    let hairLength:[String] = ["1'", "2'", "3'", "4'", "Ear Length", "Chin Length", "Neck Length", "Shoulder Length", "Collarbone Length", "Armpit Length", "Bra Strap Length", "Mid Back Length"]
    let hairTexture:[String] = ["Fine Hair", "Medium Hair", "Coarse Hair"]
    let hairDensity:[String] = ["Low Density", "Medium Density", "High Density"]
    let hairElasticity:[String] = ["Low Elasticity", "Normal Elasticity", "High Elasticity"]
    
    @IBOutlet weak var colorField: UITextField!
    @IBOutlet weak var LengthField: UITextField!
    @IBOutlet weak var textureField: UITextField!
    @IBOutlet weak var densityField: UITextField!
    @IBOutlet weak var elasticityField: UITextField!
    @IBOutlet weak var hairProfileName: UITextField!
    @IBOutlet weak var titleImage: UIImageView!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var hm:hairModel?
    
    var colorPicker = UIPickerView()
    var lengthPicker = UIPickerView()
    var texturePicker = UIPickerView()
    var densityPicker = UIPickerView()
    var elasticityPicker = UIPickerView()
    
    override func viewDidAppear(_ animated: Bool) {
        print("hi")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hm = hairModel(context: managedObjectContext)
        colorField.placeholder = "Add Hair Color"
        LengthField.placeholder = "Add Hair Length"
        textureField.placeholder = "Add Hair Texture"
        densityField.placeholder = "Add Hair Density"
        elasticityField.placeholder = "Add Hair Elasticity"
        hairProfileName.placeholder = "Add Hair Profile Name"
        
        colorField.inputView = colorPicker
        LengthField.inputView = lengthPicker
        textureField.inputView = texturePicker
        densityField.inputView = densityPicker
        elasticityField.inputView = elasticityPicker
        
        colorPicker.delegate = self
        colorPicker.dataSource = self
        colorPicker.tag = 1
        
        lengthPicker.delegate = self
        lengthPicker.dataSource = self
        lengthPicker.tag = 2
        
        texturePicker.delegate = self
        texturePicker.dataSource = self
        texturePicker.tag = 3
        
        densityPicker.delegate = self
        densityPicker.dataSource = self
        densityPicker.tag = 4
        
        elasticityPicker.delegate = self
        elasticityPicker.dataSource = self
        elasticityPicker.tag = 5
        
        titleImage.image = UIImage(named: "hairCutTitle.png")
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func deleteProfiles(_ sender: Any) {
        hm?.delete()
    }
    
    
    
    @IBAction func createNewProfile(_ sender: Any) {
        var errorCounter = 0
        var color:String = ""
        var length:String = ""
        var texture:String = ""
        var density:String = ""
        var elasticity:String = ""
        var profileName:String = ""
        
        if let text = colorField.text, !text.isEmpty
        {
            color = text
        }else
        {
            errorCounter = errorCounter + 1;
            print("nothing in the color")
        }
        if let text = LengthField.text, !text.isEmpty
        {
            length = text
        }else
        {
            errorCounter = errorCounter + 1
            print("nothing in the length")
        }
        if let text = textureField.text, !text.isEmpty
        {
            texture = text
        }else
        {
            errorCounter = errorCounter + 1
            print("nothing in the texture")
        }
        if let text = densityField.text, !text.isEmpty
        {
            density = text
        }else
        {
            errorCounter = errorCounter + 1
            print("nothing in the density")
        }
        if let text = elasticityField.text, !text.isEmpty
        {
            elasticity = text
        }else
        {
            errorCounter = errorCounter + 1
            print("nothing in the elasticity")
        }
        if let text = hairProfileName.text, !text.isEmpty
        {
            profileName = text
        }else
        {
            errorCounter = errorCounter + 1
            print("nothing in the name")
        }
        if errorCounter == 0
        {
            hm?.saveProfile(color: color, density: density, elasticity: elasticity, length: length, texture: texture, profileName: profileName)
            print("ProfileSuccesfully added to the system")
            elasticityField.text = ""
            densityField.text = ""
            hairProfileName.text = ""
            hairProfileName.placeholder = profileName + " was succesfully added!"
            LengthField.text = ""
            textureField.text = ""
            colorField.text = ""
        }
        else
        {
            print("Theres an empty field")
        }
    }
    

}



extension ViewController: UIPickerViewAccessibilityDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return hairColors.count
        case 2:
            return hairLength.count
        case 3:
            return hairTexture.count
        case 4:
            return hairDensity.count
        case 5:
            return hairElasticity.count
        default:
            print("Soemthing went wrong here")
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return hairColors[row]
        case 2:
            return hairLength[row]
        case 3:
            return hairTexture[row]
        case 4:
            return hairDensity[row]
        case 5:
            return hairElasticity[row]
        default:
            print("Soemthing went wrong here")
            return "Error"
    }
  
}
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           switch pickerView.tag {
           case 1:
               colorField.text = hairColors[row]
               colorField.resignFirstResponder()
           case 2:
               LengthField.text = hairLength[row]
               LengthField.resignFirstResponder()
           case 3:
               textureField.text =  hairTexture[row]
               textureField.resignFirstResponder()
           case 4:
               densityField.text =  hairDensity[row]
               densityField.resignFirstResponder()
           case 5:
               elasticityField.text = hairElasticity[row]
               elasticityField.resignFirstResponder()
           default:
               print("Soemthing went wrong here")
               return
       }
    }
}
