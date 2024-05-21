Return-Path: <linux-arch+bounces-4481-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5A98CB224
	for <lists+linux-arch@lfdr.de>; Tue, 21 May 2024 18:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D4E1C217BE
	for <lists+linux-arch@lfdr.de>; Tue, 21 May 2024 16:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1281B2262B;
	Tue, 21 May 2024 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FuhXwYO4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484FB4C66;
	Tue, 21 May 2024 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716308971; cv=none; b=qhWc6RUCmMyUqeqm4aeK/64BnSZ75hyb1IspySmsC6/0W0LwbBGMJwJWUJAxLHcKTMyHYufJvFJuFl34HSZExvz+1nv2HXYH/mhUvKYwTLCv/D25yzxn/gEf/nJHTY/DftkXyv/b3E3jyZidpIAd5VljYkBEwat6Okb9zD838es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716308971; c=relaxed/simple;
	bh=bqPN6dlUooHDRTisANrz7zECHdyj60J9SffCH2rG/xw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=q7Mq63fBnUEcCZ4sMZFGuOd4R52HgE7vcg4yL7RpHpeB+6tfQih6Xhgv4x9IDLoE209pPryLsXEOFo5rxNPHMTS3JlgvvinbNLYBMxNZR9+IptxzMVWC1FuZNokrD8Au/KYWmvXgYLTvXa0pYZQ7SdFvz33FGM0LaMAdojCBktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FuhXwYO4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716308968; x=1747844968;
  h=date:from:to:cc:subject:message-id;
  bh=bqPN6dlUooHDRTisANrz7zECHdyj60J9SffCH2rG/xw=;
  b=FuhXwYO4g3p1i07Q0n3cedIOamSlPpv0E187L8EOyS/RM0dRBlQznY8H
   aD2fKBgEvftu0fKjJ0Eve8HmmwZF6BBp07bY6FxZvDRJig0zd8At/Ife0
   p1rkmMdUq/iGPTx83H+Fub7o5h0fj/Czgeu3iZSFz9xMWT7609DHZgF/d
   UfwmPriIWR9vSsihYGt4andiNYzRJzoz/4n7cSoCpc8oxMP0IaN/ApEyL
   AwZpzWEIlNcaSO/FZ0rsUkbnj04TeHfTa807GxLTNMA7GZX5Bie6AAglD
   hRMc1hH+I70k2gJ1kNbWxrO0DLASwMzRm2u+QtYbvnuAtXRAJeabjVLjJ
   w==;
X-CSE-ConnectionGUID: QM+dzX37SjOjSAq+eX4IZA==
X-CSE-MsgGUID: OvKtVFduSdyjniUqKovaZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="23096673"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="23096673"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 09:29:27 -0700
X-CSE-ConnectionGUID: C+PeGOSvSrunlLutjjDU0w==
X-CSE-MsgGUID: 2PEcyffLQhK/JkPguSTtUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="33403930"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 21 May 2024 09:29:22 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9SMT-0000XZ-2b;
	Tue, 21 May 2024 16:29:16 +0000
Date: Wed, 22 May 2024 00:27:44 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
 dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-arch@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: [linux-next:master] BUILD REGRESSION
 124cfbcd6d185d4f50be02d5f5afe61578916773
Message-ID: <202405220033.NXFpd4Af-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 124cfbcd6d185d4f50be02d5f5afe61578916773  Add linux-next specific files for 20240521

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202405211405.TidTWIBX-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "__udivdi3" [drivers/vdpa/octeon_ep/octep_vdpa.ko] undefined!
ERROR: modpost: "crc16" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ad9739a.c:(.init.text+0x20): undefined reference to `__spi_register_driver'
regmap-spi.c:(.text+0x444): undefined reference to `spi_sync'
regmap-spi.c:(.text+0x6f2): undefined reference to `spi_async'
regmap-spi.c:(.text+0x71e): undefined reference to `spi_write_then_read'
xtensa-linux-ld: drivers/iio/dac/ad9739a.o:(.init.literal+0x8): undefined reference to `__spi_register_driver'
xtensa-linux-ld: regmap-spi.c:(.text+0x1a2): undefined reference to `spi_write_then_read'

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/gpu/drm/amd/amdgpu/../display/dc/hubbub/dcn401/dcn401_hubbub.o: warning: objtool: unexpected relocation symbol type in .rela.discard.reachable

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- alpha-randconfig-r112-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- arc-allmodconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- arc-allyesconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- csky-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- csky-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- csky-randconfig-001-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- csky-randconfig-r061-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- csky-randconfig-r131-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-allmodconfig
|   |-- ERROR:__udivdi3-drivers-vdpa-octeon_ep-octep_vdpa.ko-undefined
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-allyesconfig
|   |-- ERROR:__udivdi3-drivers-vdpa-octeon_ep-octep_vdpa.ko-undefined
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-randconfig-062-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-randconfig-063-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- loongarch-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- loongarch-defconfig
|   `-- drivers-thermal-thermal_trip.o:warning:objtool:unexpected-relocation-symbol-type-in-.rela.discard.reachable
|-- loongarch-loongson3_defconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hubbub-dcn401-dcn401_hubbub.o:warning:objtool:unexpected-relocation-symbol-type-in-.rela.discard.reachable
|-- m68k-allmodconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- m68k-allyesconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- microblaze-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- microblaze-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- microblaze-randconfig-r133-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- mips-allyesconfig
|   |-- ERROR:__udivdi3-drivers-vdpa-octeon_ep-octep_vdpa.ko-undefined
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- nios2-allmodconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- nios2-allyesconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- nios2-randconfig-001-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- nios2-randconfig-002-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- nios2-randconfig-r062-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- openrisc-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- parisc-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-nouveau-nvif-object.c:error:memcpy-accessing-or-more-bytes-at-offsets-and-overlaps-bytes-at-offset
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- parisc-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-nouveau-nvif-object.c:error:memcpy-accessing-or-more-bytes-at-offsets-and-overlaps-bytes-at-offset
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- parisc-randconfig-001-20240521
|   `-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|-- parisc-randconfig-002-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- powerpc-randconfig-002-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- powerpc64-randconfig-002-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- powerpc64-randconfig-003-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- riscv-randconfig-r054-20240521
|   `-- drivers-irqchip-irq-riscv-imsic-early.c:error:too-many-arguments-to-function-riscv_ipi_set_virq_range
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sh-allmodconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sh-allyesconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sh-randconfig-001-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sh-randconfig-002-20240521
|   |-- standard-input:Warning:overflow-in-branch-to-.L159-converted-into-longer-instruction-sequence
|   `-- standard-input:Warning:overflow-in-branch-to-.L161-converted-into-longer-instruction-sequence
|-- sh-randconfig-r053-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sparc-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sparc-randconfig-002-20240521
|   |-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|   |-- (.init.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-symbol-leon_smp_cpu_startup-defined-in-.text-section-in-arch-sparc-kernel-trampoline_32.o
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sparc64-randconfig-001-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sparc64-randconfig-002-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- um-allyesconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- kernel-bpf-verifier.c:error:pcpu_hot-undeclared-(first-use-in-this-function)
|-- um-randconfig-002-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-102-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-121-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-123-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-161-20240521
|   |-- drivers-dma-fsl-edma-common.c-fsl_edma_fill_tcd()-warn:statement-has-no-effect
|   |-- drivers-dma-fsl-edma-common.c-fsl_edma_set_tcd_regs()-warn:statement-has-no-effect
|   |-- drivers-dma-fsl-edma-main.c-fsl_edma_probe()-warn:statement-has-no-effect
|   |-- drivers-dma-fsl-edma-main.c-fsl_edma_resume_early()-warn:statement-has-no-effect
|   |-- lib-fortify_kunit.c-fortify_test_strcpy()-error:strcpy()-src-too-large-for-pad.buf-(-vs-)
|   `-- net-ipv6-route.c-rt6_fill_node()-error:we-previously-assumed-dst-could-be-null-(see-line-)
|-- x86_64-randconfig-a012-20230624
|   `-- ERROR:crc16-drivers-gpu-drm-amd-amdgpu-amdgpu.ko-undefined
|-- xtensa-randconfig-001-20240521
|   |-- ad9739a.c:(.init.text):undefined-reference-to-__spi_register_driver
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   |-- regmap-spi.c:(.text):undefined-reference-to-spi_async
|   |-- regmap-spi.c:(.text):undefined-reference-to-spi_sync
|   |-- regmap-spi.c:(.text):undefined-reference-to-spi_write_then_read
|   |-- xtensa-linux-ld:drivers-iio-dac-ad9739a.o:(.init.literal):undefined-reference-to-__spi_register_driver
|   `-- xtensa-linux-ld:regmap-spi.c:(.text):undefined-reference-to-spi_write_then_read
`-- xtensa-randconfig-002-20240521
    |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
    `-- init-initramfs.c:error:sysfs_bin_attr_simple_read-undeclared-here-(not-in-a-function)
clang_recent_errors
|-- arm64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
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
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-renesas-rcar-du-rcar_cmm.c:error:unused-function-rcar_cmm_read-Werror-Wunused-function
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- hexagon-allmodconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|-- hexagon-allyesconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|-- hexagon-randconfig-002-20240521
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   |-- ld.lld:error:undefined-symbol:__spi_register_driver
|   |-- ld.lld:error:undefined-symbol:spi_async
|   |-- ld.lld:error:undefined-symbol:spi_sync
|   `-- ld.lld:error:undefined-symbol:spi_write_then_read
|-- i386-randconfig-061-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- i386-randconfig-141-20240521
|   |-- lib-fortify_kunit.c-fortify_test_strcpy()-error:strcpy()-src-too-large-for-pad.buf-(-vs-)
|   `-- net-ipv6-route.c-rt6_fill_node()-error:we-previously-assumed-dst-could-be-null-(see-line-)
|-- mips-randconfig-r111-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- powerpc-randconfig-001-20240521
|   |-- ld.lld:error:undefined-symbol:__spi_register_driver
|   |-- ld.lld:error:undefined-symbol:spi_async
|   |-- ld.lld:error:undefined-symbol:spi_sync
|   `-- ld.lld:error:undefined-symbol:spi_write_then_read
|-- powerpc-randconfig-003-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- powerpc-randconfig-r132-20240521
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- riscv-defconfig
|   `-- drivers-irqchip-irq-riscv-imsic-early.c:error:too-many-arguments-to-function-call-expected-have
|-- riscv-randconfig-001-20240521
|   |-- drivers-irqchip-irq-riscv-imsic-early.c:error:too-many-arguments-to-function-call-expected-have
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- riscv-randconfig-002-20240521
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- s390-randconfig-002-20240521
|   |-- ad9739a.c:(.init.text):undefined-reference-to-__spi_register_driver
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   |-- regmap-spi.c:(.text):undefined-reference-to-spi_async
|   |-- regmap-spi.c:(.text):undefined-reference-to-spi_sync
|   `-- regmap-spi.c:(.text):undefined-reference-to-spi_write_then_read
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
`-- x86_64-randconfig-101-20240521
    `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops

elapsed time: 735m

configs tested: 172
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240521   gcc  
arc                   randconfig-002-20240521   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            mps2_defconfig   clang
arm                       multi_v4t_defconfig   clang
arm                         nhk8815_defconfig   clang
arm                   randconfig-001-20240521   gcc  
arm                   randconfig-002-20240521   gcc  
arm                   randconfig-003-20240521   clang
arm                   randconfig-004-20240521   gcc  
arm                           tegra_defconfig   gcc  
arm                        vexpress_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240521   clang
arm64                 randconfig-002-20240521   gcc  
arm64                 randconfig-003-20240521   clang
arm64                 randconfig-004-20240521   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240521   gcc  
csky                  randconfig-002-20240521   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240521   clang
hexagon               randconfig-002-20240521   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240521   clang
i386         buildonly-randconfig-002-20240521   clang
i386         buildonly-randconfig-003-20240521   gcc  
i386         buildonly-randconfig-004-20240521   clang
i386         buildonly-randconfig-005-20240521   gcc  
i386         buildonly-randconfig-006-20240521   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240521   gcc  
i386                  randconfig-002-20240521   clang
i386                  randconfig-003-20240521   gcc  
i386                  randconfig-004-20240521   gcc  
i386                  randconfig-005-20240521   gcc  
i386                  randconfig-006-20240521   clang
i386                  randconfig-011-20240521   gcc  
i386                  randconfig-012-20240521   clang
i386                  randconfig-013-20240521   clang
i386                  randconfig-014-20240521   clang
i386                  randconfig-015-20240521   clang
i386                  randconfig-016-20240521   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240521   gcc  
loongarch             randconfig-002-20240521   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip27_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240521   gcc  
nios2                 randconfig-002-20240521   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240521   gcc  
parisc                randconfig-002-20240521   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 canyonlands_defconfig   clang
powerpc                      katmai_defconfig   clang
powerpc                     kilauea_defconfig   clang
powerpc                      makalu_defconfig   clang
powerpc               randconfig-001-20240521   clang
powerpc               randconfig-002-20240521   gcc  
powerpc               randconfig-003-20240521   clang
powerpc                      walnut_defconfig   gcc  
powerpc64             randconfig-001-20240521   clang
powerpc64             randconfig-002-20240521   gcc  
powerpc64             randconfig-003-20240521   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240521   clang
riscv                 randconfig-002-20240521   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240521   clang
s390                  randconfig-002-20240521   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240521   gcc  
sh                    randconfig-002-20240521   gcc  
sh                          rsk7264_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240521   gcc  
sparc64               randconfig-002-20240521   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240521   gcc  
um                    randconfig-002-20240521   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240521   clang
x86_64       buildonly-randconfig-002-20240521   clang
x86_64       buildonly-randconfig-003-20240521   gcc  
x86_64       buildonly-randconfig-004-20240521   clang
x86_64       buildonly-randconfig-005-20240521   gcc  
x86_64       buildonly-randconfig-006-20240521   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240521   clang
x86_64                randconfig-002-20240521   clang
x86_64                randconfig-003-20240521   clang
x86_64                randconfig-004-20240521   clang
x86_64                randconfig-005-20240521   clang
x86_64                randconfig-006-20240521   clang
x86_64                randconfig-011-20240521   clang
x86_64                randconfig-012-20240521   gcc  
x86_64                randconfig-013-20240521   gcc  
x86_64                randconfig-014-20240521   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240521   gcc  
xtensa                randconfig-002-20240521   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

