Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F38C4276F7
	for <lists+linux-arch@lfdr.de>; Sat,  9 Oct 2021 05:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhJIDqg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 23:46:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:52481 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229561AbhJIDqf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Oct 2021 23:46:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10131"; a="287512497"
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="287512497"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 20:44:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="590746520"
Received: from lkp-server02.sh.intel.com (HELO 1950922c5479) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Oct 2021 20:44:38 -0700
Received: from kbuild by 1950922c5479 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mZ3Hp-00015X-IF; Sat, 09 Oct 2021 03:44:37 +0000
Date:   Sat, 09 Oct 2021 11:44:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 7efbbe6e141466dbe022b39fafbc81d17a8ed8be
Message-ID: <61611010.38NlnrNRAeRVN3Zm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 7efbbe6e141466dbe022b39fafbc81d17a8ed8be  qcom_scm: hide Kconfig symbol

elapsed time: 2217m

configs tested: 166
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211008
s390                          debug_defconfig
parisc                generic-32bit_defconfig
m68k                       bvme6000_defconfig
arm                            hisi_defconfig
openrisc                            defconfig
m68k                         amcore_defconfig
arm                      pxa255-idp_defconfig
mips                          rb532_defconfig
mips                            gpr_defconfig
powerpc                  mpc866_ads_defconfig
arm                         bcm2835_defconfig
powerpc                      cm5200_defconfig
microblaze                      mmu_defconfig
xtensa                           allyesconfig
xtensa                         virt_defconfig
powerpc                      obs600_defconfig
m68k                          amiga_defconfig
arm                        realview_defconfig
mips                      loongson3_defconfig
sh                          landisk_defconfig
sh                         microdev_defconfig
powerpc                       ppc64_defconfig
mips                          ath25_defconfig
arm                         orion5x_defconfig
arm                          collie_defconfig
sh                   secureedge5410_defconfig
ia64                        generic_defconfig
mips                        maltaup_defconfig
powerpc                      ppc64e_defconfig
xtensa                  audio_kc705_defconfig
powerpc                  mpc885_ads_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                    socrates_defconfig
arm                          pcm027_defconfig
powerpc                      pasemi_defconfig
mips                       rbtx49xx_defconfig
powerpc                   currituck_defconfig
sh                            hp6xx_defconfig
ia64                             alldefconfig
mips                         tb0219_defconfig
arc                            hsdk_defconfig
sh                        apsh4ad0a_defconfig
mips                  decstation_64_defconfig
sh                        sh7785lcr_defconfig
h8300                       h8s-sim_defconfig
sh                          rsk7264_defconfig
powerpc                       holly_defconfig
sh                            migor_defconfig
sh                         ecovec24_defconfig
powerpc                 mpc836x_rdk_defconfig
xtensa                generic_kc705_defconfig
mips                         db1xxx_defconfig
arm                          ep93xx_defconfig
powerpc                   microwatt_defconfig
arm                     davinci_all_defconfig
sh                          polaris_defconfig
xtensa                          iss_defconfig
arm                       multi_v4t_defconfig
powerpc                     ksi8560_defconfig
mips                        bcm63xx_defconfig
x86_64               randconfig-c001-20211008
arm                  randconfig-c002-20211008
x86_64               randconfig-c001-20211003
i386                 randconfig-c001-20211003
arm                  randconfig-c002-20211003
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a015-20211008
x86_64               randconfig-a012-20211008
x86_64               randconfig-a016-20211008
x86_64               randconfig-a013-20211008
x86_64               randconfig-a011-20211008
x86_64               randconfig-a014-20211008
x86_64               randconfig-a015-20211004
x86_64               randconfig-a012-20211004
x86_64               randconfig-a016-20211004
x86_64               randconfig-a014-20211004
x86_64               randconfig-a013-20211004
x86_64               randconfig-a011-20211004
i386                 randconfig-a013-20211008
i386                 randconfig-a016-20211008
i386                 randconfig-a014-20211008
i386                 randconfig-a011-20211008
i386                 randconfig-a012-20211008
i386                 randconfig-a015-20211008
i386                 randconfig-a013-20211004
i386                 randconfig-a016-20211004
i386                 randconfig-a014-20211004
i386                 randconfig-a011-20211004
i386                 randconfig-a012-20211004
i386                 randconfig-a015-20211004
arc                  randconfig-r043-20211008
s390                 randconfig-r044-20211008
riscv                randconfig-r042-20211008
arc                  randconfig-r043-20211007
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20211004
x86_64               randconfig-a005-20211004
x86_64               randconfig-a001-20211004
x86_64               randconfig-a002-20211004
x86_64               randconfig-a004-20211004
x86_64               randconfig-a006-20211004
i386                 randconfig-a001-20211008
i386                 randconfig-a003-20211008
i386                 randconfig-a005-20211008
i386                 randconfig-a004-20211008
i386                 randconfig-a002-20211008
i386                 randconfig-a006-20211008
i386                 randconfig-a001-20211004
i386                 randconfig-a003-20211004
i386                 randconfig-a005-20211004
i386                 randconfig-a002-20211004
i386                 randconfig-a004-20211004
i386                 randconfig-a006-20211004
hexagon              randconfig-r045-20211007
hexagon              randconfig-r041-20211007
s390                 randconfig-r044-20211007
riscv                randconfig-r042-20211007

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
