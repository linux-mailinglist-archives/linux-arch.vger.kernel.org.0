Return-Path: <linux-arch+bounces-11140-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ED2A71D18
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 18:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6543BA875
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 17:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F26215F4C;
	Wed, 26 Mar 2025 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yngnedqr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF9921579F
	for <linux-arch@vger.kernel.org>; Wed, 26 Mar 2025 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009952; cv=none; b=MiQB+uoNfUJpArrbIX8PwHF16ptH391MiHm/Degtzi55zORiYj5VGlReOwHAcCZWS4utVopici+CoauxxQ2McZu220fpQH62GiTD90VjbGZ2hFJntous79zrQOxT+0B+leAQED/1aK9/yOKI/f3XdbX6vgDKCGugqk1I6DcovaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009952; c=relaxed/simple;
	bh=RcnOK8Pc5IRElfTM0fcHbuSEwdu2Drv+/4Y8ITaZ7j8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DtrREHNJZ2GlPW3PQr/yEjs60stC/uP4ydgcUfadFrcEAKIqPm3WvqTzWB0DW6Ius8P0WJGqd/feStluFsedifSOJfcuBbX7hJ5/e0a38VkJu/1QPEJfA5WRrlOhunhODFzn7MwTkjgiZMrMqU2lB23DiXoRTNP8mZy6tGkDrvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yngnedqr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743009950; x=1774545950;
  h=date:from:to:cc:subject:message-id;
  bh=RcnOK8Pc5IRElfTM0fcHbuSEwdu2Drv+/4Y8ITaZ7j8=;
  b=YngnedqrGKwDQuWbkQ7cLQO8M1LHHHj15KYkut6uFkTAa7ZqZ+QmDYQu
   eJpyuiyFl1aEvwdeVSBLmHbtWCmIFEkWbeqZL6gIPHpp5MOVECXp2Vc1V
   YlgKjo3mkAEjZlikDoKYa/nv1WEAhoXECzsbd8Spzujv46F3lIl/ZKK41
   eln/UmDdYBk3/IQMY1rZ1XjVKEL3ah642it0agB7dS9g2WEyHUuNCuAiK
   Q1bHM5L81q8uASpCjdtf2bhU2x1AwtK4bwS1nqTmkNQY8rD27zn1qv10j
   LZ3DGvevWrnlhFpYC5uAuZ6HPwNfHQIlP7iaMFF4pHMDxJnTAwB6SPA7F
   g==;
X-CSE-ConnectionGUID: r2ki5KwtQxWfQSqFzUyI3Q==
X-CSE-MsgGUID: VlbyYgwNQ8akTMgwnQ/AeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="54963025"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="54963025"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 10:25:50 -0700
X-CSE-ConnectionGUID: 3XNJw2caS8uTOpue9o0UWA==
X-CSE-MsgGUID: tuPqOzpiSxiQGbvtZX+1Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="125303356"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 26 Mar 2025 10:25:49 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txUVf-0005vv-0D;
	Wed, 26 Mar 2025 17:25:47 +0000
Date: Thu, 27 Mar 2025 01:25:39 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 ece69af2ede103e190ffdfccd9f9ec850606ab5e
Message-ID: <202503270133.NMR1luYL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: ece69af2ede103e190ffdfccd9f9ec850606ab5e  rwonce: handle KCSAN like KASAN in read_word_at_a_time()

elapsed time: 1449m

configs tested: 183
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                          axs101_defconfig    gcc-14.1.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250326    gcc-14.2.0
arc                   randconfig-002-20250326    gcc-8.5.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                   randconfig-001-20250326    gcc-7.5.0
arm                   randconfig-002-20250326    clang-21
arm                   randconfig-003-20250326    gcc-8.5.0
arm                   randconfig-004-20250326    clang-21
arm                         s5pv210_defconfig    gcc-14.1.0
arm                           spitz_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250326    clang-21
arm64                 randconfig-002-20250326    clang-21
arm64                 randconfig-003-20250326    gcc-8.5.0
arm64                 randconfig-004-20250326    gcc-6.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250326    gcc-14.2.0
csky                  randconfig-002-20250326    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250326    clang-21
hexagon               randconfig-002-20250326    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250326    gcc-12
i386        buildonly-randconfig-002-20250326    clang-20
i386        buildonly-randconfig-003-20250326    clang-20
i386        buildonly-randconfig-004-20250326    clang-20
i386        buildonly-randconfig-005-20250326    gcc-12
i386        buildonly-randconfig-006-20250326    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250326    gcc-11
i386                  randconfig-002-20250326    gcc-11
i386                  randconfig-003-20250326    gcc-11
i386                  randconfig-004-20250326    gcc-11
i386                  randconfig-005-20250326    gcc-11
i386                  randconfig-006-20250326    gcc-11
i386                  randconfig-007-20250326    gcc-11
i386                  randconfig-011-20250326    gcc-12
i386                  randconfig-012-20250326    gcc-12
i386                  randconfig-013-20250326    gcc-12
i386                  randconfig-014-20250326    gcc-12
i386                  randconfig-015-20250326    gcc-12
i386                  randconfig-016-20250326    gcc-12
i386                  randconfig-017-20250326    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250326    gcc-14.2.0
loongarch             randconfig-002-20250326    gcc-12.4.0
m68k                             alldefconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-14.2.0
m68k                          sun3x_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250326    gcc-12.4.0
nios2                 randconfig-002-20250326    gcc-10.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                       virt_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250326    gcc-13.3.0
parisc                randconfig-002-20250326    gcc-7.5.0
parisc64                         alldefconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                    ge_imp3a_defconfig    gcc-14.1.0
powerpc               randconfig-001-20250326    clang-21
powerpc               randconfig-002-20250326    gcc-6.5.0
powerpc               randconfig-003-20250326    clang-19
powerpc                     tqm8548_defconfig    clang-21
powerpc                        warp_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20250326    clang-21
powerpc64             randconfig-002-20250326    gcc-8.5.0
powerpc64             randconfig-003-20250326    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250326    clang-21
riscv                 randconfig-002-20250326    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250326    clang-15
s390                  randconfig-002-20250326    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         ap325rxa_defconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    gcc-14.2.0
sh                    randconfig-001-20250326    gcc-6.5.0
sh                    randconfig-002-20250326    gcc-6.5.0
sh                           se7721_defconfig    gcc-14.1.0
sh                            shmin_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250326    gcc-11.5.0
sparc                 randconfig-002-20250326    gcc-5.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250326    gcc-5.5.0
sparc64               randconfig-002-20250326    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250326    clang-15
um                    randconfig-002-20250326    gcc-11
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250326    clang-20
x86_64      buildonly-randconfig-002-20250326    gcc-11
x86_64      buildonly-randconfig-003-20250326    clang-20
x86_64      buildonly-randconfig-004-20250326    clang-20
x86_64      buildonly-randconfig-005-20250326    clang-20
x86_64      buildonly-randconfig-006-20250326    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250326    clang-20
x86_64                randconfig-002-20250326    clang-20
x86_64                randconfig-003-20250326    clang-20
x86_64                randconfig-004-20250326    clang-20
x86_64                randconfig-005-20250326    clang-20
x86_64                randconfig-006-20250326    clang-20
x86_64                randconfig-007-20250326    clang-20
x86_64                randconfig-008-20250326    clang-20
x86_64                randconfig-071-20250326    gcc-12
x86_64                randconfig-072-20250326    gcc-12
x86_64                randconfig-073-20250326    gcc-12
x86_64                randconfig-074-20250326    gcc-12
x86_64                randconfig-075-20250326    gcc-12
x86_64                randconfig-076-20250326    gcc-12
x86_64                randconfig-077-20250326    gcc-12
x86_64                randconfig-078-20250326    gcc-12
x86_64                               rhel-9.4    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250326    gcc-7.5.0
xtensa                randconfig-002-20250326    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

