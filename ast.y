%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node Node;

struct Node {
    char *value;
    struct Node *left;
    struct Node *right;
};

Node *createNode(char *value, Node *left, Node *right);
void printAST(Node *root, int level);

Node *root = NULL;

int yylex(void);
int yyerror(const char *s);
%}

%code requires {
    typedef struct Node Node;
}

%union {
    char *str;
    Node *node;
}

%token <str> ID
%type <node> input E T F

%left '+' '-'
%left '*' '/'

%start input

%%

input:
    E
    {
        root = $1;
    }
    ;

E:
    E '+' T
    {
        $$ = createNode("+", $1, $3);
    }
    | E '-' T
    {
        $$ = createNode("-", $1, $3);
    }
    | T
    {
        $$ = $1;
    }
    ;

T:
    T '*' F
    {
        $$ = createNode("*", $1, $3);
    }
    | T '/' F
    {
        $$ = createNode("/", $1, $3);
    }
    | F
    {
        $$ = $1;
    }
    ;

F:
    '(' E ')'
    {
        $$ = $2;
    }
    | ID
    {
        $$ = createNode($1, NULL, NULL);
    }
    ;

%%

Node *createNode(char *value, Node *left, Node *right)
{
    Node *newNode = (Node *)malloc(sizeof(Node));

    if (newNode == NULL) {
        printf("Memory allocation failed\n");
        exit(1);
    }

    newNode->value = strdup(value);
    newNode->left = left;
    newNode->right = right;

    return newNode;
}

void printAST(Node *root, int level)
{
    if (root == NULL)
        return;

    for (int i = 0; i < level; i++)
        printf(" ");

    printf("%s\n", root->value);

    printAST(root->left, level + 1);
    printAST(root->right, level + 1);
}

int main(void)
{
    printf("Enter expression: ");

    if (yyparse() == 0) {
        printf("\nAbstract Syntax Tree:\n");
        printAST(root, 0);
    }

    return 0;
}

int yyerror(const char *s)
{
    printf("Invalid expression\n");
    return 0;
}

