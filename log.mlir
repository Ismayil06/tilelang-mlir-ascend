// -----// IR Dump Before AppendTargetDeviceSpec (hacc-append-device-spec) //----- //
module attributes {hivm.module_core_type = #hivm.module_core_type<MIX>, memref.memref_as_ptr} {
  func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
    hivm.hir.set_ffts_base_addr %arg0
    %c1_i32 = arith.constant 1 : i32
    %0 = arith.index_cast %c1_i32 : i32 to index
    %c512_i32 = arith.constant 512 : i32
    %1 = arith.muli %c512_i32, %c1_i32 : i32
    %2 = arith.index_cast %1 : i32 to index
    %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%2, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
    %c1024_i32 = arith.constant 1024 : i32
    %3 = arith.muli %c1024_i32, %c1_i32 : i32
    %4 = arith.index_cast %3 : i32 to index
    %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%4, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%4, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_2 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%4, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %5 = hivm.hir.get_block_idx -> i64
    %6 = arith.trunci %5 : i64 to i32
    %7 = hivm.hir.get_sub_block_idx -> i64
    %8 = arith.trunci %7 : i64 to i32
    %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    %alloc_3 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    %alloc_4 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %c4_i32 = arith.constant 4 : i32
    %9 = arith.divsi %6, %c4_i32 : i32
    %c128_i32 = arith.constant 128 : i32
    %10 = arith.muli %9, %c128_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.subi %arg7, %10 : i32
    %13 = arith.minsi %c128_i32, %12 : i32
    %14 = arith.index_cast %13 : i32 to index
    %subview = memref.subview %reinterpret_cast[%11, 0] [%14, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_5 = memref.subview %alloc[0, 0] [%14, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_5 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    %15 = arith.remsi %6, %c4_i32 : i32
    %c256_i32 = arith.constant 256 : i32
    %16 = arith.muli %15, %c256_i32 : i32
    %17 = arith.index_cast %16 : i32 to index
    %18 = arith.subi %arg8, %16 : i32
    %19 = arith.minsi %c256_i32, %18 : i32
    %20 = arith.index_cast %19 : i32 to index
    %subview_6 = memref.subview %reinterpret_cast_1[0, %17] [512, %20] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_7 = memref.subview %alloc_3[0, 0] [512, %20] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview_6 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_7 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
    %true = arith.constant true
    %21 = arith.index_cast %c512_i32 : i32 to index
    hivm.hir.mmadL1 ins(%alloc, %alloc_3, %true, %14, %21, %20 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_4 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    %subview_8 = memref.subview %alloc_4[0, 0] [%14, %20] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %subview_9 = memref.subview %reinterpret_cast_0[%11, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.fixpipe ins(%subview_8 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_9 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
    %c0_i32 = arith.constant 0 : i32
    %c15_i32 = arith.constant 15 : i32
    %c1_i32_10 = arith.constant 1 : i32
    scf.for %arg15 = %c0_i32 to %c15_i32 step %c1_i32_10  : i32 {
      hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    }
    return
  }
  func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
    hivm.hir.set_ffts_base_addr %arg0
    %c1_i32 = arith.constant 1 : i32
    %0 = arith.index_cast %c1_i32 : i32 to index
    %c512_i32 = arith.constant 512 : i32
    %1 = arith.muli %c512_i32, %c1_i32 : i32
    %2 = arith.index_cast %1 : i32 to index
    %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%2, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
    %c1024_i32 = arith.constant 1024 : i32
    %3 = arith.muli %c1024_i32, %c1_i32 : i32
    %4 = arith.index_cast %3 : i32 to index
    %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%4, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%4, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_2 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%4, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %5 = hivm.hir.get_block_idx -> i64
    %6 = arith.trunci %5 : i64 to i32
    %7 = hivm.hir.get_sub_block_idx -> i64
    %8 = arith.trunci %7 : i64 to i32
    %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %alloc_3 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %c0_i32 = arith.constant 0 : i32
    %c15_i32 = arith.constant 15 : i32
    %c1_i32_4 = arith.constant 1 : i32
    scf.for %arg15 = %c0_i32 to %c15_i32 step %c1_i32_4  : i32 {
      hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    }
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    %c4_i32 = arith.constant 4 : i32
    %9 = arith.divsi %6, %c4_i32 : i32
    %c128_i32 = arith.constant 128 : i32
    %10 = arith.muli %9, %c128_i32 : i32
    %c64_i32 = arith.constant 64 : i32
    %11 = arith.muli %8, %c64_i32 : i32
    %12 = arith.addi %10, %11 : i32
    %13 = arith.index_cast %12 : i32 to index
    %14 = arith.subi %arg7, %11 : i32
    %15 = arith.subi %14, %10 : i32
    %16 = arith.minsi %c64_i32, %15 : i32
    %17 = arith.index_cast %16 : i32 to index
    %18 = arith.remsi %6, %c4_i32 : i32
    %c256_i32 = arith.constant 256 : i32
    %19 = arith.muli %18, %c256_i32 : i32
    %20 = arith.index_cast %19 : i32 to index
    %21 = arith.subi %arg8, %19 : i32
    %22 = arith.minsi %c256_i32, %21 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%13, %20] [%17, %23] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_5 = memref.subview %alloc[0, 0] [%17, %23] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    memref.copy %subview, %subview_5 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_3 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
    %subview_6 = memref.subview %alloc_3[0, 0] [%17, %23] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %subview_7 = memref.subview %reinterpret_cast_2[%13, %20] [%17, %23] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    memref.copy %subview_6, %subview_7 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    return
  }
}


// -----// IR Dump After AppendTargetDeviceSpec (hacc-append-device-spec) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<MIX>, memref.memref_as_ptr} {
  func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
    hivm.hir.set_ffts_base_addr %arg0
    %c1_i32 = arith.constant 1 : i32
    %0 = arith.index_cast %c1_i32 : i32 to index
    %c512_i32 = arith.constant 512 : i32
    %1 = arith.muli %c512_i32, %c1_i32 : i32
    %2 = arith.index_cast %1 : i32 to index
    %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%2, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
    %c1024_i32 = arith.constant 1024 : i32
    %3 = arith.muli %c1024_i32, %c1_i32 : i32
    %4 = arith.index_cast %3 : i32 to index
    %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%4, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%4, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_2 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%4, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %5 = hivm.hir.get_block_idx -> i64
    %6 = arith.trunci %5 : i64 to i32
    %7 = hivm.hir.get_sub_block_idx -> i64
    %8 = arith.trunci %7 : i64 to i32
    %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    %alloc_3 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    %alloc_4 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %c4_i32 = arith.constant 4 : i32
    %9 = arith.divsi %6, %c4_i32 : i32
    %c128_i32 = arith.constant 128 : i32
    %10 = arith.muli %9, %c128_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.subi %arg7, %10 : i32
    %13 = arith.minsi %c128_i32, %12 : i32
    %14 = arith.index_cast %13 : i32 to index
    %subview = memref.subview %reinterpret_cast[%11, 0] [%14, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_5 = memref.subview %alloc[0, 0] [%14, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_5 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    %15 = arith.remsi %6, %c4_i32 : i32
    %c256_i32 = arith.constant 256 : i32
    %16 = arith.muli %15, %c256_i32 : i32
    %17 = arith.index_cast %16 : i32 to index
    %18 = arith.subi %arg8, %16 : i32
    %19 = arith.minsi %c256_i32, %18 : i32
    %20 = arith.index_cast %19 : i32 to index
    %subview_6 = memref.subview %reinterpret_cast_1[0, %17] [512, %20] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_7 = memref.subview %alloc_3[0, 0] [512, %20] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview_6 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_7 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
    %true = arith.constant true
    %21 = arith.index_cast %c512_i32 : i32 to index
    hivm.hir.mmadL1 ins(%alloc, %alloc_3, %true, %14, %21, %20 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_4 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    %subview_8 = memref.subview %alloc_4[0, 0] [%14, %20] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %subview_9 = memref.subview %reinterpret_cast_0[%11, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.fixpipe ins(%subview_8 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_9 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
    %c0_i32 = arith.constant 0 : i32
    %c15_i32 = arith.constant 15 : i32
    %c1_i32_10 = arith.constant 1 : i32
    scf.for %arg15 = %c0_i32 to %c15_i32 step %c1_i32_10  : i32 {
      hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    }
    return
  }
  func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
    hivm.hir.set_ffts_base_addr %arg0
    %c1_i32 = arith.constant 1 : i32
    %0 = arith.index_cast %c1_i32 : i32 to index
    %c512_i32 = arith.constant 512 : i32
    %1 = arith.muli %c512_i32, %c1_i32 : i32
    %2 = arith.index_cast %1 : i32 to index
    %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%2, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
    %c1024_i32 = arith.constant 1024 : i32
    %3 = arith.muli %c1024_i32, %c1_i32 : i32
    %4 = arith.index_cast %3 : i32 to index
    %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%4, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%4, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_2 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%4, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %5 = hivm.hir.get_block_idx -> i64
    %6 = arith.trunci %5 : i64 to i32
    %7 = hivm.hir.get_sub_block_idx -> i64
    %8 = arith.trunci %7 : i64 to i32
    %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %alloc_3 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %c0_i32 = arith.constant 0 : i32
    %c15_i32 = arith.constant 15 : i32
    %c1_i32_4 = arith.constant 1 : i32
    scf.for %arg15 = %c0_i32 to %c15_i32 step %c1_i32_4  : i32 {
      hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    }
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    %c4_i32 = arith.constant 4 : i32
    %9 = arith.divsi %6, %c4_i32 : i32
    %c128_i32 = arith.constant 128 : i32
    %10 = arith.muli %9, %c128_i32 : i32
    %c64_i32 = arith.constant 64 : i32
    %11 = arith.muli %8, %c64_i32 : i32
    %12 = arith.addi %10, %11 : i32
    %13 = arith.index_cast %12 : i32 to index
    %14 = arith.subi %arg7, %11 : i32
    %15 = arith.subi %14, %10 : i32
    %16 = arith.minsi %c64_i32, %15 : i32
    %17 = arith.index_cast %16 : i32 to index
    %18 = arith.remsi %6, %c4_i32 : i32
    %c256_i32 = arith.constant 256 : i32
    %19 = arith.muli %18, %c256_i32 : i32
    %20 = arith.index_cast %19 : i32 to index
    %21 = arith.subi %arg8, %19 : i32
    %22 = arith.minsi %c256_i32, %21 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%13, %20] [%17, %23] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_5 = memref.subview %alloc[0, 0] [%17, %23] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    memref.copy %subview, %subview_5 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_3 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
    %subview_6 = memref.subview %alloc_3[0, 0] [%17, %23] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %subview_7 = memref.subview %reinterpret_cast_2[%13, %20] [%17, %23] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    memref.copy %subview_6, %subview_7 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    return
  }
}


// -----// IR Dump Before CanonicalizeModule (canonicalize-module) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<MIX>, memref.memref_as_ptr} {
  func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
    hivm.hir.set_ffts_base_addr %arg0
    %c1_i32 = arith.constant 1 : i32
    %0 = arith.index_cast %c1_i32 : i32 to index
    %c512_i32 = arith.constant 512 : i32
    %1 = arith.muli %c512_i32, %c1_i32 : i32
    %2 = arith.index_cast %1 : i32 to index
    %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%2, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
    %c1024_i32 = arith.constant 1024 : i32
    %3 = arith.muli %c1024_i32, %c1_i32 : i32
    %4 = arith.index_cast %3 : i32 to index
    %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%4, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%4, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_2 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%4, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %5 = hivm.hir.get_block_idx -> i64
    %6 = arith.trunci %5 : i64 to i32
    %7 = hivm.hir.get_sub_block_idx -> i64
    %8 = arith.trunci %7 : i64 to i32
    %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    %alloc_3 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    %alloc_4 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %c4_i32 = arith.constant 4 : i32
    %9 = arith.divsi %6, %c4_i32 : i32
    %c128_i32 = arith.constant 128 : i32
    %10 = arith.muli %9, %c128_i32 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = arith.subi %arg7, %10 : i32
    %13 = arith.minsi %c128_i32, %12 : i32
    %14 = arith.index_cast %13 : i32 to index
    %subview = memref.subview %reinterpret_cast[%11, 0] [%14, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_5 = memref.subview %alloc[0, 0] [%14, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_5 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    %15 = arith.remsi %6, %c4_i32 : i32
    %c256_i32 = arith.constant 256 : i32
    %16 = arith.muli %15, %c256_i32 : i32
    %17 = arith.index_cast %16 : i32 to index
    %18 = arith.subi %arg8, %16 : i32
    %19 = arith.minsi %c256_i32, %18 : i32
    %20 = arith.index_cast %19 : i32 to index
    %subview_6 = memref.subview %reinterpret_cast_1[0, %17] [512, %20] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_7 = memref.subview %alloc_3[0, 0] [512, %20] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview_6 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_7 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
    %true = arith.constant true
    %21 = arith.index_cast %c512_i32 : i32 to index
    hivm.hir.mmadL1 ins(%alloc, %alloc_3, %true, %14, %21, %20 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_4 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    %subview_8 = memref.subview %alloc_4[0, 0] [%14, %20] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %subview_9 = memref.subview %reinterpret_cast_0[%11, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.fixpipe ins(%subview_8 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_9 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
    %c0_i32 = arith.constant 0 : i32
    %c15_i32 = arith.constant 15 : i32
    %c1_i32_10 = arith.constant 1 : i32
    scf.for %arg15 = %c0_i32 to %c15_i32 step %c1_i32_10  : i32 {
      hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    }
    return
  }
  func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
    hivm.hir.set_ffts_base_addr %arg0
    %c1_i32 = arith.constant 1 : i32
    %0 = arith.index_cast %c1_i32 : i32 to index
    %c512_i32 = arith.constant 512 : i32
    %1 = arith.muli %c512_i32, %c1_i32 : i32
    %2 = arith.index_cast %1 : i32 to index
    %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%2, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
    %c1024_i32 = arith.constant 1024 : i32
    %3 = arith.muli %c1024_i32, %c1_i32 : i32
    %4 = arith.index_cast %3 : i32 to index
    %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%4, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%4, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_2 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%4, %0] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %5 = hivm.hir.get_block_idx -> i64
    %6 = arith.trunci %5 : i64 to i32
    %7 = hivm.hir.get_sub_block_idx -> i64
    %8 = arith.trunci %7 : i64 to i32
    %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %alloc_3 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %c0_i32 = arith.constant 0 : i32
    %c15_i32 = arith.constant 15 : i32
    %c1_i32_4 = arith.constant 1 : i32
    scf.for %arg15 = %c0_i32 to %c15_i32 step %c1_i32_4  : i32 {
      hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    }
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    %c4_i32 = arith.constant 4 : i32
    %9 = arith.divsi %6, %c4_i32 : i32
    %c128_i32 = arith.constant 128 : i32
    %10 = arith.muli %9, %c128_i32 : i32
    %c64_i32 = arith.constant 64 : i32
    %11 = arith.muli %8, %c64_i32 : i32
    %12 = arith.addi %10, %11 : i32
    %13 = arith.index_cast %12 : i32 to index
    %14 = arith.subi %arg7, %11 : i32
    %15 = arith.subi %14, %10 : i32
    %16 = arith.minsi %c64_i32, %15 : i32
    %17 = arith.index_cast %16 : i32 to index
    %18 = arith.remsi %6, %c4_i32 : i32
    %c256_i32 = arith.constant 256 : i32
    %19 = arith.muli %18, %c256_i32 : i32
    %20 = arith.index_cast %19 : i32 to index
    %21 = arith.subi %arg8, %19 : i32
    %22 = arith.minsi %c256_i32, %21 : i32
    %23 = arith.index_cast %22 : i32 to index
    %subview = memref.subview %reinterpret_cast_0[%13, %20] [%17, %23] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_5 = memref.subview %alloc[0, 0] [%17, %23] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    memref.copy %subview, %subview_5 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_3 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
    %subview_6 = memref.subview %alloc_3[0, 0] [%17, %23] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %subview_7 = memref.subview %reinterpret_cast_2[%13, %20] [%17, %23] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    memref.copy %subview_6, %subview_7 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    return
  }
}


// -----// IR Dump After CanonicalizeModule (canonicalize-module) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<MIX>, memref.memref_as_ptr} {
  func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
    %c1024 = arith.constant 1024 : index
    %c512 = arith.constant 512 : index
    %c1 = arith.constant 1 : index
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %true = arith.constant true
    %c256_i32 = arith.constant 256 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    %c1_i32 = arith.constant 1 : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%c512, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    %alloc_2 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    %alloc_3 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %2 = arith.divsi %1, %c4_i32 : i32
    %3 = arith.muli %2, %c128_i32 : i32
    %4 = arith.index_cast %3 : i32 to index
    %5 = arith.subi %arg7, %3 : i32
    %6 = arith.minsi %5, %c128_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %subview = memref.subview %reinterpret_cast[%4, 0] [%7, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_4 = memref.subview %alloc[0, 0] [%7, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_4 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    %8 = arith.remsi %1, %c4_i32 : i32
    %9 = arith.muli %8, %c256_i32 : i32
    %10 = arith.index_cast %9 : i32 to index
    %11 = arith.subi %arg8, %9 : i32
    %12 = arith.minsi %11, %c256_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview_5 = memref.subview %reinterpret_cast_1[0, %10] [512, %13] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_6 = memref.subview %alloc_2[0, 0] [512, %13] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview_5 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_6 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.mmadL1 ins(%alloc, %alloc_2, %true, %7, %c512, %13 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_3 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    %subview_7 = memref.subview %alloc_3[0, 0] [%7, %13] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %subview_8 = memref.subview %reinterpret_cast_0[%4, %10] [%7, %13] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.fixpipe ins(%subview_7 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_8 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
    scf.for %arg15 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
      hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    }
    return
  }
  func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
    %c1024 = arith.constant 1024 : index
    %c1 = arith.constant 1 : index
    %c256_i32 = arith.constant 256 : i32
    %c64_i32 = arith.constant 64 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    %2 = hivm.hir.get_sub_block_idx -> i64
    %3 = arith.trunci %2 : i64 to i32
    %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %alloc_1 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    scf.for %arg15 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
      hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    }
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    %4 = arith.divsi %1, %c4_i32 : i32
    %5 = arith.muli %4, %c128_i32 : i32
    %6 = arith.muli %3, %c64_i32 : i32
    %7 = arith.addi %5, %6 : i32
    %8 = arith.index_cast %7 : i32 to index
    %9 = arith.subi %arg7, %6 : i32
    %10 = arith.subi %9, %5 : i32
    %11 = arith.minsi %10, %c64_i32 : i32
    %12 = arith.index_cast %11 : i32 to index
    %13 = arith.remsi %1, %c4_i32 : i32
    %14 = arith.muli %13, %c256_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.subi %arg8, %14 : i32
    %17 = arith.minsi %16, %c256_i32 : i32
    %18 = arith.index_cast %17 : i32 to index
    %subview = memref.subview %reinterpret_cast[%8, %15] [%12, %18] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_2 = memref.subview %alloc[0, 0] [%12, %18] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    memref.copy %subview, %subview_2 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_1 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
    %subview_3 = memref.subview %alloc_1[0, 0] [%12, %18] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %subview_4 = memref.subview %reinterpret_cast_0[%8, %15] [%12, %18] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    memref.copy %subview_3, %subview_4 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    return
  }
}


// -----// IR Dump Before Canonicalizer (canonicalize) //----- //
func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
  %c1024 = arith.constant 1024 : index
  %c512 = arith.constant 512 : index
  %c1 = arith.constant 1 : index
  %c15_i32 = arith.constant 15 : i32
  %c0_i32 = arith.constant 0 : i32
  %true = arith.constant true
  %c256_i32 = arith.constant 256 : i32
  %c128_i32 = arith.constant 128 : i32
  %c4_i32 = arith.constant 4 : i32
  %c1_i32 = arith.constant 1 : i32
  hivm.hir.set_ffts_base_addr %arg0
  %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%c512, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
  %alloc_2 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
  %alloc_3 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
  %2 = arith.divsi %1, %c4_i32 : i32
  %3 = arith.muli %2, %c128_i32 : i32
  %4 = arith.index_cast %3 : i32 to index
  %5 = arith.subi %arg7, %3 : i32
  %6 = arith.minsi %5, %c128_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %subview = memref.subview %reinterpret_cast[%4, 0] [%7, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_4 = memref.subview %alloc[0, 0] [%7, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
  hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_4 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
  hivm.hir.pipe_barrier[<PIPE_MTE2>]
  %8 = arith.remsi %1, %c4_i32 : i32
  %9 = arith.muli %8, %c256_i32 : i32
  %10 = arith.index_cast %9 : i32 to index
  %11 = arith.subi %arg8, %9 : i32
  %12 = arith.minsi %11, %c256_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview_5 = memref.subview %reinterpret_cast_1[0, %10] [512, %13] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_6 = memref.subview %alloc_2[0, 0] [512, %13] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
  hivm.hir.nd2nz {dst_continuous} ins(%subview_5 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_6 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
  hivm.hir.mmadL1 ins(%alloc, %alloc_2, %true, %7, %c512, %13 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_3 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
  hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
  %subview_7 = memref.subview %alloc_3[0, 0] [%7, %13] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
  %subview_8 = memref.subview %reinterpret_cast_0[%4, %10] [%7, %13] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  hivm.hir.fixpipe ins(%subview_7 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_8 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
  hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
  hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
  hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
  scf.for %arg15 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
  }
  return
}

// -----// IR Dump Before Canonicalizer (canonicalize) //----- //
func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
  %c1024 = arith.constant 1024 : index
  %c1 = arith.constant 1 : index
  %c256_i32 = arith.constant 256 : i32
  %c64_i32 = arith.constant 64 : i32
  %c128_i32 = arith.constant 128 : i32
  %c4_i32 = arith.constant 4 : i32
  %c15_i32 = arith.constant 15 : i32
  %c0_i32 = arith.constant 0 : i32
  %c1_i32 = arith.constant 1 : i32
  hivm.hir.set_ffts_base_addr %arg0
  %reinterpret_cast = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  %2 = hivm.hir.get_sub_block_idx -> i64
  %3 = arith.trunci %2 : i64 to i32
  %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  %alloc_1 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  scf.for %arg15 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
  }
  hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
  %4 = arith.divsi %1, %c4_i32 : i32
  %5 = arith.muli %4, %c128_i32 : i32
  %6 = arith.muli %3, %c64_i32 : i32
  %7 = arith.addi %5, %6 : i32
  %8 = arith.index_cast %7 : i32 to index
  %9 = arith.subi %arg7, %6 : i32
  %10 = arith.subi %9, %5 : i32
  %11 = arith.minsi %10, %c64_i32 : i32
  %12 = arith.index_cast %11 : i32 to index
  %13 = arith.remsi %1, %c4_i32 : i32
  %14 = arith.muli %13, %c256_i32 : i32
  %15 = arith.index_cast %14 : i32 to index
  %16 = arith.subi %arg8, %14 : i32
  %17 = arith.minsi %16, %c256_i32 : i32
  %18 = arith.index_cast %17 : i32 to index
  %subview = memref.subview %reinterpret_cast[%8, %15] [%12, %18] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_2 = memref.subview %alloc[0, 0] [%12, %18] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  memref.copy %subview, %subview_2 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
  hivm.hir.pipe_barrier[<PIPE_MTE2>]
  hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
  hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
  hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_1 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
  %subview_3 = memref.subview %alloc_1[0, 0] [%12, %18] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  %subview_4 = memref.subview %reinterpret_cast_0[%8, %15] [%12, %18] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  memref.copy %subview_3, %subview_4 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  return
}

// -----// IR Dump After Canonicalizer (canonicalize) //----- //
func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
  %c1024 = arith.constant 1024 : index
  %c512 = arith.constant 512 : index
  %c1 = arith.constant 1 : index
  %c15_i32 = arith.constant 15 : i32
  %c0_i32 = arith.constant 0 : i32
  %true = arith.constant true
  %c256_i32 = arith.constant 256 : i32
  %c128_i32 = arith.constant 128 : i32
  %c4_i32 = arith.constant 4 : i32
  %c1_i32 = arith.constant 1 : i32
  hivm.hir.set_ffts_base_addr %arg0
  %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%c512, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
  %alloc_2 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
  %alloc_3 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
  %2 = arith.divsi %1, %c4_i32 : i32
  %3 = arith.muli %2, %c128_i32 : i32
  %4 = arith.index_cast %3 : i32 to index
  %5 = arith.subi %arg7, %3 : i32
  %6 = arith.minsi %5, %c128_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %subview = memref.subview %reinterpret_cast[%4, 0] [%7, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_4 = memref.subview %alloc[0, 0] [%7, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
  hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_4 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
  hivm.hir.pipe_barrier[<PIPE_MTE2>]
  %8 = arith.remsi %1, %c4_i32 : i32
  %9 = arith.muli %8, %c256_i32 : i32
  %10 = arith.index_cast %9 : i32 to index
  %11 = arith.subi %arg8, %9 : i32
  %12 = arith.minsi %11, %c256_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview_5 = memref.subview %reinterpret_cast_1[0, %10] [512, %13] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_6 = memref.subview %alloc_2[0, 0] [512, %13] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
  hivm.hir.nd2nz {dst_continuous} ins(%subview_5 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_6 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
  hivm.hir.mmadL1 ins(%alloc, %alloc_2, %true, %7, %c512, %13 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_3 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
  hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
  %subview_7 = memref.subview %alloc_3[0, 0] [%7, %13] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
  %subview_8 = memref.subview %reinterpret_cast_0[%4, %10] [%7, %13] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  hivm.hir.fixpipe ins(%subview_7 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_8 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
  hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
  hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
  hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
  scf.for %arg15 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
  }
  return
}

// -----// IR Dump After Canonicalizer (canonicalize) //----- //
func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
  %c1024 = arith.constant 1024 : index
  %c1 = arith.constant 1 : index
  %c256_i32 = arith.constant 256 : i32
  %c64_i32 = arith.constant 64 : i32
  %c128_i32 = arith.constant 128 : i32
  %c4_i32 = arith.constant 4 : i32
  %c15_i32 = arith.constant 15 : i32
  %c0_i32 = arith.constant 0 : i32
  %c1_i32 = arith.constant 1 : i32
  hivm.hir.set_ffts_base_addr %arg0
  %reinterpret_cast = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  %2 = hivm.hir.get_sub_block_idx -> i64
  %3 = arith.trunci %2 : i64 to i32
  %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  %alloc_1 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  scf.for %arg15 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
  }
  hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
  %4 = arith.divsi %1, %c4_i32 : i32
  %5 = arith.muli %4, %c128_i32 : i32
  %6 = arith.muli %3, %c64_i32 : i32
  %7 = arith.addi %5, %6 : i32
  %8 = arith.index_cast %7 : i32 to index
  %9 = arith.subi %arg7, %6 : i32
  %10 = arith.subi %9, %5 : i32
  %11 = arith.minsi %10, %c64_i32 : i32
  %12 = arith.index_cast %11 : i32 to index
  %13 = arith.remsi %1, %c4_i32 : i32
  %14 = arith.muli %13, %c256_i32 : i32
  %15 = arith.index_cast %14 : i32 to index
  %16 = arith.subi %arg8, %14 : i32
  %17 = arith.minsi %16, %c256_i32 : i32
  %18 = arith.index_cast %17 : i32 to index
  %subview = memref.subview %reinterpret_cast[%8, %15] [%12, %18] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_2 = memref.subview %alloc[0, 0] [%12, %18] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  memref.copy %subview, %subview_2 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
  hivm.hir.pipe_barrier[<PIPE_MTE2>]
  hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
  hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
  hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_1 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
  %subview_3 = memref.subview %alloc_1[0, 0] [%12, %18] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  %subview_4 = memref.subview %reinterpret_cast_0[%8, %15] [%12, %18] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  memref.copy %subview_3, %subview_4 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  return
}

// -----// IR Dump Before ConvertHFusionToHIVM (convert-hfusion-to-hivm) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<MIX>, memref.memref_as_ptr} {
  func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
    %c1024 = arith.constant 1024 : index
    %c512 = arith.constant 512 : index
    %c1 = arith.constant 1 : index
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %true = arith.constant true
    %c256_i32 = arith.constant 256 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    %c1_i32 = arith.constant 1 : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%c512, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    %alloc_2 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    %alloc_3 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %2 = arith.divsi %1, %c4_i32 : i32
    %3 = arith.muli %2, %c128_i32 : i32
    %4 = arith.index_cast %3 : i32 to index
    %5 = arith.subi %arg7, %3 : i32
    %6 = arith.minsi %5, %c128_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %subview = memref.subview %reinterpret_cast[%4, 0] [%7, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_4 = memref.subview %alloc[0, 0] [%7, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_4 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    %8 = arith.remsi %1, %c4_i32 : i32
    %9 = arith.muli %8, %c256_i32 : i32
    %10 = arith.index_cast %9 : i32 to index
    %11 = arith.subi %arg8, %9 : i32
    %12 = arith.minsi %11, %c256_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview_5 = memref.subview %reinterpret_cast_1[0, %10] [512, %13] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_6 = memref.subview %alloc_2[0, 0] [512, %13] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview_5 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_6 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.mmadL1 ins(%alloc, %alloc_2, %true, %7, %c512, %13 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_3 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    %subview_7 = memref.subview %alloc_3[0, 0] [%7, %13] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %subview_8 = memref.subview %reinterpret_cast_0[%4, %10] [%7, %13] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.fixpipe ins(%subview_7 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_8 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
    scf.for %arg15 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
      hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    }
    return
  }
  func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
    %c1024 = arith.constant 1024 : index
    %c1 = arith.constant 1 : index
    %c256_i32 = arith.constant 256 : i32
    %c64_i32 = arith.constant 64 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    %2 = hivm.hir.get_sub_block_idx -> i64
    %3 = arith.trunci %2 : i64 to i32
    %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %alloc_1 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    scf.for %arg15 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
      hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    }
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    %4 = arith.divsi %1, %c4_i32 : i32
    %5 = arith.muli %4, %c128_i32 : i32
    %6 = arith.muli %3, %c64_i32 : i32
    %7 = arith.addi %5, %6 : i32
    %8 = arith.index_cast %7 : i32 to index
    %9 = arith.subi %arg7, %6 : i32
    %10 = arith.subi %9, %5 : i32
    %11 = arith.minsi %10, %c64_i32 : i32
    %12 = arith.index_cast %11 : i32 to index
    %13 = arith.remsi %1, %c4_i32 : i32
    %14 = arith.muli %13, %c256_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.subi %arg8, %14 : i32
    %17 = arith.minsi %16, %c256_i32 : i32
    %18 = arith.index_cast %17 : i32 to index
    %subview = memref.subview %reinterpret_cast[%8, %15] [%12, %18] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_2 = memref.subview %alloc[0, 0] [%12, %18] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    memref.copy %subview, %subview_2 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_1 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
    %subview_3 = memref.subview %alloc_1[0, 0] [%12, %18] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %subview_4 = memref.subview %reinterpret_cast_0[%8, %15] [%12, %18] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    memref.copy %subview_3, %subview_4 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    return
  }
}


// -----// IR Dump After ConvertHFusionToHIVM (convert-hfusion-to-hivm) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<MIX>, memref.memref_as_ptr} {
  func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
    %c1024 = arith.constant 1024 : index
    %c512 = arith.constant 512 : index
    %c1 = arith.constant 1 : index
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %true = arith.constant true
    %c256_i32 = arith.constant 256 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    %c1_i32 = arith.constant 1 : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%c512, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    %alloc_2 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    %alloc_3 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %2 = arith.divsi %1, %c4_i32 : i32
    %3 = arith.muli %2, %c128_i32 : i32
    %4 = arith.index_cast %3 : i32 to index
    %5 = arith.subi %arg7, %3 : i32
    %6 = arith.minsi %5, %c128_i32 : i32
    %7 = arith.index_cast %6 : i32 to index
    %subview = memref.subview %reinterpret_cast[%4, 0] [%7, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_4 = memref.subview %alloc[0, 0] [%7, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_4 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    %8 = arith.remsi %1, %c4_i32 : i32
    %9 = arith.muli %8, %c256_i32 : i32
    %10 = arith.index_cast %9 : i32 to index
    %11 = arith.subi %arg8, %9 : i32
    %12 = arith.minsi %11, %c256_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %subview_5 = memref.subview %reinterpret_cast_1[0, %10] [512, %13] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_6 = memref.subview %alloc_2[0, 0] [512, %13] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview_5 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_6 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.mmadL1 ins(%alloc, %alloc_2, %true, %7, %c512, %13 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_3 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    %subview_7 = memref.subview %alloc_3[0, 0] [%7, %13] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %subview_8 = memref.subview %reinterpret_cast_0[%4, %10] [%7, %13] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.fixpipe ins(%subview_7 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_8 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
    scf.for %arg15 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
      hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    }
    return
  }
  func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
    %c1024 = arith.constant 1024 : index
    %c1 = arith.constant 1 : index
    %c256_i32 = arith.constant 256 : i32
    %c64_i32 = arith.constant 64 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %0 = hivm.hir.get_block_idx -> i64
    %1 = arith.trunci %0 : i64 to i32
    %2 = hivm.hir.get_sub_block_idx -> i64
    %3 = arith.trunci %2 : i64 to i32
    %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %alloc_1 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    scf.for %arg15 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
      hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    }
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    %4 = arith.divsi %1, %c4_i32 : i32
    %5 = arith.muli %4, %c128_i32 : i32
    %6 = arith.muli %3, %c64_i32 : i32
    %7 = arith.addi %5, %6 : i32
    %8 = arith.index_cast %7 : i32 to index
    %9 = arith.subi %arg7, %6 : i32
    %10 = arith.subi %9, %5 : i32
    %11 = arith.minsi %10, %c64_i32 : i32
    %12 = arith.index_cast %11 : i32 to index
    %13 = arith.remsi %1, %c4_i32 : i32
    %14 = arith.muli %13, %c256_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = arith.subi %arg8, %14 : i32
    %17 = arith.minsi %16, %c256_i32 : i32
    %18 = arith.index_cast %17 : i32 to index
    %subview = memref.subview %reinterpret_cast[%8, %15] [%12, %18] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_2 = memref.subview %alloc[0, 0] [%12, %18] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    memref.copy %subview, %subview_2 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_1 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
    %subview_3 = memref.subview %alloc_1[0, 0] [%12, %18] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %subview_4 = memref.subview %reinterpret_cast_0[%8, %15] [%12, %18] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    memref.copy %subview_3, %subview_4 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    return
  }
}


// -----// IR Dump Before TritonGlobalKernelArgsToHIVMOp (triton-global-kernel-args-to-hivm-op) //----- //
func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
  %c1024 = arith.constant 1024 : index
  %c512 = arith.constant 512 : index
  %c1 = arith.constant 1 : index
  %c15_i32 = arith.constant 15 : i32
  %c0_i32 = arith.constant 0 : i32
  %true = arith.constant true
  %c256_i32 = arith.constant 256 : i32
  %c128_i32 = arith.constant 128 : i32
  %c4_i32 = arith.constant 4 : i32
  %c1_i32 = arith.constant 1 : i32
  hivm.hir.set_ffts_base_addr %arg0
  %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%c512, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
  %alloc_2 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
  %alloc_3 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
  %2 = arith.divsi %1, %c4_i32 : i32
  %3 = arith.muli %2, %c128_i32 : i32
  %4 = arith.index_cast %3 : i32 to index
  %5 = arith.subi %arg7, %3 : i32
  %6 = arith.minsi %5, %c128_i32 : i32
  %7 = arith.index_cast %6 : i32 to index
  %subview = memref.subview %reinterpret_cast[%4, 0] [%7, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_4 = memref.subview %alloc[0, 0] [%7, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
  hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_4 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
  hivm.hir.pipe_barrier[<PIPE_MTE2>]
  %8 = arith.remsi %1, %c4_i32 : i32
  %9 = arith.muli %8, %c256_i32 : i32
  %10 = arith.index_cast %9 : i32 to index
  %11 = arith.subi %arg8, %9 : i32
  %12 = arith.minsi %11, %c256_i32 : i32
  %13 = arith.index_cast %12 : i32 to index
  %subview_5 = memref.subview %reinterpret_cast_1[0, %10] [512, %13] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_6 = memref.subview %alloc_2[0, 0] [512, %13] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
  hivm.hir.nd2nz {dst_continuous} ins(%subview_5 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_6 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
  hivm.hir.mmadL1 ins(%alloc, %alloc_2, %true, %7, %c512, %13 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_3 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
  hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
  %subview_7 = memref.subview %alloc_3[0, 0] [%7, %13] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
  %subview_8 = memref.subview %reinterpret_cast_0[%4, %10] [%7, %13] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  hivm.hir.fixpipe ins(%subview_7 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_8 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
  hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
  hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
  hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
  scf.for %arg15 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
  }
  return
}

// -----// IR Dump Before TritonGlobalKernelArgsToHIVMOp (triton-global-kernel-args-to-hivm-op) //----- //
func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
  %c1024 = arith.constant 1024 : index
  %c1 = arith.constant 1 : index
  %c256_i32 = arith.constant 256 : i32
  %c64_i32 = arith.constant 64 : i32
  %c128_i32 = arith.constant 128 : i32
  %c4_i32 = arith.constant 4 : i32
  %c15_i32 = arith.constant 15 : i32
  %c0_i32 = arith.constant 0 : i32
  %c1_i32 = arith.constant 1 : i32
  hivm.hir.set_ffts_base_addr %arg0
  %reinterpret_cast = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %0 = hivm.hir.get_block_idx -> i64
  %1 = arith.trunci %0 : i64 to i32
  %2 = hivm.hir.get_sub_block_idx -> i64
  %3 = arith.trunci %2 : i64 to i32
  %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  %alloc_1 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  scf.for %arg15 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
  }
  hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
  %4 = arith.divsi %1, %c4_i32 : i32
  %5 = arith.muli %4, %c128_i32 : i32
  %6 = arith.muli %3, %c64_i32 : i32
  %7 = arith.addi %5, %6 : i32
  %8 = arith.index_cast %7 : i32 to index
  %9 = arith.subi %arg7, %6 : i32
  %10 = arith.subi %9, %5 : i32
  %11 = arith.minsi %10, %c64_i32 : i32
  %12 = arith.index_cast %11 : i32 to index
  %13 = arith.remsi %1, %c4_i32 : i32
  %14 = arith.muli %13, %c256_i32 : i32
  %15 = arith.index_cast %14 : i32 to index
  %16 = arith.subi %arg8, %14 : i32
  %17 = arith.minsi %16, %c256_i32 : i32
  %18 = arith.index_cast %17 : i32 to index
  %subview = memref.subview %reinterpret_cast[%8, %15] [%12, %18] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_2 = memref.subview %alloc[0, 0] [%12, %18] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  memref.copy %subview, %subview_2 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
  hivm.hir.pipe_barrier[<PIPE_MTE2>]
  hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
  hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
  hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_1 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
  %subview_3 = memref.subview %alloc_1[0, 0] [%12, %18] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  %subview_4 = memref.subview %reinterpret_cast_0[%8, %15] [%12, %18] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  memref.copy %subview_3, %subview_4 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  return
}

// -----// IR Dump After TritonGlobalKernelArgsToHIVMOp (triton-global-kernel-args-to-hivm-op) //----- //
func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
  %0 = arith.muli %arg9, %arg10 : i32
  %1 = arith.muli %0, %arg11 : i32
  annotation.mark %1 {logical_block_num} : i32
  %2 = hivm.hir.get_block_idx -> i64
  %3 = arith.trunci %2 : i64 to i32
  %c1_i32 = arith.constant 1 : i32
  %4 = arith.divsi %3, %c1_i32 : i32
  %5 = arith.remsi %4, %arg11 : i32
  %6 = arith.muli %c1_i32, %arg11 : i32
  %7 = arith.divsi %3, %6 : i32
  %8 = arith.remsi %7, %arg10 : i32
  %9 = arith.muli %6, %arg10 : i32
  %10 = arith.divsi %3, %9 : i32
  %11 = arith.remsi %10, %arg9 : i32
  %c1024 = arith.constant 1024 : index
  %c512 = arith.constant 512 : index
  %c1 = arith.constant 1 : index
  %c15_i32 = arith.constant 15 : i32
  %c0_i32 = arith.constant 0 : i32
  %true = arith.constant true
  %c256_i32 = arith.constant 256 : i32
  %c128_i32 = arith.constant 128 : i32
  %c4_i32 = arith.constant 4 : i32
  %c1_i32_0 = arith.constant 1 : i32
  hivm.hir.set_ffts_base_addr %arg0
  %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%c512, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_2 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %12 = hivm.hir.get_block_idx -> i64
  %13 = arith.trunci %12 : i64 to i32
  %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
  %alloc_3 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
  %alloc_4 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
  %14 = arith.divsi %13, %c4_i32 : i32
  %15 = arith.muli %14, %c128_i32 : i32
  %16 = arith.index_cast %15 : i32 to index
  %17 = arith.subi %arg7, %15 : i32
  %18 = arith.minsi %17, %c128_i32 : i32
  %19 = arith.index_cast %18 : i32 to index
  %subview = memref.subview %reinterpret_cast[%16, 0] [%19, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_5 = memref.subview %alloc[0, 0] [%19, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
  hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_5 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
  hivm.hir.pipe_barrier[<PIPE_MTE2>]
  %20 = arith.remsi %13, %c4_i32 : i32
  %21 = arith.muli %20, %c256_i32 : i32
  %22 = arith.index_cast %21 : i32 to index
  %23 = arith.subi %arg8, %21 : i32
  %24 = arith.minsi %23, %c256_i32 : i32
  %25 = arith.index_cast %24 : i32 to index
  %subview_6 = memref.subview %reinterpret_cast_2[0, %22] [512, %25] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_7 = memref.subview %alloc_3[0, 0] [512, %25] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
  hivm.hir.nd2nz {dst_continuous} ins(%subview_6 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_7 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
  hivm.hir.mmadL1 ins(%alloc, %alloc_3, %true, %19, %c512, %25 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_4 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
  hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
  %subview_8 = memref.subview %alloc_4[0, 0] [%19, %25] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
  %subview_9 = memref.subview %reinterpret_cast_1[%16, %22] [%19, %25] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  hivm.hir.fixpipe ins(%subview_8 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_9 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
  hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
  hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
  hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
  scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32_0  : i32 {
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
  }
  return
}

// -----// IR Dump After TritonGlobalKernelArgsToHIVMOp (triton-global-kernel-args-to-hivm-op) //----- //
func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
  %0 = arith.muli %arg9, %arg10 : i32
  %1 = arith.muli %0, %arg11 : i32
  annotation.mark %1 {logical_block_num} : i32
  %2 = hivm.hir.get_block_idx -> i64
  %3 = arith.trunci %2 : i64 to i32
  %c1_i32 = arith.constant 1 : i32
  %4 = arith.divsi %3, %c1_i32 : i32
  %5 = arith.remsi %4, %arg11 : i32
  %6 = arith.muli %c1_i32, %arg11 : i32
  %7 = arith.divsi %3, %6 : i32
  %8 = arith.remsi %7, %arg10 : i32
  %9 = arith.muli %6, %arg10 : i32
  %10 = arith.divsi %3, %9 : i32
  %11 = arith.remsi %10, %arg9 : i32
  %c1024 = arith.constant 1024 : index
  %c1 = arith.constant 1 : index
  %c256_i32 = arith.constant 256 : i32
  %c64_i32 = arith.constant 64 : i32
  %c128_i32 = arith.constant 128 : i32
  %c4_i32 = arith.constant 4 : i32
  %c15_i32 = arith.constant 15 : i32
  %c0_i32 = arith.constant 0 : i32
  %c1_i32_0 = arith.constant 1 : i32
  hivm.hir.set_ffts_base_addr %arg0
  %reinterpret_cast = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %12 = hivm.hir.get_block_idx -> i64
  %13 = arith.trunci %12 : i64 to i32
  %14 = hivm.hir.get_sub_block_idx -> i64
  %15 = arith.trunci %14 : i64 to i32
  %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  %alloc_2 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32_0  : i32 {
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
  }
  hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
  %16 = arith.divsi %13, %c4_i32 : i32
  %17 = arith.muli %16, %c128_i32 : i32
  %18 = arith.muli %15, %c64_i32 : i32
  %19 = arith.addi %17, %18 : i32
  %20 = arith.index_cast %19 : i32 to index
  %21 = arith.subi %arg7, %18 : i32
  %22 = arith.subi %21, %17 : i32
  %23 = arith.minsi %22, %c64_i32 : i32
  %24 = arith.index_cast %23 : i32 to index
  %25 = arith.remsi %13, %c4_i32 : i32
  %26 = arith.muli %25, %c256_i32 : i32
  %27 = arith.index_cast %26 : i32 to index
  %28 = arith.subi %arg8, %26 : i32
  %29 = arith.minsi %28, %c256_i32 : i32
  %30 = arith.index_cast %29 : i32 to index
  %subview = memref.subview %reinterpret_cast[%20, %27] [%24, %30] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_3 = memref.subview %alloc[0, 0] [%24, %30] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  memref.copy %subview, %subview_3 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
  hivm.hir.pipe_barrier[<PIPE_MTE2>]
  hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
  hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
  hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_2 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
  %subview_4 = memref.subview %alloc_2[0, 0] [%24, %30] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  %subview_5 = memref.subview %reinterpret_cast_1[%20, %27] [%24, %30] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  memref.copy %subview_4, %subview_5 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  return
}

// -----// IR Dump Before ConvertTensorToHIVM (convert-tensor-to-hivm) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<MIX>, memref.memref_as_ptr} {
  func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
    %0 = arith.muli %arg9, %arg10 : i32
    %1 = arith.muli %0, %arg11 : i32
    annotation.mark %1 {logical_block_num} : i32
    %2 = hivm.hir.get_block_idx -> i64
    %3 = arith.trunci %2 : i64 to i32
    %c1_i32 = arith.constant 1 : i32
    %4 = arith.divsi %3, %c1_i32 : i32
    %5 = arith.remsi %4, %arg11 : i32
    %6 = arith.muli %c1_i32, %arg11 : i32
    %7 = arith.divsi %3, %6 : i32
    %8 = arith.remsi %7, %arg10 : i32
    %9 = arith.muli %6, %arg10 : i32
    %10 = arith.divsi %3, %9 : i32
    %11 = arith.remsi %10, %arg9 : i32
    %c1024 = arith.constant 1024 : index
    %c512 = arith.constant 512 : index
    %c1 = arith.constant 1 : index
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %true = arith.constant true
    %c256_i32 = arith.constant 256 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    %c1_i32_0 = arith.constant 1 : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%c512, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_2 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %12 = hivm.hir.get_block_idx -> i64
    %13 = arith.trunci %12 : i64 to i32
    %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    %alloc_3 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    %alloc_4 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %14 = arith.divsi %13, %c4_i32 : i32
    %15 = arith.muli %14, %c128_i32 : i32
    %16 = arith.index_cast %15 : i32 to index
    %17 = arith.subi %arg7, %15 : i32
    %18 = arith.minsi %17, %c128_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %subview = memref.subview %reinterpret_cast[%16, 0] [%19, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_5 = memref.subview %alloc[0, 0] [%19, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_5 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    %20 = arith.remsi %13, %c4_i32 : i32
    %21 = arith.muli %20, %c256_i32 : i32
    %22 = arith.index_cast %21 : i32 to index
    %23 = arith.subi %arg8, %21 : i32
    %24 = arith.minsi %23, %c256_i32 : i32
    %25 = arith.index_cast %24 : i32 to index
    %subview_6 = memref.subview %reinterpret_cast_2[0, %22] [512, %25] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_7 = memref.subview %alloc_3[0, 0] [512, %25] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview_6 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_7 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.mmadL1 ins(%alloc, %alloc_3, %true, %19, %c512, %25 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_4 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    %subview_8 = memref.subview %alloc_4[0, 0] [%19, %25] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %subview_9 = memref.subview %reinterpret_cast_1[%16, %22] [%19, %25] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.fixpipe ins(%subview_8 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_9 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
    scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32_0  : i32 {
      hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    }
    return
  }
  func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
    %0 = arith.muli %arg9, %arg10 : i32
    %1 = arith.muli %0, %arg11 : i32
    annotation.mark %1 {logical_block_num} : i32
    %2 = hivm.hir.get_block_idx -> i64
    %3 = arith.trunci %2 : i64 to i32
    %c1_i32 = arith.constant 1 : i32
    %4 = arith.divsi %3, %c1_i32 : i32
    %5 = arith.remsi %4, %arg11 : i32
    %6 = arith.muli %c1_i32, %arg11 : i32
    %7 = arith.divsi %3, %6 : i32
    %8 = arith.remsi %7, %arg10 : i32
    %9 = arith.muli %6, %arg10 : i32
    %10 = arith.divsi %3, %9 : i32
    %11 = arith.remsi %10, %arg9 : i32
    %c1024 = arith.constant 1024 : index
    %c1 = arith.constant 1 : index
    %c256_i32 = arith.constant 256 : i32
    %c64_i32 = arith.constant 64 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %c1_i32_0 = arith.constant 1 : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %12 = hivm.hir.get_block_idx -> i64
    %13 = arith.trunci %12 : i64 to i32
    %14 = hivm.hir.get_sub_block_idx -> i64
    %15 = arith.trunci %14 : i64 to i32
    %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %alloc_2 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32_0  : i32 {
      hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    }
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    %16 = arith.divsi %13, %c4_i32 : i32
    %17 = arith.muli %16, %c128_i32 : i32
    %18 = arith.muli %15, %c64_i32 : i32
    %19 = arith.addi %17, %18 : i32
    %20 = arith.index_cast %19 : i32 to index
    %21 = arith.subi %arg7, %18 : i32
    %22 = arith.subi %21, %17 : i32
    %23 = arith.minsi %22, %c64_i32 : i32
    %24 = arith.index_cast %23 : i32 to index
    %25 = arith.remsi %13, %c4_i32 : i32
    %26 = arith.muli %25, %c256_i32 : i32
    %27 = arith.index_cast %26 : i32 to index
    %28 = arith.subi %arg8, %26 : i32
    %29 = arith.minsi %28, %c256_i32 : i32
    %30 = arith.index_cast %29 : i32 to index
    %subview = memref.subview %reinterpret_cast[%20, %27] [%24, %30] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_3 = memref.subview %alloc[0, 0] [%24, %30] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    memref.copy %subview, %subview_3 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_2 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
    %subview_4 = memref.subview %alloc_2[0, 0] [%24, %30] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %subview_5 = memref.subview %reinterpret_cast_1[%20, %27] [%24, %30] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    memref.copy %subview_4, %subview_5 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    return
  }
}


// -----// IR Dump After ConvertTensorToHIVM (convert-tensor-to-hivm) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<MIX>, memref.memref_as_ptr} {
  func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
    %0 = arith.muli %arg9, %arg10 : i32
    %1 = arith.muli %0, %arg11 : i32
    annotation.mark %1 {logical_block_num} : i32
    %2 = hivm.hir.get_block_idx -> i64
    %3 = arith.trunci %2 : i64 to i32
    %c1_i32 = arith.constant 1 : i32
    %4 = arith.divsi %3, %c1_i32 : i32
    %5 = arith.remsi %4, %arg11 : i32
    %6 = arith.muli %c1_i32, %arg11 : i32
    %7 = arith.divsi %3, %6 : i32
    %8 = arith.remsi %7, %arg10 : i32
    %9 = arith.muli %6, %arg10 : i32
    %10 = arith.divsi %3, %9 : i32
    %11 = arith.remsi %10, %arg9 : i32
    %c1024 = arith.constant 1024 : index
    %c512 = arith.constant 512 : index
    %c1 = arith.constant 1 : index
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %true = arith.constant true
    %c256_i32 = arith.constant 256 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    %c1_i32_0 = arith.constant 1 : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%c512, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_2 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %12 = hivm.hir.get_block_idx -> i64
    %13 = arith.trunci %12 : i64 to i32
    %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    %alloc_3 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    %alloc_4 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %14 = arith.divsi %13, %c4_i32 : i32
    %15 = arith.muli %14, %c128_i32 : i32
    %16 = arith.index_cast %15 : i32 to index
    %17 = arith.subi %arg7, %15 : i32
    %18 = arith.minsi %17, %c128_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %subview = memref.subview %reinterpret_cast[%16, 0] [%19, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_5 = memref.subview %alloc[0, 0] [%19, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_5 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    %20 = arith.remsi %13, %c4_i32 : i32
    %21 = arith.muli %20, %c256_i32 : i32
    %22 = arith.index_cast %21 : i32 to index
    %23 = arith.subi %arg8, %21 : i32
    %24 = arith.minsi %23, %c256_i32 : i32
    %25 = arith.index_cast %24 : i32 to index
    %subview_6 = memref.subview %reinterpret_cast_2[0, %22] [512, %25] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_7 = memref.subview %alloc_3[0, 0] [512, %25] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview_6 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_7 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.mmadL1 ins(%alloc, %alloc_3, %true, %19, %c512, %25 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_4 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    %subview_8 = memref.subview %alloc_4[0, 0] [%19, %25] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %subview_9 = memref.subview %reinterpret_cast_1[%16, %22] [%19, %25] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.fixpipe ins(%subview_8 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_9 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
    scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32_0  : i32 {
      hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    }
    return
  }
  func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
    %0 = arith.muli %arg9, %arg10 : i32
    %1 = arith.muli %0, %arg11 : i32
    annotation.mark %1 {logical_block_num} : i32
    %2 = hivm.hir.get_block_idx -> i64
    %3 = arith.trunci %2 : i64 to i32
    %c1_i32 = arith.constant 1 : i32
    %4 = arith.divsi %3, %c1_i32 : i32
    %5 = arith.remsi %4, %arg11 : i32
    %6 = arith.muli %c1_i32, %arg11 : i32
    %7 = arith.divsi %3, %6 : i32
    %8 = arith.remsi %7, %arg10 : i32
    %9 = arith.muli %6, %arg10 : i32
    %10 = arith.divsi %3, %9 : i32
    %11 = arith.remsi %10, %arg9 : i32
    %c1024 = arith.constant 1024 : index
    %c1 = arith.constant 1 : index
    %c256_i32 = arith.constant 256 : i32
    %c64_i32 = arith.constant 64 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %c1_i32_0 = arith.constant 1 : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %12 = hivm.hir.get_block_idx -> i64
    %13 = arith.trunci %12 : i64 to i32
    %14 = hivm.hir.get_sub_block_idx -> i64
    %15 = arith.trunci %14 : i64 to i32
    %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %alloc_2 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32_0  : i32 {
      hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    }
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    %16 = arith.divsi %13, %c4_i32 : i32
    %17 = arith.muli %16, %c128_i32 : i32
    %18 = arith.muli %15, %c64_i32 : i32
    %19 = arith.addi %17, %18 : i32
    %20 = arith.index_cast %19 : i32 to index
    %21 = arith.subi %arg7, %18 : i32
    %22 = arith.subi %21, %17 : i32
    %23 = arith.minsi %22, %c64_i32 : i32
    %24 = arith.index_cast %23 : i32 to index
    %25 = arith.remsi %13, %c4_i32 : i32
    %26 = arith.muli %25, %c256_i32 : i32
    %27 = arith.index_cast %26 : i32 to index
    %28 = arith.subi %arg8, %26 : i32
    %29 = arith.minsi %28, %c256_i32 : i32
    %30 = arith.index_cast %29 : i32 to index
    %subview = memref.subview %reinterpret_cast[%20, %27] [%24, %30] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_3 = memref.subview %alloc[0, 0] [%24, %30] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    memref.copy %subview, %subview_3 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_2 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
    %subview_4 = memref.subview %alloc_2[0, 0] [%24, %30] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %subview_5 = memref.subview %reinterpret_cast_1[%20, %27] [%24, %30] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    memref.copy %subview_4, %subview_5 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    return
  }
}


// -----// IR Dump Before ConvertToHIVMOp (convert-to-hivm-op) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<MIX>, memref.memref_as_ptr} {
  func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
    %0 = arith.muli %arg9, %arg10 : i32
    %1 = arith.muli %0, %arg11 : i32
    annotation.mark %1 {logical_block_num} : i32
    %2 = hivm.hir.get_block_idx -> i64
    %3 = arith.trunci %2 : i64 to i32
    %c1_i32 = arith.constant 1 : i32
    %4 = arith.divsi %3, %c1_i32 : i32
    %5 = arith.remsi %4, %arg11 : i32
    %6 = arith.muli %c1_i32, %arg11 : i32
    %7 = arith.divsi %3, %6 : i32
    %8 = arith.remsi %7, %arg10 : i32
    %9 = arith.muli %6, %arg10 : i32
    %10 = arith.divsi %3, %9 : i32
    %11 = arith.remsi %10, %arg9 : i32
    %c1024 = arith.constant 1024 : index
    %c512 = arith.constant 512 : index
    %c1 = arith.constant 1 : index
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %true = arith.constant true
    %c256_i32 = arith.constant 256 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    %c1_i32_0 = arith.constant 1 : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%c512, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_2 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %12 = hivm.hir.get_block_idx -> i64
    %13 = arith.trunci %12 : i64 to i32
    %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    %alloc_3 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    %alloc_4 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %14 = arith.divsi %13, %c4_i32 : i32
    %15 = arith.muli %14, %c128_i32 : i32
    %16 = arith.index_cast %15 : i32 to index
    %17 = arith.subi %arg7, %15 : i32
    %18 = arith.minsi %17, %c128_i32 : i32
    %19 = arith.index_cast %18 : i32 to index
    %subview = memref.subview %reinterpret_cast[%16, 0] [%19, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_5 = memref.subview %alloc[0, 0] [%19, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_5 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    %20 = arith.remsi %13, %c4_i32 : i32
    %21 = arith.muli %20, %c256_i32 : i32
    %22 = arith.index_cast %21 : i32 to index
    %23 = arith.subi %arg8, %21 : i32
    %24 = arith.minsi %23, %c256_i32 : i32
    %25 = arith.index_cast %24 : i32 to index
    %subview_6 = memref.subview %reinterpret_cast_2[0, %22] [512, %25] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_7 = memref.subview %alloc_3[0, 0] [512, %25] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview_6 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_7 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.mmadL1 ins(%alloc, %alloc_3, %true, %19, %c512, %25 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_4 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    %subview_8 = memref.subview %alloc_4[0, 0] [%19, %25] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %subview_9 = memref.subview %reinterpret_cast_1[%16, %22] [%19, %25] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.fixpipe ins(%subview_8 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_9 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
    scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32_0  : i32 {
      hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    }
    return
  }
  func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
    %0 = arith.muli %arg9, %arg10 : i32
    %1 = arith.muli %0, %arg11 : i32
    annotation.mark %1 {logical_block_num} : i32
    %2 = hivm.hir.get_block_idx -> i64
    %3 = arith.trunci %2 : i64 to i32
    %c1_i32 = arith.constant 1 : i32
    %4 = arith.divsi %3, %c1_i32 : i32
    %5 = arith.remsi %4, %arg11 : i32
    %6 = arith.muli %c1_i32, %arg11 : i32
    %7 = arith.divsi %3, %6 : i32
    %8 = arith.remsi %7, %arg10 : i32
    %9 = arith.muli %6, %arg10 : i32
    %10 = arith.divsi %3, %9 : i32
    %11 = arith.remsi %10, %arg9 : i32
    %c1024 = arith.constant 1024 : index
    %c1 = arith.constant 1 : index
    %c256_i32 = arith.constant 256 : i32
    %c64_i32 = arith.constant 64 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %c1_i32_0 = arith.constant 1 : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %12 = hivm.hir.get_block_idx -> i64
    %13 = arith.trunci %12 : i64 to i32
    %14 = hivm.hir.get_sub_block_idx -> i64
    %15 = arith.trunci %14 : i64 to i32
    %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %alloc_2 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32_0  : i32 {
      hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    }
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    %16 = arith.divsi %13, %c4_i32 : i32
    %17 = arith.muli %16, %c128_i32 : i32
    %18 = arith.muli %15, %c64_i32 : i32
    %19 = arith.addi %17, %18 : i32
    %20 = arith.index_cast %19 : i32 to index
    %21 = arith.subi %arg7, %18 : i32
    %22 = arith.subi %21, %17 : i32
    %23 = arith.minsi %22, %c64_i32 : i32
    %24 = arith.index_cast %23 : i32 to index
    %25 = arith.remsi %13, %c4_i32 : i32
    %26 = arith.muli %25, %c256_i32 : i32
    %27 = arith.index_cast %26 : i32 to index
    %28 = arith.subi %arg8, %26 : i32
    %29 = arith.minsi %28, %c256_i32 : i32
    %30 = arith.index_cast %29 : i32 to index
    %subview = memref.subview %reinterpret_cast[%20, %27] [%24, %30] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_3 = memref.subview %alloc[0, 0] [%24, %30] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    memref.copy %subview, %subview_3 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_2 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
    %subview_4 = memref.subview %alloc_2[0, 0] [%24, %30] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %subview_5 = memref.subview %reinterpret_cast_1[%20, %27] [%24, %30] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    memref.copy %subview_4, %subview_5 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    return
  }
}


// -----// IR Dump After ConvertToHIVMOp (convert-to-hivm-op) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<MIX>, memref.memref_as_ptr} {
  func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
    %c4_i32 = arith.constant 4 : i32
    %c128_i32 = arith.constant 128 : i32
    %c256_i32 = arith.constant 256 : i32
    %true = arith.constant true
    %c0_i32 = arith.constant 0 : i32
    %c15_i32 = arith.constant 15 : i32
    %c1 = arith.constant 1 : index
    %c512 = arith.constant 512 : index
    %c1024 = arith.constant 1024 : index
    %c1_i32 = arith.constant 1 : i32
    %0 = arith.muli %arg9, %arg10 : i32
    %1 = arith.muli %0, %arg11 : i32
    annotation.mark %1 {logical_block_num} : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%c512, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %2 = hivm.hir.get_block_idx -> i64
    %3 = arith.trunci %2 : i64 to i32
    %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    %alloc_2 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    %alloc_3 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %4 = arith.divsi %3, %c4_i32 : i32
    %5 = arith.muli %4, %c128_i32 : i32
    %6 = arith.index_cast %5 : i32 to index
    %7 = arith.subi %arg7, %5 : i32
    %8 = arith.minsi %7, %c128_i32 : i32
    %9 = arith.index_cast %8 : i32 to index
    %subview = memref.subview %reinterpret_cast[%6, 0] [%9, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_4 = memref.subview %alloc[0, 0] [%9, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_4 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    %10 = arith.remsi %3, %c4_i32 : i32
    %11 = arith.muli %10, %c256_i32 : i32
    %12 = arith.index_cast %11 : i32 to index
    %13 = arith.subi %arg8, %11 : i32
    %14 = arith.minsi %13, %c256_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %subview_5 = memref.subview %reinterpret_cast_1[0, %12] [512, %15] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_6 = memref.subview %alloc_2[0, 0] [512, %15] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview_5 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_6 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.mmadL1 ins(%alloc, %alloc_2, %true, %9, %c512, %15 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_3 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    %subview_7 = memref.subview %alloc_3[0, 0] [%9, %15] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %subview_8 = memref.subview %reinterpret_cast_0[%6, %12] [%9, %15] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.fixpipe ins(%subview_7 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_8 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
    scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
      hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    }
    return
  }
  func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
    %c0 = arith.constant 0 : index
    %c0_i32 = arith.constant 0 : i32
    %c15_i32 = arith.constant 15 : i32
    %c4_i32 = arith.constant 4 : i32
    %c128_i32 = arith.constant 128 : i32
    %c64_i32 = arith.constant 64 : i32
    %c256_i32 = arith.constant 256 : i32
    %c1 = arith.constant 1 : index
    %c1024 = arith.constant 1024 : index
    %c1_i32 = arith.constant 1 : i32
    %0 = arith.muli %arg9, %arg10 : i32
    %1 = arith.muli %0, %arg11 : i32
    annotation.mark %1 {logical_block_num} : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %2 = hivm.hir.get_block_idx -> i64
    %3 = arith.trunci %2 : i64 to i32
    %4 = hivm.hir.get_sub_block_idx -> i64
    %5 = arith.trunci %4 : i64 to i32
    %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %alloc_1 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
      hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    }
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    %6 = arith.divsi %3, %c4_i32 : i32
    %7 = arith.muli %6, %c128_i32 : i32
    %8 = arith.muli %5, %c64_i32 : i32
    %9 = arith.addi %7, %8 : i32
    %10 = arith.index_cast %9 : i32 to index
    %11 = arith.subi %arg7, %8 : i32
    %12 = arith.subi %11, %7 : i32
    %13 = arith.minsi %12, %c64_i32 : i32
    %14 = arith.index_cast %13 : i32 to index
    %15 = arith.remsi %3, %c4_i32 : i32
    %16 = arith.muli %15, %c256_i32 : i32
    %17 = arith.index_cast %16 : i32 to index
    %18 = arith.subi %arg8, %16 : i32
    %19 = arith.minsi %18, %c256_i32 : i32
    %20 = arith.index_cast %19 : i32 to index
    %subview = memref.subview %reinterpret_cast[%10, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_2 = memref.subview %alloc[0, 0] [%14, %20] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    hivm.hir.load ins(%subview : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_2 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>) left_padding_num = %c0 : index eviction_policy = <EvictFirst>
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_1 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
    %subview_3 = memref.subview %alloc_1[0, 0] [%14, %20] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %subview_4 = memref.subview %reinterpret_cast_0[%10, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.store ins(%subview_3 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%subview_4 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
    return
  }
}


// -----// IR Dump Before InitEntryKernel (hivm-init-entry-kernel) //----- //
func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
  %c4_i32 = arith.constant 4 : i32
  %c128_i32 = arith.constant 128 : i32
  %c256_i32 = arith.constant 256 : i32
  %true = arith.constant true
  %c0_i32 = arith.constant 0 : i32
  %c15_i32 = arith.constant 15 : i32
  %c1 = arith.constant 1 : index
  %c512 = arith.constant 512 : index
  %c1024 = arith.constant 1024 : index
  %c1_i32 = arith.constant 1 : i32
  %0 = arith.muli %arg9, %arg10 : i32
  %1 = arith.muli %0, %arg11 : i32
  annotation.mark %1 {logical_block_num} : i32
  hivm.hir.set_ffts_base_addr %arg0
  %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%c512, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %2 = hivm.hir.get_block_idx -> i64
  %3 = arith.trunci %2 : i64 to i32
  %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
  %alloc_2 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
  %alloc_3 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
  %4 = arith.divsi %3, %c4_i32 : i32
  %5 = arith.muli %4, %c128_i32 : i32
  %6 = arith.index_cast %5 : i32 to index
  %7 = arith.subi %arg7, %5 : i32
  %8 = arith.minsi %7, %c128_i32 : i32
  %9 = arith.index_cast %8 : i32 to index
  %subview = memref.subview %reinterpret_cast[%6, 0] [%9, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_4 = memref.subview %alloc[0, 0] [%9, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
  hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_4 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
  hivm.hir.pipe_barrier[<PIPE_MTE2>]
  %10 = arith.remsi %3, %c4_i32 : i32
  %11 = arith.muli %10, %c256_i32 : i32
  %12 = arith.index_cast %11 : i32 to index
  %13 = arith.subi %arg8, %11 : i32
  %14 = arith.minsi %13, %c256_i32 : i32
  %15 = arith.index_cast %14 : i32 to index
  %subview_5 = memref.subview %reinterpret_cast_1[0, %12] [512, %15] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_6 = memref.subview %alloc_2[0, 0] [512, %15] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
  hivm.hir.nd2nz {dst_continuous} ins(%subview_5 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_6 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
  hivm.hir.mmadL1 ins(%alloc, %alloc_2, %true, %9, %c512, %15 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_3 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
  hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
  %subview_7 = memref.subview %alloc_3[0, 0] [%9, %15] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
  %subview_8 = memref.subview %reinterpret_cast_0[%6, %12] [%9, %15] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  hivm.hir.fixpipe ins(%subview_7 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_8 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
  hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
  hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
  hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
  scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
  }
  return
}

// -----// IR Dump Before InitEntryKernel (hivm-init-entry-kernel) //----- //
func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
  %c0 = arith.constant 0 : index
  %c0_i32 = arith.constant 0 : i32
  %c15_i32 = arith.constant 15 : i32
  %c4_i32 = arith.constant 4 : i32
  %c128_i32 = arith.constant 128 : i32
  %c64_i32 = arith.constant 64 : i32
  %c256_i32 = arith.constant 256 : i32
  %c1 = arith.constant 1 : index
  %c1024 = arith.constant 1024 : index
  %c1_i32 = arith.constant 1 : i32
  %0 = arith.muli %arg9, %arg10 : i32
  %1 = arith.muli %0, %arg11 : i32
  annotation.mark %1 {logical_block_num} : i32
  hivm.hir.set_ffts_base_addr %arg0
  %reinterpret_cast = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %2 = hivm.hir.get_block_idx -> i64
  %3 = arith.trunci %2 : i64 to i32
  %4 = hivm.hir.get_sub_block_idx -> i64
  %5 = arith.trunci %4 : i64 to i32
  %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  %alloc_1 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
  }
  hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
  %6 = arith.divsi %3, %c4_i32 : i32
  %7 = arith.muli %6, %c128_i32 : i32
  %8 = arith.muli %5, %c64_i32 : i32
  %9 = arith.addi %7, %8 : i32
  %10 = arith.index_cast %9 : i32 to index
  %11 = arith.subi %arg7, %8 : i32
  %12 = arith.subi %11, %7 : i32
  %13 = arith.minsi %12, %c64_i32 : i32
  %14 = arith.index_cast %13 : i32 to index
  %15 = arith.remsi %3, %c4_i32 : i32
  %16 = arith.muli %15, %c256_i32 : i32
  %17 = arith.index_cast %16 : i32 to index
  %18 = arith.subi %arg8, %16 : i32
  %19 = arith.minsi %18, %c256_i32 : i32
  %20 = arith.index_cast %19 : i32 to index
  %subview = memref.subview %reinterpret_cast[%10, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_2 = memref.subview %alloc[0, 0] [%14, %20] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  hivm.hir.load ins(%subview : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_2 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>) left_padding_num = %c0 : index eviction_policy = <EvictFirst>
  hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
  hivm.hir.pipe_barrier[<PIPE_MTE2>]
  hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
  hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
  hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_1 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
  %subview_3 = memref.subview %alloc_1[0, 0] [%14, %20] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  %subview_4 = memref.subview %reinterpret_cast_0[%10, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  hivm.hir.store ins(%subview_3 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%subview_4 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
  return
}

// -----// IR Dump After InitEntryKernel (hivm-init-entry-kernel) //----- //
func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
  hivm.hir.set_ctrl false at ctrl[60]
  hivm.hir.set_ctrl true at ctrl[48]
  %c4_i32 = arith.constant 4 : i32
  %c128_i32 = arith.constant 128 : i32
  %c256_i32 = arith.constant 256 : i32
  %true = arith.constant true
  %c0_i32 = arith.constant 0 : i32
  %c15_i32 = arith.constant 15 : i32
  %c1 = arith.constant 1 : index
  %c512 = arith.constant 512 : index
  %c1024 = arith.constant 1024 : index
  %c1_i32 = arith.constant 1 : i32
  %0 = arith.muli %arg9, %arg10 : i32
  %1 = arith.muli %0, %arg11 : i32
  annotation.mark %1 {logical_block_num} : i32
  hivm.hir.set_ffts_base_addr %arg0
  %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%c512, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %2 = hivm.hir.get_block_idx -> i64
  %3 = arith.trunci %2 : i64 to i32
  %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
  %alloc_2 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
  %alloc_3 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
  %4 = arith.divsi %3, %c4_i32 : i32
  %5 = arith.muli %4, %c128_i32 : i32
  %6 = arith.index_cast %5 : i32 to index
  %7 = arith.subi %arg7, %5 : i32
  %8 = arith.minsi %7, %c128_i32 : i32
  %9 = arith.index_cast %8 : i32 to index
  %subview = memref.subview %reinterpret_cast[%6, 0] [%9, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_4 = memref.subview %alloc[0, 0] [%9, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
  hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_4 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
  hivm.hir.pipe_barrier[<PIPE_MTE2>]
  %10 = arith.remsi %3, %c4_i32 : i32
  %11 = arith.muli %10, %c256_i32 : i32
  %12 = arith.index_cast %11 : i32 to index
  %13 = arith.subi %arg8, %11 : i32
  %14 = arith.minsi %13, %c256_i32 : i32
  %15 = arith.index_cast %14 : i32 to index
  %subview_5 = memref.subview %reinterpret_cast_1[0, %12] [512, %15] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_6 = memref.subview %alloc_2[0, 0] [512, %15] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
  hivm.hir.nd2nz {dst_continuous} ins(%subview_5 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_6 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
  hivm.hir.mmadL1 ins(%alloc, %alloc_2, %true, %9, %c512, %15 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_3 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
  hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
  %subview_7 = memref.subview %alloc_3[0, 0] [%9, %15] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
  %subview_8 = memref.subview %reinterpret_cast_0[%6, %12] [%9, %15] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  hivm.hir.fixpipe ins(%subview_7 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_8 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
  hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
  hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
  hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
  scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
  }
  return
}

// -----// IR Dump Before Normalize (hivm-normalize-ops) //----- //
func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
  hivm.hir.set_ctrl false at ctrl[60]
  hivm.hir.set_ctrl true at ctrl[48]
  %c4_i32 = arith.constant 4 : i32
  %c128_i32 = arith.constant 128 : i32
  %c256_i32 = arith.constant 256 : i32
  %true = arith.constant true
  %c0_i32 = arith.constant 0 : i32
  %c15_i32 = arith.constant 15 : i32
  %c1 = arith.constant 1 : index
  %c512 = arith.constant 512 : index
  %c1024 = arith.constant 1024 : index
  %c1_i32 = arith.constant 1 : i32
  %0 = arith.muli %arg9, %arg10 : i32
  %1 = arith.muli %0, %arg11 : i32
  annotation.mark %1 {logical_block_num} : i32
  hivm.hir.set_ffts_base_addr %arg0
  %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%c512, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %2 = hivm.hir.get_block_idx -> i64
  %3 = arith.trunci %2 : i64 to i32
  %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
  %alloc_2 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
  %alloc_3 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
  %4 = arith.divsi %3, %c4_i32 : i32
  %5 = arith.muli %4, %c128_i32 : i32
  %6 = arith.index_cast %5 : i32 to index
  %7 = arith.subi %arg7, %5 : i32
  %8 = arith.minsi %7, %c128_i32 : i32
  %9 = arith.index_cast %8 : i32 to index
  %subview = memref.subview %reinterpret_cast[%6, 0] [%9, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_4 = memref.subview %alloc[0, 0] [%9, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
  hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_4 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
  hivm.hir.pipe_barrier[<PIPE_MTE2>]
  %10 = arith.remsi %3, %c4_i32 : i32
  %11 = arith.muli %10, %c256_i32 : i32
  %12 = arith.index_cast %11 : i32 to index
  %13 = arith.subi %arg8, %11 : i32
  %14 = arith.minsi %13, %c256_i32 : i32
  %15 = arith.index_cast %14 : i32 to index
  %subview_5 = memref.subview %reinterpret_cast_1[0, %12] [512, %15] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_6 = memref.subview %alloc_2[0, 0] [512, %15] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
  hivm.hir.nd2nz {dst_continuous} ins(%subview_5 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_6 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
  hivm.hir.mmadL1 ins(%alloc, %alloc_2, %true, %9, %c512, %15 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_3 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
  hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
  %subview_7 = memref.subview %alloc_3[0, 0] [%9, %15] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
  %subview_8 = memref.subview %reinterpret_cast_0[%6, %12] [%9, %15] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  hivm.hir.fixpipe ins(%subview_7 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_8 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
  hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
  hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
  hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
  scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
  }
  return
}

// -----// IR Dump After InitEntryKernel (hivm-init-entry-kernel) //----- //
func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
  hivm.hir.set_ctrl false at ctrl[60]
  hivm.hir.set_ctrl true at ctrl[48]
  %c0 = arith.constant 0 : index
  %c0_i32 = arith.constant 0 : i32
  %c15_i32 = arith.constant 15 : i32
  %c4_i32 = arith.constant 4 : i32
  %c128_i32 = arith.constant 128 : i32
  %c64_i32 = arith.constant 64 : i32
  %c256_i32 = arith.constant 256 : i32
  %c1 = arith.constant 1 : index
  %c1024 = arith.constant 1024 : index
  %c1_i32 = arith.constant 1 : i32
  %0 = arith.muli %arg9, %arg10 : i32
  %1 = arith.muli %0, %arg11 : i32
  annotation.mark %1 {logical_block_num} : i32
  hivm.hir.set_ffts_base_addr %arg0
  %reinterpret_cast = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %2 = hivm.hir.get_block_idx -> i64
  %3 = arith.trunci %2 : i64 to i32
  %4 = hivm.hir.get_sub_block_idx -> i64
  %5 = arith.trunci %4 : i64 to i32
  %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  %alloc_1 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
  }
  hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
  %6 = arith.divsi %3, %c4_i32 : i32
  %7 = arith.muli %6, %c128_i32 : i32
  %8 = arith.muli %5, %c64_i32 : i32
  %9 = arith.addi %7, %8 : i32
  %10 = arith.index_cast %9 : i32 to index
  %11 = arith.subi %arg7, %8 : i32
  %12 = arith.subi %11, %7 : i32
  %13 = arith.minsi %12, %c64_i32 : i32
  %14 = arith.index_cast %13 : i32 to index
  %15 = arith.remsi %3, %c4_i32 : i32
  %16 = arith.muli %15, %c256_i32 : i32
  %17 = arith.index_cast %16 : i32 to index
  %18 = arith.subi %arg8, %16 : i32
  %19 = arith.minsi %18, %c256_i32 : i32
  %20 = arith.index_cast %19 : i32 to index
  %subview = memref.subview %reinterpret_cast[%10, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_2 = memref.subview %alloc[0, 0] [%14, %20] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  hivm.hir.load ins(%subview : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_2 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>) left_padding_num = %c0 : index eviction_policy = <EvictFirst>
  hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
  hivm.hir.pipe_barrier[<PIPE_MTE2>]
  hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
  hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
  hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_1 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
  %subview_3 = memref.subview %alloc_1[0, 0] [%14, %20] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  %subview_4 = memref.subview %reinterpret_cast_0[%10, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  hivm.hir.store ins(%subview_3 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%subview_4 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
  return
}

// -----// IR Dump Before Normalize (hivm-normalize-ops) //----- //
func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
  hivm.hir.set_ctrl false at ctrl[60]
  hivm.hir.set_ctrl true at ctrl[48]
  %c0 = arith.constant 0 : index
  %c0_i32 = arith.constant 0 : i32
  %c15_i32 = arith.constant 15 : i32
  %c4_i32 = arith.constant 4 : i32
  %c128_i32 = arith.constant 128 : i32
  %c64_i32 = arith.constant 64 : i32
  %c256_i32 = arith.constant 256 : i32
  %c1 = arith.constant 1 : index
  %c1024 = arith.constant 1024 : index
  %c1_i32 = arith.constant 1 : i32
  %0 = arith.muli %arg9, %arg10 : i32
  %1 = arith.muli %0, %arg11 : i32
  annotation.mark %1 {logical_block_num} : i32
  hivm.hir.set_ffts_base_addr %arg0
  %reinterpret_cast = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %2 = hivm.hir.get_block_idx -> i64
  %3 = arith.trunci %2 : i64 to i32
  %4 = hivm.hir.get_sub_block_idx -> i64
  %5 = arith.trunci %4 : i64 to i32
  %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  %alloc_1 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
  }
  hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
  %6 = arith.divsi %3, %c4_i32 : i32
  %7 = arith.muli %6, %c128_i32 : i32
  %8 = arith.muli %5, %c64_i32 : i32
  %9 = arith.addi %7, %8 : i32
  %10 = arith.index_cast %9 : i32 to index
  %11 = arith.subi %arg7, %8 : i32
  %12 = arith.subi %11, %7 : i32
  %13 = arith.minsi %12, %c64_i32 : i32
  %14 = arith.index_cast %13 : i32 to index
  %15 = arith.remsi %3, %c4_i32 : i32
  %16 = arith.muli %15, %c256_i32 : i32
  %17 = arith.index_cast %16 : i32 to index
  %18 = arith.subi %arg8, %16 : i32
  %19 = arith.minsi %18, %c256_i32 : i32
  %20 = arith.index_cast %19 : i32 to index
  %subview = memref.subview %reinterpret_cast[%10, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_2 = memref.subview %alloc[0, 0] [%14, %20] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  hivm.hir.load ins(%subview : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_2 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>) left_padding_num = %c0 : index eviction_policy = <EvictFirst>
  hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
  hivm.hir.pipe_barrier[<PIPE_MTE2>]
  hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
  hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
  hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_1 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
  %subview_3 = memref.subview %alloc_1[0, 0] [%14, %20] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  %subview_4 = memref.subview %reinterpret_cast_0[%10, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  hivm.hir.store ins(%subview_3 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%subview_4 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
  return
}

// -----// IR Dump After Normalize (hivm-normalize-ops) //----- //
func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
  %c1_i32 = arith.constant 1 : i32
  %c1024 = arith.constant 1024 : index
  %c512 = arith.constant 512 : index
  %c1 = arith.constant 1 : index
  %c15_i32 = arith.constant 15 : i32
  %c0_i32 = arith.constant 0 : i32
  %true = arith.constant true
  %c256_i32 = arith.constant 256 : i32
  %c128_i32 = arith.constant 128 : i32
  %c4_i32 = arith.constant 4 : i32
  hivm.hir.set_ctrl false at ctrl[60]
  hivm.hir.set_ctrl true at ctrl[48]
  %0 = arith.muli %arg9, %arg10 : i32
  %1 = arith.muli %0, %arg11 : i32
  annotation.mark %1 {logical_block_num} : i32
  hivm.hir.set_ffts_base_addr %arg0
  %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%c512, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %2 = hivm.hir.get_block_idx -> i64
  %3 = arith.trunci %2 : i64 to i32
  %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
  %alloc_2 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
  %alloc_3 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
  %4 = arith.divsi %3, %c4_i32 : i32
  %5 = arith.muli %4, %c128_i32 : i32
  %6 = arith.index_cast %5 : i32 to index
  %7 = arith.subi %arg7, %5 : i32
  %8 = arith.minsi %7, %c128_i32 : i32
  %9 = arith.index_cast %8 : i32 to index
  %subview = memref.subview %reinterpret_cast[%6, 0] [%9, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_4 = memref.subview %alloc[0, 0] [%9, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
  hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_4 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
  hivm.hir.pipe_barrier[<PIPE_MTE2>]
  %10 = arith.remsi %3, %c4_i32 : i32
  %11 = arith.muli %10, %c256_i32 : i32
  %12 = arith.index_cast %11 : i32 to index
  %13 = arith.subi %arg8, %11 : i32
  %14 = arith.minsi %13, %c256_i32 : i32
  %15 = arith.index_cast %14 : i32 to index
  %subview_5 = memref.subview %reinterpret_cast_1[0, %12] [512, %15] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_6 = memref.subview %alloc_2[0, 0] [512, %15] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
  hivm.hir.nd2nz {dst_continuous} ins(%subview_5 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_6 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
  hivm.hir.mmadL1 ins(%alloc, %alloc_2, %true, %9, %c512, %15 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_3 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
  hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
  %subview_7 = memref.subview %alloc_3[0, 0] [%9, %15] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
  %subview_8 = memref.subview %reinterpret_cast_0[%6, %12] [%9, %15] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  hivm.hir.fixpipe ins(%subview_7 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_8 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
  hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
  hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
  hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
  scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
  }
  return
}

// -----// IR Dump After Normalize (hivm-normalize-ops) //----- //
func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
  %c1_i32 = arith.constant 1 : i32
  %c1024 = arith.constant 1024 : index
  %c1 = arith.constant 1 : index
  %c256_i32 = arith.constant 256 : i32
  %c64_i32 = arith.constant 64 : i32
  %c128_i32 = arith.constant 128 : i32
  %c4_i32 = arith.constant 4 : i32
  %c15_i32 = arith.constant 15 : i32
  %c0_i32 = arith.constant 0 : i32
  %c0 = arith.constant 0 : index
  hivm.hir.set_ctrl false at ctrl[60]
  hivm.hir.set_ctrl true at ctrl[48]
  %0 = arith.muli %arg9, %arg10 : i32
  %1 = arith.muli %0, %arg11 : i32
  annotation.mark %1 {logical_block_num} : i32
  hivm.hir.set_ffts_base_addr %arg0
  %reinterpret_cast = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %reinterpret_cast_0 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
  %2 = hivm.hir.get_block_idx -> i64
  %3 = arith.trunci %2 : i64 to i32
  %4 = hivm.hir.get_sub_block_idx -> i64
  %5 = arith.trunci %4 : i64 to i32
  %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  %alloc_1 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
  }
  hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
  %6 = arith.divsi %3, %c4_i32 : i32
  %7 = arith.muli %6, %c128_i32 : i32
  %8 = arith.muli %5, %c64_i32 : i32
  %9 = arith.addi %7, %8 : i32
  %10 = arith.index_cast %9 : i32 to index
  %11 = arith.subi %arg7, %8 : i32
  %12 = arith.subi %11, %7 : i32
  %13 = arith.minsi %12, %c64_i32 : i32
  %14 = arith.index_cast %13 : i32 to index
  %15 = arith.remsi %3, %c4_i32 : i32
  %16 = arith.muli %15, %c256_i32 : i32
  %17 = arith.index_cast %16 : i32 to index
  %18 = arith.subi %arg8, %16 : i32
  %19 = arith.minsi %18, %c256_i32 : i32
  %20 = arith.index_cast %19 : i32 to index
  %subview = memref.subview %reinterpret_cast[%10, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  %subview_2 = memref.subview %alloc[0, 0] [%14, %20] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  hivm.hir.load ins(%subview : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_2 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>) left_padding_num = %c0 : index eviction_policy = <EvictFirst>
  hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
  hivm.hir.pipe_barrier[<PIPE_MTE2>]
  hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
  hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
  hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_1 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
  %subview_3 = memref.subview %alloc_1[0, 0] [%14, %20] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
  %subview_4 = memref.subview %reinterpret_cast_0[%10, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
  hivm.hir.store ins(%subview_3 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%subview_4 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
  return
}

// -----// IR Dump Before RemoveRedundantLoopInit (scf-remove-redundant-loop-init) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<MIX>, memref.memref_as_ptr} {
  func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
    %c1_i32 = arith.constant 1 : i32
    %c1024 = arith.constant 1024 : index
    %c512 = arith.constant 512 : index
    %c1 = arith.constant 1 : index
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %true = arith.constant true
    %c256_i32 = arith.constant 256 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    hivm.hir.set_ctrl false at ctrl[60]
    hivm.hir.set_ctrl true at ctrl[48]
    %0 = arith.muli %arg9, %arg10 : i32
    %1 = arith.muli %0, %arg11 : i32
    annotation.mark %1 {logical_block_num} : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%c512, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %2 = hivm.hir.get_block_idx -> i64
    %3 = arith.trunci %2 : i64 to i32
    %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    %alloc_2 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    %alloc_3 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %4 = arith.divsi %3, %c4_i32 : i32
    %5 = arith.muli %4, %c128_i32 : i32
    %6 = arith.index_cast %5 : i32 to index
    %7 = arith.subi %arg7, %5 : i32
    %8 = arith.minsi %7, %c128_i32 : i32
    %9 = arith.index_cast %8 : i32 to index
    %subview = memref.subview %reinterpret_cast[%6, 0] [%9, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_4 = memref.subview %alloc[0, 0] [%9, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_4 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    %10 = arith.remsi %3, %c4_i32 : i32
    %11 = arith.muli %10, %c256_i32 : i32
    %12 = arith.index_cast %11 : i32 to index
    %13 = arith.subi %arg8, %11 : i32
    %14 = arith.minsi %13, %c256_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %subview_5 = memref.subview %reinterpret_cast_1[0, %12] [512, %15] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_6 = memref.subview %alloc_2[0, 0] [512, %15] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview_5 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_6 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.mmadL1 ins(%alloc, %alloc_2, %true, %9, %c512, %15 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_3 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    %subview_7 = memref.subview %alloc_3[0, 0] [%9, %15] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %subview_8 = memref.subview %reinterpret_cast_0[%6, %12] [%9, %15] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.fixpipe ins(%subview_7 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_8 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
    scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
      hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    }
    return
  }
  func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
    %c1_i32 = arith.constant 1 : i32
    %c1024 = arith.constant 1024 : index
    %c1 = arith.constant 1 : index
    %c256_i32 = arith.constant 256 : i32
    %c64_i32 = arith.constant 64 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %c0 = arith.constant 0 : index
    hivm.hir.set_ctrl false at ctrl[60]
    hivm.hir.set_ctrl true at ctrl[48]
    %0 = arith.muli %arg9, %arg10 : i32
    %1 = arith.muli %0, %arg11 : i32
    annotation.mark %1 {logical_block_num} : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %2 = hivm.hir.get_block_idx -> i64
    %3 = arith.trunci %2 : i64 to i32
    %4 = hivm.hir.get_sub_block_idx -> i64
    %5 = arith.trunci %4 : i64 to i32
    %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %alloc_1 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
      hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    }
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    %6 = arith.divsi %3, %c4_i32 : i32
    %7 = arith.muli %6, %c128_i32 : i32
    %8 = arith.muli %5, %c64_i32 : i32
    %9 = arith.addi %7, %8 : i32
    %10 = arith.index_cast %9 : i32 to index
    %11 = arith.subi %arg7, %8 : i32
    %12 = arith.subi %11, %7 : i32
    %13 = arith.minsi %12, %c64_i32 : i32
    %14 = arith.index_cast %13 : i32 to index
    %15 = arith.remsi %3, %c4_i32 : i32
    %16 = arith.muli %15, %c256_i32 : i32
    %17 = arith.index_cast %16 : i32 to index
    %18 = arith.subi %arg8, %16 : i32
    %19 = arith.minsi %18, %c256_i32 : i32
    %20 = arith.index_cast %19 : i32 to index
    %subview = memref.subview %reinterpret_cast[%10, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_2 = memref.subview %alloc[0, 0] [%14, %20] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    hivm.hir.load ins(%subview : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_2 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>) left_padding_num = %c0 : index eviction_policy = <EvictFirst>
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_1 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
    %subview_3 = memref.subview %alloc_1[0, 0] [%14, %20] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %subview_4 = memref.subview %reinterpret_cast_0[%10, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.store ins(%subview_3 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%subview_4 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
    return
  }
}


// -----// IR Dump After RemoveRedundantLoopInit (scf-remove-redundant-loop-init) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<MIX>, memref.memref_as_ptr} {
  func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
    %c1_i32 = arith.constant 1 : i32
    %c1024 = arith.constant 1024 : index
    %c512 = arith.constant 512 : index
    %c1 = arith.constant 1 : index
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %true = arith.constant true
    %c256_i32 = arith.constant 256 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    hivm.hir.set_ctrl false at ctrl[60]
    hivm.hir.set_ctrl true at ctrl[48]
    %0 = arith.muli %arg9, %arg10 : i32
    %1 = arith.muli %0, %arg11 : i32
    annotation.mark %1 {logical_block_num} : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%c512, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %2 = hivm.hir.get_block_idx -> i64
    %3 = arith.trunci %2 : i64 to i32
    %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    %alloc_2 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    %alloc_3 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %4 = arith.divsi %3, %c4_i32 : i32
    %5 = arith.muli %4, %c128_i32 : i32
    %6 = arith.index_cast %5 : i32 to index
    %7 = arith.subi %arg7, %5 : i32
    %8 = arith.minsi %7, %c128_i32 : i32
    %9 = arith.index_cast %8 : i32 to index
    %subview = memref.subview %reinterpret_cast[%6, 0] [%9, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_4 = memref.subview %alloc[0, 0] [%9, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_4 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    %10 = arith.remsi %3, %c4_i32 : i32
    %11 = arith.muli %10, %c256_i32 : i32
    %12 = arith.index_cast %11 : i32 to index
    %13 = arith.subi %arg8, %11 : i32
    %14 = arith.minsi %13, %c256_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %subview_5 = memref.subview %reinterpret_cast_1[0, %12] [512, %15] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_6 = memref.subview %alloc_2[0, 0] [512, %15] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview_5 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_6 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.mmadL1 ins(%alloc, %alloc_2, %true, %9, %c512, %15 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_3 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    %subview_7 = memref.subview %alloc_3[0, 0] [%9, %15] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %subview_8 = memref.subview %reinterpret_cast_0[%6, %12] [%9, %15] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.fixpipe ins(%subview_7 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_8 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
    scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
      hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    }
    return
  }
  func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
    %c1_i32 = arith.constant 1 : i32
    %c1024 = arith.constant 1024 : index
    %c1 = arith.constant 1 : index
    %c256_i32 = arith.constant 256 : i32
    %c64_i32 = arith.constant 64 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %c0 = arith.constant 0 : index
    hivm.hir.set_ctrl false at ctrl[60]
    hivm.hir.set_ctrl true at ctrl[48]
    %0 = arith.muli %arg9, %arg10 : i32
    %1 = arith.muli %0, %arg11 : i32
    annotation.mark %1 {logical_block_num} : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %2 = hivm.hir.get_block_idx -> i64
    %3 = arith.trunci %2 : i64 to i32
    %4 = hivm.hir.get_sub_block_idx -> i64
    %5 = arith.trunci %4 : i64 to i32
    %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %alloc_1 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
      hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    }
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    %6 = arith.divsi %3, %c4_i32 : i32
    %7 = arith.muli %6, %c128_i32 : i32
    %8 = arith.muli %5, %c64_i32 : i32
    %9 = arith.addi %7, %8 : i32
    %10 = arith.index_cast %9 : i32 to index
    %11 = arith.subi %arg7, %8 : i32
    %12 = arith.subi %11, %7 : i32
    %13 = arith.minsi %12, %c64_i32 : i32
    %14 = arith.index_cast %13 : i32 to index
    %15 = arith.remsi %3, %c4_i32 : i32
    %16 = arith.muli %15, %c256_i32 : i32
    %17 = arith.index_cast %16 : i32 to index
    %18 = arith.subi %arg8, %16 : i32
    %19 = arith.minsi %18, %c256_i32 : i32
    %20 = arith.index_cast %19 : i32 to index
    %subview = memref.subview %reinterpret_cast[%10, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_2 = memref.subview %alloc[0, 0] [%14, %20] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    hivm.hir.load ins(%subview : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_2 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>) left_padding_num = %c0 : index eviction_policy = <EvictFirst>
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_1 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
    %subview_3 = memref.subview %alloc_1[0, 0] [%14, %20] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %subview_4 = memref.subview %reinterpret_cast_0[%10, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.store ins(%subview_3 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%subview_4 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
    return
  }
}


// -----// IR Dump Before NormalizeMatmul (hivm-normalize-matmul) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<MIX>, memref.memref_as_ptr} {
  func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
    %c1_i32 = arith.constant 1 : i32
    %c1024 = arith.constant 1024 : index
    %c512 = arith.constant 512 : index
    %c1 = arith.constant 1 : index
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %true = arith.constant true
    %c256_i32 = arith.constant 256 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    hivm.hir.set_ctrl false at ctrl[60]
    hivm.hir.set_ctrl true at ctrl[48]
    %0 = arith.muli %arg9, %arg10 : i32
    %1 = arith.muli %0, %arg11 : i32
    annotation.mark %1 {logical_block_num} : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%c512, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %2 = hivm.hir.get_block_idx -> i64
    %3 = arith.trunci %2 : i64 to i32
    %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    %alloc_2 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    %alloc_3 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %4 = arith.divsi %3, %c4_i32 : i32
    %5 = arith.muli %4, %c128_i32 : i32
    %6 = arith.index_cast %5 : i32 to index
    %7 = arith.subi %arg7, %5 : i32
    %8 = arith.minsi %7, %c128_i32 : i32
    %9 = arith.index_cast %8 : i32 to index
    %subview = memref.subview %reinterpret_cast[%6, 0] [%9, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_4 = memref.subview %alloc[0, 0] [%9, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_4 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    %10 = arith.remsi %3, %c4_i32 : i32
    %11 = arith.muli %10, %c256_i32 : i32
    %12 = arith.index_cast %11 : i32 to index
    %13 = arith.subi %arg8, %11 : i32
    %14 = arith.minsi %13, %c256_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %subview_5 = memref.subview %reinterpret_cast_1[0, %12] [512, %15] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_6 = memref.subview %alloc_2[0, 0] [512, %15] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview_5 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_6 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.mmadL1 ins(%alloc, %alloc_2, %true, %9, %c512, %15 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_3 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    %subview_7 = memref.subview %alloc_3[0, 0] [%9, %15] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %subview_8 = memref.subview %reinterpret_cast_0[%6, %12] [%9, %15] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.fixpipe ins(%subview_7 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_8 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
    scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
      hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    }
    return
  }
  func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
    %c1_i32 = arith.constant 1 : i32
    %c1024 = arith.constant 1024 : index
    %c1 = arith.constant 1 : index
    %c256_i32 = arith.constant 256 : i32
    %c64_i32 = arith.constant 64 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %c0 = arith.constant 0 : index
    hivm.hir.set_ctrl false at ctrl[60]
    hivm.hir.set_ctrl true at ctrl[48]
    %0 = arith.muli %arg9, %arg10 : i32
    %1 = arith.muli %0, %arg11 : i32
    annotation.mark %1 {logical_block_num} : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %2 = hivm.hir.get_block_idx -> i64
    %3 = arith.trunci %2 : i64 to i32
    %4 = hivm.hir.get_sub_block_idx -> i64
    %5 = arith.trunci %4 : i64 to i32
    %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %alloc_1 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
      hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    }
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    %6 = arith.divsi %3, %c4_i32 : i32
    %7 = arith.muli %6, %c128_i32 : i32
    %8 = arith.muli %5, %c64_i32 : i32
    %9 = arith.addi %7, %8 : i32
    %10 = arith.index_cast %9 : i32 to index
    %11 = arith.subi %arg7, %8 : i32
    %12 = arith.subi %11, %7 : i32
    %13 = arith.minsi %12, %c64_i32 : i32
    %14 = arith.index_cast %13 : i32 to index
    %15 = arith.remsi %3, %c4_i32 : i32
    %16 = arith.muli %15, %c256_i32 : i32
    %17 = arith.index_cast %16 : i32 to index
    %18 = arith.subi %arg8, %16 : i32
    %19 = arith.minsi %18, %c256_i32 : i32
    %20 = arith.index_cast %19 : i32 to index
    %subview = memref.subview %reinterpret_cast[%10, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_2 = memref.subview %alloc[0, 0] [%14, %20] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    hivm.hir.load ins(%subview : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_2 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>) left_padding_num = %c0 : index eviction_policy = <EvictFirst>
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_1 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
    %subview_3 = memref.subview %alloc_1[0, 0] [%14, %20] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %subview_4 = memref.subview %reinterpret_cast_0[%10, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.store ins(%subview_3 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%subview_4 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
    return
  }
}


// -----// IR Dump After NormalizeMatmul (hivm-normalize-matmul) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<MIX>, memref.memref_as_ptr} {
  func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
    %c256 = arith.constant 256 : index
    %c128 = arith.constant 128 : index
    %c1_i32 = arith.constant 1 : i32
    %c1024 = arith.constant 1024 : index
    %c512 = arith.constant 512 : index
    %c1 = arith.constant 1 : index
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %true = arith.constant true
    %c256_i32 = arith.constant 256 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    hivm.hir.set_ctrl false at ctrl[60]
    hivm.hir.set_ctrl true at ctrl[48]
    %0 = arith.muli %arg9, %arg10 : i32
    %1 = arith.muli %0, %arg11 : i32
    annotation.mark %1 {logical_block_num} : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%c512, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %2 = hivm.hir.get_block_idx -> i64
    %3 = arith.trunci %2 : i64 to i32
    %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    %alloc_2 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    %alloc_3 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %4 = arith.divsi %3, %c4_i32 : i32
    %5 = arith.muli %4, %c128_i32 : i32
    %6 = arith.index_cast %5 : i32 to index
    %7 = arith.subi %arg7, %5 : i32
    %8 = arith.minsi %7, %c128_i32 : i32
    %9 = arith.index_cast %8 : i32 to index
    %subview = memref.subview %reinterpret_cast[%6, 0] [%9, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_4 = memref.subview %alloc[0, 0] [%9, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_4 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    %10 = arith.remsi %3, %c4_i32 : i32
    %11 = arith.muli %10, %c256_i32 : i32
    %12 = arith.index_cast %11 : i32 to index
    %13 = arith.subi %arg8, %11 : i32
    %14 = arith.minsi %13, %c256_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %subview_5 = memref.subview %reinterpret_cast_1[0, %12] [512, %15] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_6 = memref.subview %alloc_2[0, 0] [512, %15] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview_5 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_6 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.mmadL1 {already_set_real_mkn} ins(%alloc, %alloc_2, %true, %c128, %c512, %c256 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_3 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    %subview_7 = memref.subview %alloc_3[0, 0] [%9, %15] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %subview_8 = memref.subview %reinterpret_cast_0[%6, %12] [%9, %15] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.fixpipe ins(%subview_7 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_8 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
    scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
      hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    }
    return
  }
  func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
    %c1_i32 = arith.constant 1 : i32
    %c1024 = arith.constant 1024 : index
    %c1 = arith.constant 1 : index
    %c256_i32 = arith.constant 256 : i32
    %c64_i32 = arith.constant 64 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %c0 = arith.constant 0 : index
    hivm.hir.set_ctrl false at ctrl[60]
    hivm.hir.set_ctrl true at ctrl[48]
    %0 = arith.muli %arg9, %arg10 : i32
    %1 = arith.muli %0, %arg11 : i32
    annotation.mark %1 {logical_block_num} : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %2 = hivm.hir.get_block_idx -> i64
    %3 = arith.trunci %2 : i64 to i32
    %4 = hivm.hir.get_sub_block_idx -> i64
    %5 = arith.trunci %4 : i64 to i32
    %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %alloc_1 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
      hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    }
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    %6 = arith.divsi %3, %c4_i32 : i32
    %7 = arith.muli %6, %c128_i32 : i32
    %8 = arith.muli %5, %c64_i32 : i32
    %9 = arith.addi %7, %8 : i32
    %10 = arith.index_cast %9 : i32 to index
    %11 = arith.subi %arg7, %8 : i32
    %12 = arith.subi %11, %7 : i32
    %13 = arith.minsi %12, %c64_i32 : i32
    %14 = arith.index_cast %13 : i32 to index
    %15 = arith.remsi %3, %c4_i32 : i32
    %16 = arith.muli %15, %c256_i32 : i32
    %17 = arith.index_cast %16 : i32 to index
    %18 = arith.subi %arg8, %16 : i32
    %19 = arith.minsi %18, %c256_i32 : i32
    %20 = arith.index_cast %19 : i32 to index
    %subview = memref.subview %reinterpret_cast[%10, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_2 = memref.subview %alloc[0, 0] [%14, %20] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    hivm.hir.load ins(%subview : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_2 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>) left_padding_num = %c0 : index eviction_policy = <EvictFirst>
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_1 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
    %subview_3 = memref.subview %alloc_1[0, 0] [%14, %20] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %subview_4 = memref.subview %reinterpret_cast_0[%10, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.store ins(%subview_3 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%subview_4 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
    return
  }
}


// -----// IR Dump Before InlineFixpipe (hivm-inline-fixpipe) //----- //
module attributes {dlti.target_system_spec = #dlti.target_system_spec<"NPU" : #hacc.target_device_spec<#dlti.dl_entry<"AI_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"CUBE_CORE_COUNT", 28 : i32>, #dlti.dl_entry<"VECTOR_CORE_COUNT", 56 : i32>, #dlti.dl_entry<"UB_SIZE", 2031616 : i32>, #dlti.dl_entry<"L1_SIZE", 4194304 : i32>, #dlti.dl_entry<"L0A_SIZE", 524288 : i32>, #dlti.dl_entry<"L0B_SIZE", 524288 : i32>, #dlti.dl_entry<"L0C_SIZE", 2097152 : i32>, #dlti.dl_entry<"UB_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L1_ALIGN_SIZE", 256 : i32>, #dlti.dl_entry<"L0C_ALIGN_SIZE", 4096 : i32>, #dlti.dl_entry<"MINIMAL_D_CACHE_SIZE", 262144 : i32>, #dlti.dl_entry<"MAXIMUM_D_CACHE_SIZE", 983040 : i32>, #dlti.dl_entry<"ARCH", "dav-c310">>>, hacc.target = #hacc.target<"Ascend950PR_9579">, hivm.module_core_type = #hivm.module_core_type<MIX>, memref.memref_as_ptr} {
  func.func @main_mix_aic(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIC>, hivm.part_of_mix, mix_mode = "mix"} {
    %c256 = arith.constant 256 : index
    %c128 = arith.constant 128 : index
    %c1_i32 = arith.constant 1 : i32
    %c1024 = arith.constant 1024 : index
    %c512 = arith.constant 512 : index
    %c1 = arith.constant 1 : index
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %true = arith.constant true
    %c256_i32 = arith.constant 256 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    hivm.hir.set_ctrl false at ctrl[60]
    hivm.hir.set_ctrl true at ctrl[48]
    %0 = arith.muli %arg9, %arg10 : i32
    %1 = arith.muli %0, %arg11 : i32
    annotation.mark %1 {logical_block_num} : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg3 to offset: [0], sizes: [1024, 512], strides: [%c512, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_1 = memref.reinterpret_cast %arg4 to offset: [0], sizes: [512, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %2 = hivm.hir.get_block_idx -> i64
    %3 = arith.trunci %2 : i64 to i32
    %alloc = memref.alloc() : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    %alloc_2 = memref.alloc() : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    %alloc_3 = memref.alloc() : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %4 = arith.divsi %3, %c4_i32 : i32
    %5 = arith.muli %4, %c128_i32 : i32
    %6 = arith.index_cast %5 : i32 to index
    %7 = arith.subi %arg7, %5 : i32
    %8 = arith.minsi %7, %c128_i32 : i32
    %9 = arith.index_cast %8 : i32 to index
    %subview = memref.subview %reinterpret_cast[%6, 0] [%9, 512] [1, 1] : memref<1024x512xf16, strided<[512, 1]>, #hivm.address_space<gm>> to memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_4 = memref.subview %alloc[0, 0] [%9, 512] [1, 1] : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>> to memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview : memref<?x512xf16, strided<[512, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_4 : memref<?x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    %10 = arith.remsi %3, %c4_i32 : i32
    %11 = arith.muli %10, %c256_i32 : i32
    %12 = arith.index_cast %11 : i32 to index
    %13 = arith.subi %arg8, %11 : i32
    %14 = arith.minsi %13, %c256_i32 : i32
    %15 = arith.index_cast %14 : i32 to index
    %subview_5 = memref.subview %reinterpret_cast_1[0, %12] [512, %15] [1, 1] : memref<512x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_6 = memref.subview %alloc_2[0, 0] [512, %15] [1, 1] : memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>> to memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>
    hivm.hir.nd2nz {dst_continuous} ins(%subview_5 : memref<512x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_6 : memref<512x?xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>)
    hivm.hir.mmadL1 {already_set_real_mkn} ins(%alloc, %alloc_2, %true, %c128, %c512, %c256 : memref<128x512xf16, strided<[512, 1]>, #hivm.address_space<cbuf>>, memref<512x256xf16, strided<[256, 1]>, #hivm.address_space<cbuf>>, i1, index, index, index) outs(%alloc_3 : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>>)
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    %subview_7 = memref.subview %alloc_3[0, 0] [%9, %15] [1, 1] : memref<128x256xf32, strided<[256, 1]>, #hivm.address_space<cc>> to memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>
    %subview_8 = memref.subview %reinterpret_cast_0[%6, %12] [%9, %15] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.fixpipe ins(%subview_7 : memref<?x?xf32, strided<[256, 1]>, #hivm.address_space<cc>>) outs(%subview_8 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0
    hivm.hir.sync_block_set[<CUBE>, <PIPE_FIX>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_BLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 0
    scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
      hivm.hir.sync_block_wait[<CUBE>, <PIPE_S>, <PIPE_FIX>] flag = 1
    }
    return
  }
  func.func @main_mix_aiv(%arg0: i64 {hacc.arg_type = #hacc.arg_type<ffts_base_address>}, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xf16, #hivm.address_space<gm>>, %arg4: memref<?xf16, #hivm.address_space<gm>>, %arg5: memref<?xf16, #hivm.address_space<gm>>, %arg6: memref<?xf16, #hivm.address_space<gm>>, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: i32) attributes {SyncBlockLockArgIdx = 0 : i64, WorkspaceArgIdx = 1 : i64, func_dyn_memref_args = dense<[false, true, true, true, true, true, true, false, false, false, false, false]> : vector<12xi1>, hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>, hivm.func_core_type = #hivm.func_core_type<AIV>, hivm.part_of_mix, mix_mode = "mix"} {
    %c1_i32 = arith.constant 1 : i32
    %c1024 = arith.constant 1024 : index
    %c1 = arith.constant 1 : index
    %c256_i32 = arith.constant 256 : i32
    %c64_i32 = arith.constant 64 : i32
    %c128_i32 = arith.constant 128 : i32
    %c4_i32 = arith.constant 4 : i32
    %c15_i32 = arith.constant 15 : i32
    %c0_i32 = arith.constant 0 : i32
    %c0 = arith.constant 0 : index
    hivm.hir.set_ctrl false at ctrl[60]
    hivm.hir.set_ctrl true at ctrl[48]
    %0 = arith.muli %arg9, %arg10 : i32
    %1 = arith.muli %0, %arg11 : i32
    annotation.mark %1 {logical_block_num} : i32
    hivm.hir.set_ffts_base_addr %arg0
    %reinterpret_cast = memref.reinterpret_cast %arg5 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %reinterpret_cast_0 = memref.reinterpret_cast %arg6 to offset: [0], sizes: [1024, 1024], strides: [%c1024, %c1] : memref<?xf16, #hivm.address_space<gm>> to memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>>
    %2 = hivm.hir.get_block_idx -> i64
    %3 = arith.trunci %2 : i64 to i32
    %4 = hivm.hir.get_sub_block_idx -> i64
    %5 = arith.trunci %4 : i64 to i32
    %alloc = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %alloc_1 = memref.alloc() : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    scf.for %arg12 = %c0_i32 to %c15_i32 step %c1_i32  : i32 {
      hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    }
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    %6 = arith.divsi %3, %c4_i32 : i32
    %7 = arith.muli %6, %c128_i32 : i32
    %8 = arith.muli %5, %c64_i32 : i32
    %9 = arith.addi %7, %8 : i32
    %10 = arith.index_cast %9 : i32 to index
    %11 = arith.subi %arg7, %8 : i32
    %12 = arith.subi %11, %7 : i32
    %13 = arith.minsi %12, %c64_i32 : i32
    %14 = arith.index_cast %13 : i32 to index
    %15 = arith.remsi %3, %c4_i32 : i32
    %16 = arith.muli %15, %c256_i32 : i32
    %17 = arith.index_cast %16 : i32 to index
    %18 = arith.subi %arg8, %16 : i32
    %19 = arith.minsi %18, %c256_i32 : i32
    %20 = arith.index_cast %19 : i32 to index
    %subview = memref.subview %reinterpret_cast[%10, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    %subview_2 = memref.subview %alloc[0, 0] [%14, %20] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    hivm.hir.load ins(%subview : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>) outs(%subview_2 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>) left_padding_num = %c0 : index eviction_policy = <EvictFirst>
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 1
    hivm.hir.pipe_barrier[<PIPE_MTE2>]
    hivm.hir.sync_block_set[<VECTOR>, <PIPE_MTE2>, <PIPE_S>] flag = 0 sync_instr_mode = <INTER_SUBBLOCK_SYNCHRONIZATION>
    hivm.hir.sync_block_wait[<VECTOR>, <PIPE_S>, <PIPE_MTE2>] flag = 0
    hivm.hir.vexp ins(%alloc : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%alloc_1 : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>>)
    %subview_3 = memref.subview %alloc_1[0, 0] [%14, %20] [1, 1] : memref<64x256xf16, strided<[256, 1]>, #hivm.address_space<ub>> to memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>
    %subview_4 = memref.subview %reinterpret_cast_0[%10, %17] [%14, %20] [1, 1] : memref<1024x1024xf16, strided<[1024, 1]>, #hivm.address_space<gm>> to memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>
    hivm.hir.store ins(%subview_3 : memref<?x?xf16, strided<[256, 1]>, #hivm.address_space<ub>>) outs(%subview_4 : memref<?x?xf16, strided<[1024, 1], offset: ?>, #hivm.address_space<gm>>)
    return
  }
}


bishengir-compile-a5: /usr1/BiSheng/AscendNPU-IR-Dev/third-party/llvm-project/llvm/include/llvm/ADT/STLExtras.h:1270: ReferenceT llvm::detail::indexed_accessor_range_base<mlir::ResultRange, mlir::detail::OpResultImpl *, mlir::OpResult, mlir::OpResult, mlir::OpResult>::operator[](size_t) const [DerivedT = mlir::ResultRange, BaseT = mlir::detail::OpResultImpl *, T = mlir::OpResult, PointerT = mlir::OpResult, ReferenceT = mlir::OpResult]: Assertion `Index < size() && "invalid index for value range"' failed.
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace.
Stack dump:
0.	Program arguments: bishengir-compile-a5 ./output/sync_op.mlir --target=Ascend950PR_9579 --enable-auto-multi-buffer=true --disable-ffts --enable-triton-kernel-compile=true --enable-hivm-compile=true --enable-hfusion-compile=false --enable-auto-bind-sub-block=true -o kernel --mlir-print-ir-before-all --mlir-print-ir-after-all
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  bishengir-compile-a5 0x00005581c9b2da95
1  bishengir-compile-a5 0x00005581c9b2b37e
2  bishengir-compile-a5 0x00005581c9b2e1db
3  libc.so.6            0x00007f8822dcc520
4  libc.so.6            0x00007f8822e209fc pthread_kill + 300
5  libc.so.6            0x00007f8822dcc476 raise + 22
6  libc.so.6            0x00007f8822db27f3 abort + 211
7  libc.so.6            0x00007f8822db271b
8  libc.so.6            0x00007f8822dc3e96
9  bishengir-compile-a5 0x00005581c5d06139
10 bishengir-compile-a5 0x00005581c5bed26a
11 bishengir-compile-a5 0x00005581c8af06c9
12 bishengir-compile-a5 0x00005581c8aece73
13 bishengir-compile-a5 0x00005581c8aca0d0
14 bishengir-compile-a5 0x00005581c8ac65f9
15 bishengir-compile-a5 0x00005581c5d0cae1
16 bishengir-compile-a5 0x00005581c8bed0a6
17 bishengir-compile-a5 0x00005581c8bed701
18 bishengir-compile-a5 0x00005581c8befd4d
19 bishengir-compile-a5 0x00005581c40e0ba2
20 bishengir-compile-a5 0x00005581c40f78bb
21 bishengir-compile-a5 0x00005581c40da056
22 bishengir-compile-a5 0x00005581c3ff8225
23 libc.so.6            0x00007f8822db3d90
24 libc.so.6            0x00007f8822db3e40 __libc_start_main + 128
25 bishengir-compile-a5 0x00005581c3ff70e9
