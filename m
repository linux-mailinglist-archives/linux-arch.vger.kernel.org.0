Return-Path: <linux-arch+bounces-5600-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6B193AC80
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 08:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5394283CCE
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 06:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F283E49D;
	Wed, 24 Jul 2024 06:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCsYW7+Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B99A955
	for <linux-arch@vger.kernel.org>; Wed, 24 Jul 2024 06:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721801833; cv=none; b=FbLwtx56BW9Bi8NEEthntSPD/Wd6BgKMnsITtY81lh+OWnC/MxJam3xrJeqpVf+zGL9P0fIIsL+mnyR6VzoE5zzjqeefz30rBpLMLp2+HjuGyvBVCe5A9cKZE8mdYUMLNlUWDR+MTF9auhAw3otLT21eLrEO2mNWoJVurCl/gi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721801833; c=relaxed/simple;
	bh=DiCy9StFkun7363ekKwZAhuwCJgO/Bk11qlQlQnKNq0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YuPs65UqcCBasZ8C+u5IS2VHcHvjKxbtHpIaaDpMvGGB3ejOAXrhONYmKhyTOiEYcaWJHUwJlhTqj4rhHhk9HsxmZS6tlPyRjlkG9OMI+WDZs42406hXzRdRR2nM6/9wIRnxBUOV8M8oYxPK8u2BaiA5QWbFnjp/JkfjcSKrENs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCsYW7+Q; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721801831; x=1753337831;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DiCy9StFkun7363ekKwZAhuwCJgO/Bk11qlQlQnKNq0=;
  b=hCsYW7+Q3SxQJjqyeLo852Ixovtmk2JPRuPflB5oWdK38v2/Oc9tqvbo
   pAKM2pCkgtK+gv4mjCiklu4uNeFUMqulhdbiIaeaobDOuUrWMWrNxM17r
   KwFBMQX+LIHstq2u7coDeTMIvOVsYhTBAxs86Z+du5MdWCo26fcwX0Geo
   NQPpsn+8mR2b1ikUlpjvy8oBFN6mkoXxHNrqZO0Ebi6nc1Jm8iZe0huUq
   bcjPENyTLu6PPJXL6mCrc8OtQSC5T7RkVNrU26W5AW5hpBTRPPaCRU2rN
   4w2/GoS9CWG+0v1+OR7hecRGDltSYcQH8EVkh3KjgI26xET/kOLtaiIiU
   A==;
X-CSE-ConnectionGUID: ZjzLbjitTTKnFcSpNqydaQ==
X-CSE-MsgGUID: Cb0lnewvRLC1ZerMGVbziA==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="30120884"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="30120884"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 23:17:10 -0700
X-CSE-ConnectionGUID: nMa7u0mGTUiGfupmpEd5+Q==
X-CSE-MsgGUID: HNvv+WY2T8uRNUp2rLk4Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="53248693"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 23 Jul 2024 23:17:08 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWVJC-000mjw-0t;
	Wed, 24 Jul 2024 06:17:06 +0000
Date: Wed, 24 Jul 2024 14:16:52 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 44/80]
 arch/arm/kernel/sys_oabi-compat.c:407:1: error: conflicting types for
 'sys_oabi_semtimedop'
Message-ID: <202407241416.GGWdAKAR-lkp@intel.com>
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
config: arm-randconfig-002-20240724 (https://download.01.org/0day-ci/archive/20240724/202407241416.GGWdAKAR-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ad154281230d83ee551e12d5be48bb956ef47ed3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240724/202407241416.GGWdAKAR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407241416.GGWdAKAR-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm/kernel/sys_oabi-compat.c:75:
   In file included from include/linux/syscalls.h:94:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:6:
   In file included from include/linux/ring_buffer.h:5:
   In file included from include/linux/mm.h:2221:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> arch/arm/kernel/sys_oabi-compat.c:407:1: error: conflicting types for 'sys_oabi_semtimedop'
     407 | SYSCALL_DEFINE3(oabi_semtimedop, int, semid, struct oabi_sembuf __user *, tsops,
         | ^
   include/linux/syscalls.h:226:36: note: expanded from macro 'SYSCALL_DEFINE3'
     226 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^
   include/linux/syscalls.h:237:2: note: expanded from macro 'SYSCALL_DEFINEx'
     237 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^
   include/linux/syscalls.h:251:18: note: expanded from macro '__SYSCALL_DEFINEx'
     251 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                         ^
   <scratch space>:16:1: note: expanded from here
      16 | sys_oabi_semtimedop
         | ^
   arch/arm/include/asm/syscalls.h:30:17: note: previous declaration is here
      30 | asmlinkage long sys_oabi_semtimedop(int semid,
         |                 ^
>> arch/arm/kernel/sys_oabi-compat.c:419:1: error: conflicting types for 'sys_oabi_ipc'
     419 | SYSCALL_DEFINE5(oabi_ipc, uint, call, int, first, int, second, int, third,
         | ^
   include/linux/syscalls.h:228:36: note: expanded from macro 'SYSCALL_DEFINE5'
     228 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^
   include/linux/syscalls.h:237:2: note: expanded from macro 'SYSCALL_DEFINEx'
     237 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^
   include/linux/syscalls.h:251:18: note: expanded from macro '__SYSCALL_DEFINEx'
     251 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                         ^
   <scratch space>:132:1: note: expanded from here
     132 | sys_oabi_ipc
         | ^
   arch/arm/include/asm/syscalls.h:36:17: note: previous declaration is here
      36 | asmlinkage long sys_oabi_ipc(uint call, int first, int second, int third,
         |                 ^
>> arch/arm/kernel/sys_oabi-compat.c:448:1: error: conflicting types for 'sys_oabi_sendto'
     448 | SYSCALL_DEFINE4(oabi_sendto, int, fd, void __user *, buff, size_t, len,
         | ^
   include/linux/syscalls.h:227:36: note: expanded from macro 'SYSCALL_DEFINE4'
     227 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^
   include/linux/syscalls.h:237:2: note: expanded from macro 'SYSCALL_DEFINEx'
     237 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^
   include/linux/syscalls.h:251:18: note: expanded from macro '__SYSCALL_DEFINEx'
     251 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                         ^
   <scratch space>:89:1: note: expanded from here
      89 | sys_oabi_sendto
         | ^
   arch/arm/include/asm/syscalls.h:41:17: note: previous declaration is here
      41 | asmlinkage long sys_oabi_sendto(int fd, void __user *buff,
         |                 ^
>> arch/arm/kernel/sys_oabi-compat.c:453:27: error: use of undeclared identifier 'addr'
     453 |             get_user(sa_family, &addr->sa_family) == 0 &&
         |                                  ^
>> arch/arm/kernel/sys_oabi-compat.c:453:27: error: use of undeclared identifier 'addr'
>> arch/arm/kernel/sys_oabi-compat.c:453:27: error: use of undeclared identifier 'addr'
>> arch/arm/kernel/sys_oabi-compat.c:452:6: error: use of undeclared identifier 'addrlen'; did you mean 'strlen'?
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
>> arch/arm/kernel/sys_oabi-compat.c:483:37: error: too few arguments to function call, expected 4, have 3
     483 |         return __sys_sendmsg(fd, msg, flags);
         |                ~~~~~~~~~~~~~               ^
   include/linux/socket.h:411:13: note: '__sys_sendmsg' declared here
     411 | extern long __sys_sendmsg(int fd, struct user_msghdr __user *msg,
         |             ^             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     412 |                           unsigned int flags, bool forbid_cmsg_compat);
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 11 errors generated.


vim +/sys_oabi_semtimedop +407 arch/arm/kernel/sys_oabi-compat.c

   388	
   389	SYSCALL_DEFINE6(oabi_ipc, uint, call, int, first, int, second, int, third,
   390			void __user *, ptr, long, fifth)
   391	{
   392		switch (call & 0xffff) {
   393		case SEMOP:
   394			return  sys_oabi_semtimedop(first,
   395						    (struct oabi_sembuf __user *)ptr,
   396						    second, NULL);
   397		case SEMTIMEDOP:
   398			return  sys_oabi_semtimedop(first,
   399						    (struct oabi_sembuf __user *)ptr,
   400						    second,
   401						    (const struct old_timespec32 __user *)fifth);
   402		default:
   403			return sys_ipc(call, first, second, third, ptr, fifth);
   404		}
   405	}
   406	#else
 > 407	SYSCALL_DEFINE3(oabi_semtimedop, int, semid, struct oabi_sembuf __user *, tsops,
   408			unsigned, nsops, const struct old_timespec32 __user *, timeout)
   409	{
   410		return -ENOSYS;
   411	}
   412	
   413	SYSCALL_DEFINE3(oabi_semop, int, semid, struct oabi_sembuf __user *, tsops,
   414			unsigned, nsops)
   415	{
   416		return -ENOSYS;
   417	}
   418	
 > 419	SYSCALL_DEFINE5(oabi_ipc, uint, call, int, first, int, second, int, third,
   420			void __user *, ptr, long, fifth)
   421	{
   422		return -ENOSYS;
   423	}
   424	#endif
   425	
   426	SYSCALL_DEFINE3(oabi_bind, int, fd, struct sockaddr __user *, addr,
   427			int, addrlen)
   428	{
   429		sa_family_t sa_family;
   430		if (addrlen == 112 &&
   431		    get_user(sa_family, &addr->sa_family) == 0 &&
   432		    sa_family == AF_UNIX)
   433				addrlen = 110;
   434		return __sys_bind(fd, addr, addrlen);
   435	}
   436	
   437	SYSCALL_DEFINE3(oabi_connect, int, fd, struct sockaddr __user *, addr,
   438			int, addrlen)
   439	{
   440		sa_family_t sa_family;
   441		if (addrlen == 112 &&
   442		    get_user(sa_family, &addr->sa_family) == 0 &&
   443		    sa_family == AF_UNIX)
   444				addrlen = 110;
   445		return __sys_connect(fd, addr, addrlen);
   446	}
   447	
 > 448	SYSCALL_DEFINE4(oabi_sendto, int, fd, void __user *, buff, size_t, len,
   449			unsigned, flags, struct sockaddr __user *, addr, int, addrlen)
   450	{
   451		sa_family_t sa_family;
 > 452		if (addrlen == 112 &&
 > 453		    get_user(sa_family, &addr->sa_family) == 0 &&
   454		    sa_family == AF_UNIX)
   455				addrlen = 110;
   456		return __sys_sendto(fd, buff, len, flags, addr, addrlen);
   457	}
   458	
   459	SYSCALL_DEFINE3(oabi_sendmsg, int, fd, struct user_msghdr __user *, msg,
   460			unsigned, flags)
   461	{
   462		struct sockaddr __user *addr;
   463		int msg_namelen;
   464		sa_family_t sa_family;
   465		if (msg &&
   466		    get_user(msg_namelen, &msg->msg_namelen) == 0 &&
   467		    msg_namelen == 112 &&
   468		    get_user(addr, &msg->msg_name) == 0 &&
   469		    get_user(sa_family, &addr->sa_family) == 0 &&
   470		    sa_family == AF_UNIX)
   471		{
   472			/*
   473			 * HACK ALERT: there is a limit to how much backward bending
   474			 * we should do for what is actually a transitional
   475			 * compatibility layer.  This already has known flaws with
   476			 * a few ioctls that we don't intend to fix.  Therefore
   477			 * consider this blatent hack as another one... and take care
   478			 * to run for cover.  In most cases it will "just work fine".
   479			 * If it doesn't, well, tough.
   480			 */
   481			put_user(110, &msg->msg_namelen);
   482		}
 > 483		return __sys_sendmsg(fd, msg, flags);
   484	}
   485	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

