Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1676374481E
	for <lists+linux-arch@lfdr.de>; Sat,  1 Jul 2023 11:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjGAJFL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 Jul 2023 05:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGAJFK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Jul 2023 05:05:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B19BC
        for <linux-arch@vger.kernel.org>; Sat,  1 Jul 2023 02:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688202308; x=1719738308;
  h=date:from:to:cc:subject:message-id;
  bh=uVKrOKe2zxgPGEPsm0CFFjNKpKXidfPRkcX5P81FKVY=;
  b=UZ0k7RSkHrim9HgreqEs1m1FeGq8UOakurJ4YJPfi+Hc/iEHkBSJrB4j
   lIWmWwKw8uMTUmezIU9aVMlsC/mzJrL/fo4+8C0RwlXPC+dcI/eYOAIv9
   oL3gcJfhZT4JD39e+CB431qwa/XO/0kjDkIonNpiDmh8KSM8J0snNDNXG
   efTY1wAMgWfpf7R0an6CkNYWT2qx148L9ENhxqv3f4n8jO7xJthQhOjir
   n5+TTgAr28M7prmufRE0ElcqtW+xmUvRfLcC/9aLX+VRrmwnZ3N1+1scS
   i9tttUefZqil/E5sc2drUXhHxu3i4KWFVB/V83U/ussi0BQ2L6d9jsDG7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="448957297"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="448957297"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2023 02:05:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="808045706"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="808045706"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Jul 2023 02:05:06 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qFWXR-000Fva-2r;
        Sat, 01 Jul 2023 09:05:05 +0000
Date:   Sat, 01 Jul 2023 17:04:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 4dd595c34c4bb22c16a76206a18c13e4e194335d
Message-ID: <202307011724.D51SzNSO-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 4dd595c34c4bb22c16a76206a18c13e4e194335d  syscalls: Remove file path comments from headers

elapsed time: 721m

configs tested: 173
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230630   gcc  
alpha                randconfig-r012-20230630   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                  randconfig-r004-20230630   gcc  
arc                  randconfig-r043-20230629   gcc  
arc                  randconfig-r043-20230630   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                       multi_v4t_defconfig   gcc  
arm                        mvebu_v5_defconfig   clang
arm                        mvebu_v7_defconfig   gcc  
arm                          pxa168_defconfig   clang
arm                          pxa3xx_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                  randconfig-r033-20230701   clang
arm                  randconfig-r046-20230629   gcc  
arm                  randconfig-r046-20230630   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230630   clang
arm64                randconfig-r025-20230629   clang
arm64                randconfig-r031-20230629   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r032-20230701   gcc  
csky                 randconfig-r034-20230701   gcc  
hexagon              randconfig-r041-20230629   clang
hexagon              randconfig-r041-20230630   clang
hexagon              randconfig-r045-20230629   clang
hexagon              randconfig-r045-20230630   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230629   gcc  
i386         buildonly-randconfig-r004-20230630   gcc  
i386         buildonly-randconfig-r005-20230629   gcc  
i386         buildonly-randconfig-r005-20230630   gcc  
i386         buildonly-randconfig-r006-20230629   gcc  
i386         buildonly-randconfig-r006-20230630   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230629   gcc  
i386                 randconfig-i002-20230629   gcc  
i386                 randconfig-i003-20230629   gcc  
i386                 randconfig-i004-20230629   gcc  
i386                 randconfig-i005-20230629   gcc  
i386                 randconfig-i006-20230629   gcc  
i386                 randconfig-i011-20230629   clang
i386                 randconfig-i012-20230629   clang
i386                 randconfig-i013-20230629   clang
i386                 randconfig-i014-20230629   clang
i386                 randconfig-i015-20230629   clang
i386                 randconfig-i016-20230629   clang
i386                 randconfig-r011-20230630   clang
i386                 randconfig-r023-20230629   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                 randconfig-r013-20230630   gcc  
m68k                 randconfig-r014-20230630   gcc  
m68k                 randconfig-r022-20230629   gcc  
microblaze           randconfig-r012-20230630   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                      maltaaprp_defconfig   clang
mips                 randconfig-r002-20230630   clang
mips                 randconfig-r021-20230629   gcc  
mips                       rbtx49xx_defconfig   clang
mips                           xway_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230630   gcc  
nios2                randconfig-r015-20230630   gcc  
nios2                randconfig-r024-20230629   gcc  
nios2                randconfig-r031-20230701   gcc  
nios2                randconfig-r032-20230629   gcc  
nios2                randconfig-r035-20230629   gcc  
openrisc                         alldefconfig   gcc  
openrisc             randconfig-r001-20230630   gcc  
openrisc             randconfig-r006-20230630   gcc  
openrisc             randconfig-r034-20230629   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r035-20230701   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    amigaone_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                   motionpro_defconfig   gcc  
powerpc                     tqm8560_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_virt_defconfig   clang
riscv                randconfig-r003-20230630   gcc  
riscv                randconfig-r042-20230629   clang
riscv                randconfig-r042-20230630   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230630   gcc  
s390                 randconfig-r044-20230629   clang
s390                 randconfig-r044-20230630   clang
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                   randconfig-r025-20230629   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230630   gcc  
sparc                randconfig-r016-20230630   gcc  
sparc                randconfig-r022-20230629   gcc  
sparc64              randconfig-r023-20230629   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r014-20230630   gcc  
um                   randconfig-r036-20230701   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230629   gcc  
x86_64       buildonly-randconfig-r001-20230630   gcc  
x86_64       buildonly-randconfig-r002-20230629   gcc  
x86_64       buildonly-randconfig-r002-20230630   gcc  
x86_64       buildonly-randconfig-r003-20230629   gcc  
x86_64       buildonly-randconfig-r003-20230630   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r005-20230630   gcc  
x86_64               randconfig-r015-20230630   clang
x86_64               randconfig-r026-20230629   clang
x86_64               randconfig-r033-20230629   gcc  
x86_64               randconfig-x001-20230629   clang
x86_64               randconfig-x002-20230629   clang
x86_64               randconfig-x003-20230629   clang
x86_64               randconfig-x004-20230629   clang
x86_64               randconfig-x005-20230629   clang
x86_64               randconfig-x006-20230629   clang
x86_64               randconfig-x011-20230629   gcc  
x86_64               randconfig-x011-20230701   gcc  
x86_64               randconfig-x012-20230629   gcc  
x86_64               randconfig-x012-20230701   gcc  
x86_64               randconfig-x013-20230629   gcc  
x86_64               randconfig-x013-20230701   gcc  
x86_64               randconfig-x014-20230629   gcc  
x86_64               randconfig-x014-20230701   gcc  
x86_64               randconfig-x015-20230629   gcc  
x86_64               randconfig-x015-20230701   gcc  
x86_64               randconfig-x016-20230629   gcc  
x86_64               randconfig-x016-20230701   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
