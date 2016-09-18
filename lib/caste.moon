_ = require('lib/utils')

init = () =>
	@class = @@
	@type = _.lowerFirst(@@name)

class Caste

	@name: 'Caste'
	@type: 'caste'
	@parents: { @ }
	@isClass: true

	isInstance: true

	@__inherited: (child) =>
		child.name = child.__name
		child.type = _.lowerFirst(child.name)
		child.parents = _.union(@@parents, { @@ })

		-- Call setup code in constructor, so children do not need to call `super`
		constructor = child.__init
		child.__init = (...) =>
			init(@)
			constructor(@, ...)

	-- new: () => init(@)

	is: (value) =>
		if value == @ then return true
		if value == @@ then return true
		if value == @type then return true
		if value == @@name then return true

		if type(value) == 'string'
			return _.some(@@parents, (Parent) -> _.includes({ Parent.type, Parent.name }, value))
		if not not value.isInstance
			return _.some(@@parents, (Parent) -> value.class == Parent)
		if not not value.isClass
			return _.some(@@parents, (Parent) -> value == Parent)

		return false
