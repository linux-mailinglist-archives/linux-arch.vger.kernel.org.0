Return-Path: <linux-arch+bounces-8619-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA9E9B1539
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 07:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5EDEB21CE7
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 05:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BBF2AE69;
	Sat, 26 Oct 2024 05:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="muzuzvwJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BB333EA
	for <linux-arch@vger.kernel.org>; Sat, 26 Oct 2024 05:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729922092; cv=none; b=aG7dHUEDGEZ7PmTptLPkKeCSrgm86W/y8tPOuzSwpd/xXQSe4/V9bVIPHnkS6Z47s7xjKrT+KaYS4xRhHhqa0tD2EPy+xavpjyvuemqFkIE8SjDuv0PZKS23IRYuVbshwOyj3kS/kCXrHW+ZxTcLtHJJn6LIZl49EB2z4275PhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729922092; c=relaxed/simple;
	bh=ff31CZEKkTrgaKSfaZDSJeJ3Aac61l/nkxuzdVj8UVk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=H6Nn5of3sTqG9HJh1OiE/4ucnBnnHebP23kK0C5G4x+HKm23qhN498IP/DWyz3KAGByczEMkmxtrf3sg1wAecexVZ04j/5tjkJTxTT6yN7vTK5u2TjVscmVlODfZJqk4vdzqW4gtsPkdmi15qk01uBg11pvaAsSrsucL4IFUHbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=muzuzvwJ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729922090; x=1761458090;
  h=date:from:to:cc:subject:message-id;
  bh=ff31CZEKkTrgaKSfaZDSJeJ3Aac61l/nkxuzdVj8UVk=;
  b=muzuzvwJEwi/QURyNhyJ+8KH+0/itxqNuFcxq79949ONFoyVunFstVUn
   /UjfFA5wSh9KZDc6gIlw2Ye++3aHU4RuKpEbTscZzuvSTTY5684XAUx57
   BG+oA5cK5Z2anYjuwKXlz4qdn28DpgFjx6aQNSJdN9RNKoErplfWTjcQP
   bLRbuHb7lmp8qXav6It8nBuQjYZMkyUaZhu07JN9SG5O1h2oXltu1r3zF
   ZZnz+hC4Pi+ymxowJECbZlebbsVGVZsyWHb8TGX4rjeRfLKCbPq/Bl2nQ
   DbNxORlLZDTZzqx0HpMzgdC+qaquY6708sldOWi3lmH7vJXI2Eh/IQIwJ
   Q==;
X-CSE-ConnectionGUID: ABd52XQ/RdmMpKLalvfC1Q==
X-CSE-MsgGUID: 9jmjBeXWTjqbcaOiJy2QHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29373482"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29373482"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 22:54:49 -0700
X-CSE-ConnectionGUID: +e0AHhQ3S1++DMwk/S4kXA==
X-CSE-MsgGUID: xRK8Q1GpSk2gx1iKjtVBFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,234,1725346800"; 
   d="scan'208";a="81047441"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 25 Oct 2024 22:54:48 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4Zl7-000ZK4-1R;
	Sat, 26 Oct 2024 05:54:45 +0000
Date: Sat, 26 Oct 2024 13:54:24 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 e1cac6a143e257c1bf9166e30083fbd66acfe8b6
Message-ID: <202410261316.C9aXMf9J-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: e1cac6a143e257c1bf9166e30083fbd66acfe8b6  asm-generic: add an optional pfn_valid check to page_to_phys

elapsed time: 806m

configs tested: 70
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha            allnoconfig    gcc-14.1.0
alpha           allyesconfig    clang-20
arc             allmodconfig    clang-20
arc              allnoconfig    gcc-14.1.0
arc             allyesconfig    clang-20
arm             allmodconfig    clang-20
arm              allnoconfig    gcc-14.1.0
arm             allyesconfig    clang-20
arm64           allmodconfig    clang-20
arm64            allnoconfig    gcc-14.1.0
csky             allnoconfig    gcc-14.1.0
hexagon         allmodconfig    clang-20
hexagon          allnoconfig    gcc-14.1.0
hexagon         allyesconfig    clang-20
i386            allmodconfig    clang-19
i386             allnoconfig    clang-19
i386            allyesconfig    clang-19
i386               defconfig    clang-19
loongarch       allmodconfig    gcc-14.1.0
loongarch        allnoconfig    gcc-14.1.0
m68k            allmodconfig    gcc-14.1.0
m68k             allnoconfig    gcc-14.1.0
m68k            allyesconfig    gcc-14.1.0
microblaze      allmodconfig    gcc-14.1.0
microblaze       allnoconfig    gcc-14.1.0
microblaze      allyesconfig    gcc-14.1.0
mips             allnoconfig    gcc-14.1.0
nios2            allnoconfig    gcc-14.1.0
openrisc         allnoconfig    clang-20
openrisc         allnoconfig    gcc-14.1.0
openrisc        allyesconfig    gcc-14.1.0
openrisc           defconfig    gcc-12
parisc          allmodconfig    gcc-14.1.0
parisc           allnoconfig    clang-20
parisc           allnoconfig    gcc-14.1.0
parisc          allyesconfig    gcc-14.1.0
parisc             defconfig    gcc-12
powerpc         allmodconfig    gcc-14.1.0
powerpc          allnoconfig    clang-20
powerpc          allnoconfig    gcc-14.1.0
powerpc         allyesconfig    gcc-14.1.0
riscv           allmodconfig    gcc-14.1.0
riscv            allnoconfig    clang-20
riscv            allnoconfig    gcc-14.1.0
riscv           allyesconfig    gcc-14.1.0
riscv              defconfig    gcc-12
s390            allmodconfig    gcc-14.1.0
s390             allnoconfig    clang-20
s390            allyesconfig    gcc-14.1.0
s390               defconfig    gcc-12
sh              allmodconfig    gcc-14.1.0
sh               allnoconfig    gcc-14.1.0
sh              allyesconfig    gcc-14.1.0
sh                 defconfig    gcc-12
sparc           allmodconfig    gcc-14.1.0
sparc64            defconfig    gcc-12
um              allmodconfig    clang-20
um               allnoconfig    clang-17
um               allnoconfig    clang-20
um              allyesconfig    clang-20
um                 defconfig    gcc-12
um            i386_defconfig    gcc-12
um          x86_64_defconfig    gcc-12
x86_64           allnoconfig    clang-19
x86_64          allyesconfig    clang-19
x86_64             defconfig    clang-19
x86_64                 kexec    clang-19
x86_64                 kexec    gcc-12
x86_64              rhel-8.3    gcc-12
xtensa           allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

