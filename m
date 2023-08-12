Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAF8779E9E
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 11:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbjHLJhH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Aug 2023 05:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjHLJhH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Aug 2023 05:37:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B770DDA
        for <linux-arch@vger.kernel.org>; Sat, 12 Aug 2023 02:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691833030; x=1723369030;
  h=date:from:to:cc:subject:message-id;
  bh=n2pePCeGp5PxWhpENqZj9hoa6zev8kEWZ/Z1LULOZD8=;
  b=Mb+AJSmmmUkPKQa+j4EkJrEZb/+P52hGuZOZTrE2JfzDyVs+C2KYPnmP
   SEVJpUPFQYU/tZiAmqlYrVX/JD7oEVrAufMWB5+vwlGo2Gr4y+txwMxxq
   b1ao6m8kMIo1TIrJuJCBB3VoYaZyrbXgOaw3Qp1U4EO9i7BgaSlurhqDO
   7B6aqoLCA5ZhK/SSqELPT0sgy4/UrA/NjMRVFePJyP3gU5+wZij5CsRF4
   eaUBi/TJ1VjQPCOi9/SC5FjETLFJN+MFSlX39qtxydSVlLaCImi/mUiHx
   z0iNfpYJCnp/a0BPqOe7BLYU3IWvPPJqbFVCvkolkfvVzJzyB6M9JD8y2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="375526253"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="375526253"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2023 02:37:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="1063538281"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="1063538281"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 12 Aug 2023 02:37:09 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUl3U-0008S2-1Q;
        Sat, 12 Aug 2023 09:37:08 +0000
Date:   Sat, 12 Aug 2023 17:36:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 cdea694d7616727c2028ddac4d05ce4454d2e1db
Message-ID: <202308121741.aqk9wSeI-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: cdea694d7616727c2028ddac4d05ce4454d2e1db  asm-generic: partially revert "Unify uapi bitsperlong.h for arm64, riscv and loongarch"

elapsed time: 726m

configs tested: 151
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r031-20230812   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r013-20230812   gcc  
arc                  randconfig-r026-20230812   gcc  
arc                  randconfig-r034-20230812   gcc  
arc                  randconfig-r043-20230812   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                  randconfig-r006-20230812   clang
arm                  randconfig-r021-20230812   gcc  
arm                  randconfig-r046-20230812   gcc  
arm                         socfpga_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r031-20230812   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230812   gcc  
csky                 randconfig-r005-20230812   gcc  
csky                 randconfig-r014-20230812   gcc  
csky                 randconfig-r032-20230812   gcc  
csky                 randconfig-r033-20230812   gcc  
hexagon                             defconfig   clang
hexagon              randconfig-r022-20230812   clang
hexagon              randconfig-r041-20230812   clang
hexagon              randconfig-r045-20230812   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230812   gcc  
i386         buildonly-randconfig-r005-20230812   gcc  
i386         buildonly-randconfig-r006-20230812   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230812   gcc  
i386                 randconfig-i002-20230812   gcc  
i386                 randconfig-i003-20230812   gcc  
i386                 randconfig-i004-20230812   gcc  
i386                 randconfig-i005-20230812   gcc  
i386                 randconfig-i006-20230812   gcc  
i386                 randconfig-i011-20230812   clang
i386                 randconfig-i012-20230812   clang
i386                 randconfig-i013-20230812   clang
i386                 randconfig-i014-20230812   clang
i386                 randconfig-i015-20230812   clang
i386                 randconfig-i016-20230812   clang
i386                 randconfig-r014-20230812   clang
i386                 randconfig-r023-20230812   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230812   gcc  
loongarch            randconfig-r023-20230812   gcc  
loongarch            randconfig-r035-20230812   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r025-20230812   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r005-20230812   gcc  
microblaze           randconfig-r011-20230812   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     loongson1c_defconfig   clang
mips                         rt305x_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230812   gcc  
openrisc             randconfig-r004-20230812   gcc  
openrisc             randconfig-r021-20230812   gcc  
openrisc             randconfig-r024-20230812   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230812   gcc  
parisc               randconfig-r024-20230812   gcc  
parisc               randconfig-r026-20230812   gcc  
parisc               randconfig-r032-20230812   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc                  mpc885_ads_defconfig   gcc  
powerpc              randconfig-r036-20230812   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_virt_defconfig   clang
riscv                randconfig-r004-20230812   gcc  
riscv                randconfig-r015-20230812   clang
riscv                randconfig-r036-20230812   gcc  
riscv                randconfig-r042-20230812   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230812   gcc  
s390                 randconfig-r004-20230812   gcc  
s390                 randconfig-r035-20230812   gcc  
s390                 randconfig-r044-20230812   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r015-20230812   gcc  
sh                   randconfig-r025-20230812   gcc  
sh                   randconfig-r034-20230812   gcc  
sh                           se7619_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230812   gcc  
sparc                randconfig-r036-20230812   gcc  
sparc64              randconfig-r013-20230812   gcc  
sparc64              randconfig-r015-20230812   gcc  
sparc64              randconfig-r022-20230812   gcc  
sparc64              randconfig-r026-20230812   gcc  
sparc64              randconfig-r035-20230812   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r002-20230812   clang
um                   randconfig-r016-20230812   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230812   gcc  
x86_64       buildonly-randconfig-r002-20230812   gcc  
x86_64       buildonly-randconfig-r003-20230812   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r033-20230812   gcc  
x86_64               randconfig-x001-20230812   clang
x86_64               randconfig-x002-20230812   clang
x86_64               randconfig-x003-20230812   clang
x86_64               randconfig-x004-20230812   clang
x86_64               randconfig-x005-20230812   clang
x86_64               randconfig-x006-20230812   clang
x86_64               randconfig-x011-20230812   gcc  
x86_64               randconfig-x012-20230812   gcc  
x86_64               randconfig-x013-20230812   gcc  
x86_64               randconfig-x014-20230812   gcc  
x86_64               randconfig-x015-20230812   gcc  
x86_64               randconfig-x016-20230812   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r005-20230812   gcc  
xtensa               randconfig-r016-20230812   gcc  
xtensa               randconfig-r034-20230812   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
