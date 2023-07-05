      program kikugawa
c
c     KIKUGAWA_ANISO 
c      
c     (C) Dietmar Paschek 06/2023
c
      
      implicit none

      integer nargmax
      parameter (nargmax=20)
      
      integer i, narg
      integer hx, hy, hz, hmax
      integer kx, ky, kz, kmax
      double precision bx, by, bz, bx2, by2, bz2, rbx2, rby2, rbz2
      double precision alpha, alpha2, pi, pi2, nv, nv2, k2, vol
      double precision nxsum, nysum, nzsum, kxsum, kysum, kzsum
      double precision func, func1, func2, fac

      character*256  arg(nargmax)

c-----

      pi=4.0d0*datan(1.0d0)
      pi2=pi*pi
      
      alpha=1.0d0

      hmax=20
      kmax=20
      
      bx=1.0d0
      by=1.0d0
      bz=1.0d0      
      
      narg = 0
      do i=1,nargmax
         call getarg(i,arg(i))
         if (arg(i)(1:1).ne.' ') narg = narg + 1
      enddo

      do i=1,narg
         if (arg(i).eq.'-alpha') then
            read(arg(i+1),*) alpha
         endif
         if (arg(i).eq.'-lx') then
            read(arg(i+1),*) bx
         endif
         if (arg(i).eq.'-ly') then
            read(arg(i+1),*) by
         endif
         if (arg(i).eq.'-lz') then
            read(arg(i+1),*) bz
         endif         
         if (arg(i).eq.'-kmax') then
            read(arg(i+1),*) kmax
         endif
         if (arg(i).eq.'-hmax') then
            read(arg(i+1),*) hmax
         endif         
      enddo

      bx2=bx**2
      by2=by**2
      bz2=bz**2      

      rbx2=1.0d0/bx2
      rby2=1.0d0/by2
      rbz2=1.0d0/bz2      

      vol=bx*by*bz
      
      alpha2=alpha*alpha
      fac=2.0d0*alpha/dsqrt(pi)
      
      nxsum=0.0d0
      nysum=0.0d0
      nzsum=0.0d0
      do hx=-hmax, hmax
         do hy=-hmax, hmax
            do hz=-hmax, hmax
               
               nv2 = bx2*dble(hx**2)
     .             + by2*dble(hy**2)
     .             + bz2*dble(hz**2)

               if (nv2.ne.0.0d0) then

                  nv=dsqrt(nv2)
                  func=derfc(alpha*nv)/nv
                  func1=dexp(-alpha2*nv2)
                  
                  nxsum=nxsum + func + 
     .                 bx2*hx**2/nv2*(func+fac*func1)

                  nysum=nysum + func +
     .                 by2*hy**2/nv2*(func+fac*func1)

                  nzsum=nzsum+ func + 
     .                 bz2*hz**2/nv2*(func+fac*func1)

               endif
               
            enddo
         enddo
      enddo
      nxsum=nxsum*0.5d0
      nysum=nysum*0.5d0
      nzsum=nzsum*0.5d0

      kxsum=0.0d0
      kysum=0.0d0
      kzsum=0.0d0      
      do kx=-kmax, kmax
         do ky=-kmax, kmax
            do kz=-kmax, kmax

               k2=4.0d0*pi2*rbx2*kx**2
     .           +4.0d0*pi2*rby2*ky**2
     .           +4.0d0*pi2*rbz2*kz**2               

               if (k2.ne.0.0d0) then
                  
                  func=dexp(-k2/(4.0d0*alpha2))/k2

                  kxsum=kxsum + 
     .                 4.0d0*func -
     .                 func/alpha2*4.0d0*pi2*rbx2*kx**2
     .                 *(1.0d0+4.0d0*alpha2/k2)

                  kysum=kysum +
     .                 4.0d0*func -
     .                 func/alpha2*4.0d0*pi2*rby2*ky**2
     .                 *(1.0d0+4.0d0*alpha2/k2)

                  kzsum=kzsum +
     .                 4.0d0*func -
     .                 func/alpha2*4.0d0*pi2*rbz2*kz**2
     .                 *(1.0d0+4.0d0*alpha2/k2)
                  
               endif
               
            enddo
         enddo
      enddo
      kxsum=kxsum*pi/vol
      kysum=kysum*pi/vol
      kzsum=kzsum*pi/vol      
      
      func1=pi/(alpha2*vol)
      func2=alpha/(dsqrt(pi))

      print*, '--------------------------------------------------------'      
      print*,' '
      print*,' KIKUGAWA ANISO V 1.0        (C)  DP 06/2023'
      print*,' '
      print*, '--------------------------------------------------------'
      print*, ''
      print*, ' D_PBC_i = D_0 - k_B*T/(6*Pi*eta) * zeta_i/L_i'
      print*, '       i = {x,y,z}'
      print*, ''
      print*, ' Usage: '
      print*, ''
      print*, ' kikugawa_aniso -alpha <alpha> ',
     .        '-lx <Lx> -ly <Ly> -lz <Lz> -hmax <hmax> -kmax <kmax>'
      print*, ''
      print*, '--------------------------------------------------------'                  

      print*, '        Real space max inter index (h_max): ', hmax
      print*, 'Rec. lattice space max inter index (k_max): ', kmax
      print*, '               Convergence parameter alpha: ', alpha            

      print*, '--------------------------------------------------------'                        
      print*, 'L_x: ', bx
      print*, 'L_y: ', by
      print*, 'L_z: ', bz      

      print*, '---'
      
      print*, 'zeta_x/L_x: ',-(nxsum+kxsum-func1-func2)*1.50d0
      print*, 'zeta_y/L_y: ',-(nysum+kysum-func1-func2)*1.50d0
      print*, 'zeta_z/L_z: ',-(nzsum+kzsum-func1-func2)*1.50d0

      print*, '---'

      print*, 'zeta_x: ', -( nxsum+kxsum-func1-func2)*bx*1.50d0
      print*, 'zeta_y: ', -( nysum+kysum-func1-func2)*by*1.50d0
      print*, 'zeta_z: ', -( nzsum+kzsum-func1-func2)*bz*1.50d0

      print*, '--------------------------------------------------------'                        
      end

