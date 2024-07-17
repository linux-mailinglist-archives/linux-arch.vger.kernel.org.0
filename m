Return-Path: <linux-arch+bounces-5480-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA518934520
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 01:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C4E1C215B1
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 23:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB7055897;
	Wed, 17 Jul 2024 23:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KWnmui7y"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06FF59167
	for <linux-arch@vger.kernel.org>; Wed, 17 Jul 2024 23:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721260090; cv=none; b=oaPJoOQTTpGy2Bj93kTyIbt2SHlmym9tEl3ZiAsBdee5mTUNw4MEhJ8iP9DcZTS0hksJwTUv/yYG0aK4IYUpE9zJ2podKtgECOe2NGr+DmKxSsX+xUBk2siANBug3UZdiFyMJ7VGQXt9gISh4fnBMJZFmZZwHtC+LR8dFPvgFGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721260090; c=relaxed/simple;
	bh=tAd1UVW5tfnF7oD0SLqiamFOfZacUa954E56pT5X6x0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hFXhUwrNVdDec1gF9x+hFCtToROgddNPG+Gm3yoH8ioWOJ2NFLG84YVSKt56Z7OCmP7HUTlVuZ/K8a/TA8xek1zG2R4FeWy0zNbdF86W2bx8PMyVWhPgXXaMzmYNCm6hqMUO8pbeN9rihCQMSC8p6kOclaNhMd4XNzMQIeOO/98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KWnmui7y; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721260088; x=1752796088;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tAd1UVW5tfnF7oD0SLqiamFOfZacUa954E56pT5X6x0=;
  b=KWnmui7yqNinft9k+E45UK5F8aM8DxD2N3iHmgd6Zy/RkM6GJ/0kY8PF
   qE+WRHvoxAi02lcEfWqiaQfOaUokpHosrr7IuiiqoImcPo9wnUjyEuyD6
   XXxHLSrevQSOI2DxbflfqbcOXwaZFsS6V8wcs7mXsvvmJ1KhynYkq9ws7
   6TkQD4O/dVZ0AzqVPX8AWnPd+D0loCabv/netmA++XYp+or9EWE0O1EPz
   22RQlXi/oTEbhiVuqDRtVaxAsWzCFgnnMuPI63nu4SEP58Lbd91OScLEr
   Sg3uppDmIrsbfPBpMYFOq/b/cSjdq6qoX3kOAnglf6akDLBJB/qvkKKMz
   w==;
X-CSE-ConnectionGUID: IHd7n9UdQGWJG/3d+KXrYg==
X-CSE-MsgGUID: tULGFJcjTgmkEAfYF+0IAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="41321435"
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="41321435"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 16:48:01 -0700
X-CSE-ConnectionGUID: oIejBMq5QSaNNz/R0fRlhA==
X-CSE-MsgGUID: G7Nwl4i5Q4iqOA5kN/2Nvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="54892849"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 17 Jul 2024 16:48:00 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUENJ-000glO-34;
	Wed, 17 Jul 2024 23:47:57 +0000
Date: Thu, 18 Jul 2024 07:47:00 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 92/98]
 arch/x86/include/asm/syscall_wrapper.h:230:60: error: 'sys_vm86old'
 undeclared here (not in a function); did you mean 'args__vm86old'?
Message-ID: <202407180703.0A04l6MZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git syscall-tbl-6.11
head:   9a99991d90521113a738c2a4761a4147fe4b31ca
commit: d079d82a6231c5cb40ba4b46f9d0634a36051523 [92/98] syscalls: check syscall prototypes
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240718/202407180703.0A04l6MZ-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240718/202407180703.0A04l6MZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407180703.0A04l6MZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/syscalls.h:95,
                    from arch/x86/kernel/vm86_32.c:37:
>> arch/x86/include/asm/syscall_wrapper.h:230:60: error: 'sys_vm86old' undeclared here (not in a function); did you mean 'args__vm86old'?
     230 |                         (__MAP(x,__SC_DECL,__VA_ARGS__)) = sys##name;   \
         |                                                            ^~~
   include/linux/syscalls.h:228:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:215:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     215 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   arch/x86/kernel/vm86_32.c:170:1: note: in expansion of macro 'SYSCALL_DEFINE1'
     170 | SYSCALL_DEFINE1(vm86old, struct vm86_struct __user *, user_vm86)
         | ^~~~~~~~~~~~~~~
>> arch/x86/include/asm/syscall_wrapper.h:230:60: error: 'sys_vm86' undeclared here (not in a function); did you mean 'do_sys_vm86'?
     230 |                         (__MAP(x,__SC_DECL,__VA_ARGS__)) = sys##name;   \
         |                                                            ^~~
   include/linux/syscalls.h:228:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:216:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     216 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   arch/x86/kernel/vm86_32.c:176:1: note: in expansion of macro 'SYSCALL_DEFINE2'
     176 | SYSCALL_DEFINE2(vm86, unsigned long, cmd, unsigned long, arg)
         | ^~~~~~~~~~~~~~~


vim +230 arch/x86/include/asm/syscall_wrapper.h

   226	
   227	#define __SYSCALL_DEFINEx(x, name, ...)					\
   228		static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
   229		static __maybe_unused asmlinkage long (*__typecheck_sys##name)	\
 > 230				(__MAP(x,__SC_DECL,__VA_ARGS__)) = sys##name;	\
   231		static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
   232		__X64_SYS_STUBx(x, name, __VA_ARGS__)				\
   233		__IA32_SYS_STUBx(x, name, __VA_ARGS__)				\
   234		static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
   235		{								\
   236			long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
   237			__MAP(x,__SC_TEST,__VA_ARGS__);				\
   238			__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
   239			return ret;						\
   240		}								\
   241		static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
   242	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

