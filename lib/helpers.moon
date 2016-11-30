{
	virtual: (methods) =>
		if type(methods) == 'string' then methods = { [methods]: false }
		for name in pairs(methods)
			@__base[name] = () => error("Virtual method '#{name}' has not been overridden.")
}
