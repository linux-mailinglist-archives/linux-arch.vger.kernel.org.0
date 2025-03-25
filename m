Return-Path: <linux-arch+bounces-11113-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC41AA70477
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 16:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 776A87A1FF1
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 14:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6591C8621;
	Tue, 25 Mar 2025 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZTqxHkP6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8173C149C41
	for <linux-arch@vger.kernel.org>; Tue, 25 Mar 2025 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914841; cv=none; b=SrwcbO7YK1hB97Vk5UMesJqDRX/6+bGfRK9BvX1ym6GfGhqrgqYSmGV0SYdS4WNolCcL+q9RrBzih2sHaHSHIqA3doWdGbbtXygk6CuQFcM9Wi9P9XYEKT/DFvPCULdxrGcJD5bz0x5RaT4itB3/uF5O4RpXvGvvWBfgE7jDP9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914841; c=relaxed/simple;
	bh=Rg/cQ/57GCeU3meKHFR8TSCE8DUOLGIToDbwywsvaL4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZMGY0g5SoBA2o6ArX8saXEF1b17RAaRC6Tohea4HOWQHrHxUPrABaDixkciMRoyStz76iJHwz0ehY3rAJeIY+FbPa8q/1K0nZ5hZh7V6GDBs3CJ9drEZN7NZrpbd5WNFLqXiamluk1lDO0Zk+/0t2DzodFyAa+2+Fm8Z7sEP230=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZTqxHkP6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742914840; x=1774450840;
  h=date:from:to:cc:subject:message-id;
  bh=Rg/cQ/57GCeU3meKHFR8TSCE8DUOLGIToDbwywsvaL4=;
  b=ZTqxHkP64FvKJ21/4hDaZIetJoKc+oMBv2O+OQ5wiJsryMP/qAyPIQ/l
   EnbPbxVYI0UBxde4MDLtvjnSOfsaMe2CH1F67F9Gtrkr887+9mKrrtBDG
   3o7ET2MNSWj3vJc92dac6rmRX3uU5q+q0LttHviNZJu1qMJ7ezsTHYvMO
   +VkUXmaH8IkUEhVzvBrsv3knc/yZH8cGpM9puXcREgbQ3O3yJ1pYmcI3k
   d5e6ORxQPSLbr0ZC9ACv6Q7pGjOEd02WyOt5oTLdB4h93NSCknmSsVq/w
   N5MJG7ZuDiI6Qg1tNdiCPGuy2y1h2V0tPfdv3b/0VNyyg03nfOcLKIjtd
   A==;
X-CSE-ConnectionGUID: DqhFG2fES+SrO0StmV9iYg==
X-CSE-MsgGUID: VnJHQsv3QHClvqygv3cZTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="43322318"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="43322318"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 08:00:36 -0700
X-CSE-ConnectionGUID: XSDLa6INROyvlEEGnt+RKA==
X-CSE-MsgGUID: 8vp5gkJ3R+CHVjySdFw7ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="155308821"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 25 Mar 2025 08:00:35 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tx5lS-0004xL-2o;
	Tue, 25 Mar 2025 15:00:27 +0000
Date: Tue, 25 Mar 2025 22:59:49 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 dcce85484d3abe0fe0a930a154bdc076f1eb4ae0
Message-ID: <202503252239.24rQFG5v-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: dcce85484d3abe0fe0a930a154bdc076f1eb4ae0  m68k: coldfire: select PCI_IOMAP for PCI

elapsed time: 1449m

configs tested: 142
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250325    gcc-14.2.0
arc                   randconfig-002-20250325    gcc-13.3.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g4_defconfig    clang-21
arm                        mvebu_v7_defconfig    clang-21
arm                   randconfig-001-20250325    gcc-5.5.0
arm                   randconfig-002-20250325    gcc-5.5.0
arm                   randconfig-003-20250325    gcc-5.5.0
arm                   randconfig-004-20250325    clang-21
arm                           sama7_defconfig    clang-21
arm                        spear6xx_defconfig    clang-15
arm                    vt8500_v6_v7_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250325    gcc-9.5.0
arm64                 randconfig-002-20250325    clang-18
arm64                 randconfig-003-20250325    gcc-7.5.0
arm64                 randconfig-004-20250325    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250325    gcc-13.3.0
csky                  randconfig-002-20250325    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250325    clang-16
hexagon               randconfig-002-20250325    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250325    gcc-12
i386        buildonly-randconfig-002-20250325    clang-20
i386        buildonly-randconfig-003-20250325    gcc-12
i386        buildonly-randconfig-004-20250325    clang-20
i386        buildonly-randconfig-005-20250325    gcc-12
i386        buildonly-randconfig-006-20250325    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
loongarch             randconfig-001-20250325    gcc-14.2.0
loongarch             randconfig-002-20250325    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        omega2p_defconfig    clang-21
mips                          rb532_defconfig    clang-18
mips                       rbtx49xx_defconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250325    gcc-7.5.0
nios2                 randconfig-002-20250325    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                  or1klitex_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250325    gcc-12.4.0
parisc                randconfig-002-20250325    gcc-12.4.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                      cm5200_defconfig    clang-21
powerpc                        fsp2_defconfig    gcc-14.2.0
powerpc                   motionpro_defconfig    clang-15
powerpc                      pcm030_defconfig    clang-15
powerpc               randconfig-001-20250325    clang-21
powerpc               randconfig-002-20250325    clang-21
powerpc               randconfig-003-20250325    gcc-9.3.0
powerpc                  storcenter_defconfig    gcc-14.2.0
powerpc                 xes_mpc85xx_defconfig    gcc-14.2.0
powerpc64                        alldefconfig    clang-21
powerpc64             randconfig-001-20250325    clang-15
powerpc64             randconfig-002-20250325    clang-21
powerpc64             randconfig-003-20250325    gcc-9.3.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250325    gcc-9.3.0
riscv                 randconfig-002-20250325    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250325    clang-18
s390                  randconfig-002-20250325    clang-15
s390                       zfcpdump_defconfig    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                          landisk_defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250325    gcc-5.5.0
sh                    randconfig-002-20250325    gcc-11.5.0
sh                           se7206_defconfig    gcc-14.2.0
sh                           se7712_defconfig    gcc-14.2.0
sparc                            alldefconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250325    gcc-8.5.0
sparc                 randconfig-002-20250325    gcc-6.5.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250325    gcc-8.5.0
sparc64               randconfig-002-20250325    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250325    clang-21
um                    randconfig-002-20250325    clang-21
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250325    gcc-12
x86_64      buildonly-randconfig-002-20250325    clang-20
x86_64      buildonly-randconfig-003-20250325    gcc-12
x86_64      buildonly-randconfig-004-20250325    gcc-12
x86_64      buildonly-randconfig-005-20250325    clang-20
x86_64      buildonly-randconfig-006-20250325    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250325    gcc-8.5.0
xtensa                randconfig-002-20250325    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

