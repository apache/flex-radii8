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
	 * Describes the interface of a project
	 * */
	public interface IProject extends IDocumentData {
		
		/**
		 * Project documents
		 * */
		function set documents(value:Array):void;
		function get documents():Array;
		
		/**
		 * Project documents meta data
		 * */
		function set documentsMetaData(value:Array):void;
		function get documentsMetaData():Array;
		
		/**
		 * Reference to the last saved project data object
		 * */
		function get projectData():IProjectData;
		function set projectData(value:IProjectData):void;
		
		/**
		 * Import documents
		 * */
		function importDocumentInstances(documents:Array, overwrite:Boolean = false):void;
		
		/**
		 * Add document
		 * */
		function addDocument(document:IDocument, overwrite:Boolean = false):void;
		
		/**
		 * Get savable document data. If open is true then only returns open documents. 
		 * */
		function getSavableDocumentsData(open:Boolean = false, metaData:Boolean = false):Array;
		
		/**
		 * Open the project documents from meta data
		 * */
		function openFromMetaData(location:String = null):void;

		/**
		 * Checks if project has any changes and marks isChanged to true if true
		 * */
		function checkProjectHasChanged():Boolean;

		/**
		 * Gets document by UID.
		 * */
		function getDocumentByUID(uid:String):IDocumentData;
	}
}