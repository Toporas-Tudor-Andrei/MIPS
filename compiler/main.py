lines = []
instructions = {}
instrType = {"add": 0, "addi": 1, "xor": 0, "lw": 1, "sw": 1, "beq": 1, "j": 2, "sub": 0}
opcode = {"add": "000000", "addi": "001000", "xor": "000000", "lw": "100011", "sw": "101011", "beq": "000100", "j": "000010", "sub": "000000"}
func = {"add": "100000", "xor": "100110", "sub": "100010"}
shamt = {"add": "00000", "xor": "00000", "sub": "00000"}
labels = {}
registers = {"$zero": "00000", "$0":  "00000",
             "$at":   "00001", "$1":  "00001",
             "$v0":   "00010", "$2":  "00010",
             "$v1":   "00011", "$3":  "00011",
             "$a0":   "00100", "$4":  "00100",
             "$a1":   "00101", "$5":  "00101",
             "$a2":   "00110", "$6":  "00110",
             "$a3":   "00111", "$7":  "00111",
             "$t0":   "01000", "$8":  "01000",
             "$t1":   "01001", "$9":  "01001",
             "$t2":   "01010", "$10": "01010",
             "$t3":   "01011", "$11": "01011",
             "$t4":   "01100", "$12": "01100",
             "$t5":   "01101", "$13": "01101",
             "$t6":   "01110", "$14": "01110",
             "$t7":   "01111", "$15": "01111",
             "$s0":   "10000", "$16": "10000",
             "$s1":   "10001", "$17": "10001",
             "$s2":   "10010", "$18": "10010",
             "$s3":   "10011", "$19": "10011",
             "$s4":   "10100", "$20": "10100",
             "$s5":   "10101", "$21": "10101",
             "$s6":   "10110", "$22": "10110",
             "$s7":   "10111", "$23": "10111",
             "$t8":   "11000", "$24": "11000",
             "$t9":   "11001", "$25": "11001",
             "$k0":   "11010", "$26": "11010",
             "$k1":   "11011", "$27": "11011",
             "$gp":   "11100", "$28": "11100",
             "$sp":   "11101", "$29": "11101",
             "$fp":   "11110", "$30": "11110",
             "$ra":   "11111", "$31": "11111", }


def binaryToLittleEndianHex(binaryInst):
    resultH = '%0*X' % ((len(binaryInst) + 3) // 4, int(binaryInst, 2))
    littleEndianResult = f"{resultH[6:]} {resultH[4:6]} {resultH[2:4]} {resultH[0:2]}"
    return littleEndianResult


def decodeRtype(instruction):
    index = lines.index(instruction)
    lines[index] = ""
    name = instruction.split(" ", maxsplit=1)[0]
    regs = instruction.split(" ")
    rd = registers[regs[1].strip(",")]
    rs = registers[regs[2].strip(",")]
    rt = registers[regs[3].strip(",")]
    print(binaryToLittleEndianHex(
        opcode[name] + rs + rt + rd + shamt[name] + func[name]
    ))


def decodeItype(instruction):
    index = lines.index(instruction)
    lines[index] = ""
    name = instruction.split(" ", maxsplit=1)[0]
    operands = instruction.split(" ")
    rs = operands[3].strip("()")
    rt = operands[1].strip(",")
    imm = operands[2]
    if "$" in operands[2]:
        rs = operands[2].strip(",")
        imm = operands[3]
    try:
        numImm = int(imm)
    except ValueError:
        numImm = labels[imm.strip()] - (index + 1)
    finally:
        imm = f"{'1' if numImm < 0 else ''}{bin((1 << 16) + numImm)[3:]}"
    print(binaryToLittleEndianHex(
        opcode[name] + registers[rs] + registers[rt] + imm
    ))


def decodeJtype(instruction):
    index = lines.index(instruction)
    lines[index] = ""
    name = instruction.split(" ", maxsplit=1)[0]
    jAddr = labels[instruction.split(" ")[1]]
    jAddr = f"{bin((1 << 26) + jAddr)[3:]}"
    print(binaryToLittleEndianHex(
        opcode[name] + jAddr
    ))


def decode(inst):
    tip = instrType[inst.split(" ", maxsplit=1)[0]]
    if tip == 0:
        decodeRtype(inst)
    elif tip == 1:
        decodeItype(inst)
    elif tip == 2:
        decodeJtype(inst)
    else:
        print(f"unknown instruction: \"{inst}\"")


with open("instructions.txt", "r") as file:
    i = 0
    for line in file.readlines():
        if ":" in line:
            labels[line.strip(":\n")] = i
        else:
            lines.append(line.strip())
            instructions[line.strip()] = i
            i += 1

list(map(decode, lines))
