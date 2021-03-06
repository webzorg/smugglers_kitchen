function init_canvasjs() {
  var dataPoints = [];
  $.getJSON("home/index.json", function(data) {

    $.each(data, function(k, v){
  		dataPoints.push({ y: v.debt, label: v.name });
  	});
    var chart = new CanvasJS.Chart("contractors_by_debt", {

      title:{
        // text: "Contractors by Debt"
      },
      animationEnabled: true,
      axisX:{
        interval: 1,
        gridThickness: 0,
        labelFontSize: 14,
        labelFontStyle: "normal",
        labelFontWeight: "normal",
        labelFontFamily: "Sans Serif"

      },
      axisY2:{
        interlacedColor: "rgba(80,80,80,.2)",
        gridColor: "rgba(0,0,0,.1)"

      },
      data: [{
        type: "bar",
        name: "contractors",
        axisYType: "secondary",
        color: "#337ab7",
        dataPoints: dataPoints
      }]
    });

    chart.render();
  });
}
