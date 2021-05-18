Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828A638762E
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 12:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243425AbhERKMV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 06:12:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:20895 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241553AbhERKMS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 06:12:18 -0400
IronPort-SDR: AtXSjBwUNT3+5yYzZrzmfefCbIDaAdTWxTDf1dOJS0OfNzRAbFWNhkC/d2R1cYvnxXfTAdRyn4
 3byWi3g3sjGQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="187799019"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="187799019"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 03:11:00 -0700
IronPort-SDR: WkCOGJlFC7k2VeqOGoDegZpnPiyuY9LQV994tA0cYZfgg4SXrzLTgU+be362KyMuE0ZFCTkzqR
 BGDc+SH1omMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="393899335"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 May 2021 03:10:59 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1liwgk-00028j-Ak; Tue, 18 May 2021 10:10:58 +0000
Date:   Tue, 18 May 2021 18:10:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [asm-generic:compat-alloc-user-space-9] BUILD SUCCESS
 c20b182ddc8032c63c381bf868f99222bab89537
Message-ID: <60a392a8.+hoieje/Fo46qCiQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git compat-alloc-user-space-9
branch HEAD: c20b182ddc8032c63c381bf868f99222bab89537  net: bonding: move ioctl handling to private ndo operation

elapsed time: 723m

configs tested: 119
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     akebono_defconfig
arm                  colibri_pxa300_defconfig
arc                      axs103_smp_defconfig
mips                         bigsur_defconfig
sh                             sh03_defconfig
arc                    vdk_hs38_smp_defconfig
m68k                         amcore_defconfig
arm                        keystone_defconfig
um                                  defconfig
sh                          urquell_defconfig
powerpc                      arches_defconfig
mips                    maltaup_xpa_defconfig
sh                             shx3_defconfig
powerpc                        cell_defconfig
arm                           u8500_defconfig
arm                          iop32x_defconfig
powerpc                 mpc85xx_cds_defconfig
s390                          debug_defconfig
xtensa                generic_kc705_defconfig
mips                            ar7_defconfig
arm                           spitz_defconfig
arc                           tb10x_defconfig
arm                            lart_defconfig
mips                          malta_defconfig
m68k                       m5275evb_defconfig
powerpc                     tqm8548_defconfig
sh                          lboxre2_defconfig
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
i386                 randconfig-a003-20210517
i386                 randconfig-a001-20210517
i386                 randconfig-a004-20210517
i386                 randconfig-a005-20210517
i386                 randconfig-a002-20210517
i386                 randconfig-a006-20210517
x86_64               randconfig-a012-20210517
x86_64               randconfig-a015-20210517
x86_64               randconfig-a011-20210517
x86_64               randconfig-a013-20210517
x86_64               randconfig-a016-20210517
x86_64               randconfig-a014-20210517
i386                 randconfig-a016-20210517
i386                 randconfig-a014-20210517
i386                 randconfig-a011-20210517
i386                 randconfig-a012-20210517
i386                 randconfig-a015-20210517
i386                 randconfig-a013-20210517
i386                 randconfig-a014-20210518
i386                 randconfig-a016-20210518
i386                 randconfig-a011-20210518
i386                 randconfig-a015-20210518
i386                 randconfig-a012-20210518
i386                 randconfig-a013-20210518
x86_64               randconfig-a003-20210518
x86_64               randconfig-a004-20210518
x86_64               randconfig-a005-20210518
x86_64               randconfig-a001-20210518
x86_64               randconfig-a002-20210518
x86_64               randconfig-a006-20210518
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
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210518
x86_64               randconfig-b001-20210517
x86_64               randconfig-a004-20210517
x86_64               randconfig-a003-20210517
x86_64               randconfig-a001-20210517
x86_64               randconfig-a005-20210517
x86_64               randconfig-a002-20210517
x86_64               randconfig-a006-20210517

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
