Return-Path: <linux-arch+bounces-5610-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B0B93B001
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 12:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25952822F5
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 10:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE49C155A5C;
	Wed, 24 Jul 2024 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eFUIiBmE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832C1156899
	for <linux-arch@vger.kernel.org>; Wed, 24 Jul 2024 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721818459; cv=none; b=TRs3Egm0DSHuDAH5ueuPon0UwVpEOnoTBbL550blI2x34QR07/4VAfO5sFpjYs0g6SPmGNVOerhnJgcoKFb7DTjyL8tosHndFmV/GnWHCraxTTQkHNfXiELtHLgDtVcZPFqrNzZVdCGYkmsdFZ99ZmV+xx0eyqGS962d5MrJGo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721818459; c=relaxed/simple;
	bh=O92uVk17AibkA+S3QabM4bJLyFSh0yz7YEDwLStjp1s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rdTQ1Ow5pSot1A3FuMxLgAr8twq7Lk4iKqkWj1KPEASkU+QdSRPKAcgfIWHkkonELYjUCPsHY6tZDCxa577w/P/YTa1ZXwj6KTFVwNyYFmZGZgt7FKFZxwjWrFspP3DYQ5QYcrIDNq3w2tTlMOBEesHL5Ge+skDDDBYpX8phKcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eFUIiBmE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721818458; x=1753354458;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O92uVk17AibkA+S3QabM4bJLyFSh0yz7YEDwLStjp1s=;
  b=eFUIiBmE+7cHU8/OvlVNRuNkM4t4rn7ViVjVIFJIpAX8xYezh8MYDRx+
   BCrddJVj5TtxFl2Fp2+MXDVJqjzuKSETcptjTE1cQ5/Yn3m0uIbO6eKrj
   PgjRYrlT31LmyJwY+3Pj2PeZsvb4+TgpT1ME2DhaD4u90kGyJdvKSRne6
   DtxjLskclYJ74fHAn/mqb99NqknzijySvDqy8wnHAEmgaIClVWXPlmqNI
   ntl451ES7y/8AGvWcMOtaN7ZWK5PxLoUuByhd0G9RLMEteeoWlBYxyTPM
   L4bkg+CCxZMZ1mjJ4EBr5PH0CCu18EU5V/BHa9t0hCaDPUN+BsJZ28+L4
   g==;
X-CSE-ConnectionGUID: hTPqS+IZRcCj0f2XMpjYaw==
X-CSE-MsgGUID: SGNvKDIISaOLGBQd5obrmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19626285"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="19626285"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 03:54:18 -0700
X-CSE-ConnectionGUID: Due5+Q1VS1eNs8F+Y9N5xw==
X-CSE-MsgGUID: 9DuWBqJYTieNIoDAx4dgoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="90014094"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 24 Jul 2024 03:54:16 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWZdN-000muO-2B;
	Wed, 24 Jul 2024 10:54:13 +0000
Date: Wed, 24 Jul 2024 18:53:55 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 44/80]
 include/linux/syscalls.h:251:25: error: conflicting types for
 'sys_oabi_sendto'; have 'long int(int,  void *, size_t,  unsigned int)' {aka
 'long int(int,  void *, unsigned int,  unsigned int)'}
Message-ID: <202407241835.aJUft8p5-lkp@intel.com>
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
commit: 2263955b209e2016dc9f30d129e356f4123310d5 [44/80] ARM: OABI SYSCALL_DEFINEx
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20240724/202407241835.aJUft8p5-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240724/202407241835.aJUft8p5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407241835.aJUft8p5-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm/kernel/sys_oabi-compat.c:75:
>> include/linux/syscalls.h:251:25: error: conflicting types for 'sys_oabi_sendto'; have 'long int(int,  void *, size_t,  unsigned int)' {aka 'long int(int,  void *, unsigned int,  unsigned int)'}
     251 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                         ^~~
   include/linux/syscalls.h:237:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     237 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:227:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     227 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:448:1: note: in expansion of macro 'SYSCALL_DEFINE4'
     448 | SYSCALL_DEFINE4(oabi_sendto, int, fd, void __user *, buff, size_t, len,
         | ^~~~~~~~~~~~~~~
   In file included from arch/arm/kernel/sys_oabi-compat.c:13:
   arch/arm/include/asm/syscalls.h:41:17: note: previous declaration of 'sys_oabi_sendto' with type 'long int(int,  void *, size_t,  unsigned int,  struct sockaddr *, int)' {aka 'long int(int,  void *, unsigned int,  unsigned int,  struct sockaddr *, int)'}
      41 | asmlinkage long sys_oabi_sendto(int fd, void __user *buff,
         |                 ^~~~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c: In function '__do_sys_oabi_sendto':
>> arch/arm/kernel/sys_oabi-compat.c:452:13: error: 'addrlen' undeclared (first use in this function)
     452 |         if (addrlen == 112 &&
         |             ^~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:452:13: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:13,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/uapi/linux/aio_abi.h:31,
                    from include/linux/syscalls.h:83:
>> arch/arm/kernel/sys_oabi-compat.c:453:34: error: 'addr' undeclared (first use in this function)
     453 |             get_user(sa_family, &addr->sa_family) == 0 &&
         |                                  ^~~~
   arch/arm/include/asm/uaccess.h:184:35: note: in definition of macro '__get_user_check'
     184 |                 register typeof(*(p)) __user *__p asm("r0") = (p);      \
         |                                   ^
   arch/arm/kernel/sys_oabi-compat.c:453:13: note: in expansion of macro 'get_user'
     453 |             get_user(sa_family, &addr->sa_family) == 0 &&
         |             ^~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c: In function '__do_sys_oabi_sendmsg':
>> arch/arm/kernel/sys_oabi-compat.c:483:16: error: too few arguments to function '__sys_sendmsg'
     483 |         return __sys_sendmsg(fd, msg, flags);
         |                ^~~~~~~~~~~~~
   In file included from arch/arm/kernel/sys_oabi-compat.c:83:
   include/linux/socket.h:411:13: note: declared here
     411 | extern long __sys_sendmsg(int fd, struct user_msghdr __user *msg,
         |             ^~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c: In function '__do_sys_oabi_socketcall':
>> arch/arm/kernel/sys_oabi-compat.c:501:29: error: too many arguments to function 'sys_oabi_sendto'
     501 |                         r = sys_oabi_sendto(a[0], (void __user *)a[1], a[2], a[3],
         |                             ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:251:25: note: declared here
     251 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                         ^~~
   include/linux/syscalls.h:237:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     237 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:227:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     227 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:448:1: note: in expansion of macro 'SYSCALL_DEFINE4'
     448 | SYSCALL_DEFINE4(oabi_sendto, int, fd, void __user *, buff, size_t, len,
         | ^~~~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c: In function '__do_sys_oabi_sendto':
   arch/arm/kernel/sys_oabi-compat.c:457:1: warning: control reaches end of non-void function [-Wreturn-type]
     457 | }
         | ^
   arch/arm/kernel/sys_oabi-compat.c: In function '__do_sys_oabi_sendmsg':
   arch/arm/kernel/sys_oabi-compat.c:484:1: warning: control reaches end of non-void function [-Wreturn-type]
     484 | }
         | ^


vim +251 include/linux/syscalls.h

1bd21c6c21e848 Dominik Brodowski   2018-04-05  240  
e145242ea0df6b Dominik Brodowski   2018-04-09  241  /*
e145242ea0df6b Dominik Brodowski   2018-04-09  242   * The asmlinkage stub is aliased to a function named __se_sys_*() which
e145242ea0df6b Dominik Brodowski   2018-04-09  243   * sign-extends 32-bit ints to longs whenever needed. The actual work is
e145242ea0df6b Dominik Brodowski   2018-04-09  244   * done within __do_sys_*().
e145242ea0df6b Dominik Brodowski   2018-04-09  245   */
1bd21c6c21e848 Dominik Brodowski   2018-04-05  246  #ifndef __SYSCALL_DEFINEx
bed1ffca022cc8 Frederic Weisbecker 2009-03-13  247  #define __SYSCALL_DEFINEx(x, name, ...)					\
bee20031772af3 Arnd Bergmann       2018-06-19  248  	__diag_push();							\
bee20031772af3 Arnd Bergmann       2018-06-19  249  	__diag_ignore(GCC, 8, "-Wattribute-alias",			\
bee20031772af3 Arnd Bergmann       2018-06-19  250  		      "Type aliasing is used to sanitize syscall arguments");\
83460ec8dcac14 Andi Kleen          2013-11-12 @251  	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
e145242ea0df6b Dominik Brodowski   2018-04-09  252  		__attribute__((alias(__stringify(__se_sys##name))));	\
c9a211951c7c79 Howard McLauchlan   2018-03-21  253  	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
e145242ea0df6b Dominik Brodowski   2018-04-09  254  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
e145242ea0df6b Dominik Brodowski   2018-04-09  255  	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
e145242ea0df6b Dominik Brodowski   2018-04-09  256  	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
1a94bc34768e46 Heiko Carstens      2009-01-14  257  	{								\
e145242ea0df6b Dominik Brodowski   2018-04-09  258  		long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
07fe6e00f6cca6 Al Viro             2013-01-21  259  		__MAP(x,__SC_TEST,__VA_ARGS__);				\
2cf0966683430b Al Viro             2013-01-21  260  		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
2cf0966683430b Al Viro             2013-01-21  261  		return ret;						\
1a94bc34768e46 Heiko Carstens      2009-01-14  262  	}								\
bee20031772af3 Arnd Bergmann       2018-06-19  263  	__diag_pop();							\
e145242ea0df6b Dominik Brodowski   2018-04-09  264  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
1bd21c6c21e848 Dominik Brodowski   2018-04-05  265  #endif /* __SYSCALL_DEFINEx */
1a94bc34768e46 Heiko Carstens      2009-01-14  266  

:::::: The code at line 251 was first introduced by commit
:::::: 83460ec8dcac14142e7860a01fa59c267ac4657c syscalls.h: use gcc alias instead of assembler aliases for syscalls

:::::: TO: Andi Kleen <ak@linux.intel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

