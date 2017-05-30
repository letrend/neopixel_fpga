#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include "hwlib.h"
#include "socal/socal.h"
#include "socal/hps.h"
#include "socal/alt_gpio.h"
#include "neopixel_fpga/hps_0.h"
#include "neopixel_fpga/neopixel.hpp"
#include <limits.h>

#define HW_REGS_BASE ( ALT_STM_OFST )
#define HW_REGS_SPAN ( 0x04000000 )
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )

int main(int argc, char *argv[]) {

	void *virtual_base;
	int fd;
	void *h2p_lw_neopixel_addr;

	// map the address space for the LED registers into user space so we can interact with them.
	// we'll actually map in the entire CSR span of the HPS since we want to access various registers within that span

	if( ( fd = open( "/dev/mem", ( O_RDWR | O_SYNC ) ) ) == -1 ) {
		printf( "ERROR: could not open \"/dev/mem\"...\n" );
		return( 1 );
	}

	virtual_base = mmap( NULL, HW_REGS_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, HW_REGS_BASE );

	if( virtual_base == MAP_FAILED ) {
		printf( "ERROR: mmap() failed...\n" );
		close( fd );
		return( 1 );
	}
	
	h2p_lw_neopixel_addr = virtual_base + ( (unsigned long) ( ALT_LWFPGASLVS_OFST + NEOPIXEL_0_BASE ) & (unsigned long) ( HW_REGS_MASK ) );

	if (!ros::isInitialized()) {
		int argc = 0;
		char **argv = NULL;
		ros::init(argc, argv, "neopixel_fpga", ros::init_options::AnonymousName);
	}

    NeoPixel neopixel(h2p_lw_neopixel_addr);

    IOWR(h2p_lw_neopixel_addr, 0, 0x1);
    uint32_t colors[] = {0xff000000, 0x00ff0000, 0x0000ff00, 0x000000ff};
    int color_counter = 0;
    while(true){
        for(uint i=1;i<=7;i++) {
            IOWR(h2p_lw_neopixel_addr, i, colors[color_counter]);
        }
        color_counter++;
        if(color_counter>3)
            color_counter = 0;
        usleep(100000);
    }





//	vector<int> deviceIDs = {0,1,2,3};
//	AM4096 jointAngle(h2p_lw_i2c_addr,deviceIDs);
//	while(ros::ok()){
//		vector<uint32_t> absAngles, relAngles, tacho;
//		vector<uint8_t> agcGain;
//		vector<bool> tooFar, tooClose;
//		jointAngle.readAbsAngle(absAngles);
//		jointAngle.readRelAngle(relAngles);
//		jointAngle.readMagnetStatus(tooFar, tooClose);
//		jointAngle.readTacho(tacho);
//		jointAngle.readAgcGain(agcGain);
//		for(uint i=0; i<jointAngle.i2cAddrs.size(); i++) {
//			printf("-------------sensor %d -------------\n", jointAngle.i2cAddrs[i]);
//			printf("magnet   %s\n", (tooFar[i] ? "too far" : (tooClose[i] ? "too close" : "ok")));
//			printf("agc gain %d\n", agcGain[i]);
//			printf("absPos   %d\n", absAngles[i]);
//			printf("relPos   %d\n", relAngles[i]);
//			printf("tacho    %d\n", tacho[i]);
//			printf("\n");
//		}
//		usleep(100000);
//	}


	// clean up our memory mapping and exit
	if( munmap( virtual_base, HW_REGS_SPAN ) != 0 ) {
		printf( "ERROR: munmap() failed...\n" );
		close( fd );
		return( 1 );
	}

	close( fd );

	return( 0 );
}
