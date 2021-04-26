<?php
class DB1 {
    protected static $_db;
    public static function query($sql) {
        return self::_connect()->mysql_query($sql);
    }
    protected static function _connect() {
        if (!isset(self::$_db))
            self::$_db = mysql_connect(/*... params ...*/);
        return self::$_db;
    }
}

class DB2 {
    protected static $_instance;
    protected $_db;
    protected function __construct() {
    }
    public static function getInstance() {
        if (!isset(self::$_instance))
            self::$_instance = new DB2();
        return self::$_instance;
    }
    public function query($sql) {
        return $this->_connect()->mysql_query($sql);
    }
    protected function _connect() {
        if (!isset($this->_db))
            $this->_db = mysql_connect(/*... params ...*/);
        return $this->_db;
    }
}

// use static
DB1::query('SELECT * FROM user');

// use singleton
DB2::getInstance()->query('SELECT * FROM user');