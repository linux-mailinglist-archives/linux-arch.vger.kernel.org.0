Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710303DC13C
	for <lists+linux-arch@lfdr.de>; Sat, 31 Jul 2021 00:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhG3WnP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jul 2021 18:43:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:25420 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233121AbhG3WnP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Jul 2021 18:43:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="274249974"
X-IronPort-AV: E=Sophos;i="5.84,283,1620716400"; 
   d="scan'208";a="274249974"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 15:43:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,283,1620716400"; 
   d="scan'208";a="477203275"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jul 2021 15:43:07 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m9bDf-000APM-9X; Fri, 30 Jul 2021 22:43:07 +0000
Date:   Sat, 31 Jul 2021 06:42:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [asm-generic:asm-generic-uaccess-7] BUILD SUCCESS
 e6226997ec5ac272fa76274c3675bd5b7b437c53
Message-ID: <61048044.aaHJoo17JztAohmM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-uaccess-7
branch HEAD: e6226997ec5ac272fa76274c3675bd5b7b437c53  asm-generic: reverse GENERIC_{STRNCPY_FROM,STRNLEN}_USER symbols

elapsed time: 726m

configs tested: 96
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210730
sh                  sh7785lcr_32bit_defconfig
m68k                        stmark2_defconfig
arm                        clps711x_defconfig
arm                         bcm2835_defconfig
m68k                        m5307c3_defconfig
sh                          sdk7786_defconfig
mips                         mpc30x_defconfig
mips                           ci20_defconfig
arm                         socfpga_defconfig
arm                           h3600_defconfig
powerpc                    klondike_defconfig
arm                      footbridge_defconfig
arm                            mps2_defconfig
nios2                         10m50_defconfig
sh                          r7780mp_defconfig
arm                         palmz72_defconfig
powerpc                     tqm8540_defconfig
powerpc                 mpc8315_rdb_defconfig
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
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210730
i386                 randconfig-a004-20210730
i386                 randconfig-a003-20210730
i386                 randconfig-a002-20210730
i386                 randconfig-a006-20210730
i386                 randconfig-a001-20210730
x86_64               randconfig-a015-20210730
x86_64               randconfig-a014-20210730
x86_64               randconfig-a013-20210730
x86_64               randconfig-a011-20210730
x86_64               randconfig-a012-20210730
x86_64               randconfig-a016-20210730
i386                 randconfig-a013-20210730
i386                 randconfig-a016-20210730
i386                 randconfig-a012-20210730
i386                 randconfig-a011-20210730
i386                 randconfig-a014-20210730
i386                 randconfig-a015-20210730
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
x86_64               randconfig-c001-20210730
x86_64               randconfig-a001-20210730
x86_64               randconfig-a006-20210730
x86_64               randconfig-a005-20210730
x86_64               randconfig-a004-20210730
x86_64               randconfig-a002-20210730
x86_64               randconfig-a003-20210730

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
