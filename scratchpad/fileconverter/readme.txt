Manually unconverting a gzipped-then-base64-encoded file using IRB:

c:\Users\tdoane\stuff>irb
irb(main):001:0> require 'json'
=> true
irb(main):002:0> require 'zlib'
=> true
irb(main):003:0> require 'stringio'
=> true
irb(main):004:0> require 'base64'
=> true
irb(main):005:0> ff = File.open(".//srs.json_encoded.gz")
=> #<File:.//srs.json_encoded.gz>
irb(main):006:0> fr = File.read(ff)
=> "H4sIAMNOTFMAA21QzQrCMAy++xSj5yHt6nB68+IDiHhQpMQZtcy1s6mIyN7d\nrswhaAoh5PujeY2SUAxIGzZPGJeTvAityFnaI+Xtrh0eF77DMy6k4Jlc85zP\nJnI8zcT2w6zBVehXeNY2et3pgxBckVZg
Kgr7Xdx19RqmyCrB49m6Z6c9WFup\no6bmCk9ljXrggbTH3nCQuOAZ6MVMcM4HqE2T/xm/EScwpUan/AWMqi159qX9\nSpDT7rUR2ve/ckiNNYRL62qI19kINmrfmoRvalIBAAA=\n"
irb(main):007:0> decode = Base64.decode64(fr)
=> "\x1F\x8B\b\x00\xC3NLS\x00\x03mP\xCD\n\xC20\f\xBE\xFB\x14\xA3\xE7!\xED\xEApz\xF3\xE2\x03\x88xP\xA4\xC4\x19\xB5\xCC\xB5\xB3\xA9\x88\xC8\xDE\xDD\xAE\xCC!h\n!\x
E4\xFB\xA3y\x8D\x92P\fH\e6O\x18\x97\x93\xBC\b\xAD\xC8Y\xDA#\xE5\xED\xAE\x1D\x1E\x17\xBE\xC33.\xA4\xE0\x99\\\xF3\x9C\xCF&r<\xCD\xC4\xF6\xC3\xAC\xC1U\xE8Wx\xD66z\
xDD\xE9\x83\x10\\\x91V`*\n\xFB]\xDCu\xF5\x1A\xA6\xC8*\xC1\xE3\xD9\xBAg\xA7=X[\xA9\xA3\xA6\xE6\nOe\x8Dz\xE0\x81\xB4\xC7\xDEp\x90\xB8\xE0\x19\xE8\xC5Lp\xCE\a\xA8M
\x93\xFF\x19\xBF\x11'0\xA5F\xA7\xFC\x05\x8C\xAA-y\xF6\xA5\xFDJ\x90\xD3\xEE\xB5\x11\xDA\xF7\xBFrH\x8D5\x84K\xEBj\x88\xD7\xD9\b6j\xDF\x9A\x84ojR\x01\x00\x00"
irb(main):008:0> unzip = Zlib::GzipReader.new(StringIO.new(decode))
=> #<Zlib::GzipReader:0x2bd7e88>
irb(main):009:0> JSON.parse(unzip.read)
=> {"asin"=>"0345803485", "acquiredAt"=>"20131023T050943.721Z", "marketRegion"=>"us", "salesRanks"=>[{"category"=>"book_display_on_website", "rank"=>891000}, {"
category"=>"book_fancier_than_most", "rank"=>373737}], "responseFormat"=>"V1"}
