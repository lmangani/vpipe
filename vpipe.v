module main

import flag
import os
import v.vmod
import x.json2

fn main() {

	mut fp := flag.new_flag_parser(os.args)
	vm := vmod.decode( @VMOD_FILE ) or { panic(err.msg) }
        fp.application('$vm.name')
        fp.description('$vm.description')
        fp.version('$vm.version')
	fp.skip_executable()

	// Parse query and split functions
	query := os.args[1]
	mut funcs := query.split('|')
	for c, fun in funcs {
	  funcs[c] = fun.trim(' ')
	}
	//println(funcs)

        data := os.get_lines()
        for _, line in data {
	mut modline := line
		for _, fun in funcs {
		   if fun.to_lower() == "logfmt" {
		     modline = logfmt_parse(line)
		   } else if fun.to_lower() == "json" {
		     modline = json_parse(line)
		   }
		}
	        println(modline)
        }
}


fn logfmt_parse(line string) string {
	mut data := map[string]string{}
	for _, log in line.split(' ') {
	    pair := log.split('=') {
		key, value := pair[0].to_lower().trim(' '), pair[1]
		if value.starts_with('"') && value.ends_with('"') {
			data[key] = value[1..value.len - 1]
		} else {
			data[key] = value
		}
	    }
	}
	return data.str()
}

fn json_parse(line string) string {
	parsed := json2.raw_decode(line) or { line }
	return parsed.str()
}
