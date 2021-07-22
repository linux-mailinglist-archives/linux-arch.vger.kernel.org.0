Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F333D2D97
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 22:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhGVTmF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 15:42:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:42608 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230079AbhGVTmE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jul 2021 15:42:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="211738146"
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="211738146"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 13:22:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="662849961"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jul 2021 13:22:37 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m6fDJ-0000mT-A7; Thu, 22 Jul 2021 20:22:37 +0000
Date:   Fri, 23 Jul 2021 04:22:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [asm-generic:network-ioctl-v6] BUILD SUCCESS
 53ee412663f70832b994bdeeb5f72a928764ffe3
Message-ID: <60f9d389.ZQTWmNT1lpETkoDF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git network-ioctl-v6
branch HEAD: 53ee412663f70832b994bdeeb5f72a928764ffe3  net: bonding: move ioctl handling to private ndo operation

elapsed time: 727m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210722
xtensa                    xip_kc705_defconfig
m68k                       m5208evb_defconfig
mips                         bigsur_defconfig
powerpc                      katmai_defconfig
powerpc                      makalu_defconfig
powerpc                 mpc8540_ads_defconfig
sparc                               defconfig
powerpc                     taishan_defconfig
arm                          exynos_defconfig
sh                           se7721_defconfig
arm                         cm_x300_defconfig
openrisc                         alldefconfig
powerpc                      mgcoge_defconfig
arc                         haps_hs_defconfig
arm                        mini2440_defconfig
m68k                          atari_defconfig
powerpc                 mpc832x_mds_defconfig
arm                           u8500_defconfig
mips                           ci20_defconfig
powerpc                           allnoconfig
h8300                       h8s-sim_defconfig
mips                  cavium_octeon_defconfig
arm                          pxa168_defconfig
powerpc                         ps3_defconfig
m68k                         apollo_defconfig
sparc                            alldefconfig
sh                          lboxre2_defconfig
nds32                            alldefconfig
sh                          rsk7269_defconfig
arm                       imx_v6_v7_defconfig
powerpc                     asp8347_defconfig
microblaze                          defconfig
powerpc                      chrp32_defconfig
sh                          polaris_defconfig
mips                        bcm47xx_defconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
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
x86_64               randconfig-a003-20210722
x86_64               randconfig-a006-20210722
x86_64               randconfig-a001-20210722
x86_64               randconfig-a005-20210722
x86_64               randconfig-a004-20210722
x86_64               randconfig-a002-20210722
i386                 randconfig-a005-20210722
i386                 randconfig-a003-20210722
i386                 randconfig-a004-20210722
i386                 randconfig-a002-20210722
i386                 randconfig-a001-20210722
i386                 randconfig-a006-20210722
i386                 randconfig-a016-20210722
i386                 randconfig-a013-20210722
i386                 randconfig-a012-20210722
i386                 randconfig-a011-20210722
i386                 randconfig-a014-20210722
i386                 randconfig-a015-20210722
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210722
x86_64               randconfig-b001-20210722
x86_64               randconfig-a011-20210722
x86_64               randconfig-a016-20210722
x86_64               randconfig-a013-20210722
x86_64               randconfig-a014-20210722
x86_64               randconfig-a012-20210722
x86_64               randconfig-a015-20210722

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
