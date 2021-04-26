<?php
/*
Plugin Name: Authenticate Users Remotely
Author: Christopher Davis
Author URI: http://www.christopherguitar.net/
License: GPL2
*/

add_filter('xmlrpc_methods', 'wpse39662_add_login_method' );
/**
 * Filters the XMLRPC methods to allow just checking the login/pass of
 * a given users
 */
function wpse39662_add_login_method( $methods )
{
    $methods['wpse39662.login'] = 'wpse39662_check_login';
    return $methods;
}

function wpse39662_check_login( $args )
{
    $username = $args[0];
    $password = $args[1];
    
    $user = wp_authenticate( $username, $password );
    
    if( is_wp_error( $user ) )
    {
        return false;
    }
    return true;
}