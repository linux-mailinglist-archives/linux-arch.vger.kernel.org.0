Return-Path: <linux-arch+bounces-10996-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8054CA6ADE7
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 19:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180218A5380
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 18:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693CA22DFB6;
	Thu, 20 Mar 2025 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NjgSpe+i"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C3B22D7B1
	for <linux-arch@vger.kernel.org>; Thu, 20 Mar 2025 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496810; cv=none; b=kWDvSCJ7E/iq1yxrjRMVr/EW4NHJuB8WclaTgbmgROqTIml9oKpKCfB1dtEsTmhebx2e7nYGOFEBq9r3WHdXGR9dj4Z7m3VcBKtkXzD+GXf7C9SNpWRlFsz7jcLXTTAzGdMV11iC8DU1TCl0uUxuYnUw4b3epFIFTm5/1kkRDeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496810; c=relaxed/simple;
	bh=ayEUwBcdOaCHwM4Na5MJ1fO5KcQaZwXX5gCG4o8BkhU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=L8OaXKsl0rvYO7/QK89K3XKiSGbCIJz7b0TvBQBQg0ILj0Vx80mEan3VopwObo/JToggRN6F/1etl5EJKE69HkqWnLr6IcfntCjuE5GoFiC1tJ0i9QioyAz3NwEp0jp2ko7LPnRd7Ec1xbp1gL9JIgMXPYZ/2zgGWmgwlVrEoBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NjgSpe+i; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742496808; x=1774032808;
  h=date:from:to:cc:subject:message-id;
  bh=ayEUwBcdOaCHwM4Na5MJ1fO5KcQaZwXX5gCG4o8BkhU=;
  b=NjgSpe+iEUp9/Dng5g8Fj+FOgkjBNB3q405aJO9xCnBKRY8cjrcgN5c4
   N1NlvdFszxy6X/haQHXoN/RzQzDE6CPZXULfkVlQVBCymdcfQgph8qBsz
   Prh8rHLtP+Mg4fzUT5X8SR4qGw1KSoWh17NI7H9hkKoF3yLAZ6H1HqHRE
   nu25hGAlOpfczsisZ2HLWdpGeXugRvBzT+tQStB2o7ccxi/7/nF9ddGim
   6FUpG9fIeaW3peFg4lQ+4VgJ83F3cXef/9PVbrDao5x8H+XhuhZ5xTVQp
   syc5HufVEMqRY6CgjD5Rc40SC42V1Epe4JxHGHWEQrtYz8itPrOfH46le
   Q==;
X-CSE-ConnectionGUID: bMrKt/E9SeuNiW4n7NZf5w==
X-CSE-MsgGUID: GoOq839mRi+/+90lHyRddA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="47410110"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="47410110"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 11:53:28 -0700
X-CSE-ConnectionGUID: DA/ESRbhRBOMvci1GUhPJg==
X-CSE-MsgGUID: AHTUVkylQtCgd+q/9Sa/0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="123937204"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 20 Mar 2025 11:53:26 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvL19-0000gR-37;
	Thu, 20 Mar 2025 18:53:23 +0000
Date: Fri, 21 Mar 2025 02:52:59 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 eb6a0803c9dbd1307e26509a01e4ecf69db6b953
Message-ID: <202503210253.LZUHwssM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: eb6a0803c9dbd1307e26509a01e4ecf69db6b953  mips: export pci_iounmap()

elapsed time: 1446m

configs tested: 231
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-9.3.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                            hsdk_defconfig    clang-15
arc                   randconfig-001-20250320    gcc-10.5.0
arc                   randconfig-001-20250320    gcc-7.5.0
arc                   randconfig-002-20250320    gcc-7.5.0
arc                   randconfig-002-20250320    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-8.5.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-6.5.0
arm                       aspeed_g5_defconfig    clang-15
arm                                 defconfig    gcc-14.2.0
arm                             mxs_defconfig    clang-15
arm                   randconfig-001-20250320    clang-20
arm                   randconfig-001-20250320    gcc-7.5.0
arm                   randconfig-002-20250320    clang-16
arm                   randconfig-002-20250320    gcc-7.5.0
arm                   randconfig-003-20250320    gcc-7.5.0
arm                   randconfig-003-20250320    gcc-8.5.0
arm                   randconfig-004-20250320    gcc-6.5.0
arm                   randconfig-004-20250320    gcc-7.5.0
arm                           tegra_defconfig    clang-15
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    clang-15
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250320    clang-21
arm64                 randconfig-001-20250320    gcc-7.5.0
arm64                 randconfig-002-20250320    clang-21
arm64                 randconfig-002-20250320    gcc-7.5.0
arm64                 randconfig-003-20250320    clang-19
arm64                 randconfig-003-20250320    gcc-7.5.0
arm64                 randconfig-004-20250320    gcc-7.5.0
arm64                 randconfig-004-20250320    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250320    gcc-10.5.0
csky                  randconfig-001-20250320    gcc-12.4.0
csky                  randconfig-002-20250320    gcc-12.4.0
csky                  randconfig-002-20250320    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250320    clang-18
hexagon               randconfig-001-20250320    gcc-12.4.0
hexagon               randconfig-002-20250320    clang-21
hexagon               randconfig-002-20250320    gcc-12.4.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250320    gcc-12
i386        buildonly-randconfig-002-20250320    clang-20
i386        buildonly-randconfig-003-20250320    clang-20
i386        buildonly-randconfig-004-20250320    clang-20
i386        buildonly-randconfig-005-20250320    gcc-12
i386        buildonly-randconfig-006-20250320    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250320    clang-20
i386                  randconfig-002-20250320    clang-20
i386                  randconfig-003-20250320    clang-20
i386                  randconfig-004-20250320    clang-20
i386                  randconfig-005-20250320    clang-20
i386                  randconfig-006-20250320    clang-20
i386                  randconfig-007-20250320    clang-20
i386                  randconfig-011-20250320    gcc-12
i386                  randconfig-012-20250320    gcc-12
i386                  randconfig-013-20250320    gcc-12
i386                  randconfig-014-20250320    gcc-12
i386                  randconfig-015-20250320    gcc-12
i386                  randconfig-016-20250320    gcc-12
i386                  randconfig-017-20250320    gcc-12
loongarch                        allmodconfig    gcc-12.4.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    clang-15
loongarch             randconfig-001-20250320    gcc-12.4.0
loongarch             randconfig-001-20250320    gcc-14.2.0
loongarch             randconfig-002-20250320    gcc-12.4.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-8.5.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-6.5.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-9.3.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-9.3.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    clang-15
mips                         rt305x_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250320    gcc-12.4.0
nios2                 randconfig-001-20250320    gcc-6.5.0
nios2                 randconfig-002-20250320    gcc-12.4.0
openrisc                          allnoconfig    clang-15
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-10.5.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250320    gcc-12.4.0
parisc                randconfig-001-20250320    gcc-13.3.0
parisc                randconfig-002-20250320    gcc-11.5.0
parisc                randconfig-002-20250320    gcc-12.4.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-5.5.0
powerpc                           allnoconfig    clang-15
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      arches_defconfig    clang-15
powerpc                      bamboo_defconfig    clang-15
powerpc                 mpc8313_rdb_defconfig    clang-15
powerpc               randconfig-001-20250320    gcc-12.4.0
powerpc               randconfig-001-20250320    gcc-6.5.0
powerpc               randconfig-002-20250320    clang-21
powerpc               randconfig-002-20250320    gcc-12.4.0
powerpc               randconfig-003-20250320    clang-21
powerpc               randconfig-003-20250320    gcc-12.4.0
powerpc64             randconfig-001-20250320    clang-21
powerpc64             randconfig-001-20250320    gcc-12.4.0
powerpc64             randconfig-002-20250320    gcc-12.4.0
powerpc64             randconfig-002-20250320    gcc-8.5.0
powerpc64             randconfig-003-20250320    clang-21
powerpc64             randconfig-003-20250320    gcc-12.4.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250320    clang-21
riscv                 randconfig-002-20250320    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                             allyesconfig    gcc-8.5.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250320    gcc-5.5.0
s390                  randconfig-002-20250320    gcc-7.5.0
sh                               allmodconfig    gcc-14.2.0
sh                               allmodconfig    gcc-9.3.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                               allyesconfig    gcc-7.5.0
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    clang-15
sh                            migor_defconfig    clang-15
sh                    randconfig-001-20250320    gcc-14.2.0
sh                    randconfig-002-20250320    gcc-10.5.0
sh                          sdk7780_defconfig    clang-15
sparc                            allmodconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-6.5.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250320    gcc-7.5.0
sparc                 randconfig-002-20250320    gcc-7.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250320    gcc-5.5.0
sparc64               randconfig-002-20250320    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-15
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250320    gcc-12
um                    randconfig-002-20250320    clang-16
um                           x86_64_defconfig    gcc-12
x86_64                           alldefconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250320    clang-20
x86_64      buildonly-randconfig-002-20250320    clang-20
x86_64      buildonly-randconfig-002-20250320    gcc-12
x86_64      buildonly-randconfig-003-20250320    clang-20
x86_64      buildonly-randconfig-004-20250320    clang-20
x86_64      buildonly-randconfig-005-20250320    clang-20
x86_64      buildonly-randconfig-006-20250320    clang-20
x86_64      buildonly-randconfig-006-20250320    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250320    clang-20
x86_64                randconfig-002-20250320    clang-20
x86_64                randconfig-003-20250320    clang-20
x86_64                randconfig-004-20250320    clang-20
x86_64                randconfig-005-20250320    clang-20
x86_64                randconfig-006-20250320    clang-20
x86_64                randconfig-007-20250320    clang-20
x86_64                randconfig-008-20250320    clang-20
x86_64                randconfig-071-20250320    gcc-12
x86_64                randconfig-072-20250320    gcc-12
x86_64                randconfig-073-20250320    gcc-12
x86_64                randconfig-074-20250320    gcc-12
x86_64                randconfig-075-20250320    gcc-12
x86_64                randconfig-076-20250320    gcc-12
x86_64                randconfig-077-20250320    gcc-12
x86_64                randconfig-078-20250320    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    clang-15
xtensa                randconfig-001-20250320    gcc-9.3.0
xtensa                randconfig-002-20250320    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

