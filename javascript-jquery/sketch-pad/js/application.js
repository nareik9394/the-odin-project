var generateGrid = function() {
	$('#gridSpace').empty();

	var iteration = prompt('How many squares per side?');
	var size = ($('#gridSpace').width()/iteration - 2) + "px";
	var gridSpace = $('#gridSpace');

	for(var i = 0; i < iteration; i++) {
		for(var j = 0; j < iteration; j++){
			gridSpace.append('<div class="smallGrid"></div>');
		}
		gridSpace.append('<div class="newRow"></div>');
	}

	//$('.smallGrid').css('width', size);
	//$('.smallGrid').css('height', size);
	$('.smallGrid').css({'width': size, 'height': size});
	$('.smallGrid').on('mouseenter', function() {
		$(this).addClass('active');
	});
};

$(document).ready(function() {
	generateGrid();

	$('#init').on('click', generateGrid);
});