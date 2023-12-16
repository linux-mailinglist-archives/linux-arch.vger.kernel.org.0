Return-Path: <linux-arch+bounces-1100-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF5B8157B7
	for <lists+linux-arch@lfdr.de>; Sat, 16 Dec 2023 06:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 682F3B240F3
	for <lists+linux-arch@lfdr.de>; Sat, 16 Dec 2023 05:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BD010A3D;
	Sat, 16 Dec 2023 05:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jbwKIVx2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5300711181;
	Sat, 16 Dec 2023 05:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702703832; x=1734239832;
  h=date:from:to:cc:subject:message-id;
  bh=0DJx5tWAZSSJiCmdaCOvf0847AXdqKO1db2kTzxegmQ=;
  b=jbwKIVx2Y5MFNfUirqf4X+45kY7aBEC7auyGBUFtAaNQegFB+mbj7vhu
   jR84nsblT1Idbgta7UblTspI7LpgxxpQbFSiM4jhQBJ2X549SNVmnvHAd
   ULJ7zzJUdXRBJkQ7Q4EDlAuZaafb2wHM+pM14HvqTpYscThgRKeiCQetN
   oBBymA0caKkAryIC0rMwENkmoTErEphvD6jOvHMp/izGmj2j5hquxAYr6
   UgYXidrkT+d3PtTeagbyYpeRuJQau6V26Okvw9Y6zcRRW7m/zARZHtg5c
   UwlXWIeN7tbvCnv7XOK2KDyVcrXZuBmTcYAEdm7ZoqnUet91OpJeisvzT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2535934"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="2535934"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 21:17:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="893144840"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="893144840"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 15 Dec 2023 21:17:07 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEN2v-0001Bj-2F;
	Sat, 16 Dec 2023 05:17:05 +0000
Date: Sat, 16 Dec 2023 13:17:00 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org,
 linux-afs@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 17cb8a20bde66a520a2ca7aad1063e1ce7382240
Message-ID: <202312161352.wMZ6kGnT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 17cb8a20bde66a520a2ca7aad1063e1ce7382240  Add linux-next specific files for 20231215

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202312151816.munFeE4L-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202312151854.4k8dhWf6-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202312160153.ovUEsxo6-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202312160433.Oz8VJHH3-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202312161324.nZN1zCQT-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/arm/include/asm/cmpxchg.h:111:(.text+0xf6c): undefined reference to `__bad_xchg'
callback.c:(.rodata.cst4+0x18): undefined reference to `__xchg_called_with_bad_pointer'
callback.c:(.text+0x114): undefined reference to `__xchg_called_with_bad_pointer'
drivers/net/ethernet/intel/ice/ice_base.c:525:16: error: variable 'desc' has initializer but incomplete type
drivers/net/ethernet/intel/ice/ice_base.c:525:28: error: storage size of 'desc' isn't known
drivers/net/ethernet/intel/ice/ice_base.c:525:28: warning: unused variable 'desc' [-Wunused-variable]
fs/bcachefs/btree_iter.c:3090:36: sparse:    struct btree_path *
fs/bcachefs/btree_iter.c:3090:36: sparse:    struct btree_path [noderef] __rcu *
fs/bcachefs/btree_locking.c:309:36: sparse:    struct btree_path *
fs/bcachefs/btree_locking.c:309:36: sparse:    struct btree_path [noderef] __rcu *
include/asm-generic/cmpxchg.h:76:(.text+0x1d0): relocation truncated to fit: R_NIOS2_CALL26 against `__generic_xchg_called_with_bad_pointer'
include/linux/compiler_types.h:435:45: error: call to '__compiletime_assert_38' declared with attribute error: Unsupported size for __xchg_relaxed
io.c:(.text+0x6): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
m68k-linux-ld: callback.c:(.text+0x228): undefined reference to `__invalid_xchg_size'
mm/ksm.c:344:13: warning: 'set_advisor_defaults' defined but not used [-Wunused-function]
rotate.c:(.rodata.cst4+0x30): undefined reference to `__xchg_called_with_bad_pointer'
scripts/kernel-doc: drivers/spi/spi-pl022.c:397: warning: Excess struct member 'cur_msg' description in 'pl022'
scripts/kernel-doc: drivers/spi/spi-pl022.c:437: warning: Excess function parameter 'command' description in 'internal_cs_control'
scripts/kernel-doc: drivers/spi/spi-pl022.c:437: warning: Function parameter or struct member 'enable' not described in 'internal_cs_control'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-randconfig-002-20231215
|   |-- drivers-net-ethernet-intel-ice-ice_base.c:error:storage-size-of-desc-isn-t-known
|   |-- drivers-net-ethernet-intel-ice-ice_base.c:error:variable-desc-has-initializer-but-incomplete-type
|   `-- drivers-net-ethernet-intel-ice-ice_base.c:warning:unused-variable-desc
|-- arc-randconfig-r132-20231215
|   |-- drivers-hwmon-max31827.c:sparse:sparse:dubious:x-y
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- arm-buildonly-randconfig-r002-20220918
|   `-- arch-arm-include-asm-cmpxchg.h:(.text):undefined-reference-to-__bad_xchg
|-- arm-lpc18xx_defconfig
|   |-- scripts-kernel-doc:drivers-spi-spi-pl022.c:warning:Excess-function-parameter-command-description-in-internal_cs_control
|   |-- scripts-kernel-doc:drivers-spi-spi-pl022.c:warning:Excess-struct-member-cur_msg-description-in-pl022
|   `-- scripts-kernel-doc:drivers-spi-spi-pl022.c:warning:Function-parameter-or-struct-member-enable-not-described-in-internal_cs_control
|-- csky-randconfig-001-20231215
|   `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|-- csky-randconfig-r016-20220425
|   `-- io.c:(.text):relocation-truncated-to-fit:R_CKCORE_PCREL_IMM16BY4-against-__jump_table
|-- csky-randconfig-r113-20231215
|   |-- arch-csky-kernel-vdso-vgettimeofday.c:sparse:sparse:function-__vdso_clock_gettime-with-external-linkage-has-definition
|   |-- fs-bcachefs-btree_iter.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_iter.c:sparse:struct-btree_path
|   |-- fs-bcachefs-btree_iter.c:sparse:struct-btree_path-noderef-__rcu
|   |-- fs-bcachefs-btree_locking.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_locking.c:sparse:struct-btree_path
|   |-- fs-bcachefs-btree_locking.c:sparse:struct-btree_path-noderef-__rcu
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- i386-randconfig-013-20231215
|   `-- drivers-hid-hid-nintendo.c:error:initializer-element-is-not-constant
|-- loongarch-defconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- loongarch-randconfig-001-20231215
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- loongarch-randconfig-002-20231215
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- m68k-randconfig-r012-20211002
|   `-- m68k-linux-ld:callback.c:(.text):undefined-reference-to-__invalid_xchg_size
|-- microblaze-randconfig-r121-20231215
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- microblaze-randconfig-r122-20231215
|   |-- drivers-soc-qcom-pmic_pdcharger_ulog.c:sparse:sparse:incorrect-type-in-initializer-(different-base-types)-expected-restricted-__le32-usertype-opcode-got-int
|   |-- drivers-soc-qcom-pmic_pdcharger_ulog.c:sparse:sparse:incorrect-type-in-initializer-(different-base-types)-expected-restricted-__le32-usertype-owner-got-int
|   |-- drivers-soc-qcom-pmic_pdcharger_ulog.c:sparse:sparse:incorrect-type-in-initializer-(different-base-types)-expected-restricted-__le32-usertype-type-got-int
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- mips-decstation_64_defconfig
|   `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|-- mips-fuloong2e_defconfig
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-drivers-base-regmap-regmap-mmio.o
|   `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|-- mips-jazz_defconfig
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|   `-- cache.c:(.text):undefined-reference-to-r3k_cache_init
|-- nios2-allyesconfig
|   |-- callback.c:(.text):relocation-truncated-to-fit:R_NIOS2_CALL26-against-__generic_xchg_called_with_bad_pointer
|   `-- rotate.c:(.text):relocation-truncated-to-fit:R_NIOS2_CALL26-against-__generic_xchg_called_with_bad_pointer
|-- nios2-randconfig-r035-20230329
|   `-- include-asm-generic-cmpxchg.h:(.text):relocation-truncated-to-fit:R_NIOS2_CALL26-against-__generic_xchg_called_with_bad_pointer
|-- openrisc-randconfig-r016-20230621
|   `-- mm-ksm.c:warning:set_advisor_defaults-defined-but-not-used
|-- openrisc-randconfig-r111-20231215
|   |-- drivers-hwmon-max31827.c:sparse:sparse:dubious:x-y
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- parisc-randconfig-001-20231215
|   `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|-- parisc-randconfig-r015-20220820
|   |-- callback.c:(.rodata.cst4):undefined-reference-to-__xchg_called_with_bad_pointer
|   `-- rotate.c:(.rodata.cst4):undefined-reference-to-__xchg_called_with_bad_pointer
|-- powerpc-randconfig-c003-20220424
|   `-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:Unsupported-size-for-__xchg_relaxed
|-- s390-randconfig-r133-20231215
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|   |-- drivers-hwmon-max31827.c:sparse:sparse:dubious:x-y
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- sparc-allmodconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   `-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|-- sparc-allnoconfig
|   |-- arch-sparc-mm-leon_mm.c:warning:variable-paddrbase-set-but-not-used
|   `-- arch-sparc-mm-srmmu.c:warning:variable-clear-set-but-not-used
|-- sparc-defconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-leon_mm.c:warning:variable-paddrbase-set-but-not-used
|   `-- arch-sparc-mm-srmmu.c:warning:variable-clear-set-but-not-used
|-- sparc-randconfig-001-20231215
|   |-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-leon_mm.c:warning:variable-paddrbase-set-but-not-used
|   `-- arch-sparc-mm-srmmu.c:warning:variable-clear-set-but-not-used
|-- sparc-randconfig-002-20231215
|   |-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|   |-- arch-sparc-mm-leon_mm.c:warning:variable-paddrbase-set-but-not-used
|   |-- arch-sparc-mm-srmmu.c:warning:variable-clear-set-but-not-used
|   |-- parport_pc.c:(.text):undefined-reference-to-ebus_dma_enable
|   |-- parport_pc.c:(.text):undefined-reference-to-ebus_dma_irq_enable
|   |-- parport_pc.c:(.text):undefined-reference-to-ebus_dma_register
|   |-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ebus_dma_enable
|   |-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ebus_dma_irq_enable
|   |-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ebus_dma_prepare
|   |-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ebus_dma_request
|   |-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ebus_dma_residue
|   `-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ebus_dma_unregister
|-- sparc64-allmodconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   `-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|-- sparc64-allyesconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   `-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|-- sparc64-defconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   `-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|-- sparc64-randconfig-001-20231215
|   `-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|-- sparc64-randconfig-002-20231215
|   `-- arch-sparc-mm-init_64.c:warning:variable-pagecv_flag-set-but-not-used
|-- sparc64-randconfig-r062-20231215
|   `-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|-- x86_64-allnoconfig
|   `-- Warning:MAINTAINERS-references-a-file-that-doesn-t-exist:Documentation-devicetree-bindings-display-panel-synaptics-r63353.yaml
|-- x86_64-randconfig-001-20231215
|   `-- drivers-hid-hid-nintendo.c:error:initializer-element-is-not-constant
|-- x86_64-randconfig-r131-20231215
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   `-- drivers-hwmon-max31827.c:sparse:sparse:dubious:x-y
`-- xtensa-randconfig-c024-20220216
    `-- callback.c:(.text):undefined-reference-to-__xchg_called_with_bad_pointer
clang_recent_errors
|-- arm-defconfig
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:at91_poweroff_probe-(section:.text)-at91_wakeup_status-(section:.init.text)
|   `-- WARNING:modpost:vmlinux:section-mismatch-in-reference:at91_shdwc_probe-(section:.text)-at91_wakeup_status-(section:.init.text)
|-- arm64-allmodconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- arm64-allyesconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- hexagon-allmodconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- hexagon-allyesconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- i386-allmodconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- i386-buildonly-randconfig-006-20231215
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-drivers-base-regmap-regmap-mmio.o
|   `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|-- i386-randconfig-063-20231215
|   |-- fs-afs-main.c:sparse:sparse:cast-removes-address-space-__rcu-of-expression
|   |-- fs-afs-main.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-callback_head-head-got-struct-callback_head-noderef-__rcu
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- powerpc-allmodconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- powerpc-allyesconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- riscv-randconfig-r112-20231215
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- s390-randconfig-r123-20231215
|   |-- drivers-hwmon-max31827.c:sparse:sparse:dubious:x-y
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- x86_64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
`-- x86_64-randconfig-161-20231215
    |-- lib-zstd-common-bits.h-ZSTD_countLeadingZeros32()-warn:inconsistent-indenting
    |-- lib-zstd-common-bits.h-ZSTD_countTrailingZeros32()-warn:inconsistent-indenting
    |-- lib-zstd-compress-..-common-bits.h-ZSTD_countLeadingZeros32()-warn:inconsistent-indenting
    |-- lib-zstd-compress-..-common-bits.h-ZSTD_countLeadingZeros64()-warn:inconsistent-indenting
    |-- lib-zstd-compress-..-common-bits.h-ZSTD_countTrailingZeros32()-warn:inconsistent-indenting
    |-- lib-zstd-compress-..-common-bits.h-ZSTD_countTrailingZeros64()-warn:inconsistent-indenting
    |-- lib-zstd-decompress-..-common-bits.h-ZSTD_countLeadingZeros32()-warn:inconsistent-indenting
    `-- lib-zstd-decompress-..-common-bits.h-ZSTD_countTrailingZeros64()-warn:inconsistent-indenting

elapsed time: 1467m

configs tested: 166
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20231215   gcc  
arc                   randconfig-002-20231215   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                                 defconfig   clang
arm                            dove_defconfig   clang
arm                            hisi_defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                          pxa168_defconfig   clang
arm                          pxa3xx_defconfig   gcc  
arm                   randconfig-001-20231215   clang
arm                   randconfig-002-20231215   clang
arm                   randconfig-003-20231215   clang
arm                   randconfig-004-20231215   clang
arm                           stm32_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231215   clang
arm64                 randconfig-002-20231215   clang
arm64                 randconfig-003-20231215   clang
arm64                 randconfig-004-20231215   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231215   gcc  
csky                  randconfig-002-20231215   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231215   clang
hexagon               randconfig-002-20231215   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231215   clang
i386         buildonly-randconfig-002-20231215   clang
i386         buildonly-randconfig-003-20231215   clang
i386         buildonly-randconfig-004-20231215   clang
i386         buildonly-randconfig-005-20231215   clang
i386         buildonly-randconfig-006-20231215   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231215   clang
i386                  randconfig-002-20231215   clang
i386                  randconfig-003-20231215   clang
i386                  randconfig-004-20231215   clang
i386                  randconfig-005-20231215   clang
i386                  randconfig-006-20231215   clang
i386                  randconfig-011-20231215   gcc  
i386                  randconfig-012-20231215   gcc  
i386                  randconfig-013-20231215   gcc  
i386                  randconfig-014-20231215   gcc  
i386                  randconfig-015-20231215   gcc  
i386                  randconfig-016-20231215   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231215   gcc  
loongarch             randconfig-002-20231215   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                      malta_kvm_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231215   gcc  
nios2                 randconfig-002-20231215   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231215   gcc  
parisc                randconfig-002-20231215   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                  mpc885_ads_defconfig   clang
powerpc               randconfig-001-20231215   clang
powerpc               randconfig-002-20231215   clang
powerpc               randconfig-003-20231215   clang
powerpc64             randconfig-001-20231215   clang
powerpc64             randconfig-002-20231215   clang
powerpc64             randconfig-003-20231215   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231215   clang
riscv                 randconfig-002-20231215   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231215   gcc  
s390                  randconfig-002-20231215   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20231215   gcc  
sh                    randconfig-002-20231215   gcc  
sh                           se7721_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231215   gcc  
sparc64               randconfig-002-20231215   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231215   clang
um                    randconfig-002-20231215   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231215   clang
x86_64       buildonly-randconfig-003-20231215   clang
x86_64       buildonly-randconfig-005-20231215   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231215   gcc  
x86_64                randconfig-003-20231215   gcc  
x86_64                randconfig-004-20231215   gcc  
x86_64                randconfig-005-20231215   gcc  
x86_64                randconfig-006-20231215   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20231215   gcc  
xtensa                randconfig-002-20231215   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

