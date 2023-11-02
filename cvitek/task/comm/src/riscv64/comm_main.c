/* Standard includes. */
#include <stdio.h>
#include <stdint.h>

/* Kernel includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"
#include "mmio.h"
#include "delay.h"

/* cvitek includes. */
#include "printf.h"
#include "rtos_cmdqu.h"
#include "cvi_mailbox.h"
#include "intr_conf.h"
#include "top_reg.h"
#include "memmap.h"
#include "comm.h"
#include "cvi_spinlock.h"


//#define __DEBUG__

#ifdef __DEBUG__
#define debug_printf printf
#else
#define debug_printf(...)
#endif


/****************************************************************************
 * Function prototypes
 ****************************************************************************/




/****************************************************************************
 * Global parameters
 ****************************************************************************/


/* mailbox parameters */
volatile struct mailbox_set_register *mbox_reg;
volatile struct mailbox_done_register *mbox_done_reg;
volatile unsigned long *mailbox_context; // mailbox buffer context is 64 Bytess



/****************************************************************************
 * Function definitions
 ****************************************************************************/




DEFINE_CVI_SPINLOCK(mailbox_lock, SPIN_MBOX);

void app_task_demo(void * param)
{
    const int COUNTER_STOP = 3;
    int counter = 0;
    while(1) {
        if(counter < COUNTER_STOP){
            printf("Hello Milk-V Duo from the small core! [%d/%d]\r\n", counter+1, COUNTER_STOP);
            counter++;
        }
        vTaskDelay(1000);
    }
}

void main_cvirtos(void)
{
	printf("create cvi task\n");


	/* Start the tasks and timer running. */
    xTaskCreate(app_task_demo, "task_demo", 1024, NULL, 1, NULL);
    vTaskStartScheduler();

    /* If all is well, the scheduler will now be running, and the following
    line will never be reached.  If the following line does execute, then
    there was either insufficient FreeRTOS heap memory available for the idle
    and/or timer tasks to be created, or vTaskStartScheduler() was called from
    User mode.  See the memory management section on the FreeRTOS web site for
    more details on the FreeRTOS heap http://www.freertos.org/a00111.html.  The
    mode from which main() is called is set in the C start up code and must be
    a privileged mode (not user mode). */
    printf("cvi task end\n");
	
	for (;;);
}
