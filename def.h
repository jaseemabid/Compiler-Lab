/* Common header file */

struct tNode {
	int value;
	char op;
	struct tNode* left;
	struct tNode* right;
};

struct tNode* root;
struct tNode* temp;


