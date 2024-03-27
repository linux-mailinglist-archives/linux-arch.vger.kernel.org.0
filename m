Return-Path: <linux-arch+bounces-3223-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8614888EA1E
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 16:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F2CDB2BB10
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 15:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AED913AD1F;
	Wed, 27 Mar 2024 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2cQscOk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C01E13A895;
	Wed, 27 Mar 2024 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553557; cv=none; b=tsoV00CQCuA0AhewbTKUJYf7PdPMJhcqjaMVKW3b9mcolm6zDJahn6ER1+a+RA1qOps1NgNnoKX1Iyyn+/Sb3l/EGraWx3ebjcTikNcfJl9Rq6Qit55pGvD1lmTyr2P9XpHyWMdXEclRfLAJMqZhBq2+OBkgwwq0DqqzZfOsWiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553557; c=relaxed/simple;
	bh=EY1vmy+qSpddaD5xBKTWyGhU5QNJtbsjuXgfoV+5Kwc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CaXeiWP4814ner/Aari1eXdisvvroG8DF9TCqKjnHTbNjsrqK12xgeXn7T2QIcJVzySB49QZn+7ok8IGBlagbsWjtUdit/5iepUpvrChfULvVqb4UEjMhwbYFdWRbNePsSTAQOHjffO1mHvk8hHYyk/0KgA3Q6Zsy+hxSWlvaJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2cQscOk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711553555; x=1743089555;
  h=date:from:to:cc:subject:message-id;
  bh=EY1vmy+qSpddaD5xBKTWyGhU5QNJtbsjuXgfoV+5Kwc=;
  b=N2cQscOk1kX+Uq+6h4w5wA9Xm3Hkrg5tIanhdRAb1kQgIWOwdion78rs
   7XRZZ7fcPmpk0vINcG7SPknddYCq8blyq/Ih0r0r2Pv8F5701wlFAwTNO
   EY3GLQbV0fKcCcm3eCe+IZq68/kiUZxgW2rRH4f8kDCJEVTp87NqcFo8d
   6wJCMNUl61yICgMNulRiLikYstLtZEYS65gQT9p7tfsuHnkkDYOt8DVfE
   p06GiJNOVcRfqK+oL4afs/7FuHSdeYT3UGeIWgYLCj3bROO6xWlHd5NG5
   Mo82FFyoe+a3ZySbq/sXvfP6p4h/ZFfoy7qVnzPaM1P3ZcueXLMtEmfyG
   A==;
X-CSE-ConnectionGUID: fVk1MdtDQ5GCkvCBu7/VTw==
X-CSE-MsgGUID: 4yHqF+/VQkmifVoh6pyurA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6487391"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6487391"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:32:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="21037528"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 27 Mar 2024 08:32:30 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpVGN-0001BK-0X;
	Wed, 27 Mar 2024 15:32:27 +0000
Date: Wed, 27 Mar 2024 23:32:08 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
 dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 netdev@vger.kernel.org, spice-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
Subject: [linux-next:master] BUILD REGRESSION
 26074e1be23143b2388cacb36166766c235feb7c
Message-ID: <202403272304.r5Yy7kIF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 26074e1be23143b2388cacb36166766c235feb7c  Add linux-next specific files for 20240327

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202403271905.BYbGJiPi-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202403271907.0z0uuG5I-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202403272205.UKAQzc7v-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "memcpy" [crypto/asymmetric_keys/public_key.ko] undefined!
ERROR: modpost: "memcpy" [crypto/asymmetric_keys/x509_key_parser.ko] undefined!
ERROR: modpost: "memcpy" [crypto/sha1_generic.ko] undefined!
drivers/gpu/drm/lima/lima_drv.c:387:13: error: cast to smaller integer type 'enum lima_gpu_id' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
drivers/gpu/drm/panthor/panthor_sched.c:2048:6: error: variable 'csg_mod_mask' set but not used [-Werror,-Wunused-but-set-variable]
drivers/gpu/drm/pl111/pl111_versatile.c:488:24: error: cast to smaller integer type 'enum versatile_clcd' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
drivers/gpu/drm/qxl/qxl_cmd.c:424:6: error: variable 'count' set but not used [-Werror,-Wunused-but-set-variable]
drivers/gpu/drm/qxl/qxl_ioctl.c:148:14: error: variable 'num_relocs' set but not used [-Werror,-Wunused-but-set-variable]
drivers/pwm/pwm-stm32.c:662:8: error: call to undeclared function 'devm_clk_rate_exclusive_get'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
include/asm-generic/io.h:547:31: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
ld: sof_board_helpers.c:(.text+0x157): undefined reference to `sof_ssp_detect_amp_type'
sof_board_helpers.c:(.text+0x149): undefined reference to `sof_ssp_detect_codec_type'
sound/soc/codecs/rk3308_codec.c:956:34: warning: 'rk3308_codec_of_match' defined but not used [-Wunused-const-variable=]
sound/soc/codecs/rk3308_codec.c:956:34: warning: unused variable 'rk3308_codec_of_match' [-Wunused-const-variable]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c:400:42-43: WARNING opportunity for min()
drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c:269:42-43: WARNING opportunity for min()
drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.c:43:42-43: WARNING opportunity for min()

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-randconfig-r001-20220112
|   |-- ERROR:memcpy-crypto-asymmetric_keys-public_key.ko-undefined
|   |-- ERROR:memcpy-crypto-asymmetric_keys-x509_key_parser.ko-undefined
|   `-- ERROR:memcpy-crypto-sha1_generic.ko-undefined
|-- arc-randconfig-r053-20240327
|   `-- drivers-firmware-arm_scmi-raw_mode.c:WARNING:scmi_dbg_raw_mode_reset_fops:write()-has-stream-semantic-safe-to-change-nonseekable_open-stream_open.
|-- arm-omap2plus_defconfig
|   |-- arch-arm-mach-omap2-prm33xx.c:warning:expecting-prototype-for-am33xx_prm_global_warm_sw_reset().-Prototype-was-for-am33xx_prm_global_sw_reset()-instead
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- arm64-defconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- csky-allmodconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- csky-allyesconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- i386-allyesconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- loongarch-allmodconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- loongarch-defconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- m68k-allmodconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- m68k-allyesconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- microblaze-allmodconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- microblaze-allyesconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- nios2-randconfig-002-20240327
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- sh-allmodconfig
|   |-- drivers-pwm-pwm-stm32.c:error:implicit-declaration-of-function-devm_clk_rate_exclusive_get
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- sh-allyesconfig
|   |-- drivers-pwm-pwm-stm32.c:error:implicit-declaration-of-function-devm_clk_rate_exclusive_get
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- sparc-randconfig-001-20240327
|   |-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|   |-- (.init.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-symbol-leon_smp_cpu_startup-defined-in-.text-section-in-arch-sparc-kernel-trampoline_32.o
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- sparc64-allmodconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- sparc64-allyesconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- um-allyesconfig
|   |-- collect2:error:ld-returned-exit-status
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- um-i386_defconfig
|   `-- collect2:error:ld-returned-exit-status
|-- x86_64-buildonly-randconfig-001-20240327
|   |-- ld:sof_board_helpers.c:(.text):undefined-reference-to-sof_ssp_detect_amp_type
|   |-- sof_board_helpers.c:(.text):undefined-reference-to-sof_ssp_detect_codec_type
|   `-- sound-soc-codecs-rk3308_codec.c:warning:rk3308_codec_of_match-defined-but-not-used
|-- x86_64-randconfig-004-20240327
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
`-- x86_64-randconfig-102-20240326
    |-- drivers-gpu-drm-amd-display-dc-dpp-dcn10-dcn10_dpp_dscl.c:WARNING-opportunity-for-min()
    |-- drivers-gpu-drm-amd-display-dc-dpp-dcn20-dcn20_dpp.c:WARNING-opportunity-for-min()
    `-- drivers-gpu-drm-amd-display-dc-dpp-dcn32-dcn32_dpp.c:WARNING-opportunity-for-min()
clang_recent_errors
|-- arm-defconfig
|   |-- arch-arm-mach-omap2-prm33xx.c:warning:expecting-prototype-for-am33xx_prm_global_warm_sw_reset().-Prototype-was-for-am33xx_prm_global_sw_reset()-instead
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- hexagon-randconfig-001-20240326
|   `-- drivers-pwm-pwm-stm32.c:error:call-to-undeclared-function-devm_clk_rate_exclusive_get-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- hexagon-randconfig-001-20240327
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- i386-buildonly-randconfig-005-20240327
|   `-- sound-soc-codecs-rk3308_codec.c:warning:unused-variable-rk3308_codec_of_match
|-- i386-randconfig-005-20240327
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- i386-randconfig-012-20240327
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- mips-bmips_stb_defconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- powerpc-randconfig-r061-20240327
|   `-- drivers-firmware-arm_scmi-raw_mode.c:WARNING:scmi_dbg_raw_mode_reset_fops:write()-has-stream-semantic-safe-to-change-nonseekable_open-stream_open.
|-- powerpc-randconfig-r062-20240327
|   `-- drivers-firmware-arm_scmi-raw_mode.c:WARNING:scmi_dbg_raw_mode_reset_fops:write()-has-stream-semantic-safe-to-change-nonseekable_open-stream_open.
|-- riscv-allmodconfig
|   |-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|   `-- kernel-bpf-bpf_struct_ops.c:warning:bitwise-operation-between-different-enumeration-types-(-enum-bpf_type_flag-and-enum-bpf_reg_type-)
|-- riscv-allyesconfig
|   |-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
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
|   `-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|-- s390-defconfig
|   `-- kernel-bpf-bpf_struct_ops.c:warning:bitwise-operation-between-different-enumeration-types-(-enum-bpf_type_flag-and-enum-bpf_reg_type-)
|-- x86_64-randconfig-075-20240327
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
`-- x86_64-randconfig-161-20240327
    `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead

elapsed time: 725m

configs tested: 189
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240327   gcc  
arc                   randconfig-002-20240327   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   gcc  
arm                         axm55xx_defconfig   clang
arm                                 defconfig   clang
arm                          exynos_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20240327   clang
arm                   randconfig-002-20240327   clang
arm                   randconfig-003-20240327   clang
arm                   randconfig-004-20240327   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240327   clang
arm64                 randconfig-002-20240327   clang
arm64                 randconfig-003-20240327   gcc  
arm64                 randconfig-004-20240327   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240327   gcc  
csky                  randconfig-002-20240327   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240327   clang
hexagon               randconfig-002-20240327   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240327   gcc  
i386         buildonly-randconfig-002-20240327   gcc  
i386         buildonly-randconfig-003-20240327   clang
i386         buildonly-randconfig-004-20240327   clang
i386         buildonly-randconfig-005-20240327   clang
i386         buildonly-randconfig-006-20240327   clang
i386                                defconfig   clang
i386                  randconfig-001-20240327   gcc  
i386                  randconfig-002-20240327   gcc  
i386                  randconfig-003-20240327   clang
i386                  randconfig-004-20240327   gcc  
i386                  randconfig-005-20240327   clang
i386                  randconfig-006-20240327   gcc  
i386                  randconfig-011-20240327   gcc  
i386                  randconfig-012-20240327   clang
i386                  randconfig-013-20240327   gcc  
i386                  randconfig-014-20240327   clang
i386                  randconfig-015-20240327   gcc  
i386                  randconfig-016-20240327   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240327   gcc  
loongarch             randconfig-002-20240327   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                            q40_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips                    maltaup_xpa_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240327   gcc  
nios2                 randconfig-002-20240327   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240327   gcc  
parisc                randconfig-002-20240327   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       ebony_defconfig   clang
powerpc                      katmai_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                     mpc83xx_defconfig   clang
powerpc                     rainier_defconfig   gcc  
powerpc               randconfig-001-20240327   clang
powerpc               randconfig-002-20240327   gcc  
powerpc               randconfig-003-20240327   clang
powerpc                      tqm8xx_defconfig   clang
powerpc64             randconfig-001-20240327   clang
powerpc64             randconfig-002-20240327   gcc  
powerpc64             randconfig-003-20240327   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240327   clang
riscv                 randconfig-002-20240327   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240327   clang
s390                  randconfig-002-20240327   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240327   gcc  
sh                    randconfig-002-20240327   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240327   gcc  
sparc64               randconfig-002-20240327   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240327   clang
um                    randconfig-002-20240327   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240327   gcc  
x86_64       buildonly-randconfig-002-20240327   gcc  
x86_64       buildonly-randconfig-003-20240327   gcc  
x86_64       buildonly-randconfig-004-20240327   clang
x86_64       buildonly-randconfig-005-20240327   gcc  
x86_64       buildonly-randconfig-006-20240327   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240327   clang
x86_64                randconfig-002-20240327   gcc  
x86_64                randconfig-003-20240327   gcc  
x86_64                randconfig-004-20240327   gcc  
x86_64                randconfig-005-20240327   clang
x86_64                randconfig-006-20240327   clang
x86_64                randconfig-011-20240327   gcc  
x86_64                randconfig-012-20240327   clang
x86_64                randconfig-013-20240327   clang
x86_64                randconfig-014-20240327   clang
x86_64                randconfig-015-20240327   clang
x86_64                randconfig-016-20240327   clang
x86_64                randconfig-071-20240327   gcc  
x86_64                randconfig-072-20240327   clang
x86_64                randconfig-073-20240327   clang
x86_64                randconfig-074-20240327   clang
x86_64                randconfig-075-20240327   clang
x86_64                randconfig-076-20240327   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240327   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

