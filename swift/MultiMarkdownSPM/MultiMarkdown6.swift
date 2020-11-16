//
//  MultiMarkdown6.swift
//  Prev
//
//  Created by Shahaf Levi on 27/11/2015.
//  Copyright © 2015 Sl's Repository Ltd. All rights reserved.
//

import Foundation
import libMultiMarkdown

/**
 
 MultiMarkdown 6 -- Lightweight markup processor to produce HTML, LaTeX, and more.
 
 @file mmd.h
 
 @brief Header file for libMultiMarkdown.
 
 libMultiMarkdown.h provides the key commands to convert raw MultiMarkdown
 text into a desired export format.
 
 For most simple uses, the main API commands provided here are sufficient.
 For more complex scenarios, however, you may need to handle file
 transclusion which requires knowledge about the location of the source
 file in order to appropriately handle relative links.  In this case, you
 may benefit from examining multimarkdown.c.
 
 @author	Fletcher T. Penney
 @bug	No known bugs
 
 **/

/**
 
 
 
 
 @author	Fletcher T. Penney
 @bug
 
 **/

/*
 
 Copyright © 2016 - 2017 Fletcher T. Penney.
 
 
 The `MultiMarkdown 6` project is released under the MIT License..
 
 GLibFacade.c and GLibFacade.h are from the MultiMarkdown v4 project:
 
 https://github.com/fletcher/MultiMarkdown-4/
 
 MMD 4 is released under both the MIT License and GPL.
 
 
 CuTest is released under the zlib/libpng license. See CuTest.c for the text
 of the license.
 
 
 ## The MIT License ##
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

// MultiMarkdown6.swift is a Swift wrapper for MultiMarkdown (version 6) by Fletcher Penney. Made for convenience and cleaner code by Sl (Shahaf Levi) of Sl's Repository Ltd.

public class MultiMarkdown {
    /// Convert a source String containing MultiMarkdown text to the requested `output_format`, using the provided `parser_extensions` (defaults are .Footnotes, .Smart, .CreateSnippet) and language for localization and smart quotes.
    ///
    /// * Please note: This works best formats that work with single files (like HTML, LaTeX, etc). For complex formats that use multiple files (like EPub, TextBundle, OpenDocumentText, iThoughtsITMZ or MMD with Transclusion), you should use the .export function instead.
    ///
    /// - parameters:
    /// 	- source: `String` containing MultiMarkdown text.
    /// 	- extensions: Requested `parser_extensions`.
    /// 	- format: Requested `output_format`.
    /// 	- language: Requested language for localization and smart quotes.
    /// - returns: `String`, or `nil` if there was any issue.
    public class func parse(_ source: String, extensions: Extensions = [.Footnotes, .Smart, .CreateSnippet], format: OutputFormat = .HTML, language: LocalizationLanguage = .English) -> String? {
        // Convert MMD text to specified format, with specified extensions, and language
        // Returned char * must be freed
        let output = d_string_new("")
        
        let e = mmd_engine_create_with_string(source, extensions.rawValue)
        
        mmd_engine_set_language(e, language.rawValue)
        
        mmd_engine_parse_string(e)
        mmd_engine_export_token_tree(output, e, format.rawValue)
        
        guard let resultPointer = output?.pointee else {
            mmd_engine_free(e, true)
            return nil
        }
        
        let result = String(cString: resultPointer.str)
        
        mmd_engine_free(e, true) // The engine has a private copy of source that must be freed
        d_string_free(output, false)
        
        return result
    }
    
    /// Same as .parse(_:extensions:format:language), but optimized for saving complex file formats like EPub into a file (with the provided directory and name).
    ///
    /// Example Usage:
    /// ```
    /// let string = "This is an *example*"
    /// let directoryURL = FileManager.default.temporaryDirectory
    /// let fileName = "example.epub"
    /// let fileData = MultiMarkdown.export(string, format: .EPub, directory: directoryURL.path)
    /// try fileData?.write(to: directoryURL.appendingPathComponent(fileName))
    /// ```
    ///
    /// - parameters:
    /// 	- source: `String` containing MultiMarkdown text.
    /// 	- extensions: Requested `parser_extensions`.
    /// 	- format: Requested `output_format`.
    /// 	- language: Requested language for localization and smart quotes.
    /// 	- directory: File path to a directory where the data will be saved.
    /// - returns: `Data`, or `nil` if there was any issue.
    public class func export(_ source: String, extensions: Extensions = [.Footnotes, .Smart, .CreateSnippet], format: OutputFormat = .HTML, language: LocalizationLanguage = .English, directory: String = NSTemporaryDirectory()) -> Data? {
        let e = mmd_engine_create_with_string(source, extensions.rawValue)
        mmd_engine_set_language(e, language.rawValue)
        
        guard let result = mmd_engine_convert_to_data(e, format.rawValue, directory)?.pointee else {
            mmd_engine_free(e, true)
            return nil
        }
        
        let data = Data(bytes: result.str, count: Int(result.currentStringLength))
        
        mmd_engine_free(e, true)
        
        return data
    }
    
    /// Does the source string have metadata, using the provided `parser_extensions`?
    ///
    /// - parameters:
    /// 	- source: `String` containing MultiMarkdown text.
    /// 	- extensions: Requested `parser_extensions`.
    /// - returns: `true` if the string contains metadata, `false` if it doesn't.
    public class func hasMetadata(_ source: String, extensions: Extensions = [.Footnotes, .Smart, .CreateSnippet]) -> Bool {
        let e = mmd_engine_create_with_string(source, extensions.rawValue)
        
        var end = 0
        
        let result = mmd_engine_has_metadata(e, &end)
        
        mmd_engine_free(e, true)
        
        return result
    }
    
    /// Extract all of the metadata keys in the source `String` to a `[String]` array, using the provided `parser_extensions`.
    ///
    /// - parameters:
    /// 	- source: `String` containing MultiMarkdown text.
    /// 	- extensions: Requested `parser_extensions`.
    /// - returns: `[String]` array containing all the metadata keys in the source `String`, or `nil` if there was any issue.
    public class func extractMetadataKeys(_ source: String, extensions: Extensions = [.Footnotes, .Smart, .CreateSnippet]) -> [String]? {
        let e = mmd_engine_create_with_string(source, extensions.rawValue)
        
        guard let metadataKeys = mmd_engine_metadata_keys(e) else {
            mmd_engine_free(e, true)
            return nil
        }
        
        let keys = String(cString: metadataKeys)
        let result = keys.split { $0 == "\n" }.map { String($0) }
        
        mmd_engine_free(e, true)
        
        return result
    }
    
    /// Extract the value for the specified metadata key, using the provided `parser_extensions`.
    ///
    /// - parameters:
    /// 	- source: `String` containing MultiMarkdown text.
    /// 	- extensions: Requested `parser_extensions`.
    /// 	- key: The requested metadata key.
    /// - returns: `String` containing the value, or `nil` if there was any issue.
    public class func extractMetadataValue(_ source: String, extensions: Extensions = [.Footnotes, .Smart, .CreateSnippet], key: String) -> String? {
        let e = mmd_engine_create_with_string(source, extensions.rawValue)
        
        guard let value = mmd_engine_metavalue_for_key(e, key) else {
            mmd_engine_free(e, true)
            return nil
        }
        
        let result = String(cString: value)
        
        mmd_engine_free(e, true)
        
        return result
    }
    
    /// Extract all of the metadata to a `[String: String]` dictionary, using the provided `parser_extensions`.
    ///
    /// - parameters:
    /// 	- source: `String` containing MultiMarkdown text.
    /// 	- extensions: Requested `parser_extensions`.
    /// - returns: `[String: String]` dictionary containing all of the metadata in the source `String`, or `nil` if there was any issue.
    public class func extractMetadata(_ source: String, extensions: Extensions = [.Footnotes, .Smart, .CreateSnippet]) -> [String: String]? {
        guard let metadataKeys = extractMetadataKeys(source, extensions: extensions) else { return nil }
        
        var metadata: [String: String] = [:]
        
        for key in metadataKeys {
            if let value = extractMetadataValue(source, key: key) {
                metadata.updateValue(value, forKey: key)
            }
        }
        
        return metadata
    }
    
    /// Return the version string for this build of libMultiMarkdown
    public class func mmdVersion() -> String {
        return String(cString: mmd_version())
    }
    
    /// These are the basic extensions that enable or disable MultiMarkdown features
    public struct Extensions : OptionSet {
        public let rawValue: UInt
        public init(rawValue: UInt) { self.rawValue = rawValue }
        public init(_ rawValue: UInt) { self.rawValue = rawValue }
        init(_ value: parser_extensions) { self.rawValue = UInt(value.rawValue) }
        
        /// Markdown compatibility mode
        public static let Compatability = Extensions(EXT_COMPATIBILITY) 
        
        /// Create complete document
        public static let CreateCompelete = Extensions(EXT_COMPLETE)
        
        /// Create snippet only
        public static let CreateSnippet = Extensions(EXT_SNIPPET)
        
        /// Enable Smart quotes
        public static let Smart = Extensions(EXT_SMART) 
        
        /// Enable Footnotes
        public static let Footnotes = Extensions(EXT_NOTES)
        
        /// Don't add anchors to headers, etc.
        public static let NoAnchors = Extensions(EXT_NO_LABELS)
        
        /// Process Markdown inside HTML
        public static let ProcessHTML = Extensions(EXT_PROCESS_HTML) 
        
        /// Don't parse Metadata
        public static let ShowMetadata = Extensions(EXT_NO_METADATA)
        
        /// Mask email addresses
        public static let MaskEmails = Extensions(EXT_OBFUSCATE) 
        
        /// Enable Critic Markup Support
        public static let CriticMarkup = Extensions(EXT_CRITIC) 
        
        /// Accept all proposed changes
        public static let AcceptCriticMarkup = Extensions(EXT_CRITIC_ACCEPT)
        
        /// Reject all proposed changes
        public static let RejectCriticMarkup = Extensions(EXT_CRITIC_REJECT)
        
        /// Use random numbers for footnote links
        public static let RandomFootnotesNumbers = Extensions(EXT_RANDOM_FOOT) 
        
        /// Perform transclusion(s)
        public static let Transclusion = Extensions(EXT_TRANSCLUDE)
        
        /// Convert from OPML before processing source text
        public static let ParseOPML = Extensions(EXT_PARSE_OPML)
        
        /// Convert from ITMZ (iThoughts) before processing source text
        public static let ParseITMZ = Extensions(EXT_PARSE_ITMZ)
        
        /// Use random numbers for header labels (unless manually defined)
        public static let RandomHeaderLabels = Extensions(EXT_RANDOM_LABELS)
        
        /// 31 is highest number allowed
        public static let Fake = Extensions(EXT_FAKE)
    }
    
    /// Define the output formats we support
    public struct OutputFormat : Equatable, RawRepresentable, Hashable {
        public let rawValue: Int16
        public init(rawValue: Int16) { self.rawValue = rawValue }
        public init(_ rawValue: Int16) { self.rawValue = rawValue }
        init(_ value: output_format) { self.rawValue = Int16(value.rawValue) }
        
        public static let HTML = OutputFormat(FORMAT_HTML) // Well supported
        public static let EPub = OutputFormat(FORMAT_EPUB)
        public static let LaTeX = OutputFormat(FORMAT_LATEX) // Well supported
        public static let Memoir = OutputFormat(FORMAT_MEMOIR)
        public static let Beamer = OutputFormat(FORMAT_BEAMER)
        public static let MMD = OutputFormat(FORMAT_MMD)
        public static let TextBundle = OutputFormat(FORMAT_TEXTBUNDLE)
        public static let TextBundleCompressed = OutputFormat(FORMAT_TEXTBUNDLE_COMPRESSED)
        public static let OpenDocumentText = OutputFormat(FORMAT_ODT)
        public static let FlatOpenDocumentText = OutputFormat(FORMAT_FODT)
        public static let OPML = OutputFormat(FORMAT_OPML)
        public static let iThoughtsITMZ = OutputFormat(FORMAT_ITMZ)
    }
    
    /// Define smart typography languages -- first in list is default
    public struct SmartQuotesLanguage : Equatable, RawRepresentable, Hashable {
        public let rawValue: Int16
        public init(rawValue: Int16) { self.rawValue = rawValue }
        public init(_ rawValue: Int16) { self.rawValue = rawValue }
        init(_ value: smart_quotes_language) { self.rawValue = Int16(value.rawValue) }
        
        public static let English = SmartQuotesLanguage(ENGLISH)
        public static let Dutch = SmartQuotesLanguage(DUTCH)
        public static let French = SmartQuotesLanguage(FRENCH)
        public static let German = SmartQuotesLanguage(GERMAN)
        public static let GermanGuill = SmartQuotesLanguage(GERMANGUILL)
        public static let Spanish = SmartQuotesLanguage(SPANISH)
        public static let Swedish = SmartQuotesLanguage(SWEDISH)
        public static let Hebrew = SmartQuotesLanguage(HEBREW)
    }
    
    /// Define localization languages -- first in list is default
    public struct LocalizationLanguage: Equatable, RawRepresentable, Hashable {
        public let rawValue: Int16
        public init(rawValue: Int16) { self.rawValue = rawValue }
        public init(_ rawValue: Int16) { self.rawValue = rawValue }
        init(_ value: lc_languages) { self.rawValue = Int16(value.rawValue) }
        
        /// English is default
        public static let English = LocalizationLanguage(LC_EN)
        
        /// Español - Spanish
        public static let Spanish = LocalizationLanguage(LC_ES)
        
        /// Deutsch - German
        public static let German = LocalizationLanguage(LC_DE)
        
        /// Français - French
        public static let French = LocalizationLanguage(LC_FR)
        
        /// Nederlands - Dutch
        public static let Dutch = LocalizationLanguage(LC_NL)
        
        /// Svenska - Swedish
        public static let Swedish = LocalizationLanguage(LC_SV)
        
        /// Hebrew - עברית
        public static let Hebrew = LocalizationLanguage(LC_HE)
    }
}

extension String {
    /// Check for MultiMarkdown Metadata
    func hasMMDMetadata(extensions: MultiMarkdown.Extensions = [.Footnotes, .Smart, .CreateSnippet]) -> Bool {
        return MultiMarkdown.hasMetadata(self, extensions: extensions)
    }
}
