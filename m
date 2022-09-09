Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37995B317B
	for <lists+linux-arch@lfdr.de>; Fri,  9 Sep 2022 10:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiIIIPI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Sep 2022 04:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiIIIPH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Sep 2022 04:15:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A7F4D17C
        for <linux-arch@vger.kernel.org>; Fri,  9 Sep 2022 01:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662711306; x=1694247306;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7znJHFfzfeHCGCHwrEPT0wBA84S3Ob5OXshlqkQ19is=;
  b=WALFYYyQzrmx1LsYqSQmtvsftDPrvY4UDlkxoIXOOlhJKxDX1DJqEgj1
   hJ9a/3HpZDdWIEVaL0nXJcUlPMf3SmUmcqv7pJF+IodjzuVoHJaSOh796
   weAlMLaBChkBUdPbugGYajqphgTFwLKI5/cIaYwXnY7aKSKlJP49erXyR
   Sau2UjR1SECeXWcBJVLlLC//5exVssQXN+/ZGxxJ3UU7IdXhB1kVy9F/o
   +VSMq3AvMXRmcBN2cQnideW6LqsFu5y/qhiBpEH0cKA+czHjLZlaFliY3
   5oKG4dG2swif/f0xJIGZveyd6lOpEWTuyF1MnCUdp5PMH7MrgknxVrjqR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="323630527"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="323630527"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 01:15:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="566287951"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 09 Sep 2022 01:15:00 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWZAB-0000uE-35;
        Fri, 09 Sep 2022 08:14:59 +0000
Date:   Fri, 09 Sep 2022 16:14:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 e1127d3ee3ee2742a50af7a107a671b4b5e57c3e
Message-ID: <631af5fc.z4tqE+J3MSO5B9TE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: e1127d3ee3ee2742a50af7a107a671b4b5e57c3e  asm-generic: Remove empty #ifdef SA_RESTORER

elapsed time: 1003m

configs tested: 138
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                          allmodconfig
um                             i386_defconfig
mips                             allyesconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
m68k                             allmodconfig
alpha                            allyesconfig
sh                               allmodconfig
arc                              allyesconfig
m68k                             allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                           rhel-8.3-syz
x86_64                               rhel-8.3
arm                                 defconfig
i386                             allyesconfig
i386                          randconfig-a016
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
s390                 randconfig-r044-20220908
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
arc                  randconfig-r043-20220908
i386                          randconfig-a001
riscv                randconfig-r042-20220908
i386                          randconfig-a003
i386                          randconfig-a014
i386                          randconfig-a005
arm                              allyesconfig
arc                  randconfig-r043-20220907
i386                          randconfig-a012
arm64                            allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-c001
arm                             pxa_defconfig
arc                              alldefconfig
arm                           u8500_defconfig
powerpc                      mgcoge_defconfig
m68k                                defconfig
arm                            hisi_defconfig
xtensa                    smp_lx200_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
m68k                          atari_defconfig
m68k                       m5475evb_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     tqm8548_defconfig
mips                     decstation_defconfig
powerpc                     stx_gp3_defconfig
sh                          sdk7780_defconfig
mips                            ar7_defconfig
mips                         rt305x_defconfig
arc                      axs103_smp_defconfig
openrisc                    or1ksim_defconfig
sh                             shx3_defconfig
xtensa                              defconfig
mips                    maltaup_xpa_defconfig
mips                  maltasmvp_eva_defconfig
sh                        edosk7705_defconfig
powerpc                      ppc40x_defconfig
mips                      loongson3_defconfig
sh                         apsh4a3a_defconfig
parisc                           alldefconfig
sh                            migor_defconfig
openrisc                            defconfig
arc                    vdk_hs38_smp_defconfig
sh                         microdev_defconfig
mips                           xway_defconfig
sh                     magicpanelr2_defconfig
sparc64                          alldefconfig
arm                         nhk8815_defconfig
m68k                          multi_defconfig
nios2                            allyesconfig
sh                             espt_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-c001
arm                  randconfig-c002-20220908
arm                      footbridge_defconfig
arm                        realview_defconfig
m68k                       m5275evb_defconfig
parisc                           allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
ia64                             allmodconfig

clang tested configs:
s390                 randconfig-r044-20220907
i386                          randconfig-a013
i386                          randconfig-a002
hexagon              randconfig-r041-20220907
hexagon              randconfig-r041-20220908
riscv                randconfig-r042-20220907
i386                          randconfig-a011
hexagon              randconfig-r045-20220908
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a015
hexagon              randconfig-r045-20220907
i386                          randconfig-a006
x86_64                        randconfig-k001
powerpc                        fsp2_defconfig
powerpc                 mpc8272_ads_defconfig
mips                        qi_lb60_defconfig
arm                          pcm027_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
mips                           mtx1_defconfig
mips                          ath79_defconfig
powerpc                     ppa8548_defconfig
mips                           ip22_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
