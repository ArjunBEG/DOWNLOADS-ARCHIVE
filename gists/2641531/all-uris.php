<?php # -*- coding: utf-8 -*-
declare ( encoding = 'UTF-8' );
/**
 * Plugin Name: T5 All URIs
 * Description: Creates a plaintext list of all URIs on your blog.
 * Version:     2012.03.08
 * Required:    3.3
 * Author:      Thomas Scholz <info@toscho.de>
 * Author URI:  http://toscho.de
 * License:     MIT
 * License URI: http://www.opensource.org/licenses/mit-license.php
 *
 * Copyright (c) 2012 Thomas Scholz
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

// Not a WordPress context? Stop.
! defined( 'ABSPATH' ) and exit;

// Wait until all needed functions are loaded.
add_action( 'init', array ( 'T5_All_Uris', 'init' ) );
add_action( 'init', array ( 'T5_All_Uris', 'set_rewrite_rule' ) );

register_activation_hook( __FILE__, array ( 'T5_All_Uris', 'set_rewrite_rule' ) );

class T5_All_Uris
{
	/**
	 * Internal handler for WordPress
	 *
	 * @type string
	 */
	protected static $query_var = 'alluris';

	/**
	 * Creates a new instance.
	 *
	 * @wp-hook init
	 * @see    __construct()
	 * @return void
	 */
	public static function init()
	{
		new self;
	}

	/**
	 * Set actions, filters and basic variables, load language.
	 */
	public function __construct()
	{
		add_filter( 'query_vars', array ( $this, 'add_query_var' ) );
		// Hook in late to allow other plugins to operate earlier.
		add_action( 'template_redirect', array ( $this, 'render' ), 100 );

		$this->base_name = plugin_basename( __FILE__ );
		add_filter( 'plugin_row_meta', array( $this, 'add_plugin_row_link' ), 10, 2 );
	}

	/**
	 * Adds a link to the settings to plugin list.
	 *
	 * @wp-hook plugin_row_meta
	 * @param  array  $links Already existing links.
	 * @return string
	 */
	public function add_plugin_row_link( $links, $file )
	{
		if ( $this->base_name != $file )
		{
			return $links;
		}
		$url  = user_trailingslashit( home_url( '/' . self::$query_var ) );
		return array_merge( $links, array ( "<a href='$url'>View output</a>" ) );
	}

	/**
	 * Register an URI.
	 *
	 * @wp-hook activation, init
	 * @return  void
	 */
	public static function set_rewrite_rule()
	{
		add_rewrite_rule(
			'^' . self::$query_var . '$',
			'index.php?' . self::$query_var . '=1',
			'top'
		);
		'init' != current_filter() and flush_rewrite_rules();
	}

	/**
	 * Register our query var.
	 *
	 * @wp-hook query_vars
	 * @param array $vars Existing query vars
	 * @return array
	 */
	public function add_query_var( $vars )
	{
		$vars[] = self::$query_var;
		return $vars;
	}

	/**
	 * Print all URIs as plain text.
	 *
	 * @wp-hook template_redirect
	 * @return void
	 */
	public function render()
	{
		if ( ! get_query_var( self::$query_var ) )
		{
			return;
		}

		header('Content-Type: text/plain;charset=utf-8');
		$this->print_post_uris();
		$this->print_term_uris();

		exit;
	}

	/**
	 * All permalinks.
	 *
	 * @return void
	 */
	protected function print_post_uris()
	{
		$posts = $this->get_all_post_objects();
		if ( empty ( $posts ) )
		{
			return;
		}

		$out = array ();
		foreach ( $posts as $post )
		{
			$out[] = get_permalink( $post->ID );
		}

		! empty ( $out ) and print join( "\n", $out );
	}

	/**
	 * Two calls to get all post objects.
	 *
	 * @return array
	 */
	protected function get_all_post_objects()
	{
		$posts = get_posts(
			array (
				'numberposts' => -1,
				'post_type' => 'any'
			)
		);
		! is_array ( $posts ) and $posts = array ();

		// Hm, these should be queryable by the previous call. Didn’t work.
		$attachments = get_posts(
			array (
				'numberposts' => -1,
				'post_type' => 'attachment'
			)
		);
		! is_array ( $attachments ) and $posts = array ();

		$out = array_merge( $posts, $attachments );

		return $out;
	}

	/**
	 * Print permalinks for all terms.
	 *
	 * @return void
	 */
	protected function print_term_uris()
	{
		$terms = get_terms(
			get_taxonomies(),
			array (
				'hide_empty' => FALSE,
				'get' => 'all'
			)
		);

		if ( ! is_array( $terms ) )
		{
			return;
		}

		foreach ( $terms as $term )
		{
			print "\n" . get_term_link( $term );
		}
	}
}