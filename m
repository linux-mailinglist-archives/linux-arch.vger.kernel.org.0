Return-Path: <linux-arch+bounces-4229-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 694D18BD932
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 03:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC571F21B08
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 01:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0A5139F;
	Tue,  7 May 2024 01:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/1uLFWV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EE523BB
	for <linux-arch@vger.kernel.org>; Tue,  7 May 2024 01:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715047037; cv=none; b=KvEu8rwIypzehb6dy6l4rDrOcg/k3J9CQg3u2tvFrrOiaYPsrlZFKV8PDtOoqcdB7fLmLlwaIxV00otB3kzQfZdWOLWPYj3UO4/RPz8MlfolrSEfo7UzjJDfSOmRH0DxVniWUvc1ymUaDLjz3BjqIww2r9T0qhUVc1+1fy4Asw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715047037; c=relaxed/simple;
	bh=qnjutTkJ4uTC9YCfEGGaRlw2zJ8sV8Eq3wyzEpbprZo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=M8oBnNmdoPYPbZ3IEIY2QtTzW6YQrv6/8NZpoOI96mGbMv2RdKrRVKAXeLKn7Lcxq1QmF7IsK+vOrEjnV1esLzacYc1OvUoVvDmpXH0OqeerqQz9E2BjYxqYknqoawDA/LcdiVkjf1WLIqaxhc+L/S3i5C4i0suDd4Dn4LCuZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X/1uLFWV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715047035; x=1746583035;
  h=date:from:to:cc:subject:message-id;
  bh=qnjutTkJ4uTC9YCfEGGaRlw2zJ8sV8Eq3wyzEpbprZo=;
  b=X/1uLFWV9vz5G7oEHeU29iWyBDe8rlXS1pp7+gtRFBZst9nZHrGpDnb5
   SbzGc/vwDx/0bgN7UOAXzcoruK2xqB0csDTDLsVz2lyLsBXNA9cdVPxwC
   Ai47t+lCsHCs7bMLUR9jI02sA2FPYRnsrWQxusfZkxmFMbvZUtsb6M+AE
   l1V5zyVY8epJSfIJzIjzNCHtSX3Cycjvf6LicXm7vVAFE9rbAqF6FOKZm
   ljj3YIczcf6Ke90tJuT97vVFMa4wSg3PDZ1/zTRxFR6nEjlryw8GlM0nv
   3FKn+WfZzjeH6DXOgnUhZ1fc/TmgkPQ0F59B3kmscfHRpGATK3omRYe/E
   w==;
X-CSE-ConnectionGUID: 2mdUFY85SaSDTKS61b1lzQ==
X-CSE-MsgGUID: VJjxxcU/RSWi85aDvpJPIg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="28292595"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="28292595"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 18:57:14 -0700
X-CSE-ConnectionGUID: FkkHXuHEQA+UvWcbgWM8Lw==
X-CSE-MsgGUID: y+KSWPlmTveix2Y1BAK9Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="28335873"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 06 May 2024 18:57:13 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4A4s-0001DW-2P;
	Tue, 07 May 2024 01:57:10 +0000
Date: Tue, 07 May 2024 09:56:29 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:alpha-cleanup-6.9] BUILD SUCCESS
 a4184174be36369c3af8d937e165f28a43ef1e02
Message-ID: <202405070927.fMJTOxSp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git alpha-cleanup-6.9
branch HEAD: a4184174be36369c3af8d937e165f28a43ef1e02  alpha: drop pre-EV56 support

elapsed time: 933m

configs tested: 180
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240507   gcc  
arc                   randconfig-002-20240507   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                       imx_v6_v7_defconfig   clang
arm                          moxart_defconfig   gcc  
arm                             mxs_defconfig   clang
arm                        neponset_defconfig   gcc  
arm                   randconfig-001-20240507   gcc  
arm                   randconfig-002-20240507   clang
arm                   randconfig-003-20240507   gcc  
arm                   randconfig-004-20240507   clang
arm                             rpc_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240507   clang
arm64                 randconfig-002-20240507   clang
arm64                 randconfig-003-20240507   clang
arm64                 randconfig-004-20240507   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240507   gcc  
csky                  randconfig-002-20240507   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240507   clang
hexagon               randconfig-002-20240507   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240506   gcc  
i386         buildonly-randconfig-002-20240506   clang
i386         buildonly-randconfig-003-20240506   gcc  
i386         buildonly-randconfig-004-20240506   gcc  
i386         buildonly-randconfig-005-20240506   gcc  
i386         buildonly-randconfig-006-20240506   clang
i386                                defconfig   clang
i386                  randconfig-001-20240506   gcc  
i386                  randconfig-002-20240506   clang
i386                  randconfig-003-20240506   gcc  
i386                  randconfig-004-20240506   clang
i386                  randconfig-005-20240506   clang
i386                  randconfig-006-20240506   gcc  
i386                  randconfig-011-20240506   gcc  
i386                  randconfig-012-20240506   gcc  
i386                  randconfig-013-20240506   gcc  
i386                  randconfig-014-20240506   clang
i386                  randconfig-015-20240506   clang
i386                  randconfig-016-20240506   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240507   gcc  
loongarch             randconfig-002-20240507   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240507   gcc  
nios2                 randconfig-002-20240507   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240507   gcc  
parisc                randconfig-002-20240507   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       maple_defconfig   clang
powerpc               randconfig-001-20240507   gcc  
powerpc               randconfig-002-20240507   clang
powerpc               randconfig-003-20240507   clang
powerpc                     tqm8555_defconfig   clang
powerpc64             randconfig-001-20240507   gcc  
powerpc64             randconfig-002-20240507   gcc  
powerpc64             randconfig-003-20240507   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                    nommu_k210_defconfig   clang
riscv                 randconfig-001-20240507   clang
riscv                 randconfig-002-20240507   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240507   gcc  
s390                  randconfig-002-20240507   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                    randconfig-001-20240507   gcc  
sh                    randconfig-002-20240507   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240507   gcc  
sparc64               randconfig-002-20240507   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240507   gcc  
um                    randconfig-002-20240507   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240506   gcc  
x86_64       buildonly-randconfig-002-20240506   gcc  
x86_64       buildonly-randconfig-003-20240506   gcc  
x86_64       buildonly-randconfig-004-20240506   clang
x86_64       buildonly-randconfig-005-20240506   clang
x86_64       buildonly-randconfig-006-20240506   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240506   clang
x86_64                randconfig-002-20240506   clang
x86_64                randconfig-003-20240506   clang
x86_64                randconfig-004-20240506   clang
x86_64                randconfig-005-20240506   clang
x86_64                randconfig-006-20240506   clang
x86_64                randconfig-011-20240506   gcc  
x86_64                randconfig-012-20240506   gcc  
x86_64                randconfig-013-20240506   gcc  
x86_64                randconfig-014-20240506   gcc  
x86_64                randconfig-015-20240506   gcc  
x86_64                randconfig-016-20240506   gcc  
x86_64                randconfig-071-20240506   gcc  
x86_64                randconfig-072-20240506   clang
x86_64                randconfig-073-20240506   gcc  
x86_64                randconfig-074-20240506   clang
x86_64                randconfig-075-20240506   gcc  
x86_64                randconfig-076-20240506   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240507   gcc  
xtensa                randconfig-002-20240507   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

