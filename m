Return-Path: <linux-arch+bounces-4260-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ADD8BF576
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 07:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F046E1F25942
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 05:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943F814AA8;
	Wed,  8 May 2024 05:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TmRmyflO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FF1364;
	Wed,  8 May 2024 05:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715144897; cv=none; b=oeN4ZaOE7pOYnH2K5gDcM4uNIVkUIlHhlFeT6yPjVtfMyaSn3lTyWEUSZIH1U+VaHfZ1Lcl0BNYxK822MwBjEMaONhodPABgKLS5Frqq0M369s3oEdAFpoZ9pFRRHELbRFzZAypcKwyhiSxkxCpwtXy5jcfQB3IAoX5x0y7D62U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715144897; c=relaxed/simple;
	bh=vpsG8f3nMzzRpd797SW99H6zkeYYhDRtUW9MAPXclt8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FKkbSQ+ozqBwpYH2WVSOIt4Qc/iQs3hY8fAJQn5KJ9i1iEudyETiYE68yhD5gWTCe/uV991SJ+Q1k4RBZNakevWXJgVfyIZcz2Q/nB5oir1ZugHiWBRm4I4EWJTkMv2Nb9qgDRSZNi+tz63J9tIeSCCakyWEX53Cvwxo5iBBRRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TmRmyflO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715144892; x=1746680892;
  h=date:from:to:cc:subject:message-id;
  bh=vpsG8f3nMzzRpd797SW99H6zkeYYhDRtUW9MAPXclt8=;
  b=TmRmyflOVEPyGbdb7vd081Vn/Mn1RVnY+I3FNKjvO7sSbqaQgWYFsqja
   eRZE7Vpi5FcXl3dHoqudSe987xtgyiYnnTpdtQ1p7cBzC36YPcDm6hVWg
   ALju33ysKVt3azCIzYt04o9OrtVM4BQkw93r0eHcU6piXTmRLZ4ppE9HT
   0+a5cawIW/WHDj7Ys915XtNj8mNjRFsQwbJOEa/r9E7KfK5MzDc+RAXAX
   DoPsxW2+JKmeXzZZFsqrXOf/B2Bl9h4SGTe4PAtxpACQGyYFEq9ggbAKB
   d1/E1Bq93AsPInIKqs5pT3dSyUcDVjYfzcNKvKIcfBfOk3NGoUh86zXoK
   g==;
X-CSE-ConnectionGUID: QOsAacQ3SeOSKxdMJZwueQ==
X-CSE-MsgGUID: lbvhfopcQ9udblitl3bQbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10821453"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="10821453"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 22:08:11 -0700
X-CSE-ConnectionGUID: Sz2BiZXKTiayJFFzwhnMnw==
X-CSE-MsgGUID: b0OJqIP4Ry+KRqpmHNgA/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="29289923"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 07 May 2024 22:08:07 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4ZX9-00030S-3C;
	Wed, 08 May 2024 05:08:03 +0000
Date: Wed, 08 May 2024 13:07:40 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 nouveau@lists.freedesktop.org
Subject: [linux-next:master] BUILD REGRESSION
 93a39e4766083050ca0ecd6a3548093a3b9eb60c
Message-ID: <202405081332.sESCRoxn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 93a39e4766083050ca0ecd6a3548093a3b9eb60c  Add linux-next specific files for 20240507

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202405080133.16ZI5eaY-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202405080300.iTZpE1xH-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202405080553.tfH9EmS8-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202405080801.QqazYmz6-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

/usr/bin/ld: drivers/net/dsa/realtek/rtl8366rb.c:980:(.text+0x2808): undefined reference to `devm_led_classdev_register_ext'
ERROR: modpost: "drm_dsc_pps_payload_pack" [drivers/gpu/drm/panel/panel-lg-sw43408.ko] undefined!
aarch64-linux-ld: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:320:(.text+0x850): undefined reference to `kunit_binary_assert_format'
aarch64-linux-ld: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:322:(.text+0x734): undefined reference to `kunit_mem_assert_format'
aarch64-linux-ld: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:58:(.text+0x5ec): undefined reference to `kunit_binary_ptr_assert_format'
aarch64-linux-ld: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:58:(.text+0x60c): undefined reference to `__kunit_abort'
aarch64-linux-ld: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:77:(.text+0x5a0): undefined reference to `kunit_unary_assert_format'
aarch64-linux-ld: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:77:(.text+0x5b0): undefined reference to `__kunit_do_failed_assertion'
csky-linux-ld: panel-lg-sw43408.c:(.text+0x310): undefined reference to `drm_dsc_pps_payload_pack'
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:1734:62: error: bitwise operation between different enumeration types ('enum amd_asic_type' and 'enum amd_chip_flags') [-Werror,-Wenum-enum-conversion]
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:723:42: error: arithmetic between different enumeration types ('enum amdgpu_ras_block' and 'enum amdgpu_ras_mca_block') [-Werror,-Wenum-enum-conversion]
drivers/gpu/drm/arm/display/komeda/komeda_dev.c:26:37: error: invalid use of undefined type 'struct seq_file'
drivers/gpu/drm/arm/display/komeda/komeda_dev.c:29:9: error: implicit declaration of function 'seq_puts' [-Werror=implicit-function-declaration]
drivers/gpu/drm/arm/display/komeda/komeda_dev.c:44:1: error: type defaults to 'int' in declaration of 'DEFINE_SHOW_ATTRIBUTE' [-Werror=implicit-int]
drivers/gpu/drm/drm_mm.c:614:20: error: function 'drm_mm_node_scanned_block' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
drivers/gpu/drm/imx/ipuv3/imx-ldb.c:658:57: error: '_sel' directive output may be truncated writing 4 bytes into a region of size between 3 and 13 [-Werror=format-truncation=]
drivers/gpu/drm/nouveau/nouveau_backlight.c:56:69: error: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 3 [-Werror=format-truncation=]
drivers/gpu/drm/nouveau/nvif/object.c:161:9: error: 'memcpy' accessing 4294967264 or more bytes at offsets 0 and 32 overlaps 6442450881 bytes at offset -2147483617 [-Werror=restrict]
drivers/gpu/drm/pl111/pl111_versatile.c:488:24: error: cast to smaller integer type 'enum versatile_clcd' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
drivers/gpu/drm/radeon/radeon_drv.c:251:2: error: bitwise operation between different enumeration types ('enum radeon_family' and 'enum radeon_chip_flags') [-Werror,-Wenum-enum-conversion]
drivers/gpu/drm/renesas/rcar-du/rcar_cmm.c:35:19: error: unused function 'rcar_cmm_read' [-Werror,-Wunused-function]
drivers/gpu/drm/xlnx/zynqmp_disp.c:949:14: error: logical not is only applied to the left hand side of this comparison [-Werror,-Wlogical-not-parentheses]
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:322:(.text+0x728): undefined reference to `kunit_mem_assert_format'
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:77:(.text+0x598): dangerous relocation: unsupported relocation
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:77:(.text+0x598): undefined reference to `kunit_unary_assert_format'
include/asm-generic/io.h:547:31: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
include/kunit/test.h:444:(.text+0x440): undefined reference to `kunit_kmalloc_array'
kernel/bpf/verifier.c:20086:85: error: 'pcpu_hot' undeclared (first use in this function)
ld.lld: error: undefined symbol: drm_dsc_pps_payload_pack
panel-lg-sw43408.c:(.text+0x278): undefined reference to `drm_dsc_pps_payload_pack'
panel-lg-sw43408.c:(.text+0x934): undefined reference to `.drm_dsc_pps_payload_pack'

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/net/dsa/realtek/rtl8366rb.c:1032:4-15: ERROR: probable double put.

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arc-randconfig-001-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- arc-randconfig-002-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- arc-randconfig-r051-20240507
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arc-randconfig-r121-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm-randconfig-001-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- arm-randconfig-003-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- arm64-defconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm64-randconfig-r023-20221023
|   |-- aarch64-linux-ld:drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):undefined-reference-to-__kunit_abort
|   |-- aarch64-linux-ld:drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):undefined-reference-to-__kunit_do_failed_assertion
|   |-- aarch64-linux-ld:drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):undefined-reference-to-kunit_binary_assert_format
|   |-- aarch64-linux-ld:drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):undefined-reference-to-kunit_binary_ptr_assert_format
|   |-- aarch64-linux-ld:drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):undefined-reference-to-kunit_mem_assert_format
|   |-- aarch64-linux-ld:drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):undefined-reference-to-kunit_unary_assert_format
|   |-- drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):dangerous-relocation:unsupported-relocation
|   |-- drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):undefined-reference-to-kunit_mem_assert_format
|   |-- drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):undefined-reference-to-kunit_unary_assert_format
|   `-- include-kunit-test.h:(.text):undefined-reference-to-kunit_kmalloc_array
|-- csky-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- csky-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- csky-randconfig-002-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- csky-randconfig-002-20240508
|   |-- csky-linux-ld:panel-lg-sw43408.c:(.text):undefined-reference-to-drm_dsc_pps_payload_pack
|   `-- panel-lg-sw43408.c:(.text):undefined-reference-to-drm_dsc_pps_payload_pack
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-buildonly-randconfig-004-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-randconfig-002-20240507
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-011-20240507
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-014-20240507
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-015-20240507
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-052-20240507
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- loongarch-defconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- loongarch-randconfig-001-20240507
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- loongarch-randconfig-002-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- m68k-allmodconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- m68k-allyesconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- m68k-randconfig-r052-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- m68k-randconfig-r062-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- m68k-randconfig-r063-20240507
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- microblaze-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- microblaze-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- microblaze-randconfig-r052-20240508
|   |-- drivers-gpu-drm-arm-display-komeda-komeda_dev.c:error:implicit-declaration-of-function-seq_puts
|   |-- drivers-gpu-drm-arm-display-komeda-komeda_dev.c:error:invalid-use-of-undefined-type-struct-seq_file
|   `-- drivers-gpu-drm-arm-display-komeda-komeda_dev.c:error:type-defaults-to-int-in-declaration-of-DEFINE_SHOW_ATTRIBUTE
|-- microblaze-randconfig-r062-20240507
|   `-- drivers-net-dsa-realtek-rtl8366rb.c:ERROR:probable-double-put.
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- nios2-allmodconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- nios2-allyesconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- nios2-randconfig-001-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- openrisc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- parisc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-nouveau-nvif-object.c:error:memcpy-accessing-or-more-bytes-at-offsets-and-overlaps-bytes-at-offset
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- parisc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- parisc-randconfig-001-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- powerpc-randconfig-001-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- powerpc-randconfig-r053-20240507
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-calcs-dcn_calc_auto.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-calcs-dcn_calc_math.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-calcs-dcn_calcs.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn20-dcn20_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn20-display_mode_vba_20.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn20-display_mode_vba_20v2.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn20-display_rq_dlg_calc_20.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn20-display_rq_dlg_calc_20v2.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn21-display_mode_vba_21.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn21-display_rq_dlg_calc_21.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn30-dcn30_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn30-display_mode_vba_30.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn30-display_rq_dlg_calc_30.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn301-dcn301_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn302-dcn302_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn303-dcn303_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn31-dcn31_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn31-display_mode_vba_31.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn31-display_rq_dlg_calc_31.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn314-dcn314_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn314-display_mode_vba_314.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn314-display_rq_dlg_calc_314.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn32-dcn32_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn32-display_mode_vba_32.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn32-display_mode_vba_util_32.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn32-display_rq_dlg_calc_32.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn321-dcn321_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn35-dcn35_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn351-dcn351_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn401-dcn401_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-display_mode_vba.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dml1_display_rq_dlg_calc.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dsc-rc_calc_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-display_mode_core.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-display_mode_util.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-dml21_translation_helper.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-dml21_utils.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-src-dml2_core-dml2_core_dcn4.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-src-dml2_core-dml2_core_dcn4_calcs.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-src-dml2_core-dml2_core_shared.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-src-dml2_dpmm-dml2_dpmm_dcn4.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-src-dml2_mcg-dml2_mcg_dcn4.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-src-dml2_pmo-dml2_pmo_dcn3.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-src-dml2_pmo-dml2_pmo_dcn4.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-src-dml2_pmo-dml2_pmo_dcn4_fams2.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-src-dml2_standalone_libraries-lib_float_math.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-src-dml2_top-dml_top_mcache.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml2_mall_phantom.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml2_policy.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml2_translation_helper.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml2_utils.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml2_wrapper.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   `-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml_display_rq_dlg_calc.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|-- powerpc-randconfig-r113-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- powerpc64-randconfig-001-20240507
|   `-- panel-lg-sw43408.c:(.text):undefined-reference-to-drm_dsc_pps_payload_pack
|-- powerpc64-randconfig-002-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- riscv-randconfig-002-20240507
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- sh-allmodconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sh-allyesconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sh-randconfig-002-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sparc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- sparc-randconfig-001-20240507
|   |-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sparc-randconfig-002-20240507
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- sparc64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- sparc64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- sparc64-randconfig-001-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sparc64-randconfig-002-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- um-allyesconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   `-- kernel-bpf-verifier.c:error:pcpu_hot-undeclared-(first-use-in-this-function)
|-- um-randconfig-r034-20230622
|   `-- usr-bin-ld:drivers-net-dsa-realtek-rtl8366rb.c:(.text):undefined-reference-to-devm_led_classdev_register_ext
|-- x86_64-randconfig-102-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-104-20240507
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-121-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-123-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-r122-20240507
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_core-dml2_core_dcn4_calcs.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_core-dml2_core_factory.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_core-dml2_core_shared.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_dpmm-dml2_dpmm_factory.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_mcg-dml2_mcg_factory.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_pmo-dml2_pmo_dcn4.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_pmo-dml2_pmo_factory.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_top-dml_top_mcache.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dmub-src-dmub_dcn401.c:sparse:sparse:static-assertion-failed:DMUB-command-size-mismatch
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- xtensa-randconfig-001-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- xtensa-randconfig-002-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
`-- xtensa-randconfig-r054-20240507
    `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
clang_recent_errors
|-- arm-defconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm-randconfig-002-20240507
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm-randconfig-004-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- arm64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-renesas-rcar-du-rcar_cmm.c:error:unused-function-rcar_cmm_read-Werror-Wunused-function
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm64-randconfig-001-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- arm64-randconfig-003-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- arm64-randconfig-004-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- hexagon-randconfig-001-20240508
|   `-- ld.lld:error:undefined-symbol:drm_dsc_pps_payload_pack
|-- hexagon-randconfig-002-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- hexagon-randconfig-r061-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- hexagon-randconfig-r132-20240507
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-buildonly-randconfig-002-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- i386-buildonly-randconfig-003-20240507
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-001-20240507
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-005-20240507
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-012-20240507
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-013-20240507
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-016-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- i386-randconfig-051-20240507
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-053-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- i386-randconfig-054-20240507
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-061-20240507
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-063-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- i386-randconfig-141-20240507
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   `-- net-ipv6-route.c-rt6_fill_node()-error:we-previously-assumed-dst-could-be-null-(see-line-)
|-- powerpc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- powerpc-randconfig-002-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- powerpc-randconfig-003-20240507
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- powerpc64-randconfig-003-20240507
|   |-- drivers-gpu-drm-drm_mm.c:error:function-drm_mm_node_scanned_block-is-not-needed-and-will-not-be-emitted-Werror-Wunneeded-internal-declaration
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   `-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|-- powerpc64-randconfig-r131-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- riscv-randconfig-001-20240507
|   `-- ERROR:drm_dsc_pps_payload_pack-drivers-gpu-drm-panel-panel-lg-sw43408.ko-undefined
|-- s390-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-xlnx-zynqmp_disp.c:error:logical-not-is-only-applied-to-the-left-hand-side-of-this-comparison-Werror-Wlogical-not-parentheses
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   `-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|-- s390-randconfig-002-20240507
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- x86_64-allnoconfig
|   |-- Warning:MAINTAINERS-references-a-file-that-doesn-t-exist:Documentation-devicetree-bindings-display-exynos
|   |-- Warning:MAINTAINERS-references-a-file-that-doesn-t-exist:Documentation-devicetree-bindings-reserved-memory-qcom
|   `-- net-ipv6-udp.c:trace-events-udp.h-is-included-more-than-once.
|-- x86_64-randconfig-101-20240507
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   `-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|-- x86_64-randconfig-161-20240507
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   |-- drivers-usb-typec-ucsi-ucsi.c-ucsi_get_pd_caps()-warn:passing-zero-to-ERR_PTR
|   `-- net-ipv6-route.c-rt6_fill_node()-error:we-previously-assumed-dst-could-be-null-(see-line-)
`-- x86_64-randconfig-r111-20240507
    |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_core-dml2_core_dcn4_calcs.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
    |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_core-dml2_core_factory.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
    |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_core-dml2_core_shared.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
    |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_dpmm-dml2_dpmm_factory.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
    |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_mcg-dml2_mcg_factory.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
    |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_pmo-dml2_pmo_dcn4.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
    |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_pmo-dml2_pmo_factory.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
    |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_top-dml_top_mcache.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
    |-- drivers-gpu-drm-amd-amdgpu-..-display-dmub-src-dmub_dcn401.c:sparse:sparse:static-assertion-failed:DMUB-command-size-mismatch
    |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
    |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
    |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
    |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
    |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
    `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops

elapsed time: 1143m

configs tested: 152
configs skipped: 8

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                   randconfig-001-20240507   gcc  
arc                   randconfig-002-20240507   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   clang
arm                          collie_defconfig   gcc  
arm                                 defconfig   clang
arm                   milbeaut_m10v_defconfig   clang
arm                             mxs_defconfig   clang
arm                   randconfig-001-20240507   gcc  
arm                   randconfig-002-20240507   clang
arm                   randconfig-003-20240507   gcc  
arm                   randconfig-004-20240507   clang
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240507   clang
arm64                 randconfig-002-20240507   clang
arm64                 randconfig-003-20240507   clang
arm64                 randconfig-004-20240507   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240507   gcc  
csky                  randconfig-002-20240507   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240507   clang
hexagon               randconfig-002-20240507   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240507   clang
i386         buildonly-randconfig-002-20240507   clang
i386         buildonly-randconfig-003-20240507   clang
i386         buildonly-randconfig-004-20240507   gcc  
i386         buildonly-randconfig-005-20240507   gcc  
i386         buildonly-randconfig-006-20240507   clang
i386                                defconfig   clang
i386                  randconfig-001-20240507   clang
i386                  randconfig-002-20240507   gcc  
i386                  randconfig-003-20240507   clang
i386                  randconfig-004-20240507   clang
i386                  randconfig-005-20240507   clang
i386                  randconfig-006-20240507   clang
i386                  randconfig-011-20240507   gcc  
i386                  randconfig-012-20240507   clang
i386                  randconfig-013-20240507   clang
i386                  randconfig-014-20240507   gcc  
i386                  randconfig-015-20240507   gcc  
i386                  randconfig-016-20240507   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240507   gcc  
loongarch             randconfig-002-20240507   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips                            gpr_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240507   gcc  
nios2                 randconfig-002-20240507   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240507   gcc  
parisc                randconfig-002-20240507   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   currituck_defconfig   clang
powerpc                     mpc83xx_defconfig   clang
powerpc               randconfig-001-20240507   gcc  
powerpc               randconfig-002-20240507   clang
powerpc               randconfig-003-20240507   clang
powerpc                     skiroot_defconfig   clang
powerpc64             randconfig-001-20240507   gcc  
powerpc64             randconfig-002-20240507   gcc  
powerpc64             randconfig-003-20240507   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240507   clang
riscv                 randconfig-002-20240507   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240507   gcc  
s390                  randconfig-002-20240507   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240507   gcc  
sh                    randconfig-002-20240507   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240507   gcc  
sparc64               randconfig-002-20240507   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240507   gcc  
um                    randconfig-002-20240507   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64       buildonly-randconfig-001-20240508   clang
x86_64       buildonly-randconfig-004-20240508   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240507   gcc  
xtensa                randconfig-002-20240507   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

