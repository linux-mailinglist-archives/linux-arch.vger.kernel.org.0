Return-Path: <linux-arch+bounces-5368-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA7C92E49A
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2024 12:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3CF1F230D1
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2024 10:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB96158D89;
	Thu, 11 Jul 2024 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M2ElotNd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCAC14D44F
	for <linux-arch@vger.kernel.org>; Thu, 11 Jul 2024 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693523; cv=none; b=Hxz0bbYq9JblWNQK4nKHutyFHb9s9Sql/ETKq1unw53VhrEKVwhQNQviCGiXVmbInmCSA24h4oHpVEgU0jbeQp4m8SI7zqETvZoZ4kU0pCOeaO60yFvS7mLu1Np1puNEvFpdox8uuGAb9s+pR9xyoBoYlZEN7kT8kr27Xw4jQJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693523; c=relaxed/simple;
	bh=sRBoPwkiuJhUOP91kg0Fcgogabfy4b6J75To3dbaPFI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KtYQ7R6VWejhaW3ZHDvhPloX/KdClG2c4IfCXSKree1RhaYPuPRqzXwXFmGJe1vOPiFvLJrXmOz+GHYSXjKyvdz2/qkjtus/rqIbwQhwDpbLFaogHCHyvNvbM1id3bC21rD0w/BxFFHPn9hB8RFg5k0WRISQOhYu4cdeB898SKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M2ElotNd; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720693521; x=1752229521;
  h=date:from:to:cc:subject:message-id;
  bh=sRBoPwkiuJhUOP91kg0Fcgogabfy4b6J75To3dbaPFI=;
  b=M2ElotNdxD5EMiXKJx1VMiIWlt+CuBzAFLSmy8qRKAQs2sW7FRs5Wxsr
   SmazkgXjrS/BDTQsVOscWEUCFQ8RrqVvQA/P6rSeGrKtEdDXsXmrTugyw
   Vk1d+84yGXKHYAH0I8k1BJFEkbZARKHWlgPQ4N8sJNZa+ZEKz1KoIL7li
   HM4dcjRXmwF6k7yaaUSuM3U4AF56FL1N7crULe0l13OCpLLkMYkGIFVld
   MOa6UHi8E2gdlDRpVywXKaOG33OihSx8zuXDnYeApmxKKA/MX0a0YS32D
   XH7QbGgpeZXJ8XVz51l0vD+UNbffepp2sywk17dDzGXkOVKzBrkDzpSB8
   g==;
X-CSE-ConnectionGUID: gAjh+3FYSU26qMz1aS0qcQ==
X-CSE-MsgGUID: 4cX9FgRXRSC80P8pduloDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="35603153"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="35603153"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 03:25:20 -0700
X-CSE-ConnectionGUID: NYvgzwZnTN6Mwys2/PGNiw==
X-CSE-MsgGUID: 0r20wxx8TeuzCxvFbdSDOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="52820629"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 11 Jul 2024 03:25:18 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRqzF-000Z9P-0p;
	Thu, 11 Jul 2024 10:25:17 +0000
Date: Thu, 11 Jul 2024 18:24:23 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 83bb8296556e53e1a69c6de938082028247462db
Message-ID: <202407111821.XEuJtAoH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 83bb8296556e53e1a69c6de938082028247462db  fixmap: Remove unused set_fixmap_offset_io()

elapsed time: 1066m

configs tested: 137
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240711   gcc-13.2.0
arc                   randconfig-002-20240711   gcc-13.2.0
arm                              allmodconfig   gcc-13.3.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-13.3.0
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240711   clang-19
arm                   randconfig-002-20240711   gcc-13.3.0
arm                   randconfig-003-20240711   clang-19
arm                   randconfig-004-20240711   gcc-13.3.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240711   clang-19
arm64                 randconfig-002-20240711   gcc-13.2.0
arm64                 randconfig-003-20240711   gcc-13.2.0
arm64                 randconfig-004-20240711   gcc-13.2.0
csky                              allnoconfig   gcc-13.3.0
csky                  randconfig-001-20240711   gcc-13.3.0
csky                  randconfig-002-20240711   gcc-13.3.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240711   clang-19
hexagon               randconfig-002-20240711   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240711   gcc-13
i386         buildonly-randconfig-002-20240711   gcc-10
i386         buildonly-randconfig-003-20240711   gcc-13
i386         buildonly-randconfig-004-20240711   gcc-8
i386         buildonly-randconfig-005-20240711   gcc-10
i386         buildonly-randconfig-006-20240711   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240711   gcc-13
i386                  randconfig-002-20240711   gcc-10
i386                  randconfig-003-20240711   gcc-8
i386                  randconfig-004-20240711   gcc-13
i386                  randconfig-005-20240711   clang-18
i386                  randconfig-006-20240711   gcc-13
i386                  randconfig-011-20240711   gcc-9
i386                  randconfig-012-20240711   clang-18
i386                  randconfig-013-20240711   gcc-13
i386                  randconfig-014-20240711   clang-18
i386                  randconfig-015-20240711   clang-18
i386                  randconfig-016-20240711   gcc-9
loongarch                        allmodconfig   gcc-13.3.0
loongarch                         allnoconfig   gcc-13.3.0
loongarch             randconfig-001-20240711   gcc-13.3.0
loongarch             randconfig-002-20240711   gcc-13.3.0
m68k                             allmodconfig   gcc-13.3.0
m68k                              allnoconfig   gcc-13.3.0
m68k                             allyesconfig   gcc-13.3.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.3.0
nios2                             allnoconfig   gcc-13.3.0
nios2                 randconfig-001-20240711   gcc-13.3.0
nios2                 randconfig-002-20240711   gcc-13.3.0
openrisc                          allnoconfig   gcc-13.3.0
openrisc                         allyesconfig   gcc-13.3.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-13.3.0
parisc                            allnoconfig   gcc-13.3.0
parisc                           allyesconfig   gcc-13.3.0
parisc                randconfig-001-20240711   gcc-13.3.0
parisc                randconfig-002-20240711   gcc-13.3.0
powerpc                          allmodconfig   gcc-13.3.0
powerpc                           allnoconfig   gcc-13.3.0
powerpc                          allyesconfig   clang-19
powerpc               randconfig-001-20240711   gcc-13.3.0
powerpc               randconfig-002-20240711   clang-19
powerpc               randconfig-003-20240711   clang-19
powerpc64             randconfig-001-20240711   gcc-13.3.0
powerpc64             randconfig-002-20240711   clang-16
powerpc64             randconfig-003-20240711   gcc-13.3.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-13.3.0
riscv                            allyesconfig   clang-19
riscv                 randconfig-001-20240711   clang-14
riscv                 randconfig-002-20240711   gcc-13.3.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                  randconfig-001-20240711   clang-19
s390                  randconfig-002-20240711   gcc-13.2.0
sh                               allmodconfig   gcc-13.3.0
sh                                allnoconfig   gcc-13.3.0
sh                               allyesconfig   gcc-13.3.0
sh                    randconfig-001-20240711   gcc-13.3.0
sh                    randconfig-002-20240711   gcc-13.3.0
sparc                            allmodconfig   gcc-13.3.0
sparc64               randconfig-001-20240711   gcc-13.3.0
sparc64               randconfig-002-20240711   gcc-13.3.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                    randconfig-001-20240711   gcc-8
um                    randconfig-002-20240711   gcc-8
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240711   clang-18
x86_64       buildonly-randconfig-002-20240711   clang-18
x86_64       buildonly-randconfig-003-20240711   clang-18
x86_64       buildonly-randconfig-004-20240711   clang-18
x86_64       buildonly-randconfig-005-20240711   gcc-13
x86_64       buildonly-randconfig-006-20240711   gcc-13
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240711   gcc-13
x86_64                randconfig-002-20240711   gcc-13
x86_64                randconfig-003-20240711   gcc-11
x86_64                randconfig-004-20240711   gcc-9
x86_64                randconfig-005-20240711   clang-18
x86_64                randconfig-006-20240711   gcc-13
x86_64                randconfig-011-20240711   gcc-13
x86_64                randconfig-012-20240711   clang-18
x86_64                randconfig-013-20240711   gcc-13
x86_64                randconfig-014-20240711   clang-18
x86_64                randconfig-015-20240711   clang-18
x86_64                randconfig-016-20240711   gcc-10
x86_64                randconfig-071-20240711   gcc-13
x86_64                randconfig-072-20240711   gcc-13
x86_64                randconfig-073-20240711   clang-18
x86_64                randconfig-074-20240711   gcc-13
x86_64                randconfig-075-20240711   clang-18
x86_64                randconfig-076-20240711   gcc-8
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.3.0
xtensa                randconfig-001-20240711   gcc-13.3.0
xtensa                randconfig-002-20240711   gcc-13.3.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

