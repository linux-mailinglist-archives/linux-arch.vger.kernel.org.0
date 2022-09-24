Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B04A5E8D25
	for <lists+linux-arch@lfdr.de>; Sat, 24 Sep 2022 15:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiIXNgl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Sep 2022 09:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiIXNgk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Sep 2022 09:36:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C794DF3A1
        for <linux-arch@vger.kernel.org>; Sat, 24 Sep 2022 06:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664026597; x=1695562597;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JBdsmV6CR+IyZMma/9syOLdnONxaNo7CkfmTAh9S5i8=;
  b=MVWTIAfPV8Q2t5Q68Y+cFjaSQl/LRZf05MfEc0HAMuY/4knfJzKLEHCi
   e1enfmK0DYueuMR2CjuS5jhD1BU43Wu1MEg2buNZCYrCe5wpT6HE31J6d
   8yT8FmnzjDNR7byytrEfmVFkoWh73AmRYzwHn4pl1ppz/cdc5quiafR/D
   yTAB8/AElTkFMcdkCIHvd8jNr4yWrBFvCj+ztK6NflacGC4dgQ8JQyzpN
   YJzdk7hkUsXKCdNAiQAMaxp7rs1JntE2WUfJ2ExdO7f2aFp8lSlz8tu1a
   s4NDgR66VBpsWtsK0Rs2UHY5e5J376iyE1IAr+fEE5UDFL0sA3edSG3gt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10480"; a="302234723"
X-IronPort-AV: E=Sophos;i="5.93,342,1654585200"; 
   d="scan'208";a="302234723"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2022 06:36:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,342,1654585200"; 
   d="scan'208";a="571694554"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Sep 2022 06:36:33 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oc5Kb-0006YK-0y;
        Sat, 24 Sep 2022 13:36:33 +0000
Date:   Sat, 24 Sep 2022 21:36:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 28a679ea60d0d16c3556f687bb2040559e92e932
Message-ID: <632f07da.3Dfi2ujx2XQz4FYb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LONGWORDS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 28a679ea60d0d16c3556f687bb2040559e92e932  parisc: Drop homebrewn io[read|write]64_[lo_hi|hi_lo]

elapsed time: 976m

configs tested: 123
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
arc                  randconfig-r043-20220923
s390                 randconfig-r044-20220923
riscv                randconfig-r042-20220923
s390                             allmodconfig
s390                                defconfig
x86_64                          rhel-8.3-func
powerpc                           allnoconfig
x86_64                    rhel-8.3-kselftests
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
s390                             allyesconfig
m68k                             allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
i386                                defconfig
x86_64                        randconfig-a013
x86_64                           allyesconfig
i386                          randconfig-a001
arm                                 defconfig
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a015
arm64                            allyesconfig
i386                             allyesconfig
arm                              allyesconfig
i386                          randconfig-a016
i386                          randconfig-a012
i386                          randconfig-a014
ia64                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
sh                        edosk7760_defconfig
sh                        sh7785lcr_defconfig
sparc                       sparc32_defconfig
mips                         bigsur_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                          randconfig-c001
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
sh                  sh7785lcr_32bit_defconfig
sh                         ap325rxa_defconfig
nios2                         10m50_defconfig
sh                          sdk7780_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
xtensa                              defconfig
powerpc                     tqm8555_defconfig
arc                      axs103_smp_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220924
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
arm64                               defconfig
ia64                             allyesconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                  randconfig-c002-20220923

clang tested configs:
hexagon              randconfig-r041-20220923
hexagon              randconfig-r045-20220923
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
arm                        multi_v5_defconfig
mips                        bcm63xx_defconfig
arm                       aspeed_g4_defconfig
powerpc                      obs600_defconfig
x86_64                        randconfig-k001
arm                           sama7_defconfig
powerpc                    gamecube_defconfig
arm                         s3c2410_defconfig
mips                          rm200_defconfig
arm                          sp7021_defconfig
x86_64                        randconfig-c007
arm                  randconfig-c002-20220923
i386                          randconfig-c001
s390                 randconfig-c005-20220923
riscv                randconfig-c006-20220923
mips                 randconfig-c004-20220923
powerpc              randconfig-c003-20220923

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
