## About ##

|            |                           |  
| ---------- | ------------------------- |  
| Title:     | MultiMarkdown SPM       |  
| Author:    | Fletcher T. Penney & Sl (Shahaf Levi)       |  
| Date:      | 2019-05-15 |  
| Copyright: | Copyright © 2016 - 2018 Fletcher T. Penney.    |  
| Version:   | 6.4.1      |  

master branch: [![Build Status](https://travis-ci.org/fletcher/MultiMarkdown-6.svg?branch=master)](https://travis-ci.org/fletcher/MultiMarkdown-6)  
develop branch: [![Build Status](https://travis-ci.org/fletcher/MultiMarkdown-6.svg?branch=develop)](https://travis-ci.org/fletcher/MultiMarkdown-6)

## What is MultiMarkdown SPM? ##

MultiMarkdown SPM is a fork of MultiMarkdown 6, compatible with Swift Package Manager (SPM).

For more details about MultiMarkdown or for using MultiMarkdown in your app or service that isn't using SPM, visit the main repo - <https://github.com/fletcher/MultiMarkdown-6/>.

To get SPM working in your project you need to do the following:

1. Make sure your Swift version is 4.2 or above.
2. Add libMultiMarkdown to your `Package.swift` file:
```swift
import PackageDescription

let package = Package(
...
    dependencies: [
    	...
        .package(url: "https://github.com/slsrepo/MultiMarkdown-SPM.git", from: "6.4.1")
	...
    ],
    targets: [
    	...
        .target(..., dependencies: [..., "libMultiMarkdown", ...]),
	...
    ]
)
```
3. Build or run your app with the following flag: `-Xcc -fbracket-depth=264`. For example: `swift build -Xcc -fbracket-depth=264`, `swift run TargetName -Xcc -fbracket-depth=264`
4. Enjoy :)

## License ##

	The `MultiMarkdown 6` project is released under the MIT License..
	
	GLibFacade.c and GLibFacade.h are from the MultiMarkdown v4 project:
	
		https://github.com/fletcher/MultiMarkdown-4/
	
	MMD 4 is released under both the MIT License and GPL.
	
	
	CuTest is released under the zlib/libpng license. See CuTest.c for the
	text of the license.
	
	uthash library:
		Copyright (c) 2005-2016, Troy D. Hanson
	
		Licensed under Revised BSD license
	
	miniz library:
		Copyright 2013-2014 RAD Game Tools and Valve Software
		Copyright 2010-2014 Rich Geldreich and Tenacious Software LLC
	
		Licensed under the MIT license
	
	argtable3 library:
		Copyright (C) 1998-2001,2003-2011,2013 Stewart Heitmann
		<sheitmann@users.sourceforge.net>
		All rights reserved.
	
		Licensed under the Revised BSD License
	
	
	## The MIT License ##
	
	Permission is hereby granted, free of charge, to any person obtaining
	a copy of this software and associated documentation files (the
	"Software"), to deal in the Software without restriction, including
	without limitation the rights to use, copy, modify, merge, publish,
	distribute, sublicense, and/or sell copies of the Software, and to
	permit persons to whom the Software is furnished to do so, subject to
	the following conditions:
	
	The above copyright notice and this permission notice shall be
	included in all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
	IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
	CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
	TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
	SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
	
	
	## Revised BSD License ##
	
	Redistribution and use in source and binary forms, with or without
	modification, are permitted provided that the following conditions are
	met:
	    * Redistributions of source code must retain the above copyright
	      notice, this list of conditions and the following disclaimer.
	    * Redistributions in binary form must reproduce the above
	      copyright notice, this list of conditions and the following
	      disclaimer in the documentation and/or other materials provided
	      with the distribution.
	    * Neither the name of the <organization> nor the
	      names of its contributors may be used to endorse or promote
	      products derived from this software without specific prior
	      written permission.
	
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
	"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
	LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
	A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT
	HOLDER> BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
	EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
	PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES LOSS OF USE, DATA, OR
	PROFITS OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
	LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
	NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
	SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
	
