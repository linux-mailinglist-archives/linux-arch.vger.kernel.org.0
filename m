Return-Path: <linux-arch+bounces-619-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C855802873
	for <lists+linux-arch@lfdr.de>; Sun,  3 Dec 2023 23:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D79280CFC
	for <lists+linux-arch@lfdr.de>; Sun,  3 Dec 2023 22:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB8918035;
	Sun,  3 Dec 2023 22:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XPzy2BEs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FE9C8
	for <linux-arch@vger.kernel.org>; Sun,  3 Dec 2023 14:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701643099; x=1733179099;
  h=date:from:to:cc:subject:message-id;
  bh=bM+xSM5/AMBMyuE7Aw6iakV7unGiwKjTZfVWV01k6Lc=;
  b=XPzy2BEsTdmU2u/WMi0FeZAqN3vqGitlJzJV86JfciNlwvwqJ8hLA5G9
   +e63MP6gQ7dHctvrqYLe2+EsHlBkN5yPCfO077owJI46OTDlhTwr2bkE4
   dAnFKb/UvGFaRU+AzQg/Se3FqDh0gWq4QarMJtbR0USy6vXly2lBYLFZC
   y9/wJyW5+gpzadt6jATzaCcMkhla7BPcQ5CjBmZsgOJJFpmJ3eV93vxSs
   A246+OEe7AkuhBsmfEroBuWgEpYXo9bMSkv6tiQTrbaPr2ucbLPGkz8+B
   jbzfBpAe6f5V/29ymDIs5JdGgTE2o4VcJyk/RB7v64fGIToKsrQ8+XniQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="12380638"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="12380638"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 14:38:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="720127026"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="720127026"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Dec 2023 14:38:17 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r9v6N-0007Aw-1s;
	Sun, 03 Dec 2023 22:38:15 +0000
Date: Mon, 04 Dec 2023 06:38:12 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:mips-prototypes] BUILD SUCCESS
 3ba13f3f1f92410943161b5c13347847e79623e1
Message-ID: <202312040609.TMloyVp9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git mips-prototypes
branch HEAD: 3ba13f3f1f92410943161b5c13347847e79623e1  mips: kexec: include linux/reboot.h

elapsed time: 1449m

configs tested: 177
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
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231203   gcc  
arc                   randconfig-002-20231203   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                                 defconfig   clang
arm                       imx_v4_v5_defconfig   clang
arm                           omap1_defconfig   clang
arm                   randconfig-001-20231203   gcc  
arm                   randconfig-002-20231203   gcc  
arm                   randconfig-003-20231203   gcc  
arm                   randconfig-004-20231203   gcc  
arm                           sama7_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231203   gcc  
arm64                 randconfig-002-20231203   gcc  
arm64                 randconfig-003-20231203   gcc  
arm64                 randconfig-004-20231203   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231203   gcc  
csky                  randconfig-002-20231203   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231203   clang
hexagon               randconfig-002-20231203   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231203   gcc  
i386         buildonly-randconfig-002-20231203   gcc  
i386         buildonly-randconfig-003-20231203   gcc  
i386         buildonly-randconfig-004-20231203   gcc  
i386         buildonly-randconfig-005-20231203   gcc  
i386         buildonly-randconfig-006-20231203   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231203   gcc  
i386                  randconfig-002-20231203   gcc  
i386                  randconfig-003-20231203   gcc  
i386                  randconfig-004-20231203   gcc  
i386                  randconfig-005-20231203   gcc  
i386                  randconfig-006-20231203   gcc  
i386                  randconfig-011-20231203   clang
i386                  randconfig-012-20231203   clang
i386                  randconfig-013-20231203   clang
i386                  randconfig-014-20231203   clang
i386                  randconfig-015-20231203   clang
i386                  randconfig-016-20231203   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231203   gcc  
loongarch             randconfig-002-20231203   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   clang
mips                           rs90_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231203   gcc  
nios2                 randconfig-002-20231203   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20231203   gcc  
parisc                randconfig-002-20231203   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     asp8347_defconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                     ksi8560_defconfig   clang
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20231203   gcc  
powerpc               randconfig-002-20231203   gcc  
powerpc               randconfig-003-20231203   gcc  
powerpc64             randconfig-001-20231203   gcc  
powerpc64             randconfig-002-20231203   gcc  
powerpc64             randconfig-003-20231203   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231203   gcc  
riscv                 randconfig-002-20231203   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231203   clang
s390                  randconfig-002-20231203   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231203   gcc  
sh                    randconfig-002-20231203   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231203   gcc  
sparc64               randconfig-002-20231203   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231203   gcc  
um                    randconfig-002-20231203   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231203   gcc  
x86_64       buildonly-randconfig-002-20231203   gcc  
x86_64       buildonly-randconfig-003-20231203   gcc  
x86_64       buildonly-randconfig-004-20231203   gcc  
x86_64       buildonly-randconfig-005-20231203   gcc  
x86_64       buildonly-randconfig-006-20231203   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231203   clang
x86_64                randconfig-002-20231203   clang
x86_64                randconfig-003-20231203   clang
x86_64                randconfig-004-20231203   clang
x86_64                randconfig-005-20231203   clang
x86_64                randconfig-006-20231203   clang
x86_64                randconfig-011-20231203   gcc  
x86_64                randconfig-012-20231203   gcc  
x86_64                randconfig-013-20231203   gcc  
x86_64                randconfig-014-20231203   gcc  
x86_64                randconfig-015-20231203   gcc  
x86_64                randconfig-016-20231203   gcc  
x86_64                randconfig-071-20231203   gcc  
x86_64                randconfig-072-20231203   gcc  
x86_64                randconfig-073-20231203   gcc  
x86_64                randconfig-074-20231203   gcc  
x86_64                randconfig-075-20231203   gcc  
x86_64                randconfig-076-20231203   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20231203   gcc  
xtensa                randconfig-002-20231203   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

