# https://dbader.org/blog/python-multiline-comment 
# https://www.journaldev.com/19243/python-ast-abstract-syntax-tree
# import ast

#code = ast.parse("print('Hello world!')")
#print(code)

#exec(compile(code, filename="", mode="exec"))


#import ast

#tree = ast.parse('''
#fruits = ['grapes', 'mango']
#name = 'peter'

#for fruit in fruits:
#    print('{} likes {}'.format(name, fruit))
#''')

#print(ast.dump(tree))

import ast

class NodeVisitor(ast.NodeVisitor):
    def visit_Str(self, tree_node):
        print('{}'.format(tree_node.s))

class NodeTransformer(ast.NodeTransformer):
    def visit_Str(self, tree_node):
        return ast.Str(tree_node.s)

tree_node = ast.parse('''
fruits = ['grapes', 'mango']
name = 'peter'

for fruit in fruits:
    print('{} likes {}'.format(name, fruit))
'''
)

NodeTransformer().visit(tree_node)
NodeVisitor().visit(tree_node)

#Visitor class defined above implement methods that are called for each AST nodes, whereas Transformer class first calls corresponding method for node and replaces with return value.

tree_node = ast.fix_missing_locations(tree_node)
exec(compile(tree_node, '', 'exec'))
