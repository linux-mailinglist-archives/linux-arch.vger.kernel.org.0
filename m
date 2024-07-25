Return-Path: <linux-arch+bounces-5636-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F8893CB46
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2024 01:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE4C1C20A28
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 23:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F21B13CFBB;
	Thu, 25 Jul 2024 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m52OvqbC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC3A143878
	for <linux-arch@vger.kernel.org>; Thu, 25 Jul 2024 23:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721950590; cv=none; b=ubK7DCDXd4VlQkCXuJtrXj1B+r6zRFLbshjmAg+SXp99Yici5Y4gYjBNvIfNGuSkl5xc6sRoT+hb0kO/NxpIHWQkIGo8GBh1r+bW8FUnSRkZObEMeRib0BV6eFGM+3/6yykb7ESI3iXSKVM7BvcIAYtTwbEeUQD6wBVq0Eyz1Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721950590; c=relaxed/simple;
	bh=WVYPihN9pxhRTBqPKGe4Q8rwSGTIZcNXSkvjvy1yx20=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tj6AVnOKU+j76t3Qz6LZ0YJgjXppjqHA9vzbgGK7EEYP+ck4lAeOOOvZqomo+rs6ILjq8stADkKpRIkExLrfB6QCA1uTWSF9uAp1EWb21iEbrnm9F/pYVp9taR5dYJVtGydwtRYT28WvDVGw6U9RQPb3FFz6obHibCeNCXvCp6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m52OvqbC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721950588; x=1753486588;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WVYPihN9pxhRTBqPKGe4Q8rwSGTIZcNXSkvjvy1yx20=;
  b=m52OvqbC4Ytbv28MBYHGzLtWqutkXEo2yonK61FaRn6S7qyMBCsdrFZw
   FOTjkh3RCCym36G2eYk8kIjamWPhzeKjsu8cPUklRQ7U/8ImJL8YJNU1m
   xlEWPQ48EmAabMNaBgvLQywB2ho7/Lycymd4+bCRUfeXiEFzi5Z5uZ6rc
   fAZ0TrrT+JNronzqDtKKFeJcrdZLWxZug43Q1Seg5NGXz5NqhghUCBo86
   futkRyc6BqlRHdb4hlyW+ObnEdB0CGZ4WFCXNUCp+QUuucScx3u/HmBB2
   QbCy2OljNlwIVn8fHHw5QMr76SAne2fHyLt+/gMWmW663UYFDYaCc5Thz
   w==;
X-CSE-ConnectionGUID: Hbn05cBtTDue4epMXvsOCg==
X-CSE-MsgGUID: 57brZXwkSySJ3tH7xDeMKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="30345996"
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="30345996"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 16:36:27 -0700
X-CSE-ConnectionGUID: XxQyaRCqSXyuVIDXULKEXw==
X-CSE-MsgGUID: C3TUiAweSGijsgzn4q6QHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="57361881"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 25 Jul 2024 16:36:25 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sX80V-000oY0-2M;
	Thu, 25 Jul 2024 23:36:23 +0000
Date: Fri, 26 Jul 2024 07:35:45 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 47/80] ld.lld: error: undefined
 symbol: __sys_bind
Message-ID: <202407260736.TZLqB0aJ-lkp@intel.com>
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
commit: 3a8a5eab63799a794f4ddff1de56fda059d5fc80 [47/80] ARM: OABI SYSCALL_DEFINEx
config: arm-randconfig-004-20240726 (https://download.01.org/0day-ci/archive/20240726/202407260736.TZLqB0aJ-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project ccae7b461be339e717d02f99ac857cf0bc7d17fc)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240726/202407260736.TZLqB0aJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407260736.TZLqB0aJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __sys_bind
   >>> referenced by sys_oabi-compat.c:434 (arch/arm/kernel/sys_oabi-compat.c:434)
   >>>               arch/arm/kernel/sys_oabi-compat.o:(__se_sys_oabi_bind) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: __sys_connect
   >>> referenced by sys_oabi-compat.c:445 (arch/arm/kernel/sys_oabi-compat.c:445)
   >>>               arch/arm/kernel/sys_oabi-compat.o:(__se_sys_oabi_connect) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: __sys_sendto
   >>> referenced by sys_oabi-compat.c:456 (arch/arm/kernel/sys_oabi-compat.c:456)
   >>>               arch/arm/kernel/sys_oabi-compat.o:(__se_sys_oabi_sendto) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: __sys_sendmsg
   >>> referenced by sys_oabi-compat.c:483 (arch/arm/kernel/sys_oabi-compat.c:483)
   >>>               arch/arm/kernel/sys_oabi-compat.o:(__se_sys_oabi_sendmsg) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

