Return-Path: <linux-arch+bounces-3275-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CA5890801
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 19:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E924C1F25CCD
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 18:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DB5131E5C;
	Thu, 28 Mar 2024 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EgWYH9HJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277B012F38B;
	Thu, 28 Mar 2024 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649370; cv=none; b=jkPVXoHsvJPFjBCqzapNBdsQbiuviOHw8YB32fBnwu2pPqChGk9hY/YmzycrPyBBc5/rXw239jbNXbzKbGsntJHIIRmJI91I3sZAUyk9F9efNwMnOOVAcHQB4skjFpkfVWgH4KRNjV57MNYYoqxT8Z+JawyjN0nEdP0hOxF1pFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649370; c=relaxed/simple;
	bh=8Oz5LlefiSyj0IqSXmONWSOYVH7o3oZ8gdsoXmI5o/E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NRYzkiH0vKbwaRcaUmWpnck6zBm4n3sXqVTjCYtEN9V7NE2+TTC/94dwff17LNgtQlOT26ry/jGPillN+mX3SJqe5CqiCRGr4bcFPtiz1ujDF1WjncSbeKBSTS8zOWqQybWyCQhVzKrVoDDXaJYFF+y+sDm1w21jypcXXy9MaCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EgWYH9HJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711649368; x=1743185368;
  h=date:from:to:cc:subject:message-id;
  bh=8Oz5LlefiSyj0IqSXmONWSOYVH7o3oZ8gdsoXmI5o/E=;
  b=EgWYH9HJCJ3Y+ivP2wUMew2+3JvlRYAqjFwfo9GLwJ20srevHvOJRtvY
   zcRp4uUnRQl7FZNWpizZu2Z41+RqNtL5N6OhU0Ag75OK1TQwoVVUXAI/j
   9lZLE73JeMcdpe3MteY/HgPkA6O58cSkNDfUpSRubiNJ6gISCOYtYcVxR
   w6BV6mUnvUeitKZoTRfv281X8OvmfVkqMgAbCOh52GC2tD3qIC+U+TKRj
   vl/Sgy5E/GHsmPpq2NPZrIqQHSlmf5gTRamxCRPD2VVuR8/sSN0uxTtWr
   IEeUaQNTjmytuP6AsgrBesD5bjWXoepw0NjQEsuBMer+FcCYjvC67E5Uc
   g==;
X-CSE-ConnectionGUID: cds04U+lQUeU0Q8zyizlxg==
X-CSE-MsgGUID: U2+f1xFESWK5tqJaroLG5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="24270744"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="24270744"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 11:09:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="21380588"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 28 Mar 2024 11:09:18 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpuBf-0002PQ-38;
	Thu, 28 Mar 2024 18:09:15 +0000
Date: Fri, 29 Mar 2024 02:09:02 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
 dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 nouveau@lists.freedesktop.org, spice-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
Subject: [linux-next:master] BUILD REGRESSION
 a6bd6c9333397f5a0e2667d4d82fef8c970108f2
Message-ID: <202403290256.clPzQnUm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: a6bd6c9333397f5a0e2667d4d82fef8c970108f2  Add linux-next specific files for 20240328

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "memcpy" [crypto/chacha20poly1305.ko] undefined!
ERROR: modpost: "memcpy" [fs/efs/efs.ko] undefined!
ERROR: modpost: "memcpy" [mm/z3fold.ko] undefined!
drivers/gpu/drm/lima/lima_drv.c:387:13: error: cast to smaller integer type 'enum lima_gpu_id' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
drivers/gpu/drm/panthor/panthor_sched.c:2048:6: error: variable 'csg_mod_mask' set but not used [-Werror,-Wunused-but-set-variable]
drivers/gpu/drm/pl111/pl111_versatile.c:488:24: error: cast to smaller integer type 'enum versatile_clcd' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
drivers/gpu/drm/qxl/qxl_cmd.c:424:6: error: variable 'count' set but not used [-Werror,-Wunused-but-set-variable]
drivers/gpu/drm/qxl/qxl_ioctl.c:148:14: error: variable 'num_relocs' set but not used [-Werror,-Wunused-but-set-variable]
include/asm-generic/io.h:547:31: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
mm/mempolicy.c:2223: warning: expecting prototype for alloc_pages_mpol_noprof(). Prototype was for alloc_pages_mpol() instead
mm/mempolicy.c:2298: warning: expecting prototype for vma_alloc_folio_noprof(). Prototype was for vma_alloc_folio() instead
mm/mempolicy.c:2326: warning: expecting prototype for alloc_pages_noprof(). Prototype was for alloc_pages() instead
mm/page_alloc.c:4857: warning: expecting prototype for alloc_pages_exact_noprof(). Prototype was for alloc_pages_exact() instead
mm/page_alloc.c:4882: warning: expecting prototype for alloc_pages_exact_nid_noprof(). Prototype was for alloc_pages_exact_nid() instead
mm/page_alloc.c:6348: warning: expecting prototype for alloc_contig_range_noprof(). Prototype was for alloc_contig_range() instead
mm/page_alloc.c:6535: warning: expecting prototype for alloc_contig_pages_noprof(). Prototype was for alloc_contig_pages() instead

Unverified Error/Warning (likely false positive, please contact us if interested):

{standard input}:2055: Error: unknown pseudo-op: `.cfi_restore_st'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-randconfig-r015-20220508
|   `-- ERROR:memcpy-mm-z3fold.ko-undefined
|-- alpha-randconfig-r034-20220715
|   `-- ERROR:memcpy-fs-efs-efs.ko-undefined
|-- alpha-randconfig-r062-20240328
|   `-- ERROR:memcpy-crypto-chacha20poly1305.ko-undefined
|-- parisc-allmodconfig
|   `-- drivers-gpu-drm-nouveau-nvif-object.c:error:memcpy-accessing-or-more-bytes-at-offsets-and-overlaps-bytes-at-offset
|-- parisc-allyesconfig
|   `-- drivers-gpu-drm-nouveau-nvif-object.c:error:memcpy-accessing-or-more-bytes-at-offsets-and-overlaps-bytes-at-offset
|-- sh-allmodconfig
|   `-- drivers-pwm-pwm-stm32.c:error:implicit-declaration-of-function-devm_clk_rate_exclusive_get
|-- sh-allyesconfig
|   `-- drivers-pwm-pwm-stm32.c:error:implicit-declaration-of-function-devm_clk_rate_exclusive_get
|-- sh-buildonly-randconfig-r003-20221218
|   `-- standard-input:Error:unknown-pseudo-op:cfi_restore_st
|-- sparc-allmodconfig
|   |-- mm-mempolicy.c:warning:expecting-prototype-for-alloc_pages_mpol_noprof().-Prototype-was-for-alloc_pages_mpol()-instead
|   |-- mm-mempolicy.c:warning:expecting-prototype-for-alloc_pages_noprof().-Prototype-was-for-alloc_pages()-instead
|   `-- mm-mempolicy.c:warning:expecting-prototype-for-vma_alloc_folio_noprof().-Prototype-was-for-vma_alloc_folio()-instead
|-- sparc-randconfig-001-20240328
|   |-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|   `-- (.init.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-symbol-leon_smp_cpu_startup-defined-in-.text-section-in-arch-sparc-kernel-trampoline_32.o
|-- um-randconfig-002-20240328
|   `-- sound-soc-codecs-rk3308_codec.c:warning:rk3308_codec_of_match-defined-but-not-used
|-- x86_64-randconfig-073-20240328
|   |-- mm-mempolicy.c:warning:expecting-prototype-for-alloc_pages_mpol_noprof().-Prototype-was-for-alloc_pages_mpol()-instead
|   |-- mm-mempolicy.c:warning:expecting-prototype-for-alloc_pages_noprof().-Prototype-was-for-alloc_pages()-instead
|   `-- mm-mempolicy.c:warning:expecting-prototype-for-vma_alloc_folio_noprof().-Prototype-was-for-vma_alloc_folio()-instead
|-- x86_64-randconfig-121-20240328
|   |-- mm-mempolicy.c:warning:expecting-prototype-for-alloc_pages_mpol_noprof().-Prototype-was-for-alloc_pages_mpol()-instead
|   |-- mm-mempolicy.c:warning:expecting-prototype-for-alloc_pages_noprof().-Prototype-was-for-alloc_pages()-instead
|   `-- mm-mempolicy.c:warning:expecting-prototype-for-vma_alloc_folio_noprof().-Prototype-was-for-vma_alloc_folio()-instead
|-- x86_64-randconfig-123-20240328
|   |-- mm-mempolicy.c:warning:expecting-prototype-for-alloc_pages_mpol_noprof().-Prototype-was-for-alloc_pages_mpol()-instead
|   |-- mm-mempolicy.c:warning:expecting-prototype-for-alloc_pages_noprof().-Prototype-was-for-alloc_pages()-instead
|   `-- mm-mempolicy.c:warning:expecting-prototype-for-vma_alloc_folio_noprof().-Prototype-was-for-vma_alloc_folio()-instead
`-- x86_64-randconfig-r071-20240327
    |-- mm-page_alloc.c:warning:expecting-prototype-for-alloc_contig_pages_noprof().-Prototype-was-for-alloc_contig_pages()-instead
    |-- mm-page_alloc.c:warning:expecting-prototype-for-alloc_contig_range_noprof().-Prototype-was-for-alloc_contig_range()-instead
    |-- mm-page_alloc.c:warning:expecting-prototype-for-alloc_pages_exact_nid_noprof().-Prototype-was-for-alloc_pages_exact_nid()-instead
    `-- mm-page_alloc.c:warning:expecting-prototype-for-alloc_pages_exact_noprof().-Prototype-was-for-alloc_pages_exact()-instead
clang_recent_errors
|-- arm-defconfig
|   `-- arch-arm-mach-omap2-prm33xx.c:warning:expecting-prototype-for-am33xx_prm_global_warm_sw_reset().-Prototype-was-for-am33xx_prm_global_sw_reset()-instead
|-- arm-randconfig-r051-20240328
|   `-- drivers-firmware-arm_scmi-raw_mode.c:WARNING:scmi_dbg_raw_mode_reset_fops:write()-has-stream-semantic-safe-to-change-nonseekable_open-stream_open.
|-- arm64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-panthor-panthor_sched.c:error:variable-csg_mod_mask-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-qxl-qxl_cmd.c:error:variable-count-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-qxl-qxl_ioctl.c:error:variable-num_relocs-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-renesas-rcar-du-rcar_cmm.c:error:unused-function-rcar_cmm_read-Werror-Wunused-function
|   |-- kernel-bpf-bpf_struct_ops.c:warning:bitwise-operation-between-different-enumeration-types-(-enum-bpf_type_flag-and-enum-bpf_reg_type-)
|   |-- mm-mempolicy.c:warning:expecting-prototype-for-alloc_pages_mpol_noprof().-Prototype-was-for-alloc_pages_mpol()-instead
|   |-- mm-mempolicy.c:warning:expecting-prototype-for-alloc_pages_noprof().-Prototype-was-for-alloc_pages()-instead
|   `-- mm-mempolicy.c:warning:expecting-prototype-for-vma_alloc_folio_noprof().-Prototype-was-for-vma_alloc_folio()-instead
|-- hexagon-allmodconfig
|   `-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|-- hexagon-allyesconfig
|   `-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|-- i386-randconfig-141-20240328
|   `-- drivers-usb-dwc2-hcd_ddma.c-dwc2_cmpl_host_isoc_dma_desc()-warn:variable-dereferenced-before-check-qtd-urb-(see-line-)
|-- powerpc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-bios-shadowof.c:error:cast-from-void-(-)(const-void-)-to-void-(-)(void-)-converts-to-incompatible-function-type-Werror-Wcast-function-type-strict
|   |-- drivers-gpu-drm-panthor-panthor_sched.c:error:variable-csg_mod_mask-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-qxl-qxl_cmd.c:error:variable-count-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-qxl-qxl_ioctl.c:error:variable-num_relocs-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   `-- kernel-bpf-bpf_struct_ops.c:warning:bitwise-operation-between-different-enumeration-types-(-enum-bpf_type_flag-and-enum-bpf_reg_type-)
|-- powerpc-randconfig-r113-20240328
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-bios-shadowof.c:error:cast-from-void-(-)(const-void-)-to-void-(-)(void-)-converts-to-incompatible-function-type-Werror-Wcast-function-type-strict
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-panthor-panthor_sched.c:error:variable-csg_mod_mask-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-qxl-qxl_cmd.c:error:variable-count-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-qxl-qxl_ioctl.c:error:variable-num_relocs-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   `-- kernel-bpf-bpf_struct_ops.c:warning:bitwise-operation-between-different-enumeration-types-(-enum-bpf_type_flag-and-enum-bpf_reg_type-)
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-panthor-panthor_sched.c:error:variable-csg_mod_mask-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-qxl-qxl_cmd.c:error:variable-count-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-qxl-qxl_ioctl.c:error:variable-num_relocs-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   `-- kernel-bpf-bpf_struct_ops.c:warning:bitwise-operation-between-different-enumeration-types-(-enum-bpf_type_flag-and-enum-bpf_reg_type-)
|-- s390-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-panthor-panthor_sched.c:error:variable-csg_mod_mask-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-qxl-qxl_cmd.c:error:variable-count-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-qxl-qxl_ioctl.c:error:variable-num_relocs-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|   `-- kernel-bpf-bpf_struct_ops.c:warning:bitwise-operation-between-different-enumeration-types-(-enum-bpf_type_flag-and-enum-bpf_reg_type-)
|-- s390-defconfig
|   `-- kernel-bpf-bpf_struct_ops.c:warning:bitwise-operation-between-different-enumeration-types-(-enum-bpf_type_flag-and-enum-bpf_reg_type-)
|-- x86_64-allmodconfig
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-panthor-panthor_sched.c:error:variable-csg_mod_mask-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-qxl-qxl_cmd.c:error:variable-count-set-but-not-used-Werror-Wunused-but-set-variable
|   `-- drivers-gpu-drm-qxl-qxl_ioctl.c:error:variable-num_relocs-set-but-not-used-Werror-Wunused-but-set-variable
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-panthor-panthor_sched.c:error:variable-csg_mod_mask-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-qxl-qxl_cmd.c:error:variable-count-set-but-not-used-Werror-Wunused-but-set-variable
|   `-- drivers-gpu-drm-qxl-qxl_ioctl.c:error:variable-num_relocs-set-but-not-used-Werror-Wunused-but-set-variable
`-- x86_64-randconfig-072-20240328
    |-- mm-mempolicy.c:warning:expecting-prototype-for-alloc_pages_mpol_noprof().-Prototype-was-for-alloc_pages_mpol()-instead
    |-- mm-mempolicy.c:warning:expecting-prototype-for-alloc_pages_noprof().-Prototype-was-for-alloc_pages()-instead
    `-- mm-mempolicy.c:warning:expecting-prototype-for-vma_alloc_folio_noprof().-Prototype-was-for-vma_alloc_folio()-instead

elapsed time: 724m

configs tested: 179
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240328   gcc  
arc                   randconfig-002-20240328   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          ixp4xx_defconfig   gcc  
arm                          moxart_defconfig   gcc  
arm                       multi_v4t_defconfig   clang
arm                   randconfig-001-20240328   gcc  
arm                   randconfig-002-20240328   gcc  
arm                   randconfig-003-20240328   gcc  
arm                   randconfig-004-20240328   gcc  
arm                         s5pv210_defconfig   gcc  
arm                           sama5_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240328   gcc  
arm64                 randconfig-002-20240328   gcc  
arm64                 randconfig-003-20240328   gcc  
arm64                 randconfig-004-20240328   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240328   gcc  
csky                  randconfig-002-20240328   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240328   clang
hexagon               randconfig-002-20240328   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240328   gcc  
i386         buildonly-randconfig-002-20240328   gcc  
i386         buildonly-randconfig-003-20240328   clang
i386         buildonly-randconfig-004-20240328   gcc  
i386         buildonly-randconfig-005-20240328   gcc  
i386         buildonly-randconfig-006-20240328   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240328   clang
i386                  randconfig-002-20240328   clang
i386                  randconfig-003-20240328   clang
i386                  randconfig-004-20240328   clang
i386                  randconfig-005-20240328   gcc  
i386                  randconfig-006-20240328   gcc  
i386                  randconfig-011-20240328   clang
i386                  randconfig-012-20240328   clang
i386                  randconfig-013-20240328   clang
i386                  randconfig-014-20240328   clang
i386                  randconfig-015-20240328   clang
i386                  randconfig-016-20240328   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240328   gcc  
loongarch             randconfig-002-20240328   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                           gcw0_defconfig   clang
mips                           ip22_defconfig   gcc  
mips                           ip32_defconfig   clang
mips                     loongson1c_defconfig   gcc  
mips                           rs90_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240328   gcc  
nios2                 randconfig-002-20240328   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240328   gcc  
parisc                randconfig-002-20240328   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240328   clang
powerpc               randconfig-002-20240328   clang
powerpc               randconfig-003-20240328   clang
powerpc                  storcenter_defconfig   gcc  
powerpc64             randconfig-001-20240328   clang
powerpc64             randconfig-002-20240328   gcc  
powerpc64             randconfig-003-20240328   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240328   gcc  
riscv                 randconfig-002-20240328   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240328   clang
s390                  randconfig-002-20240328   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                    randconfig-001-20240328   gcc  
sh                    randconfig-002-20240328   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240328   gcc  
sparc64               randconfig-002-20240328   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240328   gcc  
um                    randconfig-002-20240328   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240328   gcc  
x86_64       buildonly-randconfig-002-20240328   clang
x86_64       buildonly-randconfig-003-20240328   gcc  
x86_64       buildonly-randconfig-004-20240328   gcc  
x86_64       buildonly-randconfig-005-20240328   gcc  
x86_64       buildonly-randconfig-006-20240328   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240328   clang
x86_64                randconfig-002-20240328   gcc  
x86_64                randconfig-003-20240328   clang
x86_64                randconfig-004-20240328   gcc  
x86_64                randconfig-005-20240328   clang
x86_64                randconfig-006-20240328   clang
x86_64                randconfig-011-20240328   clang
x86_64                randconfig-012-20240328   clang
x86_64                randconfig-013-20240328   gcc  
x86_64                randconfig-014-20240328   gcc  
x86_64                randconfig-015-20240328   clang
x86_64                randconfig-016-20240328   clang
x86_64                randconfig-071-20240328   gcc  
x86_64                randconfig-072-20240328   clang
x86_64                randconfig-073-20240328   gcc  
x86_64                randconfig-074-20240328   gcc  
x86_64                randconfig-075-20240328   gcc  
x86_64                randconfig-076-20240328   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240328   gcc  
xtensa                randconfig-002-20240328   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

