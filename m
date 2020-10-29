Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DA029E167
	for <lists+linux-arch@lfdr.de>; Thu, 29 Oct 2020 03:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgJ2CAw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Oct 2020 22:00:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:39399 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgJ2CAv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Oct 2020 22:00:51 -0400
IronPort-SDR: INkz7f5yL5weUl0yEd/cu63B2iGh0R5zFSJ3ycVCehIlpb/1rRAyoe5r2+Hl/N9luPW5Zbn5nI
 iVjpKvqjz2/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="168496763"
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="168496763"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 19:00:44 -0700
IronPort-SDR: PJPjDHY7LDjZhRs3jTXD9VcvFqe1OD8EOgItOg1NdhvEP6xVeaEcK2/JSj5XnF6yKfGPX6Dlm5
 H3RT5ERor6Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="318806226"
Received: from lkp-server02.sh.intel.com (HELO 0471ce7c9af6) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 28 Oct 2020 19:00:43 -0700
Received: from kbuild by 0471ce7c9af6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kXxF4-0000Jc-Ij; Thu, 29 Oct 2020 02:00:42 +0000
Date:   Thu, 29 Oct 2020 09:59:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [asm-generic:asm-generic-cleanup] BUILD SUCCESS
 caabdd0f59a9771ed095efe3ad5a08867b976ab2
Message-ID: <5f9a221f.2XTlFgNrrQkeQMHq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git  asm-generic-cleanup
branch HEAD: caabdd0f59a9771ed095efe3ad5a08867b976ab2  ctype.h: remove duplicate isdigit() helper

elapsed time: 721m

configs tested: 153
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                        m5307c3_defconfig
c6x                                 defconfig
s390                             allyesconfig
arm                          prima2_defconfig
ia64                          tiger_defconfig
openrisc                         alldefconfig
mips                        maltaup_defconfig
sh                           se7721_defconfig
arc                          axs103_defconfig
powerpc                    socrates_defconfig
powerpc64                           defconfig
arm                         nhk8815_defconfig
arm                          pxa3xx_defconfig
ia64                                defconfig
ia64                        generic_defconfig
mips                          malta_defconfig
sh                          lboxre2_defconfig
mips                           gcw0_defconfig
powerpc                       ebony_defconfig
sh                   sh7770_generic_defconfig
c6x                              allyesconfig
arm                          simpad_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                              zx_defconfig
c6x                         dsk6455_defconfig
parisc                generic-32bit_defconfig
powerpc                    gamecube_defconfig
arm                      integrator_defconfig
powerpc                     mpc5200_defconfig
powerpc                      chrp32_defconfig
arc                     haps_hs_smp_defconfig
m68k                       m5249evb_defconfig
arm                           tegra_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                   lite5200b_defconfig
sh                   secureedge5410_defconfig
powerpc                        warp_defconfig
sh                              ul2_defconfig
xtensa                  nommu_kc705_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                        edosk7760_defconfig
sh                ecovec24-romimage_defconfig
riscv                            alldefconfig
powerpc                     asp8347_defconfig
powerpc                     mpc512x_defconfig
sh                           se7206_defconfig
mips                          rb532_defconfig
sh                           se7343_defconfig
powerpc                      walnut_defconfig
mips                     decstation_defconfig
m68k                        m5407c3_defconfig
mips                            gpr_defconfig
sh                               j2_defconfig
mips                            e55_defconfig
ia64                      gensparse_defconfig
microblaze                          defconfig
arm                        multi_v7_defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc8272_ads_defconfig
sh                          r7780mp_defconfig
mips                            ar7_defconfig
mips                           ip22_defconfig
mips                malta_qemu_32r6_defconfig
sh                             espt_defconfig
arm                          ixp4xx_defconfig
um                            kunit_defconfig
m68k                          multi_defconfig
nds32                            alldefconfig
um                           x86_64_defconfig
arm                      tct_hammer_defconfig
mips                       bmips_be_defconfig
arm                           viper_defconfig
arm                            zeus_defconfig
sh                          rsk7264_defconfig
powerpc                    klondike_defconfig
arm                          pxa168_defconfig
riscv                    nommu_virt_defconfig
ia64                             allmodconfig
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
i386                 randconfig-a002-20201028
i386                 randconfig-a005-20201028
i386                 randconfig-a003-20201028
i386                 randconfig-a001-20201028
i386                 randconfig-a004-20201028
i386                 randconfig-a006-20201028
x86_64               randconfig-a011-20201028
x86_64               randconfig-a013-20201028
x86_64               randconfig-a016-20201028
x86_64               randconfig-a015-20201028
x86_64               randconfig-a012-20201028
x86_64               randconfig-a014-20201028
i386                 randconfig-a016-20201028
i386                 randconfig-a014-20201028
i386                 randconfig-a015-20201028
i386                 randconfig-a013-20201028
i386                 randconfig-a012-20201028
i386                 randconfig-a011-20201028
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20201026
x86_64               randconfig-a003-20201026
x86_64               randconfig-a002-20201026
x86_64               randconfig-a006-20201026
x86_64               randconfig-a004-20201026
x86_64               randconfig-a005-20201026
x86_64               randconfig-a001-20201028
x86_64               randconfig-a002-20201028
x86_64               randconfig-a003-20201028
x86_64               randconfig-a006-20201028
x86_64               randconfig-a005-20201028
x86_64               randconfig-a004-20201028

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
