Caste = req(..., 'lib.caste')

(ProxyClass) ->
	init = () =>
		@proxy = ProxyClass()

	Proxy = class extends Caste

		@__inherited: (child) =>
			super(child)

			-- Call setup code in constructor, so children do not need to call `super`
			constructor = child.__init
			child.__init = (...) =>
				init(@)
				constructor(@, ...)

		-- new: (...) => init(@, ...)

	for key, value in pairs ProxyClass.__instanceDict
		if _.isFunction(value)
			Proxy.__base[key] = (...) =>
				@proxy[key](@proxy, ...)

	return Proxy
