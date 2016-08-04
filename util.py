import lldb

def print_block(block, level):
    indent = '  ' * level
    print indent, str(block)
    for var in block.GetVariables(lldb.frame, True, True, False, lldb.eNoDynamicValues):
        print indent, var.type, var.name, '=', var.value #, str(var)

def visit_block(block, level=0):
    while block.IsValid():
        print_block(block, level)
        child = block.GetFirstChild()
        if child.IsValid():
            visit_block(child, level+1)
        block = block.GetSibling()
        break

def main():
    visit_block(lldb.frame.block)
