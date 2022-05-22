Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C1C530150
	for <lists+linux-arch@lfdr.de>; Sun, 22 May 2022 08:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240013AbiEVGnQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 22 May 2022 02:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239864AbiEVGnO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 May 2022 02:43:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE0320BC1
        for <linux-arch@vger.kernel.org>; Sat, 21 May 2022 23:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653201793; x=1684737793;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2scu1rOqAMHvg9i7QjLApRpQ94Qlpi7IWwleq1+So1M=;
  b=LjiU8X7SOMeA4Js22pR/l67zU/L1RaH35uyrTVw7P3HpzY1XCXVyJFyH
   cllrlkJ4WOqOcUjjqLEw4M1eXcJ/YdFESBMY1Oeg1OrGAgo8WAXujEpj2
   pwKKUaNQyvkGai1IY1XGHu/d25NzgY2H2AD2XnJKQjXSIGbxW/Zlzn/sy
   +iyXLhjJNiLm86mntqhj8W+Tfj5rfcVNGi3/WnHLAQXLRLixmZw44SUEX
   tg0JlVUF9ZajB0a0DNGjXGaRYx+VVM0UyMgwWbvP93avKq90+5uCPoSZV
   eYRyWMWPGWlCYPC5FZqVn4LTqpD9H1zXq8ZNT7RbbPq/mnmJS+EVMVQhT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="260546090"
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="260546090"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 23:43:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="607669239"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 May 2022 23:43:11 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsfJ1-00005o-0X;
        Sun, 22 May 2022 06:43:11 +0000
Date:   Sun, 22 May 2022 14:43:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 b2441b3bdce6c02cb96278d98c620d7ba1d41b7b
Message-ID: <6289db77.mxgRwxeRDbMxfE65%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: b2441b3bdce6c02cb96278d98c620d7ba1d41b7b  h8300: remove stale bindings and symlink

elapsed time: 2019m

configs tested: 133
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm64                            allyesconfig
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm                           imxrt_defconfig
arm                       imx_v6_v7_defconfig
parisc                           alldefconfig
arm                        cerfcube_defconfig
mips                         db1xxx_defconfig
sh                          rsk7269_defconfig
powerpc                     pq2fads_defconfig
parisc                           allyesconfig
mips                         bigsur_defconfig
mips                       bmips_be_defconfig
ia64                          tiger_defconfig
mips                  decstation_64_defconfig
sh                           se7750_defconfig
arm                            zeus_defconfig
powerpc                         wii_defconfig
mips                        bcm47xx_defconfig
powerpc                     taishan_defconfig
arm                            qcom_defconfig
arm                        realview_defconfig
powerpc                     sequoia_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                   motionpro_defconfig
arc                          axs103_defconfig
arm                      jornada720_defconfig
arm                           viper_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                            q40_defconfig
powerpc                        warp_defconfig
arc                          axs101_defconfig
alpha                               defconfig
m68k                       m5208evb_defconfig
arc                         haps_hs_defconfig
powerpc                      mgcoge_defconfig
mips                     loongson1b_defconfig
m68k                           sun3_defconfig
ia64                      gensparse_defconfig
arm                           sama5_defconfig
m68k                          amiga_defconfig
sh                         microdev_defconfig
powerpc                      ppc6xx_defconfig
ia64                                defconfig
ia64                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a015
x86_64                        randconfig-a011
x86_64                        randconfig-a013
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220519
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                          ep93xx_defconfig
powerpc                          g5_defconfig
powerpc                    socrates_defconfig
i386                             allyesconfig
powerpc                     mpc5200_defconfig
mips                           rs90_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                   lite5200b_defconfig
powerpc                 mpc8560_ads_defconfig
mips                      pic32mzda_defconfig
powerpc                          allmodconfig
arm                         bcm2835_defconfig
arm                           omap1_defconfig
powerpc                   bluestone_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
s390                 randconfig-r044-20220519
hexagon              randconfig-r041-20220519
hexagon              randconfig-r045-20220519
riscv                randconfig-r042-20220519

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
