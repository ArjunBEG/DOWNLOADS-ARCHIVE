<?php

include_once(ABSPATH . WPINC . '/feed.php');

if(function_exists('fetch_feed')) {
    $feed = fetch_feed('http://example.com/feed/');
    if (!is_wp_error($feed)) : $feed->init();
        $feed->set_output_encoding('UTF-8');    // set encoding
        $feed->handle_content_type();       // ensure encoding
        $feed->set_cache_duration(21600);   // six hours in seconds
        $limit = $feed->get_item_quantity(10);  // get 10 feed items
        $items = $feed->get_items(0, $limit);   // set array
    endif;
}

if ($limit == 0) { 
    echo '<p>RSS Feed currently unavailable.</p>'; 
} else {
    // display first five feed items
    $blocks = array_slice($items, 0, 5);
    foreach ($blocks as $block) { ?>
        <div class="feed-item column-one">
            <h1><a href="<?php echo $block->get_permalink(); ?>"><?php echo $block->get_title(); ?></a></h1>
            <p>
                <?php echo $block->get_date("l, F jS, Y"); ?>
                <?php echo substr($block->get_description(), 0, 200); ?> 
                <a href="<?php echo $block->get_permalink(); ?>">Continue reading</a>
            </p>
        </div>
    <?php } ?>

    // display next five feed items
    $blocks = array_slice($items, 5, 10);
    foreach ($blocks as $block) { ?>
        <div class="feed-item column-two">
            <h1><a href="<?php echo $block->get_permalink(); ?>"><?php echo $block->get_title(); ?></a></h1>
            <p>
                <?php echo $block->get_date("l, F jS, Y"); ?>
                <?php echo substr($block->get_description(), 0, 200); ?> 
                <a href="<?php echo $block->get_permalink(); ?>">Continue reading</a>
            </p>
        </div>
    <?php }
} ?>
