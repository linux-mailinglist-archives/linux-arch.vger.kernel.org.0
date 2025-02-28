Return-Path: <linux-arch+bounces-10471-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80433A4A0E1
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 18:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D652189A4A7
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 17:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25DA1C1F00;
	Fri, 28 Feb 2025 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQu9vcZG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345815ECDF
	for <linux-arch@vger.kernel.org>; Fri, 28 Feb 2025 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765153; cv=none; b=M1p3fLPkyZd7sMUYjJUp6A7wy+vxuR/mZyVcv9pFi7j3tr5oVjpDKoV0oN9jaUh6ax5ULklFcSv1qB6yTstuy03UA+wBE+xqm9ynnYzuv9sFcttDg4Rdg8WAMyY2t2qKFS22dSks4Z8EraNrBhjKu7Tkm6BkY2ThTqsmjAMpnBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765153; c=relaxed/simple;
	bh=+Ht1MQGBmqZtoknpD5M16MZiWZKcnDJ92gH5Uo7A9gs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gzu88D6Yipx+AQHbjbJpk5q3O+n8haSRszvk/JP11lfSg9oqbwjiL6w+fG1M32ItN3e1914RI0DV0DvZy9npPyD8m3QIJu5mJcbfepUaFd1M9XIj2ispaGXQ4UuRVC3gMWer+Sty6QFnq3WeYZdJph3bO/FOVi8E1MUK4KRPosQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQu9vcZG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740765153; x=1772301153;
  h=date:from:to:cc:subject:message-id;
  bh=+Ht1MQGBmqZtoknpD5M16MZiWZKcnDJ92gH5Uo7A9gs=;
  b=MQu9vcZGinOZKKmM2uhfsdw7QR4oQRL/Sk40sRHoZGBpAsazCYKMD8Um
   w4wlYMylPMGX86wklW5sqI8moyz7dC2SN3WXVHZMf0O/lcEd4H+Yq5APf
   aHHBD1i7pF3SB4y8wG/IL+nlsNYddHpZzsWN9WtWDQMwPCociwT3DlsXu
   N5VZNV42cPZdOwumywz8ed2HwhIvKMS7Zxch6C7FzciG7FxzzHpOeuEPA
   aHdseRAKD8ivTVDDXb+EYi96+ooaOwpfjI72cWwRyJrzKXG2kN45vtvV1
   Nir4esBbqb0B/xVH9TX5VWnWZmsqNN/Xv5YzsL4m1xx/YeSmoN+z/x5Dc
   A==;
X-CSE-ConnectionGUID: T93AMft7S6aJaHYt/0NDWg==
X-CSE-MsgGUID: 5Sv/YbQ+Skej4l9891kfvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="45354781"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="45354781"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 09:52:32 -0800
X-CSE-ConnectionGUID: d+0yjymbTwCK2qGuzSbY1g==
X-CSE-MsgGUID: NKBEVqZhR/2wkvh3ptRGRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="122540495"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 28 Feb 2025 09:52:30 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1to4XE-000FJu-0A;
	Fri, 28 Feb 2025 17:52:28 +0000
Date: Sat, 01 Mar 2025 01:51:39 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD REGRESSION
 55d422e4e5bf7aece2038533451a9bd5e5181e95
Message-ID: <202503010131.d7uB8Qsp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 55d422e4e5bf7aece2038533451a9bd5e5181e95  io.h: drop unused headers

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202502280726.h7lhKtT4-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202502280814.ATzYxKLc-lkp@intel.com

    ERROR: modpost: "__ioread64_lo_hi" [drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.ko] undefined!
    ERROR: modpost: "__iowrite64_hi_lo" [drivers/crypto/caam/caam_jr.ko] undefined!
    ERROR: modpost: "__iowrite64_lo_hi" [drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.ko] undefined!
    ERROR: modpost: "__iowrite64be_hi_lo" [drivers/crypto/caam/caam_jr.ko] undefined!
    drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:68:2: error: call to undeclared function '__iowrite64_lo_hi'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:73:9: error: call to undeclared function '__ioread64_lo_hi'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    drivers/vfio/pci/vfio_pci_rdwr.c:65:1: error: call to undeclared function '__iowrite64be_lo_hi'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    drivers/vfio/pci/vfio_pci_rdwr.c:91:1: error: call to undeclared function '__ioread64be_lo_hi'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    include/linux/io-64-nonatomic-hi-lo.h:105:18: error: implicit declaration of function '__ioread64_hi_lo'; did you mean 'ioread64_hi_lo'? [-Wimplicit-function-declaration]
    include/linux/io-64-nonatomic-hi-lo.h:114:19: error: implicit declaration of function '__iowrite64_hi_lo'; did you mean 'iowrite64_hi_lo'? [-Wimplicit-function-declaration]
    include/linux/io-64-nonatomic-hi-lo.h:123:20: error: implicit declaration of function '__ioread64be_hi_lo'; did you mean 'ioread64be_hi_lo'? [-Wimplicit-function-declaration]
    include/linux/io-64-nonatomic-hi-lo.h:132:21: error: implicit declaration of function '__iowrite64be_hi_lo'; did you mean 'iowrite64be_hi_lo'? [-Wimplicit-function-declaration]
    include/linux/io-64-nonatomic-lo-hi.h:105:18: error: implicit declaration of function '__ioread64_lo_hi'; did you mean 'ioread64_lo_hi'? [-Wimplicit-function-declaration]
    include/linux/io-64-nonatomic-lo-hi.h:114:19: error: implicit declaration of function '__iowrite64_lo_hi'; did you mean 'iowrite64_lo_hi'? [-Wimplicit-function-declaration]
    include/linux/io-64-nonatomic-lo-hi.h:123:20: error: implicit declaration of function '__ioread64be_lo_hi'; did you mean 'ioread64be_lo_hi'? [-Wimplicit-function-declaration]
    include/linux/io-64-nonatomic-lo-hi.h:132:21: error: implicit declaration of function '__iowrite64be_lo_hi'; did you mean 'iowrite64be_lo_hi'? [-Wimplicit-function-declaration]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arc-randconfig-001-20250228
|   `-- include-linux-io-nonatomic-lo-hi.h:error:implicit-declaration-of-function-__iowrite64_lo_hi
|-- csky-randconfig-001-20250228
|   |-- include-linux-io-nonatomic-lo-hi.h:error:implicit-declaration-of-function-__ioread64_lo_hi
|   `-- include-linux-io-nonatomic-lo-hi.h:error:implicit-declaration-of-function-__iowrite64_lo_hi
|-- hexagon-allmodconfig
|   |-- drivers-dma-dw-axi-dmac-dw-axi-dmac-platform.c:error:call-to-undeclared-function-__ioread64_lo_hi-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-dma-dw-axi-dmac-dw-axi-dmac-platform.c:error:call-to-undeclared-function-__iowrite64_lo_hi-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- hexagon-allyesconfig
|   |-- drivers-dma-dw-axi-dmac-dw-axi-dmac-platform.c:error:call-to-undeclared-function-__ioread64_lo_hi-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-dma-dw-axi-dmac-dw-axi-dmac-platform.c:error:call-to-undeclared-function-__iowrite64_lo_hi-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- parisc-randconfig-002-20250228
|   |-- ERROR:__ioread64_lo_hi-drivers-dma-dw-axi-dmac-dw-axi-dmac-platform.ko-undefined
|   |-- ERROR:__iowrite64_hi_lo-drivers-crypto-caam-caam_jr.ko-undefined
|   |-- ERROR:__iowrite64_lo_hi-drivers-dma-dw-axi-dmac-dw-axi-dmac-platform.ko-undefined
|   `-- ERROR:__iowrite64be_hi_lo-drivers-crypto-caam-caam_jr.ko-undefined
|-- powerpc-randconfig-001-20250228
|   |-- include-linux-io-nonatomic-hi-lo.h:error:implicit-declaration-of-function-__ioread64_hi_lo
|   |-- include-linux-io-nonatomic-hi-lo.h:error:implicit-declaration-of-function-__ioread64be_hi_lo
|   |-- include-linux-io-nonatomic-hi-lo.h:error:implicit-declaration-of-function-__iowrite64_hi_lo
|   |-- include-linux-io-nonatomic-hi-lo.h:error:implicit-declaration-of-function-__iowrite64be_hi_lo
|   |-- include-linux-io-nonatomic-lo-hi.h:error:implicit-declaration-of-function-__ioread64_lo_hi
|   |-- include-linux-io-nonatomic-lo-hi.h:error:implicit-declaration-of-function-__ioread64be_lo_hi
|   |-- include-linux-io-nonatomic-lo-hi.h:error:implicit-declaration-of-function-__iowrite64_lo_hi
|   `-- include-linux-io-nonatomic-lo-hi.h:error:implicit-declaration-of-function-__iowrite64be_lo_hi
|-- powerpc-randconfig-003-20250228
|   |-- drivers-dma-dw-axi-dmac-dw-axi-dmac-platform.c:error:call-to-undeclared-function-__ioread64_lo_hi-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-dma-dw-axi-dmac-dw-axi-dmac-platform.c:error:call-to-undeclared-function-__iowrite64_lo_hi-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-vfio-pci-vfio_pci_rdwr.c:error:call-to-undeclared-function-__ioread64be_lo_hi-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-vfio-pci-vfio_pci_rdwr.c:error:call-to-undeclared-function-__iowrite64be_lo_hi-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- riscv-randconfig-002-20250228
|   |-- include-linux-io-nonatomic-lo-hi.h:error:implicit-declaration-of-function-__ioread64_lo_hi
|   `-- include-linux-io-nonatomic-lo-hi.h:error:implicit-declaration-of-function-__iowrite64_lo_hi
`-- xtensa-randconfig-002-20250228
    |-- include-linux-io-nonatomic-lo-hi.h:error:implicit-declaration-of-function-__ioread64_lo_hi
    |-- include-linux-io-nonatomic-lo-hi.h:error:implicit-declaration-of-function-__ioread64be_lo_hi
    |-- include-linux-io-nonatomic-lo-hi.h:error:implicit-declaration-of-function-__iowrite64_lo_hi
    `-- include-linux-io-nonatomic-lo-hi.h:error:implicit-declaration-of-function-__iowrite64be_lo_hi

elapsed time: 1458m

configs tested: 67
configs skipped: 1

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250228    gcc-13.2.0
arc                  randconfig-002-20250228    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250228    clang-21
arm                  randconfig-002-20250228    gcc-14.2.0
arm                  randconfig-003-20250228    gcc-14.2.0
arm                  randconfig-004-20250228    gcc-14.2.0
arm64                           allmodconfig    clang-18
arm64                randconfig-001-20250228    gcc-14.2.0
arm64                randconfig-002-20250228    clang-21
arm64                randconfig-003-20250228    clang-16
arm64                randconfig-004-20250228    gcc-14.2.0
csky                 randconfig-001-20250228    gcc-14.2.0
csky                 randconfig-002-20250228    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250228    clang-19
hexagon              randconfig-002-20250228    clang-21
i386       buildonly-randconfig-001-20250228    clang-19
i386       buildonly-randconfig-002-20250228    clang-19
i386       buildonly-randconfig-003-20250228    gcc-12
i386       buildonly-randconfig-004-20250228    clang-19
i386       buildonly-randconfig-005-20250228    clang-19
i386       buildonly-randconfig-006-20250228    clang-19
loongarch            randconfig-001-20250228    gcc-14.2.0
loongarch            randconfig-002-20250228    gcc-14.2.0
nios2                randconfig-001-20250228    gcc-14.2.0
nios2                randconfig-002-20250228    gcc-14.2.0
parisc               randconfig-001-20250228    gcc-14.2.0
parisc               randconfig-002-20250228    gcc-14.2.0
powerpc              randconfig-001-20250228    gcc-14.2.0
powerpc              randconfig-002-20250228    clang-16
powerpc              randconfig-003-20250228    clang-18
powerpc64            randconfig-001-20250228    clang-16
powerpc64            randconfig-002-20250228    clang-18
powerpc64            randconfig-003-20250228    gcc-14.2.0
riscv                randconfig-001-20250228    gcc-14.2.0
riscv                randconfig-002-20250228    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250228    gcc-14.2.0
s390                 randconfig-002-20250228    clang-17
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250228    gcc-14.2.0
sh                   randconfig-002-20250228    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250228    gcc-14.2.0
sparc                randconfig-002-20250228    gcc-14.2.0
sparc64              randconfig-001-20250228    gcc-14.2.0
sparc64              randconfig-002-20250228    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250228    clang-21
um                   randconfig-002-20250228    clang-21
x86_64     buildonly-randconfig-001-20250228    clang-19
x86_64     buildonly-randconfig-002-20250228    clang-19
x86_64     buildonly-randconfig-003-20250228    gcc-12
x86_64     buildonly-randconfig-004-20250228    clang-19
x86_64     buildonly-randconfig-005-20250228    gcc-12
x86_64     buildonly-randconfig-006-20250228    gcc-12
xtensa               randconfig-001-20250228    gcc-14.2.0
xtensa               randconfig-002-20250228    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

