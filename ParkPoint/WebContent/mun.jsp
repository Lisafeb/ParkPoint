<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
	<!-- Afiseaza obiectele din doua straturi diferite (puncte si poligoane) 
	si la click deschide un popup diferit pentru cele doua tipuri de obiect cu editare atribute si atasament fisiere -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<meta name="viewport"
	content="initial-scale=1, maximum-scale=1,user-scalable=yes">
<title>Parking manager</title>

<link rel="stylesheet"
	href="https://js.arcgis.com/3.17/dijit/themes/claro/claro.css">
<link rel="stylesheet"
	href="https://js.arcgis.com/3.17/esri/css/esri.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
	<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js" type="text/javascript"></script>
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js" type="text/javascript"></script>
  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css">

<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.2.2/css/buttons.dataTables.min.css">


    <script type="text/javascript"   src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
<style type="text/css">
html, body {
	height: 100%;
	width: 100%;
	margin: 0;
	overflow: hidden;
}

#map {
	padding: 0;
}

#header {
	font-size: 1.1em;
	font-family: sans-serif;
	padding-left: 1em;
	padding-top: 4px;
	color: #660000;
}

#divtabel {
	background-color: #fff;
	box-shadow: 0 0 5px #888;
	font-size: 1.1em;
	position: absolute;
	left: 20px;
	top: 20px;
	padding: 5px;
	overflow: auto;
	height: 400px;
	width: 30%;
	z-index: 40;
	padding-top: 12px;
	padding-bottom: 12px;
	text-align: left;
	color: black;
}
 labelHover {
    display: inline-block;
    width: 5em;
  }
 
.templatePicker {
	border: none;
}

.dj_ie .infowindow .window .top .right .user .content {
	position: relative;
}

.dj_ie .simpleInfoWindow .content {
	position: relative;
}
</style>

<script src="https://js.arcgis.com/3.17/" type="text/javascript"></script>
<script type="text/javascript">
      var map;
      var attachmentEditor;
      require([
        "esri/map",
        "esri/tasks/query", 
        "esri/tasks/QueryTask", 
        "esri/graphic",
        "dojo/_base/lang",
        "esri/toolbars/draw",
        "esri/tasks/GeometryService",

        "esri/layers/ArcGISTiledMapServiceLayer",
        "esri/layers/FeatureLayer",

        "esri/Color",
        "esri/symbols/SimpleMarkerSymbol",
        "esri/symbols/SimpleLineSymbol",

        "esri/dijit/editing/TemplatePicker",
        "esri/dijit/editing/AttachmentEditor",

        "esri/config",
      
        "dojo/i18n!esri/nls/jsapi",

        "dojo/_base/array", 
        "dojo/parser",
        "dojo/query", 
        "dojo/keys",
        "dojo/dom",
        "dojo/on",

      
        "dojo/domReady!"
      ], function(
        Map,  
        Query,
        QueryTask,
        Graphic, 
        lang, 
        Draw, 
        GeometryService,
        ArcGISTiledMapServiceLayer, 
        FeatureLayer,
        Color, 
        SimpleMarkerSymbol, 
        SimpleLineSymbol,
        TemplatePicker, 
        AttachmentEditor,
        esriConfig, 
        jsapiBundle,
        arrayUtils, 
        parser,
        query, 
        keys,
        dom, 
        on
      ) {
        parser.parse();
        
        
        
        esriConfig.defaults.io.proxyUrl = "proxy/proxy.jsp";
        esriConfig.defaults.io.alwaysUseProxy = false;

        // snapping is enabled for this sample - change the tooltip to reflect this
       // jsapiBundle.toolbars.draw.start = jsapiBundle.toolbars.draw.start +  "<br>Press <b>ALT</b> to enable snapping";

        // refer to "Using the Proxy Page" for more information:  https://developers.arcgis.com/javascript/3/jshelp/ags_proxy.html
       // esriConfig.defaults.io.proxyUrl = "/proxy/";

        //This service is for development and testing purposes only. We recommend that you create your own geometry service for use within your applications.
        esriConfig.defaults.geometryService = new GeometryService("https://utility.arcgisonline.com/ArcGIS/rest/services/Geometry/GeometryServer");

        map = new Map("map", {
          basemap: "streets",
          extent: new esri.geometry.Extent({ "xmin": 2109143.321569743, 
		     "ymin": 5845623.9553116495, "xmax": 2971964.49685277, 
		     "ymax": 6282232.260876554,"spatialReference":{"wkid":102100}}),
          zoom: 10,
          slider: false
        });

        map.on("layers-add-result", initEditor);
    //    map.on("load", mapLoaded);
    
    map.on("load", function(){
    	  attachmentEditor = new AttachmentEditor({}, dom.byId("content"));
	    	attachmentEditor.startup(); 
    })
          
  
        var responsePoints = new FeatureLayer("http://109.166.213.45:6080/arcgis/rest/services/Disertatie/DizertatieElisa/FeatureServer/0", {
          mode: FeatureLayer.MODE_ONDEMAND,
          outFields: ['*']
        });
        
        var responsePolygon = new FeatureLayer("http://109.166.213.45:6080/arcgis/rest/services/Disertatie/DizertatieElisa/FeatureServer/1",{
        	mode: FeatureLayer.MODE_ONDEMAND,
        	outFields: ['*']
        });

    
        map.addLayers([responsePoints, responsePolygon]);
        
        responsePolygon.on("click", afisareInfoPolygon); 
        responsePoints.on("click", afisareInfo);
        
        
       
    
				
				function afisareInfoPolygon(evt) {

					//var objectID ="";
					var address = "";
					var totalCapacity = "";
					var totalDisabledParking = "";
					var operationalDays = "";
					var operationalHours = "";
					var restrictions = "";
					var timeLimit = "";
					var ownedBy = "";

					var contentTeren = "";

					if (evt.graphic.attributes.Address != null) {
						address = evt.graphic.attributes.Address;
					}
					;
					if (evt.graphic.attributes.TotalCapacity != null) {
						totalCapacity = evt.graphic.attributes.TotalCapacity;
					}
					;
					if (evt.graphic.attributes.TotalDisabledParking != null) {
						totalDisabledParking = evt.graphic.attributes.TotalDisabledParking;
					}
					;
					if (evt.graphic.attributes.OperationalDays != null) {
						operationalDays = evt.graphic.attributes.OperationalDays;
					}
					;
					if (evt.graphic.attributes.OperationalHours != null) {
						operationalHours = evt.graphic.attributes.OperationalHours;
					}
					;
					if (evt.graphic.attributes.Restrictions != null) {
						restrictions = evt.graphic.attributes.Restrictions;
					}
					;
					if (evt.graphic.attributes.TimeLimit != null) {
						timeLimit = evt.graphic.attributes.TimeLimit;
					}
					;
					if (evt.graphic.attributes.OwnedBy != null) {
						ownedBy = evt.graphic.attributes.OwnedBy;
					}
					;

					contentTeren += "<p>Address: </p> <input type='text' id='AddressInput' value='"+address+"'/> <br>"
							+ "<p>Total Capacity: </p> <input id='TotalCapacityInput' value='"+totalCapacity+"'/><br>"
							+ "<p>No. of disabled parking places: </p> <input id='TotalDisabledParkingInput' value='"+totalDisabledParking+"'/><br>"
							+ "<p>Operational Days: </p> <input id='OperationalDaysInput' value='"+operationalDays+"'/><br>"
							+ "<p>Operational Hours: </p> <input id='OperationalHoursInput' value='"+operationalHours+"'/><br>"
							+ "<p>Restrictions: </p> <input id='RestrictionsInput' value='"+restrictions+"'/><br>"
							+ "<p>Time Limit: </p> <input id='TimeLimitInput' value='"+timeLimit+"'/><br>"
							+ "<p>Owned By: </p> <input type='text'  id='OwnedByInput' value='"+ownedBy+"'/><br> ";

					attachmentEditor.showAttachments(evt.graphic,
							responsePolygon);

					newGraphic = evt.graphic;

					$("#dialogPolygon")
							.dialog(
									{
										autoOpen : false,
										modal : true,
										show : {
											effect : "blind",
											duration : 1000
										},
										hide : {
											effect : "blind",
											duration : 1000
										},
										width : 500,
										height : 500,
										stack : true,

										buttons : {

											"Update" : function() {

												newGraphic.attributes.Address = document.getElementById("AddressInput").value;
												newGraphic.attributes.TotalCapacity = document.getElementById("TotalCapacityInput").value;
												newGraphic.attributes.TotalDisabledParking = document.getElementById("TotalDisabledParkingInput").value;
												newGraphic.attributes.OperationalDays = document.getElementById("OperationalDaysInput").value;
												newGraphic.attributes.OperationalHours = document.getElementById("OperationalHoursInput").value;
												newGraphic.attributes.Restrictions = document.getElementById("RestrictionsInput").value;
												newGraphic.attributes.TimeLimit = document.getElementById("TimeLimitInput").value;
												newGraphic.attributes.OwnedBy = document.getElementById("OwnedByInput").value;

												responsePolygon.applyEdits(null,[ newGraphic ], null,function(e) {
																	drawToolbar.deactivate();
																	$('#dialogPolygon').dialog("close");
																});

											},

											"Delete" : function() {

												var r = confirm("Are you sure you want to delete this object?");
												if (r == true) {
													responsePolygon.applyEdits(null, null,[ newGraphic ],function(e) {
															});
													alert("This object was deleted successfully.");
													$('#dialogPolygon').dialog(
															"close");

												} else {
													alert("The object was not deleted.");

												}

											}

										}

									});

					document.getElementById("dialogPolygonInfo").innerHTML = contentTeren;
					$('#dialogPolygon').dialog("open");

				}

				function afisareInfo(evt) {

					console.log("on click ", evt.graphic);
					var lotID = "";
					
					// OBS!!! Here, the disabledParking attribute refers to the date&time when the parking place was 
					//occupied last. 
					var disabledParking = "";
					var accessType = "";
					var paid = "";
					var available = "";
					var availabilityRate = "";

					var content2 = "";

					if (evt.graphic.attributes.LotID != null) {
						lotID = evt.graphic.attributes.LotID;
					}
					;
					if (evt.graphic.attributes.DisabledParking != null) {
						disabledParking = evt.graphic.attributes.DisabledParking;
					}
					;
					if (evt.graphic.attributes.AccessType != null) {
						accessType = evt.graphic.attributes.AccessType;
					}
					;
					if (evt.graphic.attributes.Paid != null) {
						paid = evt.graphic.attributes.Paid;
					}
					;
					if (evt.graphic.attributes.Available != null) {
						available = evt.graphic.attributes.Available;
					}
					;
					if (evt.graphic.attributes.AvailabilityRate != null) {
						availabilityRate = evt.graphic.attributes.AvailabilityRate;
					};

					content2 += "<p><b>Lot ID:</b> </p> <input id='LotIDInput' value='"+lotID+"'/> <br>"
							+ "<p><b>Last Time Occupied:</b> </p> <input type='text' id='DisabledParkingInput' value='"+disabledParking+"'/>  <br>"
							+ "<p><b>Average occupation time:</b> </p> "+accessType+" minutes <br>"
							+ "<p><b>Paid:</b> </p> <input id='PaidInput' value='"+paid+"'/><br>";

					if (evt.graphic.attributes.Available == "Yes") {
						content2 += "<p><b>Available:</b> </p> <select id='AvailableInput'><option value="+evt.graphic.attributes.Available+"> "
								+ evt.graphic.attributes.Available
								+ "</option><option value='No'>No</option></select> <br>";
					} else
						content2 += "<p><b>Available:</b> </p> <select id='AvailableInput'><option value="+evt.graphic.attributes.Available+"> "
								+ evt.graphic.attributes.Available
								+ "</option><option value='Yes'>Yes</option></select> <br>";
						content2+="<p><b>Availability Rate:</b> </p> It was occupied "+availabilityRate+" times<br>";
					newGraphic = evt.graphic;

					$("#dialogShow")
							.dialog(
									{
										autoOpen : false,
										modal : true,
										show : {
											effect : "blind",
											duration : 1000
										},
										hide : {
											effect : "blind",
											duration : 1000
										},
										width : 600,
										height : 500,
										stack : true,
										buttons : {
											"Update" : function() {

												newGraphic.attributes.LotID = document.getElementById("LotIDInput").value;
												newGraphic.attributes.DisabledParking = document.getElementById("DisabledParkingInput").value;
											//	newGraphic.attributes.AccessType = document.getElementById("AccessTypeInput").value;
												newGraphic.attributes.Paid = document.getElementById("PaidInput").value;
											//if a parking place becomes occupied
												if (newGraphic.attributes.Available == 'Yes' && document.getElementById("AvailableInput").value == 'No') 
												{
													//increase Number of occupations
													console.log(newGraphic.attributes.Available, "newGraphic.attributes.Available");
													console.log(availabilityRateInt, "availabilityRateInt");
													var availabilityRateInt = parseInt(newGraphic.attributes.AvailabilityRate);
													availabilityRateInt=availabilityRateInt+1;
													newGraphic.attributes.AvailabilityRate=availabilityRateInt;
													//save occupation time in disabledParking attribute
													var occupationTimeStart = new Date();
													newGraphic.attributes.DisabledParking=occupationTimeStart.toString();
	
												}
													//else show how much time the parking lot was last occupied
													else
														if (newGraphic.attributes.Available == 'No' && document.getElementById("AvailableInput").value == 'Yes')
														{
														var occupationTimeEnd=new Date;
														var time2ms= occupationTimeEnd.getTime(occupationTimeEnd); //i get the time in ms  
														console.log("it was eliberated", occupationTimeEnd);
														var occupationTimeStart = new Date(newGraphic.attributes.DisabledParking);
														var time1ms= occupationTimeStart.getTime(occupationTimeStart); 
														console.log("it was occupied", occupationTimeStart);
													
														var difference = time2ms-time1ms;
														var lastDuration  = Math.floor(difference % 36e5 / 60000)
														newGraphic.attributes.AccessType =lastDuration;
													    console.log("occupation duration", newGraphic.attributes.AccessType);
													    
														//now average the total
														timesItWasOccupied = parseInt(newGraphic.attributes.AvailabilityRate);
														console.log("timesItWasOccupied", timesItWasOccupied);
														var previousAverage = parseInt(newGraphic.attributes.AccessType);
														console.log("previous average", previousAverage);
														var newAverage = (previousAverage * timesItWasOccupied + lastDuration) / (1 + timesItWasOccupied);
													    
														newGraphic.attributes.AccessType = newAverage;
														console.log("current average", newAverage) ;
													};
													
											//	};
												
												
												newGraphic.attributes.Available = document.getElementById("AvailableInput").value;
												responsePoints.applyEdits(null,[ newGraphic ],null,function(e) {
																	drawToolbar.deactivate();
																	$('#dialogShow').dialog("close");

																});

											},
											"Delete" : function() {

												var r = confirm("Are you sure you want to delete this object?");
												if (r == true) {
													responsePoints.applyEdits(null, null,[ newGraphic ],
															function(e) {
															});
													alert("This object was deleted successfully.");
													$('#dialogShow').dialog("close");
												} else {
													alert("The object was not deleted.");

												}

											}

										}

									});
					document.getElementById("dialogShow").innerHTML = content2;

					$('#dialogShow').dialog("open");
				}
			    
		         var queryTask = new QueryTask(
				"http://109.166.213.45:6080/arcgis/rest/services/Disertatie/DizertatieElisa/MapServer/0");
		       
		         query = new Query();
		         query.returnGeometry = false;
		         query.where ="1=1";
		         query.outFields = ["LotID", "DisabledParking","AccessType","Available", "AvailabilityRate"];
						
				$('#statistics').on('click', execute);
						
				function execute() {
					
						query.geometry = event.mapPoint;
						responsePoints.queryFeatures(query, showStats);
						//queryTask.execute(query, showStats);	
						console.log("exec");
						}
				
				 function showStats(results) {
					 var resultItems = [];
			          var resultCount = results.features.length;
			          console.log(results.features.length, "resultCount");
					var statsContent = "";
					statsContent+="<table  id= \"statsTable\" class=\"display\" cellspacing=\"0\" width=\"100%\"> <thead><tr><th>Parking place</th> <th> Last occupied</th><th> Average time occupied (min)</th><th> Times accessed</th><th>Available</th>  </tr></thead><tbody>"
				         
					for (var i = 0; i < resultCount; i++) 
					{
						statsContent+="<tr><td>"+results.features[i].attributes["LotID"]+"</td><td>"+results.features[i].attributes["DisabledParking"]+"</td><td>"+results.features[i].attributes["AccessType"]+"</td><td>"+results.features[i].attributes["AvailabilityRate"]+"</td>+<td>"+results.features[i].attributes["Available"]+"</td></tr>";
				    }
					statsContent+="</tbody></table>";
					
					console.log(statsContent, "statsContent");
				
					//dom.byId("example").innerHTML = content;
 					 document.getElementById("example").innerHTML = statsContent;

 					
			
				$('#example').dialog({
					autoOpen : false,
					show : {
						effect : "blind",
						duration : 1000
					},
					hide : {
						effect : "blind",
						duration : 1000
					},
					width : 600,
					height : 550,
					stack : true,
				});
				
				var d = (new Date()).toString().split(' ').splice(1,3).join(' ');
					
				 	$(document).ready(function() {
				 		var table = $('#statsTable').DataTable();
					} );
				 	   table= $("#example").dialog("open");
					
				 	  $('#example tbody').on('click', 'tr', function () {
				 		 var table = $('#statsTable').DataTable();
				 	        var data = table.row( this ).data();
				 	        alert( 'You clicked on statistics for parking spot: '+data[0]+' today, '+d+' ' );
				 	    } );
				 };  // end showStats
				
				
				 $( function() {
					    $( document ).tooltip();
					  } );
				 
				function initEditor(evt) {
					var templateLayers = arrayUtils.map(evt.layers, function(
							result) {
						return result.layer;
					});
					console.log("initeditor", evt);

					var templatePicker = new TemplatePicker({
						featureLayers : templateLayers,
						grouping : true,
						rows : "auto",
						columns : 3
					}, "templateDiv");

					templatePicker.startup();
					drawToolbar = new Draw(map);

					templatePicker.on("selection-change", function() {
						console.log("selection", templatePicker.getSelected());
						if (templatePicker.getSelected()) {

							selectedTemplate = templatePicker.getSelected();

						}
						//else drawToolbar.deactivate();
						switch (selectedTemplate.featureLayer.geometryType) {
						case "esriGeometryPoint":
							drawToolbar.activate(Draw.POINT);
							break;
						case "esriGeometryPolyline":
							drawToolbar.activate(Draw.POLYLINE);
							break;
						case "esriGeometryPolygon":
							drawToolbar.activate(Draw.POLYGON);
							break;
						}

					});

					drawToolbar.on("draw-complete",
									function(evt) {
										console.log(evt, "evt");
										console.log(selectedTemplate,
												"selectedtemplate");
										var newAttributes = lang
												.mixin(
														{

														},
														selectedTemplate.template.prototype.attributes);
										console.log(newAttributes);
										var newGraphic = new Graphic(
												evt.geometry, null,
												newAttributes);
										console.log(newGraphic);
										var content = "";
										//var graphicAttributes = evt.graphic.attributes;
										console.log("evt", responsePolygon);

										switch (evt.geometry.type) {
										case "point":

											for (i in responsePoints.fields) {
												if (i != 0)
													content += "<p>"
															+ responsePoints.fields[i].name
															+ "</p><input id='"+responsePoints.fields[i].name+"Input' value=''/>  ";

											}
											break;

										case "polygon":

											for (i in responsePolygon.fields) {
												if (i != 0)
													content += "<p>"
															+ responsePolygon.fields[i].name
															+ "</p><input id='"+responsePolygon.fields[i].name+"Input' value=''/>  ";

											}
											break;
										}

										//drawToolbar.finishDrawing();
										document.getElementById("dialog").innerHTML = content;
										console.log("dialog content");
										$('#dialog')
												.dialog(
														{
															autoOpen : false,
															height : 500,
															width : 800,
															resizable : false,
															modal : false,
															buttons : {

																"Save" : function() {

																	switch (evt.geometry.type) {
																	case "point":

																		newGraphic.attributes.LotID = document.getElementById("LotIDInput").value;
																		newGraphic.attributes.DisabledParking = document.getElementById("DisabledParkingInput").value;
																		newGraphic.attributes.AccessType = document.getElementById("AccessTypeInput").value;
																		newGraphic.attributes.Paid = document.getElementById("PaidInput").value;
																		newGraphic.attributes.Available = document.getElementById("AvailableInput").value;

																		newGraphic.attributes.AvailabilityRate = document.getElementById("AvailableInput").value;

																		responsePoints.applyEdits([ newGraphic ],null,	null,
																						function(e) {drawToolbar.deactivate();
																							$('#dialog').dialog("close");
																						});
																		break;
																	case "polygon":

																		newGraphic.attributes.Address = document.getElementById("AddressInput").value;
																		newGraphic.attributes.TotalCapacity = document.getElementById("TotalCapacityInput").value;
																		newGraphic.attributes.TotalDisabledParking = document.getElementById("TotalDisabledParkingInput").value;
																		newGraphic.attributes.OperationalDays = document.getElementById("OperationalDaysInput").value;
																		newGraphic.attributes.OperationalHours = document.getElementById("OperationalHoursInput").value;
																		newGraphic.attributes.Restrictions = document.getElementById("RestrictionsInput").value;
																		newGraphic.attributes.TimeLimit = document.getElementById("TimeLimitInput").value;
																		newGraphic.attributes.OwnedBy = document.getElementById("OwnedByInput").value;

																		responsePolygon.applyEdits([ newGraphic ],null,null,
																						function(e) {
																							drawToolbar.deactivate();
																							$('#dialog').dialog("close");
																						});
																		break;
																	} //end switch

																} //end save
															}
														// end button
														}); //enddialog

										$("#dialog").dialog("open");

										drawToolbar.deactivate();
									}); //end-drawend
					//		drawToolbar.deactivate(); 
				}
				; //end initEditor

				on(dom.byId("poligoane"), "change", updateVisibility);
				on(dom.byId("puncte"), "change", updateVisibility);

				function updateVisibility() {

					var inputs = dojo.query(".boxcheck");
					if (document.getElementById("poligoane").checked) {
						responsePolygon.setVisibility(true);
					} else if (document.getElementById("poligoane").checked == false) {
						responsePolygon.setVisibility(false);
					}
					var inputs = dojo.query(".boxcheck2");
					if (document.getElementById("puncte").checked) {
						responsePoints.setVisibility(true);
					} else if (document.getElementById("puncte").checked == false) {
						responsePoints.setVisibility(false);
					}
				}

				

			});
</script>
</head>
<body class="claro">
	<div id="main" data-dojo-type="dijit/layout/BorderContainer"
		data-dojo-props="design:'headline'"
		style="height: width:100%; height: 100%;">

		<div data-dojo-type="dijit/layout/ContentPane"data-dojo-props="region:'left'"
			style="width: 20%; height: 100%; overflow: hidden;">
			
			<a href="index.html" >
   
   <input type="image" title="Go to Homepage" src="pictures/ParkPoint-full-black.png"  width="60%" >	</a>	 
			 <p id="create"  title="Select an object and then click on the map to create it" ><b>Create</b> a new parking lot 
			 <br>or individual parking place:
			</p><div id="templateDiv"></div>
			
			
			<p>__________
		
			</p><form id="strat" action="" title="Unchecking a box will hide selected layer"><b>Legend |</b>  Set layer visibility <br>
			
				<input type="checkbox" class="boxcheck" id="poligoane" value="Parking lots"  checked>Parking lots<br>
				<input type="checkbox" class="boxcheck2" id="puncte" value="Parking Places"  checked>Parking Places 
			</form>
			
		<p>__________
			</p><p><b>Analyze</b> city wide statistics 
			<br>of occupancy rate:</p>
			
			<input type="button" title="Open daily statistics based on occupancy rate of the parking lots" id="statistics" value="Statistics" >
			<div id="example" ></div>
       
    </table>
		</div>
		<div id="map" data-dojo-type="dijit/layout/ContentPane" 
			data-dojo-props="region:'right'" style="width: 80%; height: 100%; overflow: hidden;">
		
			<p id="comboBox"></p>
			
			<div id="dialog" title="Details" ></div>
			<div id="dialogShow" title="Update parking spot"  ></div>
		    <div  id="divtabel3" style="display: none" >
 				 <div id="divtabel" style="position: absolute"></div>
				 <div id="dialogPolygon" title="Update parking lot">
					<div id="dialogPolygonInfo"></div>
					<div id="content" style="position: absolute;"></div>	 
			     </div>
			
			<div id="error1"  style="position: absolute;"></div>		
				<div id="dialog" title="Details"  style="background: white"></div>
	  		
			</div>		

		</div>				
	</div>
</div></body>
</html>