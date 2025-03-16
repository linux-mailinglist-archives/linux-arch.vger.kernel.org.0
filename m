Return-Path: <linux-arch+bounces-10892-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 486FCA63538
	for <lists+linux-arch@lfdr.de>; Sun, 16 Mar 2025 12:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B71E3A7925
	for <lists+linux-arch@lfdr.de>; Sun, 16 Mar 2025 11:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461931A239E;
	Sun, 16 Mar 2025 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBdP1WRS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD471A00ED
	for <linux-arch@vger.kernel.org>; Sun, 16 Mar 2025 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742123415; cv=none; b=lZxOhjvE7HSETwufUYESN3QXyZHecXnztzgv1LtL05DYQzFZ8IWEkvxYiVovCq7SWJZ6BYOVOOAVedOkW179IFJ55uNZy70gjVyKE7fTHgf2IkGPW4LwYUZxsxYqbpZH+lTN2PlD+Y5nE++tiws5KYbWc/ACymc58sMH/MDICAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742123415; c=relaxed/simple;
	bh=Bq7RowSkz4on9hBKf74g4thOMJs0a6qQEkFX7fLAcWw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=e4dR/BJHpbZJhoJsWoRR/0UhycvUeGnfqjSXksJj4Ui7zVMtIGqJCo9UFMP3lveJrCInPEvHoK9BTfNXWx/vI/+PSKtpgpJViOK3HNX+xZkLx46d+1yBQGC2GfYDv0Osi23fnWBC7mSNdRWr+v9HHf6kqTOcBY9EEe3++2EsF5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBdP1WRS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742123413; x=1773659413;
  h=date:from:to:cc:subject:message-id;
  bh=Bq7RowSkz4on9hBKf74g4thOMJs0a6qQEkFX7fLAcWw=;
  b=CBdP1WRSYOtynn6xV68we4CAgxi8qATasS3IfK7kHVMsxGYH6DUlEdgA
   DjgCAiAYktsQZQiv1QFr9cpN7XdXcoIVFFL7gwonE10/Py50QFPGM+lFA
   LEZui1kEsP9yOS6di/kRkCB1N7Jpl32B9/okWgPq+LZFLyOFw1Mbawvzh
   tBtt+kmSsVKOJPS0luA4wZsCcfxfZgQ4LT9NbMxxJHMClh43bo+zxW+sd
   KWFyFMZJJhqMv56/8rjHkAHkyALVgquC8PhW0Ei4QoMvbWu8DzfREquXS
   HzsWUtGWgK0ZWZYe4HfEne+2Mtyg9mQ9LXXeqaJ0XscN1Z5l8xfm/dswv
   Q==;
X-CSE-ConnectionGUID: y+ln2wMCQtSieYssyoGjCw==
X-CSE-MsgGUID: rGtfLeJGSSS5nAbFFfmAew==
X-IronPort-AV: E=McAfee;i="6700,10204,11374"; a="43136800"
X-IronPort-AV: E=Sophos;i="6.14,251,1736841600"; 
   d="scan'208";a="43136800"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2025 04:10:13 -0700
X-CSE-ConnectionGUID: kLbNjveDRhGoWbQ2Lgi00Q==
X-CSE-MsgGUID: ClUpElMvSca1jZnkk+Oblg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,251,1736841600"; 
   d="scan'208";a="122432579"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 16 Mar 2025 04:10:11 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ttlsf-000ByJ-0d;
	Sun, 16 Mar 2025 11:10:09 +0000
Date: Sun, 16 Mar 2025 19:09:24 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 9d48cc07d0d7f72d4d44c75f5f7d3471d60f2213
Message-ID: <202503161915.ovxeaLNm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 9d48cc07d0d7f72d4d44c75f5f7d3471d60f2213  m68k/nommu: stop using GENERIC_IOMAP

elapsed time: 1444m

configs tested: 155
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                        nsimosci_defconfig    gcc-13.2.0
arc                   randconfig-001-20250315    gcc-13.2.0
arc                   randconfig-002-20250315    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-14
arm                            mmp2_defconfig    gcc-14.2.0
arm                          moxart_defconfig    gcc-14.2.0
arm                             mxs_defconfig    clang-15
arm                   randconfig-001-20250315    gcc-14.2.0
arm                   randconfig-002-20250315    clang-21
arm                   randconfig-003-20250315    clang-21
arm                   randconfig-004-20250315    gcc-14.2.0
arm                        realview_defconfig    clang-16
arm                       spear13xx_defconfig    gcc-14.2.0
arm                        spear6xx_defconfig    clang-15
arm                           u8500_defconfig    gcc-14.2.0
arm                        vexpress_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250315    gcc-14.2.0
arm64                 randconfig-002-20250315    gcc-14.2.0
arm64                 randconfig-003-20250315    clang-16
arm64                 randconfig-004-20250315    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250315    gcc-14.2.0
csky                  randconfig-002-20250315    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250315    clang-21
hexagon               randconfig-002-20250315    clang-17
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250315    gcc-12
i386        buildonly-randconfig-002-20250315    clang-19
i386        buildonly-randconfig-003-20250315    clang-19
i386        buildonly-randconfig-004-20250315    clang-19
i386        buildonly-randconfig-005-20250315    gcc-11
i386        buildonly-randconfig-006-20250315    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250315    gcc-14.2.0
loongarch             randconfig-002-20250315    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250315    gcc-14.2.0
nios2                 randconfig-002-20250315    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250315    gcc-14.2.0
parisc                randconfig-002-20250315    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    clang-21
powerpc                       holly_defconfig    clang-21
powerpc                 linkstation_defconfig    clang-20
powerpc                     mpc5200_defconfig    clang-21
powerpc                      ppc44x_defconfig    clang-21
powerpc               randconfig-001-20250315    clang-21
powerpc               randconfig-002-20250315    gcc-14.2.0
powerpc               randconfig-003-20250315    clang-18
powerpc                     tqm8560_defconfig    gcc-14.2.0
powerpc                         wii_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250315    gcc-14.2.0
powerpc64             randconfig-002-20250315    clang-18
powerpc64             randconfig-003-20250315    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250315    gcc-14.2.0
riscv                 randconfig-002-20250315    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250315    clang-19
s390                  randconfig-002-20250315    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                          landisk_defconfig    gcc-14.2.0
sh                    randconfig-001-20250315    gcc-14.2.0
sh                    randconfig-002-20250315    gcc-14.2.0
sh                           se7619_defconfig    gcc-14.2.0
sh                           se7712_defconfig    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250315    gcc-14.2.0
sparc                 randconfig-002-20250315    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250315    gcc-14.2.0
sparc64               randconfig-002-20250315    gcc-14.2.0
um                               alldefconfig    clang-21
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250315    gcc-12
um                    randconfig-002-20250315    clang-18
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250315    gcc-12
x86_64      buildonly-randconfig-002-20250315    clang-19
x86_64      buildonly-randconfig-003-20250315    clang-19
x86_64      buildonly-randconfig-004-20250315    clang-19
x86_64      buildonly-randconfig-005-20250315    clang-19
x86_64      buildonly-randconfig-006-20250315    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250315    gcc-14.2.0
xtensa                randconfig-002-20250315    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

