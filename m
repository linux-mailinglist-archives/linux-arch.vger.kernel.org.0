Return-Path: <linux-arch+bounces-3267-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEDF88FFEA
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 14:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EA61F25350
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 13:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1921E7FBB9;
	Thu, 28 Mar 2024 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B65ebx4A"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE022847C;
	Thu, 28 Mar 2024 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711631741; cv=none; b=CcqGLN0yU00GaaHTFp14Fq70ZWgrPDhgUv9uy/8IBGCW8t5tcbDP3xQnUBriiDfjHJ8563JALoinOjJxp2YJ6T5Ms/nsH2jB/GXqFzbh5U8vF2XtM7sGnUC61A1DGUJ4lim8G2S+l8GQFBgAdUX5irJZd75Q+9qFHg4wz1Iq92Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711631741; c=relaxed/simple;
	bh=Xo032l06yr/hR/jwn/WjJ3wew5ThoMRYTk7U+HZZzrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuzU9VXyOERrk8Fd1wYfmfD6BLOZy9JUyyw3V68f9pzS92ciMgL2jUE1Fa73wKM+U+zlE4d2m3VHPPrp2aNJj1FpCaSukalSzY6wysTVIjPLaWm8vLCSn1YvP0pSZT4+7z7QntS/nLBzWAi2Gt3pO4L8hdTwVfyOV0bIl/otTzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B65ebx4A; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711631738; x=1743167738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xo032l06yr/hR/jwn/WjJ3wew5ThoMRYTk7U+HZZzrE=;
  b=B65ebx4Af8DFjJAYY5qvSyIryiU8E3lBdcEgf0P6v6wet68gIQ9/LwfC
   5DGnALwQqE5T9cMrnFxvy3I+CWKOK8U5YZ1avX5HMtQUQ7QmhQ8E0Fkwg
   6BlLLYAdXnigFA0ScQQwhzTEsF/B6j89EVzUHJ2ABw519hZlnyOBP1RQv
   /SqZ1Tgttu2motYFGY/uvcShSDPy+zGITB5odxyXdPhNbwGwYAyy2vk1/
   2lF94vr6QGWu5qIe1hflZb39jg6DtYq9w9vq+aeGpx4Azosk1A6SpE5Uq
   orN8hkVdiJydoG5h3vtAkNhlgpri4hJEKKttaPINnO46hecwO2ZpGtbyD
   A==;
X-CSE-ConnectionGUID: m2FbL++mQkiFPsSLcdrCWA==
X-CSE-MsgGUID: zilyCxbsRcm0ErALigs3RQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6999352"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="6999352"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 06:15:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="16637521"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 28 Mar 2024 06:15:08 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rppb0-0002A6-01;
	Thu, 28 Mar 2024 13:15:06 +0000
Date: Thu, 28 Mar 2024 21:15:01 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de,
	javierm@redhat.com, deller@gmx.de, sui.jingfeng@linux.dev
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Vineet Gupta <vgupta@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>
Subject: Re: [PATCH v2 3/3] arch: Rename fbdev header and source files
Message-ID: <202403282102.OEKoBT3H-lkp@intel.com>
References: <20240327204450.14914-4-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327204450.14914-4-tzimmermann@suse.de>

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.9-rc1 next-20240328]
[cannot apply to tip/x86/core deller-parisc/for-next arnd-asm-generic/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Zimmermann/arch-Select-fbdev-helpers-with-CONFIG_VIDEO/20240328-044735
base:   linus/master
patch link:    https://lore.kernel.org/r/20240327204450.14914-4-tzimmermann%40suse.de
patch subject: [PATCH v2 3/3] arch: Rename fbdev header and source files
config: um-randconfig-001-20240328 (https://download.01.org/0day-ci/archive/20240328/202403282102.OEKoBT3H-lkp@intel.com/config)
compiler: gcc-12 (Ubuntu 12.3.0-9ubuntu2) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240328/202403282102.OEKoBT3H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403282102.OEKoBT3H-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: drivers/video/fbdev/core/fb_io_fops.o: in function `fb_io_mmap':
>> fb_io_fops.c:(.text+0x251): undefined reference to `pgprot_framebuffer'
   collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

