//
//  MultiMarkdown6+TokenType.swift
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

extension MultiMarkdown {
    public struct TokenType: Equatable, RawRepresentable, Hashable {
        public let rawValue: UInt16
        public init(rawValue: UInt16) { self.rawValue = rawValue }
        public init(_ rawValue: UInt16) { self.rawValue = rawValue }
        init(_ value: token_types) { self.rawValue = UInt16(value.rawValue) }
        
        //!< DOC_START_TOKEN must be type 0
        public static let docStartToken = TokenType(DOC_START_TOKEN)
        
        public static let lineHR = TokenType(1)
        public static let lineSetext1 = TokenType(2)
        public static let lineSetext2 = TokenType(3)
        public static let lineYAML = TokenType(4)
        public static let lineContinuation = TokenType(5)
        public static let linePlain = TokenType(6)
        public static let lineIndentedTab = TokenType(7)
        public static let lineIndentedSpace = TokenType(8)
        public static let lineTable = TokenType(9)
        public static let lineTableSeparator = TokenType(10)
        public static let lineFallback = TokenType(11)
        public static let lineHTML = TokenType(12)
        public static let lineAtx1 = TokenType(13)
        public static let lineAtx2 = TokenType(14)
        public static let lineAtx3 = TokenType(15)
        public static let lineAtx4 = TokenType(16)
        public static let lineAtx5 = TokenType(17)
        public static let lineAtx6 = TokenType(18)
        public static let lineBlockquote = TokenType(19)
        public static let lineListBulleted = TokenType(20)
        public static let lineListEnumarated = TokenType(21)
        public static let lineDefAbbreviation = TokenType(22)
        public static let lineDefCitation = TokenType(23)
        public static let lineDefFootnote = TokenType(24)
        public static let lineDefGlossary = TokenType(25)
        public static let lineDefLink = TokenType(26)
        public static let lineTOC = TokenType(27)
        public static let lineDefinition = TokenType(28)
        public static let lineMeta = TokenType(29)
        public static let lineBacktick = TokenType(30)
        public static let lineFenceBacktick3 = TokenType(31)
        public static let lineFenceBacktick4 = TokenType(32)
        public static let lineFenceBacktick5 = TokenType(33)
        public static let lineFenceBacktickStart3 = TokenType(34)
        public static let lineFenceBacktickStart4 = TokenType(35)
        public static let lineFenceBacktickStart5 = TokenType(36)
        public static let lineStopComment = TokenType(37)
        public static let lineEmpty = TokenType(38)
        public static let lineStartComment = TokenType(39)
        
        //!< This must start *after* the largest number in parser.h
        public static let blockBlockquote = TokenType(BLOCK_BLOCKQUOTE)
        public static let blockCodeFenced = TokenType(BLOCK_CODE_FENCED)
        public static let blockCodeIndented = TokenType(BLOCK_CODE_INDENTED)
        public static let blockDeflist = TokenType(BLOCK_DEFLIST)
        public static let blockDefinition = TokenType(BLOCK_DEFINITION)
        public static let blockDefAbbreviation = TokenType(BLOCK_DEF_ABBREVIATION)
        public static let blockDefCitation = TokenType(BLOCK_DEF_CITATION)
        public static let blockDefGlossary = TokenType(BLOCK_DEF_GLOSSARY)
        public static let blockDefFootnote = TokenType(BLOCK_DEF_FOOTNOTE)
        public static let blockDefLink = TokenType(BLOCK_DEF_LINK)
        public static let blockEmpty = TokenType(BLOCK_EMPTY)
        //!< Placeholder for theme cascading
        public static let blockHeading = TokenType(BLOCK_HEADING)
        //!< Leave H1, H2, etc. in order
        public static let blockH1 = TokenType(BLOCK_H1)
        public static let blockH2 = TokenType(BLOCK_H2)
        public static let blockH3 = TokenType(BLOCK_H3)
        public static let blockH4 = TokenType(BLOCK_H4)
        public static let blockH5 = TokenType(BLOCK_H5)
        public static let blockH6 = TokenType(BLOCK_H6)
        public static let blockHr = TokenType(BLOCK_HR)
        public static let blockHtml = TokenType(BLOCK_HTML)
        public static let blockListBulleted = TokenType(BLOCK_LIST_BULLETED)
        public static let blockListBulletedLoose = TokenType(BLOCK_LIST_BULLETED_LOOSE)
        public static let blockListEnumerated = TokenType(BLOCK_LIST_ENUMERATED)
        public static let blockListEnumeratedLoose = TokenType(BLOCK_LIST_ENUMERATED_LOOSE)
        public static let blockListItem = TokenType(BLOCK_LIST_ITEM)
        public static let blockListItemTight = TokenType(BLOCK_LIST_ITEM_TIGHT)
        public static let blockMeta = TokenType(BLOCK_META)
        public static let blockPara = TokenType(BLOCK_PARA)
        public static let blockSetext1 = TokenType(BLOCK_SETEXT_1)
        public static let blockSetext2 = TokenType(BLOCK_SETEXT_2)
        public static let blockTable = TokenType(BLOCK_TABLE)
        public static let blockTableHeader = TokenType(BLOCK_TABLE_HEADER)
        public static let blockTableSection = TokenType(BLOCK_TABLE_SECTION)
        public static let blockTerm = TokenType(BLOCK_TERM)
        public static let blockToc = TokenType(BLOCK_TOC)
        
        public static let criticAddOpen = TokenType(CRITIC_ADD_OPEN)
        public static let criticAddClose = TokenType(CRITIC_ADD_CLOSE)
        public static let criticDelOpen = TokenType(CRITIC_DEL_OPEN)
        public static let criticDelClose = TokenType(CRITIC_DEL_CLOSE)
        public static let criticComOpen = TokenType(CRITIC_COM_OPEN)
        public static let criticComClose = TokenType(CRITIC_COM_CLOSE)
        public static let criticSubOpen = TokenType(CRITIC_SUB_OPEN)
        public static let criticSubDiv = TokenType(CRITIC_SUB_DIV)
        public static let criticSubDivA = TokenType(CRITIC_SUB_DIV_A)
        public static let criticSubDivB = TokenType(CRITIC_SUB_DIV_B)
        public static let criticSubClose = TokenType(CRITIC_SUB_CLOSE)
        public static let criticHiOpen = TokenType(CRITIC_HI_OPEN)
        public static let criticHiClose = TokenType(CRITIC_HI_CLOSE)
        
        public static let pairCriticAdd = TokenType(PAIR_CRITIC_ADD)
        public static let pairCriticDel = TokenType(PAIR_CRITIC_DEL)
        public static let pairCriticCom = TokenType(PAIR_CRITIC_COM)
        public static let pairCriticSubAdd = TokenType(PAIR_CRITIC_SUB_ADD)
        public static let pairCriticSubDel = TokenType(PAIR_CRITIC_SUB_DEL)
        public static let pairCriticHi = TokenType(PAIR_CRITIC_HI)
        
        //!< Placeholder for theme cascading
        public static let pairs = TokenType(PAIRS)
        public static let pairAngle = TokenType(PAIR_ANGLE)
        public static let pairBacktick = TokenType(PAIR_BACKTICK)
        public static let pairBracket = TokenType(PAIR_BRACKET)
        public static let pairBracketAbbreviation = TokenType(PAIR_BRACKET_ABBREVIATION)
        public static let pairBracketFootnote = TokenType(PAIR_BRACKET_FOOTNOTE)
        public static let pairBracketGlossary = TokenType(PAIR_BRACKET_GLOSSARY)
        public static let pairBracketCitation = TokenType(PAIR_BRACKET_CITATION)
        public static let pairBracketImage = TokenType(PAIR_BRACKET_IMAGE)
        public static let pairBracketVariable = TokenType(PAIR_BRACKET_VARIABLE)
        public static let pairBrace = TokenType(PAIR_BRACE)
        public static let pairEmph = TokenType(PAIR_EMPH)
        public static let pairMath = TokenType(PAIR_MATH)
        public static let pairParen = TokenType(PAIR_PAREN)
        public static let pairQuoteSingle = TokenType(PAIR_QUOTE_SINGLE)
        public static let pairQuoteDouble = TokenType(PAIR_QUOTE_DOUBLE)
        public static let pairQuoteAlt = TokenType(PAIR_QUOTE_ALT)
        public static let pairRawFilter = TokenType(PAIR_RAW_FILTER)
        public static let pairSubscript = TokenType(PAIR_SUBSCRIPT)
        public static let pairSuperscript = TokenType(PAIR_SUPERSCRIPT)
        public static let pairStar = TokenType(PAIR_STAR)
        public static let pairStrong = TokenType(PAIR_STRONG)
        public static let pairUl = TokenType(PAIR_UL)
        public static let pairBraces = TokenType(PAIR_BRACES)
        
        public static let markup = TokenType(MARKUP)
        public static let star = TokenType(STAR)
        public static let ul = TokenType(UL)
        public static let emphStart = TokenType(EMPH_START)
        public static let emphStop = TokenType(EMPH_STOP)
        public static let strongStart = TokenType(STRONG_START)
        public static let strongStop = TokenType(STRONG_STOP)
        
        public static let bracketLeft = TokenType(BRACKET_LEFT)
        public static let bracketRight = TokenType(BRACKET_RIGHT)
        public static let bracketAbbreviationLeft = TokenType(BRACKET_ABBREVIATION_LEFT)
        public static let bracketFootnoteLeft = TokenType(BRACKET_FOOTNOTE_LEFT)
        public static let bracketGlossaryLeft = TokenType(BRACKET_GLOSSARY_LEFT)
        public static let bracketCitationLeft = TokenType(BRACKET_CITATION_LEFT)
        public static let bracketImageLeft = TokenType(BRACKET_IMAGE_LEFT)
        public static let bracketVariableLeft = TokenType(BRACKET_VARIABLE_LEFT)
        
        public static let parenLeft = TokenType(PAREN_LEFT)
        public static let parenRight = TokenType(PAREN_RIGHT)
        
        public static let angleLeft = TokenType(ANGLE_LEFT)
        public static let angleRight = TokenType(ANGLE_RIGHT)
        
        public static let braceDoubleLeft = TokenType(BRACE_DOUBLE_LEFT)
        public static let braceDoubleRight = TokenType(BRACE_DOUBLE_RIGHT)
        
        public static let ampersand = TokenType(AMPERSAND)
        public static let ampersandLong = TokenType(AMPERSAND_LONG)
        public static let apostrophe = TokenType(APOSTROPHE)
        public static let backtick = TokenType(BACKTICK)
        public static let codeFence = TokenType(CODE_FENCE)
        public static let colon = TokenType(COLON)
        public static let dashM = TokenType(DASH_M)
        public static let dashN = TokenType(DASH_N)
        public static let ellipsis = TokenType(ELLIPSIS)
        public static let quoteSingle = TokenType(QUOTE_SINGLE)
        public static let quoteDouble = TokenType(QUOTE_DOUBLE)
        public static let quoteLeftSingle = TokenType(QUOTE_LEFT_SINGLE)
        public static let quoteRightSingle = TokenType(QUOTE_RIGHT_SINGLE)
        public static let quoteLeftDouble = TokenType(QUOTE_LEFT_DOUBLE)
        public static let quoteRightDouble = TokenType(QUOTE_RIGHT_DOUBLE)
        public static let quoteRightAlt = TokenType(QUOTE_RIGHT_ALT)
        
        public static let escapedCharacter = TokenType(ESCAPED_CHARACTER)
        
        public static let htmlEntity = TokenType(HTML_ENTITY)
        public static let htmlCommentStart = TokenType(HTML_COMMENT_START)
        public static let htmlCommentStop = TokenType(HTML_COMMENT_STOP)
        public static let pairHtmlComment = TokenType(PAIR_HTML_COMMENT)
        
        public static let mathParenOpen = TokenType(MATH_PAREN_OPEN)
        public static let mathParenClose = TokenType(MATH_PAREN_CLOSE)
        public static let mathBracketOpen = TokenType(MATH_BRACKET_OPEN)
        public static let mathBracketClose = TokenType(MATH_BRACKET_CLOSE)
        public static let mathDollarSingle = TokenType(MATH_DOLLAR_SINGLE)
        public static let mathDollarDouble = TokenType(MATH_DOLLAR_DOUBLE)
        
        public static let equal = TokenType(EQUAL)
        public static let pipe = TokenType(PIPE)
        public static let plus = TokenType(PLUS)
        public static let slash = TokenType(SLASH)
        
        public static let superscript = TokenType(SUPERSCRIPT)
        public static let `subscript` = TokenType(SUBSCRIPT)
        
        public static let indentTab = TokenType(INDENT_TAB)
        public static let indentSpace = TokenType(INDENT_SPACE)
        public static let nonIndentSpace = TokenType(NON_INDENT_SPACE)
        
        //!< Leave HASH1, HASH2, etc. in order
        public static let hash1 = TokenType(HASH1)
        public static let hash2 = TokenType(HASH2)
        public static let hash3 = TokenType(HASH3)
        public static let hash4 = TokenType(HASH4)
        public static let hash5 = TokenType(HASH5)
        public static let hash6 = TokenType(HASH6)
        
        public static let markerBlockquote = TokenType(MARKER_BLOCKQUOTE)
        //!< Leave MARKER_H1, MARKER_H2, etc. in order
        public static let markerH1 = TokenType(MARKER_H1)
        public static let markerH2 = TokenType(MARKER_H2)
        public static let markerH3 = TokenType(MARKER_H3)
        public static let markerH4 = TokenType(MARKER_H4)
        public static let markerH5 = TokenType(MARKER_H5)
        public static let markerH6 = TokenType(MARKER_H6)
        public static let markerListBullet = TokenType(MARKER_LIST_BULLET)
        public static let markerListEnumerator = TokenType(MARKER_LIST_ENUMERATOR)
        public static let markerDefListColon = TokenType(MARKER_DEFLIST_COLON)
        
        public static let tableRow = TokenType(TABLE_ROW)
        public static let tableCell = TokenType(TABLE_CELL)
        public static let tableDivider = TokenType(TABLE_DIVIDER)
        
        public static let toc = TokenType(TOC)
        public static let tocSingle = TokenType(TOC_SINGLE)
        public static let tocRange = TokenType(TOC_RANGE)
        
        public static let textBackslash = TokenType(TEXT_BACKSLASH)
        public static let rawFilterLeft = TokenType(RAW_FILTER_LEFT)
        public static let textBraceLeft = TokenType(TEXT_BRACE_LEFT)
        public static let textBraceRight = TokenType(TEXT_BRACE_RIGHT)
        public static let textEmpty = TokenType(TEXT_EMPTY)
        public static let textHash = TokenType(TEXT_HASH)
        public static let textLinebreak = TokenType(TEXT_LINEBREAK)
        public static let textLinebreakSp = TokenType(TEXT_LINEBREAK_SP)
        public static let textNl = TokenType(TEXT_NL)
        public static let textNlSp = TokenType(TEXT_NL_SP)
        public static let textNumberPossList = TokenType(TEXT_NUMBER_POSS_LIST)
        public static let textPercent = TokenType(TEXT_PERCENT)
        public static let textPeriod = TokenType(TEXT_PERIOD)
        public static let textPlain = TokenType(TEXT_PLAIN)
        
        public static let manualLabel = TokenType(MANUAL_LABEL)
        
        public static let objectReplacementCharacter = TokenType(OBJECT_REPLACEMENT_CHARACTER)
    }
}
