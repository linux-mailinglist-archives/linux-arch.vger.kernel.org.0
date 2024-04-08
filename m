Return-Path: <linux-arch+bounces-3487-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6792489CA7D
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 19:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 799C0B23459
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746CF142906;
	Mon,  8 Apr 2024 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G8AZpIZs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D9D1428E7;
	Mon,  8 Apr 2024 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596320; cv=none; b=QFfDmZcB+n+ad+dU9JkXaAUZqSX7vJ0/NCtrNJymB0OTUxtYraZEGEbGOyE7Acz9KC/9Je5E6tJUOeEBM+pAThWBXMAfQQwoIHD80YxuTnKdTD7b0Q9VymlHwJRdXTKpvW3dMwGcDcnjPgZD1juN9jAzFFvVw6LwFhBgXoLDL+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596320; c=relaxed/simple;
	bh=m9erN2sh9dAdvu52/uEy/8IUmemGIDjptN0Hs3LbyQc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=smzlRoN9eMkcDMFsjWD55640kcx7Pd/iGi0UhzvhWqcXvxvpy0sbTBWiXrZnCIv5y19zENRF+UhIit8DOCfbRSVzEaAZvWH33lB2rOn37eepTcUmrzz+d6JHzM2y4PcHtIR8Kf9appeEymWypCC2mdPMEHGUhHu0GY8RmR5G90M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G8AZpIZs; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712596317; x=1744132317;
  h=date:from:to:cc:subject:message-id;
  bh=m9erN2sh9dAdvu52/uEy/8IUmemGIDjptN0Hs3LbyQc=;
  b=G8AZpIZsOD+WPIEjql+e2+2lPnbvac7mHm6RUL/ggKBw/1oIMyyiyaEA
   pAZm1SUF5vYLEepbMijtiXEcthexWqlhh4ilj1CBDhjCY1PI+mfpjI2Y0
   ul2GOyeyfQKktdVvYeqc9XZJ4Hy1xKjG3ercvdaPGcs5jaaZparuGMCZe
   zfDxH/SI5mo47az5TNtT1UaUbc2q4klQDQX60SS3C34Zp18PwZ8O2a69w
   ZrRAk5yWiCmyBPqRrMcQcScLsUU1rNaJVafgNX+YSVMzEahP2hf4bMO73
   kJsMWz8fh01nCtE+A1abauQTiQWHAbUATSCMpHQJWdELCAjFvSFHoaBZF
   A==;
X-CSE-ConnectionGUID: +5Uih61rRBS7dH1M6Vnx7g==
X-CSE-MsgGUID: D/U6XMgHTFyP99YsSP2T+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7730996"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7730996"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 10:11:55 -0700
X-CSE-ConnectionGUID: 7APrETX/S6uqGcNthPb4nw==
X-CSE-MsgGUID: mJFp4C62Qr6bpuxayTtSeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="24648839"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 08 Apr 2024 10:11:52 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtsX7-0005Ni-1V;
	Mon, 08 Apr 2024 17:11:49 +0000
Date: Tue, 09 Apr 2024 01:11:21 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, lima@lists.freedesktop.org,
 linux-arch@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: [linux-next:master] BUILD REGRESSION
 11cb68ad52ac78c81e33b806b531f097e68edfa2
Message-ID: <202404090117.5DCH1ZO6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 11cb68ad52ac78c81e33b806b531f097e68edfa2  Add linux-next specific files for 20240408

Error/Warning: (recently discovered and may have been fixed)

drivers/gpu/drm/drm_mm.c:152:1: error: unused function 'drm_mm_interval_tree_insert' [-Werror,-Wunused-function]
drivers/gpu/drm/drm_mm.c:152:1: error: unused function 'drm_mm_interval_tree_iter_next' [-Werror,-Wunused-function]
drivers/gpu/drm/lima/lima_drv.c:387:13: error: cast to smaller integer type 'enum lima_gpu_id' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
drivers/gpu/drm/pl111/pl111_versatile.c:488:24: error: cast to smaller integer type 'enum versatile_clcd' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- csky-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- csky-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- microblaze-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- microblaze-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- openrisc-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- parisc-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-gpu-drm-nouveau-nvif-object.c:error:memcpy-accessing-or-more-bytes-at-offsets-and-overlaps-bytes-at-offset
|-- parisc-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-gpu-drm-nouveau-nvif-object.c:error:memcpy-accessing-or-more-bytes-at-offsets-and-overlaps-bytes-at-offset
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- sparc-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- sparc-randconfig-001-20240408
|   `-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|-- sparc-randconfig-002-20240408
|   `-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|-- sparc64-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
`-- sparc64-allyesconfig
    |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
    `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
clang_recent_errors
|-- arm64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-i915-display-intel_cursor.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_ddi.c:error:arithmetic-between-different-enumeration-types-(-enum-hpd_pin-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_ddi.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-phy-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-tc_port-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display_irq.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display_irq.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_dpll_mgr.c:error:arithmetic-between-different-enumeration-types-(-enum-tc_port-and-enum-intel_dpll_id-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_hotplug.c:error:arithmetic-between-different-enumeration-types-(-enum-hpd_pin-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_pipe_crc.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_tc.c:error:arithmetic-between-different-enumeration-types-(-enum-intel_display_power_domain-and-enum-tc_port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_vdsc.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-skl_universal_plane.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-skl_watermark.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-msm-adreno-a6xx_gpu_state.c:error:variable-out-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-renesas-rcar-du-rcar_cmm.c:error:unused-function-rcar_cmm_read-Werror-Wunused-function
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-msm-adreno-a6xx_gpu_state.c:error:variable-out-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-renesas-rcar-du-rcar_cmm.c:error:unused-function-rcar_cmm_read-Werror-Wunused-function
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|-- hexagon-allmodconfig
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|-- hexagon-allyesconfig
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|-- powerpc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-msm-adreno-a6xx_gpu_state.c:error:variable-out-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-i915-display-intel_cursor.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_ddi.c:error:arithmetic-between-different-enumeration-types-(-enum-hpd_pin-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_ddi.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-phy-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-tc_port-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display_irq.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display_irq.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_dpll_mgr.c:error:arithmetic-between-different-enumeration-types-(-enum-tc_port-and-enum-intel_dpll_id-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_hotplug.c:error:arithmetic-between-different-enumeration-types-(-enum-hpd_pin-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_pipe_crc.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_tc.c:error:arithmetic-between-different-enumeration-types-(-enum-intel_display_power_domain-and-enum-tc_port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_vdsc.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-skl_universal_plane.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-skl_watermark.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-msm-adreno-a6xx_gpu_state.c:error:variable-out-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-msm-adreno-a6xx_gpu_state.c:error:variable-out-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|-- s390-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_cursor.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_ddi.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-phy-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display_irq.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display_irq.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_dpll_mgr.c:error:arithmetic-between-different-enumeration-types-(-enum-tc_port-and-enum-intel_dpll_id-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_hotplug.c:error:arithmetic-between-different-enumeration-types-(-enum-hpd_pin-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_pipe_crc.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_tc.c:error:arithmetic-between-different-enumeration-types-(-enum-intel_display_power_domain-and-enum-tc_port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_vdsc.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-skl_universal_plane.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-skl_watermark.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|-- s390-randconfig-001-20240408
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|-- x86_64-allmodconfig
|   |-- drivers-gpu-drm-bridge-synopsys-dw-hdmi-i2s-audio.c:error:unused-function-hdmi_read-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-kmb-kmb_dsi.c:error:unused-function-set_test_mode_src_osc_freq_target_hi_bits-Werror-Wunused-function
|   |-- drivers-gpu-drm-kmb-kmb_dsi.c:error:unused-function-set_test_mode_src_osc_freq_target_low_bits-Werror-Wunused-function
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-msm-adreno-a6xx_gpu_state.c:error:variable-out-set-but-not-used-Werror-Wunused-but-set-variable
|   `-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
`-- x86_64-allyesconfig
    |-- drivers-gpu-drm-bridge-synopsys-dw-hdmi-i2s-audio.c:error:unused-function-hdmi_read-Werror-Wunused-function
    |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
    |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
    |-- drivers-gpu-drm-kmb-kmb_dsi.c:error:unused-function-set_test_mode_src_osc_freq_target_hi_bits-Werror-Wunused-function
    |-- drivers-gpu-drm-kmb-kmb_dsi.c:error:unused-function-set_test_mode_src_osc_freq_target_low_bits-Werror-Wunused-function
    |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
    |-- drivers-gpu-drm-msm-adreno-a6xx_gpu_state.c:error:variable-out-set-but-not-used-Werror-Wunused-but-set-variable
    `-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast

elapsed time: 720m

configs tested: 180
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240408   gcc  
arc                   randconfig-002-20240408   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20240408   clang
arm                   randconfig-002-20240408   clang
arm                   randconfig-003-20240408   clang
arm                   randconfig-004-20240408   clang
arm                         s3c6400_defconfig   gcc  
arm                           sama5_defconfig   gcc  
arm                          sp7021_defconfig   gcc  
arm                        spear3xx_defconfig   clang
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240408   clang
arm64                 randconfig-002-20240408   clang
arm64                 randconfig-003-20240408   gcc  
arm64                 randconfig-004-20240408   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240408   gcc  
csky                  randconfig-002-20240408   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240408   clang
hexagon               randconfig-002-20240408   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240408   gcc  
i386         buildonly-randconfig-002-20240408   gcc  
i386         buildonly-randconfig-003-20240408   gcc  
i386         buildonly-randconfig-004-20240408   clang
i386         buildonly-randconfig-005-20240408   clang
i386         buildonly-randconfig-006-20240408   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240408   clang
i386                  randconfig-002-20240408   clang
i386                  randconfig-003-20240408   clang
i386                  randconfig-004-20240408   clang
i386                  randconfig-005-20240408   gcc  
i386                  randconfig-006-20240408   clang
i386                  randconfig-011-20240408   clang
i386                  randconfig-012-20240408   gcc  
i386                  randconfig-013-20240408   clang
i386                  randconfig-014-20240408   gcc  
i386                  randconfig-015-20240408   gcc  
i386                  randconfig-016-20240408   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240408   gcc  
loongarch             randconfig-002-20240408   gcc  
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
mips                           ip32_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240408   gcc  
nios2                 randconfig-002-20240408   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240408   gcc  
parisc                randconfig-002-20240408   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     mpc5200_defconfig   clang
powerpc                  mpc885_ads_defconfig   clang
powerpc               randconfig-001-20240408   gcc  
powerpc               randconfig-002-20240408   clang
powerpc               randconfig-003-20240408   gcc  
powerpc64             randconfig-001-20240408   clang
powerpc64             randconfig-002-20240408   gcc  
powerpc64             randconfig-003-20240408   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240408   clang
riscv                 randconfig-002-20240408   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240408   clang
s390                  randconfig-002-20240408   gcc  
s390                       zfcpdump_defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240408   gcc  
sh                    randconfig-002-20240408   gcc  
sh                           se7722_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240408   gcc  
sparc64               randconfig-002-20240408   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240408   clang
um                    randconfig-002-20240408   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240408   clang
x86_64       buildonly-randconfig-002-20240408   clang
x86_64       buildonly-randconfig-003-20240408   clang
x86_64       buildonly-randconfig-004-20240408   clang
x86_64       buildonly-randconfig-005-20240408   clang
x86_64       buildonly-randconfig-006-20240408   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240408   gcc  
x86_64                randconfig-002-20240408   clang
x86_64                randconfig-003-20240408   clang
x86_64                randconfig-004-20240408   clang
x86_64                randconfig-005-20240408   clang
x86_64                randconfig-006-20240408   gcc  
x86_64                randconfig-011-20240408   clang
x86_64                randconfig-012-20240408   clang
x86_64                randconfig-013-20240408   gcc  
x86_64                randconfig-014-20240408   clang
x86_64                randconfig-015-20240408   clang
x86_64                randconfig-016-20240408   clang
x86_64                randconfig-071-20240408   gcc  
x86_64                randconfig-072-20240408   clang
x86_64                randconfig-073-20240408   clang
x86_64                randconfig-074-20240408   gcc  
x86_64                randconfig-075-20240408   gcc  
x86_64                randconfig-076-20240408   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240408   gcc  
xtensa                randconfig-002-20240408   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

