#running different configuraitons of tilted V

set tcl_precision 17

# Import the ParFlow TCL package
#
lappend auto_path $env(PARFLOW_DIR)/bin
package require parflow
namespace import Parflow::*

pfset FileVersion 4

set k  [lindex $argv 0]

#set rsx    [lindex $argv 0]
#set lsx    [expr (-1.0 * $rsx)]
#puts $rsx
#puts $lsx

pfset Process.Topology.P        2
pfset Process.Topology.Q        2
pfset Process.Topology.R        1

set runname "harmonic_k$k"
#set runname "replicatest.$i.$j"
file mkdir $runname
cd $runname
#---------------------------------------------------------
# Computational Grid
#---------------------------------------------------------
pfset ComputationalGrid.Lower.X           0.0
pfset ComputationalGrid.Lower.Y           0.0
pfset ComputationalGrid.Lower.Z           0.0

pfset ComputationalGrid.NX                31
pfset ComputationalGrid.NY                5
pfset ComputationalGrid.NZ                100

pfset ComputationalGrid.DX	             10.0
pfset ComputationalGrid.DY               10.0
pfset ComputationalGrid.DZ	             0.5

#---------------------------------------------------------
# The Names of the GeomInputs
#---------------------------------------------------------
pfset GeomInput.Names                 "domaininput leftinput rightinput channelinput"

pfset GeomInput.domaininput.GeomName  domain
pfset GeomInput.leftinput.GeomName  left
pfset GeomInput.rightinput.GeomName  right
pfset GeomInput.channelinput.GeomName  channel

pfset GeomInput.domaininput.InputType  Box
pfset GeomInput.leftinput.InputType  Box
pfset GeomInput.rightinput.InputType  Box
pfset GeomInput.channelinput.InputType  Box

#---------------------------------------------------------
# Domain Geometry
#---------------------------------------------------------
pfset Geom.domain.Lower.X                        0.0
pfset Geom.domain.Lower.Y                        0.0
pfset Geom.domain.Lower.Z                        0.0

pfset Geom.domain.Upper.X                        310.0
pfset Geom.domain.Upper.Y                        50.0
pfset Geom.domain.Upper.Z                        50.0
#was 0.05
pfset Geom.domain.Patches             "x-lower x-upper y-lower y-upper z-lower z-upper"

#---------------------------------------------------------
# Left Slope Geometry
#---------------------------------------------------------
pfset Geom.left.Lower.X                        0.0
pfset Geom.left.Lower.Y                        0.0
pfset Geom.left.Lower.Z                        0.0

pfset Geom.left.Upper.X                        150.0
pfset Geom.left.Upper.Y                        50.0
pfset Geom.left.Upper.Z                        50.0
#was 0.05

#---------------------------------------------------------
# Right Slope Geometry
#---------------------------------------------------------
pfset Geom.right.Lower.X                        160.0
pfset Geom.right.Lower.Y                        0.0
pfset Geom.right.Lower.Z                        0.0

pfset Geom.right.Upper.X                        310.0
pfset Geom.right.Upper.Y                        50.0
pfset Geom.right.Upper.Z                        50.0
#was 0.05
#---------------------------------------------------------
# Channel Geometry
#---------------------------------------------------------
pfset Geom.channel.Lower.X                        150.0
pfset Geom.channel.Lower.Y                        0.0
pfset Geom.channel.Lower.Z                        0.0

pfset Geom.channel.Upper.X                        160.0
pfset Geom.channel.Upper.Y                        50.0
pfset Geom.channel.Upper.Z                        50.0
#was 0.05

#-----------------------------------------------------------------------------
# Perm
#-----------------------------------------------------------------------------

pfset Geom.Perm.Names                 "domain"
pfset Geom.domain.Perm.Type            Constant
pfset Geom.domain.Perm.Value           $k
#1*10-8 m/s  -> m/d

pfset Perm.TensorType               TensorByGeom

pfset Geom.Perm.TensorByGeom.Names  "domain"

pfset Geom.domain.Perm.TensorValX  1.0d0
pfset Geom.domain.Perm.TensorValY  1.0d0
pfset Geom.domain.Perm.TensorValZ  1.0d0

#-----------------------------------------------------------------------------
# Specific Storage
#-----------------------------------------------------------------------------

pfset SpecificStorage.Type            Constant
pfset SpecificStorage.GeomNames       "domain"
pfset Geom.domain.SpecificStorage.Value 1.0e-4

#-----------------------------------------------------------------------------
# Phases
#-----------------------------------------------------------------------------

pfset Phase.Names "water"

pfset Phase.water.Density.Type	        Constant
pfset Phase.water.Density.Value	        1.0

pfset Phase.water.Viscosity.Type	     Constant
pfset Phase.water.Viscosity.Value	      1.0

#-----------------------------------------------------------------------------
# Contaminants
#-----------------------------------------------------------------------------

pfset Contaminants.Names			""

#-----------------------------------------------------------------------------
# Retardation
#-----------------------------------------------------------------------------

pfset Geom.Retardation.GeomNames           ""

#-----------------------------------------------------------------------------
# Gravity
#-----------------------------------------------------------------------------

pfset Gravity				1.0

#-----------------------------------------------------------------------------
# Setup timing info
#-----------------------------------------------------------------------------
#pfset TimingInfo.BaseUnit        0.05
#pfset TimingInfo.StartCount      0
#pfset TimingInfo.StartTime       0.0
#pfset TimingInfo.StopTime        2.0
#pfset TimingInfo.DumpInterval    -2
#pfset TimeStep.Type              Constant
#pfset TimeStep.Value             0.05
#original timeing info above

pfset TimingInfo.BaseUnit        1
pfset TimingInfo.StartCount      0
pfset TimingInfo.StartTime       0.0
pfset TimingInfo.StopTime        9999.0
pfset TimingInfo.DumpInterval    -1
pfset TimeStep.Type              Constant
pfset TimeStep.Value             1

#-----------------------------------------------------------------------------
# Porosity
#-----------------------------------------------------------------------------

pfset Geom.Porosity.GeomNames          "domain"
pfset Geom.domain.Porosity.Type          Constant
pfset Geom.domain.Porosity.Value         0.35

#-----------------------------------------------------------------------------
# Domain
#-----------------------------------------------------------------------------

pfset Domain.GeomName domain

#-----------------------------------------------------------------------------
# Relative Permeability
#-----------------------------------------------------------------------------

pfset Phase.RelPerm.Type               VanGenuchten
pfset Phase.RelPerm.GeomNames          "domain"

pfset Geom.domain.RelPerm.Alpha         6.0
pfset Geom.domain.RelPerm.N             2.

#---------------------------------------------------------
# Saturation
#---------------------------------------------------------

pfset Phase.Saturation.Type              VanGenuchten
pfset Phase.Saturation.GeomNames         "domain"

pfset Geom.domain.Saturation.Alpha        6.0
pfset Geom.domain.Saturation.N            2.
pfset Geom.domain.Saturation.SRes         0.2
pfset Geom.domain.Saturation.SSat         1.0

#-----------------------------------------------------------------------------
# Wells
#-----------------------------------------------------------------------------
pfset Wells.Names                           ""

#-----------------------------------------------------------------------------
# Time Cycles
#-----------------------------------------------------------------------------
pfset Cycle.Names "constant rainrec"
pfset Cycle.constant.Names              "alltime"
pfset Cycle.constant.alltime.Length      1
pfset Cycle.constant.Repeat             -1

# rainfall and recession time periods are defined here
# rain for 1 hour, recession for 2 hours

pfset Cycle.rainrec.Names                 "rain rec"
pfset Cycle.rainrec.rain.Length           1
#pfset Cycle.rainrec.rec.Length            300
pfset Cycle.rainrec.rec.Length            3
pfset Cycle.rainrec.Repeat                -1




#-----------------------------------------------------------------------------
# Boundary Conditions: Pressure
#-----------------------------------------------------------------------------
pfset BCPressure.PatchNames                   [pfget Geom.domain.Patches]

pfset Patch.x-lower.BCPressure.Type		      FluxConst
pfset Patch.x-lower.BCPressure.Cycle		      "constant"
pfset Patch.x-lower.BCPressure.alltime.Value	      0.0

pfset Patch.y-lower.BCPressure.Type		      FluxConst
pfset Patch.y-lower.BCPressure.Cycle		      "constant"
pfset Patch.y-lower.BCPressure.alltime.Value	      0.0

pfset Patch.z-lower.BCPressure.Type		      FluxConst
pfset Patch.z-lower.BCPressure.Cycle		      "constant"
pfset Patch.z-lower.BCPressure.alltime.Value	      0.0

pfset Patch.x-upper.BCPressure.Type		      FluxConst
pfset Patch.x-upper.BCPressure.Cycle		      "constant"
pfset Patch.x-upper.BCPressure.alltime.Value	      0.0

pfset Patch.y-upper.BCPressure.Type		      FluxConst
pfset Patch.y-upper.BCPressure.Cycle		      "constant"
pfset Patch.y-upper.BCPressure.alltime.Value	      0.0

## overland flow boundary condition with very heavy rainfall
pfset Patch.z-upper.BCPressure.Type		      OverlandFlow
#pfset Patch.z-upper.BCPressure.Type		      FluxFile
pfset Patch.z-upper.BCPressure.Cycle		      "constant"
#pfset Patch.z-upper.BCPressure.alltime.FileName	   "/Users/abramfarley/ParF/uahpc/TimeSynth/force_inputs/forcing_input.00000.pfb"
pfset Patch.z-upper.BCPressure.alltime.Value	      0.0

#pfset Patch.z-upper.BCPressure.rec.Value	      0.0000

#---------------------------------------------------------
# Mannings coefficient
#---------------------------------------------------------

pfset Mannings.Type "Constant"
pfset Mannings.GeomNames "domain"
pfset Mannings.Geom.domain.Value 3.e-6


#-----------------------------------------------------------------------------
# Phase sources:
#-----------------------------------------------------------------------------

pfset PhaseSources.water.Type                         Constant
pfset PhaseSources.water.GeomNames                    domain
pfset PhaseSources.water.Geom.domain.Value        0.0

#-----------------------------------------------------------------------------
# Exact solution specification for error calculations
#-----------------------------------------------------------------------------

pfset KnownSolution                                    NoKnownSolution

#-----------------------------------------------------------------------------
# Set solver parameters
#-----------------------------------------------------------------------------

pfset Solver                                             Richards
pfset Solver.MaxIter                                     25000

pfset Solver.Nonlinear.MaxIter                          1000
pfset Solver.Nonlinear.ResidualTol                       1e-9
pfset Solver.Nonlinear.EtaChoice                         EtaConstant
pfset Solver.Nonlinear.EtaValue                          0.01
pfset Solver.Nonlinear.UseJacobian                       False
pfset Solver.Nonlinear.DerivativeEpsilon                 1e-15
pfset Solver.Nonlinear.StepTol				                   1e-20
pfset Solver.Nonlinear.Globalization                     LineSearch
pfset Solver.Linear.KrylovDimension                      50
pfset Solver.Linear.MaxRestart                           2
pfset Solver.OverlandKinematic.Epsilon                  1E-5


pfset Solver.Linear.Preconditioner                       PFMG
pfset Solver.PrintSubsurf				                         False
pfset  Solver.Drop                                      1E-20
pfset Solver.AbsTol                                     1E-10

pfset Solver.TerrainFollowingGrid                        True
pfset Solver.WriteSiloSubsurfData                       True
pfset Solver.WriteSiloPressure                          False
pfset Solver.WriteSiloSlopes                            True
pfset Solver.WriteSiloMannings                          True
pfset Solver.WriteSiloSaturation                        False
pfset Solver.WriteSiloConcentration                     False
#pfset Solver.WriteSiloMask                              True

##EvapTransFile
#pfset Solver.EvapTransFile              True
pfset Solver.EvapTransFileTransient     True
pfset Solver.EvapTrans.FileName   "../harmonic_inputs/harmonic_input"

#---------------------------------------------------------
# Initial conditions: water pressure
#---------------------------------------------------------

# set water table to be at the bottom of the domain, the top layer is initially dry
pfset ICPressure.Type                                   PFBFile
pfset ICPressure.GeomNames                              domain
pfset Geom.domain.ICPressure.RefPatch                   z-lower

pfset Geom.domain.ICPressure.FileName                 "/Users/abramfarley/ParF/uahpc/matching_inputs/over0.4freq_hn/variable_k/ensemble/initial_pressures/spinup_k$k.out.press.00010.pfb"


#-----------------------------------------------------------------------------
# Run and Unload the ParFlow output files
#-----------------------------------------------------------------------------
#set runcheck to 1 if you want to run the pass fail tests
#set runcheck 1
#source pftest.tcl

pfset TopoSlopesX.Type "Constant"
pfset TopoSlopesX.GeomNames "left right channel"
pfset TopoSlopesX.Geom.left.Value -0.05
pfset TopoSlopesX.Geom.right.Value 0.05
pfset TopoSlopesX.Geom.channel.Value 0.0

pfset TopoSlopesY.Type "Constant"
pfset TopoSlopesY.GeomNames "domain"
pfset TopoSlopesY.Geom.domain.Value 0.01

# run with KWE upwinding
pfset Patch.z-upper.BCPressure.Type		      OverlandKinematic
pfset Solver.Nonlinear.UseJacobian                       True
pfset Solver.Linear.Preconditioner.PCMatrixType PFSymmetric

#set runname "TiltedV"
puts "##########"
puts $runname

pfdist  "/Users/abramfarley/ParF/uahpc/matching_inputs/over0.4freq_hn/variable_k/ensemble/initial_pressures/spinup_k$k.out.press.00010.pfb"
#pfdist "/Users/abramfarley/ParF/uahpc/RK_ratios_dxdy10/initial_pressures/initial_press$rsx.pfb"

for {set itime 0} {$itime < 10000 } { incr itime 1} {
  pfdist [format "../harmonic_inputs/harmonic_input.%05d.pfb" $itime]}


pfrun $runname
pfundist $runname
puts "ParFlow run Complete"
