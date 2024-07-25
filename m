Return-Path: <linux-arch+bounces-5628-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E0A93C0FB
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 13:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C6ABB216B6
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 11:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0866919922A;
	Thu, 25 Jul 2024 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ko+WbQFO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2647199221
	for <linux-arch@vger.kernel.org>; Thu, 25 Jul 2024 11:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721907487; cv=none; b=HO539jRIDoCbDq1g35ZbfNwE936H1a1PWl1vNPJZaYZtEkFfsoTopcefGRx1EIr1ZDi4QXzr4CXU7otmdXzwh9120TSfk23ONAZXotxAhVaD3HrUAihaVQLDcxlCfGVK0u1ThMg+2IPw+uXUKeYjMrWQYDN3M9fMmX+NiwSlKLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721907487; c=relaxed/simple;
	bh=1qJVu1HlWGKlDQ02P7SicY4UWLDa5VRCZhXK7FXvIW4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WnPl5xY48ETwihC65v4HWFfthSOSLbMu0PuyqFYPWWqtNahK2eGGGkM7OqAEbayrM7zfo5GKUtoEpoXqW3fAc9rWePtqsD4xOrALvKCa+cxzOqlbgsbJSQ0gFl3lnoC3fQdXAv0X32+MfBPSV7EZILnmvgwyv3ZvLemDLmF0+/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ko+WbQFO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721907485; x=1753443485;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1qJVu1HlWGKlDQ02P7SicY4UWLDa5VRCZhXK7FXvIW4=;
  b=Ko+WbQFODl4CMmxuApwDczKJwpCFS3tB0q1ECoZR1Wpg+R8YK7bAhzkk
   55/cqdz2WqqrR8MMus+IstS63wISJO/GvMVWFE3bLE8tjvpJCRPnrRVYv
   TpjSIjbGlhK9YngY97EgCor351nKbuNJ2jTPPposl7YZNo3Gcm+X+SOEc
   wToYE3WdYbEVWpZnwi0yRny+Bg2pTBPjNJWwE+Jo231NcRZYYewlSBz0T
   /27Q6t96J/jbZADBsYwZTTtmEim/pgWB6s6j1BqbVFtyoozyIADOhrycu
   8r/xoVV1NiSpZcWbY0fOBALJ/ude4IuMV7qEe9II1fG+7O6db2qO9wZF7
   A==;
X-CSE-ConnectionGUID: hoA86LHbSSKovAT8JK96iw==
X-CSE-MsgGUID: Tnnv23PVSJKVeey6Lx+2Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19777513"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="19777513"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 04:38:04 -0700
X-CSE-ConnectionGUID: ygZ2BTuiRmSrzG1NhThtpQ==
X-CSE-MsgGUID: Y5CqZRKORwGzMeiHY9xU/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="53140372"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 25 Jul 2024 04:38:03 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWwnI-000o3s-2Q;
	Thu, 25 Jul 2024 11:38:00 +0000
Date: Thu, 25 Jul 2024 19:37:58 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 77/80]
 include/linux/syscalls.h:247:42: error: 'sys_mmap' undeclared; did you mean
 'sys_mremap'?
Message-ID: <202407251910.EGPCqgCG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git syscall-tbl-6.11
head:   ece1b5ebc0b7064a8a130f64e85a81ec76381c3f
commit: ce67487a0460367a60a68fa3de3e66b8caaa3b7c [77/80] syscalls: check syscall prototypes
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20240725/202407251910.EGPCqgCG-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240725/202407251910.EGPCqgCG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407251910.EGPCqgCG-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/um/syscalls_64.c:10:
   arch/x86/um/syscalls_64.c: In function '__se_sys_mmap':
>> include/linux/syscalls.h:247:42: error: 'sys_mmap' undeclared (first use in this function); did you mean 'sys_mremap'?
     247 |                 (void)(__do_sys##name == sys##name);                    \
         |                                          ^~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   arch/x86/um/syscalls_64.c:56:1: note: in expansion of macro 'SYSCALL_DEFINE6'
      56 | SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:247:42: note: each undeclared identifier is reported only once for each function it appears in
     247 |                 (void)(__do_sys##name == sys##name);                    \
         |                                          ^~~
   include/linux/syscalls.h:229:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   arch/x86/um/syscalls_64.c:56:1: note: in expansion of macro 'SYSCALL_DEFINE6'
      56 | SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
         | ^~~~~~~~~~~~~~~


vim +247 include/linux/syscalls.h

   232	
   233	/*
   234	 * The asmlinkage stub is aliased to a function named __se_sys_*() which
   235	 * sign-extends 32-bit ints to longs whenever needed. The actual work is
   236	 * done within __do_sys_*().
   237	 */
   238	#ifndef __SYSCALL_DEFINEx
   239	#define __SYSCALL_DEFINEx(x, name, ...)					\
   240		ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
   241		static inline asmlinkage long					\
   242			__do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));		\
   243		asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
   244		asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
   245		{								\
   246			long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
 > 247			(void)(__do_sys##name == sys##name);			\
   248			__MAP(x,__SC_TEST,__VA_ARGS__);				\
   249			__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
   250			return ret;						\
   251		}								\
   252		__diag_push();							\
   253		__diag_ignore(GCC, 8, "-Wattribute-alias",			\
   254			      "Type aliasing is used to sanitize syscall arguments");\
   255		asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
   256			__attribute__((alias(__stringify(__se_sys##name))));	\
   257		__diag_pop();							\
   258		static inline asmlinkage long					\
   259			__do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
   260	#endif /* __SYSCALL_DEFINEx */
   261	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

