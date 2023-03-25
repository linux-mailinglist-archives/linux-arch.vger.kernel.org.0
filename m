Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E484A6C8BF4
	for <lists+linux-arch@lfdr.de>; Sat, 25 Mar 2023 08:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjCYHAz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Mar 2023 03:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjCYHAy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Mar 2023 03:00:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819D87AB3
        for <linux-arch@vger.kernel.org>; Sat, 25 Mar 2023 00:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679727653; x=1711263653;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=j/AOJrR4qRzt6ZBHIRvjj6JlSUWeTmYtl4yHBrAbD0E=;
  b=R2KYr+PEftgVbH/Tqbmdf48uY4C5A2hx+T9grLVbkTDMKEW/2c14D+sG
   Sy/Mpz453fj+efTKcGzrEn7lwrbiyn+9PuWAXgLlk7lEQsUL5xwrNbDr3
   w7W1vdto92oWxyhXsh2gqgQkMHMSezwDkyB+UyLL3beeBb43unMqnmI14
   d7p19wYAIa9xUOrWdG6fke8KyAwsZPVvYFuVMXxvcOF4gfQUnNKn9CXX2
   SzENfNwir2WgO6IWFfY+7blm77bT+2Jrww4MZehDrbqtPCVes9WM7jatT
   RMe+7Sk0qbVXvDksvVJNz4mXWIUgUCjKiy8pIlcLjY46JmU367FP5eSGo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="426207020"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="426207020"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 00:00:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="747426853"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="747426853"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 25 Mar 2023 00:00:52 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfxtT-000G2i-1I;
        Sat, 25 Mar 2023 07:00:51 +0000
Date:   Sat, 25 Mar 2023 15:00:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:dma-sync-rework] BUILD REGRESSION
 985cd64f3b17b82468e68c6269e09a5556d3720e
Message-ID: <641e9c17.8pAck7GEbzfeAq1P%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git dma-sync-rework
branch HEAD: 985cd64f3b17b82468e68c6269e09a5556d3720e  dma-mapping: replace custom code with generic implementation

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202303242303.IAFZ31Wv-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303251037.tsdm8i6z-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303251132.We6NFavu-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/hexagon/kernel/dma.c:19:27: error: use of undeclared identifier 'paddr'
arch/hexagon/kernel/dma.c:24:2: error: call to undeclared function 'hexagon_flush_dcache_range'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
arch/parisc/include/asm/vdso.h:10:10: fatal error: generated/vdso32-offsets.h: No such file or directory
include/linux/dma-sync.h:24:6: warning: no previous prototype for 'arch_sync_dma_for_device' [-Wmissing-prototypes]
include/linux/dma-sync.h:86:6: warning: no previous prototype for 'arch_sync_dma_for_cpu' [-Wmissing-prototypes]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- nios2-buildonly-randconfig-r005-20230322
|   |-- include-linux-dma-sync.h:warning:no-previous-prototype-for-arch_sync_dma_for_cpu
|   `-- include-linux-dma-sync.h:warning:no-previous-prototype-for-arch_sync_dma_for_device
|-- nios2-defconfig
|   |-- include-linux-dma-sync.h:warning:no-previous-prototype-for-arch_sync_dma_for_cpu
|   `-- include-linux-dma-sync.h:warning:no-previous-prototype-for-arch_sync_dma_for_device
`-- parisc-generic-64bit_defconfig
    `-- arch-parisc-include-asm-vdso.h:fatal-error:generated-vdso32-offsets.h:No-such-file-or-directory
clang_recent_errors
|-- hexagon-randconfig-r025-20230322
|   |-- arch-hexagon-kernel-dma.c:error:call-to-undeclared-function-hexagon_flush_dcache_range-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- arch-hexagon-kernel-dma.c:error:use-of-undeclared-identifier-paddr
|-- hexagon-randconfig-r041-20230322
|   |-- arch-hexagon-kernel-dma.c:error:call-to-undeclared-function-hexagon_flush_dcache_range-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- arch-hexagon-kernel-dma.c:error:use-of-undeclared-identifier-paddr
`-- hexagon-randconfig-r045-20230322
    |-- arch-hexagon-kernel-dma.c:error:call-to-undeclared-function-hexagon_flush_dcache_range-ISO-C99-and-later-do-not-support-implicit-function-declarations
    `-- arch-hexagon-kernel-dma.c:error:use-of-undeclared-identifier-paddr

elapsed time: 732m

configs tested: 137
configs skipped: 12

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230322   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230323   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                  randconfig-r002-20230322   gcc  
arc                  randconfig-r043-20230322   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm          buildonly-randconfig-r006-20230322   clang
arm                                 defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                  randconfig-r002-20230323   clang
arm                  randconfig-r014-20230322   clang
arm                  randconfig-r046-20230322   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230322   clang
arm64                randconfig-r025-20230322   gcc  
arm64                randconfig-r031-20230322   clang
csky                                defconfig   gcc  
csky                 randconfig-r023-20230322   gcc  
csky                 randconfig-r024-20230322   gcc  
csky                 randconfig-r026-20230322   gcc  
csky                 randconfig-r035-20230322   gcc  
hexagon              randconfig-r025-20230322   clang
hexagon              randconfig-r041-20230322   clang
hexagon              randconfig-r045-20230322   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230323   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r003-20230323   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230322   gcc  
loongarch            randconfig-r011-20230322   gcc  
loongarch            randconfig-r032-20230322   gcc  
loongarch            randconfig-r033-20230322   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230322   gcc  
m68k                 randconfig-r024-20230322   gcc  
m68k                 randconfig-r026-20230322   gcc  
microblaze   buildonly-randconfig-r004-20230322   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r003-20230322   gcc  
mips                 randconfig-r004-20230322   gcc  
mips                 randconfig-r005-20230322   gcc  
mips                 randconfig-r036-20230322   gcc  
nios2        buildonly-randconfig-r001-20230322   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r021-20230322   gcc  
nios2                randconfig-r036-20230322   gcc  
openrisc             randconfig-r004-20230323   gcc  
openrisc             randconfig-r006-20230323   gcc  
openrisc             randconfig-r013-20230322   gcc  
openrisc             randconfig-r023-20230322   gcc  
parisc       buildonly-randconfig-r001-20230323   gcc  
parisc       buildonly-randconfig-r006-20230323   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r014-20230322   gcc  
parisc               randconfig-r022-20230322   gcc  
parisc               randconfig-r034-20230322   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   lite5200b_defconfig   clang
powerpc                 mpc832x_mds_defconfig   clang
powerpc                 mpc837x_mds_defconfig   gcc  
powerpc              randconfig-c003-20230322   gcc  
powerpc              randconfig-r005-20230323   gcc  
powerpc              randconfig-r012-20230322   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r005-20230322   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                randconfig-r021-20230322   gcc  
riscv                randconfig-r042-20230322   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230322   clang
s390                 randconfig-r016-20230322   gcc  
s390                 randconfig-r022-20230322   gcc  
s390                 randconfig-r044-20230322   gcc  
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r024-20230322   gcc  
sparc64              randconfig-r031-20230322   gcc  
sparc64              randconfig-r034-20230322   gcc  
um                               alldefconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r022-20230322   gcc  
xtensa               randconfig-r032-20230322   gcc  
xtensa               randconfig-r035-20230322   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
