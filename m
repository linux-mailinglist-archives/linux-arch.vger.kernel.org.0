Return-Path: <linux-arch+bounces-6028-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ECC9487FF
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 05:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E651C20B95
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 03:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A493E16D330;
	Tue,  6 Aug 2024 03:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lnvdeJps"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830E4187FFF
	for <linux-arch@vger.kernel.org>; Tue,  6 Aug 2024 03:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722915693; cv=none; b=ryJQf4HBvhqrpaBJ/85JJOZy7wRn3DEEVHi+7X6Gn9BeGM6ke1sX0FSO7xzrfh8glgQEmk+bvrY1K/pBP1bC4oNQ9dV5+2Eq1iE0Pm6aNPuQxEv9AXbCXEfwhU3ryRH8VH4x/NmNrScebQCr6YZVzB6243VQf7A/wFT+wg8j7ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722915693; c=relaxed/simple;
	bh=NOIA6GXFGUTwznlVCMnQLZoaTmmRQ/fJ1wpbp9mPd7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KgOpHyP1+7v1JHipU2CXHPBfAULzvBiHZoua+lXRfxTVd7dXbh+TsSoMUowjjEZYLQ11VKxJmrrd5xwSQy3mUOdnd41sbryJMuLk8ozeiYqZlh5RASMkQs060nqmRred2MYYs0k16QzTsm8PToJN/l7TNt7cuPoiCLXXcp0dnc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lnvdeJps; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722915685; x=1754451685;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NOIA6GXFGUTwznlVCMnQLZoaTmmRQ/fJ1wpbp9mPd7Q=;
  b=lnvdeJpsajZhNfWnFW7j+X224M5HM0/Hw/wR7zFBI6sMQ3b7udoFjEsF
   bLN4K0Uq0waDE1rxanJSsVpk7W0GhGdgieFqee+c5gCVTP/Wcx1KeGN0l
   CLJ1Rz2PENjvNDXEDT157B9nb5MwMtjMXGrNQEdUd44eZdOJr6CQHlEXf
   wQH8ZPp8lwfklgw3YUr+/SPzE/UqPQseeyMVHxBcpapv6mlKu/ztXfhqk
   AQC2C1C15g5pFEcmRkHtLCJmLmSIRTUfrhnW+CDT8opt13giYWZus3wx/
   mJnvJgJ7o03FyaUBlWXnS81hG/NGIIk0AsgJRxErpO9jA4m5xi4EJw+K4
   A==;
X-CSE-ConnectionGUID: uO8HAD3kSHKDNZhY9h1xVA==
X-CSE-MsgGUID: 2jGcr7HkRq2rpB9bOUIGKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="21074697"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="21074697"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 20:41:24 -0700
X-CSE-ConnectionGUID: kUDKNsGpSAOl9OOZqiGlLA==
X-CSE-MsgGUID: v1FaqqFETtOfVCKn83hT7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="56308200"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 05 Aug 2024 20:41:23 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbB4a-000474-2P;
	Tue, 06 Aug 2024 03:41:20 +0000
Date: Tue, 6 Aug 2024 11:40:44 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:master 5/5] error:
 arch/arm64/tools/syscall_64.tbl: syscall table is not sorted or duplicates
 the same syscall number
Message-ID: <202408061154.f8BOOZRJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
head:   95cca8c0b66557774e5d08d5d0cc28c099938f15
commit: 95cca8c0b66557774e5d08d5d0cc28c099938f15 [5/5] syscalls: add back legacy __NR_nfsservctl macro
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20240806/202408061154.f8BOOZRJ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240806/202408061154.f8BOOZRJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408061154.f8BOOZRJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: arch/arm64/tools/syscall_64.tbl: syscall table is not sorted or duplicates the same syscall number
   make[3]: *** [scripts/Makefile.asm-headers:88: arch/arm64/include/generated/asm/syscall_table_64.h] Error 1
   make[3]: *** Deleting file 'arch/arm64/include/generated/asm/syscall_table_64.h'
   make[3]: Target 'all' not remade because of errors.
   make[2]: *** [Makefile:1211: asm-generic] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

