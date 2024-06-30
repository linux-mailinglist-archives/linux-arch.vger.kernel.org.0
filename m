Return-Path: <linux-arch+bounces-5211-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD9C91D456
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jul 2024 00:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E698B20B31
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jun 2024 22:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182C24AEF4;
	Sun, 30 Jun 2024 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCsrXw3x"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E5446542
	for <linux-arch@vger.kernel.org>; Sun, 30 Jun 2024 22:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719785193; cv=none; b=JWClWGU8FgzwIpn/nc6aQEnurLpB4wtvjwj2Yh0m9OcwaYuU8AVLcfSqvKyGEG2L7wicr6XGc4E2b895ln25D6LT3R7zclJwdAOIfuuAdTOJLbUdaYWTaxPJL0/93xGnJ7CzxEXuWHFUwKXvlE12fbEhDkaHw+VX/SXvW6xQHEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719785193; c=relaxed/simple;
	bh=XQjR7OO4XGXDict8xHIa9g8B6CGmAOwZkPWn2/Ql1SY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kuszdM77KJtXqtBSv725orDcMe4us9sWWMNgU6++p4seoQ//eboFrmxrXi+2WANEQD+RqUpEqkxG9O6z7N+URrXhm/yFbtZkMdT/hVWWf+ANyPHT9QfBO3Z9ZrWagASboP6g7RVqBIM9JrwhNJwfGuzB4hVTj4H9rdCwVan/2zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCsrXw3x; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719785191; x=1751321191;
  h=date:from:to:cc:subject:message-id;
  bh=XQjR7OO4XGXDict8xHIa9g8B6CGmAOwZkPWn2/Ql1SY=;
  b=SCsrXw3xNSNQhwk0wobq5+XorAmylnEnmi+XicWH07NrCM9qllPMaQTJ
   6H4uNLXPS8qrsmZYL9TGAY12nj7d8llryPMghuEdSZxcfhorchnmJo8N6
   jWMCGLznAzIIaaAUOrXQPsJt2rU6Vd3HJ+PCu4TmXJfpB1gu1ND5sBjqK
   jD7bfGwmk/Vu9VSpz4qPccpvxjdwwuFk7zKgAZfcRvGINk17CzJJ8P87q
   DBj1kRcSjLLFH1bZRqbVdDwP9WKdq/QfCL2kzPDElc9eda4VPBIcZ1Omq
   bapJAZXZJy3Y4lAC1qRPZQWe1vRC+FnZb6WLtPlv/DKCtsE88Y0BUYeNM
   g==;
X-CSE-ConnectionGUID: u3mqJ2x2SLGJBY4IqdWy9w==
X-CSE-MsgGUID: SST3kFgrRr2OmNunMn8zjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="27513174"
X-IronPort-AV: E=Sophos;i="6.09,174,1716274800"; 
   d="scan'208";a="27513174"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 15:06:31 -0700
X-CSE-ConnectionGUID: rWfoufVORyC4Iu0aK0kymQ==
X-CSE-MsgGUID: EnekC9XHTvuiIAF/Y9o/pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,174,1716274800"; 
   d="scan'208";a="76020210"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 30 Jun 2024 15:06:30 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sO2gl-000M3a-0G;
	Sun, 30 Jun 2024 22:06:27 +0000
Date: Mon, 01 Jul 2024 06:06:09 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 01b6ed5fcd5a95f93f9991b005ded2eacf067187
Message-ID: <202407010607.nkxysTGI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 01b6ed5fcd5a95f93f9991b005ded2eacf067187  syscalls: fix sys_fanotify_mark prototype

elapsed time: 1466m

configs tested: 126
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-13.2.0
arm                          exynos_defconfig   gcc-13.2.0
arm                          pxa168_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240630   clang-18
i386         buildonly-randconfig-002-20240630   clang-18
i386         buildonly-randconfig-003-20240630   clang-18
i386         buildonly-randconfig-004-20240630   clang-18
i386         buildonly-randconfig-004-20240630   gcc-7
i386         buildonly-randconfig-005-20240630   clang-18
i386         buildonly-randconfig-006-20240630   clang-18
i386         buildonly-randconfig-006-20240630   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240630   clang-18
i386                  randconfig-001-20240630   gcc-13
i386                  randconfig-002-20240630   clang-18
i386                  randconfig-002-20240630   gcc-13
i386                  randconfig-003-20240630   clang-18
i386                  randconfig-004-20240630   clang-18
i386                  randconfig-004-20240630   gcc-13
i386                  randconfig-005-20240630   clang-18
i386                  randconfig-006-20240630   clang-18
i386                  randconfig-011-20240630   clang-18
i386                  randconfig-011-20240630   gcc-13
i386                  randconfig-012-20240630   clang-18
i386                  randconfig-013-20240630   clang-18
i386                  randconfig-013-20240630   gcc-8
i386                  randconfig-014-20240630   clang-18
i386                  randconfig-014-20240630   gcc-8
i386                  randconfig-015-20240630   clang-18
i386                  randconfig-015-20240630   gcc-10
i386                  randconfig-016-20240630   clang-18
i386                  randconfig-016-20240630   gcc-13
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                          hp300_defconfig   gcc-13.2.0
m68k                       m5275evb_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                     cu1830-neo_defconfig   gcc-13.2.0
mips                            gpr_defconfig   gcc-13.2.0
mips                malta_qemu_32r6_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                    ge_imp3a_defconfig   gcc-13.2.0
powerpc                        icon_defconfig   gcc-13.2.0
powerpc                     ppa8548_defconfig   gcc-13.2.0
powerpc                    sam440ep_defconfig   gcc-13.2.0
powerpc                     stx_gp3_defconfig   gcc-13.2.0
powerpc                     tqm8541_defconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv             nommu_k210_sdcard_defconfig   gcc-13.2.0
s390                              allnoconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                             sh03_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                                allnoconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240630   gcc-13
x86_64       buildonly-randconfig-002-20240630   gcc-13
x86_64       buildonly-randconfig-003-20240630   gcc-13
x86_64       buildonly-randconfig-004-20240630   gcc-13
x86_64       buildonly-randconfig-005-20240630   gcc-13
x86_64       buildonly-randconfig-006-20240630   gcc-13
x86_64                              defconfig   clang-18
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240630   gcc-13
x86_64                randconfig-002-20240630   gcc-13
x86_64                randconfig-003-20240630   gcc-13
x86_64                randconfig-004-20240630   gcc-13
x86_64                randconfig-005-20240630   gcc-13
x86_64                randconfig-006-20240630   gcc-13
x86_64                randconfig-011-20240630   gcc-13
x86_64                randconfig-012-20240630   gcc-13
x86_64                randconfig-013-20240630   gcc-13
x86_64                randconfig-014-20240630   gcc-13
x86_64                randconfig-015-20240630   gcc-13
x86_64                randconfig-016-20240630   gcc-13
x86_64                randconfig-071-20240630   gcc-13
x86_64                randconfig-072-20240630   gcc-13
x86_64                randconfig-073-20240630   gcc-13
x86_64                randconfig-074-20240630   gcc-13
x86_64                randconfig-075-20240630   gcc-13
x86_64                randconfig-076-20240630   gcc-13
x86_64                          rhel-8.3-func   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

