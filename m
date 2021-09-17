Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6529740EECB
	for <lists+linux-arch@lfdr.de>; Fri, 17 Sep 2021 03:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242340AbhIQBfc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Sep 2021 21:35:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:61401 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242315AbhIQBf3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Sep 2021 21:35:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="245089367"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="245089367"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 18:34:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="583855106"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Sep 2021 18:34:05 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mR2lQ-0001cS-0X; Fri, 17 Sep 2021 01:34:04 +0000
Date:   Fri, 17 Sep 2021 09:33:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:master] BUILD SUCCESS
 7962c2eddbfe7cce879acb06f9b4f205789e57b7
Message-ID: <6143f05d.AUh9jnwR6km4jk+Q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
branch HEAD: 7962c2eddbfe7cce879acb06f9b4f205789e57b7  arch: remove unused function syscall_set_arguments()

elapsed time: 1678m

configs tested: 193
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210916
arm                        clps711x_defconfig
powerpc                 mpc8313_rdb_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                      cm5200_defconfig
sh                        edosk7705_defconfig
x86_64                           allyesconfig
powerpc                      chrp32_defconfig
arm                         bcm2835_defconfig
arm                         at91_dt_defconfig
sh                           se7780_defconfig
riscv                            alldefconfig
mips                malta_qemu_32r6_defconfig
arm                        mvebu_v5_defconfig
arm                         vf610m4_defconfig
powerpc                      ppc40x_defconfig
sh                          rsk7201_defconfig
sh                          polaris_defconfig
powerpc                 mpc8560_ads_defconfig
arm                         lubbock_defconfig
arm                          ep93xx_defconfig
arc                              alldefconfig
powerpc                      ppc44x_defconfig
sh                          landisk_defconfig
um                           x86_64_defconfig
powerpc                     ep8248e_defconfig
arm                        mvebu_v7_defconfig
arc                        nsimosci_defconfig
arm                          moxart_defconfig
powerpc                        fsp2_defconfig
mips                  decstation_64_defconfig
mips                          ath79_defconfig
s390                          debug_defconfig
powerpc                 mpc8272_ads_defconfig
mips                         db1xxx_defconfig
sh                           se7712_defconfig
powerpc                     tqm8555_defconfig
arm                          pxa910_defconfig
powerpc                     tqm8541_defconfig
powerpc                     tqm8548_defconfig
powerpc                     kmeter1_defconfig
riscv                          rv32_defconfig
s390                       zfcpdump_defconfig
sh                           se7724_defconfig
powerpc                     tqm5200_defconfig
sh                   sh7770_generic_defconfig
powerpc                      acadia_defconfig
sh                          lboxre2_defconfig
powerpc                   lite5200b_defconfig
mips                        nlm_xlr_defconfig
m68k                        stmark2_defconfig
mips                   sb1250_swarm_defconfig
powerpc                  mpc885_ads_defconfig
arm                         cm_x300_defconfig
sh                               alldefconfig
m68k                         amcore_defconfig
arm                        oxnas_v6_defconfig
sh                           se7206_defconfig
arm                         lpc18xx_defconfig
powerpc                    socrates_defconfig
arm                       netwinder_defconfig
sparc                       sparc32_defconfig
m68k                           sun3_defconfig
ia64                      gensparse_defconfig
mips                        workpad_defconfig
arm                     eseries_pxa_defconfig
powerpc                    klondike_defconfig
sh                           se7343_defconfig
powerpc                 mpc837x_mds_defconfig
arc                        vdk_hs38_defconfig
nios2                         10m50_defconfig
xtensa                    smp_lx200_defconfig
powerpc                     ksi8560_defconfig
powerpc                      tqm8xx_defconfig
mips                      bmips_stb_defconfig
arm                      pxa255-idp_defconfig
sh                            hp6xx_defconfig
mips                  cavium_octeon_defconfig
nios2                         3c120_defconfig
arm                             rpc_defconfig
arm                        realview_defconfig
arm                            hisi_defconfig
sh                           se7722_defconfig
arm                       versatile_defconfig
sh                              ul2_defconfig
sh                         ecovec24_defconfig
sh                          sdk7780_defconfig
arm                           u8500_defconfig
powerpc                       holly_defconfig
powerpc                   microwatt_defconfig
h8300                               defconfig
sh                          rsk7203_defconfig
m68k                       m5249evb_defconfig
powerpc                      bamboo_defconfig
sparc64                          alldefconfig
m68k                                defconfig
openrisc                         alldefconfig
m68k                       m5475evb_defconfig
powerpc                     pseries_defconfig
mips                           ip27_defconfig
arm                       imx_v6_v7_defconfig
arm                     am200epdkit_defconfig
m68k                            mac_defconfig
powerpc                    mvme5100_defconfig
sh                        apsh4ad0a_defconfig
arm                           tegra_defconfig
powerpc                     kilauea_defconfig
m68k                             alldefconfig
sh                            shmin_defconfig
sh                        dreamcast_defconfig
x86_64               randconfig-c001-20210916
arm                  randconfig-c002-20210916
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a016-20210916
x86_64               randconfig-a013-20210916
x86_64               randconfig-a012-20210916
x86_64               randconfig-a011-20210916
x86_64               randconfig-a014-20210916
x86_64               randconfig-a015-20210916
i386                 randconfig-a016-20210916
i386                 randconfig-a015-20210916
i386                 randconfig-a011-20210916
i386                 randconfig-a012-20210916
i386                 randconfig-a013-20210916
i386                 randconfig-a014-20210916
riscv                randconfig-r042-20210916
s390                 randconfig-r044-20210916
arc                  randconfig-r043-20210916
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20210916
x86_64               randconfig-c007-20210916
mips                 randconfig-c004-20210916
powerpc              randconfig-c003-20210916
arm                  randconfig-c002-20210916
i386                 randconfig-c001-20210916
s390                 randconfig-c005-20210916
x86_64               randconfig-a002-20210916
x86_64               randconfig-a003-20210916
x86_64               randconfig-a006-20210916
x86_64               randconfig-a004-20210916
x86_64               randconfig-a005-20210916
x86_64               randconfig-a001-20210916
i386                 randconfig-a004-20210916
i386                 randconfig-a005-20210916
i386                 randconfig-a006-20210916
i386                 randconfig-a002-20210916
i386                 randconfig-a003-20210916
i386                 randconfig-a001-20210916
hexagon              randconfig-r045-20210916
hexagon              randconfig-r041-20210916

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
