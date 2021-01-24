Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29031301E67
	for <lists+linux-arch@lfdr.de>; Sun, 24 Jan 2021 20:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbhAXTN3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Jan 2021 14:13:29 -0500
Received: from mga05.intel.com ([192.55.52.43]:36097 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbhAXTN1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 24 Jan 2021 14:13:27 -0500
IronPort-SDR: MRTpMrmQoG5INBM4LdNFiJsBlMgDG8eo/NHvu/qRpZ9owukqc9NCvDFMZ0prGp++iq6mzZllZ5
 990/9Oe3EDPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="264454414"
X-IronPort-AV: E=Sophos;i="5.79,371,1602572400"; 
   d="scan'208";a="264454414"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 11:12:46 -0800
IronPort-SDR: KrOe1P0wvo0Ho7YBg4aUyFk8rzDlYE+253g9LKY6NrX82MVJaRbWSADFhnoL5RhAsbM+uPPLxK
 svz8+/jKWltQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,371,1602572400"; 
   d="scan'208";a="352707691"
Received: from lkp-server01.sh.intel.com (HELO 27c4e0a4b6d9) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2021 11:12:45 -0800
Received: from kbuild by 27c4e0a4b6d9 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l3koW-0000QS-Ap; Sun, 24 Jan 2021 19:12:44 +0000
Date:   Mon, 25 Jan 2021 03:11:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [asm-generic:master] BUILD SUCCESS
 38489db09b109c22eedf6cd3846ef742bceb45fe
Message-ID: <600dc679.QtJoPrbXnXwtzKCa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
branch HEAD: 38489db09b109c22eedf6cd3846ef742bceb45fe  Merge branch 'asm-generic-fixes' into asm-generic

elapsed time: 737m

configs tested: 132
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        mvebu_v5_defconfig
mips                    maltaup_xpa_defconfig
powerpc                      ppc40x_defconfig
sh                              ul2_defconfig
mips                       lemote2f_defconfig
sh                          rsk7264_defconfig
powerpc                 linkstation_defconfig
arm                      pxa255-idp_defconfig
arm                     am200epdkit_defconfig
mips                      pistachio_defconfig
xtensa                  cadence_csp_defconfig
arm                            lart_defconfig
mips                        omega2p_defconfig
powerpc                    gamecube_defconfig
sh                            migor_defconfig
powerpc                      ppc44x_defconfig
mips                         tb0219_defconfig
powerpc                      pcm030_defconfig
powerpc                       ebony_defconfig
sh                             espt_defconfig
sparc64                             defconfig
arc                              allyesconfig
powerpc                  mpc885_ads_defconfig
s390                          debug_defconfig
arm                          iop32x_defconfig
arm                          tango4_defconfig
mips                        nlm_xlr_defconfig
sh                         apsh4a3a_defconfig
powerpc                      cm5200_defconfig
sparc                       sparc32_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                    vt8500_v6_v7_defconfig
sh                                  defconfig
sh                           se7712_defconfig
arm                        neponset_defconfig
mips                        workpad_defconfig
powerpc                      walnut_defconfig
arm                           sama5_defconfig
mips                          ath79_defconfig
mips                         db1xxx_defconfig
arm                             mxs_defconfig
powerpc                  storcenter_defconfig
arm                          lpd270_defconfig
nios2                            alldefconfig
arm                          pcm027_defconfig
mips                       capcella_defconfig
mips                          ath25_defconfig
sh                   rts7751r2dplus_defconfig
arm                          simpad_defconfig
arm                         shannon_defconfig
powerpc                        fsp2_defconfig
arm                         s5pv210_defconfig
arc                           tb10x_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                   lite5200b_defconfig
arm                           stm32_defconfig
arm                        realview_defconfig
powerpc                     sbc8548_defconfig
alpha                               defconfig
arc                 nsimosci_hs_smp_defconfig
arm                        vexpress_defconfig
arm                        oxnas_v6_defconfig
mips                           ci20_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210124
i386                 randconfig-a002-20210124
i386                 randconfig-a003-20210124
x86_64               randconfig-a012-20210124
x86_64               randconfig-a016-20210124
x86_64               randconfig-a015-20210124
x86_64               randconfig-a011-20210124
x86_64               randconfig-a013-20210124
x86_64               randconfig-a014-20210124
i386                 randconfig-a013-20210124
i386                 randconfig-a012-20210124
i386                 randconfig-a014-20210124
i386                 randconfig-a016-20210124
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210124
x86_64               randconfig-a002-20210124
x86_64               randconfig-a001-20210124
x86_64               randconfig-a005-20210124
x86_64               randconfig-a006-20210124
x86_64               randconfig-a004-20210124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
