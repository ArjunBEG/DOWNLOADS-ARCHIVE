<?php
/**
 * Format a basic job listing in HTML5
 */
function indeed_job_results( $api_results = NULL, $search = NULL ) {
	if( !$api_results ) return false;
 
	$total = count($api_results);
	$search = ( $search ) ? " found for &ldquo;<strong>$search</strong>&rdquo;" : "";
 
	$html = "<section class='jobs'>";
	$html .= "<header>";
	$html .= "<h2>$total jobs$search</h2>";
	$html .= "</header>";
	foreach ( $api_results as $job ) {
		$date = explode(' ', $job->date);
		$formattedDate = $date[2] . ' ' . $date[1] . ', ' . $date[3];
 
		$html .= "<article>";
		$html .= "<h3><a href='{$job->url}' target='_blank'>{$job->jobtitle}</a></h3>";
		$html .= "<p class='details'>{$job->formattedLocation} <em>&ndash;</em> $formattedDate</p>";
		$html .= "</article>";
	}
	$html .= "</section><!--// end .jobs -->";
 
	return $html;
}


//Using the function in practice is simple:

$api_results = json_cached_api_results();
$jobs_output = indeed_job_results( $api_results, 'Google' );
