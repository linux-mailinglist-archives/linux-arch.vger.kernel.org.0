Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BFC3A0A8D
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 05:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhFIDPS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 23:15:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:9340 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233346AbhFIDPR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 23:15:17 -0400
IronPort-SDR: 6BFOdnwbq6aB8MhYmwZB4PhZMoz5N4MbUSyJXvKSQCF0uSXcEgFHazjWfjMMAh/ENntEUKiStK
 zcWbO3MqCMHw==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="192102305"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="192102305"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 20:13:23 -0700
IronPort-SDR: RPglAXc3MELbLvppd3l5WFovLwjrhZAvKbtekGviw3NwPR4/WwG5SoQPTGjOOgVZnyv+TfHVJq
 pkUx0KwxarpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="449779304"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jun 2021 20:13:21 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lqoee-0009LR-Uj; Wed, 09 Jun 2021 03:13:20 +0000
Date:   Wed, 09 Jun 2021 11:12:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [asm-generic:clkdev] BUILD SUCCESS
 5617c9125bb66a923f3560d5739eb7f3a21c00b5
Message-ID: <60c031af./IB1dtbWRmsJ/Thz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git clkdev
branch HEAD: 5617c9125bb66a923f3560d5739eb7f3a21c00b5  clkdev: remove unused clkdev_alloc() interfaces

elapsed time: 725m

configs tested: 193
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         rt305x_defconfig
mips                      malta_kvm_defconfig
powerpc                     asp8347_defconfig
arm                           spitz_defconfig
sparc                       sparc32_defconfig
nios2                            allyesconfig
sh                          rsk7203_defconfig
mips                    maltaup_xpa_defconfig
openrisc                 simple_smp_defconfig
mips                      maltasmvp_defconfig
arm                         orion5x_defconfig
h8300                       h8s-sim_defconfig
arm                   milbeaut_m10v_defconfig
xtensa                           alldefconfig
mips                          ath79_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                           se7722_defconfig
sh                           se7724_defconfig
sh                          sdk7786_defconfig
arc                          axs103_defconfig
xtensa                           allyesconfig
arm                    vt8500_v6_v7_defconfig
mips                     loongson2k_defconfig
powerpc                     taishan_defconfig
xtensa                          iss_defconfig
powerpc                     pseries_defconfig
parisc                generic-32bit_defconfig
h8300                    h8300h-sim_defconfig
mips                      loongson3_defconfig
ia64                      gensparse_defconfig
m68k                            q40_defconfig
openrisc                            defconfig
mips                     cu1000-neo_defconfig
arc                        nsim_700_defconfig
arm                       versatile_defconfig
sh                         microdev_defconfig
sh                             espt_defconfig
powerpc                 mpc837x_rdb_defconfig
h8300                            allyesconfig
powerpc                      ep88xc_defconfig
m68k                          atari_defconfig
powerpc                      cm5200_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                       eiger_defconfig
powerpc                     tqm8560_defconfig
mips                      fuloong2e_defconfig
xtensa                  audio_kc705_defconfig
arm                         lpc32xx_defconfig
sh                           se7343_defconfig
mips                         tb0226_defconfig
arm                      integrator_defconfig
arm                         cm_x300_defconfig
arm                         bcm2835_defconfig
mips                            ar7_defconfig
arm64                            alldefconfig
arm                           tegra_defconfig
sh                           se7206_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 linkstation_defconfig
xtensa                  nommu_kc705_defconfig
i386                             allyesconfig
ia64                        generic_defconfig
powerpc                        warp_defconfig
powerpc                   currituck_defconfig
mips                  cavium_octeon_defconfig
sh                          sdk7780_defconfig
arm                             mxs_defconfig
mips                       rbtx49xx_defconfig
mips                             allmodconfig
arc                         haps_hs_defconfig
powerpc                         wii_defconfig
arm                         s3c2410_defconfig
mips                       lemote2f_defconfig
arm                       aspeed_g4_defconfig
mips                           ip27_defconfig
powerpc                      ppc6xx_defconfig
arm                         s5pv210_defconfig
arm                         shannon_defconfig
m68k                          amiga_defconfig
s390                             allyesconfig
powerpc                     tqm8555_defconfig
nios2                         3c120_defconfig
powerpc                    mvme5100_defconfig
arm                        cerfcube_defconfig
mips                      maltaaprp_defconfig
um                           x86_64_defconfig
powerpc                    gamecube_defconfig
powerpc                       ebony_defconfig
arm                         mv78xx0_defconfig
ia64                         bigsur_defconfig
m68k                           sun3_defconfig
powerpc                      pmac32_defconfig
arm                          simpad_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                           se7619_defconfig
xtensa                         virt_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                       imx_v6_v7_defconfig
arm                       netwinder_defconfig
um                             i386_defconfig
powerpc                     tqm5200_defconfig
sh                   secureedge5410_defconfig
powerpc                      bamboo_defconfig
powerpc                  mpc866_ads_defconfig
mips                        workpad_defconfig
nds32                             allnoconfig
powerpc                     mpc83xx_defconfig
arm                      jornada720_defconfig
arc                           tb10x_defconfig
microblaze                          defconfig
powerpc                     kilauea_defconfig
sh                        edosk7760_defconfig
sh                   sh7770_generic_defconfig
arm                     am200epdkit_defconfig
mips                      bmips_stb_defconfig
um                               alldefconfig
arm                          pxa168_defconfig
h8300                               defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210608
x86_64               randconfig-a002-20210608
x86_64               randconfig-a003-20210608
x86_64               randconfig-a006-20210608
x86_64               randconfig-a005-20210608
x86_64               randconfig-a001-20210608
i386                 randconfig-a003-20210608
i386                 randconfig-a006-20210608
i386                 randconfig-a004-20210608
i386                 randconfig-a001-20210608
i386                 randconfig-a005-20210608
i386                 randconfig-a002-20210608
i386                 randconfig-a015-20210608
i386                 randconfig-a013-20210608
i386                 randconfig-a016-20210608
i386                 randconfig-a011-20210608
i386                 randconfig-a012-20210608
i386                 randconfig-a014-20210608
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210607
x86_64               randconfig-a004-20210607
x86_64               randconfig-a003-20210607
x86_64               randconfig-a006-20210607
x86_64               randconfig-a005-20210607
x86_64               randconfig-a001-20210607
x86_64               randconfig-a015-20210608
x86_64               randconfig-a012-20210608
x86_64               randconfig-a014-20210608
x86_64               randconfig-a011-20210608
x86_64               randconfig-a016-20210608
x86_64               randconfig-a013-20210608

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
