
public enum ImageFormat: String, CaseIterable, CustomStringConvertible {

  case heic
  case png

  public var uti: String {
    "public.\(rawValue)"
  }

  public var fileExtension: String { rawValue }

  public var description: String { rawValue }
}