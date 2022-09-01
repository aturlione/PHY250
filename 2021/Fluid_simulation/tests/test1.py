from pysph.solver.application import Application
import pysph.tools.geometry as G
from pysph.base.utils import get_particle_array_wcsph
from pysph.sph.equation import Equation, Group
from pysph.sph.integrator_step import IntegratorStep
from pysph.sph.integrator import Integrator
from pysph.solver.solver import Solver
from pysph.base.kernels import CubicSpline

class DamBreak2D(Application):
    def create_particles(self):
        dx = 0.1
        xf, yf = G.get_2d_block(
            dx=dx, length=1.0, height=2.0, center=[-1.5+dx, 1+dx]
        )

        hdx = 1.2
        rho = 1000
        m = dx**2 * rho
        fluid = get_particle_array_wcsph(
            name='fluid', x=xf, y=yf, h=hdx*dx, m=m, rho=rho
         )

        xt, yt = G.get_2d_tank(
                dx=dx, length=4.0, height=4.0, num_layers=3
         )
        solid = get_particle_array_wcsph(
             name='solid', x=xt, y=yt, h=hdx*dx, m=m, rho=rho
         )
        return [fluid, solid]

    def create_equations(self):
        equations = [
            Group(equations=[
                TaitEOS(dest='fluid', sources=None,
                           rho0=1000, c0=10),
                   TaitEOS(dest='solid', sources=None,
                           rho0=1000, c0=10),
               ]),
            Group(equations=[
                ContinuityEquation(
                        dest='fluid', sources=['fluid', 'solid']
                ),
                ContinuityEquation(
                       dest='solid', sources=['fluid']
                ),
                MomentumEquation(
                       dest='fluid', sources=['fluid', 'solid']
                )
            ])
        ]
        return equations


    def create_solver(self):
        kernel = CubicSpline(dim=2)
        integrator = EulerIntegrator(
            fluid=EulerStep(), solid=EulerStep()
        )

        solver = Solver(
            kernel=kernel, dim=2, integrator=integrator,
            dt=2e-4, tf=1.0
        )
        return solver


class TaitEOS(Equation):
    def __init__(self, dest, sources, rho0, c0, gamma=7):
        self.rho0 = rho0
        self.gamma = gamma
        self.B = rho0*c0*c0/gamma
        super(TaitEOS, self).__init__(dest, sources)

    def initialize(self, d_idx, d_p, d_rho):
        tmp = pow(d_rho[d_idx]/self.rho0, self.gamma)
        d_p[d_idx] = self.B*(tmp - 1.0)
        
class ContinuityEquation(Equation):
    def initialize(self, d_idx, d_arho):
        d_arho[d_idx] = 0.0

    def loop(self, d_idx, d_arho, s_idx, s_m, DWIJ, VIJ):
        vijdotdwij = DWIJ[0]*VIJ[0] + DWIJ[1]*VIJ[1] + DWIJ[2]*VIJ[2]
        d_arho[d_idx] += s_m[s_idx]*vijdotdwij
    
class MomentumEquation(Equation):
    def initialize(self, d_idx, d_au, d_av, d_aw):
        d_au[d_idx] = 0.0
        d_av[d_idx] = -9.81
        d_aw[d_idx] = 0.0

    def loop(self, d_idx, s_idx, d_rho,
             d_p, d_au, d_av, d_aw, s_m,
             s_rho, s_p, VIJ, DWIJ):
        tmp = (d_p[d_idx]/(d_rho[d_idx]**2) +
               s_p[s_idx]/(s_rho[s_idx]**2))
        d_au[d_idx] += -s_m[s_idx] * tmp * DWIJ[0]
        d_av[d_idx] += -s_m[s_idx] * tmp * DWIJ[1]
        d_aw[d_idx] += -s_m[s_idx] * tmp * DWIJ[2]



class EulerIntegrator(Integrator):
    def one_timestep(self, t, dt):
        self.compute_accelerations()
        self.stage1()
        self.update_domain()
        self.do_post_stage(dt, 1)
        
class EulerStep(IntegratorStep):
    def stage1(self, d_idx, d_u, d_v, d_au, d_av, d_x, d_y,
               d_rho, d_arho, dt):
        d_u[d_idx] += dt*d_au[d_idx]
        d_v[d_idx] += dt*d_av[d_idx]

        d_x[d_idx] += dt*d_u[d_idx]
        d_y[d_idx] += dt*d_v[d_idx]

        d_rho[d_idx] += dt*d_arho[d_idx]
        
#print(DamBreak2D.create_particles(1000))
#print(DamBreak2D.create_equations(1000))
#print(DamBreak2D.create_solver(1000))
DamBreak2D().run()

    
