var mapConfig = {
    center: [
        104.065907, 30.659019
    ],
    zoom: 11
};

// GET/POST {"StationName":"a"}
var busStopApi = "http://localhost:33190/api/stations";
// GET/POST {"RouteId":"1"}
var routeApi = "http://localhost:33190/api/Routes/1";
// POST {"RouteId":"1"}
var routeLineApi = "http://localhost:33190/api/RouteLines";