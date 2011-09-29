<link rel="stylesheet" href="css/styles.css" />
        <link rel="stylesheet" href="css/ui-lightness/jquery-ui-1.8.16.custom.css" />
        <script type="text/javascript" src="js/jquery-1.6.2.min.js"></script>
        <script type="text/javascript" src="js/jquery-ui-1.8.16.custom.min.js"></script>
        <script type="text/javascript" src="scripts/functions.js"></script>
<meta charset="utf-8">








	<style>
	#demo-frame > div.demo { padding: 10px !important; };
	</style>
	<script>
	$(function() {
		$( "#slider-range-max" ).slider({
			range: "max",
			min: 0,
			max: 10,
			value: 2,
			slide: function( event, ui ) {
				$( "#amount" ).val( ui.value );
                                console.log(ui.value);
			}
		});
		$( "#amount" ).val( $( "#slider-range-max" ).slider( "value" ) );
	});
	</script>



<div class="demo">

<p>
	<label for="amount">Minimum number of bedrooms:</label>
	<input type="text" id="amount" style="border:0; color:#f6931f; font-weight:bold;" />
</p>
<div id="slider-range-max"></div>

</div><!-- End demo -->



<div class="demo-description">
<p>Fix the maximum value of the range slider so that the user can only select a minimum.  Set the <code>range</code> option to "max."</p>
</div><!-- End demo-description -->