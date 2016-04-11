// =======================================================
// JanusXML
// Nathaniel Kirby
// =======================================================

import Foundation

public enum XMLParserError: ErrorType {
    case UnableToParse
    case MissingRootNode
}


public class XMLNode {
    public var name = ""
    public var comments = [String]()
    public var CDATA = [String]()
    public var attributes = [String: AnyObject]()
    public var children = [XMLNode]()

    public var dictionary: [String: AnyObject] {
        return [
            "$name": self.name,
            "$comments": self.comments,
            "$CDATA": self.CDATA,
            "$attributes": self.attributes,
            "$children": self.children.map { $0.dictionary }
        ]
    }
}

// =======================================================

public class XMLParser: NSObject, NSXMLParserDelegate {
    private let parser: NSXMLParser

    private var dict = [String: AnyObject]()
    private var rootNode: XMLNode?
    private var elements = [XMLNode]()
    private var text = ""

    public init(data: NSData) {
        self.parser = NSXMLParser(data: data)
        super.init()
    }

    public func parse() throws -> XMLNode {
        self.parser.delegate = self
        if !self.parser.parse() {
            throw XMLParserError.UnableToParse
        }

        guard let rootNode = self.rootNode else {
            throw XMLParserError.MissingRootNode
        }

        return rootNode
    }

// =======================================================
// MARK: - Delegate

    public func parser(parser: NSXMLParser, foundCharacters string: String) {
        self.text.appendContentsOf(string)
    }

    public func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        let node = XMLNode()
        node.name = elementName
        node.attributes = attributeDict

        if self.rootNode == nil {
            self.rootNode = node
        }

        self.elements.append(node)
    }

    public func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if let last = self.elements.popLast() {
            if let previous = self.elements.last {
                previous.children.append(last)
            }
        }
    }

    public func parser(parser: NSXMLParser, foundComment comment: String) {
        if let last = self.elements.last {
            last.comments.append(comment)
        }
    }

    public func parser(parser: NSXMLParser, foundCDATA CDATABlock: NSData) {
        if let last = self.elements.last {
            let string = String(dada: CDATABlock, encoding: NSUTF8StringEncoding)
            last.CDATA.append(string)
        }
    }
}
