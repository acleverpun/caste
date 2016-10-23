__dirname = (...)\match('(.-)[^%/%.]+$')
_ = require(__dirname .. 'utils')

init = () =>
	@class = @@
	@type = _.lowerFirst(@@name)
	@isInstance = true

class Caste

	@name: 'Caste'
	@type: 'caste'
	@parents: {}
	@isClass: true

	@__inherited: (child) =>
		child.name = child.__name
		child.type = _.lowerFirst(child.name)
		child.parents = _.union(@@parents, { @@ })

		-- Inherit metamethods
		for key, value in next, @__base
			if string.sub(key, 1, 2) == '__'
				child.__base[key] or= value

		-- Call setup code in constructor, so children do not need to call `super`
		constructor = child.__init
		child.__init = (...) =>
			init(@)
			constructor(@, ...)

	-- TODO: invert this, so you're figuring out if a thing is an instance of this class
	@is: (value) =>
		if value == @ then return true
		if value == @name then return true

		valueType = type(value)
		if valueType == 'string'
			return _.some(@parents, (Parent) -> _.includes({ Parent.type, Parent.name }, value))
		if valueType == 'table' and value.isInstance
			return _.some(@parents, (Parent) -> value.class == Parent)
		if valueType == 'table' and value.isClass
			return _.some(@parents, (Parent) -> value == Parent)

		return false

	is: (value) =>
		if value == @ then return true
		if value == @type then return true
		return @@is(value)
