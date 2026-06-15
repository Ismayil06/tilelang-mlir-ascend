// -----// IR Dump Before AppendTargetDeviceSpec (hacc-append-device-spec) //----- //
module attributes {hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
    %c1_i32 = arith.constant 1 : i32
    %0 = arith.index_cast %c1_i32 : i32 to index
    %c512_i32 = arith.constant 512 : i32
    %1 = arith.muli %c512_i32, %c1_i32 : i32
    %2 = arith.index_cast %1 : i32 to index
    %c8_i32 = arith.constant 8 : i32
    %3 = arith.muli %c8_i32, %1 : i32
    %4 = arith.index_cast %3 : i32 to index
    %c128_i32 = arith.constant 128 : i32
    %5 = arith.muli %c128_i32, %3 : i32
    %6 = arith.index_cast %5 : i32 to index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%6, %4, %2, %0] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %7 = arith.muli %c8_i32, %c1_i32 : i32
    %8 = arith.index_cast %7 : i32 to index
    %9 = arith.muli %c128_i32, %7 : i32
    %10 = arith.index_cast %9 : i32 to index
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%10, %8, %0] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%6, %4, %2, %0] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %11 = hivm.hir.get_block_idx -> i64
    %12 = arith.trunci %11 : i64 to i32
    %c0_i32 = arith.constant 0 : i32
    %c1_i32_2 = arith.constant 1 : i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32_2  : i32 {
      %13 = tensor.empty() : tensor<32x1xf32>
      %14 = tensor.empty() : tensor<32x32xf32>
      %c0_i32_3 = arith.constant 0 : i32
      %15 = arith.sitofp %c0_i32_3 : i32 to f32
      %16 = linalg.fill ins(%15 : f32) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %c16_i32 = arith.constant 16 : i32
      %c1_i32_4 = arith.constant 1 : i32
      %17 = scf.for %arg12 = %c0_i32_3 to %c16_i32 step %c1_i32_4 iter_args(%arg13 = %16) -> (tensor<32x32xf32>)  : i32 {
        %18 = tensor.empty() : tensor<32x32xf32>
        %19 = tensor.empty() : tensor<32x32xf32>
        %20 = tensor.empty() : tensor<32x32xbf16>
        %21 = tensor.empty() : tensor<32x32xbf16>
        %22 = tensor.empty() : tensor<32x32xf32>
        %c32_i32_7 = arith.constant 32 : i32
        %23 = arith.divsi %12, %c32_i32_7 : i32
        %24 = arith.index_cast %23 : i32 to index
        %25 = arith.remsi %12, %c32_i32_7 : i32
        %c8_i32_8 = arith.constant 8 : i32
        %26 = arith.divsi %25, %c8_i32_8 : i32
        %27 = arith.muli %26, %c32_i32_7 : i32
        %28 = arith.index_cast %27 : i32 to index
        %29 = arith.index_cast %arg11 : i32 to index
        %30 = arith.muli %arg12, %c32_i32_7 : i32
        %31 = arith.index_cast %30 : i32 to index
        %subview = memref.subview %reinterpret_cast[%24, %28, %29, %31] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %32 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %expanded_9 = tensor.expand_shape %32 [[0], [1]] output_shape [32, 32] : tensor<32x32xbf16> into tensor<32x32xbf16>
        %inserted_slice_10 = tensor.insert_slice %expanded_9 into %20[0, 0] [32, 32] [1, 1] : tensor<32x32xbf16> into tensor<32x32xbf16>
        %33 = tensor.empty() : tensor<32x32xbf16>
        %34 = tensor.empty() : tensor<32x32xf32>
        %35 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%inserted_slice_10 : tensor<32x32xbf16>) outs(%34 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_11 = memref.subview %reinterpret_cast_1[%24, %28, %29, %31] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_12 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_11, %alloc_12 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %36 = bufferization.to_tensor %alloc_12 restrict : memref<32x32xbf16>
        %expanded_13 = tensor.expand_shape %36 [[0], [1]] output_shape [32, 32] : tensor<32x32xbf16> into tensor<32x32xbf16>
        %inserted_slice_14 = tensor.insert_slice %expanded_13 into %21[0, 0] [32, 32] [1, 1] : tensor<32x32xbf16> into tensor<32x32xbf16>
        %37 = tensor.empty() : tensor<32x32xbf16>
        %38 = tensor.empty() : tensor<32x32xf32>
        %39 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%inserted_slice_14 : tensor<32x32xbf16>) outs(%38 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %40 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%35, %39 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%22 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %41 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %40 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %41 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %13 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%17 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %18 = arith.addf %in, %init : f32
          linalg.yield %18 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      %expanded_5 = tensor.expand_shape %expanded [[0], [1]] output_shape [32, 1] : tensor<32x1xf32> into tensor<32x1xf32>
      %inserted_slice = tensor.insert_slice %expanded_5 into %13[0, 0] [32, 1] [1, 1] : tensor<32x1xf32> into tensor<32x1xf32>
      %c32_i32 = arith.constant 32 : i32
      %c1_i32_6 = arith.constant 1 : i32
      scf.for %arg12 = %c0_i32_3 to %c32_i32 step %c1_i32_6  : i32 {
        %18 = arith.index_cast %arg12 : i32 to index
        %c0_i32_7 = arith.constant 0 : i32
        %19 = arith.index_cast %c0_i32_7 : i32 to index
        %extracted = tensor.extract %inserted_slice[%18, %19] : tensor<32x1xf32>
        %c32_i32_8 = arith.constant 32 : i32
        %20 = arith.divsi %12, %c32_i32_8 : i32
        %21 = arith.index_cast %20 : i32 to index
        %22 = arith.remsi %12, %c32_i32_8 : i32
        %c8_i32_9 = arith.constant 8 : i32
        %23 = arith.divsi %22, %c8_i32_9 : i32
        %24 = arith.muli %23, %c32_i32_8 : i32
        %25 = arith.addi %24, %arg12 : i32
        %26 = arith.index_cast %25 : i32 to index
        %27 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%21, %26, %27] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After AppendTargetDeviceSpec (hacc-append-device-spec) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
    %c1_i32 = arith.constant 1 : i32
    %0 = arith.index_cast %c1_i32 : i32 to index
    %c512_i32 = arith.constant 512 : i32
    %1 = arith.muli %c512_i32, %c1_i32 : i32
    %2 = arith.index_cast %1 : i32 to index
    %c8_i32 = arith.constant 8 : i32
    %3 = arith.muli %c8_i32, %1 : i32
    %4 = arith.index_cast %3 : i32 to index
    %c128_i32 = arith.constant 128 : i32
    %5 = arith.muli %c128_i32, %3 : i32
    %6 = arith.index_cast %5 : i32 to index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%6, %4, %2, %0] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %7 = arith.muli %c8_i32, %c1_i32 : i32
    %8 = arith.index_cast %7 : i32 to index
    %9 = arith.muli %c128_i32, %7 : i32
    %10 = arith.index_cast %9 : i32 to index
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%10, %8, %0] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%6, %4, %2, %0] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %11 = hivm.hir.get_block_idx -> i64
    %12 = arith.trunci %11 : i64 to i32
    %c0_i32 = arith.constant 0 : i32
    %c1_i32_2 = arith.constant 1 : i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32_2  : i32 {
      %13 = tensor.empty() : tensor<32x1xf32>
      %14 = tensor.empty() : tensor<32x32xf32>
      %c0_i32_3 = arith.constant 0 : i32
      %15 = arith.sitofp %c0_i32_3 : i32 to f32
      %16 = linalg.fill ins(%15 : f32) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %c16_i32 = arith.constant 16 : i32
      %c1_i32_4 = arith.constant 1 : i32
      %17 = scf.for %arg12 = %c0_i32_3 to %c16_i32 step %c1_i32_4 iter_args(%arg13 = %16) -> (tensor<32x32xf32>)  : i32 {
        %18 = tensor.empty() : tensor<32x32xf32>
        %19 = tensor.empty() : tensor<32x32xf32>
        %20 = tensor.empty() : tensor<32x32xbf16>
        %21 = tensor.empty() : tensor<32x32xbf16>
        %22 = tensor.empty() : tensor<32x32xf32>
        %c32_i32_7 = arith.constant 32 : i32
        %23 = arith.divsi %12, %c32_i32_7 : i32
        %24 = arith.index_cast %23 : i32 to index
        %25 = arith.remsi %12, %c32_i32_7 : i32
        %c8_i32_8 = arith.constant 8 : i32
        %26 = arith.divsi %25, %c8_i32_8 : i32
        %27 = arith.muli %26, %c32_i32_7 : i32
        %28 = arith.index_cast %27 : i32 to index
        %29 = arith.index_cast %arg11 : i32 to index
        %30 = arith.muli %arg12, %c32_i32_7 : i32
        %31 = arith.index_cast %30 : i32 to index
        %subview = memref.subview %reinterpret_cast[%24, %28, %29, %31] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %32 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %expanded_9 = tensor.expand_shape %32 [[0], [1]] output_shape [32, 32] : tensor<32x32xbf16> into tensor<32x32xbf16>
        %inserted_slice_10 = tensor.insert_slice %expanded_9 into %20[0, 0] [32, 32] [1, 1] : tensor<32x32xbf16> into tensor<32x32xbf16>
        %33 = tensor.empty() : tensor<32x32xbf16>
        %34 = tensor.empty() : tensor<32x32xf32>
        %35 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%inserted_slice_10 : tensor<32x32xbf16>) outs(%34 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_11 = memref.subview %reinterpret_cast_1[%24, %28, %29, %31] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_12 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_11, %alloc_12 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %36 = bufferization.to_tensor %alloc_12 restrict : memref<32x32xbf16>
        %expanded_13 = tensor.expand_shape %36 [[0], [1]] output_shape [32, 32] : tensor<32x32xbf16> into tensor<32x32xbf16>
        %inserted_slice_14 = tensor.insert_slice %expanded_13 into %21[0, 0] [32, 32] [1, 1] : tensor<32x32xbf16> into tensor<32x32xbf16>
        %37 = tensor.empty() : tensor<32x32xbf16>
        %38 = tensor.empty() : tensor<32x32xf32>
        %39 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%inserted_slice_14 : tensor<32x32xbf16>) outs(%38 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %40 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%35, %39 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%22 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %41 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %40 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %41 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %13 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%17 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %18 = arith.addf %in, %init : f32
          linalg.yield %18 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      %expanded_5 = tensor.expand_shape %expanded [[0], [1]] output_shape [32, 1] : tensor<32x1xf32> into tensor<32x1xf32>
      %inserted_slice = tensor.insert_slice %expanded_5 into %13[0, 0] [32, 1] [1, 1] : tensor<32x1xf32> into tensor<32x1xf32>
      %c32_i32 = arith.constant 32 : i32
      %c1_i32_6 = arith.constant 1 : i32
      scf.for %arg12 = %c0_i32_3 to %c32_i32 step %c1_i32_6  : i32 {
        %18 = arith.index_cast %arg12 : i32 to index
        %c0_i32_7 = arith.constant 0 : i32
        %19 = arith.index_cast %c0_i32_7 : i32 to index
        %extracted = tensor.extract %inserted_slice[%18, %19] : tensor<32x1xf32>
        %c32_i32_8 = arith.constant 32 : i32
        %20 = arith.divsi %12, %c32_i32_8 : i32
        %21 = arith.index_cast %20 : i32 to index
        %22 = arith.remsi %12, %c32_i32_8 : i32
        %c8_i32_9 = arith.constant 8 : i32
        %23 = arith.divsi %22, %c8_i32_9 : i32
        %24 = arith.muli %23, %c32_i32_8 : i32
        %25 = arith.addi %24, %arg12 : i32
        %26 = arith.index_cast %25 : i32 to index
        %27 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%21, %26, %27] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before CanonicalizeModule (canonicalize-module) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
    %c1_i32 = arith.constant 1 : i32
    %0 = arith.index_cast %c1_i32 : i32 to index
    %c512_i32 = arith.constant 512 : i32
    %1 = arith.muli %c512_i32, %c1_i32 : i32
    %2 = arith.index_cast %1 : i32 to index
    %c8_i32 = arith.constant 8 : i32
    %3 = arith.muli %c8_i32, %1 : i32
    %4 = arith.index_cast %3 : i32 to index
    %c128_i32 = arith.constant 128 : i32
    %5 = arith.muli %c128_i32, %3 : i32
    %6 = arith.index_cast %5 : i32 to index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%6, %4, %2, %0] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %7 = arith.muli %c8_i32, %c1_i32 : i32
    %8 = arith.index_cast %7 : i32 to index
    %9 = arith.muli %c128_i32, %7 : i32
    %10 = arith.index_cast %9 : i32 to index
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%10, %8, %0] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%6, %4, %2, %0] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %11 = hivm.hir.get_block_idx -> i64
    %12 = arith.trunci %11 : i64 to i32
    %c0_i32 = arith.constant 0 : i32
    %c1_i32_2 = arith.constant 1 : i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32_2  : i32 {
      %13 = tensor.empty() : tensor<32x1xf32>
      %14 = tensor.empty() : tensor<32x32xf32>
      %c0_i32_3 = arith.constant 0 : i32
      %15 = arith.sitofp %c0_i32_3 : i32 to f32
      %16 = linalg.fill ins(%15 : f32) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %c16_i32 = arith.constant 16 : i32
      %c1_i32_4 = arith.constant 1 : i32
      %17 = scf.for %arg12 = %c0_i32_3 to %c16_i32 step %c1_i32_4 iter_args(%arg13 = %16) -> (tensor<32x32xf32>)  : i32 {
        %18 = tensor.empty() : tensor<32x32xf32>
        %19 = tensor.empty() : tensor<32x32xf32>
        %20 = tensor.empty() : tensor<32x32xbf16>
        %21 = tensor.empty() : tensor<32x32xbf16>
        %22 = tensor.empty() : tensor<32x32xf32>
        %c32_i32_7 = arith.constant 32 : i32
        %23 = arith.divsi %12, %c32_i32_7 : i32
        %24 = arith.index_cast %23 : i32 to index
        %25 = arith.remsi %12, %c32_i32_7 : i32
        %c8_i32_8 = arith.constant 8 : i32
        %26 = arith.divsi %25, %c8_i32_8 : i32
        %27 = arith.muli %26, %c32_i32_7 : i32
        %28 = arith.index_cast %27 : i32 to index
        %29 = arith.index_cast %arg11 : i32 to index
        %30 = arith.muli %arg12, %c32_i32_7 : i32
        %31 = arith.index_cast %30 : i32 to index
        %subview = memref.subview %reinterpret_cast[%24, %28, %29, %31] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %32 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %expanded_9 = tensor.expand_shape %32 [[0], [1]] output_shape [32, 32] : tensor<32x32xbf16> into tensor<32x32xbf16>
        %inserted_slice_10 = tensor.insert_slice %expanded_9 into %20[0, 0] [32, 32] [1, 1] : tensor<32x32xbf16> into tensor<32x32xbf16>
        %33 = tensor.empty() : tensor<32x32xbf16>
        %34 = tensor.empty() : tensor<32x32xf32>
        %35 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%inserted_slice_10 : tensor<32x32xbf16>) outs(%34 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_11 = memref.subview %reinterpret_cast_1[%24, %28, %29, %31] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_12 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_11, %alloc_12 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %36 = bufferization.to_tensor %alloc_12 restrict : memref<32x32xbf16>
        %expanded_13 = tensor.expand_shape %36 [[0], [1]] output_shape [32, 32] : tensor<32x32xbf16> into tensor<32x32xbf16>
        %inserted_slice_14 = tensor.insert_slice %expanded_13 into %21[0, 0] [32, 32] [1, 1] : tensor<32x32xbf16> into tensor<32x32xbf16>
        %37 = tensor.empty() : tensor<32x32xbf16>
        %38 = tensor.empty() : tensor<32x32xf32>
        %39 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%inserted_slice_14 : tensor<32x32xbf16>) outs(%38 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %40 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%35, %39 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%22 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %41 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %40 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %41 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %13 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%17 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %18 = arith.addf %in, %init : f32
          linalg.yield %18 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      %expanded_5 = tensor.expand_shape %expanded [[0], [1]] output_shape [32, 1] : tensor<32x1xf32> into tensor<32x1xf32>
      %inserted_slice = tensor.insert_slice %expanded_5 into %13[0, 0] [32, 1] [1, 1] : tensor<32x1xf32> into tensor<32x1xf32>
      %c32_i32 = arith.constant 32 : i32
      %c1_i32_6 = arith.constant 1 : i32
      scf.for %arg12 = %c0_i32_3 to %c32_i32 step %c1_i32_6  : i32 {
        %18 = arith.index_cast %arg12 : i32 to index
        %c0_i32_7 = arith.constant 0 : i32
        %19 = arith.index_cast %c0_i32_7 : i32 to index
        %extracted = tensor.extract %inserted_slice[%18, %19] : tensor<32x1xf32>
        %c32_i32_8 = arith.constant 32 : i32
        %20 = arith.divsi %12, %c32_i32_8 : i32
        %21 = arith.index_cast %20 : i32 to index
        %22 = arith.remsi %12, %c32_i32_8 : i32
        %c8_i32_9 = arith.constant 8 : i32
        %23 = arith.divsi %22, %c8_i32_9 : i32
        %24 = arith.muli %23, %c32_i32_8 : i32
        %25 = arith.addi %24, %arg12 : i32
        %26 = arith.index_cast %25 : i32 to index
        %27 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%21, %26, %27] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After CanonicalizeModule (canonicalize-module) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1024 = arith.constant 1024 : index
    %c8 = arith.constant 8 : index
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %c1 = arith.constant 1 : index
    %c512 = arith.constant 512 : index
    %c4096 = arith.constant 4096 : index
    %c524288 = arith.constant 524288 : index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x1xf32>
      %3 = tensor.empty() : tensor<32x32xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
        %6 = tensor.empty() : tensor<32x32xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.index_cast %11 : i32 to index
        %13 = arith.index_cast %arg11 : i32 to index
        %14 = arith.muli %arg12, %c32_i32 : i32
        %15 = arith.index_cast %14 : i32 to index
        %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %17 = tensor.empty() : tensor<32x32xf32>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %20 = tensor.empty() : tensor<32x32xf32>
        %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %23 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before LegalizeBoolPass (hfusion-legalize-bool) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1024 = arith.constant 1024 : index
    %c8 = arith.constant 8 : index
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %c1 = arith.constant 1 : index
    %c512 = arith.constant 512 : index
    %c4096 = arith.constant 4096 : index
    %c524288 = arith.constant 524288 : index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x1xf32>
      %3 = tensor.empty() : tensor<32x32xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
        %6 = tensor.empty() : tensor<32x32xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.index_cast %11 : i32 to index
        %13 = arith.index_cast %arg11 : i32 to index
        %14 = arith.muli %arg12, %c32_i32 : i32
        %15 = arith.index_cast %14 : i32 to index
        %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %17 = tensor.empty() : tensor<32x32xf32>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %20 = tensor.empty() : tensor<32x32xf32>
        %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %23 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After LegalizeBoolPass (hfusion-legalize-bool) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1024 = arith.constant 1024 : index
    %c8 = arith.constant 8 : index
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %c1 = arith.constant 1 : index
    %c512 = arith.constant 512 : index
    %c4096 = arith.constant 4096 : index
    %c524288 = arith.constant 524288 : index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x1xf32>
      %3 = tensor.empty() : tensor<32x32xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
        %6 = tensor.empty() : tensor<32x32xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.index_cast %11 : i32 to index
        %13 = arith.index_cast %arg11 : i32 to index
        %14 = arith.muli %arg12, %c32_i32 : i32
        %15 = arith.index_cast %14 : i32 to index
        %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %17 = tensor.empty() : tensor<32x32xf32>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %20 = tensor.empty() : tensor<32x32xf32>
        %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %23 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before EraseSymbol (erase-symbol) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c1024 = arith.constant 1024 : index
  %c8 = arith.constant 8 : index
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %c1 = arith.constant 1 : index
  %c512 = arith.constant 512 : index
  %c4096 = arith.constant 4096 : index
  %c524288 = arith.constant 524288 : index
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
      %6 = tensor.empty() : tensor<32x32xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.index_cast %11 : i32 to index
      %13 = arith.index_cast %arg11 : i32 to index
      %14 = arith.muli %arg12, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %17 = tensor.empty() : tensor<32x32xf32>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %20 = tensor.empty() : tensor<32x32xf32>
      %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %23 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump After EraseSymbol (erase-symbol) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c1024 = arith.constant 1024 : index
  %c8 = arith.constant 8 : index
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %c1 = arith.constant 1 : index
  %c512 = arith.constant 512 : index
  %c4096 = arith.constant 4096 : index
  %c524288 = arith.constant 524288 : index
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
      %6 = tensor.empty() : tensor<32x32xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.index_cast %11 : i32 to index
      %13 = arith.index_cast %arg11 : i32 to index
      %14 = arith.muli %arg12, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %17 = tensor.empty() : tensor<32x32xf32>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %20 = tensor.empty() : tensor<32x32xf32>
      %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %23 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump Before LegalizeScalarPass (hfusion-legalize-scalar) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c1024 = arith.constant 1024 : index
  %c8 = arith.constant 8 : index
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %c1 = arith.constant 1 : index
  %c512 = arith.constant 512 : index
  %c4096 = arith.constant 4096 : index
  %c524288 = arith.constant 524288 : index
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
      %6 = tensor.empty() : tensor<32x32xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.index_cast %11 : i32 to index
      %13 = arith.index_cast %arg11 : i32 to index
      %14 = arith.muli %arg12, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %17 = tensor.empty() : tensor<32x32xf32>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %20 = tensor.empty() : tensor<32x32xf32>
      %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %23 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump After LegalizeScalarPass (hfusion-legalize-scalar) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c1024 = arith.constant 1024 : index
  %c8 = arith.constant 8 : index
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %c1 = arith.constant 1 : index
  %c512 = arith.constant 512 : index
  %c4096 = arith.constant 4096 : index
  %c524288 = arith.constant 524288 : index
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
      %6 = tensor.empty() : tensor<32x32xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.index_cast %11 : i32 to index
      %13 = arith.index_cast %arg11 : i32 to index
      %14 = arith.muli %arg12, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %17 = tensor.empty() : tensor<32x32xf32>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %20 = tensor.empty() : tensor<32x32xf32>
      %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %23 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump Before ConvertArithToHFusion (convert-arith-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1024 = arith.constant 1024 : index
    %c8 = arith.constant 8 : index
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %c1 = arith.constant 1 : index
    %c512 = arith.constant 512 : index
    %c4096 = arith.constant 4096 : index
    %c524288 = arith.constant 524288 : index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x1xf32>
      %3 = tensor.empty() : tensor<32x32xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
        %6 = tensor.empty() : tensor<32x32xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.index_cast %11 : i32 to index
        %13 = arith.index_cast %arg11 : i32 to index
        %14 = arith.muli %arg12, %c32_i32 : i32
        %15 = arith.index_cast %14 : i32 to index
        %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %17 = tensor.empty() : tensor<32x32xf32>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %20 = tensor.empty() : tensor<32x32xf32>
        %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %23 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After ConvertArithToHFusion (convert-arith-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1024 = arith.constant 1024 : index
    %c8 = arith.constant 8 : index
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %c1 = arith.constant 1 : index
    %c512 = arith.constant 512 : index
    %c4096 = arith.constant 4096 : index
    %c524288 = arith.constant 524288 : index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x1xf32>
      %3 = tensor.empty() : tensor<32x32xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
        %6 = tensor.empty() : tensor<32x32xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.index_cast %11 : i32 to index
        %13 = arith.index_cast %arg11 : i32 to index
        %14 = arith.muli %arg12, %c32_i32 : i32
        %15 = arith.index_cast %14 : i32 to index
        %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %17 = tensor.empty() : tensor<32x32xf32>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %20 = tensor.empty() : tensor<32x32xf32>
        %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %23 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before ConvertMathToHFusion (convert-math-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1024 = arith.constant 1024 : index
    %c8 = arith.constant 8 : index
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %c1 = arith.constant 1 : index
    %c512 = arith.constant 512 : index
    %c4096 = arith.constant 4096 : index
    %c524288 = arith.constant 524288 : index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x1xf32>
      %3 = tensor.empty() : tensor<32x32xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
        %6 = tensor.empty() : tensor<32x32xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.index_cast %11 : i32 to index
        %13 = arith.index_cast %arg11 : i32 to index
        %14 = arith.muli %arg12, %c32_i32 : i32
        %15 = arith.index_cast %14 : i32 to index
        %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %17 = tensor.empty() : tensor<32x32xf32>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %20 = tensor.empty() : tensor<32x32xf32>
        %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %23 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After ConvertMathToHFusion (convert-math-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1024 = arith.constant 1024 : index
    %c8 = arith.constant 8 : index
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %c1 = arith.constant 1 : index
    %c512 = arith.constant 512 : index
    %c4096 = arith.constant 4096 : index
    %c524288 = arith.constant 524288 : index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x1xf32>
      %3 = tensor.empty() : tensor<32x32xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
        %6 = tensor.empty() : tensor<32x32xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.index_cast %11 : i32 to index
        %13 = arith.index_cast %arg11 : i32 to index
        %14 = arith.muli %arg12, %c32_i32 : i32
        %15 = arith.index_cast %14 : i32 to index
        %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %17 = tensor.empty() : tensor<32x32xf32>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %20 = tensor.empty() : tensor<32x32xf32>
        %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %23 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before SymbolDCE (symbol-dce) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1024 = arith.constant 1024 : index
    %c8 = arith.constant 8 : index
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %c1 = arith.constant 1 : index
    %c512 = arith.constant 512 : index
    %c4096 = arith.constant 4096 : index
    %c524288 = arith.constant 524288 : index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x1xf32>
      %3 = tensor.empty() : tensor<32x32xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
        %6 = tensor.empty() : tensor<32x32xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.index_cast %11 : i32 to index
        %13 = arith.index_cast %arg11 : i32 to index
        %14 = arith.muli %arg12, %c32_i32 : i32
        %15 = arith.index_cast %14 : i32 to index
        %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %17 = tensor.empty() : tensor<32x32xf32>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %20 = tensor.empty() : tensor<32x32xf32>
        %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %23 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After SymbolDCE (symbol-dce) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1024 = arith.constant 1024 : index
    %c8 = arith.constant 8 : index
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %c1 = arith.constant 1 : index
    %c512 = arith.constant 512 : index
    %c4096 = arith.constant 4096 : index
    %c524288 = arith.constant 524288 : index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x1xf32>
      %3 = tensor.empty() : tensor<32x32xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
        %6 = tensor.empty() : tensor<32x32xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.index_cast %11 : i32 to index
        %13 = arith.index_cast %arg11 : i32 to index
        %14 = arith.muli %arg12, %c32_i32 : i32
        %15 = arith.index_cast %14 : i32 to index
        %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %17 = tensor.empty() : tensor<32x32xf32>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %20 = tensor.empty() : tensor<32x32xf32>
        %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %23 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before ConvertGPUToHFusion (convert-gpu-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1024 = arith.constant 1024 : index
    %c8 = arith.constant 8 : index
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %c1 = arith.constant 1 : index
    %c512 = arith.constant 512 : index
    %c4096 = arith.constant 4096 : index
    %c524288 = arith.constant 524288 : index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x1xf32>
      %3 = tensor.empty() : tensor<32x32xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
        %6 = tensor.empty() : tensor<32x32xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.index_cast %11 : i32 to index
        %13 = arith.index_cast %arg11 : i32 to index
        %14 = arith.muli %arg12, %c32_i32 : i32
        %15 = arith.index_cast %14 : i32 to index
        %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %17 = tensor.empty() : tensor<32x32xf32>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %20 = tensor.empty() : tensor<32x32xf32>
        %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %23 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After ConvertGPUToHFusion (convert-gpu-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1024 = arith.constant 1024 : index
    %c8 = arith.constant 8 : index
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %c1 = arith.constant 1 : index
    %c512 = arith.constant 512 : index
    %c4096 = arith.constant 4096 : index
    %c524288 = arith.constant 524288 : index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x1xf32>
      %3 = tensor.empty() : tensor<32x32xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
        %6 = tensor.empty() : tensor<32x32xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.index_cast %11 : i32 to index
        %13 = arith.index_cast %arg11 : i32 to index
        %14 = arith.muli %arg12, %c32_i32 : i32
        %15 = arith.index_cast %14 : i32 to index
        %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %17 = tensor.empty() : tensor<32x32xf32>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %20 = tensor.empty() : tensor<32x32xf32>
        %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %23 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before AdaptTritonKernel (adapt-triton-kernel) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1024 = arith.constant 1024 : index
    %c8 = arith.constant 8 : index
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %c1 = arith.constant 1 : index
    %c512 = arith.constant 512 : index
    %c4096 = arith.constant 4096 : index
    %c524288 = arith.constant 524288 : index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x1xf32>
      %3 = tensor.empty() : tensor<32x32xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
        %6 = tensor.empty() : tensor<32x32xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.index_cast %11 : i32 to index
        %13 = arith.index_cast %arg11 : i32 to index
        %14 = arith.muli %arg12, %c32_i32 : i32
        %15 = arith.index_cast %14 : i32 to index
        %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %17 = tensor.empty() : tensor<32x32xf32>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %20 = tensor.empty() : tensor<32x32xf32>
        %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %23 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After AdaptTritonKernel (adapt-triton-kernel) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1024 = arith.constant 1024 : index
    %c8 = arith.constant 8 : index
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %c1 = arith.constant 1 : index
    %c512 = arith.constant 512 : index
    %c4096 = arith.constant 4096 : index
    %c524288 = arith.constant 524288 : index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x1xf32>
      %3 = tensor.empty() : tensor<32x32xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
        %6 = tensor.empty() : tensor<32x32xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.index_cast %11 : i32 to index
        %13 = arith.index_cast %arg11 : i32 to index
        %14 = arith.muli %arg12, %c32_i32 : i32
        %15 = arith.index_cast %14 : i32 to index
        %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %17 = tensor.empty() : tensor<32x32xf32>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %20 = tensor.empty() : tensor<32x32xf32>
        %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %23 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before ConvertTensorToHFusion (convert-tensor-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1024 = arith.constant 1024 : index
    %c8 = arith.constant 8 : index
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %c1 = arith.constant 1 : index
    %c512 = arith.constant 512 : index
    %c4096 = arith.constant 4096 : index
    %c524288 = arith.constant 524288 : index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x1xf32>
      %3 = tensor.empty() : tensor<32x32xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
        %6 = tensor.empty() : tensor<32x32xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.index_cast %11 : i32 to index
        %13 = arith.index_cast %arg11 : i32 to index
        %14 = arith.muli %arg12, %c32_i32 : i32
        %15 = arith.index_cast %14 : i32 to index
        %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %17 = tensor.empty() : tensor<32x32xf32>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %20 = tensor.empty() : tensor<32x32xf32>
        %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %23 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After ConvertTensorToHFusion (convert-tensor-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1024 = arith.constant 1024 : index
    %c8 = arith.constant 8 : index
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %c1 = arith.constant 1 : index
    %c512 = arith.constant 512 : index
    %c4096 = arith.constant 4096 : index
    %c524288 = arith.constant 524288 : index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x1xf32>
      %3 = tensor.empty() : tensor<32x32xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
        %6 = tensor.empty() : tensor<32x32xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.index_cast %11 : i32 to index
        %13 = arith.index_cast %arg11 : i32 to index
        %14 = arith.muli %arg12, %c32_i32 : i32
        %15 = arith.index_cast %14 : i32 to index
        %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %17 = tensor.empty() : tensor<32x32xf32>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %20 = tensor.empty() : tensor<32x32xf32>
        %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %23 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before CanonicalizeTensorReshape (canonicalize-tensor-reshape) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c1024 = arith.constant 1024 : index
  %c8 = arith.constant 8 : index
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %c1 = arith.constant 1 : index
  %c512 = arith.constant 512 : index
  %c4096 = arith.constant 4096 : index
  %c524288 = arith.constant 524288 : index
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
      %6 = tensor.empty() : tensor<32x32xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.index_cast %11 : i32 to index
      %13 = arith.index_cast %arg11 : i32 to index
      %14 = arith.muli %arg12, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %17 = tensor.empty() : tensor<32x32xf32>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %20 = tensor.empty() : tensor<32x32xf32>
      %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %23 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump After CanonicalizeTensorReshape (canonicalize-tensor-reshape) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c1024 = arith.constant 1024 : index
  %c8 = arith.constant 8 : index
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %c1 = arith.constant 1 : index
  %c512 = arith.constant 512 : index
  %c4096 = arith.constant 4096 : index
  %c524288 = arith.constant 524288 : index
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
      %6 = tensor.empty() : tensor<32x32xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.index_cast %11 : i32 to index
      %13 = arith.index_cast %arg11 : i32 to index
      %14 = arith.muli %arg12, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %17 = tensor.empty() : tensor<32x32xf32>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %20 = tensor.empty() : tensor<32x32xf32>
      %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %23 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump Before CSE (cse) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1024 = arith.constant 1024 : index
    %c8 = arith.constant 8 : index
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %c1 = arith.constant 1 : index
    %c512 = arith.constant 512 : index
    %c4096 = arith.constant 4096 : index
    %c524288 = arith.constant 524288 : index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x1xf32>
      %3 = tensor.empty() : tensor<32x32xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
        %6 = tensor.empty() : tensor<32x32xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.index_cast %11 : i32 to index
        %13 = arith.index_cast %arg11 : i32 to index
        %14 = arith.muli %arg12, %c32_i32 : i32
        %15 = arith.index_cast %14 : i32 to index
        %subview = memref.subview %reinterpret_cast[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %16 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %17 = tensor.empty() : tensor<32x32xf32>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%16 : tensor<32x32xbf16>) outs(%17 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%8, %12, %13, %15] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %19 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %20 = tensor.empty() : tensor<32x32xf32>
        %21 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%19 : tensor<32x32xbf16>) outs(%20 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %22 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%18, %21 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%6 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %23 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %22 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %23 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After CSE (cse) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1024 = arith.constant 1024 : index
    %c8 = arith.constant 8 : index
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %c1 = arith.constant 1 : index
    %c512 = arith.constant 512 : index
    %c4096 = arith.constant 4096 : index
    %c524288 = arith.constant 524288 : index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x1xf32>
      %3 = tensor.empty() : tensor<32x32xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before Canonicalizer (canonicalize) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1024 = arith.constant 1024 : index
    %c8 = arith.constant 8 : index
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %c1 = arith.constant 1 : index
    %c512 = arith.constant 512 : index
    %c4096 = arith.constant 4096 : index
    %c524288 = arith.constant 524288 : index
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [%c1024, %c8, %c1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [%c524288, %c4096, %c512, %c1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x1xf32>
      %3 = tensor.empty() : tensor<32x32xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After Canonicalizer (canonicalize) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x1xf32>
      %3 = tensor.empty() : tensor<32x32xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before NormalizeTensorOps (normalize-tensor-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump After NormalizeTensorOps (normalize-tensor-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump Before ConvertArithToHFusion (convert-arith-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x1xf32>
      %3 = tensor.empty() : tensor<32x32xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After ConvertArithToHFusion (convert-arith-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x1xf32>
      %3 = tensor.empty() : tensor<32x32xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
      %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before HFusionGeneralizePass (hfusion-generalize) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump After HFusionGeneralizePass (hfusion-generalize) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump Before HFusionFoldUnitDims (hfusion-fold-unit-dims) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %4) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump After HFusionFoldUnitDims (hfusion-fold-unit-dims) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump Before CSE (cse) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After CSE (cse) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before Canonicalizer (canonicalize) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After Canonicalizer (canonicalize) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before NormalizeTensorOps (normalize-tensor-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump After NormalizeTensorOps (normalize-tensor-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump Before ConvertArithToHFusion (convert-arith-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After ConvertArithToHFusion (convert-arith-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before ConvertMathToHFusion (convert-math-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After ConvertMathToHFusion (convert-math-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before ConvertLinalgToHFusion (convert-linalg-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After ConvertLinalgToHFusion (convert-linalg-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before SymbolDCE (symbol-dce) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After SymbolDCE (symbol-dce) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before ConvertGPUToHFusion (convert-gpu-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After ConvertGPUToHFusion (convert-gpu-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before AdaptTritonKernel (adapt-triton-kernel) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After AdaptTritonKernel (adapt-triton-kernel) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before ConvertTensorToHFusion (convert-tensor-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After ConvertTensorToHFusion (convert-tensor-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before CanonicalizeTensorReshape (canonicalize-tensor-reshape) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump After CanonicalizeTensorReshape (canonicalize-tensor-reshape) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump Before CSE (cse) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After CSE (cse) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before Canonicalizer (canonicalize) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After Canonicalizer (canonicalize) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before NormalizeTensorOps (normalize-tensor-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump After NormalizeTensorOps (normalize-tensor-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump Before ConvertArithToHFusion (convert-arith-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After ConvertArithToHFusion (convert-arith-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before ConvertGenericToNamedOp (hfusion-convert-generic-to-named) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump After ConvertGenericToNamedOp (hfusion-convert-generic-to-named) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump Before LegalizeBF16Pass (hfusion-legalize-bf16) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump After LegalizeBF16Pass (hfusion-legalize-bf16) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump Before LegalizeFP8Pass (hfusion-legalize-fp8) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump After LegalizeFP8Pass (hfusion-legalize-fp8) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump Before Decompose (hfusion-decompose) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump After Decompose (hfusion-decompose) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump Before NormalizeSliceOps (hfusion-normalize-slice-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump After NormalizeSliceOps (hfusion-normalize-slice-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump Before GenericUnroller (hfusion-generic-unroller) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump After GenericUnroller (hfusion-generic-unroller) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump Before Normalize (hfusion-normalize-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump After Normalize (hfusion-normalize-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump Before LegalizeBoolPass (hfusion-legalize-bool) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After LegalizeBoolPass (hfusion-legalize-bool) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before SimplifyOps (hfusion-simplify-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump After SimplifyOps (hfusion-simplify-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump Before HFusionInlineBrc (hfusion-inline-brc) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump After HFusionInlineBrc (hfusion-inline-brc) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump Before Normalize (hfusion-normalize-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump After Normalize (hfusion-normalize-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump Before CSE (cse) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After CSE (cse) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before Canonicalizer (canonicalize) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump After Canonicalizer (canonicalize) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c32_i32 = arith.constant 32 : i32
    %c16_i32 = arith.constant 16 : i32
    %c0_i32 = arith.constant 0 : i32
    %c8_i32 = arith.constant 8 : i32
    %c1_i32 = arith.constant 1 : i32
    %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
      %2 = tensor.empty() : tensor<32x32xf32>
      %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
        %6 = arith.divsi %1, %c32_i32 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = arith.remsi %1, %c32_i32 : i32
        %9 = arith.divsi %8, %c8_i32 : i32
        %10 = arith.muli %9, %c32_i32 : i32
        %11 = arith.index_cast %10 : i32 to index
        %12 = arith.index_cast %arg11 : i32 to index
        %13 = arith.muli %arg12, %c32_i32 : i32
        %14 = arith.index_cast %13 : i32 to index
        %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
        %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
        %alloc_3 = memref.alloc() : memref<32x32xbf16>
        memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
        %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
        %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
        %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
        scf.yield %20 : tensor<32x32xf32>
      }
      %5 = tensor.empty() : tensor<32xf32>
      %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
        (%in: f32, %init: f32) {
          %6 = arith.addf %in, %init : f32
          linalg.yield %6 : f32
        }
      %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
      scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
        %6 = arith.index_cast %arg12 : i32 to index
        %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
        %7 = arith.divsi %1, %c32_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = arith.remsi %1, %c32_i32 : i32
        %10 = arith.divsi %9, %c8_i32 : i32
        %11 = arith.muli %10, %c32_i32 : i32
        %12 = arith.addi %11, %arg12 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = arith.index_cast %arg11 : i32 to index
        memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
      }
    }
    return
  }
}


// -----// IR Dump Before NormalizeTensorOps (normalize-tensor-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump After NormalizeTensorOps (normalize-tensor-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

// -----// IR Dump Before PropagateReshape (propagate-reshape) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
  %c0 = arith.constant 0 : index
  %cst = arith.constant 0.000000e+00 : f32
  %c32_i32 = arith.constant 32 : i32
  %c16_i32 = arith.constant 16 : i32
  %c0_i32 = arith.constant 0 : i32
  %c8_i32 = arith.constant 8 : i32
  %c1_i32 = arith.constant 1 : i32
  %reinterpret_cast = memref.reinterpret_cast %arg2 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [2, 128, 8], strides: [1024, 8, 1] : memref<?xf32> to memref<2x128x8xf32, strided<[1024, 8, 1]>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg3 to offset: [0], sizes: [2, 128, 8, 512], strides: [524288, 4096, 512, 1] : memref<?xbf16> to memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  scf.for %arg11 = %c0_i32 to %c8_i32 step %c1_i32  : i32 {
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg12 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg13 = %3) -> (tensor<32x32xf32>)  : i32 {
      %6 = arith.divsi %1, %c32_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.remsi %1, %c32_i32 : i32
      %9 = arith.divsi %8, %c8_i32 : i32
      %10 = arith.muli %9, %c32_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = arith.index_cast %arg11 : i32 to index
      %13 = arith.muli %arg12, %c32_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %subview = memref.subview %reinterpret_cast[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %15 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %16 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%15 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_2 = memref.subview %reinterpret_cast_1[%7, %11, %12, %14] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_3 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc_3 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %17 = bufferization.to_tensor %alloc_3 restrict : memref<32x32xbf16>
      %18 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%17 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %19 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%16, %18 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %20 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg13, %19 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg13 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %20 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %6 = arith.addf %in, %init : f32
        linalg.yield %6 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    scf.for %arg12 = %c0_i32 to %c32_i32 step %c1_i32  : i32 {
      %6 = arith.index_cast %arg12 : i32 to index
      %extracted = tensor.extract %expanded[%6, %c0] : tensor<32x1xf32>
      %7 = arith.divsi %1, %c32_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = arith.remsi %1, %c32_i32 : i32
      %10 = arith.divsi %9, %c8_i32 : i32
      %11 = arith.muli %10, %c32_i32 : i32
      %12 = arith.addi %11, %arg12 : i32
      %13 = arith.index_cast %12 : i32 to index
      %14 = arith.index_cast %arg11 : i32 to index
      memref.store %extracted, %reinterpret_cast_0[%8, %13, %14] : memref<2x128x8xf32, strided<[1024, 8, 1]>>
    }
  }
  return
}

bishengir-compile: /home/w00933195/m60115804/tilelang-mlir-ascend/3rdparty/AscendNPU-IR-Dev/third-party/llvm-project/llvm/include/llvm/ADT/SmallVector.h:305: llvm::SmallVectorTemplateCommon::reference llvm::SmallVectorTemplateCommon<long>::operator[](llvm::SmallVectorTemplateCommon::size_type) [T = long]: Assertion `idx < size()' failed.
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace.
Stack dump:
0.	Program arguments: ./bishengir-compile kernel.npuir --target=Ascend950PR_9579 --enable-auto-multi-buffer=true --disable-ffts --enable-triton-kernel-compile=true --enable-hivm-compile=true --enable-vf-merge-level=1 --enable-hfusion-compile=true --enable-auto-bind-sub-block=true -o kernel --mlir-print-ir-before-all --mlir-print-ir-after-all
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  bishengir-compile 0x0000562191de8117
1  bishengir-compile 0x0000562191de5d1e
2  bishengir-compile 0x0000562191de87ea
3  libc.so.6         0x00007f57a9087520
4  libc.so.6         0x00007f57a90db9fc pthread_kill + 300
5  libc.so.6         0x00007f57a9087476 raise + 22
6  libc.so.6         0x00007f57a906d7f3 abort + 211
7  libc.so.6         0x00007f57a906d71b
8  libc.so.6         0x00007f57a907ee96
9  bishengir-compile 0x000056218ca2e97c
10 bishengir-compile 0x000056218c9f6991
11 bishengir-compile 0x0000562190e98e09
12 bishengir-compile 0x0000562190e9571f
13 bishengir-compile 0x0000562190e73e66
14 bishengir-compile 0x0000562190e70760
15 bishengir-compile 0x000056218c9f4158
16 bishengir-compile 0x0000562190f87c04
17 bishengir-compile 0x0000562190f88231
18 bishengir-compile 0x0000562190f8d42e
19 bishengir-compile 0x0000562190f898ab
20 bishengir-compile 0x0000562190f87d48
21 bishengir-compile 0x0000562190f88231
22 bishengir-compile 0x0000562190f8a772
23 bishengir-compile 0x000056218ca932b9
24 bishengir-compile 0x000056218ca7908c
25 bishengir-compile 0x000056218c9a9c83
26 libc.so.6         0x00007f57a906ed90
27 libc.so.6         0x00007f57a906ee40 __libc_start_main + 128
28 bishengir-compile 0x000056218c9a8b65