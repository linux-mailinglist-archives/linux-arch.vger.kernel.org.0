Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335B839B637
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 11:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhFDJuI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 05:50:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:52504 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhFDJuH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 05:50:07 -0400
IronPort-SDR: t8Gt32XplM9HcoYX6bjQN6/ErVWfuvSfVhI60xlqMAoX/t1iHSI1T2ey7QWx7msWQrl/00PSrl
 iHyhSpPKcWCQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="202402869"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="202402869"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 02:48:21 -0700
IronPort-SDR: R01AHKyydtIJwFw0BXlkiLrcalqPXWgv+IlWrervUupRWS+0f5oqFV0Eb6YTkprcDW6JjEz3vF
 Bbo89+juAfyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="480581615"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 04 Jun 2021 02:48:19 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lp6R9-0006sR-6U; Fri, 04 Jun 2021 09:48:19 +0000
Date:   Fri, 04 Jun 2021 17:47:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [asm-generic:clkdev] BUILD REGRESSION
 84587cb0f9ed09b9b7f787276ef05beda4ae0ba8
Message-ID: <60b9f6c6.Z5GOqXPOycOtaRKG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git clkdev
branch HEAD: 84587cb0f9ed09b9b7f787276ef05beda4ae0ba8  clkdev: remove unused clkdev_alloc() interfaces

Error/Warning in current branch:

arch/m68k/coldfire/m525x.c:29:30: error: 'pll' undeclared here (not in a function)

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- m68k-randconfig-r013-20210603
    `-- arch-m68k-coldfire-m525x.c:error:pll-undeclared-here-(not-in-a-function)

elapsed time: 2787m

configs tested: 333
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       omap2plus_defconfig
m68k                          amiga_defconfig
riscv                             allnoconfig
riscv                               defconfig
arm                           sunxi_defconfig
arm                         socfpga_defconfig
arm                            qcom_defconfig
sh                          sdk7786_defconfig
mips                       rbtx49xx_defconfig
parisc                           allyesconfig
mips                        vocore2_defconfig
mips                           ip27_defconfig
powerpc                      pasemi_defconfig
m68k                       m5249evb_defconfig
arm                         lpc32xx_defconfig
arm                            zeus_defconfig
powerpc                       ebony_defconfig
arm                            xcep_defconfig
h8300                               defconfig
powerpc                 mpc834x_mds_defconfig
mips                        qi_lb60_defconfig
arm                      footbridge_defconfig
mips                  decstation_64_defconfig
mips                           ip22_defconfig
mips                      maltaaprp_defconfig
mips                     cu1830-neo_defconfig
powerpc                     pq2fads_defconfig
powerpc                      mgcoge_defconfig
arm                           spitz_defconfig
xtensa                              defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                      katmai_defconfig
powerpc                   currituck_defconfig
powerpc                    adder875_defconfig
m68k                         apollo_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                      arches_defconfig
powerpc                           allnoconfig
powerpc                    mvme5100_defconfig
arm                      pxa255-idp_defconfig
arm                         s3c2410_defconfig
microblaze                          defconfig
arc                     nsimosci_hs_defconfig
h8300                     edosk2674_defconfig
arm                             mxs_defconfig
parisc                generic-64bit_defconfig
arm                           h5000_defconfig
ia64                      gensparse_defconfig
arm                          pxa168_defconfig
mips                          rm200_defconfig
sh                            titan_defconfig
powerpc                     tqm8548_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                         apsh4a3a_defconfig
arc                         haps_hs_defconfig
arm                         mv78xx0_defconfig
sh                         ecovec24_defconfig
mips                        workpad_defconfig
arc                     haps_hs_smp_defconfig
arm                           sama5_defconfig
sh                            migor_defconfig
powerpc                     tqm8560_defconfig
sh                           se7722_defconfig
m68k                         amcore_defconfig
mips                    maltaup_xpa_defconfig
nds32                               defconfig
arm                        mini2440_defconfig
parisc                              defconfig
sh                               j2_defconfig
powerpc                 mpc837x_mds_defconfig
mips                       lemote2f_defconfig
arm                              alldefconfig
m68k                        m5407c3_defconfig
x86_64                           alldefconfig
powerpc                      pmac32_defconfig
sh                          lboxre2_defconfig
s390                       zfcpdump_defconfig
arm                         bcm2835_defconfig
mips                            ar7_defconfig
powerpc                  storcenter_defconfig
powerpc                     rainier_defconfig
m68k                       bvme6000_defconfig
sh                        sh7757lcr_defconfig
xtensa                           allyesconfig
xtensa                generic_kc705_defconfig
sh                          rsk7203_defconfig
powerpc                     ep8248e_defconfig
powerpc                     sequoia_defconfig
arm                         orion5x_defconfig
sh                          r7780mp_defconfig
arm                           h3600_defconfig
arm                            mps2_defconfig
arc                          axs103_defconfig
arm                         vf610m4_defconfig
arm                       multi_v4t_defconfig
arm                         lpc18xx_defconfig
riscv                            allyesconfig
arm                          exynos_defconfig
powerpc                     kilauea_defconfig
sh                               alldefconfig
powerpc                     sbc8548_defconfig
arm                       netwinder_defconfig
powerpc64                           defconfig
arc                           tb10x_defconfig
arm                             ezx_defconfig
sh                           se7343_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                   sb1250_swarm_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                        warp_defconfig
arm                        neponset_defconfig
arm                    vt8500_v6_v7_defconfig
mips                            gpr_defconfig
h8300                       h8s-sim_defconfig
sh                         microdev_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     tqm5200_defconfig
sh                             shx3_defconfig
arm                           viper_defconfig
nios2                         3c120_defconfig
powerpc                      pcm030_defconfig
powerpc                   lite5200b_defconfig
arm                           u8500_defconfig
um                                  defconfig
x86_64                            allnoconfig
arc                              alldefconfig
m68k                       m5475evb_defconfig
arm                          pcm027_defconfig
arm                         lubbock_defconfig
sh                        sh7785lcr_defconfig
sh                          kfr2r09_defconfig
arm                  colibri_pxa270_defconfig
mips                            e55_defconfig
m68k                       m5208evb_defconfig
sh                          r7785rp_defconfig
mips                       capcella_defconfig
mips                        nlm_xlp_defconfig
sh                           se7721_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                        cell_defconfig
mips                        bcm63xx_defconfig
nios2                               defconfig
mips                         db1xxx_defconfig
powerpc                     pseries_defconfig
arm                       imx_v4_v5_defconfig
i386                             alldefconfig
arm                     davinci_all_defconfig
sh                      rts7751r2d1_defconfig
sh                          urquell_defconfig
arc                            hsdk_defconfig
mips                       bmips_be_defconfig
powerpc                     mpc83xx_defconfig
sh                   secureedge5410_defconfig
csky                             alldefconfig
arm                           omap1_defconfig
mips                      loongson3_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                   sh7724_generic_defconfig
xtensa                    smp_lx200_defconfig
sh                            hp6xx_defconfig
powerpc                        icon_defconfig
arm                        vexpress_defconfig
mips                          rb532_defconfig
mips                           ci20_defconfig
sh                 kfr2r09-romimage_defconfig
arm                        realview_defconfig
arm                         nhk8815_defconfig
arm                         axm55xx_defconfig
sh                             espt_defconfig
sh                        dreamcast_defconfig
sparc                               defconfig
powerpc                         wii_defconfig
powerpc                    gamecube_defconfig
mips                      fuloong2e_defconfig
powerpc                      acadia_defconfig
powerpc                         ps3_defconfig
sh                           se7206_defconfig
powerpc                 linkstation_defconfig
riscv             nommu_k210_sdcard_defconfig
sparc                       sparc32_defconfig
sh                     sh7710voipgw_defconfig
sh                        sh7763rdp_defconfig
mips                         tb0219_defconfig
m68k                        m5307c3_defconfig
arm                       spear13xx_defconfig
arc                          axs101_defconfig
powerpc                       maple_defconfig
sparc64                             defconfig
arm                           tegra_defconfig
sh                              ul2_defconfig
powerpc                          allmodconfig
mips                     loongson2k_defconfig
mips                      pistachio_defconfig
nios2                         10m50_defconfig
mips                         tb0226_defconfig
powerpc                  mpc885_ads_defconfig
arm                       aspeed_g4_defconfig
arm                        cerfcube_defconfig
sh                           sh2007_defconfig
xtensa                  cadence_csp_defconfig
arm                  colibri_pxa300_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                  cavium_octeon_defconfig
sh                         ap325rxa_defconfig
arm                          simpad_defconfig
mips                      malta_kvm_defconfig
arm                       versatile_defconfig
mips                          ath25_defconfig
arc                        vdk_hs38_defconfig
arm                            lart_defconfig
um                             i386_defconfig
um                            kunit_defconfig
riscv                            allmodconfig
powerpc                      ppc44x_defconfig
powerpc                     akebono_defconfig
powerpc                      chrp32_defconfig
mips                        nlm_xlr_defconfig
arm                       mainstone_defconfig
powerpc                     skiroot_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a002-20210602
x86_64               randconfig-a004-20210602
x86_64               randconfig-a003-20210602
x86_64               randconfig-a006-20210602
x86_64               randconfig-a005-20210602
x86_64               randconfig-a001-20210602
i386                 randconfig-a003-20210601
i386                 randconfig-a006-20210601
i386                 randconfig-a004-20210601
i386                 randconfig-a001-20210601
i386                 randconfig-a002-20210601
i386                 randconfig-a005-20210601
i386                 randconfig-a003-20210603
i386                 randconfig-a006-20210603
i386                 randconfig-a004-20210603
i386                 randconfig-a001-20210603
i386                 randconfig-a002-20210603
i386                 randconfig-a005-20210603
i386                 randconfig-a003-20210602
i386                 randconfig-a006-20210602
i386                 randconfig-a004-20210602
i386                 randconfig-a001-20210602
i386                 randconfig-a005-20210602
i386                 randconfig-a002-20210602
x86_64               randconfig-a015-20210603
x86_64               randconfig-a011-20210603
x86_64               randconfig-a012-20210603
x86_64               randconfig-a014-20210603
x86_64               randconfig-a016-20210603
x86_64               randconfig-a013-20210603
x86_64               randconfig-a015-20210601
x86_64               randconfig-a011-20210601
x86_64               randconfig-a012-20210601
x86_64               randconfig-a014-20210601
x86_64               randconfig-a016-20210601
x86_64               randconfig-a013-20210601
i386                 randconfig-a015-20210602
i386                 randconfig-a013-20210602
i386                 randconfig-a016-20210602
i386                 randconfig-a011-20210602
i386                 randconfig-a014-20210602
i386                 randconfig-a012-20210602
i386                 randconfig-a015-20210601
i386                 randconfig-a013-20210601
i386                 randconfig-a011-20210601
i386                 randconfig-a016-20210601
i386                 randconfig-a014-20210601
i386                 randconfig-a012-20210601
i386                 randconfig-a015-20210603
i386                 randconfig-a013-20210603
i386                 randconfig-a011-20210603
i386                 randconfig-a016-20210603
i386                 randconfig-a014-20210603
i386                 randconfig-a012-20210603
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210603
x86_64               randconfig-b001-20210601
x86_64               randconfig-b001-20210602
x86_64               randconfig-a002-20210603
x86_64               randconfig-a004-20210603
x86_64               randconfig-a003-20210603
x86_64               randconfig-a006-20210603
x86_64               randconfig-a005-20210603
x86_64               randconfig-a001-20210603
x86_64               randconfig-a002-20210601
x86_64               randconfig-a004-20210601
x86_64               randconfig-a003-20210601
x86_64               randconfig-a006-20210601
x86_64               randconfig-a005-20210601
x86_64               randconfig-a001-20210601
x86_64               randconfig-a015-20210602
x86_64               randconfig-a011-20210602
x86_64               randconfig-a012-20210602
x86_64               randconfig-a014-20210602
x86_64               randconfig-a016-20210602
x86_64               randconfig-a013-20210602

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
