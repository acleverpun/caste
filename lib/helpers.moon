Helper = req(..., 'lib.helpers.helper')

{
	abstract: (cls) => cls

	virtual: class extends Helper
		new: (err) => if type(err) == 'string' then @err = err
		__call: () => error(@err or "Virtual method '#{@key}' has not been overridden.")

	:Helper
}
