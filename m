Return-Path: <linux-arch+bounces-8731-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8543C9B6AB3
	for <lists+linux-arch@lfdr.de>; Wed, 30 Oct 2024 18:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B2F1C212ED
	for <lists+linux-arch@lfdr.de>; Wed, 30 Oct 2024 17:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700871BD9C3;
	Wed, 30 Oct 2024 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MHsDD8Up"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DF32194B4
	for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2024 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308169; cv=none; b=e3Luzcqeal+Bf9OAZcFb1Dp5L47dw6YaJmh/MRdSd2cLVHB/jK7j4jmNGEqfaGDfhMrF20mkXJB8lb16bf7LvrqHkptJvx2FDjVlAhje/T+pQ76LrkUoz9NzOUGLmg5WPIZF738iXRmpHiqkQQsO2XPF9y7lX+e6VXEhLehdtEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308169; c=relaxed/simple;
	bh=nx7aMt9MSqzasNgvf0DIwg0+3eLt2zTTLr3Rk/nvCPk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DTjcFinhr6oGSQnScwLMa2mLSHAe+ioTBc31q+JnaMwOqqUAaOOlMunVqLYUrts0kyFwYWdk3BO3uMNEWj14JFQOloKyEHv/BiHIvG/5R43dYAEUZbPxaRTgkLVR/EJoLO1ZJrbKRM0qopmpjiJoP7hVfOl8xri43qPqMoQxVq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MHsDD8Up; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730308166; x=1761844166;
  h=date:from:to:cc:subject:message-id;
  bh=nx7aMt9MSqzasNgvf0DIwg0+3eLt2zTTLr3Rk/nvCPk=;
  b=MHsDD8UptBdGh/SQhHj1ixSuegAJiMZYxS0y8MybXIRTJNCJm8HPQODw
   gkFDK+vpT+GnwvgX5utwP0ssTkl3d31KdM2TwXITLfJ7ABoGCRASwHMYG
   kuU+zNhUzXvLMsaK6LgMxho9X5m2kDQGAClhZP2bnQ9tPRW4GaGXzNkVQ
   vZVp2OhBLGiWZKXA8NOW0wlROEKOzImr8giqpNm/teXzHRGGfc20ZzUgY
   CRsw30DOn4lpoGHe0epPti3sfTpskdGlF6zCugp0O2IpmFA3JjgSZ3uLG
   JUsfDq2NMfLGsVYeq9KMcKC+ZULZymQr5WTfhTo46MlDuMsFjCoQbW/pw
   g==;
X-CSE-ConnectionGUID: y8hyiOLWQL2H3rFPc9RnFA==
X-CSE-MsgGUID: 7tHHGUqCRPi9rktP+iOsFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47485258"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47485258"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 10:09:25 -0700
X-CSE-ConnectionGUID: oEZKr/zUSkqkyxiQN3efHA==
X-CSE-MsgGUID: 0vVhAs0HSGm5Wa3Y7hJhDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="81926555"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 30 Oct 2024 10:09:24 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6CCA-000f7A-0d;
	Wed, 30 Oct 2024 17:09:22 +0000
Date: Thu, 31 Oct 2024 01:08:39 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 c0dc92144ba181cf7ba366a87909bbaa93d5b713
Message-ID: <202410310122.eLXe1hGW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: c0dc92144ba181cf7ba366a87909bbaa93d5b713  tty: serial: export serial_8250_warn_need_ioport

Unverified Warning (likely false positive, kindly check if interested):

    drivers/tty/serial/8250/8250_port.c:1333 autoconfig_irq() warn: bitwise AND condition is false here
    drivers/tty/serial/8250/8250_port.c:2375 serial8250_do_startup() warn: bitwise AND condition is false here
    drivers/tty/serial/8250/8250_port.c:2502 serial8250_do_shutdown() warn: bitwise AND condition is false here

Warning ids grouped by kconfigs:

recent_errors
|-- csky-randconfig-r072-20241030
|   |-- drivers-tty-serial-8250_port.c-autoconfig_irq()-warn:bitwise-AND-condition-is-false-here
|   |-- drivers-tty-serial-8250_port.c-serial8250_do_shutdown()-warn:bitwise-AND-condition-is-false-here
|   `-- drivers-tty-serial-8250_port.c-serial8250_do_startup()-warn:bitwise-AND-condition-is-false-here
`-- nios2-randconfig-r131-20241029
    `-- lib-iomem_copy.c:sparse:sparse:cast-removes-address-space-__iomem-of-expression

elapsed time: 1410m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    gcc-13.3.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                         haps_hs_defconfig    clang-20
arc                     nsimosci_hs_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                     am200epdkit_defconfig    clang-20
arm                         bcm2835_defconfig    clang-20
arm                          collie_defconfig    clang-20
arm                      jornada720_defconfig    clang-20
arm                       netwinder_defconfig    clang-20
arm                             rpc_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241030    gcc-12
i386        buildonly-randconfig-002-20241030    gcc-12
i386        buildonly-randconfig-003-20241030    gcc-12
i386        buildonly-randconfig-004-20241030    gcc-12
i386        buildonly-randconfig-005-20241030    gcc-12
i386        buildonly-randconfig-006-20241030    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241030    gcc-12
i386                  randconfig-002-20241030    gcc-12
i386                  randconfig-003-20241030    gcc-12
i386                  randconfig-004-20241030    gcc-12
i386                  randconfig-005-20241030    gcc-12
i386                  randconfig-006-20241030    gcc-12
i386                  randconfig-011-20241030    gcc-12
i386                  randconfig-012-20241030    gcc-12
i386                  randconfig-013-20241030    gcc-12
i386                  randconfig-014-20241030    gcc-12
i386                  randconfig-015-20241030    gcc-12
i386                  randconfig-016-20241030    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
m68k                             alldefconfig    clang-20
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          amiga_defconfig    clang-20
m68k                       m5475evb_defconfig    clang-20
m68k                        mvme16x_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                         db1xxx_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    clang-20
powerpc                     kmeter1_defconfig    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    clang-20
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241030    gcc-12
x86_64      buildonly-randconfig-002-20241030    gcc-12
x86_64      buildonly-randconfig-003-20241030    gcc-12
x86_64      buildonly-randconfig-004-20241030    gcc-12
x86_64      buildonly-randconfig-005-20241030    gcc-12
x86_64      buildonly-randconfig-006-20241030    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241030    gcc-12
x86_64                randconfig-002-20241030    gcc-12
x86_64                randconfig-003-20241030    gcc-12
x86_64                randconfig-004-20241030    gcc-12
x86_64                randconfig-005-20241030    gcc-12
x86_64                randconfig-006-20241030    gcc-12
x86_64                randconfig-011-20241030    gcc-12
x86_64                randconfig-012-20241030    gcc-12
x86_64                randconfig-013-20241030    gcc-12
x86_64                randconfig-014-20241030    gcc-12
x86_64                randconfig-015-20241030    gcc-12
x86_64                randconfig-016-20241030    gcc-12
x86_64                randconfig-071-20241030    gcc-12
x86_64                randconfig-072-20241030    gcc-12
x86_64                randconfig-073-20241030    gcc-12
x86_64                randconfig-074-20241030    gcc-12
x86_64                randconfig-075-20241030    gcc-12
x86_64                randconfig-076-20241030    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                    rhel-8.3-kselftests    gcc-12
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

