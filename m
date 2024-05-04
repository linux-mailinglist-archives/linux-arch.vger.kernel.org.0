Return-Path: <linux-arch+bounces-4175-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC3E8BBE29
	for <lists+linux-arch@lfdr.de>; Sat,  4 May 2024 23:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B2ADB2136B
	for <lists+linux-arch@lfdr.de>; Sat,  4 May 2024 21:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6BA60BB6;
	Sat,  4 May 2024 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aQCsiKKx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EA283CD3
	for <linux-arch@vger.kernel.org>; Sat,  4 May 2024 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714857295; cv=none; b=VPqYb4KPu9OQ9OvHANVDdBCV87h6iwE3PH5UVoY+lNC7ho3SWEgdGWjfrH7SIkaJOXLda5mkGmbhwjGeRNLGgiNH8Y7CuYGIT/qka52EXAZLHxMvutlFg2s6bzesAvAnVfiZysIh9ZTBb5+IZVMEN/cdG0KmpvkesgvKlUFNK0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714857295; c=relaxed/simple;
	bh=ZXYQV0gzcrJpQ15YDiGJ1MyKjsi0zNI9KdYBg2dRnXo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UcN0Ivz320b5H75Sr7ZGKHoILN55ZE37HpxtWlKQQ8oTWfMuhpK3y+puqoxAmx6j8JS/h6RqzfpR+z82EREF+bhodJNEVtwUrtawIlEIpW1dj7rizPGzaD3iidDpVfO0tZjb6l04JmOcb68WFSNtuf21e+I63qh0vAeSryXuE+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aQCsiKKx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714857293; x=1746393293;
  h=date:from:to:cc:subject:message-id;
  bh=ZXYQV0gzcrJpQ15YDiGJ1MyKjsi0zNI9KdYBg2dRnXo=;
  b=aQCsiKKx9H3lOXh6qbyZB2aHNtTpUbrYunGgFgfbcHLUCci1jGwmtjN3
   V2bQY415n5YjCxZseisvgAj1f9aCwPlS3d7ERKhLzkyTWzIZvsZZMU2Eq
   7Wk5WT1w/wqoaTn2hyKODRQ5uZOYc0/+4EAWRszaOYhL8rUoynAkeyYFb
   MLGV0PjHcaAcokhS3zc8Etzt7HyR02x7CWaSSQcZtTAwWHb2oP85+f491
   +GW8ejkmKVYQxCSN2NJJtjN+lW5XgHYhgBrmI3t78jgG9XvIf2iWOxkad
   0Qd1El4ralci1WwlEDSKPBkPcNurbMlfgQqAKT6pGWlX6maaSeneqi8sk
   Q==;
X-CSE-ConnectionGUID: hPf7LT17TKSeS1nRP4O3yA==
X-CSE-MsgGUID: lul8Qzp0TRmHNjehz3Pefw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="28116531"
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="28116531"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 14:14:51 -0700
X-CSE-ConnectionGUID: O+bFBdqyTLSCdl7SUawJMA==
X-CSE-MsgGUID: HNywh9EEQWGwdqaVbGpOHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="32460557"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 04 May 2024 14:14:50 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s3MiV-000DBq-0C;
	Sat, 04 May 2024 21:14:47 +0000
Date: Sun, 05 May 2024 05:14:25 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 8823fff36eb50cd8df61add9572562fc92c72ada
Message-ID: <202405050523.o6x7pAhc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 8823fff36eb50cd8df61add9572562fc92c72ada  Merge branch 'alpha-cleanup-6.9' into asm-generic

elapsed time: 1456m

configs tested: 168
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
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240504   gcc  
arc                   randconfig-002-20240504   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240504   gcc  
arm64                 randconfig-002-20240504   gcc  
arm64                 randconfig-003-20240504   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240504   gcc  
csky                  randconfig-002-20240504   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240504   clang
i386         buildonly-randconfig-004-20240504   clang
i386         buildonly-randconfig-004-20240505   gcc  
i386         buildonly-randconfig-005-20240504   clang
i386         buildonly-randconfig-006-20240504   clang
i386                                defconfig   clang
i386                  randconfig-002-20240504   clang
i386                  randconfig-003-20240505   gcc  
i386                  randconfig-004-20240504   clang
i386                  randconfig-005-20240504   clang
i386                  randconfig-005-20240505   gcc  
i386                  randconfig-006-20240505   gcc  
i386                  randconfig-011-20240505   gcc  
i386                  randconfig-012-20240504   clang
i386                  randconfig-012-20240505   gcc  
i386                  randconfig-013-20240504   clang
i386                  randconfig-014-20240505   gcc  
i386                  randconfig-015-20240505   gcc  
i386                  randconfig-016-20240504   clang
i386                  randconfig-016-20240505   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240504   gcc  
loongarch             randconfig-002-20240504   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       lemote2f_defconfig   gcc  
mips                      malta_kvm_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240504   gcc  
nios2                 randconfig-002-20240504   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240504   gcc  
parisc                randconfig-002-20240504   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20240504   gcc  
powerpc               randconfig-002-20240504   gcc  
powerpc               randconfig-003-20240504   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                  storcenter_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240504   gcc  
riscv                 randconfig-002-20240504   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-002-20240504   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20240504   gcc  
sh                    randconfig-002-20240504   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240504   gcc  
sparc64               randconfig-002-20240504   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240504   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240504   gcc  
x86_64       buildonly-randconfig-003-20240504   gcc  
x86_64       buildonly-randconfig-004-20240504   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-005-20240504   gcc  
x86_64                randconfig-011-20240504   gcc  
x86_64                randconfig-013-20240504   gcc  
x86_64                randconfig-015-20240504   gcc  
x86_64                randconfig-071-20240504   gcc  
x86_64                randconfig-073-20240504   gcc  
x86_64                randconfig-074-20240504   gcc  
x86_64                randconfig-076-20240504   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20240504   gcc  
xtensa                randconfig-002-20240504   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

