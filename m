Return-Path: <linux-arch+bounces-11173-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3FEA740B0
	for <lists+linux-arch@lfdr.de>; Thu, 27 Mar 2025 23:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89CD4189EFA9
	for <lists+linux-arch@lfdr.de>; Thu, 27 Mar 2025 22:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167421DC996;
	Thu, 27 Mar 2025 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnoSbwpX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533028366
	for <linux-arch@vger.kernel.org>; Thu, 27 Mar 2025 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743113934; cv=none; b=FiioSSKHHUs2hAJwW+EUvckbpS1m/JAuLKeGZZg/87yTNkB1HTEoMPWt01zpjrEaDKKf0mfg9lfo7Xtci2QKGalc5LLli5P1aSna6oGxl6fUMGjQnyjmZl58Uh4+4vl1sDW2lHgW4Ms1ElSAfI9tslZxPBcTG/oPJrL8LHfoU2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743113934; c=relaxed/simple;
	bh=1bZqGWkAPNyrHBigej+vxJzZ/iQ8rAPmp7c7YW4rk9c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=p9XS2MyHEyUNzK9/bYgJiUwtiwPvwwushdj2HWXpwTx8rJeEEgQC56p34gNB1AfAxe8rhGwoLY68QJKwD3WFGrPC6+kM89Nt0+gAV1NSCtEZAUFoSi4lFZhGiEag98636ubo/XUdIRYCnTdas5Y6+jCWPDaAe5VbD0fO5qkgeHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnoSbwpX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743113931; x=1774649931;
  h=date:from:to:cc:subject:message-id;
  bh=1bZqGWkAPNyrHBigej+vxJzZ/iQ8rAPmp7c7YW4rk9c=;
  b=dnoSbwpXbnPq4aeVFg/K5RvjOCf5PzfkuFOP8B2V/Boqq19Yhu/RPxx2
   kVAWtOhsL0u7JzW+kGjCPP+aKVqLJDObvtogiaR+2K0fkgYmBJc64xhvW
   hZcM35jJ4WJz+Xo4i04DzL4lCT7JGh0woIQEQqzA9ySQOHRljjWHk/Yxq
   cmUevlJoLUF5MWkamwWbQ0ci80Y63aQgBub/Ku9naLAsbAKt1Bgh1/xhi
   zXD2ef1dwSGc7KJgdCwgpR5CGnT0SgNB355fAo2ycx9EBthPWhVMMTwjU
   7lVoWaV89C6tCG9QnliZzvZGbXeZ828SzfWlxwzEwn2uTXGSDf1+Nxa2L
   g==;
X-CSE-ConnectionGUID: Q2oHD3F+RmyYU3DEYPzKIg==
X-CSE-MsgGUID: Tz3H6rwvS3Sv6GkJnL4gAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="69832151"
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="69832151"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 15:18:51 -0700
X-CSE-ConnectionGUID: qWUrvjQyQQqq18bdo5sZBQ==
X-CSE-MsgGUID: bmdHhW0NScaRx/RMjr9v/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="162511026"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 27 Mar 2025 15:18:49 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txvYk-0006z5-2K;
	Thu, 27 Mar 2025 22:18:46 +0000
Date: Fri, 28 Mar 2025 06:18:09 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 47a60391ae0ed04ffbb9bd8dcd94ad9d08b41288
Message-ID: <202503280600.H0mWorDS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 47a60391ae0ed04ffbb9bd8dcd94ad9d08b41288  rwonce: fix crash by removing READ_ONCE() for unaligned read

elapsed time: 1443m

configs tested: 203
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250327    gcc-14.2.0
arc                   randconfig-002-20250327    gcc-14.2.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    clang-18
arm                                 defconfig    gcc-14.2.0
arm                       imx_v6_v7_defconfig    gcc-14.2.0
arm                         mv78xx0_defconfig    clang-19
arm                        neponset_defconfig    gcc-14.2.0
arm                   randconfig-001-20250327    clang-21
arm                   randconfig-002-20250327    gcc-5.5.0
arm                   randconfig-003-20250327    clang-21
arm                   randconfig-004-20250327    clang-16
arm                           spitz_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250327    gcc-5.5.0
arm64                 randconfig-002-20250327    clang-21
arm64                 randconfig-003-20250327    clang-21
arm64                 randconfig-004-20250327    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250327    gcc-9.3.0
csky                  randconfig-002-20250327    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250327    clang-21
hexagon               randconfig-002-20250327    clang-21
i386                             alldefconfig    gcc-12
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250327    clang-20
i386        buildonly-randconfig-002-20250327    gcc-12
i386        buildonly-randconfig-003-20250327    clang-20
i386        buildonly-randconfig-004-20250327    clang-20
i386        buildonly-randconfig-005-20250327    clang-20
i386        buildonly-randconfig-006-20250327    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250327    clang-20
i386                  randconfig-002-20250327    clang-20
i386                  randconfig-003-20250327    clang-20
i386                  randconfig-004-20250327    clang-20
i386                  randconfig-005-20250327    clang-20
i386                  randconfig-006-20250327    clang-20
i386                  randconfig-007-20250327    clang-20
i386                  randconfig-011-20250327    gcc-12
i386                  randconfig-012-20250327    gcc-12
i386                  randconfig-013-20250327    gcc-12
i386                  randconfig-014-20250327    gcc-12
i386                  randconfig-015-20250327    gcc-12
i386                  randconfig-016-20250327    gcc-12
i386                  randconfig-017-20250327    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250327    gcc-14.2.0
loongarch             randconfig-002-20250327    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
m68k                        mvme147_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250327    gcc-11.5.0
nios2                 randconfig-002-20250327    gcc-13.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250327    gcc-14.2.0
parisc                randconfig-002-20250327    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                 canyonlands_defconfig    clang-21
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                     kmeter1_defconfig    gcc-14.2.0
powerpc                 mpc837x_rdb_defconfig    gcc-14.2.0
powerpc                      pasemi_defconfig    clang-21
powerpc               randconfig-001-20250327    gcc-7.5.0
powerpc               randconfig-002-20250327    gcc-9.3.0
powerpc               randconfig-003-20250327    gcc-5.5.0
powerpc                        warp_defconfig    gcc-14.2.0
powerpc64                        alldefconfig    clang-21
powerpc64             randconfig-001-20250327    gcc-9.3.0
powerpc64             randconfig-002-20250327    clang-21
powerpc64             randconfig-003-20250327    clang-16
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250327    clang-21
riscv                 randconfig-002-20250327    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                          debug_defconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                                defconfig    gcc-14.2.0
s390                  randconfig-001-20250327    gcc-6.5.0
s390                  randconfig-002-20250327    clang-16
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250327    gcc-5.5.0
sh                    randconfig-002-20250327    gcc-9.3.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250327    gcc-12.4.0
sparc                 randconfig-002-20250327    gcc-10.3.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250327    gcc-6.5.0
sparc64               randconfig-002-20250327    gcc-6.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250327    clang-19
um                    randconfig-002-20250327    gcc-12
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250327    gcc-12
x86_64      buildonly-randconfig-002-20250327    gcc-12
x86_64      buildonly-randconfig-003-20250327    clang-20
x86_64      buildonly-randconfig-004-20250327    clang-20
x86_64      buildonly-randconfig-005-20250327    gcc-12
x86_64      buildonly-randconfig-006-20250327    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250327    gcc-12
x86_64                randconfig-002-20250327    gcc-12
x86_64                randconfig-003-20250327    gcc-12
x86_64                randconfig-004-20250327    gcc-12
x86_64                randconfig-005-20250327    gcc-12
x86_64                randconfig-006-20250327    gcc-12
x86_64                randconfig-007-20250327    gcc-12
x86_64                randconfig-008-20250327    gcc-12
x86_64                randconfig-071-20250327    gcc-12
x86_64                randconfig-072-20250327    gcc-12
x86_64                randconfig-073-20250327    gcc-12
x86_64                randconfig-074-20250327    gcc-12
x86_64                randconfig-075-20250327    gcc-12
x86_64                randconfig-076-20250327    gcc-12
x86_64                randconfig-077-20250327    gcc-12
x86_64                randconfig-078-20250327    gcc-12
x86_64                               rhel-9.4    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250327    gcc-14.2.0
xtensa                randconfig-002-20250327    gcc-6.5.0
xtensa                    smp_lx200_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

