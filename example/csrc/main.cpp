#include <nvboard.h>
#include "verilated_vcd_c.h"
#include <Vtop.h>

static Vtop dut;
void nvboard_bind_all_pins(Vtop* top);

static void single_cycle() {
  // dut.clk = 0; dut.eval();
  // dut.clk = 1;
  dut.eval();
}

// static void reset(int n) {
//   dut.rst = 1;
//   while (n -- > 0) single_cycle();
//   dut.rst = 0;
// }

int main() {
  nvboard_bind_all_pins(&dut);
  nvboard_init();

  while(1) {
    nvboard_update();
    single_cycle();
  }
}

// VerilatedContext* contextp = NULL;
// VerilatedVcdC* tfp = NULL;

// static Vtop* top;

// void step_and_dump_wave(){
//   top->eval();
//   nvboard_update();
//   contextp->timeInc(1);
//   tfp->dump(contextp->time());
// }


// void sim_init(){
//   nvboard_bind_all_pins(top);
//   contextp = new VerilatedContext;
//   tfp = new VerilatedVcdC;
//   top = new Vtop;
//   nvboard_init();
//   contextp->traceEverOn(true);
//   top->trace(tfp, 0);
//   tfp->open("dump.vcd");
// }

// void sim_exit(){
//   step_and_dump_wave();
//   tfp->close();
//   nvboard_quit();
// }

// int main() {
//   sim_init();

//   top->en = 0b0;  top->x = 0b00;  step_and_dump_wave();
//                   top->x = 0b01;  step_and_dump_wave();
//                   top->x = 0b10;  step_and_dump_wave();
//                   top->x = 0b11;  step_and_dump_wave();
//   top->en = 0b1;  top->x = 0b00;  step_and_dump_wave();
//                   top->x = 0b01;  step_and_dump_wave();
//                   top->x = 0b10;  step_and_dump_wave();
//                   top->x = 0b11;  step_and_dump_wave();
//   sim_exit();
// }