Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B9738D7EA
	for <lists+linux-arch@lfdr.de>; Sun, 23 May 2021 02:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhEWAKw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 22 May 2021 20:10:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:7659 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231476AbhEWAKv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 22 May 2021 20:10:51 -0400
IronPort-SDR: ls9S0tYsZbmmiT+s0jDNp3Gx9ctZLCpNWS12bGntcwVIKHlkaAG6LDaF0ACSVP26AD0AKpLTD/
 X8z2rCu5+ypg==
X-IronPort-AV: E=McAfee;i="6200,9189,9992"; a="201741293"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="201741293"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2021 17:09:23 -0700
IronPort-SDR: 8hbDTTTgbqa1tbArZQAHOUShjSr5vHZfz7KL++/kceV2sjpUelINwKFLd4V40GgUd8AlZiZ2Uy
 1wP+td/EQriA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="463105260"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 22 May 2021 17:09:22 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lkbgI-0000ZM-1J; Sun, 23 May 2021 00:09:22 +0000
Date:   Sun, 23 May 2021 08:08:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [asm-generic:master] BUILD SUCCESS
 14462376858e35b83932f94616effc2f49fd8494
Message-ID: <60a99cf6.0Q0+R/BPNMNJoMCa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
branch HEAD: 14462376858e35b83932f94616effc2f49fd8494  Merge branch 'asm-generic-unaligned' into asm-generic

elapsed time: 756m

configs tested: 228
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
openrisc                         alldefconfig
powerpc                 xes_mpc85xx_defconfig
mips                          ath79_defconfig
sh                        sh7785lcr_defconfig
i386                                defconfig
arm                       mainstone_defconfig
sh                   sh7724_generic_defconfig
sparc                       sparc64_defconfig
mips                           ci20_defconfig
sh                        edosk7705_defconfig
sh                               j2_defconfig
arm                            pleb_defconfig
arm                         lubbock_defconfig
arm                        mvebu_v7_defconfig
sh                           se7619_defconfig
arm                             pxa_defconfig
mips                           gcw0_defconfig
powerpc                 mpc8272_ads_defconfig
m68k                          amiga_defconfig
powerpc                     ppa8548_defconfig
arm                  colibri_pxa300_defconfig
mips                         tb0287_defconfig
openrisc                  or1klitex_defconfig
openrisc                            defconfig
arm                     am200epdkit_defconfig
arc                        vdk_hs38_defconfig
sh                          polaris_defconfig
powerpc                    adder875_defconfig
m68k                        m5307c3_defconfig
powerpc                 mpc832x_mds_defconfig
mips                        nlm_xlr_defconfig
powerpc                     tqm8541_defconfig
xtensa                         virt_defconfig
powerpc                mpc7448_hpc2_defconfig
parisc                           alldefconfig
mips                       rbtx49xx_defconfig
sh                          rsk7264_defconfig
x86_64                           alldefconfig
powerpc                     pseries_defconfig
ia64                            zx1_defconfig
ia64                      gensparse_defconfig
powerpc                     mpc512x_defconfig
arm                          pxa3xx_defconfig
powerpc                          g5_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                      ppc6xx_defconfig
arm                           h5000_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     skiroot_defconfig
um                           x86_64_defconfig
arc                 nsimosci_hs_smp_defconfig
ia64                         bigsur_defconfig
mips                          ath25_defconfig
arm                              alldefconfig
powerpc                     sbc8548_defconfig
mips                  decstation_64_defconfig
sh                        sh7757lcr_defconfig
xtensa                generic_kc705_defconfig
ia64                          tiger_defconfig
arm                             ezx_defconfig
arm                         lpc32xx_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                         tb0226_defconfig
sh                             shx3_defconfig
powerpc                      makalu_defconfig
mips                           ip27_defconfig
sh                          kfr2r09_defconfig
mips                malta_qemu_32r6_defconfig
arm64                            alldefconfig
powerpc                     mpc5200_defconfig
powerpc                    amigaone_defconfig
m68k                       m5208evb_defconfig
powerpc                 mpc8560_ads_defconfig
arm                           u8500_defconfig
m68k                        m5272c3_defconfig
mips                        qi_lb60_defconfig
arm                          pxa910_defconfig
sh                          rsk7203_defconfig
sh                         apsh4a3a_defconfig
arm                             rpc_defconfig
arm                           sunxi_defconfig
arc                           tb10x_defconfig
arm                        magician_defconfig
mips                       lemote2f_defconfig
arm                     davinci_all_defconfig
m68k                        m5407c3_defconfig
arm                         assabet_defconfig
arm                         nhk8815_defconfig
um                             i386_defconfig
arm                         palmz72_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                 decstation_r4k_defconfig
mips                      maltaaprp_defconfig
mips                         rt305x_defconfig
sh                          landisk_defconfig
powerpc                     powernv_defconfig
sh                          r7780mp_defconfig
sh                           se7705_defconfig
powerpc                       holly_defconfig
powerpc                     taishan_defconfig
powerpc                         wii_defconfig
sh                              ul2_defconfig
m68k                          sun3x_defconfig
m68k                           sun3_defconfig
arm                        neponset_defconfig
powerpc                      pasemi_defconfig
powerpc                      obs600_defconfig
arc                     haps_hs_smp_defconfig
arm                         vf610m4_defconfig
h8300                               defconfig
nds32                            alldefconfig
sh                      rts7751r2d1_defconfig
powerpc                     tqm5200_defconfig
microblaze                          defconfig
sh                           se7750_defconfig
arm                           corgi_defconfig
mips                          malta_defconfig
mips                         mpc30x_defconfig
m68k                            mac_defconfig
m68k                            q40_defconfig
sh                        sh7763rdp_defconfig
powerpc                      katmai_defconfig
powerpc                     stx_gp3_defconfig
sh                     magicpanelr2_defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20210522
x86_64               randconfig-a006-20210522
x86_64               randconfig-a005-20210522
x86_64               randconfig-a003-20210522
x86_64               randconfig-a004-20210522
x86_64               randconfig-a002-20210522
i386                 randconfig-a001-20210523
i386                 randconfig-a005-20210523
i386                 randconfig-a002-20210523
i386                 randconfig-a003-20210523
i386                 randconfig-a004-20210523
i386                 randconfig-a006-20210523
i386                 randconfig-a001-20210522
i386                 randconfig-a005-20210522
i386                 randconfig-a002-20210522
i386                 randconfig-a004-20210522
i386                 randconfig-a003-20210522
i386                 randconfig-a006-20210522
x86_64               randconfig-a013-20210523
x86_64               randconfig-a014-20210523
x86_64               randconfig-a012-20210523
x86_64               randconfig-a016-20210523
x86_64               randconfig-a015-20210523
x86_64               randconfig-a011-20210523
i386                 randconfig-a016-20210523
i386                 randconfig-a011-20210523
i386                 randconfig-a015-20210523
i386                 randconfig-a012-20210523
i386                 randconfig-a014-20210523
i386                 randconfig-a013-20210523
i386                 randconfig-a016-20210522
i386                 randconfig-a011-20210522
i386                 randconfig-a015-20210522
i386                 randconfig-a012-20210522
i386                 randconfig-a014-20210522
i386                 randconfig-a013-20210522
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
x86_64               randconfig-b001-20210522
x86_64               randconfig-b001-20210523
x86_64               randconfig-a006-20210523
x86_64               randconfig-a001-20210523
x86_64               randconfig-a005-20210523
x86_64               randconfig-a003-20210523
x86_64               randconfig-a004-20210523
x86_64               randconfig-a002-20210523
x86_64               randconfig-a013-20210522
x86_64               randconfig-a014-20210522
x86_64               randconfig-a012-20210522
x86_64               randconfig-a016-20210522
x86_64               randconfig-a015-20210522
x86_64               randconfig-a011-20210522

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
