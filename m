Return-Path: <linux-arch+bounces-13782-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6E8BA25D0
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 06:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5348F1C02284
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 04:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C37A26E16A;
	Fri, 26 Sep 2025 04:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvvVjWcQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088E269D18
	for <linux-arch@vger.kernel.org>; Fri, 26 Sep 2025 04:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758859437; cv=none; b=q9QypTLqc78i8/EdDMDqKOD6GmYNojzWaQJqyqIQcO3cxChhukO/dPnP+cESIuLd26JW/QxMSeai9fbHpKxyM8FPfLdI/u5ZlaW/nxxncUDKtrv3yFJ0ThTyTRNJzjIKBAVKEWQRREjw2wtHPC3sKnRKOMDNZ5XH2nFuJeeTVTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758859437; c=relaxed/simple;
	bh=295nnwMbJxBGML+24HFC6imlMUqddvZ5oUG31+s2jyw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=k5yzdVGMbCZmlmivjSm2dzJVg1G0xMBdKftiu88zWi8P+Oasaq9ck8oUAxlbijTulA2K4x1a0xeyTwfH0r6wCvPWhJ3+XFCp8OKTWDC+/sXLyOkt5jbp5gC86d1dSq1ucbJAJS0mInNAjFc3SWgS+il2x3NrebiRO28LEyBXVVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvvVjWcQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758859434; x=1790395434;
  h=date:from:to:cc:subject:message-id;
  bh=295nnwMbJxBGML+24HFC6imlMUqddvZ5oUG31+s2jyw=;
  b=hvvVjWcQ03FHvcOFXyeFdvhBObG0189u/hTTGwHKbErLdTEEnk2ONsc9
   a5Y8mnpTxtbTk9WBHhs7CBDbGiGuArvV1KWC/Z25ylZI9hwJB4zrXeIQ3
   ZJN4KXNYFtPCvMlk85YofiyBPIoBwHsFu5BByQOanqtxCQ6tvYnXUxFum
   1F8X7/55bpDg9kjI1OU+pMtP5vLAjbQFYd1GHB76wuvTC2X5fT4k2eCTL
   sdOpKlw9AA8eybRMUhxO3IvOKEJz5mkJkd5FRkWiDCZ59Jps3uIMWPZHe
   S7ITprQz+Y2YHVACQov7jdyG9ibMFGz4NWbfsqg+NBXKoBottV/CGKMrA
   Q==;
X-CSE-ConnectionGUID: xzVCeEPLT72Frj8ESsl9fA==
X-CSE-MsgGUID: 9AGwXZoES2GAfisom6H9Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61076650"
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="61076650"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 21:03:53 -0700
X-CSE-ConnectionGUID: 8hUANIOpQbKbS5kzRlgvJA==
X-CSE-MsgGUID: XjgA4rc8QuSS3A4bqswvxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="176780654"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 25 Sep 2025 21:03:51 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1zgT-0005sj-0Q;
	Fri, 26 Sep 2025 04:03:49 +0000
Date: Fri, 26 Sep 2025 12:03:28 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 edcc8a38b5ac1a3dbd05e113a38a25b937ebefe5
Message-ID: <202509261222.04hZynjw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: edcc8a38b5ac1a3dbd05e113a38a25b937ebefe5  once: fix race by moving DO_ONCE to separate section

elapsed time: 1308m

configs tested: 239
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250925    gcc-13.4.0
arc                   randconfig-001-20250926    gcc-8.5.0
arc                   randconfig-002-20250925    gcc-15.1.0
arc                   randconfig-002-20250926    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   randconfig-001-20250925    gcc-11.5.0
arm                   randconfig-001-20250926    gcc-8.5.0
arm                   randconfig-002-20250925    gcc-10.5.0
arm                   randconfig-002-20250926    gcc-8.5.0
arm                   randconfig-003-20250925    gcc-8.5.0
arm                   randconfig-003-20250926    gcc-8.5.0
arm                   randconfig-004-20250925    gcc-14.3.0
arm                   randconfig-004-20250926    gcc-8.5.0
arm                           sama7_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250925    gcc-11.5.0
arm64                 randconfig-001-20250926    gcc-8.5.0
arm64                 randconfig-002-20250925    gcc-15.1.0
arm64                 randconfig-002-20250926    gcc-8.5.0
arm64                 randconfig-003-20250925    clang-19
arm64                 randconfig-003-20250926    gcc-8.5.0
arm64                 randconfig-004-20250925    gcc-8.5.0
arm64                 randconfig-004-20250926    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250925    gcc-14.3.0
csky                  randconfig-001-20250926    clang-22
csky                  randconfig-002-20250925    gcc-15.1.0
csky                  randconfig-002-20250926    clang-22
hexagon                          alldefconfig    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250925    clang-22
hexagon               randconfig-001-20250926    clang-22
hexagon               randconfig-002-20250925    clang-22
hexagon               randconfig-002-20250926    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250925    clang-20
i386        buildonly-randconfig-001-20250926    clang-20
i386        buildonly-randconfig-002-20250925    clang-20
i386        buildonly-randconfig-002-20250926    clang-20
i386        buildonly-randconfig-003-20250925    gcc-14
i386        buildonly-randconfig-003-20250926    clang-20
i386        buildonly-randconfig-004-20250925    gcc-14
i386        buildonly-randconfig-004-20250926    clang-20
i386        buildonly-randconfig-005-20250925    clang-20
i386        buildonly-randconfig-005-20250926    clang-20
i386        buildonly-randconfig-006-20250925    clang-20
i386        buildonly-randconfig-006-20250926    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250926    clang-20
i386                  randconfig-002-20250926    clang-20
i386                  randconfig-003-20250926    clang-20
i386                  randconfig-004-20250926    clang-20
i386                  randconfig-005-20250926    clang-20
i386                  randconfig-006-20250926    clang-20
i386                  randconfig-007-20250926    clang-20
i386                  randconfig-011-20250926    gcc-12
i386                  randconfig-012-20250926    gcc-12
i386                  randconfig-013-20250926    gcc-12
i386                  randconfig-014-20250926    gcc-12
i386                  randconfig-015-20250926    gcc-12
i386                  randconfig-016-20250926    gcc-12
i386                  randconfig-017-20250926    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250925    clang-18
loongarch             randconfig-001-20250926    clang-22
loongarch             randconfig-002-20250925    gcc-12.5.0
loongarch             randconfig-002-20250926    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                         apollo_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                         rt305x_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250925    gcc-8.5.0
nios2                 randconfig-001-20250926    clang-22
nios2                 randconfig-002-20250925    gcc-10.5.0
nios2                 randconfig-002-20250926    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250925    gcc-8.5.0
parisc                randconfig-001-20250926    clang-22
parisc                randconfig-002-20250925    gcc-15.1.0
parisc                randconfig-002-20250926    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                 canyonlands_defconfig    gcc-15.1.0
powerpc                     mpc512x_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250925    clang-22
powerpc               randconfig-001-20250926    clang-22
powerpc               randconfig-002-20250925    gcc-8.5.0
powerpc               randconfig-002-20250926    clang-22
powerpc               randconfig-003-20250925    gcc-8.5.0
powerpc               randconfig-003-20250926    clang-22
powerpc64             randconfig-001-20250925    clang-22
powerpc64             randconfig-001-20250926    clang-22
powerpc64             randconfig-002-20250925    gcc-14.3.0
powerpc64             randconfig-002-20250926    clang-22
powerpc64             randconfig-003-20250925    gcc-8.5.0
powerpc64             randconfig-003-20250926    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250925    clang-22
riscv                 randconfig-001-20250926    gcc-15.1.0
riscv                 randconfig-002-20250925    clang-22
riscv                 randconfig-002-20250926    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250925    gcc-15.1.0
s390                  randconfig-001-20250926    gcc-15.1.0
s390                  randconfig-002-20250925    gcc-13.4.0
s390                  randconfig-002-20250926    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250925    gcc-15.1.0
sh                    randconfig-001-20250926    gcc-15.1.0
sh                    randconfig-002-20250925    gcc-13.4.0
sh                    randconfig-002-20250926    gcc-15.1.0
sh                           se7712_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250925    gcc-15.1.0
sparc                 randconfig-001-20250926    gcc-15.1.0
sparc                 randconfig-002-20250925    gcc-12.5.0
sparc                 randconfig-002-20250926    gcc-15.1.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250925    gcc-10.5.0
sparc64               randconfig-001-20250926    gcc-15.1.0
sparc64               randconfig-002-20250925    gcc-10.5.0
sparc64               randconfig-002-20250926    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250925    gcc-14
um                    randconfig-001-20250926    gcc-15.1.0
um                    randconfig-002-20250925    clang-22
um                    randconfig-002-20250926    gcc-15.1.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250925    clang-20
x86_64      buildonly-randconfig-001-20250926    gcc-14
x86_64      buildonly-randconfig-002-20250925    gcc-14
x86_64      buildonly-randconfig-002-20250926    gcc-14
x86_64      buildonly-randconfig-003-20250925    gcc-14
x86_64      buildonly-randconfig-003-20250926    gcc-14
x86_64      buildonly-randconfig-004-20250925    clang-20
x86_64      buildonly-randconfig-004-20250926    gcc-14
x86_64      buildonly-randconfig-005-20250925    clang-20
x86_64      buildonly-randconfig-005-20250926    gcc-14
x86_64      buildonly-randconfig-006-20250925    gcc-14
x86_64      buildonly-randconfig-006-20250926    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250926    gcc-14
x86_64                randconfig-002-20250926    gcc-14
x86_64                randconfig-003-20250926    gcc-14
x86_64                randconfig-004-20250926    gcc-14
x86_64                randconfig-005-20250926    gcc-14
x86_64                randconfig-006-20250926    gcc-14
x86_64                randconfig-007-20250926    gcc-14
x86_64                randconfig-008-20250926    gcc-14
x86_64                randconfig-071-20250926    gcc-14
x86_64                randconfig-072-20250926    gcc-14
x86_64                randconfig-073-20250926    gcc-14
x86_64                randconfig-074-20250926    gcc-14
x86_64                randconfig-075-20250926    gcc-14
x86_64                randconfig-076-20250926    gcc-14
x86_64                randconfig-077-20250926    gcc-14
x86_64                randconfig-078-20250926    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                       common_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250925    gcc-12.5.0
xtensa                randconfig-001-20250926    gcc-15.1.0
xtensa                randconfig-002-20250925    gcc-11.5.0
xtensa                randconfig-002-20250926    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

