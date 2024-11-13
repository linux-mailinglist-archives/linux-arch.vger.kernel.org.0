Return-Path: <linux-arch+bounces-9048-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E115E9C676F
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 03:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4F41B239ED
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 02:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B63E481C4;
	Wed, 13 Nov 2024 02:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7MspyFC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E01517C
	for <linux-arch@vger.kernel.org>; Wed, 13 Nov 2024 02:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731465975; cv=none; b=ucVlZWJ0Lqetmzo788+7+zjiabpRDUF6b8/42w6F3su85F+hG7tb3ezEFZ2U8mSGbTKlCaRldAImt0tjQkV18d/hSdg/hw1g0Xa9pTIW+rg/fC96Dba5OVfnWB1A1GYKJQegZaMyK8BWlOmc7RfphPcjzLfvkj8ERw5T/unchug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731465975; c=relaxed/simple;
	bh=QlSY8hSjpQwelxlD0tuClM/F9Xa+ewfX+ZEWeIoSjFE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JgQ6bOxP0Jul3G6F2+IEHdxShvACV1l4ylSzFd/jQz3lhWSFICyWSFKToRKN1EOHGjj3YfZ0+kcHu4UY15x9hj4wCXXx4GIo6/PlIUXJBRBSWn3KS8A1g8FoJwM/wb82ya9sIz1u+5lf8RnEiVAZpzYLlvLeu8z+ozdbmS7qeYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7MspyFC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731465974; x=1763001974;
  h=date:from:to:cc:subject:message-id;
  bh=QlSY8hSjpQwelxlD0tuClM/F9Xa+ewfX+ZEWeIoSjFE=;
  b=h7MspyFC5dBGQymyjgQw/wQWm4rvYG5EoUjLhRCUiOoO24yujuXX5asO
   hAVgEyt7WHZSwvTw32/I14pqsQr4KOQGoCq9t3CgQcBv7ez77zkSS/FDu
   4gPfxYmTJbFRIQ7l2bIBwZcK8ElnoFC4isfwsDwYes7pgOOe1fI0KOukR
   oAlp2EyRUDxbcX/CL3qq7Iyo6zad+bl0dXHo2KUmn07rgASGBRZ7ZhWSR
   NGk3QUa7UtILu8aHYsS/oP70KFNhvbvBYNGGnnqHDr/nknWwSEMg2o9Sy
   SAo2o3LkTOso+XYPvMcbjF2tdwfYr0Sy3Tp8UO8Yr2GuVZocLxtGDCMyR
   w==;
X-CSE-ConnectionGUID: csJjMwVvQ/2CnzE1jc/qow==
X-CSE-MsgGUID: cwSNy97RTfm1PrNkBS0BkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="41961044"
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="41961044"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 18:46:13 -0800
X-CSE-ConnectionGUID: ABfuwlzxR8mKFXcXcdicdA==
X-CSE-MsgGUID: 67WEDwBVQF22b7rXACMbhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="125243391"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 12 Nov 2024 18:46:12 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tB3OT-0001xB-1U;
	Wed, 13 Nov 2024 02:46:09 +0000
Date: Wed, 13 Nov 2024 10:45:25 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 0af8e32343f8d0db31f593464fc140eaef25a281
Message-ID: <202411131020.y0bfWPOs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 0af8e32343f8d0db31f593464fc140eaef25a281  empty include/asm-generic/vga.h

elapsed time: 725m

configs tested: 105
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                       allnoconfig    gcc-14.2.0
alpha                      allyesconfig    clang-20
alpha                      allyesconfig    gcc-14.2.0
arc                        allmodconfig    clang-20
arc                         allnoconfig    gcc-14.2.0
arc                        allyesconfig    clang-20
arc                      hsdk_defconfig    gcc-14.2.0
arm                        allmodconfig    clang-20
arm                         allnoconfig    gcc-14.2.0
arm                        allyesconfig    clang-20
arm                   at91_dt_defconfig    clang-20
arm               davinci_all_defconfig    gcc-14.2.0
arm                integrator_defconfig    clang-20
arm                  keystone_defconfig    gcc-14.2.0
arm                  mvebu_v5_defconfig    gcc-14.2.0
arm                 netwinder_defconfig    clang-20
arm                      qcom_defconfig    clang-20
arm                  shmobile_defconfig    gcc-14.2.0
arm64                      alldefconfig    gcc-14.2.0
arm64                      allmodconfig    clang-20
arm64                       allnoconfig    gcc-14.2.0
arm64                         defconfig    clang-20
csky                        allnoconfig    gcc-14.2.0
hexagon                    allmodconfig    clang-20
hexagon                     allnoconfig    gcc-14.2.0
hexagon                    allyesconfig    clang-20
i386                       allmodconfig    clang-19
i386                        allnoconfig    clang-19
i386                       allyesconfig    clang-19
i386                          defconfig    clang-19
loongarch                  allmodconfig    gcc-14.2.0
loongarch                   allnoconfig    gcc-14.2.0
m68k                       allmodconfig    gcc-14.2.0
m68k                        allnoconfig    gcc-14.2.0
m68k                       allyesconfig    gcc-14.2.0
m68k                 m5249evb_defconfig    gcc-14.2.0
m68k                 m5475evb_defconfig    clang-20
microblaze                 allmodconfig    gcc-14.2.0
microblaze                  allnoconfig    gcc-14.2.0
microblaze                 allyesconfig    gcc-14.2.0
mips                        allnoconfig    gcc-14.2.0
mips                  qi_lb60_defconfig    gcc-14.2.0
mips                     xway_defconfig    clang-20
nios2                       allnoconfig    gcc-14.2.0
openrisc                    allnoconfig    clang-20
openrisc                   allyesconfig    gcc-14.2.0
openrisc                      defconfig    gcc-12
parisc                     allmodconfig    gcc-14.2.0
parisc                      allnoconfig    clang-20
parisc                     allyesconfig    gcc-14.2.0
parisc                        defconfig    gcc-12
powerpc              adder875_defconfig    clang-20
powerpc                    allmodconfig    gcc-14.2.0
powerpc                     allnoconfig    clang-20
powerpc                    allyesconfig    gcc-14.2.0
powerpc                  cell_defconfig    clang-20
powerpc           linkstation_defconfig    gcc-14.2.0
powerpc               mpc512x_defconfig    gcc-14.2.0
powerpc               mpc5200_defconfig    clang-20
powerpc           mpc836x_rdk_defconfig    clang-20
powerpc            mpc866_ads_defconfig    clang-20
powerpc                pcm030_defconfig    clang-20
powerpc               ppa8548_defconfig    gcc-14.2.0
powerpc               sequoia_defconfig    gcc-14.2.0
powerpc               tqm8555_defconfig    gcc-14.2.0
riscv                      allmodconfig    gcc-14.2.0
riscv                       allnoconfig    clang-20
riscv                      allyesconfig    gcc-14.2.0
riscv                         defconfig    gcc-12
s390                       allmodconfig    clang-20
s390                       allmodconfig    gcc-14.2.0
s390                        allnoconfig    clang-20
s390                       allyesconfig    gcc-14.2.0
s390                          defconfig    gcc-12
sh                         allmodconfig    gcc-14.2.0
sh                          allnoconfig    gcc-14.2.0
sh                         allyesconfig    gcc-14.2.0
sh                   apsh4a3a_defconfig    gcc-14.2.0
sh                            defconfig    gcc-12
sh          ecovec24-romimage_defconfig    clang-20
sh             secureedge5410_defconfig    clang-20
sh               sh7710voipgw_defconfig    gcc-14.2.0
sh             sh7724_generic_defconfig    clang-20
sh                       shx3_defconfig    clang-20
sparc                      allmodconfig    gcc-14.2.0
sparc64                       defconfig    gcc-12
um                         allmodconfig    clang-20
um                          allnoconfig    clang-20
um                         allyesconfig    clang-20
um                         allyesconfig    gcc-12
um                            defconfig    gcc-12
um                       i386_defconfig    gcc-12
um                     x86_64_defconfig    gcc-12
x86_64                      allnoconfig    clang-19
x86_64                     allyesconfig    clang-19
x86_64                        defconfig    clang-19
x86_64                            kexec    clang-19
x86_64                            kexec    gcc-12
x86_64                         rhel-8.3    gcc-12
x86_64                     rhel-8.3-bpf    clang-19
x86_64              rhel-8.3-kselftests    gcc-12
x86_64                   rhel-8.3-kunit    clang-19
x86_64                     rhel-8.3-ltp    clang-19
x86_64                    rhel-8.3-rust    clang-19
xtensa                      allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

