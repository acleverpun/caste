Helper = req(..., 'lib.helpers.helper')

{
	abstract: () =>
		@__init = () => error('Abstract classes cannot be instantiated.')
		@__base.__inherited = (child) =>
			for key, value in pairs @__base
				if string.sub(key, 1, 2) != '__' and not rawget(child.__base, key)
					error("Abstract method '#{key}' has not been overridden.")
		return @

	virtual: class extends Helper
		new: (err) => if type(err) == 'string' then @err = err
		__call: () => error(@err or "Virtual method '#{@key}' has not been overridden.")

	:Helper
}
