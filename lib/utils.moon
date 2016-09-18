_ = {}

_.includes = (array, value) ->
	for item in *array
		if item == value then return true
	return false

_.indexOf = (array, value) ->
	if type(array) == 'table'
		for i = 1, #array
			if value == array[i] then return i
	return -1

_.some = (collection, fn) ->
	for key, value in pairs(collection)
		if fn(value, key) then return true
	return false

_.union = (...) ->
	args = table.pack(...)
	result = {}
	for array in *args
		for value in *array
			if _.indexOf(result, value) then table.insert(result, value)
	return result

_.lowerFirst = (value) ->
	first = string.lower(string.sub(value, 1, 1))
	rest = string.sub(value, 2)
	return "#{first}#{rest}"

return _
