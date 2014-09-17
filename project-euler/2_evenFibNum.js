var bruteForce = function(range){
	var sum = 0;
	var fib = [1, 2, 3];
	var pointer = fib.length;

	while(fib[pointer - 1] <= range){
		fib.push(fib[pointer - 1] + fib[pointer - 2]);
		pointer++;
	}

	for(var i = 0; i < pointer - 1; i++){
		if(fib[i] % 2 === 0)
			sum += fib[i];
	}

	return sum;
};

var refinedSolution = function(range){
	var sum = 0;

	/*
	fib[0] = first fibonacci number
	fib[1] = second fibonacci number
	next_fib = fib[0] + fib[1]

	Then use shift the elements to the left and use only 3 memory spaces.
	next_fib ---> fib[1] ---> fib[0]

	Also, reduce the time by adding the new even calculated fib numbers
	*/
	var fib = [0, 1];
	var next_fib = 0;

	while(next_fib <= range){
		next_fib = fib[0] + fib[1];
		if(next_fib % 2 === 0 && next_fib <= range)
			sum += next_fib;

		fib[0] = fib[1];
		fib[1] = next_fib;
	}

	return sum;
};

var compareSolutions = function(range){
	var start, end, result;

	console.log("Sum of the Even Fibonacci Numbers below " + range + "\n");

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

var range = 4000000;
compareSolutions(range);