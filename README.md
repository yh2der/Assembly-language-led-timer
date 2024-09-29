# Timer Program

## Overview
This assembly program is designed for a microcontroller-based timer system with four push buttons and four LEDs. The user can set a countdown timer by adjusting the minutes and seconds using the buttons, and once confirmed, the system will start counting down. The LEDs provide visual feedback, indicating the mode and status of the countdown.

## Components
- **Four Push Buttons**: 
  - **Button 1 (P2.0)**: Increments the value (used for adjusting time).
  - **Button 2 (P2.1)**: Decrements the value.
  - **Button 3 (P2.2)**: Confirms the current setting and moves to the next mode.
  - **Button 4 (P2.3)**: Resets the program to Mode 1 (starting mode).
  
- **Four LEDs (P0)**: Represent the four modes:
  - **Mode 1**: Set the tens digit of the minutes.
  - **Mode 2**: Set the ones digit of the minutes.
  - **Mode 3**: Set the tens digit of the seconds.
  - **Mode 4**: Set the ones digit of the seconds.

## Program Structure
The program is divided into four main modes, each responsible for setting a specific portion of the timer:
1. **Mode 1**: Sets the tens digit of the minutes.
2. **Mode 2**: Sets the ones digit of the minutes.
3. **Mode 3**: Sets the tens digit of the seconds.
4. **Mode 4**: Sets the ones digit of the seconds.

Once the settings are confirmed, the countdown begins, and the remaining time is displayed on the LEDs. If the time reaches zero, the LEDs will flash to indicate that the countdown is complete. The program can then be reset by pressing Button 4.

## Usage Instructions
1. **Initial Setup**:
   - The system starts in **Mode 1** where the user sets the tens digit of the minutes.
   - Use **Button 1** to increment the value and **Button 2** to decrement it.
   - Press **Button 3** to confirm the current setting and move to the next mode (Mode 2).

2. **Setting Time**:
   - **Mode 1**: Adjust the tens digit of the minutes using Button 1 (+) and Button 2 (-).
   - **Mode 2**: Adjust the ones digit of the minutes using Button 1 (+) and Button 2 (-).
   - **Mode 3**: Adjust the tens digit of the seconds using Button 1 (+) and Button 2 (-).
   - **Mode 4**: Adjust the ones digit of the seconds using Button 1 (+) and Button 2 (-).
   - After setting the ones digit of the seconds in **Mode 4**, press **Button 3** to start the countdown.

3. **During Countdown**:
   - The countdown starts after the time is set. The LEDs will blink to indicate the countdown status.
   - Once the countdown completes, the LEDs will flash continuously to signal the end of the timer.

4. **Reset**:
   - At any time, you can press **Button 4 (P2.3)** to reset the timer and return to **Mode 1** to set a new countdown.

## Button Functionality
- **Button 1 (P2.0)**: Increments the current value in the active mode.
- **Button 2 (P2.1)**: Decrements the current value in the active mode.
- **Button 3 (P2.2)**: Confirms the current value and moves to the next mode.
- **Button 4 (P2.3)**: Resets the timer and returns to Mode 1.

## Key Routines
- **Mode1, Mode2, Mode3, Mode4**: Handle the setting of each time digit (minutes and seconds).
- **KEY Handlers**: `KEY0` to `KEY7` correspond to button actions for incrementing and decrementing time values.
- **DELAY1/DELAY2**: Delay routines used for timing (1 second and 0.1 second delays).
- **START**: Initiates the countdown once all values are set.
- **TOUT**: Triggered when the countdown reaches zero, flashing the LEDs to indicate that the timer has ended.

## Notes
- This program assumes that the countdown timer needs to handle up to 99 minutes and 59 seconds.
- Ensure that the buttons and LEDs are connected correctly to the microcontroller as per the port mappings defined in the code.
  
## Troubleshooting
- **The countdown starts immediately without setting**: Ensure that the buttons are not stuck or initialized incorrectly. The program waits for user input in each mode before starting the countdown.
- **Time settings do not change**: Verify that the buttons are correctly mapped to P2.0 - P2.3 and functioning properly.
- **Countdown is too fast or slow**: Adjust the delay routines `DELAY1` and `DELAY2` to ensure proper timing based on the clock speed of your microcontroller.
