var isPrime = function(num){
	for(var i = 2; i < num; i++){
		if(num % i === 0)
			return false;
	}

	return true;
};

//Brute force function, doesn't work well with large input
var bruteForce = function(input){
	var possible = input - 1;

	while(possible > 1){
		if(input % possible === 0 && isPrime(possible))
			return possible;
		
		possible--;
	}

	return input;
};

var findMax = function(x, y){
	return (x > y) ? x : y;
};

//This function uses square root method, drastically reduce sample size
var sqrtSolution = function(input){
	var sqrt = Math.round(Math.sqrt(input));

	while(sqrt > 1){
	    if(input % sqrt === 0){
	        if(isPrime(sqrt) && isPrime(input/sqrt))
	            return findMax(sqrt, input/sqrt);
	        else if(isPrime(input/sqrt))
	            return input/sqrt;
	        else if(isPrime(sqrt))
	            return sqrt;
	    }
		
		sqrt--;
	}

	return input;
};

//This function uses recursion, much much faster
var recursionSolution = function(input, limit_input){
	var limit = limit_input;
	
	for(var i = 2; i < limit; i++){
		if(input % i === 0 && isPrime(input/i))
			return input/i;
		else if(input % i === 0)
			limit = recursionSolution(input/i, limit);
	}

	return limit;
};

var compareSolutions = function(range){
	var start, end, result;

	console.log("Find the Largest Prime Factor of " + range + "\n");

	if(range < 999999999){
		start = new Date().getTime();
		result = bruteForce(range);
		end = new Date().getTime();

		console.log("Calling Brute-force Solution: \n");
		console.log("\tLargest Prime: " + result + "\n");
		console.log("\tTime Used (ms): " + (end - start) + "\n");
	}

	start = new Date().getTime();
	result = sqrtSolution(range);
	end = new Date().getTime();

	console.log("Calling Square Solution: \n");
	console.log("\tLargest Prime: " + result + "\n");
	console.log("\tTime Used (ms): " + (end - start) + "\n");

	start = new Date().getTime();
	result = recursionSolution(range, range);
	end = new Date().getTime();

	console.log("Calling Recursion Solution: \n");
	console.log("\tLargest Prime: " + result + "\n");
	console.log("\tTime Used (ms): " + (end - start) + "\n");
};

var range = 6008514751;
compareSolutions(range); 