Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B531388440
	for <lists+linux-arch@lfdr.de>; Wed, 19 May 2021 03:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhESBOr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 21:14:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:57393 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231322AbhESBOq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 21:14:46 -0400
IronPort-SDR: VB33BSvkJEjR6h4a3Txnv7N6P4TAyfXEGvFywX+OVySM3toS2NmijmlEnpZiJ7jdq7/X2VKtJF
 irysWd7KGcfw==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="200922000"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="200922000"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 18:13:27 -0700
IronPort-SDR: 6I26iZ/4kST95kD6o+XyhLdabal85nb1pS9vaJuKRgzOjIiry9IFoaBytS0a4VpENOjIGe23zo
 PldUFuPsa+cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="461020798"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 May 2021 18:13:25 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ljAm5-0002QP-2A; Wed, 19 May 2021 01:13:25 +0000
Date:   Wed, 19 May 2021 09:13:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [asm-generic:asm-generic-compat-syscall] BUILD SUCCESS
 3967cc93c536b9e7e8e3a62178d1c647c3f92904
Message-ID: <60a46626.xO3UQ5iZIEhlEyCo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-compat-syscall
branch HEAD: 3967cc93c536b9e7e8e3a62178d1c647c3f92904  compat: remove some compat entry points

elapsed time: 724m

configs tested: 234
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        spear6xx_defconfig
mips                           rs90_defconfig
arm                           omap1_defconfig
xtensa                       common_defconfig
microblaze                      mmu_defconfig
mips                        nlm_xlp_defconfig
powerpc64                           defconfig
m68k                          atari_defconfig
powerpc                     ep8248e_defconfig
alpha                               defconfig
arm                          lpd270_defconfig
parisc                           alldefconfig
arm                        mini2440_defconfig
arm                     am200epdkit_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      ppc44x_defconfig
arm                       aspeed_g4_defconfig
arc                         haps_hs_defconfig
arm                         lubbock_defconfig
sh                          rsk7201_defconfig
sh                          landisk_defconfig
arc                      axs103_smp_defconfig
mips                           xway_defconfig
csky                             alldefconfig
powerpc                     tqm8555_defconfig
sh                           se7722_defconfig
mips                         mpc30x_defconfig
um                            kunit_defconfig
powerpc                      makalu_defconfig
powerpc                 mpc8315_rdb_defconfig
m68k                          hp300_defconfig
powerpc                     pq2fads_defconfig
powerpc                    socrates_defconfig
arm                       imx_v6_v7_defconfig
arm64                            alldefconfig
arm                          gemini_defconfig
sh                             espt_defconfig
sh                        apsh4ad0a_defconfig
sparc                       sparc32_defconfig
sh                              ul2_defconfig
sh                      rts7751r2d1_defconfig
xtensa                generic_kc705_defconfig
xtensa                    smp_lx200_defconfig
i386                                defconfig
sh                            hp6xx_defconfig
powerpc                 mpc837x_mds_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                     loongson2k_defconfig
m68k                       m5475evb_defconfig
powerpc                   lite5200b_defconfig
arm                           u8500_defconfig
um                                  defconfig
mips                           ip28_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      cm5200_defconfig
arm                           viper_defconfig
arc                        nsimosci_defconfig
i386                             alldefconfig
openrisc                  or1klitex_defconfig
sh                          kfr2r09_defconfig
mips                      malta_kvm_defconfig
arm                             rpc_defconfig
arm                          iop32x_defconfig
ia64                            zx1_defconfig
powerpc                 mpc834x_mds_defconfig
mips                   sb1250_swarm_defconfig
sh                          urquell_defconfig
arm                        realview_defconfig
mips                           ip32_defconfig
arm                         socfpga_defconfig
sh                               alldefconfig
powerpc                   currituck_defconfig
arm                            dove_defconfig
arc                     nsimosci_hs_defconfig
powerpc                     rainier_defconfig
mips                        maltaup_defconfig
m68k                         amcore_defconfig
sh                           se7721_defconfig
arm                         shannon_defconfig
sh                   secureedge5410_defconfig
mips                       rbtx49xx_defconfig
arm                        multi_v7_defconfig
m68k                         apollo_defconfig
arm                           h3600_defconfig
arm                      footbridge_defconfig
arm                            hisi_defconfig
arm                          exynos_defconfig
sh                          polaris_defconfig
alpha                            alldefconfig
mips                        nlm_xlr_defconfig
openrisc                    or1ksim_defconfig
powerpc                    ge_imp3a_defconfig
mips                     cu1830-neo_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                           se7343_defconfig
arm                          pxa168_defconfig
arm                         axm55xx_defconfig
powerpc                      ppc6xx_defconfig
powerpc                         wii_defconfig
arm                          simpad_defconfig
powerpc                     tqm8541_defconfig
mips                        qi_lb60_defconfig
x86_64                            allnoconfig
m68k                           sun3_defconfig
nios2                         3c120_defconfig
parisc                generic-64bit_defconfig
x86_64                              defconfig
arm                       multi_v4t_defconfig
arm                      integrator_defconfig
sparc                               defconfig
arm                          ep93xx_defconfig
arm                           h5000_defconfig
xtensa                  nommu_kc705_defconfig
arm                       aspeed_g5_defconfig
powerpc                      ppc64e_defconfig
sh                           se7206_defconfig
x86_64                           allyesconfig
mips                malta_qemu_32r6_defconfig
powerpc                       eiger_defconfig
powerpc                        icon_defconfig
powerpc                       maple_defconfig
powerpc                     tqm5200_defconfig
arm                        keystone_defconfig
mips                       lemote2f_defconfig
mips                        workpad_defconfig
sh                          rsk7269_defconfig
sh                         apsh4a3a_defconfig
powerpc                      bamboo_defconfig
riscv                             allnoconfig
powerpc                     mpc83xx_defconfig
xtensa                    xip_kc705_defconfig
m68k                        mvme16x_defconfig
powerpc                    klondike_defconfig
powerpc                     tqm8560_defconfig
microblaze                          defconfig
powerpc                 mpc834x_itx_defconfig
nds32                               defconfig
s390                             allyesconfig
arm                         assabet_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210518
x86_64               randconfig-a004-20210518
x86_64               randconfig-a005-20210518
x86_64               randconfig-a001-20210518
x86_64               randconfig-a002-20210518
x86_64               randconfig-a006-20210518
i386                 randconfig-a003-20210518
i386                 randconfig-a001-20210518
i386                 randconfig-a005-20210518
i386                 randconfig-a004-20210518
i386                 randconfig-a002-20210518
i386                 randconfig-a006-20210518
i386                 randconfig-a003-20210519
i386                 randconfig-a001-20210519
i386                 randconfig-a005-20210519
i386                 randconfig-a004-20210519
i386                 randconfig-a002-20210519
i386                 randconfig-a006-20210519
x86_64               randconfig-a012-20210519
x86_64               randconfig-a015-20210519
x86_64               randconfig-a013-20210519
x86_64               randconfig-a011-20210519
x86_64               randconfig-a016-20210519
x86_64               randconfig-a014-20210519
i386                 randconfig-a014-20210519
i386                 randconfig-a016-20210519
i386                 randconfig-a011-20210519
i386                 randconfig-a015-20210519
i386                 randconfig-a012-20210519
i386                 randconfig-a013-20210519
i386                 randconfig-a014-20210518
i386                 randconfig-a016-20210518
i386                 randconfig-a011-20210518
i386                 randconfig-a015-20210518
i386                 randconfig-a012-20210518
i386                 randconfig-a013-20210518
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                               allyesconfig
um                                allnoconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210519
x86_64               randconfig-b001-20210518
x86_64               randconfig-a003-20210519
x86_64               randconfig-a004-20210519
x86_64               randconfig-a005-20210519
x86_64               randconfig-a001-20210519
x86_64               randconfig-a002-20210519
x86_64               randconfig-a006-20210519
x86_64               randconfig-a015-20210518
x86_64               randconfig-a012-20210518
x86_64               randconfig-a013-20210518
x86_64               randconfig-a011-20210518
x86_64               randconfig-a016-20210518
x86_64               randconfig-a014-20210518

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
