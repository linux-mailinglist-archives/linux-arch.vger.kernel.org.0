Return-Path: <linux-arch+bounces-5202-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4194C91C75D
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jun 2024 22:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDCB3288918
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jun 2024 20:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E44C50275;
	Fri, 28 Jun 2024 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHObmcUH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE382B645
	for <linux-arch@vger.kernel.org>; Fri, 28 Jun 2024 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719606862; cv=none; b=SunvxkY6TzAoCgI/FvKacfYWkYhbbswkeZowPU3B8hrIHxsgHhG/xP5ygSKCNlFqFWgs5ph4NTR/sYhhFKTGN2gzqfU2DmAeMkfUrRmh24frEDm5SMramTrwuKQc/383Vu+aTUQZZuow0POf8oa170/B5uWhut5MA1WhY5Bonq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719606862; c=relaxed/simple;
	bh=Px6Bpk7tZ4AlWbPDywIyoDPOO6PVUWzFSyreoyIgEcM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NTw8zcqnrd5/7hU6EMlWTyosa/xlm/Vw5sucifW0f97aS684HANlEAjJ+Aca73fRzdva5j4sPz/rTHsR4n4wiHEjqHMMAFNwxxPcw6NLF8c40EScQpDM3bRB7xSGbfIqh7JZfAw8dSYTlfre7zRAtPa5ivKnJhvgOcNcSAPct8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHObmcUH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719606861; x=1751142861;
  h=date:from:to:cc:subject:message-id;
  bh=Px6Bpk7tZ4AlWbPDywIyoDPOO6PVUWzFSyreoyIgEcM=;
  b=bHObmcUHHYjsKML+9B+cBSkLn4Ah6BB+bBzu/X4JzNzOqaMsI0cRg7bv
   8eMn/IcI2bannbUrbR5ub2oa5JgpYH2SPRhOPWmF6BrCMSWvLddsUt1Lp
   lenxog0yNtXFBW+rt8vC9X/U/9qTjX3s53YZ4wjeRPnuFWeV51+nLlI2U
   VkBx6KmFUAM1HMUSDpbFAFNMuXrxEYhX9pjQQfSUld0VaUbGSWAJL6ak1
   z6pAiHhtMGweCxUqEgDT9NwP6RsoA5OZRxBLVewLrEBj8ZBIUA+MQcnXi
   67vbBLw/ovLtYQdEK7GmxWgXhVGQpV+twfJg2VlABo7dlUac96Xv1q6rc
   A==;
X-CSE-ConnectionGUID: TI2ofQYfQ/qhkYq0gPr24Q==
X-CSE-MsgGUID: nk6DIrdpT+GhtJe2Uj+Tfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="19705820"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="19705820"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:34:20 -0700
X-CSE-ConnectionGUID: gu/5AHT3QmKudxsgT/F5JQ==
X-CSE-MsgGUID: sRqc0MkWSFmtvoFM65ZUfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="44962759"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 28 Jun 2024 13:34:18 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNIIS-000IRM-1X;
	Fri, 28 Jun 2024 20:34:16 +0000
Date: Sat, 29 Jun 2024 04:34:09 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-fixes-6.10] BUILD SUCCESS
 0fa8ab5f3533b307a7d0e438ab08ecd92725dad7
Message-ID: <202406290408.iRO4vTwb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git syscall-fixes-6.10
branch HEAD: 0fa8ab5f3533b307a7d0e438ab08ecd92725dad7  linux/syscalls.h: add missing __user annotations

elapsed time: 4649m

configs tested: 173
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240628   gcc-13.2.0
arc                   randconfig-002-20240628   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                     am200epdkit_defconfig   gcc-13.2.0
arm                         bcm2835_defconfig   gcc-13.2.0
arm                     davinci_all_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                        multi_v5_defconfig   gcc-13.2.0
arm                         mv78xx0_defconfig   gcc-13.2.0
arm                        mvebu_v7_defconfig   gcc-13.2.0
arm                           omap1_defconfig   gcc-13.2.0
arm                   randconfig-001-20240628   gcc-13.2.0
arm                   randconfig-002-20240628   gcc-13.2.0
arm                   randconfig-003-20240628   gcc-13.2.0
arm                   randconfig-004-20240628   gcc-13.2.0
arm                           tegra_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                            allyesconfig   clang-19
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240628   gcc-13.2.0
arm64                 randconfig-002-20240628   gcc-13.2.0
arm64                 randconfig-003-20240628   gcc-13.2.0
arm64                 randconfig-004-20240628   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240628   gcc-13.2.0
csky                  randconfig-002-20240628   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240628   gcc-10
i386         buildonly-randconfig-002-20240628   gcc-10
i386         buildonly-randconfig-003-20240628   gcc-10
i386         buildonly-randconfig-004-20240628   gcc-10
i386         buildonly-randconfig-005-20240628   gcc-10
i386         buildonly-randconfig-006-20240628   gcc-10
i386                                defconfig   clang-18
i386                  randconfig-001-20240628   gcc-10
i386                  randconfig-002-20240628   gcc-10
i386                  randconfig-003-20240628   gcc-10
i386                  randconfig-004-20240628   gcc-10
i386                  randconfig-005-20240628   gcc-10
i386                  randconfig-006-20240628   gcc-10
i386                  randconfig-011-20240628   gcc-10
i386                  randconfig-012-20240628   gcc-10
i386                  randconfig-013-20240628   gcc-10
i386                  randconfig-014-20240628   gcc-10
i386                  randconfig-015-20240628   gcc-10
i386                  randconfig-016-20240628   gcc-10
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240628   gcc-13.2.0
loongarch             randconfig-002-20240628   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                             allmodconfig   clang-19
mips                              allnoconfig   gcc-13.2.0
mips                             allyesconfig   clang-19
mips                          ath79_defconfig   gcc-13.2.0
mips                        qi_lb60_defconfig   gcc-13.2.0
nios2                            allmodconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                            allyesconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240628   gcc-13.2.0
nios2                 randconfig-002-20240628   gcc-13.2.0
openrisc                         allmodconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240628   gcc-13.2.0
parisc                randconfig-002-20240628   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   gcc-13.2.0
powerpc                    amigaone_defconfig   gcc-13.2.0
powerpc                    klondike_defconfig   gcc-13.2.0
powerpc                    mvme5100_defconfig   gcc-13.2.0
powerpc                      ppc44x_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240628   gcc-13.2.0
powerpc               randconfig-002-20240628   gcc-13.2.0
powerpc               randconfig-003-20240628   gcc-13.2.0
powerpc64             randconfig-001-20240628   gcc-13.2.0
powerpc64             randconfig-002-20240628   gcc-13.2.0
powerpc64             randconfig-003-20240628   gcc-13.2.0
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240628   gcc-13.2.0
riscv                 randconfig-002-20240628   gcc-13.2.0
s390                              allnoconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240628   gcc-13.2.0
s390                  randconfig-002-20240628   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                          lboxre2_defconfig   gcc-13.2.0
sh                    randconfig-001-20240628   gcc-13.2.0
sh                    randconfig-002-20240628   gcc-13.2.0
sh                          rsk7264_defconfig   gcc-13.2.0
sh                        sh7785lcr_defconfig   gcc-13.2.0
sparc                            allyesconfig   gcc-13.2.0
sparc64                          allmodconfig   gcc-13.2.0
sparc64                          allyesconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240628   gcc-13.2.0
sparc64               randconfig-002-20240628   gcc-13.2.0
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240628   gcc-13.2.0
um                    randconfig-002-20240628   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240628   gcc-13
x86_64       buildonly-randconfig-002-20240628   gcc-13
x86_64       buildonly-randconfig-003-20240628   gcc-13
x86_64       buildonly-randconfig-004-20240628   gcc-13
x86_64       buildonly-randconfig-005-20240628   gcc-13
x86_64       buildonly-randconfig-006-20240628   gcc-13
x86_64                              defconfig   clang-18
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240628   gcc-13
x86_64                randconfig-002-20240628   gcc-13
x86_64                randconfig-003-20240628   gcc-13
x86_64                randconfig-004-20240628   gcc-13
x86_64                randconfig-005-20240628   gcc-13
x86_64                randconfig-006-20240628   gcc-13
x86_64                randconfig-011-20240628   gcc-13
x86_64                randconfig-012-20240628   gcc-13
x86_64                randconfig-013-20240628   gcc-13
x86_64                randconfig-014-20240628   gcc-13
x86_64                randconfig-015-20240628   gcc-13
x86_64                randconfig-016-20240628   gcc-13
x86_64                randconfig-071-20240628   gcc-13
x86_64                randconfig-072-20240628   gcc-13
x86_64                randconfig-073-20240628   gcc-13
x86_64                randconfig-074-20240628   gcc-13
x86_64                randconfig-075-20240628   gcc-13
x86_64                randconfig-076-20240628   gcc-13
x86_64                          rhel-8.3-func   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                           allyesconfig   gcc-13.2.0
xtensa                randconfig-001-20240628   gcc-13.2.0
xtensa                randconfig-002-20240628   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

