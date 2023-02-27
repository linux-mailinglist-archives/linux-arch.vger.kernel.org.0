Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A0B6A4380
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 14:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjB0N6F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 08:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjB0N6E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 08:58:04 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1721C7EFB;
        Mon, 27 Feb 2023 05:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677506283; x=1709042283;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=LyjZENe9a58xVacAUqqOV7tjA6jkVjLtJKW3Hpgpaoo=;
  b=oCB83bhRjnYDEb+ix/zloNAKc4uFOS+VaIjFWCrlmQqM++tg6rd0CHz+
   tJERns6dBOK6FfbKKDXoiW3a6PPJsAoPgISAFc8vlI9pFQvJAlemC2/6I
   FDcAyaPKCGgdUUq0qf+o8YWHLjUi4e5pkuxU3IOLN3ar+iOXdMW1ofgv+
   5fXrGAWecT8K4oE8l1udfwrR8oGkOGL8c5ZylqJOa4Rgn6VwlQZ5sc0nq
   oU9NsmCzzpo6W7zdhmYFg7MLo64pojVY3THeMHbXgQz1Nmqpa5Gqw21qW
   TACXfZoLzDCIZNtgaQLLVE1Y2ayg+eGMnxS6dqXiYR7YHfi0JGTYS7JtQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="361419431"
X-IronPort-AV: E=Sophos;i="5.98,332,1673942400"; 
   d="scan'208";a="361419431"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 05:57:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="797641398"
X-IronPort-AV: E=Sophos;i="5.98,332,1673942400"; 
   d="scan'208";a="797641398"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2023 05:57:44 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWe0d-0004TT-11;
        Mon, 27 Feb 2023 13:57:43 +0000
Date:   Mon, 27 Feb 2023 21:57:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-usb@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 7f7a8831520f12a3cf894b0627641fad33971221
Message-ID: <63fcb6b4.yGpADaCT3Jus/Y+Z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 7f7a8831520f12a3cf894b0627641fad33971221  Add linux-next specific files for 20230227

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202302111601.jtY4lKrA-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202302170355.Ljqlzucu-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202302210350.lynWcL4t-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202302242257.4W4myB9z-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202302262324.Xemtp2Zk-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

FAILED: load BTF from vmlinux: No data available
drivers/block/zram/zram_drv.c:1234:23: error: incompatible pointer types passing 'atomic_long_t *' (aka 'atomic_t *') to parameter of type 'const atomic64_t *' [-Werror,-Wincompatible-pointer-types]
drivers/block/zram/zram_drv.c:1234:44: error: passing argument 1 of 'atomic64_read' from incompatible pointer type [-Werror=incompatible-pointer-types]
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.c:294:6: warning: no previous prototype for 'optc3_wait_drr_doublebuffer_pending_clear' [-Wmissing-prototypes]
idma64.c:(.text+0x145a): undefined reference to `devm_platform_ioremap_resource'
idma64.c:(.text+0xacc): undefined reference to `devm_platform_ioremap_resource'
include/asm-generic/div64.h:238:36: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Werror=incompatible-pointer-types]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/usb/gadget/composite.c:2082:33: sparse: sparse: restricted __le16 degrades to integer
mm/page_alloc.c:257:1: sparse: sparse: symbol 'check_pages_enabled' was not declared. Should it be static?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-randconfig-s031-20230226
|   |-- drivers-usb-gadget-composite.c:sparse:sparse:restricted-__le16-degrades-to-integer
|   `-- mm-page_alloc.c:sparse:sparse:symbol-check_pages_enabled-was-not-declared.-Should-it-be-static
|-- arc-allyesconfig
|   |-- drivers-block-zram-zram_drv.c:error:passing-argument-of-atomic64_read-from-incompatible-pointer-type
|   `-- include-asm-generic-div64.h:error:passing-argument-of-__div64_32-from-incompatible-pointer-type
|-- arm-allmodconfig
|   |-- drivers-block-zram-zram_drv.c:error:passing-argument-of-atomic64_read-from-incompatible-pointer-type
|   `-- include-asm-generic-div64.h:error:passing-argument-of-__div64_32-from-incompatible-pointer-type
|-- arm-allyesconfig
|   |-- drivers-block-zram-zram_drv.c:error:passing-argument-of-atomic64_read-from-incompatible-pointer-type
|   `-- include-asm-generic-div64.h:error:passing-argument-of-__div64_32-from-incompatible-pointer-type
|-- arm64-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dcn30-dcn30_optc.c:warning:no-previous-prototype-for-optc3_wait_drr_doublebuffer_pending_clear
|-- csky-allmodconfig
|   |-- drivers-block-zram-zram_drv.c:error:passing-argument-of-atomic64_read-from-incompatible-pointer-type
|   `-- include-asm-generic-div64.h:error:passing-argument-of-__div64_32-from-incompatible-pointer-type
|-- csky-randconfig-r001-20230226
|   `-- drivers-block-zram-zram_drv.c:error:passing-argument-of-atomic64_read-from-incompatible-pointer-type
|-- i386-allyesconfig
|   |-- drivers-block-zram-zram_drv.c:error:passing-argument-of-atomic64_read-from-incompatible-pointer-type
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dcn30-dcn30_optc.c:warning:no-previous-prototype-for-optc3_wait_drr_doublebuffer_pending_clear
|-- m68k-allmodconfig
|   `-- drivers-block-zram-zram_drv.c:error:passing-argument-of-atomic64_read-from-incompatible-pointer-type
|-- m68k-defconfig
|   `-- drivers-block-zram-zram_drv.c:error:passing-argument-of-atomic64_read-from-incompatible-pointer-type
|-- m68k-hp300_defconfig
|   `-- drivers-block-zram-zram_drv.c:error:passing-argument-of-atomic64_read-from-incompatible-pointer-type
|-- m68k-mvme16x_defconfig
|   `-- drivers-block-zram-zram_drv.c:error:passing-argument-of-atomic64_read-from-incompatible-pointer-type
|-- microblaze-randconfig-c043-20230226
|   `-- drivers-block-zram-zram_drv.c:error:passing-argument-of-atomic64_read-from-incompatible-pointer-type
|-- mips-allmodconfig
|   `-- drivers-block-zram-zram_drv.c:error:passing-argument-of-atomic64_read-from-incompatible-pointer-type
|-- mips-allyesconfig
|   `-- drivers-block-zram-zram_drv.c:error:passing-argument-of-atomic64_read-from-incompatible-pointer-type
|-- nios2-randconfig-s032-20230226
|   `-- mm-page_alloc.c:sparse:sparse:symbol-check_pages_enabled-was-not-declared.-Should-it-be-static
|-- nios2-randconfig-s053-20230226
|   |-- drivers-usb-gadget-composite.c:sparse:sparse:restricted-__le16-degrades-to-integer
|   |-- include-asm-generic-cmpxchg-local.h:sparse:sparse:cast-truncates-bits-from-constant-value-(-becomes-)
|   |-- include-asm-generic-cmpxchg-local.h:sparse:sparse:cast-truncates-bits-from-constant-value-(aaa31337-becomes-)
|   `-- mm-page_alloc.c:sparse:sparse:symbol-check_pages_enabled-was-not-declared.-Should-it-be-static
|-- openrisc-randconfig-r002-20230227
|   `-- drivers-block-zram-zram_drv.c:error:passing-argument-of-atomic64_read-from-incompatible-pointer-type
|-- parisc-randconfig-s052-20230226
|   |-- FAILED:load-BTF-from-vmlinux:No-data-available
|   |-- drivers-usb-gadget-composite.c:sparse:sparse:restricted-__le16-degrades-to-integer
|   `-- mm-page_alloc.c:sparse:sparse:symbol-check_pages_enabled-was-not-declared.-Should-it-be-static
|-- powerpc-allmodconfig
clang_recent_errors
|-- hexagon-randconfig-r032-20230227
|   `-- drivers-block-zram-zram_drv.c:error:incompatible-pointer-types-passing-atomic_long_t-(aka-atomic_t-)-to-parameter-of-type-const-atomic64_t-Werror-Wincompatible-pointer-types
|-- hexagon-randconfig-r041-20230226
|   `-- drivers-block-zram-zram_drv.c:error:incompatible-pointer-types-passing-atomic_long_t-(aka-atomic_t-)-to-parameter-of-type-const-atomic64_t-Werror-Wincompatible-pointer-types
|-- hexagon-randconfig-r045-20230226
|   `-- drivers-block-zram-zram_drv.c:error:incompatible-pointer-types-passing-atomic_long_t-(aka-atomic_t-)-to-parameter-of-type-const-atomic64_t-Werror-Wincompatible-pointer-types
|-- i386-randconfig-a005-20230227
|   `-- drivers-block-zram-zram_drv.c:error:incompatible-pointer-types-passing-atomic_long_t-(aka-atomic_t-)-to-parameter-of-type-const-atomic64_t-Werror-Wincompatible-pointer-types
|-- powerpc-mpc8560_ads_defconfig
|   `-- error:unknown-target-CPU
|-- powerpc-ppa8548_defconfig
|   `-- error:unknown-target-CPU
|-- powerpc-socrates_defconfig
|   `-- error:unknown-target-CPU
`-- powerpc-tqm8540_defconfig
    `-- error:unknown-target-CPU

elapsed time: 724m

configs tested: 145
configs skipped: 11

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230227   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r035-20230226   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230226   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r032-20230226   gcc  
arc                  randconfig-r034-20230226   gcc  
arc                  randconfig-r043-20230226   gcc  
arc                  randconfig-r043-20230227   gcc  
arm                     am200epdkit_defconfig   clang
arm                           h3600_defconfig   gcc  
arm                  randconfig-r036-20230226   clang
arm                  randconfig-r046-20230226   gcc  
arm                  randconfig-r046-20230227   clang
arm                           tegra_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r006-20230226   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230226   gcc  
csky                 randconfig-r004-20230227   gcc  
csky                 randconfig-r011-20230227   gcc  
hexagon              randconfig-r013-20230226   clang
hexagon              randconfig-r015-20230226   clang
hexagon              randconfig-r032-20230227   clang
hexagon              randconfig-r041-20230226   clang
hexagon              randconfig-r041-20230227   clang
hexagon              randconfig-r045-20230226   clang
hexagon              randconfig-r045-20230227   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230227   clang
i386                 randconfig-a002-20230227   clang
i386                 randconfig-a003-20230227   clang
i386                 randconfig-a004-20230227   clang
i386                 randconfig-a005-20230227   clang
i386                 randconfig-a006-20230227   clang
i386                 randconfig-a011-20230227   gcc  
i386                 randconfig-a012-20230227   gcc  
i386                 randconfig-a013-20230227   gcc  
i386                 randconfig-a014-20230227   gcc  
i386                 randconfig-a015-20230227   gcc  
i386                 randconfig-a016-20230227   gcc  
i386                 randconfig-r034-20230227   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r002-20230227   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r036-20230227   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230226   gcc  
loongarch            randconfig-r003-20230226   gcc  
loongarch            randconfig-r005-20230227   gcc  
loongarch            randconfig-r011-20230226   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r004-20230227   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r004-20230226   gcc  
m68k                 randconfig-r013-20230227   gcc  
m68k                 randconfig-r016-20230227   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r005-20230226   clang
mips                  cavium_octeon_defconfig   clang
mips                           ip28_defconfig   clang
mips                    maltaup_xpa_defconfig   gcc  
mips                 randconfig-r014-20230227   clang
mips                          rm200_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230227   gcc  
openrisc             randconfig-r002-20230227   gcc  
openrisc             randconfig-r031-20230226   gcc  
openrisc             randconfig-r031-20230227   gcc  
parisc       buildonly-randconfig-r004-20230226   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc               randconfig-r015-20230227   gcc  
parisc               randconfig-r035-20230227   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230227   gcc  
powerpc      buildonly-randconfig-r003-20230227   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                        icon_defconfig   clang
powerpc                   microwatt_defconfig   clang
powerpc                 mpc8560_ads_defconfig   clang
powerpc                     ppa8548_defconfig   clang
powerpc                    socrates_defconfig   clang
powerpc                     tqm8540_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r003-20230227   clang
riscv                randconfig-r006-20230226   gcc  
riscv                randconfig-r006-20230227   clang
riscv                randconfig-r042-20230226   clang
riscv                randconfig-r042-20230227   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230226   clang
s390                 randconfig-r044-20230227   gcc  
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r005-20230226   gcc  
sh                   randconfig-r012-20230226   gcc  
sh                          rsk7269_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230226   gcc  
sparc                       sparc64_defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230227   clang
x86_64               randconfig-a002-20230227   clang
x86_64               randconfig-a003-20230227   clang
x86_64               randconfig-a004-20230227   clang
x86_64               randconfig-a005-20230227   clang
x86_64               randconfig-a006-20230227   clang
x86_64               randconfig-a011-20230227   gcc  
x86_64               randconfig-a012-20230227   gcc  
x86_64               randconfig-a013-20230227   gcc  
x86_64               randconfig-a014-20230227   gcc  
x86_64               randconfig-a015-20230227   gcc  
x86_64               randconfig-a016-20230227   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r006-20230227   gcc  
xtensa               randconfig-r033-20230226   gcc  
xtensa               randconfig-r033-20230227   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
