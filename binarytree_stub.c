#include <stdio.h>
#include <stdlib.h>

struct node {
    /* simple node struct to implement an
       integer binary tree: 'content' is an
       integer storing the content of the node;
       'left' is a pointer to the left child and
       'right' is a pointer to the right child. */

    int content;
    struct node *left;
    struct node *right;
};

struct node* newnode(int c) {
    /* allocate a new node in memory, with
       content 'c', NULL as left and right childs, and
       return a pointer to the new node.*/

    struct node* temp = (struct node*)malloc(sizeof(struct node));
    temp->content = c;
    temp->left = temp->right = NULL;
    return temp;
}

struct node* insert(struct node* root, int c) {
    /* if tree is empty, return a new node with content 'c' 
       otherwise insert a new node to the left subtree if its content
       is less than that of the root or the right subtree if its content
       is greater than or equal to the root.
       (recursive) */
    
    if (root == NULL)
        return newnode(c);
    if (c < root->content)
        root->left = insert(root->left, c);
    else
        root->right = insert(root->right, c);
    return root;
}

void printinorder(struct node* root) {
    /* print the content of all tree elements
       displays left node, root node, and then right node */
    
    if (root != NULL) {
        printinorder(root->left);
        printf("%d ", root->content);
        printinorder(root->right);
    }
}

int countnodes(struct node* root) {
    /* return the number of nodes in the tree. */
    
    if (root == NULL)
        return 0;
    return 1 + countnodes(root->left) + countnodes(root->right);
}

int sumnodes(struct node* root) {
    /* return the sum of the contents of nodes in the tree */
    
    if (root == NULL)
        return 0;
    return root->content + sumnodes(root->left) + sumnodes(root->right);
}

struct node* findminimum(struct node* root) {
    /* return the node which has minimum value in the tree.
       Note: node with minimum value will have no left child.
       (iterative) */
    
    if (root == NULL)
        return NULL;
    struct node* current = root;
    while (current->left != NULL)
        current = current->left;
    return current;
}

void deletetree(struct node* root) {
    /* delete a given tree.
       Note: delete left and right subtrees first and 
       then the current node.
       Print deleted nodes. */
    
    if (root != NULL) {
        deletetree(root->left);
        deletetree(root->right);
        printf("Deleted node with value: %d\n", root->content);
        free(root);
    }
}

int main() {
    struct node* root = newnode(12);
    root = insert(root, 5);
    root = insert(root, 15);
    root = insert(root, 3);
    root = insert(root, 10);

    printf("In Order Display:\n");
    printinorder(root);
    printf("\n");

    printf("Number of nodes: %d\n", countnodes(root));
    printf("Sum of nodes: %d\n", sumnodes(root));

    struct node* minNode = findminimum(root);
    if (minNode != NULL) {
        printf("Minimum value: %d\n", minNode->content);
    }

    printf("Deleting tree...\n");
    deletetree(root);

    return 0;
}