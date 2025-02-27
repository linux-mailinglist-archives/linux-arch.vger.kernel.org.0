Return-Path: <linux-arch+bounces-10446-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024DBA48C74
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 00:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05F6188F7B5
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 23:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FC2272912;
	Thu, 27 Feb 2025 23:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f287fZgT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C3427290E
	for <linux-arch@vger.kernel.org>; Thu, 27 Feb 2025 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697910; cv=none; b=VGcBeFrHu+prERW8JcH3GmN/M7SgEL3Oiso4YBurGa8UHLByHxtj2mlY9NeEbPDa5Lwz62Uc6pkQreGESEBBdcpBmsSQBHa4xI+7v+PvoL18SmpCkhKChB73hz3r4VnCHhhbcdTxUOAuj1q8u+Ck9R1nvPOfIBtpqw1pGvPp6ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697910; c=relaxed/simple;
	bh=dvpgR4BubP9+zVjnCdkXuYhnDnaLy3Kpf1QM0Bw5WR0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PYZlxQrLdDdaWu2ClRIeKkE2mLrh23LSSZrmCWFwU5sWUpN7cSQ5OJK2oLvY9+XcKT4gVBTBZltuE6MOXcGX61ZdaztVMmJWbDj89Vl9LC8KREZwMrr4JcLb8sYjYrvNxgbp1pbfUE8yzvBnUI5rshIkLlG8UYf77ZY42FwryL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f287fZgT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740697909; x=1772233909;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dvpgR4BubP9+zVjnCdkXuYhnDnaLy3Kpf1QM0Bw5WR0=;
  b=f287fZgTSiZwHj6tq/SAtTrMEecM96Rh9a53YH1hGZ0oDpXTpt3I6w2e
   BslJ5A9TU5lLXavBBhmG2ev+5CNxwaETV8057qjcKiP+AmZRaQeJlW4Ox
   +RCai6GmsPTzcUq9Zqns5zklQ9hFQGxr1+qOqWn8S1ma1kMNmE3AVepO0
   N2E7ssBykUhhSTkfnyH11rbMjHS+zGCx9mjTpImBkMlMl+F7lzZY0ioo+
   sXpzL9DSQ8pi8DuDpW+yvLWKOz9bUeMlsBPvDMJ/LMuKQHUvjw96CG/1l
   Ix3hB5EL3veH6/M9dW5SPlyysfZBLVco1oqmXnht9JviZb+D5Ch79Ehyb
   Q==;
X-CSE-ConnectionGUID: wqLW1Ha3QRqoDcfhoRakig==
X-CSE-MsgGUID: ze1ezL3xTHCjMQ8pospG9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41868982"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41868982"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 15:11:48 -0800
X-CSE-ConnectionGUID: lgXHka7uQ3mGJkwitpH4fw==
X-CSE-MsgGUID: EalsUr4GQxu0muQS0OrZ7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117152823"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 27 Feb 2025 15:11:46 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnn2Z-000E9S-00;
	Thu, 27 Feb 2025 23:11:40 +0000
Date: Fri, 28 Feb 2025 07:11:29 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:master 1/3]
 include/linux/io-64-nonatomic-lo-hi.h:114:19: error: implicit declaration of
 function '__iowrite64_lo_hi'; did you mean 'iowrite64_lo_hi'?
Message-ID: <202502280726.h7lhKtT4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
head:   55d422e4e5bf7aece2038533451a9bd5e5181e95
commit: 07928da414b8c0166c9ad4d33b5470d6f7c1dd47 [1/3] asm-generic/io.h: rework split ioread64/iowrite64 helpers
config: riscv-randconfig-002-20250228 (https://download.01.org/0day-ci/archive/20250228/202502280726.h7lhKtT4-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502280726.h7lhKtT4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502280726.h7lhKtT4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:20:
   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c: In function 'axi_dma_iowrite64':
>> include/linux/io-64-nonatomic-lo-hi.h:114:19: error: implicit declaration of function '__iowrite64_lo_hi'; did you mean 'iowrite64_lo_hi'? [-Wimplicit-function-declaration]
     114 | #define iowrite64 __iowrite64_lo_hi
         |                   ^~~~~~~~~~~~~~~~~
   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:68:9: note: in expansion of macro 'iowrite64'
      68 |         iowrite64(val, chip->regs + reg);
         |         ^~~~~~~~~
   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c: In function 'axi_dma_ioread64':
>> include/linux/io-64-nonatomic-lo-hi.h:105:18: error: implicit declaration of function '__ioread64_lo_hi'; did you mean 'ioread64_lo_hi'? [-Wimplicit-function-declaration]
     105 | #define ioread64 __ioread64_lo_hi
         |                  ^~~~~~~~~~~~~~~~
   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:73:16: note: in expansion of macro 'ioread64'
      73 |         return ioread64(chip->regs + reg);
         |                ^~~~~~~~


vim +114 include/linux/io-64-nonatomic-lo-hi.h

   101	
   102	#ifndef ioread64
   103	#define ioread64_is_nonatomic
   104	#ifdef CONFIG_GENERIC_IOREMAP
 > 105	#define ioread64 __ioread64_lo_hi
   106	#else
   107	#define ioread64 ioread64_lo_hi
   108	#endif
   109	#endif
   110	
   111	#ifndef iowrite64
   112	#define iowrite64_is_nonatomic
   113	#ifdef CONFIG_GENERIC_IOREMAP
 > 114	#define iowrite64 __iowrite64_lo_hi
   115	#else
   116	#define iowrite64 iowrite64_lo_hi
   117	#endif
   118	#endif
   119	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

