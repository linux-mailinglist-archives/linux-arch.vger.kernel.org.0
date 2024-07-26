Return-Path: <linux-arch+bounces-5639-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270CF93D04A
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2024 11:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83487B21027
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2024 09:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD802B9B8;
	Fri, 26 Jul 2024 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NlhuV2/U"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65946116
	for <linux-arch@vger.kernel.org>; Fri, 26 Jul 2024 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721985408; cv=none; b=GJMsNeVNocN/X8z60Nfnwk7+tQJZRsnTf/mossqWtqxUAO+ymZUghcZR75kjM2psIRW+Qv1bBzntTH1OGrEvNymUWopl00dNIq9RN62vXoxTh3rUMjHhHN+XbK8RAqFEX5Qp9UfT4PMUqN+qbr1vCH6YKNI3lqKj1Jo5ThJRU+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721985408; c=relaxed/simple;
	bh=1WRif6zFratgP6hy5t2S1knQwLOhGvgYxLgn75CdlwM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h7Vf4y+klrlUaO1I6Y8VMG9tloCgOkwqSj7VynPuM/JUshGymK7oBajWA5gWndjiSsbR/xCWWHl4k5LtGEfGFZo2GeIYUi9fsFy1cGCSHk1zlxfcMe0J/UmQL0noOwDWwlmSpkz5XpGvzJR13HAMWG0Rrmbu7268GpmV/vOdTUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NlhuV2/U; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721985405; x=1753521405;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1WRif6zFratgP6hy5t2S1knQwLOhGvgYxLgn75CdlwM=;
  b=NlhuV2/UqgI0S3nbTSpByRrrsjE3rau2OYfq883juU9pAT+yYGqqQW14
   HC9zj0l/CobuhHFDFbcUAVFEu9axfjJzJEtvDtzNVCO24rw7m12lqquZQ
   L2JKoJp9mmEkFAwLkghllarekFDBnQwM+p9uUdloAXpH/4JICO97+fMki
   4yiCma5ZwEuFAUoTIxemvT+9JNu8tAsGkYntcKDo5wKrz2sV8uqdswCsD
   E9U1bASUbaN1FaPE5pFRSknS2Yf2vlm3+SEnWaId+bNMI2AY6pAcNqO1A
   a+W+68/NgGpTN/ZtaVDvSAje9HIIiaR/byLer3zN8pbYhsBihJ62hwHdf
   Q==;
X-CSE-ConnectionGUID: Bn8W2piyQ4ixrF9NhVB+mQ==
X-CSE-MsgGUID: wdrdUBafRSmR0ElPiznd6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19643692"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="19643692"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 02:16:45 -0700
X-CSE-ConnectionGUID: qh4CTPE0QeW0hAGnoVL1nQ==
X-CSE-MsgGUID: Z1DFGd9+T2m2NEbb/NRgrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="53122101"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 26 Jul 2024 02:16:44 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXH46-000ovW-0d;
	Fri, 26 Jul 2024 09:16:42 +0000
Date: Fri, 26 Jul 2024 17:16:19 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 45/80]
 arch/parisc/kernel/sys_parisc.c:299:undefined reference to
 `ksys_inotify_init'
Message-ID: <202407261747.czogEFdz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git syscall-tbl-6.11
head:   297d47a6407bea09324a4e1ba26a1735093f433f
commit: 6fcd1fc502adfe6e3fca25783617ebfa9b61dd66 [45/80] parisc SYSCALL_DEFINE
config: parisc-randconfig-r063-20240726 (https://download.01.org/0day-ci/archive/20240726/202407261747.czogEFdz-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240726/202407261747.czogEFdz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407261747.czogEFdz-lkp@intel.com/

All errors (new ones prefixed by >>):

   hppa-linux-ld: arch/parisc/kernel/sys_parisc.o: in function `__do_sys_parisc_inotify_init1':
>> arch/parisc/kernel/sys_parisc.c:299:(.text+0x7f4): undefined reference to `ksys_inotify_init'
   hppa-linux-ld: arch/parisc/kernel/sys_parisc.o: in function `__do_sys_parisc_madvise':
>> arch/parisc/kernel/sys_parisc.c:327:(.text+0x84c): undefined reference to `do_madvise'


vim +299 arch/parisc/kernel/sys_parisc.c

   295	
   296	SYSCALL_DEFINE1(parisc_inotify_init1, int, flags)
   297	{
   298		flags = FIX_O_NONBLOCK(flags);
 > 299		return ksys_inotify_init(flags);
   300	}
   301	
   302	/*
   303	 * madvise() wrapper
   304	 *
   305	 * Up to kernel v6.1 parisc has different values than all other
   306	 * platforms for the MADV_xxx flags listed below.
   307	 * To keep binary compatibility with existing userspace programs
   308	 * translate the former values to the new values.
   309	 *
   310	 * XXX: Remove this wrapper in year 2025 (or later)
   311	 */
   312	
   313	SYSCALL_DEFINE3(parisc_madvise, unsigned long, start, size_t, len_in, int, behavior)
   314	{
   315		switch (behavior) {
   316		case 65: behavior = MADV_MERGEABLE;	break;
   317		case 66: behavior = MADV_UNMERGEABLE;	break;
   318		case 67: behavior = MADV_HUGEPAGE;	break;
   319		case 68: behavior = MADV_NOHUGEPAGE;	break;
   320		case 69: behavior = MADV_DONTDUMP;	break;
   321		case 70: behavior = MADV_DODUMP;	break;
   322		case 71: behavior = MADV_WIPEONFORK;	break;
   323		case 72: behavior = MADV_KEEPONFORK;	break;
   324		case 73: behavior = MADV_COLLAPSE;	break;
   325		}
   326	
 > 327		return do_madvise(current->mm, start, len_in, behavior);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

