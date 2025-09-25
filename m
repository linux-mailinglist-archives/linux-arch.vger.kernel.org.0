Return-Path: <linux-arch+bounces-13772-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9772B9F3A1
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 14:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D01E4E5611
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 12:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE84C2FC893;
	Thu, 25 Sep 2025 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kj3+QrXU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BE686353;
	Thu, 25 Sep 2025 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802952; cv=none; b=hhUEW/4dZQqD6QF73fgZnGZO00cJH1Ap8vH+2uYjKa/Y1b/aOtoGKm1FPmANT4r6aDumc6+cq88mpg7++lLSJ7FRmAbFmAS/0PqzCRTndu7n0EgGEuUxizLh7XepxkWN0w+CVOFsgB4g+fb9GcQ8e8j6VIlHNEKER2v/3ivvV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802952; c=relaxed/simple;
	bh=Tm+4joIsAVhoOGpHV0IfGhWDLFgBiLx2fFOsiG1Cw1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTwrFXDNzHGb4BGasJ7H0zKCwGKx2SLQeA9p05Lo5AnahcN40iWZMsgvdE4LFlpW6ye7bMkHgrd9iLZI5m3D61P48FRgq2VxU5db2RsPfBNCx95rDconeAbeCQ2ROqqSbqASs8xtIQDAU8sRZbVoeCWDPSmbqeZDVmIGVg2h7CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kj3+QrXU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758802951; x=1790338951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tm+4joIsAVhoOGpHV0IfGhWDLFgBiLx2fFOsiG1Cw1E=;
  b=Kj3+QrXUjm4bP89idtM3S5Q9Jiaud8MXl/L9FX35Z3lVcJFRpCfai0BN
   fcxR7wMpnsivkgzhLvYik2Mp5F0tR7PNsGweZjcrbh6Chbum1gp9A6Fwz
   FdgUmlS5u2iPa1ILn26QSUd1JVFCnT+/Wd3Ew1UiqgrXNVaR/xCobQeLg
   HMcxgy48rksewicC05vnhgehk1v9aDRhYjC0hEcTj018e72oIffzkZgyb
   FjPw5hk3bwrdwqs5b7SmV+m5wnN6MUgMRGVEta33PD3g35qroaGsV9Qs1
   XuQJbAjSIJ8uQPXGbhzlapQAh8orlQx/n0RBgfwLIxKs176oj/fiSYhBK
   w==;
X-CSE-ConnectionGUID: pjVdzTQYRuCgcNKFDjLcEA==
X-CSE-MsgGUID: BYfgH5AXQHKuetF3jjCNLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="60330596"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="60330596"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 05:22:30 -0700
X-CSE-ConnectionGUID: wREnvNLfTMWuWHu54WXTbw==
X-CSE-MsgGUID: 2WHOhuASRYGVg79ikjlZhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181711175"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 25 Sep 2025 05:22:24 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1kzN-0005DB-2S;
	Thu, 25 Sep 2025 12:22:21 +0000
Date: Thu, 25 Sep 2025 20:22:14 +0800
From: kernel test robot <lkp@intel.com>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>, git@amd.com,
	michal.simek@amd.com, alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, pgaj@cadence.com,
	wsa+renesas@sang-engineering.com, tommaso.merciai.xr@bp.renesas.com,
	arnd@arndb.de, quic_msavaliy@quicinc.com, Shyam-sundar.S-k@amd.com,
	sakari.ailus@linux.intel.com, billy_tsai@aspeedtech.com,
	kees@kernel.org, gustavoars@kernel.org,
	jarkko.nikula@linux.intel.com, jorge.marques@analog.com,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, radhey.shyam.pandey@amd.com,
	srinivas.goud@amd.com, shubhrajyoti.datta@amd.com,
	manion05gk@gmail.com,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: Re: [PATCH V7 3/4] i3c: master: Add endianness support for
 i3c_readl_fifo() and i3c_writel_fifo()
Message-ID: <202509252022.QvbNmJil-lkp@intel.com>
References: <20250923154551.2112388-4-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923154551.2112388-4-manikanta.guntupalli@amd.com>

Hi Manikanta,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master arnd-asm-generic/master v6.17-rc7 next-20250924]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manikanta-Guntupalli/dt-bindings-i3c-Add-AMD-I3C-master-controller-support/20250923-234944
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250923154551.2112388-4-manikanta.guntupalli%40amd.com
patch subject: [PATCH V7 3/4] i3c: master: Add endianness support for i3c_readl_fifo() and i3c_writel_fifo()
config: mips-randconfig-r123-20250925 (https://download.01.org/0day-ci/archive/20250925/202509252022.QvbNmJil-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project cafc064fc7a96b3979a023ddae1da2b499d6c954)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250925/202509252022.QvbNmJil-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509252022.QvbNmJil-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/i3c/master/i3c-master-cdns.c: note: in included file:
>> drivers/i3c/master/../internals.h:53:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   drivers/i3c/master/../internals.h:53:25: sparse:     expected unsigned int [usertype] val
   drivers/i3c/master/../internals.h:53:25: sparse:     got restricted __be32 [usertype]
>> drivers/i3c/master/../internals.h:53:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/i3c/master/../internals.h:53:25: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/i3c/master/../internals.h:53:25: sparse:     got unsigned int *
>> drivers/i3c/master/../internals.h:78:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/i3c/master/../internals.h:78:31: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/i3c/master/../internals.h:78:31: sparse:     got unsigned int *
>> drivers/i3c/master/../internals.h:78:31: sparse: sparse: cast to restricted __be32
>> drivers/i3c/master/../internals.h:78:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/i3c/master/../internals.h:78:31: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/i3c/master/../internals.h:78:31: sparse:     got unsigned int *
>> drivers/i3c/master/../internals.h:78:31: sparse: sparse: cast to restricted __be32

vim +53 drivers/i3c/master/../internals.h

    31	
    32	/**
    33	 * i3c_writel_fifo - Write data buffer to 32bit FIFO
    34	 * @addr: FIFO Address to write to
    35	 * @buf: Pointer to the data bytes to write
    36	 * @nbytes: Number of bytes to write
    37	 * @endian: Endianness of FIFO write
    38	 */
    39	static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
    40					   int nbytes, enum i3c_fifo_endian endian)
    41	{
    42		if (endian)
    43			writesl_be(addr, buf, nbytes / 4);
    44		else
    45			writesl(addr, buf, nbytes / 4);
    46	
    47		if (nbytes & 3) {
    48			u32 tmp = 0;
    49	
    50			memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
    51	
    52			if (endian)
  > 53				writel_be(tmp, addr);
    54			else
    55				writel(tmp, addr);
    56		}
    57	}
    58	
    59	/**
    60	 * i3c_readl_fifo - Read data buffer from 32bit FIFO
    61	 * @addr: FIFO Address to read from
    62	 * @buf: Pointer to the buffer to store read bytes
    63	 * @nbytes: Number of bytes to read
    64	 * @endian: Endianness of FIFO read
    65	 */
    66	static inline void i3c_readl_fifo(const void __iomem *addr, void *buf,
    67					  int nbytes, enum i3c_fifo_endian endian)
    68	{
    69		if (endian)
    70			readsl_be(addr, buf, nbytes / 4);
    71		else
    72			readsl(addr, buf, nbytes / 4);
    73	
    74		if (nbytes & 3) {
    75			u32 tmp;
    76	
    77			if (endian)
  > 78				tmp = readl_be(addr);
    79			else
    80				tmp = readl(addr);
    81	
    82			memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
    83		}
    84	}
    85	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

