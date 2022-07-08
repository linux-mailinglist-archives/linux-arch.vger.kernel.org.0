Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D6556B071
	for <lists+linux-arch@lfdr.de>; Fri,  8 Jul 2022 04:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbiGHCJW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jul 2022 22:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiGHCJV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jul 2022 22:09:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDAE1EEC3
        for <linux-arch@vger.kernel.org>; Thu,  7 Jul 2022 19:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657246160; x=1688782160;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=B/KMugMWzqxZ+CdFqdAqWbEIOWulXN9jho+wH1UQ5Kc=;
  b=d12D6ze3xZ0JbDHZNNGRVcEKEt0iYLDy7zAI7CgUR5Y3XpFjTK+O/pp/
   Qe5Z1gnprId04rvlzrhuDGwhulJilB/rpls8Dxu3HQJycW7RaIr0RQj3M
   VBGtvpPWTPbFAOWSn/dKvtauvlRj98M8OtA/5RWe1kw84bnMAuKiDIYCi
   HUqGetPjxCx2k1W+i8qz41MmLK6+0/svuG8gGViIW5xU1o7FwAgJ14+rJ
   LsnFqK2MHDeb8eAnfmQpNLHXBY2vgojLkQ0jlxhmCNwwwpF0GB0BXZR9/
   5RRyiGzxqt+dNehqpBCAsvYRgf8wkVv3858j/LsBwjGPf4KVaLhK53Q7Y
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="284190389"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="284190389"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 19:09:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="920825016"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jul 2022 19:09:18 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9dQk-000MlA-39;
        Fri, 08 Jul 2022 02:09:18 +0000
Date:   Fri, 08 Jul 2022 10:08:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic-fixes] BUILD REGRESSION
 cdfde8f61a004fa5797d40581077603c142adca1
Message-ID: <62c79198.cku0WcPDJTfoxFq2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-fixes
branch HEAD: cdfde8f61a004fa5797d40581077603c142adca1  asm-generic: correct reference to GENERIC_LIB_DEVMEM_IS_ALLOWED

Error/Warning reports:

https://lore.kernel.org/linux-arch/202207080744.tSGEdxng-lkp@intel.com
https://lore.kernel.org/llvm/202207080606.J3uB2s10-lkp@intel.com
https://lore.kernel.org/llvm/202207080855.lobMzAgr-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/char/mem.c:66:16: error: implicit declaration of function 'devmem_is_allowed'; did you mean 'page_is_allowed'? [-Werror=implicit-function-declaration]
drivers/char/mem.c:66:9: error: call to undeclared function 'devmem_is_allowed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
kernel/resource.c:1124:6: error: call to undeclared function 'devmem_is_allowed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allyesconfig
|   `-- drivers-char-mem.c:error:implicit-declaration-of-function-devmem_is_allowed
`-- arm64-allyesconfig
    `-- drivers-char-mem.c:error:implicit-declaration-of-function-devmem_is_allowed
clang_recent_errors
|-- arm-buildonly-randconfig-r003-20220707
|   |-- drivers-char-mem.c:error:call-to-undeclared-function-devmem_is_allowed-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-resource.c:error:call-to-undeclared-function-devmem_is_allowed-ISO-C99-and-later-do-not-support-implicit-function-declarations
`-- riscv-randconfig-r035-20220707
    `-- drivers-char-mem.c:error:call-to-undeclared-function-devmem_is_allowed-ISO-C99-and-later-do-not-support-implicit-function-declarations

elapsed time: 825m

configs tested: 129
configs skipped: 3

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
m68k                        mvme147_defconfig
m68k                             alldefconfig
xtensa                       common_defconfig
sh                                  defconfig
sh                          rsk7269_defconfig
alpha                            alldefconfig
openrisc                            defconfig
arm                          badge4_defconfig
powerpc                  storcenter_defconfig
arc                         haps_hs_defconfig
mips                             allmodconfig
arm                        cerfcube_defconfig
powerpc                     asp8347_defconfig
arm                          pxa910_defconfig
arc                      axs103_smp_defconfig
powerpc                      mgcoge_defconfig
sh                             shx3_defconfig
mips                           xway_defconfig
powerpc                 mpc8540_ads_defconfig
nios2                            allyesconfig
sh                           se7705_defconfig
powerpc                     tqm8548_defconfig
m68k                       m5249evb_defconfig
arc                        nsimosci_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                           stm32_defconfig
sh                   sh7770_generic_defconfig
mips                         tb0226_defconfig
arm                        mvebu_v7_defconfig
sh                         ap325rxa_defconfig
arm                        spear6xx_defconfig
sh                      rts7751r2d1_defconfig
riscv                               defconfig
sh                           se7722_defconfig
xtensa                              defconfig
powerpc                     tqm8555_defconfig
powerpc                    adder875_defconfig
sh                              ul2_defconfig
arm                        keystone_defconfig
sh                   secureedge5410_defconfig
arm                           u8500_defconfig
arc                     nsimosci_hs_defconfig
mips                 decstation_r4k_defconfig
sh                           se7712_defconfig
sh                        edosk7705_defconfig
m68k                            q40_defconfig
powerpc                      ppc6xx_defconfig
arm                      jornada720_defconfig
powerpc                     ep8248e_defconfig
m68k                           sun3_defconfig
sh                          r7780mp_defconfig
x86_64                           alldefconfig
xtensa                generic_kc705_defconfig
microblaze                      mmu_defconfig
s390                          debug_defconfig
sh                           sh2007_defconfig
sh                         ecovec24_defconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
ia64                             allmodconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220707
arc                  randconfig-r043-20220707
s390                 randconfig-r044-20220707
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                  mpc885_ads_defconfig
powerpc                    mvme5100_defconfig
arm                      pxa255-idp_defconfig
powerpc                     tqm8540_defconfig
mips                         tb0287_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                        multi_v5_defconfig
powerpc                 mpc8315_rdb_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220707
hexagon              randconfig-r041-20220707

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
