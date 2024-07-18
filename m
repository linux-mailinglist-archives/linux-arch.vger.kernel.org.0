Return-Path: <linux-arch+bounces-5488-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC67934790
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 07:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2441C20DBF
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 05:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9ED44376;
	Thu, 18 Jul 2024 05:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2lPAwxL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5898242067
	for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2024 05:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721280145; cv=none; b=nTcHNLrV9NoBGyXtMfc6s/1AgLX6Yc96IejqVIPxjS36HoLsod6puP5ta683REvjW4+QcA88ygZwsYEQwdS1HrnHPN1N1bm5yZtuDQAiIrCs4iJg4Kme8AAHt2TuXoRNvwJTz4Zg4f4X7g1r+K0LdNm6g6qvcbZUTgBEiGVV8R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721280145; c=relaxed/simple;
	bh=TdfOc33+SYvNyuK9hXRyxBvYS/T4PEYoY/HuLGCXBvk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eJsVwHWHC6frX+HwOneRelFAANS72RlFJllNibjPavpDkW1POCXSgOxu5bqO3lztNVLUh7A76/h1ml7TWyEz9qtcMv0/ifjweM5aRvMHZqsT7CB/GnrukENQ8dZdwP19l77aWd5Zf8/1wiob4WFbZOU1u68X/zTuots+iBGO7MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2lPAwxL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721280143; x=1752816143;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TdfOc33+SYvNyuK9hXRyxBvYS/T4PEYoY/HuLGCXBvk=;
  b=W2lPAwxL3sClpiKrBCXP+Z0ZYZJyaQ70fAqkj5/WUx0w2Iz48ElsyV1M
   Rf9Pe+/O1tXGMw0Wn6JmOZ5p+gHGyhV7cJyU7od+zMVyjz56X75sn0Fyd
   sNZt8bXBOCmgMKHkMgfJCwCEHn2wtKVrhvSRiXwSl+dnkfXv/1C8bDxmB
   qSlaVrrIVDLqEAoIvhkrrsm24uzw7N7hhZSElg/xxh0f8F+h2VN9Pcrod
   12d2QBnqXrSvLLjlveFd8JksMCQgLzHPHvF2ahYBw7hzobQCGWVcnxSOn
   o9OhMmCU9u0ezXOg4d/xgzuytOzSY8unoYjhS25EbvMBBxaZoq3BKxMBp
   A==;
X-CSE-ConnectionGUID: oQTcEKQDRNexgmjzJRKQ+g==
X-CSE-MsgGUID: I9QwEd75SUy/QFHCaB+SaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29977537"
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="29977537"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 22:22:21 -0700
X-CSE-ConnectionGUID: XkcS2m8mRU23OxHjpWz4Ag==
X-CSE-MsgGUID: iRaRNChZRby6EOKehsk7Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="55145823"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 17 Jul 2024 22:22:20 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUJar-000gyi-1s;
	Thu, 18 Jul 2024 05:22:17 +0000
Date: Thu, 18 Jul 2024 13:21:47 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 60/98]
 include/linux/syscalls.h:250:25: error: conflicting types for
 'sys_oabi_semtimedop'; have 'long int(int,  struct oabi_sembuf *, unsigned
 int)'
Message-ID: <202407181351.FWGCeOYe-lkp@intel.com>
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
commit: 39f4c859d147bb7d48fa363687c5afa2ab9b2893 [60/98] ARM: OABI SYSCALL_DEFINEx
config: arm-randconfig-004-20240718 (https://download.01.org/0day-ci/archive/20240718/202407181351.FWGCeOYe-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240718/202407181351.FWGCeOYe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407181351.FWGCeOYe-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm/kernel/sys_oabi-compat.c:75:
>> include/linux/syscalls.h:250:25: error: conflicting types for 'sys_oabi_semtimedop'; have 'long int(int,  struct oabi_sembuf *, unsigned int)'
     250 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                         ^~~
   include/linux/syscalls.h:236:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:225:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     225 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:407:1: note: in expansion of macro 'SYSCALL_DEFINE3'
     407 | SYSCALL_DEFINE3(oabi_semtimedop, int, semid, struct oabi_sembuf __user *, tsops,
         | ^~~~~~~~~~~~~~~
   In file included from arch/arm/kernel/sys_oabi-compat.c:13:
   arch/arm/include/asm/syscalls.h:30:17: note: previous declaration of 'sys_oabi_semtimedop' with type 'long int(int,  struct oabi_sembuf *, unsigned int,  const struct old_timespec32 *)'
      30 | asmlinkage long sys_oabi_semtimedop(int semid,
         |                 ^~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:250:25: error: conflicting types for 'sys_oabi_ipc'; have 'long int(uint,  int,  int,  int,  void *)' {aka 'long int(unsigned int,  int,  int,  int,  void *)'}
     250 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                         ^~~
   include/linux/syscalls.h:236:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:227:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     227 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:419:1: note: in expansion of macro 'SYSCALL_DEFINE5'
     419 | SYSCALL_DEFINE5(oabi_ipc, uint, call, int, first, int, second, int, third,
         | ^~~~~~~~~~~~~~~
   arch/arm/include/asm/syscalls.h:36:16: note: previous declaration of 'sys_oabi_ipc' with type 'int(uint,  int,  int,  int,  void *, long int)' {aka 'int(unsigned int,  int,  int,  int,  void *, long int)'}
      36 | asmlinkage int sys_oabi_ipc(uint call, int first, int second, int third,
         |                ^~~~~~~~~~~~
   include/linux/syscalls.h:250:25: error: conflicting types for 'sys_oabi_sendto'; have 'long int(int,  void *, size_t,  unsigned int)' {aka 'long int(int,  void *, unsigned int,  unsigned int)'}
     250 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                         ^~~
   include/linux/syscalls.h:236:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:226:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     226 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:448:1: note: in expansion of macro 'SYSCALL_DEFINE4'
     448 | SYSCALL_DEFINE4(oabi_sendto, int, fd, void __user *, buff, size_t, len,
         | ^~~~~~~~~~~~~~~
   arch/arm/include/asm/syscalls.h:41:17: note: previous declaration of 'sys_oabi_sendto' with type 'long int(int,  void *, size_t,  unsigned int,  struct sockaddr *, int)' {aka 'long int(int,  void *, unsigned int,  unsigned int,  struct sockaddr *, int)'}
      41 | asmlinkage long sys_oabi_sendto(int fd, void __user *buff,
         |                 ^~~~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c: In function '__do_sys_oabi_sendto':
   arch/arm/kernel/sys_oabi-compat.c:452:13: error: 'addrlen' undeclared (first use in this function)
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
                    from include/linux/syscalls.h:82:
   arch/arm/kernel/sys_oabi-compat.c:453:34: error: 'addr' undeclared (first use in this function)
     453 |             get_user(sa_family, &addr->sa_family) == 0 &&
         |                                  ^~~~
   arch/arm/include/asm/uaccess.h:184:35: note: in definition of macro '__get_user_check'
     184 |                 register typeof(*(p)) __user *__p asm("r0") = (p);      \
         |                                   ^
   arch/arm/kernel/sys_oabi-compat.c:453:13: note: in expansion of macro 'get_user'
     453 |             get_user(sa_family, &addr->sa_family) == 0 &&
         |             ^~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c: In function '__do_sys_oabi_sendmsg':
   arch/arm/kernel/sys_oabi-compat.c:483:16: error: too few arguments to function '__sys_sendmsg'
     483 |         return __sys_sendmsg(fd, msg, flags);
         |                ^~~~~~~~~~~~~
   In file included from arch/arm/kernel/sys_oabi-compat.c:83:
   include/linux/socket.h:411:13: note: declared here
     411 | extern long __sys_sendmsg(int fd, struct user_msghdr __user *msg,
         |             ^~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c: In function '__do_sys_oabi_socketcall':
   arch/arm/kernel/sys_oabi-compat.c:501:29: error: too many arguments to function 'sys_oabi_sendto'
     501 |                         r = sys_oabi_sendto(a[0], (void __user *)a[1], a[2], a[3],
         |                             ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:250:25: note: declared here
     250 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                         ^~~
   include/linux/syscalls.h:236:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:226:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     226 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
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


vim +250 include/linux/syscalls.h

1bd21c6c21e848 Dominik Brodowski   2018-04-05  239  
e145242ea0df6b Dominik Brodowski   2018-04-09  240  /*
e145242ea0df6b Dominik Brodowski   2018-04-09  241   * The asmlinkage stub is aliased to a function named __se_sys_*() which
e145242ea0df6b Dominik Brodowski   2018-04-09  242   * sign-extends 32-bit ints to longs whenever needed. The actual work is
e145242ea0df6b Dominik Brodowski   2018-04-09  243   * done within __do_sys_*().
e145242ea0df6b Dominik Brodowski   2018-04-09  244   */
1bd21c6c21e848 Dominik Brodowski   2018-04-05  245  #ifndef __SYSCALL_DEFINEx
bed1ffca022cc8 Frederic Weisbecker 2009-03-13  246  #define __SYSCALL_DEFINEx(x, name, ...)					\
bee20031772af3 Arnd Bergmann       2018-06-19  247  	__diag_push();							\
bee20031772af3 Arnd Bergmann       2018-06-19  248  	__diag_ignore(GCC, 8, "-Wattribute-alias",			\
bee20031772af3 Arnd Bergmann       2018-06-19  249  		      "Type aliasing is used to sanitize syscall arguments");\
83460ec8dcac14 Andi Kleen          2013-11-12 @250  	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
e145242ea0df6b Dominik Brodowski   2018-04-09  251  		__attribute__((alias(__stringify(__se_sys##name))));	\
c9a211951c7c79 Howard McLauchlan   2018-03-21  252  	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
e145242ea0df6b Dominik Brodowski   2018-04-09  253  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
e145242ea0df6b Dominik Brodowski   2018-04-09  254  	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
e145242ea0df6b Dominik Brodowski   2018-04-09  255  	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
1a94bc34768e46 Heiko Carstens      2009-01-14  256  	{								\
e145242ea0df6b Dominik Brodowski   2018-04-09  257  		long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
07fe6e00f6cca6 Al Viro             2013-01-21  258  		__MAP(x,__SC_TEST,__VA_ARGS__);				\
2cf0966683430b Al Viro             2013-01-21  259  		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
2cf0966683430b Al Viro             2013-01-21  260  		return ret;						\
1a94bc34768e46 Heiko Carstens      2009-01-14  261  	}								\
bee20031772af3 Arnd Bergmann       2018-06-19  262  	__diag_pop();							\
e145242ea0df6b Dominik Brodowski   2018-04-09  263  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
1bd21c6c21e848 Dominik Brodowski   2018-04-05  264  #endif /* __SYSCALL_DEFINEx */
1a94bc34768e46 Heiko Carstens      2009-01-14  265  

:::::: The code at line 250 was first introduced by commit
:::::: 83460ec8dcac14142e7860a01fa59c267ac4657c syscalls.h: use gcc alias instead of assembler aliases for syscalls

:::::: TO: Andi Kleen <ak@linux.intel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

