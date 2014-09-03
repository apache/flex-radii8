////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////

package com.flexcapacitor.model {
	import com.flexcapacitor.utils.supportClasses.ComponentDescription;
	
	
	
	/**
	 * Handles exporting to various formats
	 * */
	public interface IDocumentExporter {
		
		/**
		 * Is valid
		 * */
		function set isValid(value:Boolean):void;
		function get isValid():Boolean;
		
		/**
		 * Error event
		 * */
		function set error(value:Error):void;
		function get error():Error;
		
		/**
		 * Error message
		 * */
		function set errorMessage(value:String):void;
		function get errorMessage():String;
		
		/**
		 * Errors
		 * */
		function set errors(value:Array):void;
		function get errors():Array;
		
		/**
		 * Warnings
		 * */
		function set warnings(value:Array):void;
		function get warnings():Array;
		
		/**
		 * Exports to an XML string. When reference is true it returns
		 * a shorter string with a URI to the document details
		 * */
		function export(document:IDocument, target:ComponentDescription = null, reference:Boolean = false):*;
		
		/**
		 * Export to XML. When reference is true it returns
		 * a shorter string with a URI to the document details
		 * */
		function exportXML(document:IDocument, reference:Boolean = false):XML;
		
		/**
		 * Export to JSON representation. When reference is true it returns
		 * a shorter string with a URI to the document details
		 * */
		function exportJSON(document:IDocument, reference:Boolean = false):JSON;
	}
}