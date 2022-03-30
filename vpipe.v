module main

import flag
import os
import v.vmod
import x.json2
import regex

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	vm := vmod.decode(@VMOD_FILE) or { panic(err.msg) }
	fp.application('$vm.name')
	fp.description('$vm.description')
	fp.version('$vm.version')
	fp.skip_executable()

	query := os.args[1]
	mut funcs := query.split(' | ')
	for c, fun in funcs {
		funcs[c] = fun.trim(' ')
	}

	mut data := os.get_lines()
	for l, mut line in data {
		for _, fun in funcs {
			if fun.to_lower() == 'logfmt' {
				line = logfmt_parse(line)
				data[l] = line
			} else if fun.to_lower() == 'json' {
				line = json_parse(line)
				data[l] = line
			} else if fun.to_lower().starts_with('regex') {
				q := fun.split(' ')
				if q[1].len > 0 {
					line = regex_parse(line, q[1])
					data[l] = line
				}
			}
		}
		println(line)
	}
}

fn logfmt_parse(line string) string {
	mut data := map[string]string{}
	for _, mut log in line.split(' ') {
		pair := log.split('=')
		{
			if pair.len == 1 {
				data['raw'] = line
			} else {
				key, value := pair[0].to_lower().trim(' '), pair[1]
				if value.starts_with('"') && value.ends_with('"') {
					data[key] = value[1..value.len - 1]
				} else {
					data[key] = value
				}
			}
		}
	}
	return data.str()
}

fn json_parse(line string) string {
	parsed := json2.raw_decode(line) or { line }
	return parsed.str()
}

fn regex_parse(line string, query string) string {
	mut bits := map[string]json2.Any{}
	mut re := regex.regex_opt(query) or { panic(err) }
	re.debug = 0 // disable log
	_, _ := re.match_string(line)
	for name in re.group_map.keys() {
		bits['$name'] = '${re.get_group_by_name(line, name)}'
	}
	return bits.str()
}
