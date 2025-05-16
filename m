Return-Path: <linux-arch+bounces-11982-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E73FCABA569
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 23:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42EB11C01948
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 21:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C64280A50;
	Fri, 16 May 2025 21:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ze3mv1EH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8E128033C
	for <linux-arch@vger.kernel.org>; Fri, 16 May 2025 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747431512; cv=none; b=Nk2Ki3V9StKHEUHDCckhjLmiDIhppnOBDJFuepyZVYyaWzK+pCEHUmCfpWhiqhk1Gax0x52zGgvNPt1MSeExoe8gTvHFf110DrY2qXDZ2rbpb/bcgzEUTYRNrRY2p2N3kNVrYF9H0qq0VJ5oI2nVr+d+UyD+mPn9ceZXl5YEwU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747431512; c=relaxed/simple;
	bh=cPvSnIKRkdD7RRNYbtj2pvo/lMhO/PICeED/OitXhgY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sBwKmvgqvXIjDxW7dx6zZ9P96irLxVF6KNMlV8rpO5ZANTtLtcx300oiwtWwDXrlKoVpzlP1KOyNi1vtA9iYMcV5fZDff6+13C0ODvfKfFlWCf0yPcjcrDCElkMuKY8nOEEXyp6aaEoDKcwJjRJqQH1803btReq042UHUjCPNpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ze3mv1EH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747431511; x=1778967511;
  h=date:from:to:cc:subject:message-id;
  bh=cPvSnIKRkdD7RRNYbtj2pvo/lMhO/PICeED/OitXhgY=;
  b=Ze3mv1EHHpa+uU6zM9AuBfd27qPNaRAt+H8hkBu2woNsEsonEnX7aF9w
   L6Cn0cFb1wALz9yrvjRGMnRd/nivMxFe1g5644u3sU3DcBhoAP3E4mCsY
   kDycbo3QLK5t5rVRCQ4x7pc/Tc/BoFQXvjPczvtfcJk1GH/rveeKdcsAR
   namyZMvnKcBqh4K90UFDaTZEP6yCfIzqXoB0C/4rz9JooiWvvUwxj22fy
   VHNvuZedCQN+kj5yGOI5X/+M60BgvjTYOPZhSFmseELTSxJFzsvSlfy67
   Kk0cXUJYMRU8ib3glnjvZaw6BtSIZlWLx7IDb8wqgBQn6uowgwrfix4TM
   Q==;
X-CSE-ConnectionGUID: FSTT57qfS+2uwjUwhOhn5w==
X-CSE-MsgGUID: Hfa2IsTrSdCYnFXFAl3lrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49483398"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="49483398"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 14:38:30 -0700
X-CSE-ConnectionGUID: LgyvBzAXRqGV05ypiRBuYw==
X-CSE-MsgGUID: 1tZZWUnWTnaAEc5+OGFktw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="138544043"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 16 May 2025 14:38:29 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uG2l8-000JjD-1N;
	Fri, 16 May 2025 21:38:26 +0000
Date: Sat, 17 May 2025 05:37:45 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 28d51df0dbaad038a69af134b92314ce7c2196e2
Message-ID: <202505170535.w07RBV2i-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 28d51df0dbaad038a69af134b92314ce7c2196e2  Documentation: update binutils-2.30 version reference

elapsed time: 758m

configs tested: 264
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-14.2.0
arc                     haps_hs_smp_defconfig    clang-21
arc                 nsimosci_hs_smp_defconfig    clang-21
arc                   randconfig-001-20250516    gcc-13.3.0
arc                   randconfig-001-20250517    gcc-8.5.0
arc                   randconfig-002-20250516    gcc-13.3.0
arc                   randconfig-002-20250517    gcc-8.5.0
arm                              alldefconfig    gcc-14.2.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                         assabet_defconfig    clang-21
arm                                 defconfig    gcc-14.2.0
arm                          pxa910_defconfig    clang-21
arm                            qcom_defconfig    clang-21
arm                   randconfig-001-20250516    gcc-8.5.0
arm                   randconfig-001-20250517    gcc-8.5.0
arm                   randconfig-002-20250516    clang-21
arm                   randconfig-002-20250517    gcc-8.5.0
arm                   randconfig-003-20250516    clang-21
arm                   randconfig-003-20250517    gcc-8.5.0
arm                   randconfig-004-20250516    clang-21
arm                   randconfig-004-20250517    gcc-8.5.0
arm                        realview_defconfig    clang-21
arm                             rpc_defconfig    gcc-14.2.0
arm                           sama5_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                            allyesconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250516    gcc-9.5.0
arm64                 randconfig-001-20250517    gcc-8.5.0
arm64                 randconfig-002-20250516    gcc-9.5.0
arm64                 randconfig-002-20250517    gcc-8.5.0
arm64                 randconfig-003-20250516    gcc-8.5.0
arm64                 randconfig-003-20250517    gcc-8.5.0
arm64                 randconfig-004-20250516    gcc-9.5.0
arm64                 randconfig-004-20250517    gcc-8.5.0
csky                             allmodconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                             allyesconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250516    gcc-14.2.0
csky                  randconfig-001-20250517    clang-21
csky                  randconfig-002-20250516    gcc-14.2.0
csky                  randconfig-002-20250517    clang-21
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250516    clang-19
hexagon               randconfig-001-20250517    clang-21
hexagon               randconfig-002-20250516    clang-21
hexagon               randconfig-002-20250517    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250516    clang-20
i386        buildonly-randconfig-001-20250517    clang-20
i386        buildonly-randconfig-002-20250516    gcc-12
i386        buildonly-randconfig-002-20250517    clang-20
i386        buildonly-randconfig-003-20250516    clang-20
i386        buildonly-randconfig-003-20250517    clang-20
i386        buildonly-randconfig-004-20250516    clang-20
i386        buildonly-randconfig-004-20250517    clang-20
i386        buildonly-randconfig-005-20250516    clang-20
i386        buildonly-randconfig-005-20250517    clang-20
i386        buildonly-randconfig-006-20250516    gcc-12
i386        buildonly-randconfig-006-20250517    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250517    clang-20
i386                  randconfig-002-20250517    clang-20
i386                  randconfig-003-20250517    clang-20
i386                  randconfig-004-20250517    clang-20
i386                  randconfig-005-20250517    clang-20
i386                  randconfig-006-20250517    clang-20
i386                  randconfig-007-20250517    clang-20
i386                  randconfig-011-20250517    gcc-12
i386                  randconfig-012-20250517    gcc-12
i386                  randconfig-013-20250517    gcc-12
i386                  randconfig-014-20250517    gcc-12
i386                  randconfig-015-20250517    gcc-12
i386                  randconfig-016-20250517    gcc-12
i386                  randconfig-017-20250517    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                        allyesconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250516    gcc-14.2.0
loongarch             randconfig-001-20250517    clang-21
loongarch             randconfig-002-20250516    gcc-14.2.0
loongarch             randconfig-002-20250517    clang-21
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    clang-21
m68k                                defconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    clang-21
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    clang-21
mips                             allmodconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                             allyesconfig    gcc-14.2.0
mips                        maltaup_defconfig    gcc-14.2.0
mips                           mtx1_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250516    gcc-13.3.0
nios2                 randconfig-001-20250517    clang-21
nios2                 randconfig-002-20250516    gcc-13.3.0
nios2                 randconfig-002-20250517    clang-21
openrisc                         alldefconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250516    gcc-10.5.0
parisc                randconfig-001-20250517    clang-21
parisc                randconfig-002-20250516    gcc-12.4.0
parisc                randconfig-002-20250517    clang-21
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                          g5_defconfig    clang-21
powerpc                      pmac32_defconfig    clang-21
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250516    gcc-8.5.0
powerpc               randconfig-001-20250517    clang-21
powerpc               randconfig-002-20250516    gcc-8.5.0
powerpc               randconfig-002-20250517    clang-21
powerpc               randconfig-003-20250516    clang-17
powerpc               randconfig-003-20250517    clang-21
powerpc                     tqm8548_defconfig    clang-21
powerpc64             randconfig-001-20250516    clang-21
powerpc64             randconfig-001-20250517    clang-21
powerpc64             randconfig-002-20250516    clang-21
powerpc64             randconfig-002-20250517    clang-21
powerpc64             randconfig-003-20250516    clang-21
powerpc64             randconfig-003-20250517    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                               defconfig    gcc-14.2.0
riscv                 randconfig-001-20250516    gcc-8.5.0
riscv                 randconfig-001-20250517    gcc-9.3.0
riscv                 randconfig-002-20250516    gcc-8.5.0
riscv                 randconfig-002-20250517    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250516    gcc-8.5.0
s390                  randconfig-001-20250517    gcc-9.3.0
s390                  randconfig-002-20250516    gcc-8.5.0
s390                  randconfig-002-20250517    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                         ecovec24_defconfig    clang-21
sh                    randconfig-001-20250516    gcc-14.2.0
sh                    randconfig-001-20250517    gcc-9.3.0
sh                    randconfig-002-20250516    gcc-9.3.0
sh                    randconfig-002-20250517    gcc-9.3.0
sh                   sh7770_generic_defconfig    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250516    gcc-8.5.0
sparc                 randconfig-001-20250517    gcc-9.3.0
sparc                 randconfig-002-20250516    gcc-8.5.0
sparc                 randconfig-002-20250517    gcc-9.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250516    gcc-12.4.0
sparc64               randconfig-001-20250517    gcc-9.3.0
sparc64               randconfig-002-20250516    gcc-14.2.0
sparc64               randconfig-002-20250517    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250516    clang-21
um                    randconfig-001-20250517    gcc-9.3.0
um                    randconfig-002-20250516    gcc-12
um                    randconfig-002-20250517    gcc-9.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250516    clang-20
x86_64      buildonly-randconfig-001-20250517    clang-20
x86_64      buildonly-randconfig-002-20250516    gcc-12
x86_64      buildonly-randconfig-002-20250517    clang-20
x86_64      buildonly-randconfig-003-20250516    clang-20
x86_64      buildonly-randconfig-003-20250517    clang-20
x86_64      buildonly-randconfig-004-20250516    clang-20
x86_64      buildonly-randconfig-004-20250517    clang-20
x86_64      buildonly-randconfig-005-20250516    gcc-12
x86_64      buildonly-randconfig-005-20250517    clang-20
x86_64      buildonly-randconfig-006-20250516    gcc-12
x86_64      buildonly-randconfig-006-20250517    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250517    gcc-11
x86_64                randconfig-002-20250517    gcc-11
x86_64                randconfig-003-20250517    gcc-11
x86_64                randconfig-004-20250517    gcc-11
x86_64                randconfig-005-20250517    gcc-11
x86_64                randconfig-006-20250517    gcc-11
x86_64                randconfig-007-20250517    gcc-11
x86_64                randconfig-008-20250517    gcc-11
x86_64                randconfig-071-20250517    gcc-12
x86_64                randconfig-072-20250517    gcc-12
x86_64                randconfig-073-20250517    gcc-12
x86_64                randconfig-074-20250517    gcc-12
x86_64                randconfig-075-20250517    gcc-12
x86_64                randconfig-076-20250517    gcc-12
x86_64                randconfig-077-20250517    gcc-12
x86_64                randconfig-078-20250517    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250516    gcc-10.5.0
xtensa                randconfig-001-20250517    gcc-9.3.0
xtensa                randconfig-002-20250516    gcc-10.5.0
xtensa                randconfig-002-20250517    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

