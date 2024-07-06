Return-Path: <linux-arch+bounces-5288-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3790692925C
	for <lists+linux-arch@lfdr.de>; Sat,  6 Jul 2024 12:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577F01C20AC7
	for <lists+linux-arch@lfdr.de>; Sat,  6 Jul 2024 10:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4689A47781;
	Sat,  6 Jul 2024 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvXOQqLx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7473399F
	for <linux-arch@vger.kernel.org>; Sat,  6 Jul 2024 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720260103; cv=none; b=ZH6Uuh/4I+goSv5VACGY3iCyM7XFGi2o1ZntiFg+Lc79PiKCGvMAA2zVOOScdeWhaaQv/QNNEVMgaLonQcqy7A9qq8DnwqG9Lag+yswn2a0+JQLNJNdWn/cjrKTIS/qukadOaJJYMP63Y5jcBUhjbv+7DxS4ITP8jzMt9xNK4Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720260103; c=relaxed/simple;
	bh=LqXzd056gI8UoBgnpfpxDPZxosy3m8hkg+Q8faGwhRw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cYZu+vijrgy/B/k9tHHg/V74/IL+GwrdN0VJ3ybvjKZJE+lDg9mtvTCQxjj2w2CgSiD1tjLvFCWVzHCo9yrVtGQVhm0jFJsZqacMemMWx7ejU21/Gj1DZa+GFun95KllzrxHU5QyYHKz72R7vTm9uzuZKDMNlTBoJ2e5Dch9PAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvXOQqLx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720260100; x=1751796100;
  h=date:from:to:cc:subject:message-id;
  bh=LqXzd056gI8UoBgnpfpxDPZxosy3m8hkg+Q8faGwhRw=;
  b=PvXOQqLxpsUm7wXjtKoHqpAWUNDa4DJOXSnO7PKiAaxqbZMeAwi0cdV0
   a4hEPSPvyJECYXGtwyfOJWPmkhpQj/P2wYMmwGyM2eO3ZZmM+zlAMqWen
   uRUd68+hAPK900jBR1y3lCr7+n47anZ9qqEGoqPSqmcq4XfFqnpmT1Obk
   w+b3zSCUmmXqQ+8kVkZBacPKvAwMefeF61sQKQRVjXfboPBszdb3z4vJw
   B7g6aIjPQ7VooNfWRYKrN51XzNpL5UpGFyAoEEVug3FRB00u9U0sNbrhl
   rJGswUjWb7n6f5yZKhVfYL2c9Ovs7pHTToV6R4xrXvRMS6FBe1DeANcK1
   g==;
X-CSE-ConnectionGUID: yfleHd4yQgOLcWPoU4TDJA==
X-CSE-MsgGUID: wEBHN9sETKemR7Py+f+j5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28919715"
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="28919715"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 03:01:39 -0700
X-CSE-ConnectionGUID: EsjWiZ+iSzO5YJuN+bCw4w==
X-CSE-MsgGUID: qcZ1olIhQWSEhxkuStlwAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="47797893"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 06 Jul 2024 03:01:39 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQ2EZ-000Tan-1s;
	Sat, 06 Jul 2024 10:01:35 +0000
Date: Sat, 06 Jul 2024 18:01:20 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscalls-for-6.11] BUILD SUCCESS
 f564176f4e4f2507d36924300fbd5f6f0e00ff29
Message-ID: <202407061819.H44nCqvy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git syscalls-for-6.11
branch HEAD: f564176f4e4f2507d36924300fbd5f6f0e00ff29  riscv: convert to generic syscall table

elapsed time: 1300m

configs tested: 199
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                      axs103_smp_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240706   gcc-13.2.0
arc                   randconfig-002-20240706   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-13.2.0
arm                         bcm2835_defconfig   clang-19
arm                                 defconfig   clang-14
arm                            dove_defconfig   gcc-13.2.0
arm                       multi_v4t_defconfig   clang-19
arm                        mvebu_v7_defconfig   clang-15
arm                   randconfig-001-20240706   gcc-13.2.0
arm                   randconfig-002-20240706   gcc-13.2.0
arm                   randconfig-003-20240706   gcc-13.2.0
arm                   randconfig-004-20240706   gcc-13.2.0
arm                           tegra_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240706   gcc-13.2.0
arm64                 randconfig-002-20240706   gcc-13.2.0
arm64                 randconfig-003-20240706   clang-16
arm64                 randconfig-004-20240706   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240706   gcc-13.2.0
csky                  randconfig-002-20240706   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240706   clang-19
hexagon               randconfig-002-20240706   clang-15
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240705   gcc-13
i386         buildonly-randconfig-001-20240706   clang-18
i386         buildonly-randconfig-002-20240705   gcc-9
i386         buildonly-randconfig-002-20240706   gcc-13
i386         buildonly-randconfig-003-20240705   gcc-11
i386         buildonly-randconfig-003-20240706   clang-18
i386         buildonly-randconfig-004-20240705   clang-18
i386         buildonly-randconfig-004-20240706   gcc-13
i386         buildonly-randconfig-005-20240705   clang-18
i386         buildonly-randconfig-005-20240706   gcc-10
i386         buildonly-randconfig-006-20240705   clang-18
i386         buildonly-randconfig-006-20240706   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240705   gcc-13
i386                  randconfig-001-20240706   gcc-13
i386                  randconfig-002-20240705   clang-18
i386                  randconfig-002-20240706   clang-18
i386                  randconfig-003-20240705   gcc-11
i386                  randconfig-003-20240706   gcc-13
i386                  randconfig-004-20240705   gcc-13
i386                  randconfig-004-20240706   clang-18
i386                  randconfig-005-20240705   clang-18
i386                  randconfig-005-20240706   clang-18
i386                  randconfig-006-20240705   clang-18
i386                  randconfig-006-20240706   gcc-12
i386                  randconfig-011-20240705   gcc-13
i386                  randconfig-011-20240706   gcc-11
i386                  randconfig-012-20240705   gcc-13
i386                  randconfig-012-20240706   clang-18
i386                  randconfig-013-20240705   clang-18
i386                  randconfig-013-20240706   clang-18
i386                  randconfig-014-20240705   gcc-8
i386                  randconfig-014-20240706   clang-18
i386                  randconfig-015-20240705   gcc-10
i386                  randconfig-015-20240706   gcc-7
i386                  randconfig-016-20240705   clang-18
i386                  randconfig-016-20240706   gcc-13
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240706   gcc-13.2.0
loongarch             randconfig-002-20240706   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                  decstation_64_defconfig   gcc-13.2.0
mips                      fuloong2e_defconfig   gcc-13.2.0
mips                           jazz_defconfig   clang-19
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240706   gcc-13.2.0
nios2                 randconfig-002-20240706   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240706   gcc-13.2.0
parisc                randconfig-002-20240706   gcc-13.2.0
parisc64                         alldefconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc                     asp8347_defconfig   clang-17
powerpc                        fsp2_defconfig   gcc-13.2.0
powerpc                    ge_imp3a_defconfig   gcc-13.2.0
powerpc                     mpc512x_defconfig   clang-19
powerpc                    mvme5100_defconfig   gcc-13.2.0
powerpc                      pasemi_defconfig   clang-19
powerpc               randconfig-001-20240706   gcc-13.2.0
powerpc               randconfig-002-20240706   gcc-13.2.0
powerpc               randconfig-003-20240706   clang-19
powerpc64             randconfig-001-20240706   gcc-13.2.0
powerpc64             randconfig-002-20240706   gcc-13.2.0
powerpc64             randconfig-003-20240706   clang-19
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240706   gcc-13.2.0
riscv                 randconfig-002-20240706   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240706   gcc-13.2.0
s390                  randconfig-002-20240706   clang-19
sh                               alldefconfig   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                         ecovec24_defconfig   gcc-13.2.0
sh                     magicpanelr2_defconfig   gcc-13.2.0
sh                    randconfig-001-20240706   gcc-13.2.0
sh                    randconfig-002-20240706   gcc-13.2.0
sh                          rsk7264_defconfig   gcc-13.2.0
sh                           se7343_defconfig   gcc-13.2.0
sh                           se7751_defconfig   gcc-13.2.0
sh                           sh2007_defconfig   gcc-13.2.0
sh                     sh7710voipgw_defconfig   gcc-13.2.0
sh                        sh7785lcr_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240706   gcc-13.2.0
sparc64               randconfig-002-20240706   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240706   clang-19
um                    randconfig-002-20240706   gcc-13
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240706   clang-18
x86_64       buildonly-randconfig-002-20240706   clang-18
x86_64       buildonly-randconfig-003-20240706   clang-18
x86_64       buildonly-randconfig-004-20240706   clang-18
x86_64       buildonly-randconfig-005-20240706   gcc-13
x86_64       buildonly-randconfig-006-20240706   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240706   gcc-9
x86_64                randconfig-002-20240706   clang-18
x86_64                randconfig-003-20240706   clang-18
x86_64                randconfig-004-20240706   clang-18
x86_64                randconfig-005-20240706   clang-18
x86_64                randconfig-006-20240706   clang-18
x86_64                randconfig-011-20240706   gcc-12
x86_64                randconfig-012-20240706   gcc-12
x86_64                randconfig-013-20240706   clang-18
x86_64                randconfig-014-20240706   gcc-13
x86_64                randconfig-015-20240706   gcc-13
x86_64                randconfig-016-20240706   gcc-13
x86_64                randconfig-071-20240706   gcc-12
x86_64                randconfig-072-20240706   gcc-13
x86_64                randconfig-073-20240706   gcc-12
x86_64                randconfig-074-20240706   gcc-13
x86_64                randconfig-075-20240706   clang-18
x86_64                randconfig-076-20240706   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  audio_kc705_defconfig   gcc-13.2.0
xtensa                  nommu_kc705_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240706   gcc-13.2.0
xtensa                randconfig-002-20240706   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

