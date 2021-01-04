import UIKit

class ViewController: UIViewController {
    
    // Test demonstrations
    
    @IBOutlet weak var figmaLabelOne: FigmaLabel!
    private var figmaLabelTwo: FigmaLabel!
    private var attributedFigmaLabel: FigmaLabel!
    
    // "Figma design"
    @IBOutlet weak var imagesContainerView: UIView!
    private var figmaLabel: FigmaLabel!
    
    // Vertical alignment
    @IBOutlet weak var imagesContainerViewTwo: UIView!
    private var verticallyAlignedFigmaLabel: FigmaLabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFigmaLabelOne()
        setupFigmaLabelTwo()
        setupAttributedFigmaLabel()
        setupFigmaLabel()
        setupVerticallyAlignedFigmaLabel()
    }
    
    // MARK: - Test demonstrations setup
    
    private func configureFigmaLabelOne() {
        let label = figmaLabelOne!
        label.lineHeight = 20
        label.characterSpacing = 4
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 3
        label.text = "Greetings there!\nThis is a demonstration.\nHopefully, it will help you."
    }
    
    private func setupFigmaLabelTwo() {
        // Label
        let label = FigmaLabel()
        label.font = UIFont(name: "ObjectSans-Regular", size: 15) // R.swift library works better here ;) Example: R.font.objectSansRegular(size: 17.scale)
        label.lineHeight = 20
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 2
        label.text = "Created to help match the label with\nwhatever the designer created within Figma"
        view.addSubview(label)
        figmaLabelTwo = label

        // Constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: figmaLabelOne, attribute: .bottom, multiplier: 1, constant: 20).isActive = true
    }
    
    private func setupAttributedFigmaLabel() {
        // Label
        let label = FigmaLabel()
        label.font = UIFont(name: "ObjectSans-Regular", size: 13)
        label.lineHeight = 18
        label.lineSpacing = 10
        label.textColor = .gray
        label.textAlignment = .right
        label.numberOfLines = 2
        view.addSubview(label)
        attributedFigmaLabel = label

        // Constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: figmaLabelTwo, attribute: .bottom, multiplier: 1, constant: 20).isActive = true
        
        // Attribution
        let text = "Behold the power of the\nattributed label !!!"
        let highlight1 = "power"
        let highlight2 = "!!!"
        var attributes = label.attributes()
        
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttributes(attributes, range: text.fullRange())
        
        if let range = text.rangeOfString(highlight1) {
            attributes[.foregroundColor] = UIColor.black
            attributes[.font] = UIFont(name: "ObjectSans-BoldSlanted", size: 13)
            attributedText.addAttributes(attributes, range: range)
        }
        if let range = text.rangeOfString(highlight2) {
            attributes[.foregroundColor] = UIColor.blue
            attributes[.font] = UIFont(name: "ObjectSans-Bold", size: 13)
            attributedText.addAttributes(attributes, range: range)
        }
        
        label.attributedText = attributedText
    }
    
    // MARK: - Figma design
    
    private func setupFigmaLabel() {
        // Label
        let label = FigmaLabel()
        label.font = UIFont(name: "ObjectSans-Regular", size: 15) // R.swift library works better here ;) Example: R.font.objectSansRegular(size: 17.scale)
        label.lineHeight = 18
        label.textColor = UIColor(red: 0.087, green: 0.087, blue: 0.087, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "1244 people are already enjoying this pack"
        view.addSubview(label)
        figmaLabel = label
        
        figmaLabelAttributionExample(label, boldHighlights: ["1244 people"])

        // Constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: imagesContainerView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: imagesContainerView, attribute: .right, multiplier: 1, constant: 12).isActive = true
        NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: view, attribute: .rightMargin, multiplier: 1, constant: -24).isActive = true
    }
    
    private func setupVerticallyAlignedFigmaLabel() {
        // Label
        let label = FigmaLabel()
        label.font = UIFont(name: "ObjectSans-Regular", size: 15) // R.swift library works better here ;) Example: R.font.objectSansRegular(size: 17.scale)
        label.lineHeight = 32
        label.textColor = UIColor(red: 0.087, green: 0.087, blue: 0.087, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "This is a vertically aligned attributed label. 'verticalAlignment' property is set to '.top' & 'lineHeight' is set to 32"
        label.backgroundColor = .gray
        label.verticalAlignment = .top
        view.addSubview(label)
        verticallyAlignedFigmaLabel = label
        
        figmaLabelAttributionExample(label, boldHighlights: ["vertically aligned", "verticalAlignment", "lineHeight"])
        
        // Constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: imagesContainerViewTwo, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: imagesContainerViewTwo, attribute: .right, multiplier: 1, constant: 12).isActive = true
        NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: view, attribute: .rightMargin, multiplier: 1, constant: -24).isActive = true
    }
    
    private func figmaLabelAttributionExample(_ label: FigmaLabel, boldHighlights: [String]) {
        let text = label.text!
        
        var attributes = label.attributes()
        
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttributes(attributes, range: text.fullRange())
        
        for boldHighlight in boldHighlights {
            if let range = text.rangeOfString(boldHighlight) {
                attributes[.foregroundColor] = UIColor(red: 0.087, green: 0.087, blue: 0.087, alpha: 1)
                attributes[.font] = UIFont(name: "ObjectSans-Bold", size: 15)
                attributedText.addAttributes(attributes, range: range)
            }
        }
        
        label.attributedText = attributedText
    }
    
}
