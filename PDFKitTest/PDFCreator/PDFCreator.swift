//
//  PDFCreator.swift
//  PDFKitTest
//
//  Created by Bart van Kuik on 08/02/2021.
//

import Foundation
import PDFKit

struct PDFCreator {
    static let bodyFontSize: CGFloat = 12
    static let bodyFont = UIFont(name: "Helvetica", size: 12) ?? UIFont.systemFont(ofSize: Self.bodyFontSize)
    static var headerFont: UIFont {
        UIFont(descriptor: bodyFont.fontDescriptor.withSymbolicTraits(.traitBold) ?? UIFontDescriptor(),
               size: Self.bodyFontSize + 2)
    }
    static let pageRect = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4
    static let margin: CGFloat = 72 // 1 inch @ 72 DPI
    static let marginInsets = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    static let marginRect = pageRect.inset(by: marginInsets)

    private var content: [Table] = []

    mutating func append(_ table: Table) {
        self.content.append(table)
    }

    
    func render() -> Data {
        let format = UIGraphicsPDFRendererFormat()

        let renderer = UIGraphicsPDFRenderer(bounds: Self.pageRect, format: format)
        let data = renderer.pdfData { context in
            var offset = Self.marginRect.origin
            
            for table in self.content {
                table.render(context, offset: &offset)
            }
        }
        return data
    }
}

extension PDFCreator {
    static func makeTest() -> PDFCreator {
        var pdfCreator = PDFCreator()
        var table = PDFCreator.Table(columns: 2)
        table.append(["Column 1", "Column 2"])
        table.append(["Column 1", "Column 2"])
        table.append(["Column 1", "Column 2"])
        table.append(["Column 1", "Column 2"])
        table.append(["Column 1", "Column 2"])
        pdfCreator.append(table)
        return pdfCreator
    }
}
