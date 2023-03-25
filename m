Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BB26C91A7
	for <lists+linux-arch@lfdr.de>; Sun, 26 Mar 2023 00:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjCYXE0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Mar 2023 19:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCYXEZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Mar 2023 19:04:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ED7B2
        for <linux-arch@vger.kernel.org>; Sat, 25 Mar 2023 16:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679785464; x=1711321464;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KTJ+FpXmAq1b7aDAniEs/95Q8QEaQhl+hiryozzLxL4=;
  b=Bt8nbCY1KTOoQk9ExZCzylEi5T0JgcPC6xcJRdaMUC/M12FR57mWGYPQ
   oPSJjLRRVTuqGqYLNkIsIOEWgkVvIaOpDqJde9GiheipyAPlpMZhoe0BF
   +wDozqZHL423weQJedsUZHtzAlwD7Y295s3uu8ohPA03EeNVTpkR340y6
   0Tww9NMoKmsNKjrMWZ0ZtyTcEJ1EnOzbn8qyB3WGNIsuNWXKo5jDinx6p
   ZOop0ETUv8Kj2FESz39Y3wQ+fQk+aYqEPgXLDXwiBcGy1jV+M2cvbQIXd
   gNfJ5f5MiUDw2YJcF9lSW5vSJCNGFx1xVPd42syBCKlicq+VptSuEgB7e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="342420702"
X-IronPort-AV: E=Sophos;i="5.98,291,1673942400"; 
   d="scan'208";a="342420702"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 16:04:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="685572677"
X-IronPort-AV: E=Sophos;i="5.98,291,1673942400"; 
   d="scan'208";a="685572677"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 25 Mar 2023 16:04:22 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pgCvt-000Giz-24;
        Sat, 25 Mar 2023 23:04:21 +0000
Date:   Sun, 26 Mar 2023 07:04:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:dma-sync-rework] BUILD REGRESSION
 854b3f802e18f13161b3227759d12eb36930152e
Message-ID: <641f7de3.ZBsuUQC3gAIuy7Gy%lkp@intel.com>
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
branch HEAD: 854b3f802e18f13161b3227759d12eb36930152e  dma-mapping: replace custom code with generic implementation

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202303242303.IAFZ31Wv-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/hexagon/kernel/dma.c:19:27: error: use of undeclared identifier 'paddr'
arch/hexagon/kernel/dma.c:24:2: error: call to undeclared function 'hexagon_flush_dcache_range'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

Error/Warning ids grouped by kconfigs:

clang_recent_errors
|-- hexagon-randconfig-r006-20230322
|   |-- arch-hexagon-kernel-dma.c:error:call-to-undeclared-function-hexagon_flush_dcache_range-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- arch-hexagon-kernel-dma.c:error:use-of-undeclared-identifier-paddr
|-- hexagon-randconfig-r013-20230322
|   |-- arch-hexagon-kernel-dma.c:error:call-to-undeclared-function-hexagon_flush_dcache_range-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- arch-hexagon-kernel-dma.c:error:use-of-undeclared-identifier-paddr
|-- hexagon-randconfig-r041-20230322
|   |-- arch-hexagon-kernel-dma.c:error:call-to-undeclared-function-hexagon_flush_dcache_range-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- arch-hexagon-kernel-dma.c:error:use-of-undeclared-identifier-paddr
`-- hexagon-randconfig-r045-20230322
    |-- arch-hexagon-kernel-dma.c:error:call-to-undeclared-function-hexagon_flush_dcache_range-ISO-C99-and-later-do-not-support-implicit-function-declarations
    `-- arch-hexagon-kernel-dma.c:error:use-of-undeclared-identifier-paddr

elapsed time: 726m

configs tested: 95
configs skipped: 11

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230322   gcc  
arc                  randconfig-r043-20230322   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230322   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230322   clang
arm64        buildonly-randconfig-r006-20230322   clang
arm64                               defconfig   gcc  
arm64                randconfig-r022-20230325   clang
csky                                defconfig   gcc  
hexagon              randconfig-r006-20230322   clang
hexagon              randconfig-r013-20230322   clang
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
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r031-20230322   gcc  
ia64                 randconfig-r032-20230322   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r004-20230322   gcc  
loongarch    buildonly-randconfig-r005-20230322   gcc  
loongarch                           defconfig   gcc  
m68k         buildonly-randconfig-r001-20230322   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r034-20230322   gcc  
openrisc             randconfig-r001-20230322   gcc  
openrisc             randconfig-r004-20230322   gcc  
openrisc             randconfig-r012-20230322   gcc  
openrisc             randconfig-r016-20230322   gcc  
openrisc             randconfig-r033-20230322   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230322   gcc  
powerpc              randconfig-r025-20230325   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r024-20230325   clang
riscv                randconfig-r042-20230322   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r011-20230322   gcc  
s390                 randconfig-r044-20230322   gcc  
sh                   randconfig-r014-20230322   gcc  
sh                   randconfig-r036-20230322   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r035-20230322   gcc  
sparc64              randconfig-r023-20230325   gcc  
sparc64              randconfig-r026-20230325   gcc  
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
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r002-20230322   gcc  
xtensa               randconfig-r021-20230325   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
