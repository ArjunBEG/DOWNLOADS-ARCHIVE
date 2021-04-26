<?php

//We can add a field as follows:

function add_comment_fields($fields) {
 
    $fields['age'] = '<p class="comment-form-age"><label for="age">' . __( 'Age' ) . '</label>' .
        '<input id="age" name="age" type="text" size="30" /></p>';
    return $fields;
 
}

add_filter('comment_form_default_fields','add_comment_fields');

//Once we add the field depending on the theme we might want to style it. As I am using the Twenty Eleven theme I style it by adding #respond .comment-form-age label with the other labels style like #respond .comment-form-url label etc. as follows:

/*
    #respond .comment-form-author label,
    #respond .comment-form-email label,
    #respond .comment-form-url label,
    #respond .comment-form-age label,
    #respond .comment-form-comment label {
    background: #eee;
    -webkit-box-shadow: 1px 2px 2px rgba(204,204,204,0.8);
    -moz-box-shadow: 1px 2px 2px rgba(204,204,204,0.8);
    box-shadow: 1px 2px 2px rgba(204,204,204,0.8);
    color: #555;
    display: inline-block;
    font-size: 13px;
    left: 4px;
    min-width: 60px;
    padding: 4px 10px;
    position: relative;
    top: 40px;
    z-index: 1;
}
*/


function add_comment_meta_values($comment_id) {
 
    if(isset($_POST['age'])) {
        $age = wp_filter_nohtml_kses($_POST['age']);
        add_comment_meta($comment_id, 'age', $age, false);
    }
 
}
add_action ('comment_post', 'add_comment_meta_values', 1);


echo 'Comment authors age: ' . get_comment_meta( $comment->comment_ID, 'age', true );


function add_comment_fields($fields) {
    if( is_singular( 'books' ) ) {
        $fields['age'] = '<p class="comment-form-age"><label for="age">' . __( 'Age' ) . '</label>' .
            '<input id="age" name="age" type="text" size="30" /></p>';
    }
    return $fields;
}

add_filter('comment_form_default_fields','add_comment_fields');

//In the Twenty Eleven theme in comments.php you will see a line:
wp_list_comments( array( 'callback' => 'twentyeleven_comment' ) );
//This we will change to:
wp_list_comments( array( 'callback' => 'my_comments_callback' ) );
//So the function my_comments_callback will be called for each post.


function my_comments_callback( $comment, $args, $depth ) {
    $GLOBALS['comment'] = $comment;
    ?>
    <li <?php comment_class(); ?> id="li-comment-<?php comment_ID(); ?>">
        <article id="comment-<?php comment_ID(); ?>" class="comment">

            <div class="comment-content"><?php comment_text(); ?></div>

            <p><?php echo "Comment authors age: ".get_comment_meta( $comment->comment_ID, 'age', true ); ?></p>

            <div class="reply">
                <?php comment_reply_link( array_merge( $args, array( 'reply_text' => __( 'Reply <span>&darr;</span>', 'twentyeleven' ), 'depth' => $depth, 'max_depth' => $args['max_depth'] ) ) ); ?>
            </div>
        </article>
    </li>
    <?php
}
//We also modify the background color as follows:
/*
.commentlist > li.comment {
    background: #99ccff;
    border: 3px solid #ddd;
    -moz-border-radius: 3px;
    border-radius: 3px;
    margin: 0 0 1.625em;
    padding: 1.625em;
    position: relative;
}
*/

function remove_comment_fields($fields) {
    unset($fields['url']);
    return $fields;
}

add_filter('comment_form_default_fields','remove_comment_fields');

