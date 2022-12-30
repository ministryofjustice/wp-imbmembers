<?php

use Roots\Sage\Assets;

/**
 *  Restricts core Gutenberg Block in editor
 */
function imb_allowed_block_types( $allowed_blocks ) {

        $allowed_blocks = array(
            'core/paragraph',
            'core/heading',
            'core/list',
            'core/table',
            'core/image',
            'core/file',
            'core/video',
            'core/spacer',
            'core/columns',
            'core/embed',
            'core/html'
            //'core/freeform',
        );

        return  $allowed_blocks;
}

add_filter( 'allowed_block_types_all', 'imb_allowed_block_types' );

function imb_restrict_embed_blocks() {

        wp_enqueue_script(
            'restrict-embed-blocks',
            Assets\asset_path('/restrict-embed-blocks.js'),
            array('wp-blocks', 'wp-dom-ready', 'wp-edit-post'), null, true
        );
}
add_action( 'enqueue_block_editor_assets', 'imb_restrict_embed_blocks' );

