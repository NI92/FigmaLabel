//
//  FigmaLabel.swift
//
//  Created by Nick Ignatenko on 2021-01-03.
//

import UIKit

class FigmaLabel: UILabel {
    
    /*
     Spacing between each character within the text.
     Расстояние между символами.
     */
    var characterSpacing: CGFloat?
    
    /*
     Distance between two separate lines (bottom to next lines top).
     Расстояние между строками.
     */
    var lineSpacing: CGFloat?
    
    /*
     Newline spacing - after the \n characters.
     Расстояние после переноса.
     */
    var paragraphSpacing: CGFloat?
    
    /*
     Individual line height.
     Высота строки.
     */
    var lineHeight: CGFloat {
        set {
            _lineHeight = newValue
        }
        get {
            return _lineHeight ?? font.lineHeight
        }
    }
    private var _lineHeight: CGFloat?
    
    /*
     Line height multiplied by number of lines.
     Высота строки перемноженная на кол-во строк.
     */
    var labelHeight: CGFloat {
        var height = font.lineHeight
        if let line = _lineHeight {
            height = line
        }
        return CGFloat(numberOfLines) * height
    }
    
    enum VerticalAlignment {
        case top
        case middle
        case bottom
    }
    
    /*
     Vertical/y-axis positioning of actual text within the frame.
     Вертикальное позиционирование текста в фрейме.
     */
    var verticalAlignment: VerticalAlignment = .bottom {
        didSet {
            updateText()
        }
    }
    
    override var text: String? {
        didSet {
            updateText()
        }
    }
    
    // MARK: - Functions
    
    func empty() -> Bool {
        return !(text != nil && text!.count > 0)
    }
    
    func width() -> CGFloat {
        return size(forWidth: CGFloat(MAXFLOAT)).width
    }
    
    func height() -> CGFloat {
        return height(forWidth: frame.width)
    }
    
    func height(forWidth width: CGFloat) -> CGFloat {
        return size(forWidth: width).height
    }
    
    func copyLabel() -> FigmaLabel {
        let label = FigmaLabel()
        label.font = font
        label.textColor = textColor
        label.numberOfLines = numberOfLines
        label.textAlignment = textAlignment
        label.lineBreakMode = lineBreakMode
        label.characterSpacing = characterSpacing
        label.lineSpacing = lineSpacing
        label._lineHeight = _lineHeight
        label.paragraphSpacing = paragraphSpacing
        label.text = text
        label.frame = frame
        return label
    }
    
    func size(forWidth width: CGFloat) -> CGSize {
        let maxHeight = (numberOfLines == 0) ? CGFloat(MAXFLOAT) : lineHeight * CGFloat(numberOfLines)
        let maxSize = CGSize.init(width: width, height: maxHeight)
        return sizeThatFits(maxSize)
    }
    
    // Attributes

    func attributes() -> [NSAttributedString.Key: Any] {
        var attributes = [NSAttributedString.Key: Any]()
        
        if let font = font {
            attributes[NSAttributedString.Key.font] = font
        }
        if let textColor = textColor {
            attributes[NSAttributedString.Key.foregroundColor] = textColor
        }
        if let chapterSpacing = characterSpacing {
            attributes[NSAttributedString.Key.kern] = chapterSpacing
        }
        if let linesHeight = _lineHeight {
            var baselineOffset: CGFloat = 0.0 // Actual default
            switch verticalAlignment {
            case .top: baselineOffset = linesHeight / 2
            case .middle: baselineOffset = linesHeight / 4
            case .bottom:()
            }
            attributes[NSAttributedString.Key.baselineOffset] = baselineOffset
        }
        
        let style = NSMutableParagraphStyle()
        style.alignment = textAlignment
        style.lineBreakMode = lineBreakMode
        
        if let linesHeight = _lineHeight {
            style.minimumLineHeight = linesHeight - 0.01
            style.maximumLineHeight = linesHeight + 0.01
        }
        if let linesSpacing = lineSpacing {
            style.lineSpacing = linesSpacing
        }
        if let paragraphSpacing = paragraphSpacing {
            style.paragraphSpacing = paragraphSpacing
        }
        attributes[NSAttributedString.Key.paragraphStyle] = style
        
        return attributes
    }
    
    func setAttributes(_ attributes: [NSAttributedString.Key: Any]) {
        if let font = attributes[NSAttributedString.Key.font] as? UIFont {
            self.font = font
        }
        if let textColor = attributes[NSAttributedString.Key.foregroundColor] as? UIColor {
            self.textColor = textColor
        }
        if let chapterSpacing = attributes[NSAttributedString.Key.kern] as? CGFloat {
            self.characterSpacing = chapterSpacing
        }
        if let style = attributes[NSAttributedString.Key.paragraphStyle] as? NSParagraphStyle {
            textAlignment = style.alignment
            lineBreakMode = style.lineBreakMode
            _lineHeight = style.minimumLineHeight + 0.01
            lineSpacing = style.lineSpacing
            paragraphSpacing = style.paragraphSpacing
        }
    }
    
    // Custom text
    
    struct CustomText {
        
        var text: String?
        var attributes: [NSAttributedString.Key: Any]
        
    }
    
    func setupText(_ text: String, customTexts: [CustomText]) {
        var dict = attributes()
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes(dict, range: text.fullRange())
        
        for model in customTexts {
            guard let string = model.text else { return }
            if let range = text.rangeOfString(string) {
                model.attributes.forEach { (k, v) in dict[k] = v }
                attributedString.addAttributes(dict, range: range)
            }
            dict = attributes()
        }
        attributedText = attributedString
    }
    
}

// MARK: - Private

extension FigmaLabel {
    
    private func updateText() {
        if let text = text {
            let aText = NSMutableAttributedString(string: text)
            let fullRange = NSRange(location: 0, length: text.utf16.count)
            aText.addAttributes(attributes(), range: fullRange)
            attributedText = aText
        } else {
            super.text = nil
        }
    }
    
}
