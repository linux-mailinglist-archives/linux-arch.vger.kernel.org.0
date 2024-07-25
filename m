Return-Path: <linux-arch+bounces-5634-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDA893C9B7
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 22:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27FB1C21FCD
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 20:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E529B13C812;
	Thu, 25 Jul 2024 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/GQh5rK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983AF4D8B9
	for <linux-arch@vger.kernel.org>; Thu, 25 Jul 2024 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939846; cv=none; b=oKvkOivcs1tXPq7z6WcyhT7WG91tidxGq6payL6UgdWO9b62QyrSpMq0phB45EpZtWGvWY/fhJ246tlBs1WlEqjrAY3ga+hZrgnQxTG1GynU5l1uu99eA/BV9jTXYGV2lx2TSOtj2TLS6xICtGftOOoty1OuKNhQyxwvILchM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939846; c=relaxed/simple;
	bh=lQ0ua/5TXf/wFvz+8+f3KAbcdiXKzHvJHsGWJqje39s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NRof4OJX9BWLryEebrzM8eDXhWUle8fRoQ9Q/9qP/isBj2KoumtxClfewT5xL0mFHrTOYv7M3fZO2AgYGqYuKg0E1zO7N1dAtmuJaSbauiqV8zuaVu+MBc4rs0/x//uy6xAC90lrkFOiCeYFskW3E3NedSdKt+tlk2LM4DaAcOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/GQh5rK; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721939844; x=1753475844;
  h=date:from:to:cc:subject:message-id;
  bh=lQ0ua/5TXf/wFvz+8+f3KAbcdiXKzHvJHsGWJqje39s=;
  b=H/GQh5rKt6ZeYlQFHGuiseW9Q0tgy4Lv4C7aGP5xqkHQdrvfZDRvBist
   X8pZM/DQeeimbKm5yZetQZhbCqOr7e6Gw0Ns+OghwtCZn8nXIkvFmKJcu
   Ste7y7UE1G5YEsyA/+9XfsA3GLogYQS8dJqLHI5U+T9nUXE5Sir969U6d
   hlynl/EtPYZ3DIA/hSAt3gcK7MJ09/3QXcIupa/QGP2YKCatBduddNAhD
   CdFzQxeVPRvebhwyK2uXY6ZIq31UOGU7sJRIZOH+8ZycbvNx4hIRK5Ke9
   YiTwzpHkb3eVriZLdamHjhVOlGfam/TBC7HoIZNs6SRnwi9auc2cfGKC7
   A==;
X-CSE-ConnectionGUID: XQlwjTzPQeuZazXe7mIc+g==
X-CSE-MsgGUID: SJQH7weRQ8m03fjTzIjdEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19586386"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="19586386"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 13:37:24 -0700
X-CSE-ConnectionGUID: ugkmjSUNReKYSPXVjC09Ww==
X-CSE-MsgGUID: KGA7e+dFRLS2XWDKgujkZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="84023140"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 25 Jul 2024 13:37:22 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sX5DD-000oRI-1e;
	Thu, 25 Jul 2024 20:37:19 +0000
Date: Fri, 26 Jul 2024 04:36:36 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11] BUILD REGRESSION
 297d47a6407bea09324a4e1ba26a1735093f433f
Message-ID: <202407260433.7hQBErrn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git syscall-tbl-6.11
branch HEAD: 297d47a6407bea09324a4e1ba26a1735093f433f  mips: clean up signal syscalls

Error/Warning ids grouped by kconfigs:

recent_errors
|-- um-allmodconfig
|   `-- arch-x86-um-syscalls_64.c:error:use-of-undeclared-identifier-sys_mmap
|-- um-allyesconfig
|   `-- include-linux-syscalls.h:error:sys_mmap-undeclared-(first-use-in-this-function)
`-- x86_64-allnoconfig
    |-- arch-arm-kernel-entry-common.S:asm-syscall_table_oabi.h-is-included-more-than-once.
    |-- arch-powerpc-kernel-systbl.c:asm-syscall_table_64.h-is-included-more-than-once.
    `-- arch-x86-um-sys_call_table_32.c:asm-syscall_table_32.h-is-included-more-than-once.

elapsed time: 725m

configs tested: 181
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
arc                   randconfig-001-20240725   gcc-13.2.0
arc                   randconfig-002-20240725   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         axm55xx_defconfig   clang-20
arm                                 defconfig   gcc-13.2.0
arm                      integrator_defconfig   clang-20
arm                        multi_v7_defconfig   clang-20
arm                   randconfig-001-20240725   clang-20
arm                   randconfig-002-20240725   clang-20
arm                   randconfig-003-20240725   clang-17
arm                   randconfig-004-20240725   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240725   clang-20
arm64                 randconfig-002-20240725   clang-20
arm64                 randconfig-003-20240725   gcc-14.1.0
arm64                 randconfig-004-20240725   gcc-14.1.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240725   gcc-14.1.0
csky                  randconfig-002-20240725   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240725   clang-20
hexagon               randconfig-002-20240725   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240725   gcc-13
i386         buildonly-randconfig-002-20240725   gcc-8
i386         buildonly-randconfig-003-20240725   gcc-13
i386         buildonly-randconfig-004-20240725   gcc-8
i386         buildonly-randconfig-005-20240725   gcc-13
i386         buildonly-randconfig-006-20240725   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240725   gcc-13
i386                  randconfig-002-20240725   gcc-13
i386                  randconfig-003-20240725   gcc-13
i386                  randconfig-004-20240725   gcc-8
i386                  randconfig-005-20240725   clang-18
i386                  randconfig-006-20240725   clang-18
i386                  randconfig-011-20240725   clang-18
i386                  randconfig-012-20240725   gcc-13
i386                  randconfig-013-20240725   clang-18
i386                  randconfig-014-20240725   gcc-13
i386                  randconfig-015-20240725   clang-18
i386                  randconfig-016-20240725   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240725   gcc-14.1.0
loongarch             randconfig-002-20240725   gcc-14.1.0
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
mips                          ath79_defconfig   clang-20
mips                     cu1830-neo_defconfig   clang-20
mips                     loongson1b_defconfig   clang-20
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240725   gcc-14.1.0
nios2                 randconfig-002-20240725   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240725   gcc-14.1.0
parisc                randconfig-002-20240725   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                    amigaone_defconfig   clang-20
powerpc                 canyonlands_defconfig   clang-20
powerpc                    gamecube_defconfig   clang-20
powerpc                      ppc64e_defconfig   clang-20
powerpc               randconfig-001-20240725   clang-20
powerpc               randconfig-002-20240725   clang-20
powerpc               randconfig-003-20240725   gcc-14.1.0
powerpc                    sam440ep_defconfig   clang-20
powerpc                     tqm8555_defconfig   clang-20
powerpc64             randconfig-001-20240725   gcc-14.1.0
powerpc64             randconfig-002-20240725   gcc-14.1.0
powerpc64             randconfig-003-20240725   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240725   gcc-14.1.0
riscv                 randconfig-002-20240725   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240725   clang-20
s390                  randconfig-002-20240725   clang-15
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240725   gcc-14.1.0
sh                    randconfig-002-20240725   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240725   gcc-14.1.0
sparc64               randconfig-002-20240725   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240725   gcc-12
um                    randconfig-002-20240725   clang-20
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240725   clang-18
x86_64       buildonly-randconfig-002-20240725   clang-18
x86_64       buildonly-randconfig-003-20240725   clang-18
x86_64       buildonly-randconfig-004-20240725   clang-18
x86_64       buildonly-randconfig-005-20240725   gcc-13
x86_64       buildonly-randconfig-006-20240725   gcc-13
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240725   clang-18
x86_64                randconfig-002-20240725   clang-18
x86_64                randconfig-003-20240725   clang-18
x86_64                randconfig-004-20240725   clang-18
x86_64                randconfig-005-20240725   gcc-13
x86_64                randconfig-006-20240725   gcc-13
x86_64                randconfig-011-20240725   gcc-10
x86_64                randconfig-012-20240725   clang-18
x86_64                randconfig-013-20240725   gcc-13
x86_64                randconfig-014-20240725   gcc-13
x86_64                randconfig-015-20240725   clang-18
x86_64                randconfig-016-20240725   gcc-8
x86_64                randconfig-071-20240725   gcc-13
x86_64                randconfig-072-20240725   clang-18
x86_64                randconfig-073-20240725   gcc-8
x86_64                randconfig-074-20240725   clang-18
x86_64                randconfig-075-20240725   clang-18
x86_64                randconfig-076-20240725   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240725   gcc-14.1.0
xtensa                randconfig-002-20240725   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

