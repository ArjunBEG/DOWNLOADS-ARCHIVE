class Widget_Setup
{
    public $widget_class  = '';
    public $admin_styles  = array();
    public $admin_scripts = array();
    public $front_styles  = array();
    public $front_scripts = array();

    public $script_defaults = array(
        'handle'    => '',
        'src'       => '',
        'deps'      => array(),
        'version'   => false,
        'in_footer' => false
    );

    public $style_defaults = array(
        'handle'   => '',
        'src'      => '',
        'deps'     => array(),
        'version'  => false,
        'media'    => 'all'
    );

    public function __construct( $widget_class = '', $admin_styles = array(), $admin_scripts = array(), $front_styles = array(), $front_scripts = array() ) {

        $this->widget_class  = $widget_class;
        $this->admin_styles  = $admin_styles;
        $this->admin_scripts = $admin_scripts;
        $this->front_styles  = $front_styles;
        $this->front_scripts = $front_scripts;

        add_action( 'admin_print_styles',    array( $this, 'add_styles' ) );
        add_action( 'admin_enqueue_scripts', array( $this, 'add_scripts' ) );
        add_action( 'wp_enqueue_scripts',    array( $this, 'add_styles' ) );
        add_action( 'wp_enqueue_scripts',    array( $this, 'add_scripts' ) );

        if( ! empty( $this->widget_class ) )
            add_action( 'widgets_init', array( $this, 'register_widget' ) );

    }

    public function register_widget() {

        register_widget( $this->widget_class );

        return true;

    }

    public function add_styles() {

        $styles = ( is_admin() ) ?
            $this->admin_styles : $this->front_styles;

        if( empty( $styles ) )
            return false;

        foreach( $styles as $style ) {

            $style = wp_parse_args( $style, $this->style_defaults );

            wp_enqueue_style(
                $style['handle'],
                $style['src'],
                $style['deps'],
                $style['version'],
                $style['media']
            );

        }

        return true;
    }

    public function add_scripts() {

        $scripts = ( is_admin() ) ?
            $this->admin_scripts : $this->front_scripts;

        if( empty( $scripts ) )
            return false;

        foreach( $scripts as $script ) {

            $script = wp_parse_args( $script, $this->script_defaults );

            wp_enqueue_script(
                $script['handle'],
                $script['src'],
                $script['deps'],
                $script['version'],
                $script['media']
            );

        }

        return true;
    }

}