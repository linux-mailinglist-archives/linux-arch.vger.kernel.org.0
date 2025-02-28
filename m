Return-Path: <linux-arch+bounces-10451-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7E4A48D0E
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 01:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AAF6167569
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 00:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E429F625;
	Fri, 28 Feb 2025 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="US1TU4+u"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCBD36C
	for <linux-arch@vger.kernel.org>; Fri, 28 Feb 2025 00:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740701445; cv=none; b=rby+06ejPtj5etMJk93hBVuXY4ArIfgwBIFSscLq5TGBI+Uc/gh2PAbB6CPTrriAfcgqWk3eAxzvfe+q754RNL5Y+VuFYrDg/NvmUjk6yIKW3BMy8/N6q/YpizQTwChwV5xSMiQvL4duX3Tok0SQxeYNoPO8tNTw7ttrCmdkc9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740701445; c=relaxed/simple;
	bh=XnBvdezlNA7pZ2esYOYeXu4I3CF58TE8LpoB4Ju2BGA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fCuz71ICwB57PrD/oLee6/TqQ/OSWC1n7rIvUBQZoVDnvGTKz8XbsNTLpuJ7oxS3G8aNVeiKKqy6h5BvrRW3zFeqSiNNMn8mo5n5sWQcOcKPGK7ftsxRCoe2IrVl94LzhWEzv+5k2I4Gd0O6cQlAHQ2P6oVXVARdQV7/7lBXYYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=US1TU4+u; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740701444; x=1772237444;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XnBvdezlNA7pZ2esYOYeXu4I3CF58TE8LpoB4Ju2BGA=;
  b=US1TU4+ur+fsd8pq+Y/Kj1zO5oT5yx9BEEFMDjADz/9e2DVJG409CVsw
   KUsFtK5JbewlovH4gkQu7l4FGFyRenLONqvZc1rmVpy/Ih3ej4GdChIz6
   jEmO52w0+B/Th3kCJt1aHyE2eEMYDwwEXOyLn/6X+dKhps6QNpz6i9XUX
   +qPrc5gGs1tsiAeq92kdf2mLdhLXQstzI9cgGDVV7/a5i/3h+pl9j35FD
   O+h0ORJLVY3ewOsS1kgpBb0BaHu+KUWhGztySre+XpDBttibw6d1n4zsz
   BLOIFEgy61I/YYVIxgXMHfdPRD9qvRM1jwPxJeaFAkPVOVpZwxFTeJGHj
   g==;
X-CSE-ConnectionGUID: yHk7ET70RSSq4ffcsCiLFw==
X-CSE-MsgGUID: rgKJqPqWSdanTCxl0BMGJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52251653"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="52251653"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 16:10:43 -0800
X-CSE-ConnectionGUID: SdphHCXgTWqE3Ir7zRJWFA==
X-CSE-MsgGUID: SXxgTBduSXqYOraA/ix8ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117843893"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 27 Feb 2025 16:10:42 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnnxg-000EDi-0L;
	Fri, 28 Feb 2025 00:10:40 +0000
Date: Fri, 28 Feb 2025 08:10:19 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:master 1/3]
 include/linux/io-64-nonatomic-lo-hi.h:132:21: error: implicit declaration of
 function '__iowrite64be_lo_hi'; did you mean 'iowrite64be_lo_hi'?
Message-ID: <202502280814.ATzYxKLc-lkp@intel.com>
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
config: xtensa-randconfig-002-20250228 (https://download.01.org/0day-ci/archive/20250228/202502280814.ATzYxKLc-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502280814.ATzYxKLc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502280814.ATzYxKLc-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/vfio/pci/vfio_pci_rdwr.c:19:
   drivers/vfio/pci/vfio_pci_rdwr.c: In function 'vfio_pci_core_iowrite64':
>> include/linux/io-64-nonatomic-lo-hi.h:132:21: error: implicit declaration of function '__iowrite64be_lo_hi'; did you mean 'iowrite64be_lo_hi'? [-Wimplicit-function-declaration]
     132 | #define iowrite64be __iowrite64be_lo_hi
         |                     ^~~~~~~~~~~~~~~~~~~
   drivers/vfio/pci/vfio_pci_rdwr.c:32:25: note: in expansion of macro 'iowrite64be'
      32 | #define vfio_iowrite64  iowrite64be
         |                         ^~~~~~~~~~~
   drivers/vfio/pci/vfio_pci_rdwr.c:53:9: note: in expansion of macro 'vfio_iowrite64'
      53 |         vfio_iowrite##size(val, io);                                    \
         |         ^~~~~~~~~~~~
   drivers/vfio/pci/vfio_pci_rdwr.c:65:1: note: in expansion of macro 'VFIO_IOWRITE'
      65 | VFIO_IOWRITE(64)
         | ^~~~~~~~~~~~
   drivers/vfio/pci/vfio_pci_rdwr.c: In function 'vfio_pci_core_ioread64':
>> include/linux/io-64-nonatomic-lo-hi.h:123:20: error: implicit declaration of function '__ioread64be_lo_hi'; did you mean 'ioread64be_lo_hi'? [-Wimplicit-function-declaration]
     123 | #define ioread64be __ioread64be_lo_hi
         |                    ^~~~~~~~~~~~~~~~~~
   drivers/vfio/pci/vfio_pci_rdwr.c:31:25: note: in expansion of macro 'ioread64be'
      31 | #define vfio_ioread64   ioread64be
         |                         ^~~~~~~~~~
   drivers/vfio/pci/vfio_pci_rdwr.c:79:16: note: in expansion of macro 'vfio_ioread64'
      79 |         *val = vfio_ioread##size(io);                                   \
         |                ^~~~~~~~~~~
   drivers/vfio/pci/vfio_pci_rdwr.c:91:1: note: in expansion of macro 'VFIO_IOREAD'
      91 | VFIO_IOREAD(64)
         | ^~~~~~~~~~~
--
   In file included from vfio_pci_rdwr.c:19:
   vfio_pci_rdwr.c: In function 'vfio_pci_core_iowrite64':
>> include/linux/io-64-nonatomic-lo-hi.h:132:21: error: implicit declaration of function '__iowrite64be_lo_hi'; did you mean 'iowrite64be_lo_hi'? [-Wimplicit-function-declaration]
     132 | #define iowrite64be __iowrite64be_lo_hi
         |                     ^~~~~~~~~~~~~~~~~~~
   vfio_pci_rdwr.c:32:25: note: in expansion of macro 'iowrite64be'
      32 | #define vfio_iowrite64  iowrite64be
         |                         ^~~~~~~~~~~
   vfio_pci_rdwr.c:53:9: note: in expansion of macro 'vfio_iowrite64'
      53 |         vfio_iowrite##size(val, io);                                    \
         |         ^~~~~~~~~~~~
   vfio_pci_rdwr.c:65:1: note: in expansion of macro 'VFIO_IOWRITE'
      65 | VFIO_IOWRITE(64)
         | ^~~~~~~~~~~~
   vfio_pci_rdwr.c: In function 'vfio_pci_core_ioread64':
>> include/linux/io-64-nonatomic-lo-hi.h:123:20: error: implicit declaration of function '__ioread64be_lo_hi'; did you mean 'ioread64be_lo_hi'? [-Wimplicit-function-declaration]
     123 | #define ioread64be __ioread64be_lo_hi
         |                    ^~~~~~~~~~~~~~~~~~
   vfio_pci_rdwr.c:31:25: note: in expansion of macro 'ioread64be'
      31 | #define vfio_ioread64   ioread64be
         |                         ^~~~~~~~~~
   vfio_pci_rdwr.c:79:16: note: in expansion of macro 'vfio_ioread64'
      79 |         *val = vfio_ioread##size(io);                                   \
         |                ^~~~~~~~~~~
   vfio_pci_rdwr.c:91:1: note: in expansion of macro 'VFIO_IOREAD'
      91 | VFIO_IOREAD(64)
         | ^~~~~~~~~~~


vim +132 include/linux/io-64-nonatomic-lo-hi.h

   119	
   120	#ifndef ioread64be
   121	#define ioread64be_is_nonatomic
   122	#ifdef CONFIG_GENERIC_IOREMAP
 > 123	#define ioread64be __ioread64be_lo_hi
   124	#else
   125	#define ioread64be ioread64be_lo_hi
   126	#endif
   127	#endif
   128	
   129	#ifndef iowrite64be
   130	#define iowrite64be_is_nonatomic
   131	#ifdef CONFIG_GENERIC_IOREMAP
 > 132	#define iowrite64be __iowrite64be_lo_hi
   133	#else
   134	#define iowrite64be iowrite64be_lo_hi
   135	#endif
   136	#endif
   137	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

