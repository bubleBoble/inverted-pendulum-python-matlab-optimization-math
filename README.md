Matlab and python scripts developed for linear inverted pendulum build, control system design and implementation project.

Down and up position controller is based on LQR, swingup was done with optimal trajectory (optimTraj for Matlab): 
https://github.com/MatthewPeterKelly/OptimTraj

Python (sympy, numpy, matplotlib) is used to derive pendulum model and draw some phase portraits of nonlinear and linear models. 

Implementation of controller app on STM32 MCU: 
https://github.com/bubleBoble/inverted-pendulum-stm-FreeRTOS-app

Videos of real device and simulation:\
https://www.youtube.com/playlist?list=PLLyk_frqcOGw6XyiyMOqAa3b0tapfJQMq

<b> Final build: </b>
<img title="Finished pendulum" alt="" src="./imgs/allallinone.png">
<b> Swingup: </b> (pink measurement, yellow simulation)
Pink animation is generated from measurement from real device, near up pendulum arm position it is caught by stabilizaing controler. 
<img title="Finished pendulum" alt="" src="./imgs/swingupGif.gif">
<b> Down position control: </b>
<img title="Finished pendulum" alt="" src="./imgs/downControlGif.gif">
<b> Up position control: </b>
<img title="Finished pendulum" alt="" src="./imgs/upControlGif.gif">

<b> Phase portrait </b> from <em> imgs/phasePortraits/nonlinearModel</em> and <em>imgs/phasePortraits/LinearAndNonlinearModel</em>:
<img title="Finished pendulum" alt="" src="./imgs/phasePortraits/nonlinearModel/PFdxw0.jpg">
<img title="Finished pendulum" alt="" src="./imgs/phasePortraits/LinearAndNonlinearModel/PFdxw0_lin_d.jpg">
