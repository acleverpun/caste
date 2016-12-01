moon = require('moon')
_ = req(..., 'lib.utils')

init = () =>
	@class = @@
	@type = _.lowerFirst(@@name)
	@isInstance = true

class Caste

	@name: 'Caste'
	@type: 'caste'
	@parents: {}
	@isClass: true
	@__implements: {}

	@__inherited: (child) =>
		child.name = child.__name
		child.type = _.lowerFirst(child.name)
		child.parents = _.union(@@parents, { @@ })

		for key, value in pairs child.__base
			if type(value) == 'table' and value.isHelper
				value\apply(child, key)

		-- Inherit metamethods
		for key, value in pairs @__base
			if string.sub(key, 1, 2) == '__'
				child.__base[key] or= value

		-- Call setup code in constructor, so children do not need to call `super`
		constructor = child.__init
		child.__init = (...) =>
			init(@)
			constructor(@, ...)

	@implements: (...) =>
		mixins = { ... }
		for mixin in *mixins
			constructor = mixin.__init
			mixin.__init = mixin.__base.__apply
			moon.mixin(@__base, mixin)
			mixin.__init = constructor
			table.insert(@__implements, mixin)

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
