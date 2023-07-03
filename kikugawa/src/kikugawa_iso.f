      program kikugawa
c
c     KIKUGAWA_ISO 
c      
c     (C) Dietmar Paschek 06/2023
c

      implicit none

      integer nargmax
      parameter (nargmax=10)
      
      integer i, narg
      integer hx, hy, hz, hmax
      integer kx, ky, kz, kmax
      double precision b, b2, rb2
      double precision alpha, alpha2, pi, pi2, nv, nv2
      double precision k2, vol
      double precision nsum, ksum, func1, func2

      character*256  arg(nargmax)

c-----

      pi=4.0d0*datan(1.0d0)
      pi2=pi*pi
      
      alpha=1.0d0

      hmax=10
      kmax=10
      b=1.0d0
      
      narg = 0
      do i=1,nargmax
         call getarg(i,arg(i))
         if (arg(i)(1:1).ne.' ') narg = narg + 1
      enddo

      do i=1,narg
         if (arg(i).eq.'-alpha') then
            read(arg(i+1),*) alpha
         endif
         if (arg(i).eq.'-b') then
            read(arg(i+1),*) b
         endif
         if (arg(i).eq.'-kmax') then
            read(arg(i+1),*) kmax
         endif
         if (arg(i).eq.'-hmax') then
            read(arg(i+1),*) hmax
         endif         
         
      enddo

      b2=b*b
      rb2=1.0d0/b2
      vol=b**3

      alpha2=alpha*alpha

      nsum=0.0d0
      do hx=-hmax, hmax
         do hy=-hmax, hmax
            do hz=-hmax, hmax
               
               nv2=b2*dble(hx**2+hy**2+hz**2)
               
               if (nv2.ne.0.0d0) then
                  nv=dsqrt(nv2)
                  nsum=nsum + derfc(alpha*nv)/nv
               endif
               
            enddo
         enddo
      enddo

      ksum=0.0d0
      do kx=-kmax, kmax
         do ky=-kmax, kmax
            do kz=-kmax, kmax

               k2=4.0d0*pi2*rb2*dble(kx**2+ky**2+kz**2)

               if (k2.ne.0.0d0) then
                  ksum=ksum + 4.0d0*dexp(-k2/(4.0d0*alpha2))/k2
               endif
               
            enddo
         enddo
      enddo
      ksum=ksum*pi/vol
      
      func1=pi/(alpha2*vol)
      func2=2.0d0*alpha/(dsqrt(pi))
      
c      print*, ksum
c      print*, nsum
c      print*, ksum, nsum, func1, func2
c      print*, nsum+ksum+func2+func1
c      print*, nsum+ksum-func1-func2
c      print*, (nsum+ksum-func1-func2)*b
      
      print*, '--------------------------------------------------------'      
      print*,' '
      print*,' KIKUGAWA ISO V 1.0        (C)  DP 06/2023'
      print*,' '
      print*, '--------------------------------------------------------'
      print*, ''
      print*, ' D_PBC = D_0 - k_B*T/(6*Pi*eta) * chi/b'
      print*, ''
      print*, ' Usage: '
      print*, ''
      print*, ' kikugawa_iso -alpha <alpha> ',
     .        '-b <b> -hmax <hmax> -kmax <kmax>'
      print*, ''
      print*, '--------------------------------------------------------'                  
      print*, '        Real space max inter index (h_max): ', hmax
      print*, 'Rec. lattice space max inter index (k_max): ', kmax
      print*, '               Convergence parameter alpha: ', alpha            

      print*, '--------------------------------------------------------'
      print*, '    b: ', b
      print*, 'chi/b: ',-1.0d0*(nsum+ksum-func1-func2)
      print*, '  chi: ',-1.0d0*(nsum+ksum-func1-func2)*b
      print*, '--------------------------------------------------------'
      
      end

