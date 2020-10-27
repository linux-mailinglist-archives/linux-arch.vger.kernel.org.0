Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1107029A388
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 05:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501892AbgJ0EEn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 00:04:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:21525 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733017AbgJ0EEl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Oct 2020 00:04:41 -0400
IronPort-SDR: JTUxT9hpUoETdyBNwSCAQi7iETsAalZHOBsUB6FTgZBKEjPz3dIiaCgEmYWP1knao3lz6VgVZL
 lZxRQWJKTnng==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="155803021"
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="155803021"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 21:04:38 -0700
IronPort-SDR: dBH9JvnJoWGE0KLCsezG3jdKygG8d3QBZLWmZv2kMlAElAFqyB9ohMzeF1e0A9sHb7j1/XR9uf
 WJbPAS75mdKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="535629911"
Received: from lkp-server01.sh.intel.com (HELO ef28dff175aa) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 Oct 2020 21:04:37 -0700
Received: from kbuild by ef28dff175aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kXGDs-00002h-V0; Tue, 27 Oct 2020 04:04:36 +0000
Date:   Tue, 27 Oct 2020 12:04:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [asm-generic:master] BUILD SUCCESS
 a259218ae60de9d1442c74728fe3a615cd435a19
Message-ID: <5f979c42.mkHhNSrm7jkTs5wc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git  master
branch HEAD: a259218ae60de9d1442c74728fe3a615cd435a19  Merge branch 'asm-generic-cleanup' into asm-generic

elapsed time: 722m

configs tested: 182
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                            zeus_defconfig
arm                         ebsa110_defconfig
arm                        shmobile_defconfig
sparc                            allyesconfig
powerpc                     sequoia_defconfig
arm                     davinci_all_defconfig
powerpc                       maple_defconfig
arm                           omap1_defconfig
powerpc                       holly_defconfig
m68k                        mvme147_defconfig
powerpc                     mpc83xx_defconfig
sh                          landisk_defconfig
powerpc                      obs600_defconfig
mips                     decstation_defconfig
arm                           sama5_defconfig
m68k                       m5249evb_defconfig
mips                    maltaup_xpa_defconfig
sh                             sh03_defconfig
ia64                             alldefconfig
arm                           sunxi_defconfig
powerpc                        icon_defconfig
sh                     magicpanelr2_defconfig
powerpc                   motionpro_defconfig
arm                       mainstone_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                   secureedge5410_defconfig
mips                       rbtx49xx_defconfig
sh                     sh7710voipgw_defconfig
powerpc                 mpc85xx_cds_defconfig
xtensa                generic_kc705_defconfig
arm                            qcom_defconfig
arm                           h3600_defconfig
arm                         s3c2410_defconfig
sh                          rsk7269_defconfig
mips                      pic32mzda_defconfig
sh                          rsk7264_defconfig
riscv                            allyesconfig
powerpc                     sbc8548_defconfig
arm                          exynos_defconfig
sh                      rts7751r2d1_defconfig
mips                      malta_kvm_defconfig
arm                         assabet_defconfig
arc                              alldefconfig
sh                           se7343_defconfig
xtensa                         virt_defconfig
powerpc                 linkstation_defconfig
mips                      bmips_stb_defconfig
parisc                generic-32bit_defconfig
arm                      integrator_defconfig
arm                          simpad_defconfig
arm                         shannon_defconfig
arm                         s3c6400_defconfig
sh                            shmin_defconfig
sh                             espt_defconfig
arm                          iop32x_defconfig
xtensa                              defconfig
arm                        multi_v7_defconfig
xtensa                  nommu_kc705_defconfig
arc                          axs101_defconfig
c6x                                 defconfig
sh                               j2_defconfig
mips                            gpr_defconfig
sh                            migor_defconfig
i386                             alldefconfig
powerpc                      mgcoge_defconfig
arm                            lart_defconfig
mips                     loongson1c_defconfig
arm                        mvebu_v5_defconfig
ia64                         bigsur_defconfig
x86_64                           allyesconfig
powerpc                      walnut_defconfig
c6x                        evmc6472_defconfig
mips                        nlm_xlp_defconfig
arc                        nsimosci_defconfig
sh                           se7780_defconfig
arm                          moxart_defconfig
sh                        edosk7760_defconfig
arm                             rpc_defconfig
sh                              ul2_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                          allyesconfig
powerpc                 mpc8313_rdb_defconfig
ia64                        generic_defconfig
m68k                       m5275evb_defconfig
m68k                        m5272c3_defconfig
arm                      footbridge_defconfig
arm                  colibri_pxa270_defconfig
mips                malta_kvm_guest_defconfig
sh                           se7750_defconfig
powerpc                   bluestone_defconfig
powerpc                   lite5200b_defconfig
arm                         mv78xx0_defconfig
mips                      fuloong2e_defconfig
mips                           mtx1_defconfig
m68k                            mac_defconfig
sh                        dreamcast_defconfig
powerpc                     ppa8548_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     redwood_defconfig
arc                      axs103_smp_defconfig
m68k                        mvme16x_defconfig
powerpc                      acadia_defconfig
powerpc                     tqm8560_defconfig
powerpc                         ps3_defconfig
c6x                        evmc6678_defconfig
powerpc                       ppc64_defconfig
arm                       versatile_defconfig
arc                     nsimosci_hs_defconfig
arm                           stm32_defconfig
powerpc                    gamecube_defconfig
mips                      pistachio_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20201026
i386                 randconfig-a003-20201026
i386                 randconfig-a005-20201026
i386                 randconfig-a001-20201026
i386                 randconfig-a006-20201026
i386                 randconfig-a004-20201026
x86_64               randconfig-a011-20201026
x86_64               randconfig-a013-20201026
x86_64               randconfig-a016-20201026
x86_64               randconfig-a015-20201026
x86_64               randconfig-a012-20201026
x86_64               randconfig-a014-20201026
i386                 randconfig-a016-20201026
i386                 randconfig-a015-20201026
i386                 randconfig-a014-20201026
i386                 randconfig-a012-20201026
i386                 randconfig-a013-20201026
i386                 randconfig-a011-20201026
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20201026
x86_64               randconfig-a003-20201026
x86_64               randconfig-a002-20201026
x86_64               randconfig-a006-20201026
x86_64               randconfig-a004-20201026
x86_64               randconfig-a005-20201026

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
