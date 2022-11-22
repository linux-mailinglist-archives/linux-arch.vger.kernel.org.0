Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22196349D1
	for <lists+linux-arch@lfdr.de>; Tue, 22 Nov 2022 23:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiKVWKj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Nov 2022 17:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiKVWKi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2022 17:10:38 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F24EDFEB
        for <linux-arch@vger.kernel.org>; Tue, 22 Nov 2022 14:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669155037; x=1700691037;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mUyxvy1ot2g4BwUXvYHN6ASnq154jXxmhGNm/kw8Yo4=;
  b=NJ4VdmUXQfCVbRU0Mf/F7H9MZGb7+OIA9ehImn0/OxzN6Mo3I+Je5pWl
   61OLoC2x3lBJ/MgkMZ1M6uWO6RwrPA8ZuEx/fiAGHQbrbALZ7P8HkyhEf
   1C8Q9VZ/+s4ci0AWj5GvAMaZjhq712DeMpcFBAK9SmYjG0PejOVeOKrDB
   KavUUfA21DVEDX68a8QffsmROyoFYfZBfwjolTXhFnvB+pxbCjWGOfuNf
   XkLZHfKkN6iomgGugd3CiG5d9/22pK11uFkXqbo7QkSKzl8245aysUO0U
   qcS5kii5T/bl6BAaf5N4uN7wc58n9C8u7X9Pb6gf3tSDI15WOnP48eaqz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="301481049"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="301481049"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 14:10:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="674497961"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="674497961"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Nov 2022 14:10:35 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxbTO-0001v5-2Y;
        Tue, 22 Nov 2022 22:10:34 +0000
Date:   Wed, 23 Nov 2022 06:09:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 5e5ff73c2e5863f93fc5fd78d178cd8f2af12464
Message-ID: <637d489d.9jD4jql7BHMCxOCh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 5e5ff73c2e5863f93fc5fd78d178cd8f2af12464  asm-generic/io: Add _RET_IP_ to MMIO trace for more accurate debug info

elapsed time: 1444m

configs tested: 143
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                                defconfig
alpha                               defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
s390                             allmodconfig
s390                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
ia64                             allmodconfig
i386                 randconfig-a011-20221121
x86_64                            allnoconfig
i386                 randconfig-a013-20221121
i386                 randconfig-a012-20221121
i386                 randconfig-a014-20221121
i386                 randconfig-a015-20221121
i386                 randconfig-a016-20221121
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig
i386                                defconfig
mips                           jazz_defconfig
powerpc                      ep88xc_defconfig
m68k                       m5249evb_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                           sama5_defconfig
arm                                 defconfig
x86_64               randconfig-a011-20221121
x86_64               randconfig-a014-20221121
x86_64               randconfig-a012-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a016-20221121
x86_64               randconfig-a015-20221121
s390                 randconfig-r044-20221121
riscv                randconfig-r042-20221121
arc                  randconfig-r043-20221120
arc                  randconfig-r043-20221121
m68k                             allmodconfig
i386                          randconfig-c001
sparc                       sparc32_defconfig
powerpc                    sam440ep_defconfig
sparc                            alldefconfig
sh                           se7705_defconfig
m68k                        stmark2_defconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                 mpc8540_ads_defconfig
arm                      jornada720_defconfig
m68k                             allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                      footbridge_defconfig
powerpc                       eiger_defconfig
arm                              allyesconfig
loongarch                           defconfig
loongarch                         allnoconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arc                           tb10x_defconfig
mips                          rb532_defconfig
m68k                        m5272c3_defconfig
arm                         nhk8815_defconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
sparc                               defconfig
csky                                defconfig
x86_64                                  kexec
x86_64                        randconfig-c001
arm                  randconfig-c002-20221120
arm                        trizeps4_defconfig
m68k                       m5275evb_defconfig
arc                          axs103_defconfig
sh                              ul2_defconfig
sh                           se7780_defconfig
sh                          sdk7780_defconfig
arm                          simpad_defconfig
powerpc                  iss476-smp_defconfig
sh                             espt_defconfig
m68k                       m5208evb_defconfig
arm                          gemini_defconfig
arm                            pleb_defconfig
parisc                generic-64bit_defconfig
sh                     sh7710voipgw_defconfig
powerpc                      pcm030_defconfig
powerpc                mpc7448_hpc2_defconfig
arc                         haps_hs_defconfig
arc                      axs103_smp_defconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
powerpc                    mvme5100_defconfig
arm                         bcm2835_defconfig
arm                         lpc32xx_defconfig
i386                 randconfig-a001-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a006-20221121
i386                 randconfig-a004-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121
x86_64                        randconfig-k001
x86_64               randconfig-a002-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a006-20221121
x86_64               randconfig-a005-20221121
x86_64               randconfig-a003-20221121
powerpc                    gamecube_defconfig
powerpc                  mpc866_ads_defconfig
arm                        neponset_defconfig
powerpc                     ksi8560_defconfig
arm                     am200epdkit_defconfig
hexagon                             defconfig
arm                                 defconfig
s390                 randconfig-r044-20221120
hexagon              randconfig-r041-20221120
hexagon              randconfig-r041-20221121
riscv                randconfig-r042-20221120
hexagon              randconfig-r045-20221120
hexagon              randconfig-r045-20221121
powerpc                   bluestone_defconfig
arm                          moxart_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
