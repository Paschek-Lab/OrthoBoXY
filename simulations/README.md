
# Studied Systems using the OrthoBoXY approach
This folder contains input files for performing simulations of various systems using the OrthoBoXY approach and sytem sizes of 768, 1536, 3072 and 6144 molecules/ion pairs. The simulations were performed with the GROMACS 5.0.6 software package. All parameters different from default can be found in `SIMXX.mdp` while `sim1out.mdp` include all used parameters. For naming convention, please refer to the Gromacs-5.0.6-manual. The start configurations are stored in `START.gro`, the corresponding force field parameters can be found in `topol.top`. 

The studied systems are:
| System | NVT/NpT | $T$ / K | $p$ / bar | $\rho$ / g cm$`^{-3}`$ | Force Field |
| :--- | :---: | :---: | :---: | :---: | :---: |
| [TIP4P/2005](TIP4P2005/) | NVT and NpT | 298 | 1.0 | 0.9972 | [TIP4P/2005](https://doi.org/10.1063/1.2121687) |
| [Dimethyl Ether](Dimethylether/) | NpT | 303 | 50.0 | 0.6603 | [TraPPE-UA](https://doi.org/10.1021/jp049459w) |
| [Methanol](Methanol/) | NpT | 298 | 1.0 | 0.7882 | [OPLS/2016](https://doi.org/10.1063/1.4958320) |
| [Triglyme](Triglyme/) | NpT | 303 | 1.0 | 0.9760 | [modified TraPPE-UA](https://doi.org/10.1021/jp0765345) |
| [Methanol/Water 1:1](Methanol_Water/) | NpT | 298 | 1.0 | 0.98678 | [OPLS/2016](https://doi.org/10.1063/1.4958320) / [TIP4P/2005](https://doi.org/10.1063/1.2121687) |
| [Triglyme/Water 1:1](Triglyme_Water/) | NpT | 303 | 1.0 | 0.9947 | [modified TraPPE-UA](https://doi.org/10.1021/jp0765345) / [TIP4P/2005](https://doi.org/10.1063/1.2121687) |
| [[BMim][PF$_6$]](BMim_PF6/) | NpT | 350 | 1.0 | 1.3216 | [ILM2](https://doi.org/10.1021/jp108179n) |

The folder [TIP4P2005](TIP4P2005/) contains the input files for simulations according to the OrthoboXY approach as well as other files. If not indicated differently, the simulations are NVT simulations.
  - The subfolder [cubic/](TIP4P2005/cubic/) contains the input files for the cubic simulation boxes with system sizes 256, 512, 1024 and 2048 molecules, while the subfolder [orthoboxy/](TIP4P2005/orthoboxy/) contains the input files for MD simulations with system sizes of 768, 1536, 3072 and 6144 molecules using an orthorhombic unit cell with $L_z/L_x=L_z/L_y\approx 2.7933596497$
  - The subfolder [orthorhombic/](TIP4P2005/orthorhombic/) contains the input files for simulations with various orthorhombic simulation cells with $L_x\neq L_y \neq L_z$. All systems in this folder contain 1536 water molecules and fulfil the condition $\frac{L_y}{L_z} = \frac{L_x}{L_y}$. The corresponding start configurations are named according to the box-length ratio $\frac{L_y}{L_z}=XXX$ of the simulation cell as `START_lylzXXX.gro`.
