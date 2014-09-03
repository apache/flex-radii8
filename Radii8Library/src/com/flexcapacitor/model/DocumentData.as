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
	import com.flexcapacitor.controller.Radiate;
	import com.flexcapacitor.services.IServiceEvent;
	import com.flexcapacitor.services.IWPService;
	import com.flexcapacitor.services.IWPServiceEvent;
	import com.flexcapacitor.services.WPService;
	import com.flexcapacitor.services.WPServiceBase;
	import com.flexcapacitor.services.WPServiceEvent;
	import com.flexcapacitor.utils.MXMLDocumentExporter;
	
	import flash.events.IEventDispatcher;
	import flash.net.FileReference;
	import flash.net.URLVariables;
	import flash.system.ApplicationDomain;
	
	/**
	 * Event dispatched when the save results are returned. 
	 * SaveResultsEvent
	 * */
	[Event(name="saveResults", type="com.flexcapacitor.model.SaveResultsEvent")]
	
	/**
	 * Event dispatched when the document data is retrieved. 
	 * LoadResultsEvent
	 * */
	[Event(name="loadResults", type="com.flexcapacitor.model.LoadResultsEvent")]
	
	/**
	 * Holds document data. 
	 * */
	[RemoteClass(alias="DocumentData")]
	public class DocumentData extends DocumentMetaData implements IDocumentData {
		
		/**
		 * Constructor
		 * */
		public function DocumentData(target:IEventDispatcher = null) {
			super();
		}
		
		/**
		 * Default class that exports the document 
		 * */
		[Transient]
		public static var internalExporter:IDocumentExporter = new MXMLDocumentExporter();
		
		private var _exporter:IDocumentExporter = internalExporter;

		/**
		 * Exports the document to string
		 * */
		[Transient]
		public function get exporter():IDocumentExporter {
			return _exporter;
		}

		/**
		 * @private
		 */
		public function set exporter(value:IDocumentExporter):void {
			_exporter = value;
		}
		
		/**
		 * Constant used to save locally to a shared object
		 * */
		[Transient]
		public static const LOCAL_LOCATION:String = "local";
		
		/**
		 * Constant used to open from internal references
		 * */
		[Transient]
		public static const INTERNAL_LOCATION:String = "internal";
		
		/**
		 * Constant used to save to the local file system
		 * */
		[Transient]
		public static const FILE_LOCATION:String = "file";
		
		/**
		 * Constant used to save to a database
		 * */
		[Transient]
		public static const DATABASE_LOCATION:String = "database";
		
		/**
		 * Constant used to save to the server
		 * */
		[Transient]
		public static const REMOTE_LOCATION:String = "remote";
		
		/**
		 * Constant used to save to the server
		 * */
		[Transient]
		public static const ALL_LOCATIONS:String = "all";
		
		/**
		 * Used to set the type of category used for projects on the server
		 * */
		[Transient]
		public static const PROJECT_CATEGORY:String = "project";
		
		/**
		 * Used to set the type of category used for documents on the server
		 * */
		[Transient]
		public static const DOCUMENT_CATEGORY:String = "document";
		
		public static var DefaultDocumentType:Object;

		private var _description:String;

		/**
		 * Description
		 * */
		public function get description():String {
			return _description;
		}

		/**
		 * @private
		 */
		public function set description(value:String):void {
			_description = value;
		}

		private var _file:FileReference;

		/**
		 * File reference
		 * */
		public function get file():FileReference {
			return _file;
		}

		/**
		 * @private
		 */
		public function set file(value:FileReference):void {
			_file = value;
		}

		
		private var _source:String;

		/**
		 * 
		 * */
		public function get source():String {
			return _source;
		}

		/**
		 * @inheritDoc
		 */
		public function set source(value:String):void {
			_source = value;
		}

		
		private var _originalSource:String;

		/**
		 * 
		 * */
		public function get originalSource():String {
			return _originalSource;
		}

		/**
		 * @inheritDoc
		 */
		public function set originalSource(value:String):void {
			_originalSource = value;
		}
		
		private var _assets:Array = [];

		public function get assets():Array {
			return _assets;
		}

		public function set assets(value:Array):void {
			_assets = value;
		}


		private var _document:IDocument;

		/**
		 * @inheritDoc
		 * */
		[Transient]
		public function get document():IDocument {
			return _document;
		}

		public function set document(value:IDocument):void {
			_document = value;
		}
		
		private var _isChanged:Boolean;

		/**
		 * Indicates if the document is changed
		 * */
		public function get isChanged():Boolean {
			return _isChanged;
		}

		/**
		 * @private
		 */
		[Bindable]
		public function set isChanged(value:Boolean):void {
			_isChanged = value;
		}
		
		private var _saveSuccessful:Boolean;

		/**
		 * @inheritDoc
		 * */
		[Transient]
		public function get saveSuccessful():Boolean {
			return _saveSuccessful;
		}

		public function set saveSuccessful(value:Boolean):void {
			_saveSuccessful = value;
		}

		
		private var _saveInProgress:Boolean;

		/**
		 * Indicates if a save is in progress. 
		 * */
		[Bindable]
		[Transient]
		public function get saveInProgress():Boolean {
			return _saveInProgress;
		}

		public function set saveInProgress(value:Boolean):void {
			_saveInProgress = value;
		}
		
		private var _openSuccessful:Boolean;

		/**
		 * Indicates if open was successful.
		 * */
		[Transient]
		public function get openSuccessful():Boolean {
			return _openSuccessful;
		}

		public function set openSuccessful(value:Boolean):void {
			_openSuccessful = value;
		}

		private var _openInProgress:Boolean;

		/**
		 * Indicates if open is in progress.
		 * */
		[Bindable]
		public function get openInProgress():Boolean {
			return _openInProgress;
		}

		public function set openInProgress(value:Boolean):void {
			_openInProgress = value;
		}
		
		public var firstTimeSave:Boolean;

		
		private var _saveService:IWPService;

		/**
		 * Service that saves to WP installation
		 * */
		[Transient]
		public function get saveService():IWPService {
			return _saveService;
		}

		/**
		 * @private
		 */
		public function set saveService(value:IWPService):void {
			_saveService = value;
		}

		/**
		 * Used to open document
		 * */
		public var openService:WPService;
		
		/**
		 * @inheritDoc
		 * */
		public function save(locations:String = LOCAL_LOCATION, options:Object = null):Boolean {
			var saveRemote:Boolean = locations.indexOf(REMOTE_LOCATION)!=-1;
			var saveLocally:Boolean = locations.indexOf(LOCAL_LOCATION)!=-1;
			var form:URLVariables;
			
			if (saveRemote) {
			//Radiate.log.info("Save");
				// we need to create service
				if (saveService==null) {
					var wpSaveService:WPService = new WPService();
					wpSaveService.host = host;
					wpSaveService.addEventListener(WPServiceBase.RESULT, saveResultsHandler, false, 0, true);
					wpSaveService.addEventListener(WPServiceBase.FAULT, saveFaultHandler, false, 0, true);
					saveService = wpSaveService;
				}
				
				saveSuccessful = false;
				saveInProgress = true;
				
				form = toSaveFormObject();
				
				// save project
				saveService.save(form);
			}
			
			if (saveLocally) {
				// check if remote id is not set. 
				// if we can't save remotely we should still save locally
				// but if we can save remotely and we need to save
				// again when we have an id from the server
				var result:Boolean = saveDocumentLocally()
				return result;
			}
			
			return false;
		}
		
		/**
		 * Open 
		 * */
		public function open(location:String = null):void {
			var loadRemote:Boolean = location==REMOTE_LOCATION;
			var loadLocally:Boolean = location==LOCAL_LOCATION;
			
			if (location==REMOTE_LOCATION) {
				//Radiate.log.info("Open Document Remote");
				retrieve();
			}
			else if (location==LOCAL_LOCATION) {
				//var documentData:IDocumentData = Radiate.getInstance().getDocumentLocally(this);
				//Radiate.log.info("Open Document Local");
			}
			else {
				//Radiate.log.info("Open Document normal");
				//source = getSource();
			}
			
			isOpen = true;
		}
		
		/**
		 * @inheritDoc
		 * */
		public function close():void {
			//Radiate.log.info("Close Document");
			source = getSource();
			isOpen = false;
		}
		
		/**
		 * @inheritDoc
		 * */
		public function retrieve(local:Boolean = false):void {
			var form:Object;
			
			// we need to create service
			if (openService==null) {
				openService = new WPService();
				openService.host = host;
				openService.addEventListener(WPServiceBase.RESULT, openResultsHandler, false, 0, true);
				openService.addEventListener(WPServiceBase.FAULT, openFaultHandler, false, 0, true);
			}
			
			openSuccessful = false;
			openInProgress = true;
			
			form = toLoadFormObject();
			
			// open project
			openService.open(id);
		}
		
		/**
		 * Creates an object to send to the server
		 * */
		public function toSaveFormObject():URLVariables {
			var object:URLVariables = new URLVariables();
			var value:String = getSource();
			object.title = name;
			object.content = value;
			object["custom[uid]"] = uid;
			object["custom[source]"] = value;
			object["custom[sponge]"] = 1;
			object["custom[sandpaper]"] = 1;
			object.categories = "document";
			
			if (id) 		object.id 		= id;
			if (status)		object.status 	= status;
			
			return object;
		}
		
		/**
		 * Creates an object to send to the server
		 * */
		public function toLoadFormObject():Object {
			var object:Object = {};
			
			if (id) object.id = id;
			
			return object;
		}
		
		/**
		 * Result from save result
		 * */
		public function saveResultsHandler(event:IWPServiceEvent):void {
			var saveResultsEvent:SaveResultsEvent = new SaveResultsEvent(SaveResultsEvent.SAVE_RESULTS);
			var data:Object = event.data;
			//var post:Object;
			//Radiate.log.info("Save result handler on document " + name);
			
			saveResultsEvent.call = event.call;
			saveResultsEvent.data = event.data;
			saveResultsEvent.message = event.message;
			saveResultsEvent.text = event.text;
			
			if (data && data.post) {
				if (id==null) {
					//Radiate.log.info("Document does not have an id. Needs to be resaved: "+ name);
					id = data.post.id;
					// we don't have id so we need to save again
					// doing it in the sub classes because we need to 
					// update the source (for project)
					//save(REMOTE_LOCATION);
					//return;
				}
				
				saveResultsEvent.successful = true;
				saveSuccessful = true;
				//Radiate.log.info("Document saved: "+ name);
				
				Radiate.instance.setLastSaveDate();
			}
			else {
				saveSuccessful = false;
				//Radiate.log.info("Document not saved: "+ name);
			}
			
			
			saveInProgress = false;
			
			dispatchEvent(saveResultsEvent);
		}
		
		/**
		 * Result from save fault
		 * */
		public function saveFaultHandler(event:IServiceEvent):void {
			var saveResultsEvent:SaveResultsEvent = new SaveResultsEvent(SaveResultsEvent.SAVE_RESULTS);
			
			Radiate.log.info("Error when trying to save document: "+ name + ".");
			
			saveInProgress = false;
			
			dispatchEvent(saveResultsEvent);
		}
		
		/**
		 * Result from open result
		 * */
		public function openResultsHandler(event:IServiceEvent):void {
			var openResultsEvent:LoadResultsEvent = new LoadResultsEvent(LoadResultsEvent.LOAD_RESULTS);
			var data:Object = event.data;
			var post:Object;
			
			//Radiate.log..info("Open result handler on document " + name);
			// when the post id was null then we ended up receiving the latest post 
			
			if (data && data.post) {
				post = data.post; //TODO create value object
				
				//source = data.post.content;
				if ("source" in post.custom_fields) {
					source = post.custom_fields.source;
					originalSource = source;
				}
				else {
					source = post.content;
				}
				
				// this is because WP adds formating to the content
				// there is a plugin that disables formatting that was enabled on the site but not currently
				// but you have to set custom fields on the post to enable it
				// this should eventually be fixed
				if (source.indexOf("<p>")==0) {
					source = source.substr(3);
					var li:int = source.lastIndexOf("</p>");
					source = source.substr(0, li);
				}
				
				if (source.indexOf("<br />")!=-1) {
					source = source.replace(/<br \/>/g, "");
				}
				
				if (post.attachments && post.attachments.length>0) {
					parseAttachments(post.attachments);
				}
				
				openResultsEvent.successful = true;
				openSuccessful = true;
				//Radiate.log.info("Document open: "+ name);
			}
			else {
				
				if (event is WPServiceEvent) {
					openResultsEvent.message = WPServiceEvent(event).message;
				}
				//Radiate.log.info("Document not opened: "+ name);
			}
			
			openResultsEvent.data = data;
			openResultsEvent.text = event.text;
			openInProgress = false;
			
			isOpen = true;
			dispatchEvent(openResultsEvent);
		}
		
		/**
		 * Result from open fault
		 * */
		public function openFaultHandler(event:IServiceEvent):void {
			var openResultsEvent:OpenResultsEvent = new OpenResultsEvent(SaveResultsEvent.SAVE_RESULTS);
			
			Radiate.log.info("Error when trying to open document: "+ name + ".");
			
			saveInProgress = false;
			
			dispatchEvent(openResultsEvent);
		}
		
		/**
		 * Parses attachments
		 * */
		public function parseAttachments(attachments:Array):void {
			var length:int;
			var object:Object;
			var attachment:AttachmentData;
			
			if (attachments && attachments.length>0) {
				length = attachments.length;
				
				for (var i:int;i<length;i++) {
					object = attachments[i];
					
					if (String(object.mime_type).indexOf("image/")!=-1) {
						attachment = new ImageData();
						attachment.unmarshall(object);
					}
					else {
						attachment = new AttachmentData();
						attachment.unmarshall(object);
					}
					
					addAsset(attachment);
				}
			}
		}
		
		/**
		 * Add an asset
		 * */
		public function addAsset(asset:AttachmentData):Boolean {
			var length:int = assets ? assets.length:0;
			var exists:Boolean;
			
			for (var i:int;i<length;i++) {
				if (assets[i].id==asset.id) {
					exists = true;
					break;
				}
			}
			
			if (!exists) {
				assets.push(asset);
				return true;
			}
			
			return false;
		}
		
		/**
		 * Removes an asset
		 * */
		public function removeAsset(asset:AttachmentData):Boolean {
			var length:int = assets ? assets.length:0;
			var exists:Boolean;
			
			for (var i:int;i<length;i++) {
				if (assets[i].id==asset.id) {
					exists = true;
					break;
				}
			}
			
			if (exists) {
				assets.splice(i, 1);
				return true;
			}
			
			return false;
		}

		/**
		 * Get source code for document. 
		 * If document isn't created yet get last stored source code
		 * 
		 * This is overridden in Document
		 * TODO test this
		 * */
		public function getSource(target:Object = null):String {
			
			// if document isn't created yet get stored source code - refactor
			if (!document) {
				return source;
			}
			/*else {
				return internalExporter.exportXMLString(this);
			}*/
			
			// you are in DocumentData
			return source;
			//throw new Error("GetSource not implemented. Override in sub class");
		}
		
		
		/**
		 * Serialize. Export for saving to disk or server
		 * */
		override public function marshall(dataType:String = DOCUMENT_TYPE, representation:Boolean = false):Object {
			var object:Object;
			
			// if string type get xml object. we will translate later
			if (dataType==STRING_TYPE || dataType==XML_TYPE) {
				object = super.marshall(XML_TYPE, representation);
			}
			
			if (dataType==METADATA_TYPE) {
				object = super.marshall(METADATA_TYPE, representation);
				return DocumentMetaData(object);
			}
			else if (dataType==DOCUMENT_TYPE) {
				// get default document data information
				object = super.marshall(METADATA_TYPE, representation);
				var documentData:DocumentData = new DocumentData();
				documentData.unmarshall(object);
				documentData.source = getSource();
			
				return DocumentData(documentData);
			}
			else if (dataType==STRING_TYPE || dataType==XML_TYPE ) {				
				var xml:XML = object as XML;
				
				// add source
				if (!representation) {
					//source = getSource();
					
					if (source) {
						//xml = XMLUtils.setItemContents(xml, "source", source);
					}
				}
				
				
				if (dataType==STRING_TYPE) {
					return xml.toXMLString();
				}
				
				return xml;
			}
			
			return object;
		}
		
		/**
		 * Deserialize document data. Import.
		 * */
		override public function unmarshall(data:Object):void {
			super.unmarshall(data);
			// this should probably be overriden by sub classes
			if (data is IDocumentData) {
				source 	= data.source;
			}
			else if (data is XML) {
				source 	= data.content;
				originalSource = XML(data).toXMLString();
			}
		}
		
		/**
		 * Get basic project metadata
		 * */
		public function toMetaData():IDocumentMetaData {
			return marshall(METADATA_TYPE, true) as IDocumentMetaData;
		}
		
		/**
		 * Exports to XML
		 * */
		public function toXML(representation:Boolean = false):XML {
			return marshall(XML_TYPE, representation) as XML;
		}

		/**
		 * Exports an XML string.
		 * If representation is true then just returns just enough basic information to locate it. 
		 * */
		override public function toString():String {
			return marshall(STRING_TYPE, false) as String;
		}
		
		/**
		 * Creates an instance of the document type
		 * */
		public function createInstance(data:Object = null):IDocument {
			var iDocument:IDocument;
			var hasDefinition:Boolean = ApplicationDomain.currentDomain.hasDefinition(className);
			var DocumentType:Object = Document;
			
			if (hasDefinition) {
				DocumentType = ApplicationDomain.currentDomain.getDefinition(className);
			}
			
			iDocument = new DocumentType();
			
			if (data) {
				iDocument.unmarshall(data);
			}
			
			
			return iDocument;
		}
		
		/**
		 * Save document locally
		 * */
		public function saveDocumentLocally():Boolean {
			// for now just passing to saveDocument
			var result:Boolean = Radiate.getInstance().saveDocumentLocally(this);
			
			
			/*var result:Object = SharedObjectUtils.getSharedObject(SAVED_DATA_NAME);
			var so:SharedObject;
			
			if (result is SharedObject) {
				updateSaveDataForDocument(document);
				so = SharedObject(result);
				so.setProperty(SAVED_DATA_NAME, savedData);
				so.flush();
				//log.info("Saved Data: " + ObjectUtil.toString(so.data));
			}
			else {
				log.error("Could not save data. " + ObjectUtil.toString(result));
				//return false;
			}
			
			return true;*/
			return result;
		}
	}
}