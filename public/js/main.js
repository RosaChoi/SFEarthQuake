var id = 'displayProbability',
    probStr = $('#' + id).data('probability'),
    prob = probStr.substring(0, probStr.length - 1),
    noEarthquakeProb =  100 - prob;

var morris = Morris.Donut({
  element: id,
  data: [
    {label: "No Earthquake", value: noEarthquakeProb },
    {label: "Proabability of Earthquake", value: prob }
  ],
  formatter: function(y, data) {
    return y + "%";
  }
});

morris.select(1);
