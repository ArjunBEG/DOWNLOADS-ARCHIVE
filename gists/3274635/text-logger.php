/* eZLog class very slightly modified from eZ Publish 4.3 */
class eZLog {
    const MAX_LOGROTATE_FILES = 3;
    const MAX_LOGFILE_SIZE = 204800; // 200*1024
    /*!
      Creates a new log object.
    */
    function eZLog( )
    {
    }
    /*!
     \static
     \public
     Writes a message $message to a given file name $name and directory $dir for logging
    */
    static function write( $message, $logName = 'common.log', $dir = 'var/log' )
    {
        $fileName = $dir . '/' . $logName;
        $oldumask = @umask( 0 );
        $fileExisted = @file_exists( $fileName );
        if ( $fileExisted && filesize( $fileName ) > eZLog::maxLogSize() )
        {
            if ( eZLog::rotateLog( $fileName ) )
                $fileExisted = false;
        }
        $logFile = @fopen( $fileName, "a" );
        if ( $logFile )
        {
            $time = strftime( "%b %d %Y %H:%M:%S", strtotime( "now" ) + get_option( 'gmt_offset' ) * 3600 );
            $logMessage = "[ " . $time . " ] $message\n";
            @fwrite( $logFile, $logMessage );
            @fclose( $logFile );
            if ( !$fileExisted )
            {
                $permissions = octdec( '0666' );
                @chmod( $fileName, $permissions );
            }
            @umask( $oldumask );
        }
        else
        {
            error_log( 'Couldn\'t create the log file "' . $fileName . '"' );
        }
    }
    /*!
     \static
     \return the maximum size for a log file in bytes.
    */
    static function maxLogSize()
    {
        $maxLogSize =& $GLOBALS['eZMaxLogSize'];
        if ( isset( $maxLogSize ) )
            return $maxLogSize;
        return self::MAX_LOGFILE_SIZE;
    }
    /*!
     \static
     Sets the maximum size for a log file to \a $size.
    */
    static function setMaxLogSize( $size )
    {
        $GLOBALS['eZMaxLogSize'] = $size;
    }
    /*!
     \static
     \return the maximum number of logrotate files to keep.
    */
    static function maxLogrotateFiles()
    {
        $maxLogrotateFiles =& $GLOBALS['eZMaxLogrotateFiles'];
        if ( isset( $maxLogrotateFiles ) )
            return $maxLogrotateFiles;
        return self::MAX_LOGROTATE_FILES;
    }
    /*!
     \static
     Rotates logfiles so the current logfile is backed up,
     old rotate logfiles are rotated once more and those that
     exceed maxLogrotateFiles() will be removed.
     Rotated files will get the extension .1, .2 etc.
    */
    static function rotateLog( $fileName )
    {
        $maxLogrotateFiles = eZLog::maxLogrotateFiles();
        for ( $i = $maxLogrotateFiles; $i > 0; --$i )
        {
            $logRotateName = $fileName . '.' . $i;
            if ( @file_exists( $logRotateName ) )
            {
                if ( $i == $maxLogrotateFiles )
                {
                    @unlink( $logRotateName );
                }
                else
                {
                    $newLogRotateName = $fileName . '.' . ($i + 1);
                    eZLog::rename( $logRotateName, $newLogRotateName );
                }
            }
        }
        if ( @file_exists( $fileName ) )
        {
            $newLogRotateName = $fileName . '.' . 1;
            eZLog::rename( $fileName, $newLogRotateName );
            return true;
        }
        return false;
    }
    static function rename( $srcFile, $destFile )
    {
        /* On windows we need to unlink the destination file first */
        if ( strtolower( substr( PHP_OS, 0, 3 ) ) == 'win' )
        {
            @unlink( $destFile );
        }
        return rename( $srcFile, $destFile );
    }
    /*!
     \static
     Sets the maximum number of logrotate files to keep to \a $files.
    */
    static function setLogrotateFiles( $files ) {
        $GLOBALS['eZMaxLogrotateFiles'] = $files;
    }
}

/* Source : http://www.theblog.ca/wordpress-file-logs */


/* Usage */
$message = 'Logging this';
$logger = new eZLog();
$logFile = 'wp-logs.txt';
$logPath = WP_CONTENT_DIR;
$logger->write( $message, $logFile, $logPath );