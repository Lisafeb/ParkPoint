
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no">
<title>Parking helper</title>
 <link rel="stylesheet" href="https://js.arcgis.com/3.18/esri/themes/calcite/dijit/calcite.css">
   <link rel="stylesheet" href="https://js.arcgis.com/3.18/esri/themes/calcite/esri/esri.css">
   
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
   <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css">

<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.2.2/css/buttons.dataTables.min.css">


    <script type="text/javascript"   src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>

<style>
html, body, .container, #map {
    height:100%;
    width:100%;
    margin:0;
    padding:0;
    margin:0;
    font-family: "Open Sans";
}
#map {
    padding:0;
}
#layerListPane{
    width:25%;
}
.esriLayer{
  background-color: #fff;
}
.esriLayerList .esriList{
    border-top:none;
}
.esriLayerList .esriTitle {
  background-color: #fff;
  border-bottom:none;
}
.esriLayerList .esriList ul{
  background-color: #fff;
}
 #logo {
      position: absolute;
      top: 0px;
      left: 85px;
      z-index: 50;
    }

         #divtabel{
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
#anunt{
      position: absolute;
      top: 480px;
      left: 10px;
      z-index: 50;
    }
  #HomeButton {
      position: absolute;
      top: 31px;
      left: 345px;
      z-index: 50;
    }
      #LocateButton {
      position: absolute;
      top: 63px;
      left: 345px;
      z-index: 50;
    }
      #strat {
      position: absolute;
      top: 150px;
      left: 55px;
      z-index: 50;
    }
    #imgParking{
     position: absolute;
      top: 157px;
      left: 10px;
      z-index: 50;
    }
    #imgParking2{
     position: absolute;
      top: 181px;
      left: 10px;
      z-index: 50;
    }
      #search {
        display: block;
         position: absolute;
         z-index: 100;
         top: 100px;
         left: 10px;
        
      }
    #razaBuffer{
      position: absolute;
      top: 230px;
      left: 10px;
      z-index: 50;
    }
    #raza{
    width:50px;
    }
   #dir{
    display: block;
         position: absolute;
         z-index: 100;
         top: 500px;
         left: 10px;
   }
 
     .arcgisSearch .searchGroup .searchInput {
   width:100px;
  }
  input[type=text], input[type=password] {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    box-sizing: border-box;
}

/* Set a style for all buttons */
button {
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    cursor: pointer;
    width: 100%;
}

/* Extra styles for the cancel button */
.cancelbtn {
    width: auto;
    padding: 10px 18px;
    background-color: #f44336;
}

/* Center the image and position the close button */
.imgcontainer {
    text-align: center;
    margin: 24px 0 12px 0;
    position: relative;
}

img.avatar {
    width: 40%;
    border-radius: 50%;
}

.container {
    padding: 16px;
}

span.psw {
    float: right;
    padding-top: 16px;
}

/* The Modal (background) */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    left: 0;
    top: 0;
    width: 100px; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    padding-top: 60px;
}

/* Modal Content/Box */
.modal-content {
    background-color: #fefefe;
    margin: 5% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
    border: 1px solid #888;
    width: 80%; /* Could be more or less, depending on screen size */
}

/* The Close Button (x) */
.close {
    position: absolute;
    right: 25px;
    top: 0;
    color: #000;
    font-size: 35px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: red;
    cursor: pointer;
}

/* Add Zoom Animation */
.animate {
    -webkit-animation: animatezoom 0.6s;
    animation: animatezoom 0.6s
}

@-webkit-keyframes animatezoom {
    from {-webkit-transform: scale(0)}
    to {-webkit-transform: scale(1)}
}
    
@keyframes animatezoom {
    from {transform: scale(0)}
    to {transform: scale(1)}
}

/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
    span.psw {
       display: block;
       float: none;
    }
    .cancelbtn {
       width: 100%;
    }
}
</style>
<script>var dojoConfig = { parseOnLoad: false };</script>
<script src="https://js.arcgis.com/3.18/"></script>
<script>
var map, visibleLayerIds = [];;
require([
        
  "esri/map",
  "esri/layers/ImageParameters",
  "esri/urlUtils",
  "esri/dijit/Directions",
  "esri/layers/FeatureLayer", 
  "esri/tasks/query", "esri/geometry/Circle",
  "esri/graphic", "esri/InfoTemplate", "esri/symbols/SimpleMarkerSymbol",
  "esri/symbols/SimpleLineSymbol", "esri/symbols/SimpleFillSymbol", "esri/renderers/SimpleRenderer",
  "esri/config", "esri/Color",
  "esri/dijit/HomeButton",
  "esri/dijit/Search",
  "esri/dijit/LocateButton",
  "esri/dijit/BasemapGallery", 
  "esri/dijit/OverviewMap",
    "esri/arcgis/utils",
    "esri/dijit/LayerList","dojo/query",
    "dojo/on","dojo/dom","dojo/parser",
    "dojo/domReady!",
    "dijit/layout/BorderContainer",
    "dijit/layout/ContentPane",
   
], function(Map,  ImageParameters, urlUtils, Directions, FeatureLayer,
        Query, Circle,
        Graphic, InfoTemplate, SimpleMarkerSymbol,
        SimpleLineSymbol, SimpleFillSymbol, SimpleRenderer,
        esriConfig, Color, HomeButton,Search,LocateButton,BasemapGallery,OverviewMap,
    arcgisUtils,
    LayerList, query,on, dom, parser
) {
	parser.parse();
	
	 urlUtils.addProxyRule({
	     urlPrefix: "route.arcgis.com",
	     proxyUrl: "/sproxy/"
	   });
	   urlUtils.addProxyRule({
	     urlPrefix: "traffic.arcgis.com",
	     proxyUrl: "/sproxy/"
	   });
	   
    //Create a map based on an ArcGIS Online web map id
 map = new Map("map", {
    	        basemap: "topo",  //For full list of pre-defined basemaps, navigate to http://arcg.is/1JVo6Wd
    	        extent: new esri.geometry.Extent({ "xmin": 2018841.3785149138, 
    			     "ymin": 5589649.810197768, "xmax": 3584271.7177949073, 
    			     "ymax": 6157118.308186765,"spatialReference":{"wkid":102100}}),
    	        zoom: 7
    	      });
    
 var imageParameters = new ImageParameters();
 imageParameters.layerIds = [2];
 imageParameters.layerOption = ImageParameters.LAYER_OPTION_SHOW;
 
 var featureLayer = new FeatureLayer("http://109.166.213.45:6080/arcgis/rest/services/Disertatie/DizertatieElisa/FeatureServer/0",{
		mode: FeatureLayer.MODE_ONDEMAND,
   outFields: ["*"]
});
 
 var responsePolygon = new FeatureLayer("http://109.166.213.45:6080/arcgis/rest/services/Disertatie/DizertatieElisa/FeatureServer/1",{
 	mode: FeatureLayer.MODE_ONDEMAND,
 	outFields: ['*']
 
 });
 map.addLayers([featureLayer, responsePolygon]);
 

 
   
   
 var symbol = new SimpleMarkerSymbol(
         SimpleMarkerSymbol.STYLE_CIRCLE, 
         12, 
         new SimpleLineSymbol(
           SimpleLineSymbol.STYLE_NULL, 
           new Color([247, 34, 101, 0.9]), 
           1
         ),
         new Color([207, 34, 171, 0.5])
       );
       featureLayer.setSelectionSymbol(symbol); 
       
       var circle="";  
 
 var circleSymb = new SimpleFillSymbol(
   SimpleFillSymbol.STYLE_NULL,
   new SimpleLineSymbol(
     SimpleLineSymbol.STYLE_SHORTDASHDOTDOT,
     new Color([105, 105, 105]),
     2
   ), new Color([255, 255, 0, 0.25])
 );
 
	  on(dom.byId("button"), "click", function()
			{
		        var x=document.getElementById("raza").value;
		        circle = new Circle({
	            center: evtGlobal.mapPoint,
	            geodesic: true,
	            radius: x,
	            radiusUnit: "esriMiles"
	        }); 
		        map.graphics.clear();
		          map.infoWindow.hide();
		          var graphic = new Graphic(circle, circleSymb);
		          map.graphics.add(graphic);

		          var query = new Query();
		          query.geometry = circle.getExtent();
		          //use a fast bounding box query. will only go to the server if bounding box is outside of the visible map
		          featureLayer.queryFeatures(query, selectInBuffer);
			}); 
		

 //when the map is clicked create a buffer around the click point of the specified distance.
 map.on("click", function(evt){
 	evtGlobal = evt;
		var x=document.getElementById("raza").value;
   	circle = new Circle({
     center: evt.mapPoint,
     geodesic: true,
     radius: x,
     radiusUnit: "esriMiles"
   });
   map.graphics.clear();
   map.infoWindow.hide();
   var graphic = new Graphic(circle, circleSymb);
   map.graphics.add(graphic);

   var query = new Query();
   query.geometry = circle.getExtent();
   //use a fast bounding box query. will only go to the server if bounding box is outside of the visible map
   featureLayer.queryFeatures(query, selectInBuffer);
   
  

   
 });

 function selectInBuffer(response){
 	console.log("response", response);
   var feature;
   var features = response.features;
   var inBuffer = [];
   //filter out features that are not actually in buffer, since we got all points in the buffer's bounding box
   for (var i = 0; i < features.length; i++) {
     feature = features[i];
     if(circle.contains(feature.geometry)){
       inBuffer.push(feature.attributes[featureLayer.objectIdField]);
     }
   }
   var query = new Query();
   query.objectIds = inBuffer;
   //use a fast objectIds selection query (should not need to go to the server)
   featureLayer.selectFeatures(query, FeatureLayer.SELECTION_NEW, function(results){
     var totalPlaces = sumPlaces(features);
     console.log("results", results);
     var r = "";
     r = "<b>The total number of parking places within the buffer is <i>" + totalPlaces + "</i>.</b>";
     dom.byId("messages").innerHTML = r;
   });
 }
 
 function sumPlaces(features) {
 	console.log("sum places", features.length);
   var placesTotal = 0;
   var content="";
   //var content= "<button id=\"close\" onclick=\"closeTabel()\">"; 
  
   content+="<table  id= \"tabel1\" class=\"display\" cellspacing=\"0\" width=\"100%\"> <thead><tr><th>Parking Places</th> <th>Address</th> </tr></thead><tbody>"
   console.log("placesTotal", placesTotal);
   for (var x = 0; x < features.length; x++) {
 	  console.log("adauga la suma");
 	 placesTotal = placesTotal + features[x].attributes["OBJECTID"];
     content+="<tr><td>"+features[x].attributes["Available"]+"</td><td>"+features[x].attributes["OBJECTID"]+"</td></tr>";
    // content=content+features[x].attributes["Anul_2014"]+features[x].attributes["Localitati"];
   }
   content+="</tbody></table>";
   console.log(content);
   document.getElementById("divtabel").innerHTML=content;
   document.getElementById('divtabel3').style.display = 'block';
/*         $('#tabel1').DataTable(
 		  {
 			  "scrollY": "200px",
 			  "scrollCollapse": true,
 			  "paging": false,
 			  "autoClose": true, 
 		  }); */
  
  $('#tabel1').DataTable();
//  $('#divtabel').dialog();	  
   
   return placesTotal;
 
   console.log("placesTotal after", placesTotal);
   
 }
 

 var search = new Search({
     map: map
  }, "search");
  search.startup();
  
  
 var home = new HomeButton({
     map: map
   }, "HomeButton");
   home.startup();
   
   var geoLocate = new LocateButton({
	   map: map,
	   highlightLocation: false
	   }, "LocateButton"
	 );
	 geoLocate.startup();
	 
	 //add the basemap gallery, in this case we'll display maps from ArcGIS.com including bing maps
     var basemapGallery = new BasemapGallery({
       showArcGISBasemaps: true,
       map: map
     }, "basemapGallery");
     basemapGallery.startup();
     
     basemapGallery.on("error", function(msg) {
       console.log("basemap gallery error:  ", msg);
     });

	   
			var modal = document.getElementById('id01');

			// When the user clicks anywhere outside of the modal, close it
			window.onclick = function(event) {
			    if (event.target == modal) {
			        modal.style.display = "none";
			    }
			}
			
			  on(dom.byId("poligoane"), "change", updateVisibility);
	          on(dom.byId("puncte"), "change", updateVisibility);
		
			
			function updateVisibility(){
				
				var inputs = query(".boxcheck");
				 if (document.getElementById("poligoane").checked) {
					 responsePolygon.setVisibility(true);
		              }
				 else if (document.getElementById("poligoane").checked == false){
					 responsePolygon.setVisibility(false);
				     }
				 var inputs = query(".boxcheck2");
				  if ( document.getElementById("puncte").checked ) {
					 featureLayer.setVisibility(true);
				 } 
				 else if (document.getElementById("puncte").checked == false){
					 featureLayer.setVisibility(false);
			     }
			}

});
</script>
</head>
<body class="calcite">
<div id="HomeButton"></div>
      <div id="LocateButton"></div>
      <div style="position:absolute; right:10px; top:42px; z-Index:999;">
     <div class="basemap"> 
        <div data-dojo-type="dijit/TitlePane" 
             data-dojo-props="title:'Switch Basemap', closable:false, open:false">
          <div data-dojo-type="dijit/layout/ContentPane"  style="width:380px; height:280px; overflow:auto;">
            <div id="basemapGallery"></div>
          </div>
        </div>
      </div> </div>
<div class="container" data-dojo-type="dijit/layout/BorderContainer" 
data-dojo-props="design:'headline',gutters:false">
<div id="layerListPane" data-dojo-type="dijit/layout/ContentPane" data-dojo-props="region:'left'"style="width:250px;">
    <div id="layerList"></div>
    
     
     
   <a href="index.html" >
   
   <input type="image" src="pictures/ParkPoint-full-black.png"  width="60%" >	</a>

       
    <img id="imgParking" src="http://tinyurl.com/jolm73r" alt="some_text" style="width:25px;height:height;">
    <img id="imgParking2" src="http://tinyurl.com/hnu76v9" alt="some_text" style="width:25px;height:height;">
          <form id="strat">Check the desired layer<br>
				<input type="checkbox" class="boxcheck" id="poligoane" value="ParkingLots"  checked>Parking lots<br>
				<input type="checkbox" class="boxcheck2" id="puncte" value="ParkingSpots"  checked>Parking spots 
			</form>  
  <div id="razaBuffer" >Radius (km):
  <input id="raza" type="number" min="1" value="5">
  <button class="button" id="button" style="width: 57px; height: 28px; ">Apply</button>
  </div>
  <div id="search"></div>
 
  

</div> 

<div id="map" data-dojo-type="dijit/layout/ContentPane" data-dojo-props="region:'center'"></div>
  <div id="mapDiv"></div>
    
    <div  id="divtabel3" style="display: none" >
  <div id="divtabel" style="position:absolute"></div>
   <button class="button" id="close" style="z-index: 100; width: 46px" onclick="document.getElementById('divtabel3').style.display = 'none';">X</button> 
   </div>
 
 
 
 
</div>
</body>
</html>
