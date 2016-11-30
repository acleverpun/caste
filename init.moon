{ :gsub, :split } = require('std.string')

export req = (path, file) ->
	pathParts = split(gsub(path, '/', '.'), '%.')
	firstFilePart = split(gsub(file, '/', '.'), '%.')[1]
	dir = ''
	for part in *pathParts
		if part == firstFilePart then break
		dir ..= "#{part}."
	require(dir .. file)

exports = {
	Caste: req(..., 'lib.caste'),
	Proxy: req(..., 'lib.proxy'),
	helpers: req(..., 'lib.helpers'),
}

for name, helper in pairs(exports.helpers)
	exports[name] = helper

return exports
