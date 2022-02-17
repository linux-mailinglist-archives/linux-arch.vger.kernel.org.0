Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04474BAB07
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 21:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbiBQU3W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 15:29:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236655AbiBQU3V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 15:29:21 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D18C3342
        for <linux-arch@vger.kernel.org>; Thu, 17 Feb 2022 12:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645129745; x=1676665745;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dmlaQMXuY41tE/f5BkgWZF+mdp6fChWXry1LLy1feCs=;
  b=P3HIal49jutICVl4Ei4XqFm3QcQJBMUpfKvLWzArxIsjdt/SdZ16Ds+b
   p5XTyMrQNc/UfnH2FxW25NXSWalxUbFCrLS0kXqpC93VV/pbfGZq+hudk
   9a+Z3yMl+AsYwrWyQVQGf0DVjNDUgqAgNfh6S6OU4CzGID3BtLS0f0IpV
   Uwv5svub/GmCeZghLqC37wVE0W5k09fIz9u47GDAQ/v+q+W+Cm3tmCIeC
   vz8xuFjP5DYDuvEFOV/hIURXldVDaRJEcK/dQAI7UD3pEYkEw2ujhCsDe
   nVJHYskRz0s3g7U7Xowvp8OGwfO1sdomxGfAPYFe9cpum0O1THifpOU3M
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="238371255"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="238371255"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 12:29:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="637347875"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 17 Feb 2022 12:29:03 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKnOg-0000cM-Op; Thu, 17 Feb 2022 20:29:02 +0000
Date:   Fri, 18 Feb 2022 04:28:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD REGRESSION
 3f2b41135db9099b8d216fffeede5c2cb38ed277
Message-ID: <620eafe1.ymrzTCAT9xPqUC6J%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 3f2b41135db9099b8d216fffeede5c2cb38ed277  Merge branch 'set_fs-3' of git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic into asm-generic

Error/Warning reports:

https://lore.kernel.org/linux-arch/202202172154.lJ3Z0yXe-lkp@intel.com

Error/Warning in current branch:

arch/sparc/include/uapi/asm/posix_types.h:14: Error: Unknown opcode: `typedef'
arch/sparc/include/uapi/asm/posix_types.h:26: Error: Unknown opcode: `struct'
arch/sparc/include/uapi/asm/posix_types.h:27: Error: Unknown opcode: `__kernel_long_t tv_sec'
arch/sparc/include/uapi/asm/posix_types.h:28: Error: Unknown opcode: `__kernel_suseconds_t tv_usec'
arch/sparc/include/uapi/asm/posix_types.h:29: Error: junk at end of line, first unrecognized character is `}'
arch/sparc/include/uapi/asm/posix_types.h:35: Error: Unknown opcode: `typedef'
include/uapi/asm-generic/posix_types.h:15: Error: Unknown opcode: `typedef'
include/uapi/asm-generic/posix_types.h:20: Error: Unknown opcode: `typedef'
include/uapi/asm-generic/posix_types.h:80: Error: Unknown opcode: `int'
include/uapi/asm-generic/posix_types.h:81: Error: junk at end of line, first unrecognized character is `}'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- sparc-allyesconfig
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:__kernel_long_t-tv_sec
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:__kernel_suseconds_t-tv_usec
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:struct
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:typedef
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:int
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:typedef
|   `-- include-uapi-asm-generic-posix_types.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|-- sparc-buildonly-randconfig-r002-20220217
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:__kernel_long_t-tv_sec
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:__kernel_suseconds_t-tv_usec
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:struct
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:typedef
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:int
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:typedef
|   `-- include-uapi-asm-generic-posix_types.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|-- sparc-defconfig
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:typedef
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:int
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:typedef
|   `-- include-uapi-asm-generic-posix_types.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|-- sparc-randconfig-r003-20220217
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:typedef
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:int
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:typedef
|   `-- include-uapi-asm-generic-posix_types.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|-- sparc-randconfig-r012-20220217
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:__kernel_long_t-tv_sec
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:__kernel_suseconds_t-tv_usec
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:struct
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:typedef
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:int
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:typedef
|   `-- include-uapi-asm-generic-posix_types.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|-- sparc-randconfig-r022-20220217
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:typedef
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:int
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:typedef
|   `-- include-uapi-asm-generic-posix_types.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|-- sparc-randconfig-r026-20220217
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:typedef
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:int
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:typedef
|   `-- include-uapi-asm-generic-posix_types.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|-- sparc-randconfig-r033-20220217
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:typedef
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:int
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:typedef
|   `-- include-uapi-asm-generic-posix_types.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|-- sparc64-randconfig-r016-20220217
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:__kernel_long_t-tv_sec
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:__kernel_suseconds_t-tv_usec
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:struct
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:typedef
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:int
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:typedef
|   `-- include-uapi-asm-generic-posix_types.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|-- sparc64-randconfig-r023-20220217
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:__kernel_long_t-tv_sec
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:__kernel_suseconds_t-tv_usec
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:struct
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:typedef
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:int
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:typedef
|   `-- include-uapi-asm-generic-posix_types.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|-- sparc64-randconfig-r031-20220217
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:__kernel_long_t-tv_sec
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:__kernel_suseconds_t-tv_usec
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:struct
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:typedef
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:int
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:typedef
|   `-- include-uapi-asm-generic-posix_types.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|-- sparc64-randconfig-r034-20220217
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:__kernel_long_t-tv_sec
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:__kernel_suseconds_t-tv_usec
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:struct
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:typedef
|   |-- arch-sparc-include-uapi-asm-posix_types.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:int
|   |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:typedef
|   `-- include-uapi-asm-generic-posix_types.h:Error:junk-at-end-of-line-first-unrecognized-character-is
`-- sparc64-randconfig-r036-20220217
    |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:__kernel_long_t-tv_sec
    |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:__kernel_suseconds_t-tv_usec
    |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:struct
    |-- arch-sparc-include-uapi-asm-posix_types.h:Error:Unknown-opcode:typedef
    |-- arch-sparc-include-uapi-asm-posix_types.h:Error:junk-at-end-of-line-first-unrecognized-character-is
    |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:int
    |-- include-uapi-asm-generic-posix_types.h:Error:Unknown-opcode:typedef
    `-- include-uapi-asm-generic-posix_types.h:Error:junk-at-end-of-line-first-unrecognized-character-is

elapsed time: 721m

configs tested: 115
configs skipped: 4

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                          exynos_defconfig
sh                            migor_defconfig
arm                        cerfcube_defconfig
arc                          axs103_defconfig
sh                         microdev_defconfig
mips                  decstation_64_defconfig
m68k                          hp300_defconfig
powerpc                      cm5200_defconfig
powerpc                      makalu_defconfig
xtensa                    xip_kc705_defconfig
xtensa                generic_kc705_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                       eiger_defconfig
h8300                               defconfig
microblaze                      mmu_defconfig
m68k                       m5475evb_defconfig
arm                        spear6xx_defconfig
arm                            lart_defconfig
sh                            titan_defconfig
h8300                            alldefconfig
nios2                         3c120_defconfig
m68k                         apollo_defconfig
sh                           se7343_defconfig
sh                     sh7710voipgw_defconfig
m68k                          sun3x_defconfig
sh                           se7619_defconfig
arc                           tb10x_defconfig
arm                           viper_defconfig
mips                           gcw0_defconfig
openrisc                  or1klitex_defconfig
mips                    maltaup_xpa_defconfig
powerpc                      bamboo_defconfig
xtensa                          iss_defconfig
arm                          simpad_defconfig
sh                          rsk7201_defconfig
powerpc                      pasemi_defconfig
arm                           h5000_defconfig
ia64                         bigsur_defconfig
mips                     decstation_defconfig
arm                         assabet_defconfig
arm                  randconfig-c002-20220217
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                             allnoconfig
riscv                    nommu_virt_defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
mips                       lemote2f_defconfig
arm                       aspeed_g4_defconfig
powerpc                      ppc64e_defconfig
mips                      maltaaprp_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220217
hexagon              randconfig-r041-20220217
riscv                randconfig-r042-20220217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
