Return-Path: <linux-arch+bounces-5604-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D174E93AD5B
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 09:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F841F22C40
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 07:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BAE12F59C;
	Wed, 24 Jul 2024 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlDdeDL+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EC174409
	for <linux-arch@vger.kernel.org>; Wed, 24 Jul 2024 07:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807114; cv=none; b=mgYbMF29RGJKESRX3HCAz59Cu8VLJFCEy9r4phkRITnabnAnmTPOxyj2e85O0eKCc6Dwr5GbbheGlr/r7ajr600MiodtBOIdO2CpDXGQC4cJoj9r1gAbKyLqSmZQJQ68Lw5SIeLJDf1fZd2+cEnQMsMq5k4fo3wK8elCDBpLdm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807114; c=relaxed/simple;
	bh=EHSZX5YkojSNNXmBnmJCsu4S0sbiiSFHtGhpyoZakeo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J2MC697BOikgL4zhSf2hyAkkPkquzG3Tny+AkOZChSuexAel+82cHtOi/T6MZmxUaP6uwwHK51swZwco53PabUDJ0dbyUPWWy8Us7C6a4wUolqVbbZbq9KAggekQT17VsHsL+qfVO+JE1Cuzup+dLbw3zmEcNON3sHMFnN0KN/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlDdeDL+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721807113; x=1753343113;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EHSZX5YkojSNNXmBnmJCsu4S0sbiiSFHtGhpyoZakeo=;
  b=MlDdeDL+441SGmpVeyttd/8cdk4OSFPZiaCTrQuV7LaJG3EBSsYPtwAU
   nM6Gnqy18VT8pmfaHLHvLJLQveT4xkpn7ldtJUxjDTKrgZxvBC3xsPMei
   wjtawzejmhlaP4eOMF5LgsA9HpLdNH8wsA/JonkD/L8w0/TJ8tVQ/hvyP
   6CBVXwct1KjdCY1wBvvwMMLukVXdKOnpFBOVDjlTXyCUcL1lKoi86zfz9
   2j6iVUEDn3QZ3nr3PesbXCjuvv0V5Fgjgd99ftcFb5nsHohFAHggZA2GX
   M/A+7rou8UqwAtfBKP30TmotpSqcVS0ezijnHzYI0WnFJ5pTCisovR04T
   w==;
X-CSE-ConnectionGUID: Br7gqavHT/Kfrktx+uwH8w==
X-CSE-MsgGUID: NHa8UvNkTlyE75iCI6uJsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="44894100"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="44894100"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 00:45:12 -0700
X-CSE-ConnectionGUID: yCiRd8aoQbeRYr1aKZdExw==
X-CSE-MsgGUID: /fYG26j+QxqKdiQvudJq+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="53096576"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 24 Jul 2024 00:45:11 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWWgO-000mmw-1J;
	Wed, 24 Jul 2024 07:45:08 +0000
Date: Wed, 24 Jul 2024 15:44:57 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 77/80]
 arch/arm/kernel/sys_oabi-compat.c:448:1: warning: comparison of distinct
 pointer types ('long (*)(int, void *, size_t, unsigned int)' (aka 'long
 (*)(int, void *, unsigned int, unsigned int)') and 'long (*)(int, void *,
 size_t, unsigned int, struct sockadd...
Message-ID: <202407241512.6bjBAKyO-lkp@intel.com>
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
config: arm-randconfig-002-20240724 (https://download.01.org/0day-ci/archive/20240724/202407241512.6bjBAKyO-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ad154281230d83ee551e12d5be48bb956ef47ed3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240724/202407241512.6bjBAKyO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407241512.6bjBAKyO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/arm/kernel/sys_oabi-compat.c:75:
   In file included from include/linux/syscalls.h:86:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:6:
   In file included from include/linux/ring_buffer.h:5:
   In file included from include/linux/mm.h:2221:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> arch/arm/kernel/sys_oabi-compat.c:407:1: warning: comparison of distinct pointer types ('long (*)(int, struct oabi_sembuf *, unsigned int)' and 'long (*)(int, struct oabi_sembuf *, unsigned int, const struct old_timespec32 *)') [-Wcompare-distinct-pointer-types]
     407 | SYSCALL_DEFINE3(oabi_semtimedop, int, semid, struct oabi_sembuf __user *, tsops,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     408 |                 unsigned, nsops, const struct old_timespec32 __user *, timeout)
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:218:36: note: expanded from macro 'SYSCALL_DEFINE3'
     218 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:229:2: note: expanded from macro 'SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:247:25: note: expanded from macro '__SYSCALL_DEFINEx'
     247 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:407:1: error: conflicting types for 'sys_oabi_semtimedop'
   include/linux/syscalls.h:218:36: note: expanded from macro 'SYSCALL_DEFINE3'
     218 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^
   include/linux/syscalls.h:229:2: note: expanded from macro 'SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^
   include/linux/syscalls.h:255:18: note: expanded from macro '__SYSCALL_DEFINEx'
     255 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                         ^
   <scratch space>:38:1: note: expanded from here
      38 | sys_oabi_semtimedop
         | ^
   arch/arm/include/asm/syscalls.h:30:17: note: previous declaration is here
      30 | asmlinkage long sys_oabi_semtimedop(int semid,
         |                 ^
>> arch/arm/kernel/sys_oabi-compat.c:419:1: warning: comparison of distinct pointer types ('long (*)(uint, int, int, int, void *)' (aka 'long (*)(unsigned int, int, int, int, void *)') and 'long (*)(uint, int, int, int, void *, long)' (aka 'long (*)(unsigned int, int, int, int, void *, long)')) [-Wcompare-distinct-pointer-types]
     419 | SYSCALL_DEFINE5(oabi_ipc, uint, call, int, first, int, second, int, third,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     420 |                 void __user *, ptr, long, fifth)
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:220:36: note: expanded from macro 'SYSCALL_DEFINE5'
     220 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:229:2: note: expanded from macro 'SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:247:25: note: expanded from macro '__SYSCALL_DEFINEx'
     247 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:419:1: error: conflicting types for 'sys_oabi_ipc'
   include/linux/syscalls.h:220:36: note: expanded from macro 'SYSCALL_DEFINE5'
     220 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^
   include/linux/syscalls.h:229:2: note: expanded from macro 'SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^
   include/linux/syscalls.h:255:18: note: expanded from macro '__SYSCALL_DEFINEx'
     255 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                         ^
   <scratch space>:158:1: note: expanded from here
     158 | sys_oabi_ipc
         | ^
   arch/arm/include/asm/syscalls.h:36:17: note: previous declaration is here
      36 | asmlinkage long sys_oabi_ipc(uint call, int first, int second, int third,
         |                 ^
>> arch/arm/kernel/sys_oabi-compat.c:448:1: warning: comparison of distinct pointer types ('long (*)(int, void *, size_t, unsigned int)' (aka 'long (*)(int, void *, unsigned int, unsigned int)') and 'long (*)(int, void *, size_t, unsigned int, struct sockaddr *, int)' (aka 'long (*)(int, void *, unsigned int, unsigned int, struct sockaddr *, int)')) [-Wcompare-distinct-pointer-types]
     448 | SYSCALL_DEFINE4(oabi_sendto, int, fd, void __user *, buff, size_t, len,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     449 |                 unsigned, flags, struct sockaddr __user *, addr, int, addrlen)
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:219:36: note: expanded from macro 'SYSCALL_DEFINE4'
     219 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:229:2: note: expanded from macro 'SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:247:25: note: expanded from macro '__SYSCALL_DEFINEx'
     247 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:448:1: error: conflicting types for 'sys_oabi_sendto'
   include/linux/syscalls.h:219:36: note: expanded from macro 'SYSCALL_DEFINE4'
     219 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^
   include/linux/syscalls.h:229:2: note: expanded from macro 'SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^
   include/linux/syscalls.h:255:18: note: expanded from macro '__SYSCALL_DEFINEx'
     255 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                         ^
   <scratch space>:135:1: note: expanded from here
     135 | sys_oabi_sendto
         | ^
   arch/arm/include/asm/syscalls.h:41:17: note: previous declaration is here
      41 | asmlinkage long sys_oabi_sendto(int fd, void __user *buff,
         |                 ^
   arch/arm/kernel/sys_oabi-compat.c:453:27: error: use of undeclared identifier 'addr'
     453 |             get_user(sa_family, &addr->sa_family) == 0 &&
         |                                  ^
   arch/arm/kernel/sys_oabi-compat.c:453:27: error: use of undeclared identifier 'addr'
   arch/arm/kernel/sys_oabi-compat.c:453:27: error: use of undeclared identifier 'addr'
   arch/arm/kernel/sys_oabi-compat.c:452:6: error: use of undeclared identifier 'addrlen'; did you mean 'strlen'?
     452 |         if (addrlen == 112 &&
         |             ^~~~~~~
         |             strlen
   include/linux/string.h:196:24: note: 'strlen' declared here
     196 | extern __kernel_size_t strlen(const char *);
         |                        ^
   arch/arm/kernel/sys_oabi-compat.c:455:4: error: use of undeclared identifier 'addrlen'
     455 |                         addrlen = 110;
         |                         ^
   arch/arm/kernel/sys_oabi-compat.c:456:44: error: use of undeclared identifier 'addr'
     456 |         return __sys_sendto(fd, buff, len, flags, addr, addrlen);
         |                                                   ^
   arch/arm/kernel/sys_oabi-compat.c:456:50: error: use of undeclared identifier 'addrlen'
     456 |         return __sys_sendto(fd, buff, len, flags, addr, addrlen);
         |                                                         ^
   arch/arm/kernel/sys_oabi-compat.c:483:37: error: too few arguments to function call, expected 4, have 3
     483 |         return __sys_sendmsg(fd, msg, flags);
         |                ~~~~~~~~~~~~~               ^
   include/linux/socket.h:411:13: note: '__sys_sendmsg' declared here
     411 | extern long __sys_sendmsg(int fd, struct user_msghdr __user *msg,
         |             ^             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     412 |                           unsigned int flags, bool forbid_cmsg_compat);
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   4 warnings and 11 errors generated.


vim +448 arch/arm/kernel/sys_oabi-compat.c

687ad0191488a0 Nicolas Pitre 2006-01-14  388  
2263955b209e20 Arnd Bergmann 2024-07-05  389  SYSCALL_DEFINE6(oabi_ipc, uint, call, int, first, int, second, int, third,
2263955b209e20 Arnd Bergmann 2024-07-05  390  		void __user *, ptr, long, fifth)
687ad0191488a0 Nicolas Pitre 2006-01-14  391  {
687ad0191488a0 Nicolas Pitre 2006-01-14  392  	switch (call & 0xffff) {
687ad0191488a0 Nicolas Pitre 2006-01-14  393  	case SEMOP:
687ad0191488a0 Nicolas Pitre 2006-01-14  394  		return  sys_oabi_semtimedop(first,
687ad0191488a0 Nicolas Pitre 2006-01-14  395  					    (struct oabi_sembuf __user *)ptr,
687ad0191488a0 Nicolas Pitre 2006-01-14  396  					    second, NULL);
687ad0191488a0 Nicolas Pitre 2006-01-14  397  	case SEMTIMEDOP:
687ad0191488a0 Nicolas Pitre 2006-01-14  398  		return  sys_oabi_semtimedop(first,
687ad0191488a0 Nicolas Pitre 2006-01-14  399  					    (struct oabi_sembuf __user *)ptr,
687ad0191488a0 Nicolas Pitre 2006-01-14  400  					    second,
00bf25d693e7f6 Arnd Bergmann 2019-01-01  401  					    (const struct old_timespec32 __user *)fifth);
687ad0191488a0 Nicolas Pitre 2006-01-14  402  	default:
687ad0191488a0 Nicolas Pitre 2006-01-14  403  		return sys_ipc(call, first, second, third, ptr, fifth);
687ad0191488a0 Nicolas Pitre 2006-01-14  404  	}
687ad0191488a0 Nicolas Pitre 2006-01-14  405  }
bdec0145286f7e Arnd Bergmann 2021-08-11  406  #else
2263955b209e20 Arnd Bergmann 2024-07-05 @407  SYSCALL_DEFINE3(oabi_semtimedop, int, semid, struct oabi_sembuf __user *, tsops,
2263955b209e20 Arnd Bergmann 2024-07-05  408  		unsigned, nsops, const struct old_timespec32 __user *, timeout)
bdec0145286f7e Arnd Bergmann 2021-08-11  409  {
bdec0145286f7e Arnd Bergmann 2021-08-11  410  	return -ENOSYS;
bdec0145286f7e Arnd Bergmann 2021-08-11  411  }
bdec0145286f7e Arnd Bergmann 2021-08-11  412  
2263955b209e20 Arnd Bergmann 2024-07-05  413  SYSCALL_DEFINE3(oabi_semop, int, semid, struct oabi_sembuf __user *, tsops,
2263955b209e20 Arnd Bergmann 2024-07-05  414  		unsigned, nsops)
bdec0145286f7e Arnd Bergmann 2021-08-11  415  {
bdec0145286f7e Arnd Bergmann 2021-08-11  416  	return -ENOSYS;
bdec0145286f7e Arnd Bergmann 2021-08-11  417  }
bdec0145286f7e Arnd Bergmann 2021-08-11  418  
2263955b209e20 Arnd Bergmann 2024-07-05 @419  SYSCALL_DEFINE5(oabi_ipc, uint, call, int, first, int, second, int, third,
2263955b209e20 Arnd Bergmann 2024-07-05  420  		void __user *, ptr, long, fifth)
bdec0145286f7e Arnd Bergmann 2021-08-11  421  {
bdec0145286f7e Arnd Bergmann 2021-08-11  422  	return -ENOSYS;
bdec0145286f7e Arnd Bergmann 2021-08-11  423  }
bdec0145286f7e Arnd Bergmann 2021-08-11  424  #endif
99595d0237926b Nicolas Pitre 2006-02-08  425  
2263955b209e20 Arnd Bergmann 2024-07-05  426  SYSCALL_DEFINE3(oabi_bind, int, fd, struct sockaddr __user *, addr,
2263955b209e20 Arnd Bergmann 2024-07-05  427  		int, addrlen)
99595d0237926b Nicolas Pitre 2006-02-08  428  {
99595d0237926b Nicolas Pitre 2006-02-08  429  	sa_family_t sa_family;
99595d0237926b Nicolas Pitre 2006-02-08  430  	if (addrlen == 112 &&
99595d0237926b Nicolas Pitre 2006-02-08  431  	    get_user(sa_family, &addr->sa_family) == 0 &&
99595d0237926b Nicolas Pitre 2006-02-08  432  	    sa_family == AF_UNIX)
99595d0237926b Nicolas Pitre 2006-02-08  433  			addrlen = 110;
2263955b209e20 Arnd Bergmann 2024-07-05  434  	return __sys_bind(fd, addr, addrlen);
99595d0237926b Nicolas Pitre 2006-02-08  435  }
99595d0237926b Nicolas Pitre 2006-02-08  436  
2263955b209e20 Arnd Bergmann 2024-07-05  437  SYSCALL_DEFINE3(oabi_connect, int, fd, struct sockaddr __user *, addr,
2263955b209e20 Arnd Bergmann 2024-07-05  438  		int, addrlen)
99595d0237926b Nicolas Pitre 2006-02-08  439  {
99595d0237926b Nicolas Pitre 2006-02-08  440  	sa_family_t sa_family;
99595d0237926b Nicolas Pitre 2006-02-08  441  	if (addrlen == 112 &&
99595d0237926b Nicolas Pitre 2006-02-08  442  	    get_user(sa_family, &addr->sa_family) == 0 &&
99595d0237926b Nicolas Pitre 2006-02-08  443  	    sa_family == AF_UNIX)
99595d0237926b Nicolas Pitre 2006-02-08  444  			addrlen = 110;
2263955b209e20 Arnd Bergmann 2024-07-05  445  	return __sys_connect(fd, addr, addrlen);
99595d0237926b Nicolas Pitre 2006-02-08  446  }
99595d0237926b Nicolas Pitre 2006-02-08  447  
2263955b209e20 Arnd Bergmann 2024-07-05 @448  SYSCALL_DEFINE4(oabi_sendto, int, fd, void __user *, buff, size_t, len,
2263955b209e20 Arnd Bergmann 2024-07-05  449  		unsigned, flags, struct sockaddr __user *, addr, int, addrlen)
99595d0237926b Nicolas Pitre 2006-02-08  450  {
99595d0237926b Nicolas Pitre 2006-02-08  451  	sa_family_t sa_family;
99595d0237926b Nicolas Pitre 2006-02-08  452  	if (addrlen == 112 &&
99595d0237926b Nicolas Pitre 2006-02-08  453  	    get_user(sa_family, &addr->sa_family) == 0 &&
99595d0237926b Nicolas Pitre 2006-02-08  454  	    sa_family == AF_UNIX)
99595d0237926b Nicolas Pitre 2006-02-08  455  			addrlen = 110;
2263955b209e20 Arnd Bergmann 2024-07-05  456  	return __sys_sendto(fd, buff, len, flags, addr, addrlen);
99595d0237926b Nicolas Pitre 2006-02-08  457  }
99595d0237926b Nicolas Pitre 2006-02-08  458  

:::::: The code at line 448 was first introduced by commit
:::::: 2263955b209e2016dc9f30d129e356f4123310d5 ARM: OABI SYSCALL_DEFINEx

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

