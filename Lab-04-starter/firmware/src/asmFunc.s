/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */
/* create a string */
.global nameStr
.type nameStr,%gnu_unique_object
    
/*** STUDENTS: Change the next line to your name!  **/
nameStr: .asciz "Inigo Montoya"  

.align   /* realign so that next mem allocations are on word boundaries */
 
/* initialize a global variable that C can access to print the nameStr */
.global nameStrPtr
.type nameStrPtr,%gnu_unique_object
nameStrPtr: .word nameStr   /* Assign the mem loc of nameStr to nameStrPtr */

.global balance,transaction,eat_out,stay_in,eat_ice_cream,we_have_a_problem
.type balance,%gnu_unique_object
.type transaction,%gnu_unique_object
.type eat_out,%gnu_unique_object
.type stay_in,%gnu_unique_object
.type eat_ice_cream,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
balance:           .word     0  /* input/output value */
transaction:       .word     0  /* output value */
eat_out:           .word     0  /* output value */
stay_in:           .word     0  /* output value */
eat_ice_cream:     .word     0  /* output value */
we_have_a_problem: .word     0  /* output value */

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align


    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: the integer value returned to the C function
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
    
    /* START - INITIALIZE OUTPUT VARIABLES TO 0 */
    
    // Initialize variable. Load the address where the value is stored to a register
    LDR r1, =transaction 
    // Set r2 to the value, 0, and use to initialize variales to 0
    MOVS r2, 0
    // Copy data from r2 to transaction 
    STR r2, [r1] 
    
    // Initialize variable. Load the address where the value is stored to a register
    LDR r1, =eat_out 
    // Copy data from r2 (value of 0) to eat_out
    STR r2, [r1] 
    
    // Initialize variable. Load the address where the value is stored to a register
    LDR r1, =stay_in 
    // Copy data from r2 (value of 0) to stay_in 
    STR r2, [r1] 
    
    // Initialize variable. Load the address where the value is stored to a register
    LDR r1, =eat_ice_cream 
    // Copy data from r2 (value of 0) to eat_ice_cream 
    STR r2, [r1] 
    
    // Initialize variable. Load the address where the value is stored to a register
    LDR r1, =we_have_a_problem 
    // Copy data from r2 (value of 0) to we_have_a_problem 
    STR r2, [r1] 
    
    /* END - INITIALIZE OUTPUT VARIABLES TO 0 */

    
    /* START - PERFORM TRANSACTION */
     
    // LOGIC - CHECK TRANSACTION AMOUNT
    
    // Load the address where the value is stored to a register
    LDR r1, =transaction 
    // Copy data from r0 to transaction, per instructions
    STR r0, [r1] 
    
    // Check if transaction value is too high
    CMP r0, 1000    
    /* ERROR - If r0 is greater than 1000 - BRANCH */
    BGT transaction_error
    
    // Check if transaction value is too low
    CMP r0, -1000
    /* ERROR - If r0 is less than -1000 - BRANCH */
    BLT transaction_error
    
    
    // HAPPY PATH CONTINUES - TRANSACTION AMOUNT IS VALID
       
    // Initialize variable. Load the address where the value is stored to a register
    LDR r3, =balance
    LDR r4, [r3]
    LDR r5, =transaction
    LDR r5, [r5]
    
    // Add the balance and transaction (r5) and use the result to set r2 as the temporary balance
    ADDS r2, r4, r5
    
    /* ERROR - If Overflow - BRANCH */
    BVS transaction_error
    
    
    // HAPPY PATH CONTINUES - TRANSACTION IS SUCCESSFUL
    
    // Set balance (r3) to the result (r2) of the addition operation
    STR r2, [r3]
    
    // Check if the resulting balance is greater than 0
    CMP r2, 0
    
    /* If balance is greater than 0 - BRANCH */
    BGT positive_balance
    
    /* If balance is less than 0 - BRANCH */
    BLT negative_balance
    
    // If balance equals 0, set eat_ice_cream to 1 (true), per instructions
    LDR r5, =eat_ice_cream
    MOVS r2, 1
    STR r2, [r5] 
    
    B final_code
    
    /* END - PERFORM TRANSACTION */

    
/* BRANCHES */
    
// TRANSACTION ISSUE OCCURRED
transaction_error:
    // Set transaction (via r1) to 0, per instructions
    LDR r1, =transaction
    MOVS r2, 0
    STR r2, [r1]
    
    // set we_have_a_problem to 1 (true), per instructions
    MOVS r2, 1
    LDR r5, =we_have_a_problem
    STR r2, [r5] 
    
    B final_code
    
// THE BALANCE IS LESS THAN 0    
negative_balance:
    // Set stay_in to 1 (true), per instructions
    LDR r5, =stay_in
    MOVS r2, 1
    STR r2, [r5] 
    
    B final_code
    
// THE BALANCE IS GREATER THAN 0
positive_balance:
    // Set eat_out to 1 (true), per instructions
    LDR r5, =eat_out
    MOVS r2, 1
    STR r2, [r5] 
    
    B final_code
    
/* BRANCHES */

    
/* START - FINAL CODE - ALWAYS EXECUTE */
final_code:
    // Set r0 to the balance value, per instructions
    LDR r2, =balance
    LDR r0, [r2]

    // The process flow ends
    B done
    
/* END - FINAL CODE - ALWAYS EXECUTE */

    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




