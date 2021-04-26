<?php
/**
 * Plugin Name: Hook Debug Output
 * Plugin URI: http://unserkaiser.com
 * Description: Debug Hooked filter callback functions with adding <code>?debug=secret&hook=your_hook_name</code> to the URl
 * Version: 0.1
 * Author: Stephen Harris, Franz Josef Kaiser
 * Author URI: http://unserkaiser.com
 */
// Prevent loading this file directly - Busted!
if ( ! class_exists('WP') ) 
{
	header( 'Status: 403 Forbidden' );
	header( 'HTTP/1.1 403 Forbidden' );
	exit;
}



if ( ! class_exists( 'HookDebugOutput' ) )
{
	add_action( 'after_setup_theme', array( 'HookDebugOutput', 'init' ) );
/**
 * Debug Hooked filter callback functions
 * 
 * @author Stephen Harris, Franz Josef Kaiser
 * @since 0.1
 * @version 0.1
 * @package WordPress
 * @subpackage Hook Debug Output
 * @license MIT
 */
final class HookDebugOutput
{
	/**
	 * The Class Object
	 * @var
	 */
	static private $class = null;


	/**
	 * The Storage container
	 * @var array
	 */
	public $debug_filters_storage = array();


	/**
	 * Handler for the action 'init'. Instantiates this class.
	 * 
	 * @return void
	 */
	public static function init()
	{
		if ( null === self::$class ) 
			self :: $class = new self;

		return self :: $class;
	}


	/**
	 * Hook the functions
	 * 
	 * @return void
	 */
	public function __construct()
	{
		if ( 
			! current_user_can( 'manage_options' ) 
			OR empty( $_GET[ 'debug' ] ) 
			OR 'true' !== $_GET[ 'debug' ] 
			OR ! isset( $_GET[ 'hook' ] )
		)
			return;

		add_action( 'all', array( $this, 'store_fired_filters' ) );
		add_action( 'shutdown', array( $this, 'display_fired_filters' ) );
	}


	/**
	 * @return array $debug_filters_storage
	 */
	public function store_fired_filters( $tag )
	{
		if (
			empty( $_GET[ 'hook' ] )
			OR $tag !== $_GET[ 'hook' ]
		)
			return;

		global $wp_filter;

		if ( ! isset( $wp_filter[ $tag ] ) )
			return;

		$hooked = $wp_filter[ $tag ];

		ksort( $hooked );

		foreach ( $hooked as $priority => $function )
			$hooked[] = $function;

		return $this->debug_filters_storage[] = array(
			 'tag'    => $tag
			,'hooked' => $wp_filter[ $tag ]
		);
	}


	/**
	 * Display the fired filters
	 * 
	 * @return string $output
	 */
	public function display_fired_filters()
	{
		foreach ( $this->debug_filters_storage as $index => $the_ )
		{
			ksort( $the_['hooked'] );

			$index   = str_pad( (int) $index, 2, "0", STR_PAD_LEFT );
			$output  = "<h1>{$index} &rarr; {$the_['tag']}</h1>";
			$output .= '<ul style="list-style-type: none;">';
			foreach ( $the_['hooked'] as $priority => $hooked )
			{
				foreach ( $hooked as $id => $function )
				{
					// leading 0 for numbers below 10
					$priority = str_pad( (int) $priority, 2, "0", STR_PAD_LEFT );
					$name     = sprintf( 
						 '<%1$s><%2$s> %3$s </%2$s></%1$s>'
						,'pre'
						,'code'
						,print_r( $function['function'], true )
					);
					$args     = "<sup>(accepted args: {$function['accepted_args']})</sup>";

					$output  .= "<li>{$priority} <strong>{$name}</strong> {$args}<hr /></li>";
				}
			}
			$output .= '</ul>';
		}

		return print $output;
	}
} // END Class HookDebugOutput

} // endif;