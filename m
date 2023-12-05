Return-Path: <linux-arch+bounces-696-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B4C8057DB
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 15:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CDE1F216C0
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 14:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C2E65ED1;
	Tue,  5 Dec 2023 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwDll7OR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388B0CA
	for <linux-arch@vger.kernel.org>; Tue,  5 Dec 2023 06:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701787766; x=1733323766;
  h=date:from:to:cc:subject:message-id;
  bh=1LFNxcA+3W5YXlKeyLIOMxilcOFQsQPNgcQjxz3lOOY=;
  b=QwDll7ORY/7nCNRURewR+yqntWMPBRAYRW6xPA60iVFV7khv4YYYM2iI
   u3UN2oNUUw47NLFtRTlWlxwvxQ+Tjj5YZIlyU7MfFdJ9/a6eZez/8RP/S
   aoI8OyedlM8JOuCf2uXskUk4HOPDUOpRFqSdg/FmEfucF3kGdc2xOeEBE
   MECBrZJd/D8hT4iqQP/BYFFAxbjUBscxsm5MtIYNT3x9+ZozwTZYggHsA
   Hmcb6LEw1g/c3I2pf4xomwJLuCq5EoadSWCoXE4e2G/a+BK3uyXOhkvmc
   cGbppHgR5SAt8PQuaWiN3ViFktc8FdoN20eY4k5zT2dheLNcdDQWzrXnl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="966784"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="966784"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 06:49:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="770942106"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="770942106"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 05 Dec 2023 06:49:23 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAWjh-0009Cg-0A;
	Tue, 05 Dec 2023 14:49:21 +0000
Date: Tue, 05 Dec 2023 22:49:12 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 e183130c9a87cc57c73ecc9c251e10d07b658530
Message-ID: <202312052209.9PRXcoDY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: e183130c9a87cc57c73ecc9c251e10d07b658530  sparc: Use $(kecho) to announce kernel images being ready

elapsed time: 1457m

configs tested: 192
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                   randconfig-001-20231205   gcc  
arc                   randconfig-002-20231205   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   clang
arm                          exynos_defconfig   gcc  
arm                         mv78xx0_defconfig   clang
arm                        neponset_defconfig   clang
arm                           omap1_defconfig   clang
arm                         orion5x_defconfig   clang
arm                   randconfig-001-20231205   gcc  
arm                   randconfig-002-20231205   gcc  
arm                   randconfig-003-20231205   gcc  
arm                   randconfig-004-20231205   gcc  
arm                       spear13xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231205   gcc  
arm64                 randconfig-002-20231205   gcc  
arm64                 randconfig-003-20231205   gcc  
arm64                 randconfig-004-20231205   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231205   gcc  
csky                  randconfig-002-20231205   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231205   clang
hexagon               randconfig-002-20231205   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231205   gcc  
i386         buildonly-randconfig-002-20231205   gcc  
i386         buildonly-randconfig-003-20231205   gcc  
i386         buildonly-randconfig-004-20231205   gcc  
i386         buildonly-randconfig-005-20231205   gcc  
i386         buildonly-randconfig-006-20231205   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231205   gcc  
i386                  randconfig-002-20231205   gcc  
i386                  randconfig-003-20231205   gcc  
i386                  randconfig-004-20231205   gcc  
i386                  randconfig-005-20231205   gcc  
i386                  randconfig-006-20231205   gcc  
i386                  randconfig-011-20231205   clang
i386                  randconfig-012-20231205   clang
i386                  randconfig-013-20231205   clang
i386                  randconfig-014-20231205   clang
i386                  randconfig-015-20231205   clang
i386                  randconfig-016-20231205   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231205   gcc  
loongarch             randconfig-002-20231205   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                      malta_kvm_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231205   gcc  
nios2                 randconfig-002-20231205   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231205   gcc  
parisc                randconfig-002-20231205   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      cm5200_defconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                     kilauea_defconfig   clang
powerpc                     ksi8560_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc               randconfig-001-20231205   gcc  
powerpc               randconfig-002-20231205   gcc  
powerpc               randconfig-003-20231205   gcc  
powerpc                     redwood_defconfig   gcc  
powerpc                     tqm8548_defconfig   gcc  
powerpc                      tqm8xx_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20231205   gcc  
powerpc64             randconfig-002-20231205   gcc  
powerpc64             randconfig-003-20231205   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231205   gcc  
riscv                 randconfig-002-20231205   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231205   clang
s390                  randconfig-002-20231205   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231205   gcc  
sh                    randconfig-002-20231205   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231205   gcc  
sparc64               randconfig-002-20231205   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231205   gcc  
um                    randconfig-002-20231205   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231205   gcc  
x86_64       buildonly-randconfig-002-20231205   gcc  
x86_64       buildonly-randconfig-003-20231205   gcc  
x86_64       buildonly-randconfig-004-20231205   gcc  
x86_64       buildonly-randconfig-005-20231205   gcc  
x86_64       buildonly-randconfig-006-20231205   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231205   clang
x86_64                randconfig-002-20231205   clang
x86_64                randconfig-003-20231205   clang
x86_64                randconfig-004-20231205   clang
x86_64                randconfig-005-20231205   clang
x86_64                randconfig-006-20231205   clang
x86_64                randconfig-011-20231205   gcc  
x86_64                randconfig-012-20231205   gcc  
x86_64                randconfig-013-20231205   gcc  
x86_64                randconfig-014-20231205   gcc  
x86_64                randconfig-015-20231205   gcc  
x86_64                randconfig-016-20231205   gcc  
x86_64                randconfig-071-20231205   gcc  
x86_64                randconfig-072-20231205   gcc  
x86_64                randconfig-073-20231205   gcc  
x86_64                randconfig-074-20231205   gcc  
x86_64                randconfig-075-20231205   gcc  
x86_64                randconfig-076-20231205   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20231205   gcc  
xtensa                randconfig-002-20231205   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

