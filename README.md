# matRad_MKM-extension

This code is an extension of the open-source toolkit, matRad.
This extension enables the microdosimetric kinetic model (MKM) based biological dose calculation.

ANYONE can use this extension with no permission.
The redistribution strategy is affected by the GPLv3 license. Please check the License.md file.

You can use this extension by just replacing or adding the file into the matRad toolkit,
then it can be tested by the MKMtest script file.
For optimizing fluence based on MKM, a sequential process is depicted with a short description.

--------------------------------------------------------------------------------------------------------------------------------------------

This MKM extension is need to be optimized because it takes more memory and time for dose calculation and optimization than the default LEM model.
For reference, we provide information on memory consumption and calculating time, comparing the MKM extension to the default LEM model.

Given are run with PC(3x3x3cm3) and HPC server(6x6x6cm3) and each specifications are as follows:
PC - 11th Intel Core i7-1165G7 @2.80 GHz,16GB RAM / HPC server - Intel Xeon E5-2698 @2.20 GHz,131.7 RAM

In the case of the water phantom with the 3X3X3 cm3 target, the MKM extension consumes about 10GB memory but LEM 6GB when fluence is optimized.
Also, MKM extension takes time for dose calculation by 3 times longer than LEM(46 sec vs 12 sec) with laptop, and for fluence optimization, it takes time more than 20 times longer than LEM(508 sec vs 23 sec) .

In the case of the 6X6X6 cm3 target, 10 times more memory consumption in the MKM extension affects the dose calculation time similar to the memory consumption ratio.
To calculate the dose, LEM-based optimization takes about 50 s, but for MKM extension, it takes 630 s for fluence optimization.
The fluence optimization using LEM takes 127sec, but using MKM takes more than 12 hours.

During dose calculation, LEM consumes 8.5 GB memory but MKM consumes about 80 GB.
For optimization, LEM consumes 12 GB memory but MKM consumes about 117 GB.
In short, although there may be differences depending on the individual PC specification, memory usage may be about 10 times and calculation time may be 20 times or more, so when using matRad MKM extension with a PC, it can be used only in limited situations such as small targets.
We are trying to resolve the memory consumption problem because when we handle a large target, the extension cannot be used with a PC.

--------------------------------------------------------------------------------------------------------------------------------------------
