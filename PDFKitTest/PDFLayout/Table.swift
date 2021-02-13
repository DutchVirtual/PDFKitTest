//
//  Table.swift
//  PDFKitTest
//
//  Created by Bart van Kuik on 09/02/2021.
//

import Foundation
import PDFKit

extension PDFLayout {
    struct Table {
        static let spacing: CGFloat = 3
        var columns: Int
        private(set) var content: [[String]]

        mutating func append(_ row: [String]) {
            self.content.append(row)
        }

        func render(_ context: UIGraphicsPDFRendererContext, offset: inout CGPoint) {
            // Render table
            let columnWidth = PDFLayout.marginRect.width / CGFloat(self.columns)
            for row in self.content {
                for i in row.indices {
                    let newOffsetX = PDFLayout.marginRect.origin.x + (CGFloat(i) * columnWidth)
                    offset = CGPoint(x: newOffsetX, y: offset.y)

                    let text: String = row[i]
                    NSLog("Column \(i+1) at offset \(offset) with content [\(text)]")
                    let attributes = [NSAttributedString.Key.font: PDFLayout.bodyFont]
                    text.draw(at: offset, withAttributes: attributes)
                }
                let newOffsetY = offset.y + PDFLayout.bodyFontSize + Self.spacing
                offset = CGPoint(x: PDFLayout.marginRect.origin.x, y: newOffsetY)
            }
        }

        init(columns: Int) {
            self.columns = columns
            self.content = []
        }
    }
}