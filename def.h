/* Common header file */

/** Sample Expression Tree Node Structure **/

struct Tnode {
	int TYPE;
					/* Integer (1), Boolean (2) or Void (3) (for statements) */
					/* Must point to the type expression tree for user defined types */
	int NODETYPE;
					/* this field should carry following information:
					* a) operator : (+,*,/ etc.) for expressions
					* b) statement Type : (WHILE, READ etc.) for statements */
	char* NAME;
					/* For Identifiers/Functions */
	int VALUE;
					/* for constants */
	struct Tnode *ArgList;
					/* List of arguments for functions */
	struct Tnode *left, *right;
};

