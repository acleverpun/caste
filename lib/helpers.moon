Helper = req(..., 'lib.helpers.helper')

{
	abstract: (cls) => cls

	virtual: class extends Helper
		__call: () => error("Virtual method '#{@key}' has not been overridden.")

	:Helper
}
