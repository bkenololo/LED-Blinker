# LED Blinker (VHDL)

This project is a VHDL implementation of a blinking LED, using a safe synchronous design (Clock Enable).

## Design Features

  - **CLK\_PERIOD**  : Made generic via the `const_b` port.
  - **Enable**       : Features an `en_counter` port to pause the counter.
  - **Synthesis**    : Targeted for Intel FPGAs (Quartus).
  - **Verification** : Passed simulation in ModelSim.

## Simulation Results (ModelSim)

This is the result of the toggle (N=10). The counter counts from 0-9, the `tick_pulse` fires, and the LED (`reg_led`) toggles.

<img width="1274" height="560" alt="timing_diagram_zoomin" src="https://github.com/user-attachments/assets/8e914290-e495-480c-878a-9191e4310241" />

This is another view from the result. 

<img width="1275" height="560" alt="timing_diagram_zoomout" src="https://github.com/user-attachments/assets/f868f505-8f37-42e2-9248-d8d7bc7f0a71" />
