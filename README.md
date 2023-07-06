
# OrthoBoXY: A Simple Way to Compute True Self Diffusion Coefficients from MD Simulations with Periodic Boundary Conditions Without Prior Knowledge of the Viscosity

This repository contains a collection of input files and source code as described in the paper "OrthoBoXY: A Simple Way to Compute True Self Diffusion Coefficients from MD Simulations with Periodic Boundary Conditions Without Prior Knowledge of the Viscosity". The paper is currently under review and can be found on [arXiv](https://arxiv.org/abs/2307.01591).

The repository is structured as follows:
- [simulations](simulations/) : contains the required input files for the molecular dynamics simulations of TIP4P/2005 water at 298 K. The simulations were performed with the GROMACS 5.0.6 software package. If not indicated differently, the simulations are performed under NVT conditions at a temperature of 298 K and a density $\rho=0.9972$ g/cm$^3$. All parameters different from default can be found in `SIMXX.mdp` while `sim1out.mdp` include all used parameters. For naming convention, please refer to the Gromacs-5.0.6-manual. The start configurations are stored in `START.gro`, the corresponding force field parameters can be found in `topol.top`
    - The subfolder [simulations/cubic_box/](simulations/cubic_box/) contains the input files for the cubic simulation boxes with system sizes 256, 512, 1024 and 2048 molecules, while the subfolder [simulations/orthorhombic_box/](simulations/orthorhombic_box/) contains the input files for MD simulations with system sizes of 768, 1536, 3072 and 6144 molecules using an orthorhombic unit cell with $L_z/L_x=L_z/L_y\approx 2.7933596497$
  - The subfolder [simulations/orthorhombic_box/3072/NPT/](simulations/orthorhombic_box/3072/NPT/) contains the input files for the NPT simulations with 3072 molecules at a pressure of $P=1$ bar.

- [kikugawa/](kikugawa/) contains the Fortran source code and examples for the numerical calculation of the Madelung constant analogue $\zeta$ for the cubic and orthorhombic simulation boxes.
  - [src/](kikugawa/src) includes the Fortran source code for the isotropic and anisotropic calculation of the Madelung constant analogues $\zeta$, $\zeta_{xx}$, $\zeta_{yy}$, and $\zeta_{zz}$, for the cubic, and orthorhombic simulation boxes, respectively. The executetable files can be generated by running the `make` command in the corresponding subfolder.
  - [examples](kikugawa/examples/) contains 1 example for the isotropic and 2 examples for the anisotropic case, which can be found in the script [doit.sh](kikugawa/examples/doit.sh)
## Usage of the kikugawa program
The program `kikugawa` calculates the Madelung constant analogue $\zeta$ for the [cubic](kikugawa/src/kikugawa_iso.f) and [orthorhombic](kikugawa/src/kikugawa_aniso.f) simulation boxes. The program is based on the work of [Kikugawa et al.](https://pubs.aip.org/aip/jcp/article/143/2/024507/825372/Hydrodynamic-consideration-of-the-finite-size). The program can be compiled by running `make` in the corresponding subfolder. The program can be used in the following way:
### [Isotropic case](kikugawa/src/kikugawa_iso.f) - cubic simulation boxes
**command line options:**
-   `-l` : $L$ Box length of the cubic MD cell
-   `-alpha` $\alpha$ : Convergence parameter
-   `-hmax` : maximum range $m_\mathrm{max}$ of integers $m_\alpha$  with $-m_\mathrm{max} \leq m_\alpha \leq m_\mathrm{max}$ for the real lattice summation
-   `-kmax` : maximum range $m_\mathrm{max}$ of integers $m_\alpha$  with $-m_\mathrm{max} \leq m_\alpha \leq m_\mathrm{max}$ for the reciprocal lattice summation

**Return values:** The program returns the following value:
- `zeta` : $\zeta$ Madelung constant analogue of a cubic lattice

The self-diffusion coefficient for an infinity large system can be calculated by
$D_0=D_\mathrm{PBC}+\frac{k_B\cdot T}{6\pi \eta}\cdot\frac{\zeta}{l}$
  
**Usage:** `kikugawa_iso -alpha <alpha> -l <L> -hmax <hmax> -kmax <kmax>`

### [Anisotropic case](kikugawa/src/kikugawa_aniso.f) - orthorhombic simulation boxes

**command line options:**
-   `-lx` : $L_x$ Box length of the orthorhombic MD cell in x direction
-   `-ly` : $L_y$ Box length of the orthorhombic MD cell in y direction
-   `-lz` : $L_z$ Box length of the orthorhombic MD cell in z direction
-   `-alpha` $\alpha$ : Convergence parameter
-   `-hmax` : maximum range $m_\mathrm{max}$ of integers $m_\alpha$  with $-m_\mathrm{max} \leq m_\alpha \leq m_\mathrm{max}$ for the real lattice summation
-   `-kmax` : maximum range $m_\mathrm{max}$ of integers $m_\alpha$  with $-m_\mathrm{max} \leq m_\alpha \leq m_\mathrm{max}$ for the reciprocal lattice summation


**Return values:** The program returns the following values:
- `zeta_x`: $\zeta_x$ direction dependent Madelung constant analogue of the orthorhombic lattice in x direction
- `zeta_y`: $\zeta_y$ direction dependent Madelung constant analogue of the orthorhombic lattice in y direction
- `zeta_z`: $\zeta_z$ direction dependent Madelung constant analogue of the orthorhombic lattice in z direction

**Usage:** `kikugawa_aniso -alpha <alpha> -lx <Lx> -ly <Ly> -lz <Lz> -hmax <hmax> -kmax <kmax>`

The self-diffusion coefficient for an infinitely large system can be calculated by
$D_0=D_\mathrm{PBC,\alpha\alpha}+\frac{k_B\cdot T}{6\pi \eta}\cdot\frac{\zeta_{\alpha\alpha}}{l_\alpha}$ with $\alpha \in \{x,y,z\}$




For further information, please contact [the authors](mailto:dietmar.pascheck@uni-rostock.de).
