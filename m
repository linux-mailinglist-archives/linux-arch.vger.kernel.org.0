Return-Path: <linux-arch+bounces-7648-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7D198E888
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 04:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB14286C99
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 02:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0157E1FB4;
	Thu,  3 Oct 2024 02:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R98EI8w5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6123317BA3
	for <linux-arch@vger.kernel.org>; Thu,  3 Oct 2024 02:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727923676; cv=none; b=o927qL15lVubeOMxttNi08siCuoqSSmkjJHHxX0IEXPe4tUiTjUDJLirk9MhBWJKfdMbRgN5/1r01q2u4NQ1agZnGBoY+LGDVVXXpamyG0K7YLPd1DCq7DXmR6ZypFixSxYRhVDV9/VFfltKaJwG/jFAfvWXITAUX7MKccNBJTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727923676; c=relaxed/simple;
	bh=K71L9do+WGN4SZJdRdkW2HZ4+LS4Mr+VcoVrOsb086s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EM8SWy4UTtoZ+j79yi9wFFqBu2+z1snnWSccIiSZaQMY6IdjUALYR+41pJjbJyR+fhNUP5N6ALbpyP4YEdh4zoFMKTadYYJhY78d8iZ01oDGAs+ix8FNEsV67xP13S+E6fX8TDTokf4dtEw6UuGLnKbdOq9ympcXlR6lC0X7wxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R98EI8w5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727923672; x=1759459672;
  h=date:from:to:cc:subject:message-id;
  bh=K71L9do+WGN4SZJdRdkW2HZ4+LS4Mr+VcoVrOsb086s=;
  b=R98EI8w5y5OZcIK8+5NFNNTvzLCyakXT4X+xyMDqbaN2UnUPPgw5rSTz
   oRuvvsba6S4vAK9HlG7xNSIs/g+Xk6ffBD9k4976EaQtFyTBQ2W0ruEK3
   bCmurim10bBHjfLBdNt5jWJeQ10MOu4Usc4iJsTxmejzn2yqVUUSGOA9H
   Xx3EmBQFckqYAsPoVzeokLflOPONk1Eah0AP/ufXuC01EK/YrVLjXJ1sL
   B8EoC60safiNYDPbjU3Gm/376fKi1OulWQ+k+d+qHIcjiLw3TpTq2PoA5
   NZ/M7+wptUApJkQbwlItPkuWk4/LRzAJiVrXGmeZpOzisalN/WZZQqd+e
   w==;
X-CSE-ConnectionGUID: HOgAV1VkSwSBKlgja5/RIg==
X-CSE-MsgGUID: dnlNvK2WRZiYxtbC2YJK9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="38466175"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="38466175"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 19:47:52 -0700
X-CSE-ConnectionGUID: Ox/u3J3ARnmOyuYH5mszXA==
X-CSE-MsgGUID: GV9CnEi4SDSb7ZQRd895CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74207133"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 02 Oct 2024 19:47:51 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swBsa-000Uqp-27;
	Thu, 03 Oct 2024 02:47:48 +0000
Date: Thu, 03 Oct 2024 10:47:12 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 f822712a2c69154f9a0a009f8e18fe394eb7766f
Message-ID: <202410031057.D3b3YkPJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: f822712a2c69154f9a0a009f8e18fe394eb7766f  UAPI/ioctl: Improve parameter name of ioctl request definition helpers

elapsed time: 1093m

configs tested: 119
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241003    gcc-12
i386        buildonly-randconfig-002-20241003    gcc-12
i386        buildonly-randconfig-003-20241003    gcc-12
i386        buildonly-randconfig-004-20241003    gcc-12
i386        buildonly-randconfig-005-20241003    gcc-12
i386        buildonly-randconfig-006-20241003    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241003    gcc-12
i386                  randconfig-002-20241003    gcc-12
i386                  randconfig-003-20241003    gcc-12
i386                  randconfig-004-20241003    gcc-12
i386                  randconfig-005-20241003    gcc-12
i386                  randconfig-006-20241003    gcc-12
i386                  randconfig-011-20241003    gcc-12
i386                  randconfig-012-20241003    gcc-12
i386                  randconfig-013-20241003    gcc-12
i386                  randconfig-014-20241003    gcc-12
i386                  randconfig-015-20241003    gcc-12
i386                  randconfig-016-20241003    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241003    clang-18
x86_64      buildonly-randconfig-002-20241003    clang-18
x86_64      buildonly-randconfig-003-20241003    clang-18
x86_64      buildonly-randconfig-004-20241003    clang-18
x86_64      buildonly-randconfig-005-20241003    clang-18
x86_64      buildonly-randconfig-006-20241003    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241003    clang-18
x86_64                randconfig-002-20241003    clang-18
x86_64                randconfig-003-20241003    clang-18
x86_64                randconfig-004-20241003    clang-18
x86_64                randconfig-005-20241003    clang-18
x86_64                randconfig-006-20241003    clang-18
x86_64                randconfig-011-20241003    clang-18
x86_64                randconfig-012-20241003    clang-18
x86_64                randconfig-013-20241003    clang-18
x86_64                randconfig-014-20241003    clang-18
x86_64                randconfig-015-20241003    clang-18
x86_64                randconfig-016-20241003    clang-18
x86_64                randconfig-071-20241003    clang-18
x86_64                randconfig-072-20241003    clang-18
x86_64                randconfig-073-20241003    clang-18
x86_64                randconfig-074-20241003    clang-18
x86_64                randconfig-075-20241003    clang-18
x86_64                randconfig-076-20241003    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

