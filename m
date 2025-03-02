Return-Path: <linux-arch+bounces-10485-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6C2A4B4E2
	for <lists+linux-arch@lfdr.de>; Sun,  2 Mar 2025 22:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946F01890040
	for <lists+linux-arch@lfdr.de>; Sun,  2 Mar 2025 21:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B6C1E9B33;
	Sun,  2 Mar 2025 21:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mnS5VI7X"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDDD1D54FE
	for <linux-arch@vger.kernel.org>; Sun,  2 Mar 2025 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740950067; cv=none; b=FsgSpTCzrquoey2Kr3kv9GPoU9fIGrP6ow0G8QNEXxEi6UzZEuEOrdO/pJBNbYLcduxX0Xas+0oUhH7I50b+3/kxydrAL84wqrglr4wNpXZ50C/VCcjYmHBcF5P3gSHlJAD/DhhNGAXEnwu7b0A/ZPnbfLCs+BD3leTzMkRI3wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740950067; c=relaxed/simple;
	bh=4Icxa0I8IeFaQlDn63EmFlFMh0Rch6PPgu74ZDWfWXg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qdzFL2Mx1ZaZL3Q004KXONMxC0pL92sLFyBtIPIoKIxP6pQE6HRkXZPNi3AdXy7XkqoJkgT1ryyedSVNlT+z7uk91OcgUJMaXEkbZYHvdpX11yniynco5Hp1GLp7GX1IgUjal5I36xjjH04F1mycy3iAJnaQSNazHQyQ1uAzMio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mnS5VI7X; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740950065; x=1772486065;
  h=date:from:to:cc:subject:message-id;
  bh=4Icxa0I8IeFaQlDn63EmFlFMh0Rch6PPgu74ZDWfWXg=;
  b=mnS5VI7X5VdYfkHrUKXKr9fMRvmnGs/eQZxM/eOg/wGv1ZGt4Zdljxo9
   kRvOGsqWhEc+4li8WXu72bfiYkW5pdvPBwuqTgMT6WS/e5vEi4IojlHkk
   hrjeMbcB26wyU4SHDxGl3mIhpMR7TXMkR60TEomCgGI1fl4qbBACl91PH
   qI25Fh54kg8hSNM0kNi3wKBN3QJ3rl29rRDQhVFjlELxvOBajHjgYiO9H
   jPe7bOoSUITUsYUEvTRuhwJsLCfNe/p0JWtuw1HXnO6/iTXb5qf92q2gW
   AySnUI7QP3nYTvzn1Ax8XkP9yuQTIdJfFftdYdr8ziledp8LC29TX/P5X
   w==;
X-CSE-ConnectionGUID: sq5ag1mXQsuzXSsRKNm+HQ==
X-CSE-MsgGUID: tXPhWrpZSNe6KvrOoiFmnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="41733335"
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="41733335"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 13:14:25 -0800
X-CSE-ConnectionGUID: kLsZ6JFeTTGJDjeS0in29g==
X-CSE-MsgGUID: vycb1p3QS2qYiqoreN8J9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="118523596"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 02 Mar 2025 13:14:24 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toqdZ-000Hdm-1q;
	Sun, 02 Mar 2025 21:14:16 +0000
Date: Mon, 03 Mar 2025 05:13:27 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 9e81c965742c2a9a28cf59416fee40e7cb1b773e
Message-ID: <202503030521.mlOCM7jt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 9e81c965742c2a9a28cf59416fee40e7cb1b773e  io.h: drop unused headers

elapsed time: 1445m

configs tested: 152
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
arc                 nsimosci_hs_smp_defconfig    gcc-13.2.0
arc                   randconfig-001-20250302    gcc-13.2.0
arc                   randconfig-002-20250302    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                     davinci_all_defconfig    clang-21
arm                                 defconfig    clang-21
arm                          ep93xx_defconfig    clang-21
arm                            mps2_defconfig    clang-15
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                        mvebu_v7_defconfig    clang-15
arm                            qcom_defconfig    clang-17
arm                   randconfig-001-20250302    gcc-14.2.0
arm                   randconfig-002-20250302    clang-21
arm                   randconfig-003-20250302    gcc-14.2.0
arm                   randconfig-004-20250302    clang-21
arm                        shmobile_defconfig    gcc-14.2.0
arm                        vexpress_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250302    clang-18
arm64                 randconfig-002-20250302    gcc-14.2.0
arm64                 randconfig-003-20250302    gcc-14.2.0
arm64                 randconfig-004-20250302    clang-16
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250302    gcc-14.2.0
csky                  randconfig-002-20250302    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250302    clang-21
hexagon               randconfig-002-20250302    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250302    gcc-12
i386        buildonly-randconfig-002-20250302    clang-19
i386        buildonly-randconfig-003-20250302    gcc-12
i386        buildonly-randconfig-004-20250302    gcc-12
i386        buildonly-randconfig-005-20250302    gcc-12
i386        buildonly-randconfig-006-20250302    gcc-12
i386                                defconfig    clang-19
loongarch                        alldefconfig    gcc-14.2.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250302    gcc-14.2.0
loongarch             randconfig-002-20250302    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    clang-16
mips                         bigsur_defconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250302    gcc-14.2.0
nios2                 randconfig-002-20250302    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250302    gcc-14.2.0
parisc                randconfig-002-20250302    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                       ebony_defconfig    clang-18
powerpc                      ep88xc_defconfig    gcc-14.2.0
powerpc                    gamecube_defconfig    clang-16
powerpc                 mpc832x_rdb_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250302    gcc-14.2.0
powerpc               randconfig-002-20250302    gcc-14.2.0
powerpc               randconfig-003-20250302    clang-16
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250302    gcc-14.2.0
powerpc64             randconfig-002-20250302    gcc-14.2.0
powerpc64             randconfig-003-20250302    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250302    clang-21
riscv                 randconfig-002-20250302    clang-16
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250302    clang-17
s390                  randconfig-002-20250302    clang-19
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250302    gcc-14.2.0
sh                    randconfig-002-20250302    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sh                             sh03_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250302    gcc-14.2.0
sparc                 randconfig-002-20250302    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250302    gcc-14.2.0
sparc64               randconfig-002-20250302    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250302    gcc-12
um                    randconfig-002-20250302    clang-16
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250302    clang-19
x86_64      buildonly-randconfig-002-20250302    clang-19
x86_64      buildonly-randconfig-003-20250302    gcc-12
x86_64      buildonly-randconfig-004-20250302    gcc-12
x86_64      buildonly-randconfig-005-20250302    gcc-12
x86_64      buildonly-randconfig-006-20250302    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250302    gcc-14.2.0
xtensa                randconfig-002-20250302    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

