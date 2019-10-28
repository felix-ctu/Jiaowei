$(function () {
    function decimal(num, v) {
        var vv = Math.pow(10, v);
        return Math.round(num * vv) / vv;
    }

    NProgress.start();
    $.ajax({
        type: "GET",
        url: busStopApi,
        crossDomain: true,
        dataType: "json",
        success: function (data) {
            if (data.StatusCode === 200) {

                NProgress.done();
                busStations = data.Stations;
            }
        }
    });

    var map,
        toolbar,
        overView,
        ruler,
        mouseTool,
        customArea,
        busStations;

    var cluster,
        markers = [],
        routePolylines = [];
    rulerElements = [],
    rulerMarkers = [];

    var cvt = new GPSConvert();

    map = new AMap.Map('container', mapConfig);
    var canvas = document.createElement('canvas');

    map.setFeatures(["bg", "road", "building"])

    AMap.plugin([
        'AMap.ToolBar', 'AMap.OverView', 'AMap.MouseTool', 'AMap.RangingTool'
    ], function () {
        toolbar = new AMap.ToolBar();
        map.addControl(toolbar);

        overView = new AMap.OverView({visible: false});
        map.addControl(overView);

        overView.show();
        overView.open();
        ruler = new AMap.RangingTool(map);
        AMap
            .event
            .addListener(ruler, "end", function (e) {
                rulerElements.push(e.polyline);
                ruler.turnOff();
            });

        AMap
            .event
            .addListener(ruler, "addnode", function (e) {
                console.log(e.marker);
                rulerMarkers.push(e.marker);
            });
    });

    function drawBusStop(busStops) {
        for (var i = 0; i < busStops.length; i++) {
            var position = busStops[i].LngLat;
            var marker = new AMap.Marker({
                position: position,
                icon: new AMap.Icon({
                    image: "./images/busstop.png",
                    size: new AMap.Size(32, 32),
                    imageSize: new AMap.Size(32, 32)
                }),
                cursor: 'pointer',
                extData: {
                    busStopName: busStops[i].StationName,
                    busStopNumber: busStops[i].StationNo
                },
                label: {
                    //  content:busStops[i].name,
                    offset: {
                        x: 32,
                        y: 5
                    }
                }
            });
            marker.on('click', function () {
                // console.log('站点：' + busStops[i].name + "，GIS坐标:" + position + ", AMAP坐标：" +
                // markerPosition);
            });

            markers.push(marker);
        }

        addCluster();

        // 添加点聚合
        function addCluster() {
            if (cluster) {
                cluster.setMap(null);
            }

            map
                .plugin(["AMap.MarkerClusterer"], function () {
                    cluster = new AMap.MarkerClusterer(map, markers, {
                        gridSize: 60,
                        minClusterSize: 1
                    });
                });
        }

        AMap
            .event
            .addListener(map, 'zoomend', function () {
                //  console.log(map.getZoom());
                if (map.getZoom() > 15) {
                    cluster.setMinClusterSize(10);
                } else {
                    cluster.setMinClusterSize(1);
                }

                if (map.getZoom() === 18) {
                    markers
                        .forEach(function (marker) {
                            var label = marker.getExtData();
                            marker.setLabel({content: label.busStopName});
                            marker.on("mouseover", function () {
                                marker.setLabel({content: label.busStopName})
                            });

                            marker.on("mouseout", function () {
                                marker.setLabel({content: label.busStopName})
                            });
                        }, this);
                }

                if (map.getZoom() < 18 && map.getZoom() > 15) {
                    markers
                        .forEach(function (marker) {
                            marker.setLabel({content: ""});
                            var label = marker.getExtData();
                            marker.on("mouseover", function () {
                                marker.setLabel({content: label.busStopName})
                            });

                            marker.on("mouseout", function () {
                                marker.setLabel({content: ""})
                            });
                        }, this);
                }
            });
    }

    // event start
    $(".zoom-in")
        .click(function () {
            map.zoomIn();
        });

    $(".zoom-out").click(function () {
        map.zoomOut();
    });

    $(".eagle-eye").click(function () {
        var selected = $(this).hasClass("active");
        if (!selected) {
            $(this).addClass("active");
            overView.show();
            overView.open();
        } else {
            $(this).removeClass("active");
            overView.hide();
            overView.close();
        }
    });

    $(".stations .hide-layer").click(function () {
        markers = [];
        cluster.clearMarkers();
    });

    $(".stations .bus-stop").click(function () {
        if (busStations) {
            if (cluster) {
                markers = [];
                cluster.clearMarkers();
            }
            drawBusStop(busStations);
        } else {
            NProgress.start();
            $.ajax({
                type: "GET",
                url: busStopApi,
                crossDomain: true,
                dataType: "json",
                success: function (data) {
                    NProgress.done();
                    if (data.StatusCode === 200) {
                        busStations = data.Stations;
                        drawBusStop(data.Stations);
                    } else {
                        toastr.error(data.Message);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    /*错误信息处理*/
                }
            });
        }

    });

    $(".measure .reset").click(function () {
        if (customArea) {
            map.remove([customArea]);
            customArea = null;
            $("ul.area-info").remove();
        }
    });

    $(".measure .ranging").click(function () {
        ruler.turnOn();
    });

    $(".stations .bus-stop-area").click(function () {
        if (customArea) {
            map.remove([customArea]);
            customArea = null;
            $("ul.area-info").remove();
        }
        if (mouseTool) {
            mouseTool.close();
        }
        mouseTool = new AMap.MouseTool(map);
        AMap
            .event
            .addListener(mouseTool, "draw", function callback(e) {
                var polygon = e.obj;
                customArea = e.obj;

                if (busStations) {
                    var stationsInRange = [];
                    for (var i = 0; i < busStations.length; i++) {
                        var station = busStations[i];
                        if (polygon.contains(station.LngLat)) {
                            stationsInRange.push(station);
                        }
                    }
                    if (cluster) {
                        markers = [];
                        cluster.clearMarkers();
                    }
                    drawBusStop(stationsInRange);
                    map.remove([customArea]);
                    customArea = null;
                }
                mouseTool.close();
            });
        mouseTool.rectangle();
    });

    $(".measure .area").click(function () {
        if (customArea) {
            map.remove([customArea]);
            customArea = null;
            $("ul.area-info").remove();
        }
        if (mouseTool) {
            mouseTool.close();
        }
        mouseTool = new AMap.MouseTool(map);
        AMap
            .event
            .addListener(mouseTool, "draw", function callback(e) {
                customArea = e.obj;
                var path = customArea.getPath();
                var lnglat = new AMap.LngLat(3, 39.923423);
                var w = decimal(path[1].distance(path[0]) / 1000, 2);
                var h = decimal(path[1].distance(path[2]) / 1000, 2);
                // console.log("长", w + "公里"); console.log("宽", h + "公里"); console.log("周长",
                // decimal((w + h) * 2, 2) + "公里"); console.log("面积", decimal(w * h, 2) +
                // "平方公里"); customArea.on('click', function () {     alert('您点击了鼠标'); });

                var $ul = $("<ul>")
                    .attr("class", "area-info")
                    .appendTo($("body"));
                $("<li>")
                    .html("<label>长:</label><span>" + w + "</span> 公里")
                    .appendTo($ul);
                $("<li>")
                    .html("<label>宽:</label><span>" + h + "</span> 公里")
                    .appendTo($ul);
                $("<li>").html("<label>周长:</label><span>" + decimal((w + h) * 2, 2) + "</span> 公里").appendTo($ul);
                $("<li>").html("<label>面积:</label><span>" + decimal(w * h, 2) + "</span> 平方公里").appendTo($ul);
                mouseTool.close();
            });
        mouseTool.rectangle();
    });

    $(".route .reset").click(function () {
        map.remove(routePolylines);
        routePolylines = [];
        $("ul.area-info").remove();
    });

    $("#btnSearch").click(function () {
        var key = $("#txtRouteId")
            .val()
            .trim();
        var routeIds = key.split(',');
        $.each(routeIds, function (index, routeId) {
            if ($("ul.area-info").length === 0) {
                $("<ul>")
                    .attr("class", "area-info")
                    .appendTo($("body"));
            }
            if ($("ul.area-info").find("li[data-routeId=" + routeId + "]").length > 0) 
                return;
            showRoute(routeId.trim());
        })
    });

    function showRoute(routeId) {
        NProgress.start();
        $.ajax({
            type: "POST",
            data: "RouteId=" + routeId,
            url: routeLineApi,
            crossDomain: true,
            dataType: "json",
            // contentType: "application/json",
            success: function (data) {
                if (data.StatusCode === 200) {
                    NProgress.done();
                    if (data.Routes.length > 0) {
                        var polyline = new AMap.Polyline({
                            path: data.Routes[0].Points, //设置线覆盖物路径
                            strokeColor: "#3366FF", //线颜色           strokeOpacity: 1, //线透明度
                            strokeWeight: 3, //线宽            strokeStyle: "solid", //线样式
                            strokeDasharray: [
                                10, 5
                            ], //补充线样式
                            extData: data.Routes[0].SegmentId
                        });

                        var $ul = $("ul.area-info");
                        $("<li>")
                            .attr("data-routeId", routeId)
                            .html("<label>" + routeId + "路:</label><span>" + (polyline.getLength() / 1000).toFixed(2) + "</span> 公里")
                            .appendTo($ul);
                        polyline.setMap(map);
                        routePolylines.push(polyline);
                    }
                } else {
                    toastr.error(data.Message);
                }
            }
        });
    }
});