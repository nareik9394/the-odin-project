var bruteForce = function(range){
	var sum = 0;

	for(var i = 0; i < range; i++){
		if(i % 3 === 0 || i % 5 === 0)
			sum += i;
	}

	return sum;
};

var refinedSolution = function(range){
	var shorten_range = range/3;
	var sum = 0;
	var mult_of_three = 0, mult_of_five = 0;

	for(var i = 1; i < shorten_range; i++){
		mult_of_three = i * 3;
		mult_of_five = i * 5;

		if(mult_of_five < range && mult_of_five % 3 !== 0)
			sum += mult_of_five;
        sum += mult_of_three;
	}

	return sum;
};

var compareSolutions = function(range){
	var start, end, result;

	console.log("Sum of the multiple of 3 and 5 below " + range + "\n");

	start = new Date().getTime();
	result = bruteForce(range);
	end = new Date().getTime();

	console.log("Calling Brute-force Solution: \n");
	console.log("\tSum: " + result + "\n");
	console.log("\tTime Used (ms): " + (end - start) + "\n");

	start = new Date().getTime();
	result = refinedSolution(range);
	end = new Date().getTime();

	console.log("Calling Refined Solution: \n");
	console.log("\tSum: " + result + "\n");
	console.log("\tTime Used (ms): " + (end - start) + "\n");
};

var range = 1000;
compareSolutions(range);