Return-Path: <linux-arch+bounces-4228-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 536188BD79A
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 00:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7BF91F2112E
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 22:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5214144C88;
	Mon,  6 May 2024 22:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IP9tNf48"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1494B42A8A
	for <linux-arch@vger.kernel.org>; Mon,  6 May 2024 22:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715034814; cv=none; b=WD/oJhNaB8Y6gijeI4HiI3joAcI4skFpvUgLXzzYJTs/9GPg9PINgkDNKapol73Ozp1aYotNEFt57Zg8Z3Pr5OAkAIaIRV3uYrk1wz7o4hcCw25Iwu33DYeZdPWTjkQtsw8CgdjavCU5zqi0Qtp2mJSlF3ms9OFdN4zljjB7HYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715034814; c=relaxed/simple;
	bh=fNCak3YtV+uaj4xJeDPLK5u+wnJb6JeoFIp/EeqANc0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rNPlunCKYFqZuIE1PobOXcvF60e6fIFiWm3JyV2Wjp6MNIqWsP5Ywr/fIc1FAjxT7IPjOksd74+XQt91PZFEBqNJMwSU9Fki/PSWuxHD1hrffiz4IPkzWHkE00UJ/zXoy6ht51GoiFIrcMExoEA348ApQJDHIfDicf+8pxAffnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IP9tNf48; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715034812; x=1746570812;
  h=date:from:to:cc:subject:message-id;
  bh=fNCak3YtV+uaj4xJeDPLK5u+wnJb6JeoFIp/EeqANc0=;
  b=IP9tNf48B4M8kdRetOq6J2Oq9jmPjJRQLxjT8JDL6ib729HreXL/WWil
   5YkdvnWUA/jsMLhuJreYaZItntmbu/sZmK7trd4XZVFoqNVoevmWUQboC
   jaZ3LbRb6nfnowhQ6/u27BmsYvWflbUFpjk4e/sVwwxfVL1NmwdSlvnhM
   Qzrj4FANdm3TiX7/YzBCIltY6pbgMUDgiFkhaUJAFG6c9Qg9oj7DNwSXa
   gb6/LcEDSE/t14cHitVn/v+2+ZfFisSjM1KGOGnpS+27iF9AlGjPHq4CU
   2HyfgRdvXYdXqhXpCvvIEm0awq3Dtz9RYHuXfJeyEixbgfhO4T1Q2G1Y8
   g==;
X-CSE-ConnectionGUID: jfSOTRfmS4qUmLiUTQDEcA==
X-CSE-MsgGUID: 2lAMEDdgSwSJgH/SsTonzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="36185575"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="36185575"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 15:33:31 -0700
X-CSE-ConnectionGUID: oOFK0ptnSE2D+9REnqivew==
X-CSE-MsgGUID: SHJ8ANCISmim0DEIbtgU3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="59162181"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 06 May 2024 15:33:30 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s46tk-00015t-08;
	Mon, 06 May 2024 22:33:28 +0000
Date: Tue, 07 May 2024 06:32:59 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 02d947bc83a277c2e5d6f4d9d1b0281e3fbcb817
Message-ID: <202405070658.sUlX7QEs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 02d947bc83a277c2e5d6f4d9d1b0281e3fbcb817  Merge branch 'alpha-cleanup-6.9' into asm-generic

elapsed time: 729m

configs tested: 200
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
arc                   randconfig-001-20240506   gcc  
arc                   randconfig-001-20240507   gcc  
arc                   randconfig-002-20240506   gcc  
arc                   randconfig-002-20240507   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240506   clang
arm                   randconfig-001-20240507   gcc  
arm                   randconfig-002-20240506   clang
arm                   randconfig-002-20240507   clang
arm                   randconfig-003-20240506   gcc  
arm                   randconfig-003-20240507   gcc  
arm                   randconfig-004-20240506   clang
arm                   randconfig-004-20240507   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240506   gcc  
arm64                 randconfig-001-20240507   clang
arm64                 randconfig-002-20240506   gcc  
arm64                 randconfig-002-20240507   clang
arm64                 randconfig-003-20240506   clang
arm64                 randconfig-003-20240507   clang
arm64                 randconfig-004-20240506   clang
arm64                 randconfig-004-20240507   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240506   gcc  
csky                  randconfig-001-20240507   gcc  
csky                  randconfig-002-20240506   gcc  
csky                  randconfig-002-20240507   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240506   clang
hexagon               randconfig-001-20240507   clang
hexagon               randconfig-002-20240506   clang
hexagon               randconfig-002-20240507   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240506   gcc  
i386         buildonly-randconfig-002-20240506   clang
i386         buildonly-randconfig-003-20240506   gcc  
i386         buildonly-randconfig-004-20240506   gcc  
i386         buildonly-randconfig-005-20240506   gcc  
i386         buildonly-randconfig-006-20240506   clang
i386                                defconfig   clang
i386                  randconfig-001-20240506   gcc  
i386                  randconfig-002-20240506   clang
i386                  randconfig-003-20240506   gcc  
i386                  randconfig-004-20240506   clang
i386                  randconfig-005-20240506   clang
i386                  randconfig-006-20240506   gcc  
i386                  randconfig-011-20240506   gcc  
i386                  randconfig-012-20240506   gcc  
i386                  randconfig-013-20240506   gcc  
i386                  randconfig-014-20240506   clang
i386                  randconfig-015-20240506   clang
i386                  randconfig-016-20240506   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240506   gcc  
loongarch             randconfig-001-20240507   gcc  
loongarch             randconfig-002-20240506   gcc  
loongarch             randconfig-002-20240507   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240506   gcc  
nios2                 randconfig-001-20240507   gcc  
nios2                 randconfig-002-20240506   gcc  
nios2                 randconfig-002-20240507   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240506   gcc  
parisc                randconfig-001-20240507   gcc  
parisc                randconfig-002-20240506   gcc  
parisc                randconfig-002-20240507   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240506   gcc  
powerpc               randconfig-001-20240507   gcc  
powerpc               randconfig-002-20240506   clang
powerpc               randconfig-002-20240507   clang
powerpc               randconfig-003-20240506   gcc  
powerpc               randconfig-003-20240507   clang
powerpc64             randconfig-001-20240506   clang
powerpc64             randconfig-001-20240507   gcc  
powerpc64             randconfig-002-20240506   clang
powerpc64             randconfig-002-20240507   gcc  
powerpc64             randconfig-003-20240506   clang
powerpc64             randconfig-003-20240507   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240506   clang
riscv                 randconfig-001-20240507   clang
riscv                 randconfig-002-20240506   gcc  
riscv                 randconfig-002-20240507   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240506   gcc  
s390                  randconfig-001-20240507   gcc  
s390                  randconfig-002-20240506   gcc  
s390                  randconfig-002-20240507   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240506   gcc  
sh                    randconfig-001-20240507   gcc  
sh                    randconfig-002-20240506   gcc  
sh                    randconfig-002-20240507   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240506   gcc  
sparc64               randconfig-002-20240506   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240506   clang
um                    randconfig-002-20240506   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240506   gcc  
x86_64       buildonly-randconfig-002-20240506   gcc  
x86_64       buildonly-randconfig-003-20240506   gcc  
x86_64       buildonly-randconfig-004-20240506   clang
x86_64       buildonly-randconfig-005-20240506   clang
x86_64       buildonly-randconfig-006-20240506   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240506   clang
x86_64                randconfig-002-20240506   clang
x86_64                randconfig-003-20240506   clang
x86_64                randconfig-004-20240506   clang
x86_64                randconfig-005-20240506   clang
x86_64                randconfig-006-20240506   clang
x86_64                randconfig-011-20240506   gcc  
x86_64                randconfig-012-20240506   gcc  
x86_64                randconfig-013-20240506   gcc  
x86_64                randconfig-014-20240506   gcc  
x86_64                randconfig-015-20240506   gcc  
x86_64                randconfig-016-20240506   gcc  
x86_64                randconfig-071-20240506   gcc  
x86_64                randconfig-072-20240506   clang
x86_64                randconfig-073-20240506   gcc  
x86_64                randconfig-074-20240506   clang
x86_64                randconfig-075-20240506   gcc  
x86_64                randconfig-076-20240506   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240506   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

