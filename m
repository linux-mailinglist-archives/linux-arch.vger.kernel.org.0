Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABF937F1D4
	for <lists+linux-arch@lfdr.de>; Thu, 13 May 2021 06:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhEMEIT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 May 2021 00:08:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:46950 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhEMEIS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 May 2021 00:08:18 -0400
IronPort-SDR: u6DaTau5W4/1ST8aBs3vPwjO2wRv23k1ovHDt69rQz7mQ38zzo4CgiAQKEfGVrY4l0i4MoZc6C
 5os+fa34E6Vw==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="199545618"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="199545618"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 21:07:06 -0700
IronPort-SDR: RS5RASIGC1X4cV1dQicJ6McplDE322Nuwr9mfMRcdTsBM/kTCvetgxDfc1aNaTntdO/+OLjNbQ
 k/T16BbXfRIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="392129738"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 12 May 2021 21:07:05 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lh2cq-000061-JO; Thu, 13 May 2021 04:07:04 +0000
Date:   Thu, 13 May 2021 12:06:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [asm-generic:master] BUILD SUCCESS
 d74ebb76967f2395128f8cb7e87c31c27758e104
Message-ID: <609ca5b0.U0lRjXNJJKYPl4pB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
branch HEAD: d74ebb76967f2395128f8cb7e87c31c27758e104  Merge branch 'asm-generic-unaligned' into asm-generic

elapsed time: 720m

configs tested: 170
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                           h3600_defconfig
mips                      malta_kvm_defconfig
arm                        realview_defconfig
arm                      footbridge_defconfig
powerpc                     sequoia_defconfig
mips                  decstation_64_defconfig
s390                       zfcpdump_defconfig
xtensa                    xip_kc705_defconfig
m68k                        m5407c3_defconfig
arc                 nsimosci_hs_smp_defconfig
ia64                        generic_defconfig
sh                          lboxre2_defconfig
arm                       aspeed_g4_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      mgcoge_defconfig
powerpc                   lite5200b_defconfig
sparc64                          alldefconfig
powerpc                 mpc836x_rdk_defconfig
mips                     loongson2k_defconfig
sh                         microdev_defconfig
powerpc                       ppc64_defconfig
nds32                               defconfig
arc                     haps_hs_smp_defconfig
mips                          rm200_defconfig
powerpc                      cm5200_defconfig
powerpc                      katmai_defconfig
powerpc                      pcm030_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                      ppc64e_defconfig
arm                        neponset_defconfig
arm                           h5000_defconfig
h8300                               defconfig
openrisc                  or1klitex_defconfig
mips                     cu1000-neo_defconfig
arm                           omap1_defconfig
m68k                        mvme147_defconfig
powerpc                     skiroot_defconfig
arm                              alldefconfig
m68k                       m5208evb_defconfig
arm                           viper_defconfig
sh                        edosk7705_defconfig
s390                          debug_defconfig
mips                           xway_defconfig
i386                                defconfig
powerpc                 canyonlands_defconfig
openrisc                 simple_smp_defconfig
powerpc                        warp_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     kmeter1_defconfig
powerpc                   currituck_defconfig
m68k                             allyesconfig
s390                             allyesconfig
powerpc                      bamboo_defconfig
m68k                       bvme6000_defconfig
arm                     am200epdkit_defconfig
sh                        dreamcast_defconfig
mips                           gcw0_defconfig
arm                          ixp4xx_defconfig
sh                        sh7785lcr_defconfig
mips                           ci20_defconfig
powerpc                 mpc8272_ads_defconfig
sh                             sh03_defconfig
arm                           sama5_defconfig
arm                       imx_v6_v7_defconfig
sh                         ap325rxa_defconfig
sparc                               defconfig
powerpc                          g5_defconfig
powerpc                 mpc834x_mds_defconfig
h8300                       h8s-sim_defconfig
powerpc                    adder875_defconfig
sh                               j2_defconfig
sh                   sh7770_generic_defconfig
arm                          pxa168_defconfig
ia64                          tiger_defconfig
powerpc                       holly_defconfig
arm                   milbeaut_m10v_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                          simpad_defconfig
mips                     loongson1b_defconfig
m68k                        mvme16x_defconfig
m68k                       m5249evb_defconfig
powerpc                        cell_defconfig
sh                           se7780_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
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
x86_64               randconfig-a003-20210512
x86_64               randconfig-a004-20210512
x86_64               randconfig-a001-20210512
x86_64               randconfig-a005-20210512
x86_64               randconfig-a002-20210512
x86_64               randconfig-a006-20210512
i386                 randconfig-a003-20210512
i386                 randconfig-a001-20210512
i386                 randconfig-a005-20210512
i386                 randconfig-a004-20210512
i386                 randconfig-a002-20210512
i386                 randconfig-a006-20210512
i386                 randconfig-a003-20210513
i386                 randconfig-a001-20210513
i386                 randconfig-a005-20210513
i386                 randconfig-a004-20210513
i386                 randconfig-a002-20210513
i386                 randconfig-a006-20210513
i386                 randconfig-a016-20210512
i386                 randconfig-a014-20210512
i386                 randconfig-a011-20210512
i386                 randconfig-a015-20210512
i386                 randconfig-a012-20210512
i386                 randconfig-a013-20210512
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-a003-20210513
x86_64               randconfig-a004-20210513
x86_64               randconfig-a001-20210513
x86_64               randconfig-a005-20210513
x86_64               randconfig-a002-20210513
x86_64               randconfig-a006-20210513
x86_64               randconfig-a015-20210512
x86_64               randconfig-a012-20210512
x86_64               randconfig-a011-20210512
x86_64               randconfig-a013-20210512
x86_64               randconfig-a016-20210512
x86_64               randconfig-a014-20210512

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
