<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	svg > g > g > g > g > g{
		display:none
	}

</style>

</head>
<body>
	<div id="chartdiv1" style="width:100%; height:300px;"></div>
	
	<div id="chartdiv" style="width:100%; height:300px;"></div>

</body>
<script src="//www.amcharts.com/lib/4/core.js"></script>
<script src="//www.amcharts.com/lib/4/charts.js"></script>
<script src="//www.amcharts.com/lib/4/themes/animated.js"></script>

<script>
/**
 * ---------------------------------------
 * This demo was created using amCharts 4.
 *
 * For more information visit:
 * https://www.amcharts.com/
 *
 * Documentation is available at:
 * https://www.amcharts.com/docs/v4/
 * ---------------------------------------
 */

// Create chart instance
var chart = am4core.create("chartdiv1", am4charts.XYChart);

// Add data
chart.data = [{
  "category": "Research & Development",
  "value": 90
}, {
  "category": "Marketing",
  "value": 102
}, {
  "category": "Distribution",
  "value": 1500
}];

// Create axes
var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "category";

var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
//valueAxis.logarithmic = true;
valueAxis.min = 50;
valueAxis.max = 1200;
valueAxis.renderer.minGridDistance = 20;
valueAxis.strictMinMax = true;



// Create series
var series = chart.series.push(new am4charts.ColumnSeries());
series.dataFields.valueY = "value";
series.dataFields.categoryX = "category";
series.name = "Sales";

















//div1

am4core.useTheme(am4themes_animated);

// Create chart instance
var chart = am4core.create("chartdiv", am4charts.XYChart);

// Add data
chart.data = [{
  "date": new Date(2018, 0, 1),
  "value": 450,
  "value2": 362,
  "value3": 699
}, {
  "date": new Date(2018, 0, 2),
  "value": 269,
  "value2": 450,
  "value3": 841
}, {
  "date": new Date(2018, 0, 3),
  "value": 700,
  "value2": 358,
  "value3": 699
}, {
  "date": new Date(2018, 0, 4),
  "value": 490,
  "value2": 367,
  "value3": 500
}, {
  "date": new Date(2018, 0, 5),
  "value": 500,
  "value2": 485,
  "value3": 369
}, {
  "date": new Date(2018, 0, 6),
  "value": 550,
  "value2": 354,
  "value3": 250
}, {
  "date": new Date(2018, 0, 7),
  "value": 420,
  "value2": 350,
  "value3": 600
}];

// Create axes
var categoryAxis = chart.xAxes.push(new am4charts.DateAxis());
categoryAxis.renderer.grid.template.location = 0;
//categoryAxis.renderer.minGridDistance = 30;

var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());

// Create series
function createSeries(field, name) {
  var series = chart.series.push(new am4charts.LineSeries());
  series.dataFields.valueY = field;
  series.dataFields.dateX = "date";
  series.name = name;
  series.tooltipText = "{dateX}: [b]{valueY}[/]";
  series.strokeWidth = 2;
  
var bullet = series.bullets.push(new am4charts.CircleBullet());
bullet.events.on("hit", function(ev) {
  alert("Clicked on " + ev.target.dataItem.dateX + ": " + ev.target.dataItem.valueY);
});
}

createSeries("value", "Series #1");
createSeries("value2", "Series #2");
createSeries("value3", "Series #3");

chart.legend = new am4charts.Legend();
chart.cursor = new am4charts.XYCursor();
</script>

</html>