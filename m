Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3F92B5A17
	for <lists+linux-arch@lfdr.de>; Tue, 17 Nov 2020 08:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgKQHMQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Nov 2020 02:12:16 -0500
Received: from mga04.intel.com ([192.55.52.120]:30978 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbgKQHMQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Nov 2020 02:12:16 -0500
IronPort-SDR: PuMLCrKcyZ6gU72USZhXfkufWIALmcbJkDyktfEfNItxZm/4g0CTQ22CDgJ3m5xF4FE/E8khpY
 ndF+6buo2sTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="168298515"
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="168298515"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 23:12:15 -0800
IronPort-SDR: tQEj5T6hPBSvGpOh9kWxqfW/KM3maHJdfDN0HfZrq7Vq0PIGaUIPq7l+0OcIADjB9Ybp4+fbk2
 SRfoniO56snw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="367773031"
Received: from lkp-server01.sh.intel.com (HELO 345567a03a52) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Nov 2020 23:12:13 -0800
Received: from kbuild by 345567a03a52 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kev9w-00003M-F8; Tue, 17 Nov 2020 07:12:12 +0000
Date:   Tue, 17 Nov 2020 15:12:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [asm-generic:asm-generic-fixes] BUILD SUCCESS
 cef397038167ac15d085914493d6c86385773709
Message-ID: <5fb377c7.hw7VIXvrLKqhVFtr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git  asm-generic-fixes
branch HEAD: cef397038167ac15d085914493d6c86385773709  arch: pgtable: define MAX_POSSIBLE_PHYSMEM_BITS where needed

elapsed time: 725m

configs tested: 173
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     tqm8541_defconfig
arm                            qcom_defconfig
ia64                        generic_defconfig
m68k                         amcore_defconfig
arm                      footbridge_defconfig
mips                     cu1830-neo_defconfig
arm                         socfpga_defconfig
nios2                         10m50_defconfig
powerpc                 mpc8315_rdb_defconfig
xtensa                  nommu_kc705_defconfig
sh                          rsk7203_defconfig
arm                       netwinder_defconfig
arm                     am200epdkit_defconfig
mips                           gcw0_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     mpc512x_defconfig
sh                        sh7785lcr_defconfig
arm                        oxnas_v6_defconfig
m68k                            q40_defconfig
m68k                       m5475evb_defconfig
arm                       cns3420vb_defconfig
arm                        mini2440_defconfig
arm                        vexpress_defconfig
mips                  decstation_64_defconfig
arc                                 defconfig
powerpc               mpc834x_itxgp_defconfig
mips                         bigsur_defconfig
sh                           sh2007_defconfig
mips                        bcm63xx_defconfig
arm                         shannon_defconfig
sh                 kfr2r09-romimage_defconfig
arm                          iop32x_defconfig
powerpc                 linkstation_defconfig
mips                          rb532_defconfig
m68k                        mvme147_defconfig
openrisc                    or1ksim_defconfig
sh                          rsk7201_defconfig
mips                          rm200_defconfig
mips                       lemote2f_defconfig
mips                 decstation_r4k_defconfig
powerpc                     ppa8548_defconfig
sh                     magicpanelr2_defconfig
arm                            zeus_defconfig
arm                           omap1_defconfig
arm                        neponset_defconfig
mips                           ip22_defconfig
mips                         tb0219_defconfig
arc                      axs103_smp_defconfig
mips                        qi_lb60_defconfig
m68k                            mac_defconfig
mips                          ath79_defconfig
sh                         ecovec24_defconfig
m68k                          hp300_defconfig
arm                          gemini_defconfig
arm                      tct_hammer_defconfig
mips                        bcm47xx_defconfig
mips                      loongson3_defconfig
powerpc                     stx_gp3_defconfig
arc                     nsimosci_hs_defconfig
mips                        jmr3927_defconfig
powerpc                       holly_defconfig
xtensa                          iss_defconfig
powerpc                     mpc83xx_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                     powernv_defconfig
arm                            mmp2_defconfig
arm                         lpc32xx_defconfig
ia64                      gensparse_defconfig
powerpc                    amigaone_defconfig
sh                           se7724_defconfig
arc                    vdk_hs38_smp_defconfig
sh                          rsk7264_defconfig
powerpc                     tqm5200_defconfig
mips                            e55_defconfig
powerpc                     tqm8560_defconfig
sh                     sh7710voipgw_defconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
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
x86_64               randconfig-a003-20201116
x86_64               randconfig-a005-20201116
x86_64               randconfig-a004-20201116
x86_64               randconfig-a002-20201116
x86_64               randconfig-a001-20201116
x86_64               randconfig-a006-20201116
i386                 randconfig-a006-20201116
i386                 randconfig-a005-20201116
i386                 randconfig-a001-20201116
i386                 randconfig-a002-20201116
i386                 randconfig-a004-20201116
i386                 randconfig-a003-20201116
i386                 randconfig-a006-20201115
i386                 randconfig-a005-20201115
i386                 randconfig-a001-20201115
i386                 randconfig-a002-20201115
i386                 randconfig-a004-20201115
i386                 randconfig-a003-20201115
x86_64               randconfig-a015-20201115
x86_64               randconfig-a011-20201115
x86_64               randconfig-a014-20201115
x86_64               randconfig-a013-20201115
x86_64               randconfig-a016-20201115
x86_64               randconfig-a012-20201115
i386                 randconfig-a012-20201116
i386                 randconfig-a014-20201116
i386                 randconfig-a016-20201116
i386                 randconfig-a011-20201116
i386                 randconfig-a015-20201116
i386                 randconfig-a013-20201116
i386                 randconfig-a012-20201115
i386                 randconfig-a014-20201115
i386                 randconfig-a016-20201115
i386                 randconfig-a011-20201115
i386                 randconfig-a015-20201115
i386                 randconfig-a013-20201115
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a003-20201115
x86_64               randconfig-a005-20201115
x86_64               randconfig-a004-20201115
x86_64               randconfig-a002-20201115
x86_64               randconfig-a001-20201115
x86_64               randconfig-a006-20201115
x86_64               randconfig-a015-20201116
x86_64               randconfig-a011-20201116
x86_64               randconfig-a014-20201116
x86_64               randconfig-a013-20201116
x86_64               randconfig-a016-20201116
x86_64               randconfig-a012-20201116

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
