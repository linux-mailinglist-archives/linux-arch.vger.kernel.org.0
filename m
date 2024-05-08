Return-Path: <linux-arch+bounces-4265-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 905818BFF82
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 15:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7BF1C220CB
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 13:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161861A2C11;
	Wed,  8 May 2024 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHLkf9fY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269A026291
	for <linux-arch@vger.kernel.org>; Wed,  8 May 2024 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176361; cv=none; b=IEj1bo/nMhGbuo0SPomXJVEjDATn2ZkZV15T/u7P2tZNW4WHdUKZOv1nEmSnW6SN28kj1DTjAlUXtacxRTGP7mBnmhEGD9pGIiysGslFzFWkd9XxGZobTlCDqyObMiZpYZ4KMhBzapuJXxA/7Qu2NGmTmo9HdecJ8NgYZTu1fWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176361; c=relaxed/simple;
	bh=4Ejwksm1niviFG/5DCld4+5Obo3AuPrwWYFMOidE2tc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cubwUltlfzbov/h3OYxTfzY/IZPhS1d6vCd38Y6To8QGre0uac3zSiWHPwgwMgfDesxzNfy/F+zKiJymkApujJ7OqH4C7qVxyfAaan6d2K+p1PgUtc0Xqk3jRyoZSjWOF1B6rujkGZ4liFi5Y1YfUfEL6qyMDqe/F/5n+EMUwMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHLkf9fY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715176359; x=1746712359;
  h=date:from:to:cc:subject:message-id;
  bh=4Ejwksm1niviFG/5DCld4+5Obo3AuPrwWYFMOidE2tc=;
  b=WHLkf9fY3e7LuP/9ujAMwmMvr5b+fa778y987Pmrmvsqic5C+7QMu4mx
   QqHxWfYa9BmQ2PYdkTe+w4vwAutk0pK+Yz+cHSw7M9lHxPcFMX37lOfsS
   IlcV9FVFA0x74SNaMgyk+vJH3Qj9OecuD2AbT0yoJof3X4JMTw2PJ7Rqv
   Q9w/O7EyGzKei+gVT3zckvTwienAMmZXwSsK/o+KS2Dk/gCxouxb3prgL
   Co7A5Jx6g0wVNFIY5LhI5hUAzqmoUbtXFXignDVdhYfGO4j6ku0fLARva
   NJM0lOXDgmo9RRA2t0vViE37H0CLS89nyGP2I5DzCJ6aDn+41SNPsHX09
   g==;
X-CSE-ConnectionGUID: 3SyyiAI3SbGKx+z3sEVegQ==
X-CSE-MsgGUID: ha634KtiSLKW45NSUW0uyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="21606120"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="21606120"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 06:52:39 -0700
X-CSE-ConnectionGUID: 0AC3E/A0Siy9XI657ndK/Q==
X-CSE-MsgGUID: Hmk/SRFFQISIzZZ/WT0I+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33727947"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 08 May 2024 06:52:37 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4hil-0003YX-17;
	Wed, 08 May 2024 13:52:35 +0000
Date: Wed, 08 May 2024 21:52:07 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 02af68767d27aa66c95ef0850545a9616c5e847e
Message-ID: <202405082105.PFQCRXb4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 02af68767d27aa66c95ef0850545a9616c5e847e  Merge branch 'alpha-cleanup-6.9' into asm-generic

elapsed time: 1470m

configs tested: 120
configs skipped: 3

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
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                         s3c6400_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240508   clang
i386         buildonly-randconfig-002-20240508   clang
i386         buildonly-randconfig-003-20240508   gcc  
i386         buildonly-randconfig-004-20240508   gcc  
i386         buildonly-randconfig-005-20240508   clang
i386         buildonly-randconfig-006-20240508   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240508   gcc  
i386                  randconfig-002-20240508   clang
i386                  randconfig-003-20240508   clang
i386                  randconfig-004-20240508   gcc  
i386                  randconfig-005-20240508   clang
i386                  randconfig-006-20240508   gcc  
i386                  randconfig-011-20240508   gcc  
i386                  randconfig-012-20240508   gcc  
i386                  randconfig-013-20240508   clang
i386                  randconfig-014-20240508   clang
i386                  randconfig-015-20240508   clang
i386                  randconfig-016-20240508   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                   sb1250_swarm_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        cell_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

