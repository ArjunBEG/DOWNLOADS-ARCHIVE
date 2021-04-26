<?php

require_once __DIR__.'/autoload.php.dist';

use Symfony\Component\ExpressionLanguage\ExpressionLanguage;
use Symfony\Component\ExpressionLanguage\Lexer;
use Symfony\Component\ExpressionLanguage\Parser;
use Symfony\Component\ExpressionLanguage\Compiler;
use Symfony\Component\ExpressionLanguage\SerializedParsedExpression;

class Obj
{
    public $foo = 'bar';

    public function bar($foo)
    {
        return $foo;
    }
}

$el = new ExpressionLanguage();

$context = array('number' => 12, 'foo' => 'bar', 'arr' => array('foo' => 'bar'), 'obj' => new Obj());

$nb = 1000;

$lexer = new Lexer();
$parser = new Parser(array());
$compiler = new Compiler(array());

foreach (array('simple', 'complex') as $type) {
    print "Internal Benchmarks ($type)\n";
    print "-------------------\n\n";

    $a = microtime(true);
    for ($i = 0; $i < $nb; $i++) {
        $lexer->tokenize(get_expression($type));
    }
    printf("LEXER    %.3fms\n", (microtime(true) - $a) * 1000 / $nb);

    $tokens = $lexer->tokenize(get_expression($type));
    $a = microtime(true);
    for ($i = 0; $i < $nb; $i++) {
        $parser->parse(clone $tokens, array_keys($context));
    }
    printf("PARSER   %.3fms\n", (microtime(true) - $a) * 1000 / $nb);

    $nodes = $parser->parse(clone $tokens, array_keys($context));
    $a = microtime(true);
    for ($i = 0; $i < $nb; $i++) {
        $compiler->compile($nodes);
    }
    printf("COMPILER %.3fms\n", (microtime(true) - $a) * 1000 / $nb);

    print "\nEvaluation Benchmarks ($type)\n";
    print "---------------------\n\n";

    $a = microtime(true);
    for ($i = 0; $i < $nb; $i++) {
        $el->evaluate(get_expression($type), $context);
    }
    printf("EVAL %.3fms (from string expression)\n", (microtime(true) - $a) * 1000 / $nb);

    $expr = get_expression($type);
    $expr = new SerializedParsedExpression($expr, serialize($el->parse($expr, array_keys($context))));
    $a = microtime(true);
    for ($i = 0; $i < $nb; $i++) {
        $el->evaluate($expr, $context);
    }
    printf("EVAL %.3fms (from serialized expression)\n\n", (microtime(true) - $a) * 1000 / $nb);
}

function get_expression($type)
{
    // we put some random string to avoid hitting our internal cache

    if ('simple' == $type) {
        // simple expression
        return 'obj.bar("foo") == "bar"';
    }

    // a more complex expression (you will probably never have anything more complex)
    return sprintf('arr["foo"] ~ (%d + number) ? number : obj.bar("foo")', mt_rand());
}
