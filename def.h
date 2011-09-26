/* Common header file */

// Global Variable structure

typedef struct Gsymbol {
	char *NAME;		// Name of the Identifier
	int TYPE;		// TYPE can be INTEGER or BOOLEAN
	int SIZE;		// Size field for arrays
	int* BINDING;		// Address of the Identifier in Memory
	struct Gsymbol *NEXT;	// Pointer to next Symbol Table Entry */
} Gsymbol;

Gsymbol *gList=NULL, *temp=NULL;


/** Sample Expression Tree Node Structure **/

struct Tnode {
	int TYPE;
					/* Integer (1), Boolean (2) or Void (3) (for statements) */
					/* Must point to the type expression tree for user defined types */
	int NODETYPE;
					/* this field should carry following information:
					* a) operator : (+,*,/ etc.) for expressions
					* b) statement Type : (WHILE, READ etc.) for statements 
					* c) else 0
					*/
	char* NAME;
					/* For Identifiers/Functions */
	int VALUE;
					/* for constants */
	struct Tnode *ArgList;
					/* List of arguments for functions */
	struct Tnode *left, *right;

	Gsymbol *Gentry; // For global identifiers/functions
};


