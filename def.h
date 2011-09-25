/* Common header file */

/** Sample Expression Tree Node Structure **/

struct tNode {
	int TYPE;
					/* Integer, Boolean or Void (for statements) */
					/* Must point to the type expression tree for user defined types */
	int NODETYPE;
					/* this field should carry following information:
					* a) operator : (+,*,/ etc.) for expressions
					* b) statement Type : (WHILE, READ etc.) for statements */
	char* NAME;
					/* For Identifiers/Functions */
	int VALUE;
					/* for constants */
	tNode *ArgList;
					/* List of arguments for functions */
	tNode *left, *right;
}

struct tNode* root;
struct tNode* temp;

/* struct tNode *TreeCreate(TYPE,NODETYPE,VALUE,NAME,left,right); */
