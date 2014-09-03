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
	
	/**
	 * Used to store the least amount of information about a document so it can be retrieved later.
	 * */
	public interface IDocumentMetaData {
		
		/**
		 * Name of the document
		 * */
		function set name(value:String):void;
		function get name():String;
		
		/**
		 * A unique ID that is used to find the document through it's various locations
		 * */
		function get uid():String;
		function set uid(value:String):void;
		
		/**
		 * A unique URI that is used to find the document through it's various locations
		 * */
		function get uri():String;
		function set uri(value:String):void;
		
		/**
		 * The ID of the record that this document is saved at remotely
		 * */
		function get id():String;
		function set id(value:String):void;
		
		/**
		 * The host that the document is located at. Used with the ID property. 
		 * */
		function get host():String;
		function set host(value:String):void;
		
		/**
		 * The status that the document is in. For example, draft or publish. 
		 * */
		function get status():String;
		function set status(value:String):void;
		
		/**
		 * The type of document 
		 * */
		function get type():String;
		function set type(value:String):void;
		
		/**
		 * The content type or mime type of document. For example, "image/jpg". 
		 * */
		function get contentType():String;
		function set contentType(value:String):void;
		
		/**
		 * The class type of document 
		 * */
		function get className():String;
		function set className(value:String):void;
		
		/**
		 * The date the document was last saved. 
		 * */
		function get dateSaved():String;
		function set dateSaved(value:String):void;
		
		/**
		 * Serializes document. Export. 
		 * */
		function marshall(type:String = "", representation:Boolean = true):Object;
		
		/**
		 * Deserializes the data. Import. 
		 * */
		function unmarshall(data:Object):void;
	}
	
	
}