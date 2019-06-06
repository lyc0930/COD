`define opcode    31 : 26

`define rs        25 : 21
`define rt        20 : 16

`define rd        15 : 11
`define shamt     10 : 6
`define funct      5 : 0

`define immediate 15 : 0

`define address   25 : 0

// Load 
`define LB      6'b100000  // opcode
`define LBU     6'b100100  // opcode
`define LH      6'b100001  // opcode
`define LHU     6'b100101  // opcode
`define LW      6'b100011  // opcode

// Save
`define SB      6'b101000  // opcode
`define SH      6'b101001  // opcode
`define SW      6'b101011  // opcode


`define R_type  6'b000000  // opcode
// R-R Calculate
`define ADD     6'b100000  // funct
`define ADDU    6'b100001  // funct
`define SUB     6'b100010  // funct
`define SUBU    6'b100011  // funct
`define MULT    6'b011000  // funct
`define MULTU   6'b011001  // funct
`define DIV     6'b011010  // funct
`define DIVU    6'b011011  // funct
`define SLT     6'b101010  // funct
`define SLTU    6'b101011  // funct
`define SLL     6'b000000  // funct
`define SRL     6'b000010  // funct
`define SRA     6'b000011  // funct
`define SLLV    6'b000100  // funct
`define SRLV    6'b000110  // funct
`define SRAV    6'b000111  // funct
`define AND     6'b100100  // funct
`define OR      6'b100101  // funct
`define XOR     6'b100110  // funct
`define NOR     6'b100111  // funct

// R-I Calculate
`define ADDI    6'b001000  // opcode
`define ADDIU   6'b001001  // opcode
`define ANDI    6'b001100  // opcode
`define ORI     6'b001101  // opcode
`define XORI    6'b001110  // opcode
`define LUI     6'b001111  // opcode
`define SLTI    6'b001010  // opcode
`define SLTIU   6'b001011  // opcode

// Branch
`define BEQ     6'b000100  // opcode
`define BNE     6'b000101  // opcode
`define BLEZ    6'b000110  // opcode
`define BGTZ    6'b000111  // opcode
`define BLTZ    6'b000001  // opcode | rt = 5'b00000
`define BGEZ    6'b000001  // opcode | rt = 5'b00001

// Jump
`define J       6'b000010  // opcode
`define JAL     6'b000011  // opcode
`define JALR    6'b001001  // funct
`define JR      6'b001000  // funct

// Move
`define MFHI    6'b010000   // funct
`define MFLO    6'b010010   // funct
`define MTHI    6'b010001   // funct
`define MTLO    6'b010011   // funct

// Privilege
`define ERET    6'b011000    // funct | opcode = 6'b000010
`define MFC0    5'b00000     // rs    | opcode = 6'b000010
`define MTC0    5'b00100     // rs    | opcode = 6'b000010

// Pitfall
`define BREAK   6'b001101   // funct
`define SYSCALL 6'b001100 // funct

//NPCOp
`define NPCOPB 0
`define NPCOPJ 1