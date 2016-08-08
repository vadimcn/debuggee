import lldb

def print_block(block, level):
    indent = '  ' * level
    print indent, str(block), '-', str(block.GetInlinedName())
    for var in block.GetVariables(lldb.target, True, True, True):
        print indent, var.type, var.name

def visit_block(block):
    parent = block.GetParent()
    level = 0
    if parent.IsValid():
        level = visit_block(parent)
    print_block(block, level)
    return level + 1

def main():
    visit_block(lldb.frame.block)
