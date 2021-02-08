//
//  PDFCreator.swift
//  PDFKitTest
//
//  Created by Bart van Kuik on 08/02/2021.
//

import Foundation
import PDFKit

struct PDFCreator {
    struct Table {
        var columns: Int
        private(set) var content: [[String]]

        mutating func append(_ row: [String]) {
            self.content.append(row)
        }

        init(columns: Int) {
            self.columns = columns
            self.content = []
        }
    }

    private var content: [Table] = []

    mutating func append(_ table: Table) {
        self.content.append(table)
    }

    func render() -> Data {
        let format = UIGraphicsPDFRendererFormat()
        let pageRect = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4
        let margin: CGFloat = 72 // 1 inch @ 72 DPI
        let marginInsets = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        let marginRect = pageRect.inset(by: marginInsets)
        let bodyFont = UIFont(name: "Helvetica", size: 12) ?? UIFont.systemFont(ofSize: 12)
//        let headerFont = UIFont(descriptor: bodyFont.fontDescriptor.withSymbolicTraits(.traitBold) ?? UIFontDescriptor(), size: 14)
        let attributes = [
            NSAttributedString.Key.font: bodyFont
        ]
        let lineHeight: CGFloat = 15

        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        let data = renderer.pdfData { context in
            var offset = marginRect.origin
            context.beginPage()

            for table in self.content {
                // Render table
                let columnWidth = marginRect.width / CGFloat(table.columns)
                for row in table.content {
                    for i in 0 ..< table.columns {
                        let newOffsetX = CGFloat(i) * columnWidth
                        offset = CGPoint(x: offset.x + newOffsetX, y: offset.y)
                        
                        let text: String = row[i]
                        text.draw(at: offset, withAttributes: attributes)
                    }
                    offset = CGPoint(x: marginRect.origin.x, y: offset.y + lineHeight)
                }
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
