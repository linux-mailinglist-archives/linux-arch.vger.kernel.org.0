Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DCD386DEA
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 01:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbhEQXwq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 May 2021 19:52:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:60777 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344629AbhEQXwp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 May 2021 19:52:45 -0400
IronPort-SDR: ZKJeq05swjlksii7achmMeDHHaTSu/dB9vnLTx7KoYAQHgfEgSZqqT9f2Y/lCW30zZw9vFSgTH
 moA4L8eeUluw==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="200283417"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="200283417"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 16:51:24 -0700
IronPort-SDR: +h6aOLXTfv8Z4kyUiRlP9GYuTABiKAmbW7lStzBLRrlyfab56Sf638AAcpbwNG5cSCHhHyvcNt
 DDHzzWXuk9MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="411027752"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 17 May 2021 16:51:22 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lin17-0001xz-Uu; Mon, 17 May 2021 23:51:21 +0000
Date:   Tue, 18 May 2021 07:51:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [asm-generic:asm-generic-unaligned] BUILD SUCCESS
 803f4e1eab7a8938ba3a3c30dd4eb5e9eeef5e63
Message-ID: <60a30172.tg+UeRPH+mMXU3hA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-unaligned
branch HEAD: 803f4e1eab7a8938ba3a3c30dd4eb5e9eeef5e63  asm-generic: simplify asm/unaligned.h

elapsed time: 723m

configs tested: 117
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                           stm32_defconfig
mips                        nlm_xlr_defconfig
mips                      loongson3_defconfig
sh                        edosk7705_defconfig
m68k                                defconfig
arm                          moxart_defconfig
openrisc                         alldefconfig
m68k                          multi_defconfig
riscv                    nommu_k210_defconfig
arm                         at91_dt_defconfig
powerpc                     ep8248e_defconfig
m68k                       m5249evb_defconfig
arm                       spear13xx_defconfig
sh                        edosk7760_defconfig
x86_64                           alldefconfig
arm                             mxs_defconfig
powerpc                 mpc8560_ads_defconfig
mips                        maltaup_defconfig
powerpc                     stx_gp3_defconfig
sh                     sh7710voipgw_defconfig
powerpc                     ppa8548_defconfig
openrisc                  or1klitex_defconfig
um                               allyesconfig
h8300                    h8300h-sim_defconfig
powerpc                        cell_defconfig
ia64                      gensparse_defconfig
xtensa                  cadence_csp_defconfig
powerpc                     mpc5200_defconfig
nios2                            allyesconfig
mips                     loongson1c_defconfig
powerpc                   currituck_defconfig
sh                             shx3_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     tqm5200_defconfig
mips                    maltaup_xpa_defconfig
arm                     am200epdkit_defconfig
arm                         vf610m4_defconfig
s390                       zfcpdump_defconfig
arm                            zeus_defconfig
ia64                          tiger_defconfig
csky                             alldefconfig
xtensa                       common_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nds32                               defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210517
x86_64               randconfig-a003-20210517
x86_64               randconfig-a001-20210517
x86_64               randconfig-a005-20210517
x86_64               randconfig-a002-20210517
x86_64               randconfig-a006-20210517

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
