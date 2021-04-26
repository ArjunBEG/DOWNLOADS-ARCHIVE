
'.source.go':
  'Options':
    'prefix': 'options'
    'body': '''
// Option function.
type Option func(*$1)

// New with the given options.
func New(options ...Option) *$1 {
	var v $1
	for _, o := range options {
		o(&v)
	}
	return &v
}

$0
'''

  'Option':
    'prefix': 'o'
    'body': '''
// With$1 option.
func With$1($2) Option {
	return func(v *$3) {
		$0
	}
}
'''

  'Context Background':
    'prefix': 'cb'
    'body': 'context.Background()'

  'Context WithTimeout':
    'prefix': 'ct'
    'body': '''
ctx, cancel := context.WithTimeout($0, ${1:time.Second})
defer cancel()
'''

  'log':
    'prefix': 'l'
    'body': 'println($0)'

  'Log Debug':
    'prefix': 'ld'
    'body': 'log.Debugf("$1", $0)'

  'db sqlx':
    'prefix': 'db'
    'body': '*sqlx.DB'

  'Return nil':
    'prefix': 'n'
    'body': 'return nil'

  'Reverse Slice':
    'prefix': 'reverse'
    'body': '''
for i, j := 0, len($1)-1; i < j; i, j = i+1, j-1 {
  $1[i], $1[j] = $1[j], $1[i]
}
'''

  'Go inline':
    'prefix': 'goi'
    'body': 'go func() { $0 }()'

  'Log WithFields':
      'prefix': 'lw'
      'body': '''
${1:log}.WithFields(log.Fields{
  $0
})
'''

  'No Error':
    'prefix': 'ae'
    'body': '''
assert.NoError(t, ${1:err}, "$0")
'''

  'Assert Equal':
    'prefix': 'aee'
    'body': '''
assert.Equal(t, ${1:expected}, ${2:actual})
'''

  'HTTP error':
    'prefix': 'he'
    'body': 'http.Error(w, http.StatusText(http.Status$1), http.Status$1)'

  'Inspect JSON':
    'prefix': 'ij'
    'body': '''
{
  enc := json.NewEncoder(os.Stderr)
  enc.SetIndent("", "  ")
  enc.Encode($0)
}
'''

  'For range':
    'prefix': 'fr'
    'body': '''
for _, $1 := range $2 {
  $0
}
'''

  'Config':
    'prefix': 'configuration'
    'body':'''
// Config options.
type Config struct {
  $0
}

// $1 $2
type $1 struct {
  *Config
}

// New $3 with the given config.
func New(config *Config) *$1 {
  return &$1{
    Config: config,
  }
}
'''

  'Benchmark':
    'prefix': 'bench'
    'body': '''
func Benchmark$1(b *testing.B) {
	for i := 0; i < b.N; i++ {
		$0
	}
}
'''

  'Map':
    'prefix': 'ma'
    'body': 'map[${1:string}]${0:value}'

  'Lock':
    'prefix': 'lo',
    'body': '''
$0.Lock()
defer $0.Unlock()
'''

  'unsigned int 64':
    'prefix': 'u'
    'body': 'uint64'

  'unsigned int 32':
    'prefix': 'uu'
    'body': 'uint32'

  'int 64':
    'prefix': 'i'
    'body': 'int64'

  'int 32':
    'prefix': 'ii'
    'body': 'int32'

  'float 64':
    'prefix': 'fl'
    'body': 'float64'

  'Append':
    'prefix': 'a'
    'body': '$1 = append($1, $2)$0'

  'HTTP Handler':
    'prefix': 'ha'
    'body': 'w http.ResponseWriter, r *http.Request'

  'HTTP Handler Function':
    'prefix': 'haf'
    'body': 'func (w http.ResponseWriter, r *http.Request){$0}'

  'Error Wrap':
    'prefix': 'ew'
    'body': 'errors.Wrap(err, "$0")'

  'Log Error':
    'prefix': 'le'
    'body': 'log.WithError(err).Error("$0")'

  'Context Error':
    'prefix': 'ce'
    'body': 'ctx.WithError(err).Error("$0")'

  'Log Fatalf':
    'prefix': 'fa'
    'body': 'log.Fatalf("error $1: %s", err)$0'

  'Init function':
    'prefix': 'init'
    'body': '''
func init() {
  $0
}
'''

  'Defer function':
    'prefix': 'd'
    'body': '''
defer func(){
  $0
}()
'''

  'Test function':
    'prefix': 't'
    'body': '''
func Test$1(t *testing.T) {
  $0
}
'''

  'Test file':
    'prefix': 'tf'
    'body': '''
package $1

import (
  "testing"

  "github.com/tj/assert"
)

func Test$2(t *testing.T) {
  $0
}
'''

  'Full file example':
    'prefix': 'ex'
    'body': '''
package $1_test

import (
	"github.com/$2"
)

// $3
func Example() {
	$0
}
'''

  'If error':
    'prefix': 'ie'
    'body': '''
if err := $1; err != nil {
  return $0
}
'''

  'Hex Dump Reader':
    'prefix': 'hdr'
    'body': '''
{
  b, err := ioutil.ReadAll($0)
  if err != nil {
    panic(err)
  }

  fmt.Printf("%s\\\\n", hex.Dump(b))
}
'''

  'Hex Dump':
    'prefix': 'hd'
    'body': '''
fmt.Printf("%s\\\\n", hex.Dump($1))
'''

  'Fmt Printf':
    'prefix': 'p'
    'body': '''
fmt.Printf("$1\\\\n", $2)
'''

  'Fmt Printf Inspect':
    'prefix': 'pp'
    'body': '''
fmt.Printf("%#v\\\\n", $1)
'''

  'Fmt Printf Inspect Stderr':
    'prefix': 'ppp'
    'body': '''
fmt.Fprintf(os.Stderr, "%#v\\\\n", $1)
'''

  'Return':
    'prefix': 'r'
    'body': 'return'

  'Tag':
    'prefix': 'tag'
    'body': '`$1:"$2"`'

  'Bytes':
    'prefix': 'b'
    'body': '[]byte($1)'

  'Function':
    'prefix': 'f'
    'body': '''
func $1($2) $3 {
  $0
}
'''

  'If Ok':
    'prefix': 'io'
    'body': '''
if $1, ok := $2.($3); ok {
  $0
}
'''

  'If Error':
    'prefix': 'e'
    'body': '''
if err != nil {
  $0
}
'''

  'Struct':
    'prefix': 's'
    'body': '''
type $1 struct {
  $0
}
'''

  'Method':
    'prefix': 'm'
    'body': '''
// $3 $4
func ($1 *$2) $3($5) $6 {
  $0
}
'''

  'Method Chained':
    'prefix': 'mc'
    'body': '''
// $3 $4
func ($1 *$2) $3($5) *$2 {
  $0
  return $1
}
'''
