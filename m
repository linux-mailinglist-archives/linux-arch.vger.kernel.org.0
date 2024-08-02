Return-Path: <linux-arch+bounces-5940-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA94194607C
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 17:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DC4285256
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDA2175D2B;
	Fri,  2 Aug 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OFVHz+6Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B54175D26
	for <linux-arch@vger.kernel.org>; Fri,  2 Aug 2024 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722612355; cv=none; b=VYqBu8u2b/bHDE7EaBDPV14K699MqYwnTurP6qjhYvbPOvIP45IkiI/KrYHYMfCFTElu6OLMIqX7Ss+sNgMhFRfKuKFXBkNgWpgc9tP+V/LFdUl8YeilFHyeHl/R0OyCL5vSj9FeQc6wanyJ2IljF1cYR/qW0LQbl22Gml3z/s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722612355; c=relaxed/simple;
	bh=WSOTIx4Jrwk3std3dZaySoR3yMDWu9BgAP/CCkWiiZE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EYmoLqFZvtD6XiGhbshVWU1EOTmaXSqGCE+Tg42YQwDi1BIWIDtuWDaxfY90EPG2gUa238wDEOZARHJehVAb9HcpEAExEQF8V82jep+UOpAcaIg9YavmospPbLUZburq8ZpEvr+cbQAtgfP86u6s033ogKnZilkd6M6Vl+nQ/GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OFVHz+6Y; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722612353; x=1754148353;
  h=date:from:to:cc:subject:message-id;
  bh=WSOTIx4Jrwk3std3dZaySoR3yMDWu9BgAP/CCkWiiZE=;
  b=OFVHz+6YUbrKDzyN63yKvaUPgKt5KKdEpFgMslzc97jJ6UFEHB0Pc5vl
   I9D5VDNfREWpoODPEWJB2gTKFqkLsTuzUMhr1P3SOt1s3AyclATqZ5UGF
   vcyv/HDvZpPCmactYqvCQHzh8eOAiSxl2IaFhaAgk0XBcV301nIk4CTCZ
   JChXkQeLpfhdSXgnyb5nxAHUQKk6X8WEnxbxuRMLhMaOUfQyRUFRoV4x8
   sR/wNftrrinqmaj9LfRduk0TGtnKgwMQ4YwpQcKaGVDUDHMrnxs/wtgq/
   xebk7qIwLcdka7QUBzytK1g0z9SdV0rQ6y5ktFkYMWQiGPGIW+r1WirbF
   Q==;
X-CSE-ConnectionGUID: 7RExMNizRNiR/FRTZh+2Sw==
X-CSE-MsgGUID: j09kOKJpSMS19FWhpVx7Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="12850156"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="12850156"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 08:25:52 -0700
X-CSE-ConnectionGUID: hbu9id1fRfKGwSv58gRg/Q==
X-CSE-MsgGUID: 3uF6/sD9TeK+hfgkvscM7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="60051255"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 02 Aug 2024 08:25:53 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZuA9-000wxl-0N;
	Fri, 02 Aug 2024 15:25:49 +0000
Date: Fri, 02 Aug 2024 23:25:21 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 a73df08ebb5a402fbcecaecbd633926ca3f63aba
Message-ID: <202408022319.EeRcKpxN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: a73df08ebb5a402fbcecaecbd633926ca3f63aba  syscalls: fix syscall macros for newfstat/newfstatat

elapsed time: 1475m

configs tested: 205
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-13.2.0
arc                   randconfig-001-20240802   gcc-13.2.0
arc                   randconfig-002-20240802   gcc-13.2.0
arc                        vdk_hs38_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                       aspeed_g5_defconfig   gcc-14.1.0
arm                        clps711x_defconfig   gcc-13.2.0
arm                     davinci_all_defconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                          ep93xx_defconfig   gcc-14.1.0
arm                          exynos_defconfig   gcc-13.2.0
arm                      integrator_defconfig   gcc-13.2.0
arm                          ixp4xx_defconfig   clang-20
arm                      jornada720_defconfig   gcc-14.1.0
arm                        mvebu_v7_defconfig   gcc-13.2.0
arm                   randconfig-001-20240802   gcc-13.2.0
arm                   randconfig-002-20240802   gcc-13.2.0
arm                   randconfig-003-20240802   gcc-13.2.0
arm                   randconfig-004-20240802   gcc-13.2.0
arm                             rpc_defconfig   gcc-13.2.0
arm                         s3c6400_defconfig   gcc-13.2.0
arm                        shmobile_defconfig   gcc-14.1.0
arm                           sunxi_defconfig   gcc-13.2.0
arm                    vt8500_v6_v7_defconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240802   gcc-13.2.0
arm64                 randconfig-002-20240802   gcc-13.2.0
arm64                 randconfig-003-20240802   gcc-13.2.0
arm64                 randconfig-004-20240802   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240802   gcc-13.2.0
csky                  randconfig-002-20240802   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240802   gcc-13
i386         buildonly-randconfig-002-20240802   gcc-13
i386         buildonly-randconfig-003-20240802   gcc-13
i386         buildonly-randconfig-004-20240802   gcc-13
i386         buildonly-randconfig-005-20240802   gcc-13
i386         buildonly-randconfig-006-20240802   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240802   gcc-13
i386                  randconfig-002-20240802   gcc-13
i386                  randconfig-003-20240802   gcc-13
i386                  randconfig-004-20240802   gcc-13
i386                  randconfig-005-20240802   gcc-13
i386                  randconfig-006-20240802   gcc-13
i386                  randconfig-011-20240802   gcc-13
i386                  randconfig-012-20240802   gcc-13
i386                  randconfig-013-20240802   gcc-13
i386                  randconfig-014-20240802   gcc-13
i386                  randconfig-015-20240802   gcc-13
i386                  randconfig-016-20240802   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240802   gcc-13.2.0
loongarch             randconfig-002-20240802   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                           virt_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
microblaze                      mmu_defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                        bcm63xx_defconfig   gcc-13.2.0
mips                          eyeq5_defconfig   gcc-14.1.0
mips                           ip30_defconfig   gcc-13.2.0
mips                           jazz_defconfig   gcc-14.1.0
mips                     loongson2k_defconfig   gcc-14.1.0
mips                malta_qemu_32r6_defconfig   gcc-13.2.0
mips                      maltasmvp_defconfig   gcc-13.2.0
mips                  maltasmvp_eva_defconfig   gcc-14.1.0
mips                          rb532_defconfig   clang-20
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240802   gcc-13.2.0
nios2                 randconfig-002-20240802   gcc-13.2.0
openrisc                         alldefconfig   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                generic-64bit_defconfig   gcc-13.2.0
parisc                randconfig-001-20240802   gcc-13.2.0
parisc                randconfig-002-20240802   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                   bluestone_defconfig   clang-20
powerpc                        icon_defconfig   gcc-14.1.0
powerpc                  iss476-smp_defconfig   clang-20
powerpc                 linkstation_defconfig   clang-20
powerpc                   lite5200b_defconfig   clang-20
powerpc                       maple_defconfig   gcc-13.2.0
powerpc                   microwatt_defconfig   clang-20
powerpc                   microwatt_defconfig   gcc-13.2.0
powerpc                    mvme5100_defconfig   clang-20
powerpc                     rainier_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240802   gcc-13.2.0
powerpc               randconfig-003-20240802   gcc-13.2.0
powerpc                    sam440ep_defconfig   gcc-14.1.0
powerpc                     sequoia_defconfig   gcc-13.2.0
powerpc                     tqm8540_defconfig   gcc-14.1.0
powerpc                         wii_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240802   gcc-13.2.0
powerpc64             randconfig-002-20240802   gcc-13.2.0
powerpc64             randconfig-003-20240802   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                    nommu_virt_defconfig   gcc-14.1.0
riscv                 randconfig-001-20240802   gcc-13.2.0
riscv                 randconfig-002-20240802   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240802   gcc-13.2.0
s390                  randconfig-002-20240802   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                        edosk7760_defconfig   gcc-13.2.0
sh                          r7785rp_defconfig   gcc-14.1.0
sh                    randconfig-001-20240802   gcc-13.2.0
sh                    randconfig-002-20240802   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                          sdk7786_defconfig   gcc-13.2.0
sh                             sh03_defconfig   gcc-13.2.0
sh                   sh7770_generic_defconfig   gcc-13.2.0
sh                            titan_defconfig   gcc-13.2.0
sh                          urquell_defconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240802   gcc-13.2.0
sparc64               randconfig-002-20240802   gcc-13.2.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240802   gcc-13.2.0
um                    randconfig-002-20240802   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240802   gcc-8
x86_64       buildonly-randconfig-002-20240802   gcc-8
x86_64       buildonly-randconfig-003-20240802   gcc-8
x86_64       buildonly-randconfig-004-20240802   gcc-8
x86_64       buildonly-randconfig-005-20240802   gcc-8
x86_64       buildonly-randconfig-006-20240802   gcc-8
x86_64                              defconfig   clang-18
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240802   gcc-8
x86_64                randconfig-002-20240802   gcc-8
x86_64                randconfig-003-20240802   gcc-8
x86_64                randconfig-004-20240802   gcc-8
x86_64                randconfig-005-20240802   gcc-8
x86_64                randconfig-006-20240802   gcc-8
x86_64                randconfig-011-20240802   gcc-8
x86_64                randconfig-012-20240802   gcc-8
x86_64                randconfig-013-20240802   gcc-8
x86_64                randconfig-014-20240802   gcc-8
x86_64                randconfig-015-20240802   gcc-8
x86_64                randconfig-016-20240802   gcc-8
x86_64                randconfig-071-20240802   gcc-8
x86_64                randconfig-072-20240802   gcc-8
x86_64                randconfig-073-20240802   gcc-8
x86_64                randconfig-074-20240802   gcc-8
x86_64                randconfig-075-20240802   gcc-8
x86_64                randconfig-076-20240802   gcc-8
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  audio_kc705_defconfig   gcc-13.2.0
xtensa                       common_defconfig   gcc-13.2.0
xtensa                          iss_defconfig   gcc-14.1.0
xtensa                  nommu_kc705_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240802   gcc-13.2.0
xtensa                randconfig-002-20240802   gcc-13.2.0
xtensa                         virt_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

