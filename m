Return-Path: <linux-arch+bounces-1324-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EE2829639
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jan 2024 10:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781291C2158D
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jan 2024 09:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC993E472;
	Wed, 10 Jan 2024 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RrZt9QZo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55AC3E47B
	for <linux-arch@vger.kernel.org>; Wed, 10 Jan 2024 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704878588; x=1736414588;
  h=date:from:to:cc:subject:message-id;
  bh=t/0j4TnSQ3XmZKzJ3F+Z/G4wPBxl7a2uf1sYBst8TGE=;
  b=RrZt9QZo5xDQIuy+x9m9BBddgTg69yZ8sS8jYwNg+Buq+V7rnh/HZvXu
   EhrCQluVZBhMx94qgKTIUqZAX1XGABBb6HIzXgTjZmmJp2CARK6IsJOh7
   3MZiwEza5PNvztb4iOcSRA7mseMWyZtQ7XNOoGUyAWUj+sUcDdJUF88wS
   ReQW7eCZw7yXttXUYqn03+SXraFieXN5eSME9iN78YG4hpq3H9Utt4/Co
   FLLb6/JzaMxuuIXbOQ0NL2rTsr5xa0Y7otNVDSHsMKmVLignDCsIxEV3S
   SOI1qZglFp+0sYaefFCBnRiItZe+rmledrksjHVNYzb6yeQv3tL+J05UN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5545554"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5545554"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 01:23:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="16575964"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 10 Jan 2024 01:23:05 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNUnf-0006od-1N;
	Wed, 10 Jan 2024 09:23:03 +0000
Date: Wed, 10 Jan 2024 17:01:42 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 e8cf41b96bc9c8a735ba30a38ea69cc2ef1b5cae
Message-ID: <202401101735.GpYGgz8l-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: e8cf41b96bc9c8a735ba30a38ea69cc2ef1b5cae  asm-generic: make sparse happy with odd-sized put_unaligned_*()

elapsed time: 1481m

configs tested: 207
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
arc                     haps_hs_smp_defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240109   gcc  
arc                   randconfig-001-20240110   gcc  
arc                   randconfig-002-20240109   gcc  
arc                   randconfig-002-20240110   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240109   gcc  
csky                  randconfig-001-20240110   gcc  
csky                  randconfig-002-20240109   gcc  
csky                  randconfig-002-20240110   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             alldefconfig   gcc  
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20240109   gcc  
i386                  randconfig-011-20240110   gcc  
i386                  randconfig-012-20240109   gcc  
i386                  randconfig-012-20240110   gcc  
i386                  randconfig-013-20240109   gcc  
i386                  randconfig-013-20240110   gcc  
i386                  randconfig-014-20240109   gcc  
i386                  randconfig-014-20240110   gcc  
i386                  randconfig-015-20240109   gcc  
i386                  randconfig-015-20240110   gcc  
i386                  randconfig-016-20240109   gcc  
i386                  randconfig-016-20240110   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240109   gcc  
loongarch             randconfig-001-20240110   gcc  
loongarch             randconfig-002-20240109   gcc  
loongarch             randconfig-002-20240110   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                          rb532_defconfig   gcc  
mips                       rbtx49xx_defconfig   gcc  
mips                        vocore2_defconfig   gcc  
mips                           xway_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240109   gcc  
nios2                 randconfig-001-20240110   gcc  
nios2                 randconfig-002-20240109   gcc  
nios2                 randconfig-002-20240110   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240109   gcc  
parisc                randconfig-001-20240110   gcc  
parisc                randconfig-002-20240109   gcc  
parisc                randconfig-002-20240110   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       holly_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc                     redwood_defconfig   gcc  
powerpc                     tqm8560_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240109   gcc  
s390                  randconfig-001-20240110   gcc  
s390                  randconfig-002-20240109   gcc  
s390                  randconfig-002-20240110   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240109   gcc  
sh                    randconfig-001-20240110   gcc  
sh                    randconfig-002-20240109   gcc  
sh                    randconfig-002-20240110   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240109   gcc  
sparc64               randconfig-001-20240110   gcc  
sparc64               randconfig-002-20240109   gcc  
sparc64               randconfig-002-20240110   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240109   clang
x86_64       buildonly-randconfig-001-20240110   clang
x86_64       buildonly-randconfig-002-20240109   clang
x86_64       buildonly-randconfig-002-20240110   clang
x86_64       buildonly-randconfig-003-20240109   clang
x86_64       buildonly-randconfig-003-20240110   clang
x86_64       buildonly-randconfig-004-20240109   clang
x86_64       buildonly-randconfig-004-20240110   clang
x86_64       buildonly-randconfig-005-20240109   clang
x86_64       buildonly-randconfig-005-20240110   clang
x86_64       buildonly-randconfig-006-20240109   clang
x86_64       buildonly-randconfig-006-20240110   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20240109   clang
x86_64                randconfig-011-20240110   clang
x86_64                randconfig-012-20240109   clang
x86_64                randconfig-012-20240110   clang
x86_64                randconfig-013-20240109   clang
x86_64                randconfig-013-20240110   clang
x86_64                randconfig-014-20240109   clang
x86_64                randconfig-014-20240110   clang
x86_64                randconfig-015-20240109   clang
x86_64                randconfig-015-20240110   clang
x86_64                randconfig-016-20240109   clang
x86_64                randconfig-016-20240110   clang
x86_64                randconfig-071-20240109   clang
x86_64                randconfig-071-20240110   clang
x86_64                randconfig-072-20240109   clang
x86_64                randconfig-072-20240110   clang
x86_64                randconfig-073-20240109   clang
x86_64                randconfig-073-20240110   clang
x86_64                randconfig-074-20240109   clang
x86_64                randconfig-074-20240110   clang
x86_64                randconfig-075-20240109   clang
x86_64                randconfig-075-20240110   clang
x86_64                randconfig-076-20240109   clang
x86_64                randconfig-076-20240110   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240109   gcc  
xtensa                randconfig-001-20240110   gcc  
xtensa                randconfig-002-20240109   gcc  
xtensa                randconfig-002-20240110   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

