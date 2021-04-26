<?php

class RetriesExceededException extends \Exception {}

class Retry
{

    const MAX_RETRIES = 5;
    
    const BASE_RETRY_DELAY = 1000000;
    
    static public function delayed(callable $action, $retries = 1)
    {
        if ( ! is_int($retries) || $retries > self::MAX_RETRIES) {
            throw new \InvalidArgumentException();
        }
        
        return self::attempt($action, $retries, true);
    }

    static public function immediately(callable $action, $retries = 1)
    {
        if ( ! is_int($retries) || $retries > self::MAX_RETRIES) {
            throw new \InvalidArgumentException();
        }
        
        return self::attempt($action, $retries, false);
    }

    static private function attempt(callable $action, $retries, $delay)
    {
        do {
            try {
                return $action();
            } catch (\Exception $e) {
                if ($delay && $retries) {
                    //do delay
                }
            }
        } while ($retries--)

        throw new RetriesExceededException(); 
    }

}

//Retry::delayed($delay, $action, $retries);
//Retry::immediately($action, $retries);