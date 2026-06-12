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
    %13 = tensor.empty() : tensor<32x1xf32>
    %14 = tensor.empty() : tensor<32x32xf32>
    %c0_i32 = arith.constant 0 : i32
    %15 = arith.sitofp %c0_i32 : i32 to f32
    %16 = linalg.fill ins(%15 : f32) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %c16_i32 = arith.constant 16 : i32
    %c1_i32_2 = arith.constant 1 : i32
    %17 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32_2 iter_args(%arg12 = %16) -> (tensor<32x32xf32>)  : i32 {
      %26 = tensor.empty() : tensor<32x32xf32>
      %27 = tensor.empty() : tensor<32x32xf32>
      %28 = tensor.empty() : tensor<32x32xf32>
      %c32_i32_4 = arith.constant 32 : i32
      %29 = arith.divsi %12, %c32_i32_4 : i32
      %30 = arith.index_cast %29 : i32 to index
      %31 = arith.remsi %12, %c32_i32_4 : i32
      %c8_i32_5 = arith.constant 8 : i32
      %32 = arith.divsi %31, %c8_i32_5 : i32
      %33 = arith.muli %32, %c32_i32_4 : i32
      %34 = arith.index_cast %33 : i32 to index
      %35 = arith.remsi %12, %c8_i32_5 : i32
      %36 = arith.index_cast %35 : i32 to index
      %37 = arith.muli %arg11, %c32_i32_4 : i32
      %38 = arith.index_cast %37 : i32 to index
      %subview_6 = memref.subview %reinterpret_cast[%30, %34, %36, %38] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_6, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %39 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %40 = tensor.empty() : tensor<32x32xbf16>
      %41 = tensor.empty() : tensor<32x32xf32>
      %42 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%39 : tensor<32x32xbf16>) outs(%41 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %expanded_7 = tensor.expand_shape %42 [[0], [1]] output_shape [32, 32] : tensor<32x32xf32> into tensor<32x32xf32>
      %inserted_slice_8 = tensor.insert_slice %expanded_7 into %26[0, 0] [32, 32] [1, 1] : tensor<32x32xf32> into tensor<32x32xf32>
      %subview_9 = memref.subview %reinterpret_cast_1[%30, %34, %36, %38] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_10 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_9, %alloc_10 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %43 = bufferization.to_tensor %alloc_10 restrict : memref<32x32xbf16>
      %44 = tensor.empty() : tensor<32x32xbf16>
      %45 = tensor.empty() : tensor<32x32xf32>
      %46 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%43 : tensor<32x32xbf16>) outs(%45 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %expanded_11 = tensor.expand_shape %46 [[0], [1]] output_shape [32, 32] : tensor<32x32xf32> into tensor<32x32xf32>
      %inserted_slice_12 = tensor.insert_slice %expanded_11 into %27[0, 0] [32, 32] [1, 1] : tensor<32x32xf32> into tensor<32x32xf32>
      %47 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%inserted_slice_8, %inserted_slice_12 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%28 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %48 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %47 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %48 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %13 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%17 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %26 = arith.addf %in, %init : f32
        linalg.yield %26 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %expanded_3 = tensor.expand_shape %expanded [[0], [1]] output_shape [32, 1] : tensor<32x1xf32> into tensor<32x1xf32>
    %inserted_slice = tensor.insert_slice %expanded_3 into %13[0, 0] [32, 1] [1, 1] : tensor<32x1xf32> into tensor<32x1xf32>
    %c32_i32 = arith.constant 32 : i32
    %18 = arith.divsi %12, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %12, %c32_i32 : i32
    %21 = arith.divsi %20, %c8_i32 : i32
    %22 = arith.muli %21, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %24 = arith.remsi %12, %c8_i32 : i32
    %25 = arith.index_cast %24 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%19, %23, %25] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %inserted_slice in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
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
    %13 = tensor.empty() : tensor<32x1xf32>
    %14 = tensor.empty() : tensor<32x32xf32>
    %c0_i32 = arith.constant 0 : i32
    %15 = arith.sitofp %c0_i32 : i32 to f32
    %16 = linalg.fill ins(%15 : f32) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %c16_i32 = arith.constant 16 : i32
    %c1_i32_2 = arith.constant 1 : i32
    %17 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32_2 iter_args(%arg12 = %16) -> (tensor<32x32xf32>)  : i32 {
      %26 = tensor.empty() : tensor<32x32xf32>
      %27 = tensor.empty() : tensor<32x32xf32>
      %28 = tensor.empty() : tensor<32x32xf32>
      %c32_i32_4 = arith.constant 32 : i32
      %29 = arith.divsi %12, %c32_i32_4 : i32
      %30 = arith.index_cast %29 : i32 to index
      %31 = arith.remsi %12, %c32_i32_4 : i32
      %c8_i32_5 = arith.constant 8 : i32
      %32 = arith.divsi %31, %c8_i32_5 : i32
      %33 = arith.muli %32, %c32_i32_4 : i32
      %34 = arith.index_cast %33 : i32 to index
      %35 = arith.remsi %12, %c8_i32_5 : i32
      %36 = arith.index_cast %35 : i32 to index
      %37 = arith.muli %arg11, %c32_i32_4 : i32
      %38 = arith.index_cast %37 : i32 to index
      %subview_6 = memref.subview %reinterpret_cast[%30, %34, %36, %38] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_6, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %39 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %40 = tensor.empty() : tensor<32x32xbf16>
      %41 = tensor.empty() : tensor<32x32xf32>
      %42 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%39 : tensor<32x32xbf16>) outs(%41 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %expanded_7 = tensor.expand_shape %42 [[0], [1]] output_shape [32, 32] : tensor<32x32xf32> into tensor<32x32xf32>
      %inserted_slice_8 = tensor.insert_slice %expanded_7 into %26[0, 0] [32, 32] [1, 1] : tensor<32x32xf32> into tensor<32x32xf32>
      %subview_9 = memref.subview %reinterpret_cast_1[%30, %34, %36, %38] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_10 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_9, %alloc_10 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %43 = bufferization.to_tensor %alloc_10 restrict : memref<32x32xbf16>
      %44 = tensor.empty() : tensor<32x32xbf16>
      %45 = tensor.empty() : tensor<32x32xf32>
      %46 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%43 : tensor<32x32xbf16>) outs(%45 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %expanded_11 = tensor.expand_shape %46 [[0], [1]] output_shape [32, 32] : tensor<32x32xf32> into tensor<32x32xf32>
      %inserted_slice_12 = tensor.insert_slice %expanded_11 into %27[0, 0] [32, 32] [1, 1] : tensor<32x32xf32> into tensor<32x32xf32>
      %47 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%inserted_slice_8, %inserted_slice_12 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%28 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %48 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %47 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %48 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %13 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%17 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %26 = arith.addf %in, %init : f32
        linalg.yield %26 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %expanded_3 = tensor.expand_shape %expanded [[0], [1]] output_shape [32, 1] : tensor<32x1xf32> into tensor<32x1xf32>
    %inserted_slice = tensor.insert_slice %expanded_3 into %13[0, 0] [32, 1] [1, 1] : tensor<32x1xf32> into tensor<32x1xf32>
    %c32_i32 = arith.constant 32 : i32
    %18 = arith.divsi %12, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %12, %c32_i32 : i32
    %21 = arith.divsi %20, %c8_i32 : i32
    %22 = arith.muli %21, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %24 = arith.remsi %12, %c8_i32 : i32
    %25 = arith.index_cast %24 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%19, %23, %25] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %inserted_slice in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
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
    %13 = tensor.empty() : tensor<32x1xf32>
    %14 = tensor.empty() : tensor<32x32xf32>
    %c0_i32 = arith.constant 0 : i32
    %15 = arith.sitofp %c0_i32 : i32 to f32
    %16 = linalg.fill ins(%15 : f32) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %c16_i32 = arith.constant 16 : i32
    %c1_i32_2 = arith.constant 1 : i32
    %17 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32_2 iter_args(%arg12 = %16) -> (tensor<32x32xf32>)  : i32 {
      %26 = tensor.empty() : tensor<32x32xf32>
      %27 = tensor.empty() : tensor<32x32xf32>
      %28 = tensor.empty() : tensor<32x32xf32>
      %c32_i32_4 = arith.constant 32 : i32
      %29 = arith.divsi %12, %c32_i32_4 : i32
      %30 = arith.index_cast %29 : i32 to index
      %31 = arith.remsi %12, %c32_i32_4 : i32
      %c8_i32_5 = arith.constant 8 : i32
      %32 = arith.divsi %31, %c8_i32_5 : i32
      %33 = arith.muli %32, %c32_i32_4 : i32
      %34 = arith.index_cast %33 : i32 to index
      %35 = arith.remsi %12, %c8_i32_5 : i32
      %36 = arith.index_cast %35 : i32 to index
      %37 = arith.muli %arg11, %c32_i32_4 : i32
      %38 = arith.index_cast %37 : i32 to index
      %subview_6 = memref.subview %reinterpret_cast[%30, %34, %36, %38] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_6, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %39 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %40 = tensor.empty() : tensor<32x32xbf16>
      %41 = tensor.empty() : tensor<32x32xf32>
      %42 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%39 : tensor<32x32xbf16>) outs(%41 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %expanded_7 = tensor.expand_shape %42 [[0], [1]] output_shape [32, 32] : tensor<32x32xf32> into tensor<32x32xf32>
      %inserted_slice_8 = tensor.insert_slice %expanded_7 into %26[0, 0] [32, 32] [1, 1] : tensor<32x32xf32> into tensor<32x32xf32>
      %subview_9 = memref.subview %reinterpret_cast_1[%30, %34, %36, %38] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_10 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_9, %alloc_10 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %43 = bufferization.to_tensor %alloc_10 restrict : memref<32x32xbf16>
      %44 = tensor.empty() : tensor<32x32xbf16>
      %45 = tensor.empty() : tensor<32x32xf32>
      %46 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%43 : tensor<32x32xbf16>) outs(%45 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %expanded_11 = tensor.expand_shape %46 [[0], [1]] output_shape [32, 32] : tensor<32x32xf32> into tensor<32x32xf32>
      %inserted_slice_12 = tensor.insert_slice %expanded_11 into %27[0, 0] [32, 32] [1, 1] : tensor<32x32xf32> into tensor<32x32xf32>
      %47 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%inserted_slice_8, %inserted_slice_12 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%28 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %48 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %47 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %48 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %13 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%17 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %26 = arith.addf %in, %init : f32
        linalg.yield %26 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %expanded_3 = tensor.expand_shape %expanded [[0], [1]] output_shape [32, 1] : tensor<32x1xf32> into tensor<32x1xf32>
    %inserted_slice = tensor.insert_slice %expanded_3 into %13[0, 0] [32, 1] [1, 1] : tensor<32x1xf32> into tensor<32x1xf32>
    %c32_i32 = arith.constant 32 : i32
    %18 = arith.divsi %12, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %12, %c32_i32 : i32
    %21 = arith.divsi %20, %c8_i32 : i32
    %22 = arith.muli %21, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %24 = arith.remsi %12, %c8_i32 : i32
    %25 = arith.index_cast %24 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%19, %23, %25] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %inserted_slice in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After CanonicalizeModule (canonicalize-module) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
      %14 = tensor.empty() : tensor<32x32xf32>
      %15 = arith.divsi %1, %c32_i32 : i32
      %16 = arith.index_cast %15 : i32 to index
      %17 = arith.remsi %1, %c32_i32 : i32
      %18 = arith.divsi %17, %c8_i32 : i32
      %19 = arith.muli %18, %c32_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.remsi %1, %c8_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = arith.muli %arg11, %c32_i32 : i32
      %24 = arith.index_cast %23 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %26 = tensor.empty() : tensor<32x32xf32>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %29 = tensor.empty() : tensor<32x32xf32>
      %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %32 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before LegalizeBoolPass (hfusion-legalize-bool) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
      %14 = tensor.empty() : tensor<32x32xf32>
      %15 = arith.divsi %1, %c32_i32 : i32
      %16 = arith.index_cast %15 : i32 to index
      %17 = arith.remsi %1, %c32_i32 : i32
      %18 = arith.divsi %17, %c8_i32 : i32
      %19 = arith.muli %18, %c32_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.remsi %1, %c8_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = arith.muli %arg11, %c32_i32 : i32
      %24 = arith.index_cast %23 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %26 = tensor.empty() : tensor<32x32xf32>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %29 = tensor.empty() : tensor<32x32xf32>
      %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %32 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After LegalizeBoolPass (hfusion-legalize-bool) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
      %14 = tensor.empty() : tensor<32x32xf32>
      %15 = arith.divsi %1, %c32_i32 : i32
      %16 = arith.index_cast %15 : i32 to index
      %17 = arith.remsi %1, %c32_i32 : i32
      %18 = arith.divsi %17, %c8_i32 : i32
      %19 = arith.muli %18, %c32_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.remsi %1, %c8_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = arith.muli %arg11, %c32_i32 : i32
      %24 = arith.index_cast %23 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %26 = tensor.empty() : tensor<32x32xf32>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %29 = tensor.empty() : tensor<32x32xf32>
      %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %32 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before EraseSymbol (erase-symbol) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x1xf32>
  %3 = tensor.empty() : tensor<32x32xf32>
  %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
    %14 = tensor.empty() : tensor<32x32xf32>
    %15 = arith.divsi %1, %c32_i32 : i32
    %16 = arith.index_cast %15 : i32 to index
    %17 = arith.remsi %1, %c32_i32 : i32
    %18 = arith.divsi %17, %c8_i32 : i32
    %19 = arith.muli %18, %c32_i32 : i32
    %20 = arith.index_cast %19 : i32 to index
    %21 = arith.remsi %1, %c8_i32 : i32
    %22 = arith.index_cast %21 : i32 to index
    %23 = arith.muli %arg11, %c32_i32 : i32
    %24 = arith.index_cast %23 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %26 = tensor.empty() : tensor<32x32xf32>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %29 = tensor.empty() : tensor<32x32xf32>
    %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %32 : tensor<32x32xf32>
  }
  %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
  %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
  return
}

// -----// IR Dump After EraseSymbol (erase-symbol) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x1xf32>
  %3 = tensor.empty() : tensor<32x32xf32>
  %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
    %14 = tensor.empty() : tensor<32x32xf32>
    %15 = arith.divsi %1, %c32_i32 : i32
    %16 = arith.index_cast %15 : i32 to index
    %17 = arith.remsi %1, %c32_i32 : i32
    %18 = arith.divsi %17, %c8_i32 : i32
    %19 = arith.muli %18, %c32_i32 : i32
    %20 = arith.index_cast %19 : i32 to index
    %21 = arith.remsi %1, %c8_i32 : i32
    %22 = arith.index_cast %21 : i32 to index
    %23 = arith.muli %arg11, %c32_i32 : i32
    %24 = arith.index_cast %23 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %26 = tensor.empty() : tensor<32x32xf32>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %29 = tensor.empty() : tensor<32x32xf32>
    %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %32 : tensor<32x32xf32>
  }
  %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
  %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before LegalizeScalarPass (hfusion-legalize-scalar) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x1xf32>
  %3 = tensor.empty() : tensor<32x32xf32>
  %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
    %14 = tensor.empty() : tensor<32x32xf32>
    %15 = arith.divsi %1, %c32_i32 : i32
    %16 = arith.index_cast %15 : i32 to index
    %17 = arith.remsi %1, %c32_i32 : i32
    %18 = arith.divsi %17, %c8_i32 : i32
    %19 = arith.muli %18, %c32_i32 : i32
    %20 = arith.index_cast %19 : i32 to index
    %21 = arith.remsi %1, %c8_i32 : i32
    %22 = arith.index_cast %21 : i32 to index
    %23 = arith.muli %arg11, %c32_i32 : i32
    %24 = arith.index_cast %23 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %26 = tensor.empty() : tensor<32x32xf32>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %29 = tensor.empty() : tensor<32x32xf32>
    %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %32 : tensor<32x32xf32>
  }
  %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
  %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
  return
}

// -----// IR Dump After LegalizeScalarPass (hfusion-legalize-scalar) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x1xf32>
  %3 = tensor.empty() : tensor<32x32xf32>
  %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
    %14 = tensor.empty() : tensor<32x32xf32>
    %15 = arith.divsi %1, %c32_i32 : i32
    %16 = arith.index_cast %15 : i32 to index
    %17 = arith.remsi %1, %c32_i32 : i32
    %18 = arith.divsi %17, %c8_i32 : i32
    %19 = arith.muli %18, %c32_i32 : i32
    %20 = arith.index_cast %19 : i32 to index
    %21 = arith.remsi %1, %c8_i32 : i32
    %22 = arith.index_cast %21 : i32 to index
    %23 = arith.muli %arg11, %c32_i32 : i32
    %24 = arith.index_cast %23 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %26 = tensor.empty() : tensor<32x32xf32>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %29 = tensor.empty() : tensor<32x32xf32>
    %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %32 : tensor<32x32xf32>
  }
  %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
  %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before ConvertArithToHFusion (convert-arith-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
      %14 = tensor.empty() : tensor<32x32xf32>
      %15 = arith.divsi %1, %c32_i32 : i32
      %16 = arith.index_cast %15 : i32 to index
      %17 = arith.remsi %1, %c32_i32 : i32
      %18 = arith.divsi %17, %c8_i32 : i32
      %19 = arith.muli %18, %c32_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.remsi %1, %c8_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = arith.muli %arg11, %c32_i32 : i32
      %24 = arith.index_cast %23 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %26 = tensor.empty() : tensor<32x32xf32>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %29 = tensor.empty() : tensor<32x32xf32>
      %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %32 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After ConvertArithToHFusion (convert-arith-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
      %14 = tensor.empty() : tensor<32x32xf32>
      %15 = arith.divsi %1, %c32_i32 : i32
      %16 = arith.index_cast %15 : i32 to index
      %17 = arith.remsi %1, %c32_i32 : i32
      %18 = arith.divsi %17, %c8_i32 : i32
      %19 = arith.muli %18, %c32_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.remsi %1, %c8_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = arith.muli %arg11, %c32_i32 : i32
      %24 = arith.index_cast %23 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %26 = tensor.empty() : tensor<32x32xf32>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %29 = tensor.empty() : tensor<32x32xf32>
      %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %32 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before ConvertMathToHFusion (convert-math-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
      %14 = tensor.empty() : tensor<32x32xf32>
      %15 = arith.divsi %1, %c32_i32 : i32
      %16 = arith.index_cast %15 : i32 to index
      %17 = arith.remsi %1, %c32_i32 : i32
      %18 = arith.divsi %17, %c8_i32 : i32
      %19 = arith.muli %18, %c32_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.remsi %1, %c8_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = arith.muli %arg11, %c32_i32 : i32
      %24 = arith.index_cast %23 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %26 = tensor.empty() : tensor<32x32xf32>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %29 = tensor.empty() : tensor<32x32xf32>
      %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %32 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After ConvertMathToHFusion (convert-math-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
      %14 = tensor.empty() : tensor<32x32xf32>
      %15 = arith.divsi %1, %c32_i32 : i32
      %16 = arith.index_cast %15 : i32 to index
      %17 = arith.remsi %1, %c32_i32 : i32
      %18 = arith.divsi %17, %c8_i32 : i32
      %19 = arith.muli %18, %c32_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.remsi %1, %c8_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = arith.muli %arg11, %c32_i32 : i32
      %24 = arith.index_cast %23 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %26 = tensor.empty() : tensor<32x32xf32>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %29 = tensor.empty() : tensor<32x32xf32>
      %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %32 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before SymbolDCE (symbol-dce) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
      %14 = tensor.empty() : tensor<32x32xf32>
      %15 = arith.divsi %1, %c32_i32 : i32
      %16 = arith.index_cast %15 : i32 to index
      %17 = arith.remsi %1, %c32_i32 : i32
      %18 = arith.divsi %17, %c8_i32 : i32
      %19 = arith.muli %18, %c32_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.remsi %1, %c8_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = arith.muli %arg11, %c32_i32 : i32
      %24 = arith.index_cast %23 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %26 = tensor.empty() : tensor<32x32xf32>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %29 = tensor.empty() : tensor<32x32xf32>
      %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %32 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After SymbolDCE (symbol-dce) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
      %14 = tensor.empty() : tensor<32x32xf32>
      %15 = arith.divsi %1, %c32_i32 : i32
      %16 = arith.index_cast %15 : i32 to index
      %17 = arith.remsi %1, %c32_i32 : i32
      %18 = arith.divsi %17, %c8_i32 : i32
      %19 = arith.muli %18, %c32_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.remsi %1, %c8_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = arith.muli %arg11, %c32_i32 : i32
      %24 = arith.index_cast %23 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %26 = tensor.empty() : tensor<32x32xf32>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %29 = tensor.empty() : tensor<32x32xf32>
      %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %32 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before ConvertGPUToHFusion (convert-gpu-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
      %14 = tensor.empty() : tensor<32x32xf32>
      %15 = arith.divsi %1, %c32_i32 : i32
      %16 = arith.index_cast %15 : i32 to index
      %17 = arith.remsi %1, %c32_i32 : i32
      %18 = arith.divsi %17, %c8_i32 : i32
      %19 = arith.muli %18, %c32_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.remsi %1, %c8_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = arith.muli %arg11, %c32_i32 : i32
      %24 = arith.index_cast %23 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %26 = tensor.empty() : tensor<32x32xf32>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %29 = tensor.empty() : tensor<32x32xf32>
      %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %32 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After ConvertGPUToHFusion (convert-gpu-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
      %14 = tensor.empty() : tensor<32x32xf32>
      %15 = arith.divsi %1, %c32_i32 : i32
      %16 = arith.index_cast %15 : i32 to index
      %17 = arith.remsi %1, %c32_i32 : i32
      %18 = arith.divsi %17, %c8_i32 : i32
      %19 = arith.muli %18, %c32_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.remsi %1, %c8_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = arith.muli %arg11, %c32_i32 : i32
      %24 = arith.index_cast %23 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %26 = tensor.empty() : tensor<32x32xf32>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %29 = tensor.empty() : tensor<32x32xf32>
      %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %32 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before AdaptTritonKernel (adapt-triton-kernel) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, global_kernel = "local", mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
      %14 = tensor.empty() : tensor<32x32xf32>
      %15 = arith.divsi %1, %c32_i32 : i32
      %16 = arith.index_cast %15 : i32 to index
      %17 = arith.remsi %1, %c32_i32 : i32
      %18 = arith.divsi %17, %c8_i32 : i32
      %19 = arith.muli %18, %c32_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.remsi %1, %c8_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = arith.muli %arg11, %c32_i32 : i32
      %24 = arith.index_cast %23 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %26 = tensor.empty() : tensor<32x32xf32>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %29 = tensor.empty() : tensor<32x32xf32>
      %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %32 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After AdaptTritonKernel (adapt-triton-kernel) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
      %14 = tensor.empty() : tensor<32x32xf32>
      %15 = arith.divsi %1, %c32_i32 : i32
      %16 = arith.index_cast %15 : i32 to index
      %17 = arith.remsi %1, %c32_i32 : i32
      %18 = arith.divsi %17, %c8_i32 : i32
      %19 = arith.muli %18, %c32_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.remsi %1, %c8_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = arith.muli %arg11, %c32_i32 : i32
      %24 = arith.index_cast %23 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %26 = tensor.empty() : tensor<32x32xf32>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %29 = tensor.empty() : tensor<32x32xf32>
      %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %32 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before ConvertTensorToHFusion (convert-tensor-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
      %14 = tensor.empty() : tensor<32x32xf32>
      %15 = arith.divsi %1, %c32_i32 : i32
      %16 = arith.index_cast %15 : i32 to index
      %17 = arith.remsi %1, %c32_i32 : i32
      %18 = arith.divsi %17, %c8_i32 : i32
      %19 = arith.muli %18, %c32_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.remsi %1, %c8_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = arith.muli %arg11, %c32_i32 : i32
      %24 = arith.index_cast %23 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %26 = tensor.empty() : tensor<32x32xf32>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %29 = tensor.empty() : tensor<32x32xf32>
      %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %32 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After ConvertTensorToHFusion (convert-tensor-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
      %14 = tensor.empty() : tensor<32x32xf32>
      %15 = arith.divsi %1, %c32_i32 : i32
      %16 = arith.index_cast %15 : i32 to index
      %17 = arith.remsi %1, %c32_i32 : i32
      %18 = arith.divsi %17, %c8_i32 : i32
      %19 = arith.muli %18, %c32_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.remsi %1, %c8_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = arith.muli %arg11, %c32_i32 : i32
      %24 = arith.index_cast %23 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %26 = tensor.empty() : tensor<32x32xf32>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %29 = tensor.empty() : tensor<32x32xf32>
      %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %32 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before CanonicalizeTensorReshape (canonicalize-tensor-reshape) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x1xf32>
  %3 = tensor.empty() : tensor<32x32xf32>
  %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
    %14 = tensor.empty() : tensor<32x32xf32>
    %15 = arith.divsi %1, %c32_i32 : i32
    %16 = arith.index_cast %15 : i32 to index
    %17 = arith.remsi %1, %c32_i32 : i32
    %18 = arith.divsi %17, %c8_i32 : i32
    %19 = arith.muli %18, %c32_i32 : i32
    %20 = arith.index_cast %19 : i32 to index
    %21 = arith.remsi %1, %c8_i32 : i32
    %22 = arith.index_cast %21 : i32 to index
    %23 = arith.muli %arg11, %c32_i32 : i32
    %24 = arith.index_cast %23 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %26 = tensor.empty() : tensor<32x32xf32>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %29 = tensor.empty() : tensor<32x32xf32>
    %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %32 : tensor<32x32xf32>
  }
  %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
  %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
  return
}

// -----// IR Dump After CanonicalizeTensorReshape (canonicalize-tensor-reshape) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x1xf32>
  %3 = tensor.empty() : tensor<32x32xf32>
  %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
    %14 = tensor.empty() : tensor<32x32xf32>
    %15 = arith.divsi %1, %c32_i32 : i32
    %16 = arith.index_cast %15 : i32 to index
    %17 = arith.remsi %1, %c32_i32 : i32
    %18 = arith.divsi %17, %c8_i32 : i32
    %19 = arith.muli %18, %c32_i32 : i32
    %20 = arith.index_cast %19 : i32 to index
    %21 = arith.remsi %1, %c8_i32 : i32
    %22 = arith.index_cast %21 : i32 to index
    %23 = arith.muli %arg11, %c32_i32 : i32
    %24 = arith.index_cast %23 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %26 = tensor.empty() : tensor<32x32xf32>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %29 = tensor.empty() : tensor<32x32xf32>
    %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %32 : tensor<32x32xf32>
  }
  %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
  %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before CSE (cse) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
      %14 = tensor.empty() : tensor<32x32xf32>
      %15 = arith.divsi %1, %c32_i32 : i32
      %16 = arith.index_cast %15 : i32 to index
      %17 = arith.remsi %1, %c32_i32 : i32
      %18 = arith.divsi %17, %c8_i32 : i32
      %19 = arith.muli %18, %c32_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.remsi %1, %c8_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = arith.muli %arg11, %c32_i32 : i32
      %24 = arith.index_cast %23 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %25 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %26 = tensor.empty() : tensor<32x32xf32>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%25 : tensor<32x32xbf16>) outs(%26 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%16, %20, %22, %24] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %28 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %29 = tensor.empty() : tensor<32x32xf32>
      %30 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%28 : tensor<32x32xbf16>) outs(%29 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %31 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%27, %30 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%14 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %32 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %31 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %32 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After CSE (cse) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before Canonicalizer (canonicalize) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After Canonicalizer (canonicalize) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before NormalizeTensorOps (normalize-tensor-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x1xf32>
  %3 = tensor.empty() : tensor<32x32xf32>
  %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
  %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
  return
}

// -----// IR Dump After NormalizeTensorOps (normalize-tensor-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x1xf32>
  %3 = tensor.empty() : tensor<32x32xf32>
  %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
  %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before ConvertArithToHFusion (convert-arith-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After ConvertArithToHFusion (convert-arith-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x1xf32>
    %3 = tensor.empty() : tensor<32x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
    %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before HFusionGeneralizePass (hfusion-generalize) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x1xf32>
  %3 = tensor.empty() : tensor<32x32xf32>
  %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
  %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
  return
}

// -----// IR Dump After HFusionGeneralizePass (hfusion-generalize) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x1xf32>
  %3 = tensor.empty() : tensor<32x32xf32>
  %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
  %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before HFusionFoldUnitDims (hfusion-fold-unit-dims) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x1xf32>
  %3 = tensor.empty() : tensor<32x32xf32>
  %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %5 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %4) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%3 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<32x1xf32> into tensor<32xf32>
  %reduced = linalg.reduce ins(%5 : tensor<32x32xf32>) outs(%collapsed : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %expanded = tensor.expand_shape %reduced [[0, 1]] output_shape [32, 1] : tensor<32xf32> into tensor<32x1xf32>
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  bufferization.materialize_in_destination %expanded in writable %subview : (tensor<32x1xf32>, memref<32x1xf32, strided<[8, 1], offset: ?>>) -> ()
  return
}

// -----// IR Dump After HFusionFoldUnitDims (hfusion-fold-unit-dims) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before CSE (cse) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After CSE (cse) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before Canonicalizer (canonicalize) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After Canonicalizer (canonicalize) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before NormalizeTensorOps (normalize-tensor-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump After NormalizeTensorOps (normalize-tensor-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before ConvertArithToHFusion (convert-arith-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After ConvertArithToHFusion (convert-arith-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before ConvertMathToHFusion (convert-math-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After ConvertMathToHFusion (convert-math-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before ConvertLinalgToHFusion (convert-linalg-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After ConvertLinalgToHFusion (convert-linalg-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before SymbolDCE (symbol-dce) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After SymbolDCE (symbol-dce) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before ConvertGPUToHFusion (convert-gpu-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After ConvertGPUToHFusion (convert-gpu-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before AdaptTritonKernel (adapt-triton-kernel) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After AdaptTritonKernel (adapt-triton-kernel) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before ConvertTensorToHFusion (convert-tensor-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After ConvertTensorToHFusion (convert-tensor-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before CanonicalizeTensorReshape (canonicalize-tensor-reshape) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump After CanonicalizeTensorReshape (canonicalize-tensor-reshape) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before CSE (cse) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After CSE (cse) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before Canonicalizer (canonicalize) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After Canonicalizer (canonicalize) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before NormalizeTensorOps (normalize-tensor-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump After NormalizeTensorOps (normalize-tensor-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before ConvertArithToHFusion (convert-arith-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After ConvertArithToHFusion (convert-arith-to-hfusion) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before ConvertGenericToNamedOp (hfusion-convert-generic-to-named) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump After ConvertGenericToNamedOp (hfusion-convert-generic-to-named) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before LegalizeBF16Pass (hfusion-legalize-bf16) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump After LegalizeBF16Pass (hfusion-legalize-bf16) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before LegalizeFP8Pass (hfusion-legalize-fp8) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump After LegalizeFP8Pass (hfusion-legalize-fp8) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before Decompose (hfusion-decompose) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump After Decompose (hfusion-decompose) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before NormalizeSliceOps (hfusion-normalize-slice-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump After NormalizeSliceOps (hfusion-normalize-slice-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before GenericUnroller (hfusion-generic-unroller) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump After GenericUnroller (hfusion-generic-unroller) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before Normalize (hfusion-normalize-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump After Normalize (hfusion-normalize-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before LegalizeBoolPass (hfusion-legalize-bool) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After LegalizeBoolPass (hfusion-legalize-bool) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before SimplifyOps (hfusion-simplify-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump After SimplifyOps (hfusion-simplify-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before HFusionInlineBrc (hfusion-inline-brc) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump After HFusionInlineBrc (hfusion-inline-brc) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before Normalize (hfusion-normalize-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump After Normalize (hfusion-normalize-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before CSE (cse) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After CSE (cse) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before Canonicalizer (canonicalize) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After Canonicalizer (canonicalize) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before NormalizeTensorOps (normalize-tensor-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump After NormalizeTensorOps (normalize-tensor-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before PropagateReshape (propagate-reshape) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump After PropagateReshape (propagate-reshape) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before FoldTensorEmpty (fold-tensor-empty) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump After FoldTensorEmpty (fold-tensor-empty) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before CanonicalizeTensorReshape (canonicalize-tensor-reshape) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump After CanonicalizeTensorReshape (canonicalize-tensor-reshape) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before CSE (cse) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After CSE (cse) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before Canonicalizer (canonicalize) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump After Canonicalizer (canonicalize) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<AIV>, memref.memref_as_ptr} {
  func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
    %2 = tensor.empty() : tensor<32x32xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
      %14 = arith.divsi %1, %c32_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.remsi %1, %c32_i32 : i32
      %17 = arith.divsi %16, %c8_i32 : i32
      %18 = arith.muli %17, %c32_i32 : i32
      %19 = arith.index_cast %18 : i32 to index
      %20 = arith.remsi %1, %c8_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = arith.muli %arg11, %c32_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
      %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
      %alloc_4 = memref.alloc() : memref<32x32xbf16>
      memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
      %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
      %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
      %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
      scf.yield %29 : tensor<32x32xf32>
    }
    %5 = tensor.empty() : tensor<32xf32>
    %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
      (%in: f32, %init: f32) {
        %14 = arith.addf %in, %init : f32
        linalg.yield %14 : f32
      }
    %6 = arith.divsi %1, %c32_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.remsi %1, %c32_i32 : i32
    %9 = arith.divsi %8, %c8_i32 : i32
    %10 = arith.muli %9, %c32_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.remsi %1, %c8_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
    %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
    bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
    return
  }
}


// -----// IR Dump Before NormalizeTensorOps (normalize-tensor-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump After NormalizeTensorOps (normalize-tensor-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

// -----// IR Dump Before FlattenOps (hfusion-flatten-ops) //----- //
func.func @preprocess_kernel(%arg0: memref<?xi8> {hacc.arg_type = #hacc.arg_type<sync_block_lock>}, %arg1: memref<?xi8> {hacc.arg_type = #hacc.arg_type<workspace>}, %arg2: memref<?xbf16>, %arg3: memref<?xbf16>, %arg4: memref<?xf32>, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, mix_mode = "aiv", parallel_mode = "simd"} {
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
  %2 = tensor.empty() : tensor<32x32xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
  %4 = scf.for %arg11 = %c0_i32 to %c16_i32 step %c1_i32 iter_args(%arg12 = %3) -> (tensor<32x32xf32>)  : i32 {
    %14 = arith.divsi %1, %c32_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.remsi %1, %c32_i32 : i32
    %17 = arith.divsi %16, %c8_i32 : i32
    %18 = arith.muli %17, %c32_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = arith.remsi %1, %c8_i32 : i32
    %21 = arith.index_cast %20 : i32 to index
    %22 = arith.muli %arg11, %c32_i32 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview_2 = memref.subview %reinterpret_cast[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_2, %alloc : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %24 = bufferization.to_tensor %alloc restrict : memref<32x32xbf16>
    %25 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%24 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %subview_3 = memref.subview %reinterpret_cast_1[%15, %19, %21, %23] [1, 32, 1, 32] [1, 1, 1, 1] : memref<2x128x8x512xbf16, strided<[524288, 4096, 512, 1]>> to memref<32x32xbf16, strided<[4096, 1], offset: ?>>
    %alloc_4 = memref.alloc() : memref<32x32xbf16>
    memref.copy %subview_3, %alloc_4 : memref<32x32xbf16, strided<[4096, 1], offset: ?>> to memref<32x32xbf16>
    %26 = bufferization.to_tensor %alloc_4 restrict : memref<32x32xbf16>
    %27 = hfusion.cast {enable_overflow = true, round_mode = #hfusion.round_mode<rint>, type_fn = #hfusion.type_fn<cast_signed>} ins(%26 : tensor<32x32xbf16>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %28 = linalg.elemwise_binary {fun = #linalg.binary_fn<mul>} ins(%25, %27 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%2 : tensor<32x32xf32>) -> tensor<32x32xf32>
    %29 = linalg.elemwise_binary {fun = #linalg.binary_fn<add>} ins(%arg12, %28 : tensor<32x32xf32>, tensor<32x32xf32>) outs(%arg12 : tensor<32x32xf32>) -> tensor<32x32xf32>
    scf.yield %29 : tensor<32x32xf32>
  }
  %5 = tensor.empty() : tensor<32xf32>
  %reduced = linalg.reduce ins(%4 : tensor<32x32xf32>) outs(%5 : tensor<32xf32>) dimensions = [1] 
    (%in: f32, %init: f32) {
      %14 = arith.addf %in, %init : f32
      linalg.yield %14 : f32
    }
  %6 = arith.divsi %1, %c32_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %8 = arith.remsi %1, %c32_i32 : i32
  %9 = arith.divsi %8, %c8_i32 : i32
  %10 = arith.muli %9, %c32_i32 : i32
  %11 = arith.index_cast %10 : i32 to index
  %12 = arith.remsi %1, %c8_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview = memref.subview %reinterpret_cast_0[%7, %11, %13] [1, 32, 1] [1, 1, 1] : memref<2x128x8xf32, strided<[1024, 8, 1]>> to memref<32x1xf32, strided<[8, 1], offset: ?>>
  %collapse_shape = memref.collapse_shape %subview [[0, 1]] : memref<32x1xf32, strided<[8, 1], offset: ?>> into memref<32xf32, strided<[8], offset: ?>>
  bufferization.materialize_in_destination %reduced in writable %collapse_shape : (tensor<32xf32>, memref<32xf32, strided<[8], offset: ?>>) -> ()
  return
}

bishengir-compile: /home/w00933195/m60115804/tilelang-mlir-ascend/3rdparty/AscendNPU-IR-Dev/third-party/llvm-project/llvm/include/llvm/ADT/BitVector.h:445: llvm::BitVector::reference llvm::BitVector::operator[](unsigned int): Assertion `Idx < Size && "Out-of-bounds Bit access."' failed.
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace.
Stack dump:
0.	Program arguments: ./bishengir-compile kernel.npuir --target=Ascend950PR_9579 --enable-auto-multi-buffer=true --disable-ffts --enable-triton-kernel-compile=true --enable-hivm-compile=true --enable-vf-merge-level=1 --enable-hfusion-compile=true --enable-auto-bind-sub-block=true -o kernel --mlir-print-ir-before-all --mlir-print-ir-after-all
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  bishengir-compile 0x0000561a55fe5057
1  bishengir-compile 0x0000561a55fe2c5e
2  bishengir-compile 0x0000561a55fe572a
3  libc.so.6         0x00007f1985d39520
4  libc.so.6         0x00007f1985d8d9fc pthread_kill + 300
5  libc.so.6         0x00007f1985d39476 raise + 22
6  libc.so.6         0x00007f1985d1f7f3 abort + 211
7  libc.so.6         0x00007f1985d1f71b
8  libc.so.6         0x00007f1985d30e96
9  bishengir-compile 0x0000561a51a5f86b
10 bishengir-compile 0x0000561a51a6400e
11 bishengir-compile 0x0000561a51a63147
12 bishengir-compile 0x0000561a51a5940c
13 bishengir-compile 0x0000561a51a583f3
14 bishengir-compile 0x0000561a51a5585a
15 bishengir-compile 0x0000561a51a53a0f
16 bishengir-compile 0x0000561a55184b34
17 bishengir-compile 0x0000561a55185161
18 bishengir-compile 0x0000561a5518a35e
19 bishengir-compile 0x0000561a551867db
20 bishengir-compile 0x0000561a55184c78
21 bishengir-compile 0x0000561a55185161
22 bishengir-compile 0x0000561a551876a2
23 bishengir-compile 0x0000561a50c902b9
24 bishengir-compile 0x0000561a50c7608c
25 bishengir-compile 0x0000561a50ba6c83
26 libc.so.6         0x00007f1985d20d90
27 libc.so.6         0x00007f1985d20e40 __libc_start_main + 128
28 bishengir-compile 0x0000561a50ba5b65
