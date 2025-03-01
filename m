Return-Path: <linux-arch+bounces-10483-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA36CA4AD46
	for <lists+linux-arch@lfdr.de>; Sat,  1 Mar 2025 19:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10E33A3618
	for <lists+linux-arch@lfdr.de>; Sat,  1 Mar 2025 18:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20981B3927;
	Sat,  1 Mar 2025 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgV1PEcX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212FB8BF8
	for <linux-arch@vger.kernel.org>; Sat,  1 Mar 2025 18:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740852858; cv=none; b=n6boLaXZDQZ+XEFQ7+24mTLlgASxWJdbx57MZGEhSyjKiE+QP/ye5mXgmjqM9yYV3kbr2ioTSBYj3CBzhb4TMy5KPXyLcpz+7Bq8C5YpKjRmbjZHpV9qNMCoK44jbJOf1j70aZcSyyMiFvAJF2fKaO/BPWS/9llS235Jnt8SKW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740852858; c=relaxed/simple;
	bh=1Seyb5egjFClyUJEN8T+Qm0k0LZGnpOOgOvcVMyj+Qw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mmKC1ejaziBz/Fabc++NetQGuCegjyKmNzE/9ZaoVnnRjonRU6vs727LzqirH+EJUn1YDTIsDmQOWvORbVjIYL2Cy3cG/bPPUiTMl3fpnCq0Zj232pj94JOaTf4tqmHcWJtHmwryElEnT6LgjnxdZ+CKdZRNZD1k9Yvool4yRIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kgV1PEcX; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740852857; x=1772388857;
  h=date:from:to:cc:subject:message-id;
  bh=1Seyb5egjFClyUJEN8T+Qm0k0LZGnpOOgOvcVMyj+Qw=;
  b=kgV1PEcXs2f0+48dVaOotX3QY4NCUiRkFpLCgl5W2R0MX92KhibLHcvy
   x6t1VcGw42Ev5T/SpV/AT/112VReCUhqDHRvc55lc0GgcGUYRUxdf6WnP
   q12Jeea8oKvl1Y7qfYKrJUdbiVkq8nVorfA68z4svmV6twJR/V5JpNDjI
   De5/nC2Uqo9wlVEAPV8UQKd7DDlp4Q6m7nBPx1ePVmg7cTo7ZsHMZMaqk
   3vQIYPo8sN/m1hJTUA1F33h5DZY7XmvuYsh5/mfczXuZmW8DfhKMJb1pe
   TWXkVyI+h5X8kCM4vvOW44vCL+UNNTLQwGuwhFTW0kQ3JnkpcGHXiu3aB
   w==;
X-CSE-ConnectionGUID: bEmAw7IbSLep3u0f4mMbHg==
X-CSE-MsgGUID: +pIi+cuBT/W1PneId8I+AA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41956753"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41956753"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 10:14:16 -0800
X-CSE-ConnectionGUID: SNG2KwOKRMGLUOm2Mz7e/Q==
X-CSE-MsgGUID: YT6KS24VT4eq6XvrGqK1aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122862511"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 01 Mar 2025 10:14:15 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toRLo-000GXu-09;
	Sat, 01 Mar 2025 18:14:12 +0000
Date: Sun, 02 Mar 2025 02:13:48 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD REGRESSION
 3a5810be18b2c47e348ca10635500c535e4edd44
Message-ID: <202503020233.g4daJ0CT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 3a5810be18b2c47e348ca10635500c535e4edd44  io.h: drop unused headers

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202503010627.d4L934cN-lkp@intel.com

    ld.lld: error: undefined symbol: __ioread64_hi_lo
    ld.lld: error: undefined symbol: __ioread64_lo_hi
    ld.lld: error: undefined symbol: __ioread64be_hi_lo
    ld.lld: error: undefined symbol: __iowrite64_hi_lo
    ld.lld: error: undefined symbol: __iowrite64_lo_hi
    ld.lld: error: undefined symbol: __iowrite64be_hi_lo

Error/Warning ids grouped by kconfigs:

recent_errors
|-- i386-buildonly-randconfig-003-20250301
|   |-- ld.lld:error:undefined-symbol:__ioread64_hi_lo
|   |-- ld.lld:error:undefined-symbol:__ioread64be_hi_lo
|   |-- ld.lld:error:undefined-symbol:__iowrite64_hi_lo
|   `-- ld.lld:error:undefined-symbol:__iowrite64be_hi_lo
`-- i386-buildonly-randconfig-006-20250301
    |-- ld.lld:error:undefined-symbol:__ioread64_lo_hi
    `-- ld.lld:error:undefined-symbol:__iowrite64_lo_hi

elapsed time: 1447m

configs tested: 88
configs skipped: 1

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250301    gcc-13.2.0
arc                  randconfig-002-20250301    gcc-13.2.0
arm                  randconfig-001-20250301    gcc-14.2.0
arm                  randconfig-002-20250301    gcc-14.2.0
arm                  randconfig-003-20250301    clang-21
arm                  randconfig-004-20250301    clang-21
arm64                randconfig-001-20250301    gcc-14.2.0
arm64                randconfig-002-20250301    clang-21
arm64                randconfig-003-20250301    clang-15
arm64                randconfig-004-20250301    clang-17
csky                 randconfig-001-20250301    gcc-14.2.0
csky                 randconfig-002-20250301    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250301    clang-21
hexagon              randconfig-002-20250301    clang-21
i386                            allmodconfig    clang-19
i386                             allnoconfig    clang-19
i386                            allyesconfig    clang-19
i386       buildonly-randconfig-001-20250301    clang-19
i386       buildonly-randconfig-002-20250301    clang-19
i386       buildonly-randconfig-003-20250301    clang-19
i386       buildonly-randconfig-004-20250301    clang-19
i386       buildonly-randconfig-005-20250301    gcc-12
i386       buildonly-randconfig-006-20250301    clang-19
i386                               defconfig    clang-19
loongarch            randconfig-001-20250301    gcc-14.2.0
loongarch            randconfig-002-20250301    gcc-14.2.0
nios2                randconfig-001-20250301    gcc-14.2.0
nios2                randconfig-002-20250301    gcc-14.2.0
openrisc                         allnoconfig    clang-15
parisc                           allnoconfig    clang-15
parisc               randconfig-001-20250301    gcc-14.2.0
parisc               randconfig-002-20250301    gcc-14.2.0
powerpc                          allnoconfig    clang-15
powerpc              randconfig-001-20250301    clang-17
powerpc              randconfig-002-20250301    clang-19
powerpc              randconfig-003-20250301    clang-21
powerpc64            randconfig-001-20250301    gcc-14.2.0
powerpc64            randconfig-002-20250301    clang-21
powerpc64            randconfig-003-20250301    gcc-14.2.0
riscv                            allnoconfig    clang-15
riscv                randconfig-001-20250301    gcc-14.2.0
riscv                randconfig-002-20250301    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-15
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250301    clang-15
s390                 randconfig-002-20250301    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250301    gcc-14.2.0
sh                   randconfig-002-20250301    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250301    gcc-14.2.0
sparc                randconfig-002-20250301    gcc-14.2.0
sparc64              randconfig-001-20250301    gcc-14.2.0
sparc64              randconfig-002-20250301    gcc-14.2.0
um                              allmodconfig    clang-21
um                               allnoconfig    clang-15
um                              allyesconfig    gcc-12
um                   randconfig-001-20250301    gcc-12
um                   randconfig-002-20250301    gcc-12
x86_64                           allnoconfig    clang-19
x86_64                          allyesconfig    clang-19
x86_64     buildonly-randconfig-001-20250301    clang-19
x86_64     buildonly-randconfig-001-20250302    gcc-12
x86_64     buildonly-randconfig-002-20250301    clang-19
x86_64     buildonly-randconfig-002-20250302    gcc-12
x86_64     buildonly-randconfig-003-20250301    gcc-11
x86_64     buildonly-randconfig-003-20250302    gcc-12
x86_64     buildonly-randconfig-004-20250301    gcc-12
x86_64     buildonly-randconfig-004-20250302    gcc-12
x86_64     buildonly-randconfig-005-20250301    gcc-12
x86_64     buildonly-randconfig-005-20250302    gcc-12
x86_64     buildonly-randconfig-006-20250301    clang-19
x86_64     buildonly-randconfig-006-20250302    gcc-12
x86_64                             defconfig    clang-19
x86_64                                 kexec    clang-19
x86_64                              rhel-9.4    clang-19
x86_64                          rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-func    clang-19
x86_64                        rhel-9.4-kunit    clang-18
x86_64                          rhel-9.4-ltp    clang-18
x86_64                         rhel-9.4-rust    clang-18
xtensa               randconfig-001-20250301    gcc-14.2.0
xtensa               randconfig-002-20250301    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

