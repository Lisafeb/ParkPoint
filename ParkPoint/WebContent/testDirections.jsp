<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>Directions Widget</title>
    <link rel="stylesheet" href="https://js.arcgis.com/3.18/dijit/themes/claro/claro.css">
    <link rel="stylesheet" href="https://js.arcgis.com/3.18/esri/css/esri.css">
    <style>
      html, body, #map {
        height:100%;
        width:100%;
        margin:0;
        padding:0;
      }
      body {
        background-color:#FFF;
        overflow:hidden;
        font-family:"Trebuchet MS";
      }
    </style>

    <script src="https://js.arcgis.com/3.18/"></script>
    <script>
      require([
        "esri/urlUtils", "esri/map", "esri/IdentityManager", "esri/dijit/Directions",
        "dojo/parser",
        "dijit/layout/BorderContainer", "dijit/layout/ContentPane", "dojo/domReady!"
      ], function(
        urlUtils, Map,esriId, Directions,
        parser
      ) {
        parser.parse();
        //all requests to route.arcgis.com will proxy to the proxyUrl defined in this object.
         /* esriConfig.defaults.io.proxyUrl = "http://localhost:8080/ParkPoint/proxy.jsp"
		esriConfig.defaults.io.alwaysUseProxy = false; */
         
         urlUtils.addProxyRule({
          urlPrefix: "route.arcgis.com",
          proxyUrl: "http://localhost:8080/ParkPoint/proxy.jsp"
        }); 
         urlUtils.addProxyRule({
             urlPrefix: "traffic.arcgis.com",
             proxyUrl: "http://localhost:8080/ParkPoint/proxy.jsp"
           });
 
        var map = new Map("map", {
          basemap: "streets",
          center:[-98.56,39.82],
          zoom: 4
        });

        //default will point to ArcGIS world routing service
        var directions = new Directions({
          map: map,
          //routeTaskUrl:"http://route.arcgis.com/arcgis/rest/services/World/Route/NAServer/Route_World",
          geocoderOptions: {autoComplete:true, autoNavigate:false}
          // --------------------------------------------------------------------
          // New constuctor option and property showSaveButton added at version
          // 3.17 to allow saving route. For more information see the API Reference.
          // https://developers.arcgis.com/javascript/3/jsapi/directions-amd.html#showsavebutton
          //
          // Uncomment the line below to add the save button to the Directions widget
          // --------------------------------------------------------------------
          // , showSaveButton: true
        },"dir");
       
        directions.startup();
        
        
      });
    </script>
  </head>
  <body class="claro">
    <div data-dojo-type="dijit/layout/BorderContainer"
         data-dojo-props="design:'headline', gutters:false"
         style="width:100%;height:100%;">
      <div data-dojo-type="dijit/layout/ContentPane"
           data-dojo-props="region:'right'"
           style="width:250px;">

        <div id="dir"></div>
      </div>
      <div id="map"
           data-dojo-type="dijit/layout/ContentPane"
           data-dojo-props="region:'center'">
      </div>
    </div>
  </body>
</html>