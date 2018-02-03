using divand
using Base.Test
import Base.LinAlg.BLAS

@testset "divand" begin
    # ndgrid
    include("test_ndgrid.jl");

    include("test_covaris.jl");

    # conjugate gradient
    include("test_conjugategradient.jl");

    include("test_sparse_diff.jl");
    include("test_laplacian.jl");
    include("test_localize_separable_grid.jl");
    include("test_statevector.jl");

    include("test_diagnostic_tools.jl");

    include("test_1dvar.jl");
    include("test_1D_seminormed.jl");


    include("test_2dvar_adv.jl");
    include("test_2dvar_iter.jl");
    #include("test_2dvar_jog.jl");
    include("test_2dvar_error.jl");

    include("test_2dvar_all_masked.jl");

    # cross-validation
    include("test_2dvar_cv.jl");
    include("test_2dvar_matfun.jl");
    include("test_2dvar_qc.jl");

    include("test_2dvar_outside.jl");


    include("test_variableLandpmn.jl")

    include("test_3dvar.jl");

    include("test_4dvar.jl");

    # comparision with analytical kernels
    include("test_ndvar_point.jl");

    include("test_divandgo.jl");


    # test kernel
    include("test_kernel.jl");

    include("test_fzero.jl");

    # test 3D-var analysis
    include("test_varanalysis.jl");


    include("test_averaged_bg.jl");

    # SDN Vocabulary
    include("test_vocab.jl");

    # SDN ODVspreadsheet
    include("test_ODVspreadsheet.jl");

    # SDN metadata
    include("test_metadata.jl");

    # Saving data as NetCDF file
    include("test_save.jl");

    # Anamorphosis
    include("test_anam.jl");

    # Fitting covariance model
    include("test_select_time.jl");
    
    # Fitting covariance model
    include("test_fit.jl");

    # Test utility functions
    include("test_utils.jl");

    # Test utility functions
    include("test_obsstat.jl");
    
    # test divand_filter3
    A = zeros(5,5,5,5,5)
    A[3,3,3,3,3] = 1
    z = divand_filter3(A,9999,1)

    @test maximum(z) ≈ 0.00411522633744856

    # test divand_metric
    lon,lat = ndgrid([0:10;],[0:5;])
    pm,pn = divand_metric(lon,lat)
    @test 111e3 < mean(1./pm) < 112e3
    @test 111e3 < mean(1./pn) < 112e3

    # test divand_kernel
    mu,K,len_scale = divand_kernel(2,[1,2,1])
    @test mu ≈ 4π
    @test K(0) ≈ 1
    @test K(1) ≈ SpecialFunctions.besselk(1,1)
    @test K(len_scale) ≈ SpecialFunctions.besselk(1,1) atol=1e-6

    mu,K,len_scale = divand_kernel(2,[1,3,3,1])
    @test K(len_scale) ≈ SpecialFunctions.besselk(1,1) atol=1e-6

    mu,K,len_scale = divand_kernel(2,[0,3,3,1])
    @test K(len_scale) ≈ SpecialFunctions.besselk(1,1) atol=1e-6

end