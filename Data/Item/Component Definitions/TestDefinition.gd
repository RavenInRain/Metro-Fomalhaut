extends Resource
class_name TestDefinition

#-# PURPOSE
# > Tells the item which Virtue it should test if it is used.

#var virtues: VirtueData = VirtueData
var test: TESTS = TESTS.NONE 

enum TESTS {
	NONE,
	TESTS_VIGOR,
	TESTS_CLARITY,
	TESTS_SPIRIT
}
