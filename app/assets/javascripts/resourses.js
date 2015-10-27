$(document).on("page:change", function() {
	$("#add_resourses").submit(function() {
		var request = "";

		if ( $("#1").is(":checked") )
			request += "1";
		if ( $("#2").is(":checked") )
			request += "2";
		if ( $("#3").is(":checked") )
			request += "3";
		if ( $("#4").is(":checked") )
			request += "4";
		if ( $("#5").is(":checked") )
			request += "5";
		if ( $("#6").is(":checked") )
			request += "6";
		if ( $("#7").is(":checked") )
			request += "7";
		if ( $("#8").is(":checked") )
			request += "8";

		$.ajax({
			type: 'POST',
			dataType: 'html',
			url: $(this).attr("action"),
			data: {
				request: request
			},
			success: function() {
				alert("Done");
			}
		});
	});
});