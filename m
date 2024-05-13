Return-Path: <linux-arch+bounces-4356-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C528C3E81
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 12:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8017282DE3
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 10:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CE5149C6B;
	Mon, 13 May 2024 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIFNYOim"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76128148FE7
	for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715594429; cv=none; b=eBr+XdcSghdZKfUa7xt3mw31RmTkkEfxay42kBQNxYcPRcsFSyJzqB77zkwmXcLAwJW0t92IZJtiVnFAVq7LgAru0hrVrD2G1/AhV1ffdKWPG8+79kCJPbo0Qg+tnmYTKvzSUO3iL1+XKix2nzhR1FEGksEQ3tRCiJ4CKD2Ki6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715594429; c=relaxed/simple;
	bh=2/534MfTAjfjqR/ExUVXfxH36+dBnKxvVfg9nJMIqzI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mhv7hw3uEPJxmUovx1dvzDngzvmwPSeO8/ChI10rudZ6yqqeI4qhciQObqI1b70Z3MLqrtCmE1tCVhy5/mzL6gppDnirEYU0eLFWBFmJlSn1GqHTShG6Xfsk35rXWDMEaL8c0L7MQuXl9G7i05XaCAbehUAZ0KvYwJsFSQ/JyfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIFNYOim; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715594428; x=1747130428;
  h=date:from:to:cc:subject:message-id;
  bh=2/534MfTAjfjqR/ExUVXfxH36+dBnKxvVfg9nJMIqzI=;
  b=SIFNYOimLRI8AL1ORvfmSF8n+dyd5+7CCElhbsJ1JUc4uD3dTQ679Rme
   TK6Crf9UqaVhEuCVZwFrRrI6mwIBS/td5K2AlcxbLSs9vIt6yblTcQVrM
   i9hNah3I+OPC/nd31edOZONgvNsJpUbpmr8PgO/rm4jz5S+PSFMGA2QVc
   mivYiZ7YQ/OcJBb5nGTW3FUi5MA6Bj2sYI4IX3onLcXZ2krgz7sQV4PGa
   L7xf14vvFBpAHpx1k3kbXpBI/gMyMvDKo1hPRSiji4E+4jGDOmKsSjhjl
   k7BoiqWOdZQg4sVf/zGa0zUjv9HslrD0NQNqOKiYxO+kFHtZsuT1xTqZD
   g==;
X-CSE-ConnectionGUID: oKSYyWlqRB6j/eFQxGSZ+A==
X-CSE-MsgGUID: po1WsQKmRDK6YEG9P4Fsrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11343257"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="11343257"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:00:25 -0700
X-CSE-ConnectionGUID: 7q05XIfLQ7Guv7CUA+s7Cg==
X-CSE-MsgGUID: fA8Ot9Y7QjOn8Br89+Swpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="30313463"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 13 May 2024 03:00:23 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6STl-000A3U-2F;
	Mon, 13 May 2024 10:00:21 +0000
Date: Mon, 13 May 2024 17:59:54 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.9] BUILD REGRESSION
 e0d7a2fe9b74052a280531e773ebaba59e2d523f
Message-ID: <202405131751.qYGQXcMD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git syscall-tbl-6.9
branch HEAD: e0d7a2fe9b74052a280531e773ebaba59e2d523f  arm64: use generic syscall table generation rules

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202405130707.pzKiV49b-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202405130739.4E0Jd9gx-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202405131015.R5eW2BHz-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/arm64/include/asm/vdso/compat_gettimeofday.h:27:31: error: use of undeclared identifier '__NR_compat32_gettimeofday'
arch/arm64/include/asm/vdso/compat_gettimeofday.h:44:31: error: use of undeclared identifier '__NR_compat32_clock_gettime64'
arch/arm64/include/asm/vdso/compat_gettimeofday.h:61:31: error: use of undeclared identifier '__NR_compat32_clock_gettime'
arch/arm64/include/asm/vdso/compat_gettimeofday.h:78:31: error: use of undeclared identifier '__NR_compat32_clock_getres_time64'
arch/arm64/include/asm/vdso/compat_gettimeofday.h:95:31: error: use of undeclared identifier '__NR_compat32_clock_getres'
kernel/fork.c:3087:2: warning: #warning clone3() entry point is missing, please fix [-Wcpp]
make[3]: *** No rule to make target 'arch/um/include/generated/asm/bpf_perf_event.h', needed by 'all'.

Unverified Error/Warning (likely false positive, please contact us if interested):

arch/riscv/kernel/syscall_table.c: asm/syscall_table.h is included more than once.
{standard input}:465: Warning: overflow in branch to .L44; converted into longer instruction sequence

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allnoconfig
|   `-- kernel-fork.c:warning:warning-clone3()-entry-point-is-missing-please-fix
|-- sh-ecovec24-romimage_defconfig
|   `-- kernel-fork.c:warning:warning-clone3()-entry-point-is-missing-please-fix
|-- sh-edosk7760_defconfig
|   `-- kernel-fork.c:warning:warning-clone3()-entry-point-is-missing-please-fix
|-- sh-randconfig-001-20240513
|   |-- kernel-fork.c:warning:warning-clone3()-entry-point-is-missing-please-fix
|   `-- standard-input:Warning:overflow-in-branch-to-.L44-converted-into-longer-instruction-sequence
|-- sh-se7206_defconfig
|   `-- kernel-fork.c:warning:warning-clone3()-entry-point-is-missing-please-fix
|-- sh-shx3_defconfig
|   `-- kernel-fork.c:warning:warning-clone3()-entry-point-is-missing-please-fix
|-- sparc-randconfig-002-20240513
|   `-- kernel-fork.c:warning:warning-clone3()-entry-point-is-missing-please-fix
`-- sparc64-randconfig-002-20240513
    `-- kernel-fork.c:warning:warning-clone3()-entry-point-is-missing-please-fix
clang_recent_errors
|-- arm64-allmodconfig
|   |-- arch-arm64-include-asm-vdso-compat_gettimeofday.h:error:use-of-undeclared-identifier-__NR_compat32_clock_getres
|   |-- arch-arm64-include-asm-vdso-compat_gettimeofday.h:error:use-of-undeclared-identifier-__NR_compat32_clock_getres_time64
|   |-- arch-arm64-include-asm-vdso-compat_gettimeofday.h:error:use-of-undeclared-identifier-__NR_compat32_clock_gettime
|   |-- arch-arm64-include-asm-vdso-compat_gettimeofday.h:error:use-of-undeclared-identifier-__NR_compat32_clock_gettime64
|   `-- arch-arm64-include-asm-vdso-compat_gettimeofday.h:error:use-of-undeclared-identifier-__NR_compat32_gettimeofday
|-- um-allnoconfig
|   `-- make:No-rule-to-make-target-arch-um-include-generated-asm-bpf_perf_event.h-needed-by-all-.
`-- x86_64-allnoconfig
    `-- arch-riscv-kernel-syscall_table.c:asm-syscall_table.h-is-included-more-than-once.

elapsed time: 726m

configs tested: 179
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240513   gcc  
arc                   randconfig-002-20240513   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                      footbridge_defconfig   clang
arm                            hisi_defconfig   gcc  
arm                         lpc18xx_defconfig   clang
arm                   randconfig-001-20240513   clang
arm                   randconfig-002-20240513   gcc  
arm                   randconfig-003-20240513   clang
arm                   randconfig-004-20240513   gcc  
arm                         socfpga_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240513   gcc  
arm64                 randconfig-002-20240513   gcc  
arm64                 randconfig-003-20240513   clang
arm64                 randconfig-004-20240513   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240513   gcc  
csky                  randconfig-002-20240513   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240513   clang
hexagon               randconfig-002-20240513   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240513   clang
i386         buildonly-randconfig-002-20240513   clang
i386         buildonly-randconfig-003-20240513   gcc  
i386         buildonly-randconfig-004-20240513   clang
i386         buildonly-randconfig-005-20240513   gcc  
i386         buildonly-randconfig-006-20240513   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240513   gcc  
i386                  randconfig-002-20240513   clang
i386                  randconfig-003-20240513   gcc  
i386                  randconfig-004-20240513   clang
i386                  randconfig-005-20240513   gcc  
i386                  randconfig-006-20240513   gcc  
i386                  randconfig-011-20240513   gcc  
i386                  randconfig-012-20240513   clang
i386                  randconfig-013-20240513   clang
i386                  randconfig-014-20240513   gcc  
i386                  randconfig-015-20240513   gcc  
i386                  randconfig-016-20240513   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240513   gcc  
loongarch             randconfig-002-20240513   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                     loongson1b_defconfig   clang
mips                    maltaup_xpa_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240513   gcc  
nios2                 randconfig-002-20240513   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240513   gcc  
parisc                randconfig-002-20240513   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     powernv_defconfig   gcc  
powerpc               randconfig-001-20240513   gcc  
powerpc               randconfig-002-20240513   gcc  
powerpc               randconfig-003-20240513   gcc  
powerpc64             randconfig-001-20240513   gcc  
powerpc64             randconfig-002-20240513   clang
powerpc64             randconfig-003-20240513   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240513   gcc  
riscv                 randconfig-002-20240513   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240513   gcc  
s390                  randconfig-002-20240513   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                    randconfig-001-20240513   gcc  
sh                    randconfig-002-20240513   gcc  
sh                           se7206_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240513   gcc  
sparc64               randconfig-002-20240513   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240513   clang
um                    randconfig-002-20240513   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240513   gcc  
x86_64       buildonly-randconfig-002-20240513   gcc  
x86_64       buildonly-randconfig-003-20240513   gcc  
x86_64       buildonly-randconfig-004-20240513   clang
x86_64       buildonly-randconfig-005-20240513   clang
x86_64       buildonly-randconfig-006-20240513   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240513   clang
x86_64                randconfig-002-20240513   clang
x86_64                randconfig-003-20240513   clang
x86_64                randconfig-004-20240513   gcc  
x86_64                randconfig-005-20240513   clang
x86_64                randconfig-006-20240513   clang
x86_64                randconfig-011-20240513   clang
x86_64                randconfig-012-20240513   gcc  
x86_64                randconfig-013-20240513   clang
x86_64                randconfig-014-20240513   clang
x86_64                randconfig-015-20240513   gcc  
x86_64                randconfig-016-20240513   clang
x86_64                randconfig-071-20240513   clang
x86_64                randconfig-072-20240513   clang
x86_64                randconfig-073-20240513   clang
x86_64                randconfig-074-20240513   gcc  
x86_64                randconfig-075-20240513   gcc  
x86_64                randconfig-076-20240513   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240513   gcc  
xtensa                randconfig-002-20240513   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

