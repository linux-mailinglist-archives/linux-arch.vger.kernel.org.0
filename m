Return-Path: <linux-arch+bounces-1739-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B1483EDAF
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jan 2024 15:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256DB1F224EC
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jan 2024 14:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8850025779;
	Sat, 27 Jan 2024 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9o853BN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2479F2030B
	for <linux-arch@vger.kernel.org>; Sat, 27 Jan 2024 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706367086; cv=none; b=Qr0zv275o9oF+XirpnmTDBzqn/drbAox5f0H5EhOOVo35lwgL4dZIafgPm2eRYHTMmpL52UB0Jp0tUsqT981ZKVfxX6RttR3YRVNHrBrOtbH1I5/d3mv89UIbltl2A3aRONBQV4YSMrnNOLKYHwxtQhlqViiGzRz6CbA+r0OpPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706367086; c=relaxed/simple;
	bh=yNsPOnAs7f70gYnq5YrcX6ACYU1O3A1baiX2mxHJRLU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sLk1nvNl6u4Y787Qs1pFSTa+xpK36st8ubTLD5TgvE7axULh3sjn1n4EHvS3t/77cyBwoZwQgrjwto259ULG+gv4SufgTBE6oUwaiiEyLBHFxCVwt/XOrXZKWIF9uJiGGoMuvZoEwaOZhryBqlcMQDiXVQAgqCjVeL9Z449tppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9o853BN; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706367084; x=1737903084;
  h=date:from:to:cc:subject:message-id;
  bh=yNsPOnAs7f70gYnq5YrcX6ACYU1O3A1baiX2mxHJRLU=;
  b=g9o853BN3j2DhegsK0IdF3cSpVIqe91Anot8Cp0Z3SJCyIDOosavaQUz
   lzSjlUEVghCqJ23QAf9fD9JwR3LbrOlpiBe+1SGmOYk9qc+5pHwIiT/OH
   BgGKFD5ZLGI5T0veuhsLEYjiVUwC6izZB2Cu6arM/DW1M3isyYunH7U79
   8NfP5e9AWfyOLnJmoPVrqfxsumI63pcgMpsbgL/L1rrLKypQScrtFgrub
   OnrnzOMS0X2tFA2bUG9JnBogYibZ5ZRy62jNnsMJUP9WoLmXmmenpZYf1
   d1ZHUTL5AStJrzlbooFqbKlHCwhbl15QyD/nUNYDfOQz0XsSE6mBko1fN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="393116725"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="393116725"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 06:51:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="906611079"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="906611079"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jan 2024 06:51:21 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTk1f-0002Qf-23;
	Sat, 27 Jan 2024 14:51:19 +0000
Date: Sat, 27 Jan 2024 22:50:48 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 34b2321cc648a246d08cc51e423532eac690ccf1
Message-ID: <202401272244.Nzcp12uB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 34b2321cc648a246d08cc51e423532eac690ccf1  MAINTAINERS: Add Andreas Larsson as co-maintainer for arch/sparc

elapsed time: 1466m

configs tested: 149
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240127   gcc  
arc                   randconfig-002-20240127   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20240127   gcc  
arm                   randconfig-002-20240127   gcc  
arm                   randconfig-003-20240127   gcc  
arm                   randconfig-004-20240127   gcc  
arm                           stm32_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240127   gcc  
arm64                 randconfig-002-20240127   gcc  
arm64                 randconfig-003-20240127   gcc  
arm64                 randconfig-004-20240127   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240127   gcc  
csky                  randconfig-002-20240127   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                  randconfig-011-20240127   clang
i386                  randconfig-012-20240127   clang
i386                  randconfig-013-20240127   clang
i386                  randconfig-014-20240127   clang
i386                  randconfig-015-20240127   clang
i386                  randconfig-016-20240127   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240127   gcc  
loongarch             randconfig-002-20240127   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240127   gcc  
nios2                 randconfig-002-20240127   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240127   gcc  
parisc                randconfig-002-20240127   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   currituck_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc               randconfig-001-20240127   gcc  
powerpc               randconfig-002-20240127   gcc  
powerpc               randconfig-003-20240127   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc                     tqm8555_defconfig   gcc  
powerpc64             randconfig-001-20240127   gcc  
powerpc64             randconfig-002-20240127   gcc  
powerpc64             randconfig-003-20240127   gcc  
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240127   gcc  
riscv                 randconfig-002-20240127   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240127   gcc  
sh                    randconfig-002-20240127   gcc  
sh                          rsk7201_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240127   gcc  
sparc64               randconfig-002-20240127   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240127   gcc  
um                    randconfig-002-20240127   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240127   gcc  
x86_64       buildonly-randconfig-002-20240127   gcc  
x86_64       buildonly-randconfig-003-20240127   gcc  
x86_64       buildonly-randconfig-004-20240127   gcc  
x86_64       buildonly-randconfig-005-20240127   gcc  
x86_64       buildonly-randconfig-006-20240127   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20240127   gcc  
x86_64                randconfig-012-20240127   gcc  
x86_64                randconfig-013-20240127   gcc  
x86_64                randconfig-014-20240127   gcc  
x86_64                randconfig-015-20240127   gcc  
x86_64                randconfig-016-20240127   gcc  
x86_64                randconfig-071-20240127   gcc  
x86_64                randconfig-072-20240127   gcc  
x86_64                randconfig-073-20240127   gcc  
x86_64                randconfig-074-20240127   gcc  
x86_64                randconfig-075-20240127   gcc  
x86_64                randconfig-076-20240127   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240127   gcc  
xtensa                randconfig-002-20240127   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

