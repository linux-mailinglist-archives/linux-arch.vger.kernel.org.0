Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1315F37F1D5
	for <lists+linux-arch@lfdr.de>; Thu, 13 May 2021 06:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbhEMEIU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 May 2021 00:08:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:32791 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhEMEIT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 May 2021 00:08:19 -0400
IronPort-SDR: hMgtISa7ZemgShrRukB+WjgRvyBztgow5smns/2RtbjPquGtgQoncscIdE01IpeVhDrbRckWEt
 fxa44Bs34u9Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="186994108"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="186994108"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 21:07:06 -0700
IronPort-SDR: JeNYgLTYN77sOLTwEQu1GwoYTvW8CYF49QYfmDt4yA1vkWkw449K8RgrPNTvDxX4W+7hvTfWDT
 H2pk1XjgznDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="471602181"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 May 2021 21:07:05 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lh2cq-00005z-Ip; Thu, 13 May 2021 04:07:04 +0000
Date:   Thu, 13 May 2021 12:06:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [asm-generic:unaligned-rework-v2] BUILD SUCCESS
 3be8a90fd433063539ff7b563a29c34b449f1c34
Message-ID: <609ca5b5.9bdrI1fuyiZEMQHe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git unaligned-rework-v2
branch HEAD: 3be8a90fd433063539ff7b563a29c34b449f1c34  asm-generic: simplify asm/unaligned.h

elapsed time: 720m

configs tested: 146
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
s390                       zfcpdump_defconfig
xtensa                    xip_kc705_defconfig
m68k                        m5407c3_defconfig
arc                 nsimosci_hs_smp_defconfig
ia64                        generic_defconfig
sh                          lboxre2_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                     loongson2k_defconfig
sh                         microdev_defconfig
powerpc                       ppc64_defconfig
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
powerpc                      cm5200_defconfig
powerpc                        warp_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     kmeter1_defconfig
s390                          debug_defconfig
powerpc                   currituck_defconfig
arm                        neponset_defconfig
m68k                             allyesconfig
s390                             allyesconfig
powerpc                      bamboo_defconfig
m68k                       bvme6000_defconfig
arm                     am200epdkit_defconfig
sh                        dreamcast_defconfig
mips                           gcw0_defconfig
powerpc                 mpc834x_itx_defconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
x86_64               randconfig-a003-20210512
x86_64               randconfig-a004-20210512
x86_64               randconfig-a001-20210512
x86_64               randconfig-a005-20210512
x86_64               randconfig-a002-20210512
x86_64               randconfig-a006-20210512
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
