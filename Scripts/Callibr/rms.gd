<script>   
   // Function that Calculate Root

	// Mean Square

	function rmsValue(arr , n) {

		var square = 0;
		var mean = 0;
		var root = 0; 

		// Calculate square.
		for (i = 0; i < n; i++) {
			square += Math.pow(arr[i], 2);
		}
 
		// Calculate Mean.
		mean = (square /  (n)); 

		// Calculate Root.
		root =  Math.sqrt(mean);

		return root;
	}
 
		var arr = [ 10, 4, 6, 8 ];
		var n = arr.length;
 
		document.write(rmsValue(arr, n).toFixed(5)); 
</script>
