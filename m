Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F07B381D69
	for <lists+linux-arch@lfdr.de>; Sun, 16 May 2021 10:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhEPIdZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 May 2021 04:33:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:44181 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230248AbhEPIdY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 16 May 2021 04:33:24 -0400
IronPort-SDR: veB+KxYrXkMX+Eo8mKqWHacP+6TEsQ2BM0z3WW3CLQsbm+l6QyTDR3CLtAGTt4mEHb9IkOKdFK
 RxOkgegwm5+A==
X-IronPort-AV: E=McAfee;i="6200,9189,9985"; a="187450206"
X-IronPort-AV: E=Sophos;i="5.82,304,1613462400"; 
   d="scan'208";a="187450206"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2021 01:32:10 -0700
IronPort-SDR: g8jCs6z+mtKmHF46dcBioQrhv6bMTIEo3QPcPo8hOa+PpGSrutoZONm0xMJ1fFavdmbxjaeFI2
 AvH2/8HUvoTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,304,1613462400"; 
   d="scan'208";a="437236415"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 16 May 2021 01:32:08 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1liCBz-0001OO-NN; Sun, 16 May 2021 08:32:07 +0000
Date:   Sun, 16 May 2021 16:32:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [asm-generic:unaligned-sh4a] BUILD SUCCESS
 be31970519e9a6e8d7993d0c70bfbb10014e1785
Message-ID: <60a0d881.uy+vl5rTAk+C5FIO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git unaligned-sh4a
branch HEAD: be31970519e9a6e8d7993d0c70bfbb10014e1785  sh: add back asm/unaligned.h for sh4a

elapsed time: 722m

configs tested: 108
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                            mmp2_defconfig
m68k                          sun3x_defconfig
sh                        apsh4ad0a_defconfig
xtensa                  audio_kc705_defconfig
powerpc                     kmeter1_defconfig
mips                        bcm63xx_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                   sh7770_generic_defconfig
powerpc                     tqm8541_defconfig
arm                        shmobile_defconfig
arm                           stm32_defconfig
arm                       versatile_defconfig
mips                        nlm_xlr_defconfig
sh                        dreamcast_defconfig
sh                   sh7724_generic_defconfig
sh                          r7780mp_defconfig
arm                       multi_v4t_defconfig
arc                     nsimosci_hs_defconfig
sh                           se7750_defconfig
powerpc                       ebony_defconfig
arm                       netwinder_defconfig
mips                          ath25_defconfig
mips                   sb1250_swarm_defconfig
arm                            qcom_defconfig
powerpc                     powernv_defconfig
mips                     loongson1c_defconfig
m68k                          amiga_defconfig
powerpc                     asp8347_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210516
x86_64               randconfig-a003-20210516
x86_64               randconfig-a001-20210516
x86_64               randconfig-a005-20210516
x86_64               randconfig-a002-20210516
x86_64               randconfig-a006-20210516
i386                 randconfig-a003-20210516
i386                 randconfig-a001-20210516
i386                 randconfig-a004-20210516
i386                 randconfig-a005-20210516
i386                 randconfig-a002-20210516
i386                 randconfig-a006-20210516
i386                 randconfig-a016-20210516
i386                 randconfig-a014-20210516
i386                 randconfig-a011-20210516
i386                 randconfig-a012-20210516
i386                 randconfig-a015-20210516
i386                 randconfig-a013-20210516
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
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210516
x86_64               randconfig-a012-20210516
x86_64               randconfig-a011-20210516
x86_64               randconfig-a013-20210516
x86_64               randconfig-a016-20210516
x86_64               randconfig-a014-20210516

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
