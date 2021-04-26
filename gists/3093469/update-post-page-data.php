<?php

function wpa47153_run_once(){

    $posts = get_posts(array('numberposts' => -1) );

    foreach($posts as $p) :  

        $meta = get_post_meta($p->ID, 'meta_key',true);

        if($meta) :

            $my_post = array();
            $my_post['ID'] = $p->ID;
            $my_post['post_content'] = $meta . "<br/>"  . $p->post_content ;

            // Update the post into the database
            wp_update_post( $my_post );
        unset($my_post);

            //remove the meta key
            delete_post_meta($p->ID, 'meta_key');

        endif;

    endforeach; 


}