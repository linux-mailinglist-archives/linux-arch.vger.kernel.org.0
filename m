Return-Path: <linux-arch+bounces-5615-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F3693B1B7
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 15:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229621C2144A
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 13:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7965A158D6A;
	Wed, 24 Jul 2024 13:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JENT6dlw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050CA1586D5
	for <linux-arch@vger.kernel.org>; Wed, 24 Jul 2024 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721828195; cv=none; b=myxTkNzpi8BgyyJsFl5WOEFtOy8VraNP3Bc/3XZAaVt00lJAu1FeX5bdcQYP8KiwEdpmNRL8MyjiPQgd1qaszv4lTQ5QGazVLO+/ZKcWBn7KPJ8ptnbRFLqAvGSBwpcBnBEyRU6qpDFXiA9nmGZyoN46QfJ1DSFydZ8gA5T35Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721828195; c=relaxed/simple;
	bh=HcpDwRBya8gJ0plHicYJDtwWYycyfZQQ05GUJwFKZcE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uTpD85FGHmOatmeUf8YlmwQx8o5+J4VJEyuYACSDBNaQt4Bk6bFSZM1i2DlEpf7bE6DWBeLJCIjdwP+zbyJB89fB+HgSXSOyUMxG1BuDNEeaqodUXYIEc2qFmWCWC69QYyw0+gmw0AT4PxZ5xWnAlRwF86IXqwAHg+bDsqgu0zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JENT6dlw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721828193; x=1753364193;
  h=date:from:to:cc:subject:message-id;
  bh=HcpDwRBya8gJ0plHicYJDtwWYycyfZQQ05GUJwFKZcE=;
  b=JENT6dlwYY/7XtI/slM8D9rHaNSwA+RINpfmzhZuxr1jbaM75jvP3WUL
   Mp4TBwfoRGZzFChFsbPXX0GF86Ra52w8KJ/eidk/WrU9pjEm8PB3QILM5
   Z1/lfiy2/F2V2cAIc/LYX7uOIsIn9Ew9v1MLFZmGmf7MUnglA1FPhiPmt
   tLcUIRfC+SWbi03xHi0oq8uBiT+RMQZQWs8ofwv+q0VJE70bvSVy4krr+
   ouLRuXdDIZkY4Gy5EHApTCeut/QaAbua4cCQHg+o7U+3E9Y5FQ6cRNJlq
   REYbxra2RgdoDtzOIq1jtCFcXWPzt7dFQVvDBueYCMJIb16/ae73RduPB
   g==;
X-CSE-ConnectionGUID: z4zSA1g+TUq9ccP3fWAySA==
X-CSE-MsgGUID: yQwKiCoFSNKwSaydqwtu0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19316429"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="19316429"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 06:36:31 -0700
X-CSE-ConnectionGUID: TSzV233bTTidxJHbJlexPg==
X-CSE-MsgGUID: PapAE34BQC6q6aD8zY3hYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="56905295"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 24 Jul 2024 06:36:19 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWcAD-000n1u-2g;
	Wed, 24 Jul 2024 13:36:17 +0000
Date: Wed, 24 Jul 2024 21:35:22 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11] BUILD REGRESSION
 ece1b5ebc0b7064a8a130f64e85a81ec76381c3f
Message-ID: <202407242117.DZCSMwlC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git syscall-tbl-6.11
branch HEAD: ece1b5ebc0b7064a8a130f64e85a81ec76381c3f  syscalls: fix readv/writev entry

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202407241404.i00uka5s-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407241414.kQcjV3vu-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407241416.GGWdAKAR-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407241512.6bjBAKyO-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407241835.aJUft8p5-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/arm/kernel/sys_oabi-compat.c:407:1: error: conflicting types for 'sys_oabi_semtimedop'
arch/arm/kernel/sys_oabi-compat.c:407:1: warning: comparison of distinct pointer types ('long (*)(int, struct oabi_sembuf *, unsigned int)' and 'long (*)(int, struct oabi_sembuf *, unsigned int, const struct old_timespec32 *)') [-Wcompare-distinct-pointer-types]
arch/arm/kernel/sys_oabi-compat.c:419:1: error: conflicting types for 'sys_oabi_ipc'
arch/arm/kernel/sys_oabi-compat.c:419:1: warning: comparison of distinct pointer types ('long (*)(uint, int, int, int, void *)' (aka 'long (*)(unsigned int, int, int, int, void *)') and 'long (*)(uint, int, int, int, void *, long)' (aka 'long (*)(unsigned int, int, int, int, void *, long)')) [-Wcompare-distinct-pointer-types]
arch/arm/kernel/sys_oabi-compat.c:448:1: error: conflicting types for 'sys_oabi_sendto'
arch/arm/kernel/sys_oabi-compat.c:448:1: warning: comparison of distinct pointer types ('long (*)(int, void *, size_t, unsigned int)' (aka 'long (*)(int, void *, unsigned int, unsigned int)') and 'long (*)(int, void *, size_t, unsigned int, struct sockaddr *, int)' (aka 'long (*)(int, void *, unsigned int, unsigned int, struct sockaddr *, int)')) [-Wcompare-distinct-pointer-types]
arch/arm/kernel/sys_oabi-compat.c:452:13: error: 'addrlen' undeclared (first use in this function)
arch/arm/kernel/sys_oabi-compat.c:452:6: error: use of undeclared identifier 'addrlen'; did you mean 'strlen'?
arch/arm/kernel/sys_oabi-compat.c:453:27: error: use of undeclared identifier 'addr'
arch/arm/kernel/sys_oabi-compat.c:453:34: error: 'addr' undeclared (first use in this function)
arch/arm/kernel/sys_oabi-compat.c:483:16: error: too few arguments to function '__sys_sendmsg'
arch/arm/kernel/sys_oabi-compat.c:483:37: error: too few arguments to function call, expected 4, have 3
arch/arm/kernel/sys_oabi-compat.c:501:29: error: too many arguments to function 'sys_oabi_sendto'
include/linux/syscalls.h:255:25: error: conflicting types for 'sys_oabi_sendto'; have 'long int(int,  void *, size_t,  unsigned int)' {aka 'long int(int,  void *, unsigned int,  unsigned int)'}
ld.lld: error: undefined symbol: __riscv_sys_fadvise64
riscv64-linux-ld: arch/riscv/kernel/syscall_table.o:(.rodata+0x6f8): undefined reference to `__riscv_sys_fadvise64'

Unverified Error/Warning (likely false positive, please contact us if interested):

arch/x86/um/sys_call_table_32.c: asm/syscall_table_32.h is included more than once.

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm-allmodconfig
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:addr-undeclared-(first-use-in-this-function)
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:addrlen-undeclared-(first-use-in-this-function)
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:too-few-arguments-to-function-__sys_sendmsg
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:too-many-arguments-to-function-sys_oabi_sendto
|   |-- arch-arm-kernel-sys_oabi-compat.c:warning:control-reaches-end-of-non-void-function
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_oabi_sendto-have-long-int(int-void-size_t-unsigned-int)-aka-long-int(int-void-unsigned-int-unsigned-int)
|   `-- include-linux-syscalls.h:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arm-allyesconfig
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:addr-undeclared-(first-use-in-this-function)
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:addrlen-undeclared-(first-use-in-this-function)
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:too-few-arguments-to-function-__sys_sendmsg
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:too-many-arguments-to-function-sys_oabi_sendto
|   |-- arch-arm-kernel-sys_oabi-compat.c:warning:control-reaches-end-of-non-void-function
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_oabi_sendto-have-long-int(int-void-size_t-unsigned-int)-aka-long-int(int-void-unsigned-int-unsigned-int)
|   `-- include-linux-syscalls.h:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arm-randconfig-002-20240724
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:conflicting-types-for-sys_oabi_ipc
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:conflicting-types-for-sys_oabi_semtimedop
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:conflicting-types-for-sys_oabi_sendto
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:too-few-arguments-to-function-call-expected-have
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:use-of-undeclared-identifier-addr
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:use-of-undeclared-identifier-addrlen
|   |-- arch-arm-kernel-sys_oabi-compat.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-struct-oabi_sembuf-unsigned-int)-and-long-(-)(int-struct-oabi_sembuf-unsigned-int-const-struct-old_timespe
|   |-- arch-arm-kernel-sys_oabi-compat.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-void-size_t-unsigned-int)-(aka-long-(-)(int-void-unsigned-int-unsigned-int)-)-and-long-(-)(int-void-size_t
|   `-- arch-arm-kernel-sys_oabi-compat.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(uint-int-int-int-void-)-(aka-long-(-)(unsigned-int-int-int-int-void-)-)-and-long-(-)(uint-int-int-int-void-lon
|-- arm-randconfig-003-20240724
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:conflicting-types-for-sys_oabi_ipc
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:conflicting-types-for-sys_oabi_semtimedop
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:conflicting-types-for-sys_oabi_sendto
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:too-few-arguments-to-function-call-expected-have
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:use-of-undeclared-identifier-addr
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:use-of-undeclared-identifier-addrlen
|   |-- arch-arm-kernel-sys_oabi-compat.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-struct-oabi_sembuf-unsigned-int)-and-long-(-)(int-struct-oabi_sembuf-unsigned-int-const-struct-old_timespe
|   |-- arch-arm-kernel-sys_oabi-compat.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-void-size_t-unsigned-int)-(aka-long-(-)(int-void-unsigned-int-unsigned-int)-)-and-long-(-)(int-void-size_t
|   `-- arch-arm-kernel-sys_oabi-compat.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(uint-int-int-int-void-)-(aka-long-(-)(unsigned-int-int-int-int-void-)-)-and-long-(-)(uint-int-int-int-void-lon
|-- riscv-nommu_k210_sdcard_defconfig
|   `-- riscv64-linux-ld:arch-riscv-kernel-syscall_table.o:(.rodata):undefined-reference-to-__riscv_sys_fadvise64
|-- riscv-nommu_virt_defconfig
|   `-- ld.lld:error:undefined-symbol:__riscv_sys_fadvise64
`-- x86_64-allnoconfig
    |-- arch-arm-kernel-entry-common.S:asm-syscall_table_oabi.h-is-included-more-than-once.
    |-- arch-powerpc-kernel-systbl.c:asm-syscall_table_64.h-is-included-more-than-once.
    `-- arch-x86-um-sys_call_table_32.c:asm-syscall_table_32.h-is-included-more-than-once.

elapsed time: 973m

configs tested: 194
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240724   gcc-13.2.0
arc                   randconfig-002-20240724   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                       aspeed_g5_defconfig   gcc-14.1.0
arm                     davinci_all_defconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                           omap1_defconfig   gcc-14.1.0
arm                   randconfig-001-20240724   gcc-13.2.0
arm                   randconfig-002-20240724   gcc-13.2.0
arm                   randconfig-003-20240724   gcc-13.2.0
arm                   randconfig-004-20240724   gcc-13.2.0
arm                       spear13xx_defconfig   gcc-14.1.0
arm                           spitz_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240724   gcc-13.2.0
arm64                 randconfig-002-20240724   gcc-13.2.0
arm64                 randconfig-003-20240724   gcc-13.2.0
arm64                 randconfig-004-20240724   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240724   gcc-13.2.0
csky                  randconfig-002-20240724   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240724   clang-18
i386         buildonly-randconfig-002-20240724   clang-18
i386         buildonly-randconfig-002-20240724   gcc-9
i386         buildonly-randconfig-003-20240724   clang-18
i386         buildonly-randconfig-004-20240724   clang-18
i386         buildonly-randconfig-005-20240724   clang-18
i386         buildonly-randconfig-006-20240724   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240724   clang-18
i386                  randconfig-002-20240724   clang-18
i386                  randconfig-003-20240724   clang-18
i386                  randconfig-004-20240724   clang-18
i386                  randconfig-004-20240724   gcc-9
i386                  randconfig-005-20240724   clang-18
i386                  randconfig-006-20240724   clang-18
i386                  randconfig-011-20240724   clang-18
i386                  randconfig-011-20240724   gcc-13
i386                  randconfig-012-20240724   clang-18
i386                  randconfig-013-20240724   clang-18
i386                  randconfig-013-20240724   gcc-13
i386                  randconfig-014-20240724   clang-18
i386                  randconfig-014-20240724   gcc-8
i386                  randconfig-015-20240724   clang-18
i386                  randconfig-015-20240724   gcc-13
i386                  randconfig-016-20240724   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240724   gcc-13.2.0
loongarch             randconfig-002-20240724   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                         bigsur_defconfig   gcc-14.1.0
mips                      pic32mzda_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240724   gcc-13.2.0
nios2                 randconfig-002-20240724   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240724   gcc-13.2.0
parisc                randconfig-002-20240724   gcc-13.2.0
parisc64                         alldefconfig   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-14.1.0
powerpc                     ksi8560_defconfig   gcc-14.1.0
powerpc                 mpc837x_rdb_defconfig   gcc-14.1.0
powerpc                      pmac32_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240724   gcc-13.2.0
powerpc               randconfig-002-20240724   gcc-13.2.0
powerpc               randconfig-003-20240724   gcc-13.2.0
powerpc                     redwood_defconfig   gcc-14.1.0
powerpc                     tqm8560_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240724   gcc-13.2.0
powerpc64             randconfig-002-20240724   gcc-13.2.0
powerpc64             randconfig-003-20240724   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv             nommu_k210_sdcard_defconfig   gcc-14.1.0
riscv                    nommu_virt_defconfig   gcc-14.1.0
riscv                 randconfig-001-20240724   gcc-13.2.0
riscv                 randconfig-002-20240724   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240724   gcc-13.2.0
s390                  randconfig-002-20240724   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                            migor_defconfig   gcc-14.1.0
sh                    randconfig-001-20240724   gcc-13.2.0
sh                    randconfig-002-20240724   gcc-13.2.0
sh                        sh7763rdp_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240724   gcc-13.2.0
sparc64               randconfig-002-20240724   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240724   gcc-13.2.0
um                    randconfig-002-20240724   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240724   clang-18
x86_64       buildonly-randconfig-002-20240724   clang-18
x86_64       buildonly-randconfig-003-20240724   clang-18
x86_64       buildonly-randconfig-004-20240724   clang-18
x86_64       buildonly-randconfig-005-20240724   clang-18
x86_64       buildonly-randconfig-006-20240724   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240724   clang-18
x86_64                randconfig-002-20240724   clang-18
x86_64                randconfig-003-20240724   clang-18
x86_64                randconfig-004-20240724   clang-18
x86_64                randconfig-005-20240724   clang-18
x86_64                randconfig-006-20240724   clang-18
x86_64                randconfig-011-20240724   clang-18
x86_64                randconfig-012-20240724   clang-18
x86_64                randconfig-013-20240724   clang-18
x86_64                randconfig-014-20240724   clang-18
x86_64                randconfig-015-20240724   clang-18
x86_64                randconfig-016-20240724   clang-18
x86_64                randconfig-071-20240724   clang-18
x86_64                randconfig-072-20240724   clang-18
x86_64                randconfig-073-20240724   clang-18
x86_64                randconfig-074-20240724   clang-18
x86_64                randconfig-075-20240724   clang-18
x86_64                randconfig-076-20240724   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240724   gcc-13.2.0
xtensa                randconfig-002-20240724   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

