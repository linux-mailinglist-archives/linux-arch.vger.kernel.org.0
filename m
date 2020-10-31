Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F402A1452
	for <lists+linux-arch@lfdr.de>; Sat, 31 Oct 2020 10:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgJaJDU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 31 Oct 2020 05:03:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:5938 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgJaJDT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 31 Oct 2020 05:03:19 -0400
IronPort-SDR: KfFUygIq3WbUH7JJsE+oj4ss/sCbcqtGWHVJPvgOIGRZ09aGYXU8GBZ8VpS1oxfnchhroqA3mN
 OYW2FB3WPutQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="147996899"
X-IronPort-AV: E=Sophos;i="5.77,436,1596524400"; 
   d="scan'208";a="147996899"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2020 02:03:18 -0700
IronPort-SDR: yeGWwZlXg60ZpgYX3K1ed4FkwxFCf1NSZ9RHzW5pSR0LzhZMysAFRjkw2hvH2gn4+kpRJECHea
 XymICWUtzeww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,436,1596524400"; 
   d="scan'208";a="526138532"
Received: from lkp-server02.sh.intel.com (HELO fcc9f8859912) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 31 Oct 2020 02:03:17 -0700
Received: from kbuild by fcc9f8859912 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kYmn7-0000Ut-1x; Sat, 31 Oct 2020 09:03:17 +0000
Date:   Sat, 31 Oct 2020 17:02:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [asm-generic:master] BUILD SUCCESS
 78d127fd689200ff1d62d1f24f6be8dd68250764
Message-ID: <5f9d2821.oVjhGmr3+psxlcic%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git  master
branch HEAD: 78d127fd689200ff1d62d1f24f6be8dd68250764  Merge branch 'asm-generic-timers' into asm-generic

elapsed time: 720m

configs tested: 149
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          r7785rp_defconfig
arm                          ep93xx_defconfig
arc                     nsimosci_hs_defconfig
i386                             alldefconfig
sh                           se7722_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                        mvme16x_defconfig
mips                      maltasmvp_defconfig
sh                             shx3_defconfig
mips                      loongson3_defconfig
powerpc                   motionpro_defconfig
arm                     eseries_pxa_defconfig
sh                          r7780mp_defconfig
arm                           omap1_defconfig
powerpc                     kilauea_defconfig
mips                  maltasmvp_eva_defconfig
arm                   milbeaut_m10v_defconfig
sparc                       sparc32_defconfig
powerpc                     skiroot_defconfig
x86_64                           allyesconfig
arc                        vdk_hs38_defconfig
arm                          exynos_defconfig
s390                          debug_defconfig
arm                            pleb_defconfig
ia64                          tiger_defconfig
powerpc                 mpc834x_mds_defconfig
xtensa                  nommu_kc705_defconfig
mips                malta_kvm_guest_defconfig
arm                        keystone_defconfig
h8300                    h8300h-sim_defconfig
arm                          ixp4xx_defconfig
arm                         shannon_defconfig
sh                           se7751_defconfig
powerpc64                           defconfig
arm                          tango4_defconfig
powerpc                      chrp32_defconfig
mips                     loongson1c_defconfig
powerpc                     kmeter1_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc8540_ads_defconfig
mips                           mtx1_defconfig
mips                          rm200_defconfig
arc                         haps_hs_defconfig
arm                        multi_v5_defconfig
alpha                            alldefconfig
powerpc                       ebony_defconfig
sh                        apsh4ad0a_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                         ps3_defconfig
arm                         socfpga_defconfig
powerpc                 mpc8560_ads_defconfig
m68k                       bvme6000_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                         lubbock_defconfig
arm                        magician_defconfig
mips                        bcm47xx_defconfig
arc                     haps_hs_smp_defconfig
um                             i386_defconfig
mips                          ath79_defconfig
openrisc                         alldefconfig
arm                        shmobile_defconfig
sh                ecovec24-romimage_defconfig
ia64                      gensparse_defconfig
sh                           se7721_defconfig
mips                        workpad_defconfig
arm                         s3c6400_defconfig
arm                            lart_defconfig
powerpc                  iss476-smp_defconfig
mips                     loongson1b_defconfig
sparc                            allyesconfig
riscv                               defconfig
arm                       multi_v4t_defconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20201030
x86_64               randconfig-a001-20201030
x86_64               randconfig-a002-20201030
x86_64               randconfig-a003-20201030
x86_64               randconfig-a006-20201030
x86_64               randconfig-a004-20201030
i386                 randconfig-a005-20201030
i386                 randconfig-a003-20201030
i386                 randconfig-a002-20201030
i386                 randconfig-a001-20201030
i386                 randconfig-a006-20201030
i386                 randconfig-a004-20201030
i386                 randconfig-a005-20201031
i386                 randconfig-a003-20201031
i386                 randconfig-a002-20201031
i386                 randconfig-a001-20201031
i386                 randconfig-a006-20201031
i386                 randconfig-a004-20201031
i386                 randconfig-a011-20201030
i386                 randconfig-a014-20201030
i386                 randconfig-a015-20201030
i386                 randconfig-a012-20201030
i386                 randconfig-a013-20201030
i386                 randconfig-a016-20201030
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                   rhel
x86_64                              defconfig
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20201030
x86_64               randconfig-a014-20201030
x86_64               randconfig-a015-20201030
x86_64               randconfig-a016-20201030
x86_64               randconfig-a011-20201030
x86_64               randconfig-a012-20201030

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
