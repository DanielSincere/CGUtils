import CoreGraphics
import Foundation

extension CGContext {

  public static func openPDF(url: URL, scale: CGFloat = 1, pdfBox: CGPDFBox = .mediaBox, background: CGColor? = nil) throws -> CGContext {
    guard let document = CGPDFDocument(url as CFURL) else {
      throw PDFErrors.couldNotOpenPDFDocument
    }

    guard let page = document.page(at: 1) else {
      throw PDFErrors.couldNotOpenFirstPage
    }

    let box = page.getBoxRect(pdfBox)
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
      .union(.byteOrder32Little).rawValue
    guard let context = CGContext(data: nil,
                                  width: Int(box.width),
                                  height: Int(box.height),
                                  bitsPerComponent: 8,
                                  bytesPerRow: 0,
                                  space: CGColorSpace(name: CGColorSpace.sRGB)!,
                                  bitmapInfo: bitmapInfo) else {
      throw PDFErrors.couldNotCreateGraphicsContext
    }
    context.interpolationQuality = .high

    if let background = background {
      context.setFillColor(background)
      context.fill(CGRect(x: 0, y: 0, width: box.width, height: box.height))
    }

    context.translateBy(x: 0,
                        y: box.height)
    context.scaleBy(x: scale, y: scale)

    context.drawPDFPage(page)

    return context
  }

  enum PDFErrors: Error {
    case couldNotOpenPDFDocument
    case couldNotOpenFirstPage
    case couldNotCreateGraphicsContext
  }
}
