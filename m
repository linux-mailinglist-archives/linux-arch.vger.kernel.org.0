Return-Path: <linux-arch+bounces-2690-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B0D860832
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 02:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D58C1C21B95
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 01:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9701946C;
	Fri, 23 Feb 2024 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LpdCZBp9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEF979E1;
	Fri, 23 Feb 2024 01:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708651640; cv=none; b=Mae98+TuRCFSAVnVZQMayJ97e692BcoqtxAUDtgo3alq3GkzX40uEKI9l4eRDXJSWW6C+ki45r0iMU5y+VIhHiLYNjUSnQwgBC5fUdcB63NiBgyoc3s4kQDat0qU6aOPHT8b8n5x20zLbVcRZtnbPJLW7y0eGtgm1ROhbuO+pkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708651640; c=relaxed/simple;
	bh=VJfzL6GLEaZMoUqazrxisfj34PLQuSNA02WLHhDPT4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8ETOUUteJk46Cx6DI6O8scVD/qI874fqH3Rt5rDk6qyTLdJQRjUj5237VMIilZRRRym635B+1M6d7ifQz0nCJNdG3u81a/po1KiVqucQj9Ml3OlpclyG27/mauYkm1rl6zTQmR5lKYPlaXIS/UR3KI3tYRihFq4lTqb0woUU/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LpdCZBp9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708651638; x=1740187638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VJfzL6GLEaZMoUqazrxisfj34PLQuSNA02WLHhDPT4k=;
  b=LpdCZBp9dhFIIgtBdS4jFXFuqQKkaB2vJ/hsogVcQYEdTIm2tKSaQ3wS
   8G5JCIyHVhU213hGOCea465UhwZgyodbLd4M/iDu1BGwQW45RAHNxLtu6
   XesxHPmEeXlKuLwkNgMkfcrhlo0DinziUKifjYi9w+1u/b3wgmuw0S8MD
   QIez8EIi682kcMnGnTjFUIyBbPqgcxnS1nYy5mNobPyZIQrEZDdLBvD4G
   MT8ZOHJp5GzvK+3mXAjUU6mP7umP1knqUmICgxfc1wGDLEBo5KcXltXMa
   jaZWpp67OG6EqS3IgostuJF2qH8x4Shbnpg6W6k6mxoW4UjS+9DMk+DQd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="14072581"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="14072581"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 17:27:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6192032"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 17:27:11 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rdKL6-0006vK-2c;
	Fri, 23 Feb 2024 01:27:02 +0000
Date: Fri, 23 Feb 2024 09:26:10 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de,
	javierm@redhat.com, deller@gmx.de, suijingfeng@loongson.cn
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/3] arch: Remove struct fb_info from video helpers
Message-ID: <202402230941.JZdvHHEX-lkp@intel.com>
References: <20240221161431.8245-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221161431.8245-3-tzimmermann@suse.de>

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on deller-parisc/for-next arnd-asm-generic/master linus/master v6.8-rc5]
[cannot apply to next-20240222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Zimmermann/arch-Select-fbdev-helpers-with-CONFIG_VIDEO/20240222-001622
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240221161431.8245-3-tzimmermann%40suse.de
patch subject: [PATCH 2/3] arch: Remove struct fb_info from video helpers
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20240223/202402230941.JZdvHHEX-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240223/202402230941.JZdvHHEX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402230941.JZdvHHEX-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `fbcon_select_primary':
>> drivers/video/fbdev/core/fbcon.c:2944: undefined reference to `video_is_primary_device'
   ld: vmlinux.o: in function `fb_io_mmap':
   drivers/video/fbdev/core/fb_io_fops.c:164: undefined reference to `pgprot_framebuffer'


vim +2944 drivers/video/fbdev/core/fbcon.c

  2939	
  2940	#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
  2941	static void fbcon_select_primary(struct fb_info *info)
  2942	{
  2943		if (!map_override && primary_device == -1 &&
> 2944		    video_is_primary_device(info->device)) {
  2945			int i;
  2946	
  2947			printk(KERN_INFO "fbcon: %s (fb%i) is primary device\n",
  2948			       info->fix.id, info->node);
  2949			primary_device = info->node;
  2950	
  2951			for (i = first_fb_vc; i <= last_fb_vc; i++)
  2952				con2fb_map_boot[i] = primary_device;
  2953	
  2954			if (con_is_bound(&fb_con)) {
  2955				printk(KERN_INFO "fbcon: Remapping primary device, "
  2956				       "fb%i, to tty %i-%i\n", info->node,
  2957				       first_fb_vc + 1, last_fb_vc + 1);
  2958				info_idx = primary_device;
  2959			}
  2960		}
  2961	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

