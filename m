Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147ED3EC5EC
	for <lists+linux-arch@lfdr.de>; Sun, 15 Aug 2021 01:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbhHNXSy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 Aug 2021 19:18:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:64171 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233223AbhHNXSy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 14 Aug 2021 19:18:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10076"; a="215737009"
X-IronPort-AV: E=Sophos;i="5.84,322,1620716400"; 
   d="scan'208";a="215737009"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2021 16:18:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,322,1620716400"; 
   d="scan'208";a="678361853"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 14 Aug 2021 16:18:23 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mF2v0-000PLF-Ve; Sat, 14 Aug 2021 23:18:22 +0000
Date:   Sun, 15 Aug 2021 07:18:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [asm-generic:master] BUILD SUCCESS
 8f76f9c46952659dd925c21c3f62a0d05a3f3e71
Message-ID: <61184f39.KlHxSTln/jd9KQxq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
branch HEAD: 8f76f9c46952659dd925c21c3f62a0d05a3f3e71  bitops/non-atomic: make @nr unsigned to avoid any DIV

elapsed time: 722m

configs tested: 165
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210814
mips                            ar7_defconfig
arm64                            alldefconfig
arm                            pleb_defconfig
powerpc                       ppc64_defconfig
sh                   sh7770_generic_defconfig
openrisc                  or1klitex_defconfig
m68k                        m5407c3_defconfig
powerpc                    klondike_defconfig
mips                     loongson1c_defconfig
arm                          ep93xx_defconfig
arm                          iop32x_defconfig
h8300                       h8s-sim_defconfig
riscv                    nommu_k210_defconfig
arm                        clps711x_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                  maltasmvp_eva_defconfig
mips                         bigsur_defconfig
powerpc64                           defconfig
powerpc                        cell_defconfig
m68k                          hp300_defconfig
arm                         at91_dt_defconfig
powerpc                      mgcoge_defconfig
m68k                          sun3x_defconfig
xtensa                          iss_defconfig
arm                      jornada720_defconfig
mips                     cu1830-neo_defconfig
sparc                            alldefconfig
arm                          lpd270_defconfig
arm                          simpad_defconfig
m68k                        stmark2_defconfig
sh                          lboxre2_defconfig
powerpc                     tqm5200_defconfig
powerpc                      walnut_defconfig
mips                      bmips_stb_defconfig
sh                           se7619_defconfig
arm                         orion5x_defconfig
sh                               alldefconfig
arm                         s3c6400_defconfig
arm                             mxs_defconfig
sparc                       sparc32_defconfig
arm                        multi_v5_defconfig
powerpc                      makalu_defconfig
powerpc                       maple_defconfig
mips                           rs90_defconfig
powerpc                         wii_defconfig
powerpc                     ksi8560_defconfig
h8300                            allyesconfig
arm                     davinci_all_defconfig
sh                           se7206_defconfig
sh                                  defconfig
arm                           corgi_defconfig
xtensa                  audio_kc705_defconfig
arm                       aspeed_g4_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                       lemote2f_defconfig
mips                         tb0287_defconfig
powerpc                     sbc8548_defconfig
arm                           viper_defconfig
arm                          collie_defconfig
xtensa                  nommu_kc705_defconfig
sh                   sh7724_generic_defconfig
sh                          sdk7780_defconfig
powerpc                        warp_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
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
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210814
x86_64               randconfig-a006-20210814
x86_64               randconfig-a003-20210814
x86_64               randconfig-a001-20210814
x86_64               randconfig-a005-20210814
x86_64               randconfig-a002-20210814
i386                 randconfig-a004-20210814
i386                 randconfig-a002-20210814
i386                 randconfig-a001-20210814
i386                 randconfig-a003-20210814
i386                 randconfig-a006-20210814
i386                 randconfig-a005-20210814
i386                 randconfig-a004-20210815
i386                 randconfig-a001-20210815
i386                 randconfig-a002-20210815
i386                 randconfig-a003-20210815
i386                 randconfig-a006-20210815
i386                 randconfig-a005-20210815
x86_64               randconfig-a013-20210815
x86_64               randconfig-a011-20210815
x86_64               randconfig-a016-20210815
x86_64               randconfig-a012-20210815
x86_64               randconfig-a014-20210815
x86_64               randconfig-a015-20210815
i386                 randconfig-a011-20210814
i386                 randconfig-a015-20210814
i386                 randconfig-a013-20210814
i386                 randconfig-a014-20210814
i386                 randconfig-a016-20210814
i386                 randconfig-a012-20210814
i386                 randconfig-a011-20210815
i386                 randconfig-a015-20210815
i386                 randconfig-a014-20210815
i386                 randconfig-a013-20210815
i386                 randconfig-a016-20210815
i386                 randconfig-a012-20210815
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210814
x86_64               randconfig-a004-20210815
x86_64               randconfig-a006-20210815
x86_64               randconfig-a003-20210815
x86_64               randconfig-a001-20210815
x86_64               randconfig-a002-20210815
x86_64               randconfig-a005-20210815
x86_64               randconfig-a013-20210814
x86_64               randconfig-a011-20210814
x86_64               randconfig-a016-20210814
x86_64               randconfig-a012-20210814
x86_64               randconfig-a014-20210814
x86_64               randconfig-a015-20210814

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
