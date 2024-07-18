Return-Path: <linux-arch+bounces-5499-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF724934E6E
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 15:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD192B20B46
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 13:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C0881745;
	Thu, 18 Jul 2024 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWKI+8GZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC541B86D0
	for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2024 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310111; cv=none; b=OGen7e6GJQ/GPMYotngjRY5DRZbPT3SpKzzEqy33ldGbQaX/LaeRG14KGestH8pihf5yPtHPzuDc7TfyLOubTg+cvwH3MyXYdN4nxTW6UnhF4LLV20tS4W+jj0W9h8Ri0UdVCwh2shBLJ8OwsUEGjaVbNijyvQP2ncSSmYOH2bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310111; c=relaxed/simple;
	bh=Ovc36BqXRQJz8W6QKeMfbXBy2Z86Md7KvtLAo11s4eE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=N0DGiIX0SXgx2oxL7iQ6Morust4TLdijWT6JyVuOWQQ7xgRki6PBBD5BxDGeEeJm8GNvrTR9h+I2TC+8ZSYPoMq87SY4hmcQsqmxarVofHkaepTg3eL6D7VKSLzYZrn/wtzuRVSAekRypxi7cmAu7ikLl6vbBUtzN1TwceP3tDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWKI+8GZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721310105; x=1752846105;
  h=date:from:to:cc:subject:message-id;
  bh=Ovc36BqXRQJz8W6QKeMfbXBy2Z86Md7KvtLAo11s4eE=;
  b=RWKI+8GZq/D9QGn7UZuIMeaxa+oWvDQ8JBjmdzl8a6M1Yc5JHCsvQGxC
   GeNYK1nXdywtkgwSUiqHroTCuMs5uWVvFT7YTeUlMn+d5FgEPdCkdvyON
   87PHMPztP2ONyzl4kCpL3/x0c5UYWumkjDfR2eQDxczYL3h3CZ7sQvQNC
   qweykHR2L2WBkOT+Xb8rA0jSTPiD3bMipR+wWszqU4WVI+0zMe+3tR5ZV
   d9jH+gHQqdGqPkYc+UqZHiBfwQs8BuSTu98dWmEsPVSUv3emwGCgkLoNg
   YXi1AhUXKVypmONMpIN+DnDqqU6KPcJMGX/PXO59//pgjFnI3LMLrRVRy
   Q==;
X-CSE-ConnectionGUID: 7EMGCfsMToqg4QcK9X1/QA==
X-CSE-MsgGUID: fw6MsQ59RwiSLIeqgpV9nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="44293406"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="44293406"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 06:41:42 -0700
X-CSE-ConnectionGUID: xoTpBbSvRmyxqNQ/PqMw9g==
X-CSE-MsgGUID: 5uR4c/0bQd6zWs0B6vm+Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="55612923"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 18 Jul 2024 06:41:40 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sURO6-000hIs-0E;
	Thu, 18 Jul 2024 13:41:38 +0000
Date: Thu, 18 Jul 2024 21:40:44 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11] BUILD REGRESSION
 9a99991d90521113a738c2a4761a4147fe4b31ca
Message-ID: <202407182116.1G8W2vfZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git syscall-tbl-6.11
branch HEAD: 9a99991d90521113a738c2a4761a4147fe4b31ca  syscalls: fix readv/writev entry

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202407180400.SzsjPaHl-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407180428.tHFOgti0-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407180559.Fx7UMDJy-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407180608.OqFajxwV-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407180703.0A04l6MZ-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407180720.lk7Gw1pf-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407180721.r42zYOeD-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407180723.rk3cGZ41-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407180852.frUNVOxd-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407180947.jfaAP6M1-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407181157.lIOH6oLx-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407181209.jFiC5Wi2-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407181351.FWGCeOYe-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407181356.BxLqHh6I-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407181359.v2PMzxXm-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407181648.IsTOYT9n-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

(.text+0x2298c): undefined reference to `sys_fadvise64_64_6'
(.text+0x230c4): undefined reference to `sys_fadvise64'
./arch/arc/include/generated/asm/syscall_table_32.h:464:16: error: 'sys_setxattrat' undeclared here (not in a function); did you mean 'sys_setxattr'?
./arch/arc/include/generated/asm/syscall_table_32.h:465:16: error: 'sys_getxattrat' undeclared here (not in a function); did you mean 'sys_getxattr'?
./arch/arc/include/generated/asm/syscall_table_32.h:466:16: error: 'sys_listxattrat' undeclared here (not in a function); did you mean 'sys_listxattr'?
./arch/arc/include/generated/asm/syscall_table_32.h:467:16: error: 'sys_removexattrat' undeclared here (not in a function); did you mean 'sys_removexattr'?
./arch/csky/include/generated/asm/syscall_table_32.h:464:16: error: 'sys_setxattrat' undeclared here (not in a function); did you mean 'sys_setxattr'?
./arch/csky/include/generated/asm/syscall_table_32.h:465:16: error: 'sys_getxattrat' undeclared here (not in a function); did you mean 'sys_getxattr'?
./arch/csky/include/generated/asm/syscall_table_32.h:466:16: error: 'sys_listxattrat' undeclared here (not in a function); did you mean 'sys_listxattr'?
./arch/csky/include/generated/asm/syscall_table_32.h:467:16: error: 'sys_removexattrat' undeclared here (not in a function); did you mean 'sys_removexattr'?
./arch/hexagon/include/generated/asm/syscall_table_32.h:464:16: error: use of undeclared identifier 'sys_setxattrat'; did you mean 'sys_setxattr'?
./arch/hexagon/include/generated/asm/syscall_table_32.h:465:16: error: use of undeclared identifier 'sys_getxattrat'; did you mean 'sys_getxattr'?
./arch/hexagon/include/generated/asm/syscall_table_32.h:466:16: error: use of undeclared identifier 'sys_listxattrat'; did you mean 'sys_listxattr'?
./arch/hexagon/include/generated/asm/syscall_table_32.h:467:16: error: use of undeclared identifier 'sys_removexattrat'; did you mean 'sys_removexattr'?
./arch/loongarch/include/generated/asm/syscall_table_64.h:464:16: error: 'sys_setxattrat' undeclared here (not in a function); did you mean 'sys_setxattr'?
./arch/loongarch/include/generated/asm/syscall_table_64.h:465:16: error: 'sys_getxattrat' undeclared here (not in a function); did you mean 'sys_getxattr'?
./arch/loongarch/include/generated/asm/syscall_table_64.h:466:16: error: 'sys_listxattrat' undeclared here (not in a function); did you mean 'sys_listxattr'?
./arch/loongarch/include/generated/asm/syscall_table_64.h:467:16: error: 'sys_removexattrat' undeclared here (not in a function); did you mean 'sys_removexattr'?
./arch/loongarch/include/generated/asm/syscall_table_64.h:468:16: error: 'sys_uretprobe' undeclared here (not in a function); did you mean 'get_kretprobe'?
./arch/nios2/include/generated/asm/syscall_table_32.h:464:16: error: 'sys_setxattrat' undeclared here (not in a function); did you mean 'sys_setxattr'?
./arch/nios2/include/generated/asm/syscall_table_32.h:465:16: error: 'sys_getxattrat' undeclared here (not in a function); did you mean 'sys_getxattr'?
./arch/nios2/include/generated/asm/syscall_table_32.h:466:16: error: 'sys_listxattrat' undeclared here (not in a function); did you mean 'sys_listxattr'?
./arch/nios2/include/generated/asm/syscall_table_32.h:467:16: error: 'sys_removexattrat' undeclared here (not in a function); did you mean 'sys_removexattr'?
./arch/openrisc/include/generated/asm/syscall_table_32.h:464:16: error: 'sys_setxattrat' undeclared here (not in a function); did you mean 'sys_setxattr'?
./arch/openrisc/include/generated/asm/syscall_table_32.h:465:16: error: 'sys_getxattrat' undeclared here (not in a function); did you mean 'sys_getxattr'?
./arch/openrisc/include/generated/asm/syscall_table_32.h:466:16: error: 'sys_listxattrat' undeclared here (not in a function); did you mean 'sys_listxattr'?
./arch/openrisc/include/generated/asm/syscall_table_32.h:467:16: error: 'sys_removexattrat' undeclared here (not in a function); did you mean 'sys_removexattr'?
./arch/x86/include/generated/asm/syscall_table_32.h:273:(.text+0x625): undefined reference to `__ia32_sys_fadvise64_64_6'
./arch/x86/include/generated/asm/syscall_table_64.h:222:(.text+0x30a): undefined reference to `__x64_sys_fadvise64'
aarch64-linux-ld: arch/arm64/kernel/sys.o:(.rodata+0x6f8): undefined reference to `__arm64_sys_fadvise64'
aarch64-linux-ld: arch/arm64/kernel/sys.o:(.rodata+0xe78): undefined reference to `__arm64_sys_setxattrat'
aarch64-linux-ld: arch/arm64/kernel/sys.o:(.rodata+0xe80): undefined reference to `__arm64_sys_getxattrat'
aarch64-linux-ld: arch/arm64/kernel/sys.o:(.rodata+0xe88): undefined reference to `__arm64_sys_listxattrat'
aarch64-linux-ld: arch/arm64/kernel/sys.o:(.rodata+0xe90): undefined reference to `__arm64_sys_removexattrat'
aarch64-linux-ld: arch/arm64/kernel/sys.o:(.rodata+0xe98): undefined reference to `__arm64_sys_uretprobe'
aarch64-linux-ld: arch/arm64/kernel/sys32.o:(.rodata+0x870): undefined reference to `__arm64_sys_fadvise64_64_2'
arch/arm/kernel/sys_oabi-compat.c:401:83: error: 'fifth' undeclared (first use in this function)
arch/arm/kernel/sys_oabi-compat.c:405:1: warning: control reaches end of non-void function [-Wreturn-type]
arch/arm/kernel/sys_oabi-compat.c:452:13: error: 'addrlen' undeclared (first use in this function)
arch/arm/kernel/sys_oabi-compat.c:453:34: error: 'addr' undeclared (first use in this function)
arch/arm/kernel/sys_oabi-compat.c:483:16: error: too few arguments to function '__sys_sendmsg'
arch/arm/kernel/sys_oabi-compat.c:501:29: error: too many arguments to function 'sys_oabi_sendto'
arch/arm64/include/asm/syscalls.h:11:75: error: unknown type name 'compat_size_t'; did you mean 'compat_sp_abt'?
arch/x86/include/asm/syscall_wrapper.h:230:60: error: 'sys_vm86' undeclared here (not in a function); did you mean 'do_sys_vm86'?
arch/x86/include/asm/syscall_wrapper.h:230:60: error: 'sys_vm86old' undeclared here (not in a function); did you mean 'args__vm86old'?
arch/x86/include/asm/syscalls.h:27:76: warning: 'struct stat64' declared inside parameter list will not be visible outside of this definition or declaration
arch/x86/include/asm/syscalls.h:27:76: warning: declaration of 'struct stat64' will not be visible outside of this function [-Wvisibility]
arch/x86/kernel/vm86_32.c:170:1: error: incompatible function pointer types initializing 'long (*)(struct vm86_struct *)' with an expression of type 'long (const char *, umode_t, unsigned int)' (aka 'long (const char *, unsigned short, unsigned int)') [-Wincompatible-function-pointer-types]
arch/x86/kernel/vm86_32.c:170:1: error: use of undeclared identifier 'sys_vm86old'; did you mean 'sys_mknod'?
arch/x86/kernel/vm86_32.c:176:1: error: incompatible function pointer types initializing 'long (*)(unsigned long, unsigned long)' with an expression of type 'long (unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)' [-Wincompatible-function-pointer-types]
arch/x86/kernel/vm86_32.c:176:1: error: use of undeclared identifier 'sys_vm86'; did you mean 'sys_mmap'?
arch/x86/um/ldt.c:375:1: warning: comparison of distinct pointer types ('long (*)(int, void *, unsigned long)' and 'long (*)(int, void *, unsigned long)') [-Wcompare-distinct-pointer-types]
arch/x86/um/sys_call_table_32.c:27:10: fatal error: 'asm/syscalls_32.h' file not found
arch/x86/um/sys_call_table_32.c:27:10: fatal error: asm/syscalls_32.h: No such file or directory
arch/x86/um/syscalls_32.c:5:1: warning: comparison of distinct pointer types ('long (*)(int, unsigned long)' and 'long (*)(int, unsigned long)') [-Wcompare-distinct-pointer-types]
arch/x86/um/tls_32.c:254:1: warning: comparison of distinct pointer types ('long (*)(struct user_desc *)' and 'long (*)(struct user_desc *)') [-Wcompare-distinct-pointer-types]
block/ioprio.c:184:1: warning: comparison of distinct pointer types ('long (*)(int, int)' and 'long (*)(int, int)') [-Wcompare-distinct-pointer-types]
block/ioprio.c:69:1: warning: comparison of distinct pointer types ('long (*)(int, int, int)' and 'long (*)(int, int, int)') [-Wcompare-distinct-pointer-types]
drivers/char/random.c:1364:1: warning: comparison of distinct pointer types ('long (*)(char *, size_t, unsigned int)' (aka 'long (*)(char *, unsigned int, unsigned int)') and 'long (*)(char *, size_t, unsigned int)' (aka 'long (*)(char *, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/aio.c:1391:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, aio_context_t *)' (aka 'long (*)(unsigned int, unsigned long *)') and 'long (*)(unsigned int, aio_context_t *)' (aka 'long (*)(unsigned int, unsigned long *)')) [-Wcompare-distinct-pointer-types]
fs/aio.c:1460:1: warning: comparison of distinct pointer types ('long (*)(aio_context_t)' (aka 'long (*)(unsigned long)') and 'long (*)(aio_context_t)' (aka 'long (*)(unsigned long)')) [-Wcompare-distinct-pointer-types]
fs/aio.c:2090:1: warning: comparison of distinct pointer types ('long (*)(aio_context_t, long, struct iocb **)' (aka 'long (*)(unsigned long, long, struct iocb **)') and 'long (*)(aio_context_t, long, struct iocb **)' (aka 'long (*)(unsigned long, long, struct iocb **)')) [-Wcompare-distinct-pointer-types]
fs/aio.c:2184:1: warning: comparison of distinct pointer types ('long (*)(aio_context_t, struct iocb *, struct io_event *)' (aka 'long (*)(unsigned long, struct iocb *, struct io_event *)') and 'long (*)(aio_context_t, struct iocb *, struct io_event *)' (aka 'long (*)(unsigned long, struct iocb *, struct io_event *)')) [-Wcompare-distinct-pointer-types]
fs/aio.c:2285:1: warning: comparison of distinct pointer types ('long (*)(aio_context_t, long, long, struct io_event *, struct __kernel_timespec *, const struct __aio_sigset *)' (aka 'long (*)(unsigned long, long, long, struct io_event *, struct __kernel_timespec *, const struct __aio_sigset *)') and 'long (*)(aio_context_t, long, long, struct io_event *, struct __kernel_timespec *, const struct __aio_sigset *)' (aka 'long (*)(unsigned long, long, long, struct io_event *, struct __kernel_timespec *, const struct __aio_sigset *)')) [-Wcompare-distinct-pointer-types]
fs/d_path.c:412:1: warning: comparison of distinct pointer types ('long (*)(char *, unsigned long)' and 'long (*)(char *, unsigned long)') [-Wcompare-distinct-pointer-types]
fs/eventfd.c:427:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, int)' and 'long (*)(unsigned int, int)') [-Wcompare-distinct-pointer-types]
fs/eventfd.c:432:1: warning: comparison of distinct pointer types ('long (*)(unsigned int)' and 'long (*)(unsigned int)') [-Wcompare-distinct-pointer-types]
fs/eventpoll.c:2219:1: warning: comparison of distinct pointer types ('long (*)(int)' and 'long (*)(int)') [-Wcompare-distinct-pointer-types]
fs/eventpoll.c:2413:1: warning: comparison of distinct pointer types ('long (*)(int, int, int, struct epoll_event *)' and 'long (*)(int, int, int, struct epoll_event *)') [-Wcompare-distinct-pointer-types]
fs/eventpoll.c:2471:1: warning: comparison of distinct pointer types ('long (*)(int, struct epoll_event *, int, int)' and 'long (*)(int, struct epoll_event *, int, int)') [-Wcompare-distinct-pointer-types]
fs/eventpoll.c:2505:1: warning: comparison of distinct pointer types ('long (*)(int, struct epoll_event *, int, int, const sigset_t *, size_t)' (aka 'long (*)(int, struct epoll_event *, int, int, const sigset_t *, unsigned int)') and 'long (*)(int, struct epoll_event *, int, int, const sigset_t *, size_t)' (aka 'long (*)(int, struct epoll_event *, int, int, const sigset_t *, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/eventpoll.c:2516:1: warning: comparison of distinct pointer types ('long (*)(int, struct epoll_event *, int, const struct __kernel_timespec *, const sigset_t *, size_t)' (aka 'long (*)(int, struct epoll_event *, int, const struct __kernel_timespec *, const sigset_t *, unsigned int)') and 'long (*)(int, struct epoll_event *, int, const struct __kernel_timespec *, const sigset_t *, size_t)' (aka 'long (*)(int, struct epoll_event *, int, const struct __kernel_timespec *, const sigset_t *, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/exec.c:2143:1: warning: comparison of distinct pointer types ('long (*)(const char *, const char *const *, const char *const *)' and 'long (*)(const char *, const char *const *, const char *const *)') [-Wcompare-distinct-pointer-types]
fs/exec.c:2151:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, const char *const *, const char *const *, int)' and 'long (*)(int, const char *, const char *const *, const char *const *, int)') [-Wcompare-distinct-pointer-types]
fs/fcntl.c:477:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, unsigned int, unsigned long)' and 'long (*)(unsigned int, unsigned int, unsigned long)') [-Wcompare-distinct-pointer-types]
fs/fhandle.c:258:1: warning: comparison of distinct pointer types ('long (*)(int, struct file_handle *, int)' and 'long (*)(int, struct file_handle *, int)') [-Wcompare-distinct-pointer-types]
fs/fhandle.c:94:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, struct file_handle *, int *, int)' and 'long (*)(int, const char *, struct file_handle *, int *, int)') [-Wcompare-distinct-pointer-types]
fs/file.c:1385:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, unsigned int, int)' and 'long (*)(unsigned int, unsigned int, int)') [-Wcompare-distinct-pointer-types]
fs/file.c:1390:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, unsigned int)' and 'long (*)(unsigned int, unsigned int)') [-Wcompare-distinct-pointer-types]
fs/file.c:1409:1: warning: comparison of distinct pointer types ('long (*)(unsigned int)' and 'long (*)(unsigned int)') [-Wcompare-distinct-pointer-types]
fs/filesystems.c:191:1: warning: comparison of distinct pointer types ('long (*)(int, unsigned long, unsigned long)' and 'long (*)(int, unsigned long, unsigned long)') [-Wcompare-distinct-pointer-types]
fs/fsopen.c:115:1: warning: comparison of distinct pointer types ('long (*)(const char *, unsigned int)' and 'long (*)(const char *, unsigned int)') [-Wcompare-distinct-pointer-types]
fs/fsopen.c:158:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, unsigned int)' and 'long (*)(int, const char *, unsigned int)') [-Wcompare-distinct-pointer-types]
fs/fsopen.c:349:1: warning: comparison of distinct pointer types ('long (*)(int, unsigned int, const char *, const void *, int)' and 'long (*)(int, unsigned int, const char *, const void *, int)') [-Wcompare-distinct-pointer-types]
fs/ioctl.c:893:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, unsigned int, unsigned long)' and 'long (*)(unsigned int, unsigned int, unsigned long)') [-Wcompare-distinct-pointer-types]
fs/locks.c:2131:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, unsigned int)' and 'long (*)(unsigned int, unsigned int)') [-Wcompare-distinct-pointer-types]
fs/namei.c:4084:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, umode_t, unsigned int)' (aka 'long (*)(int, const char *, unsigned short, unsigned int)') and 'long (*)(int, const char *, umode_t, unsigned int)' (aka 'long (*)(int, const char *, unsigned short, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/namei.c:4090:1: warning: comparison of distinct pointer types ('long (*)(const char *, umode_t, unsigned int)' (aka 'long (*)(const char *, unsigned short, unsigned int)') and 'long (*)(const char *, umode_t, unsigned int)' (aka 'long (*)(const char *, unsigned short, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/namei.c:4167:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, umode_t)' (aka 'long (*)(int, const char *, unsigned short)') and 'long (*)(int, const char *, umode_t)' (aka 'long (*)(int, const char *, unsigned short)')) [-Wcompare-distinct-pointer-types]
fs/namei.c:4172:1: warning: comparison of distinct pointer types ('long (*)(const char *, umode_t)' (aka 'long (*)(const char *, unsigned short)') and 'long (*)(const char *, umode_t)' (aka 'long (*)(const char *, unsigned short)')) [-Wcompare-distinct-pointer-types]
fs/namei.c:4290:1: warning: comparison of distinct pointer types ('long (*)(const char *)' and 'long (*)(const char *)') [-Wcompare-distinct-pointer-types]
fs/namei.c:4443:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, int)' and 'long (*)(int, const char *, int)') [-Wcompare-distinct-pointer-types]
fs/namei.c:4528:1: warning: comparison of distinct pointer types ('long (*)(const char *, int, const char *)' and 'long (*)(const char *, int, const char *)') [-Wcompare-distinct-pointer-types]
fs/namei.c:4534:1: warning: comparison of distinct pointer types ('long (*)(const char *, const char *)' and 'long (*)(const char *, const char *)') [-Wcompare-distinct-pointer-types]
fs/namei.c:4708:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, int, const char *, int)' and 'long (*)(int, const char *, int, const char *, int)') [-Wcompare-distinct-pointer-types]
fs/namei.c:5075:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, int, const char *, unsigned int)' and 'long (*)(int, const char *, int, const char *, unsigned int)') [-Wcompare-distinct-pointer-types]
fs/namei.c:5082:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, int, const char *)' and 'long (*)(int, const char *, int, const char *)') [-Wcompare-distinct-pointer-types]
fs/namespace.c:1922:1: warning: comparison of distinct pointer types ('long (*)(char *, int)' and 'long (*)(char *, int)') [-Wcompare-distinct-pointer-types]
fs/namespace.c:1932:1: warning: comparison of distinct pointer types ('long (*)(char *)' and 'long (*)(char *)') [-Wcompare-distinct-pointer-types]
fs/namespace.c:2692:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, unsigned int)' and 'long (*)(int, const char *, unsigned int)') [-Wcompare-distinct-pointer-types]
fs/namespace.c:3875:1: warning: comparison of distinct pointer types ('long (*)(char *, char *, char *, unsigned long, void *)' and 'long (*)(char *, char *, char *, unsigned long, void *)') [-Wcompare-distinct-pointer-types]
fs/namespace.c:3943:1: warning: comparison of distinct pointer types ('long (*)(int, unsigned int, unsigned int)' and 'long (*)(int, unsigned int, unsigned int)') [-Wcompare-distinct-pointer-types]
fs/namespace.c:4071:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, int, const char *, unsigned int)' and 'long (*)(int, const char *, int, const char *, unsigned int)') [-Wcompare-distinct-pointer-types]
fs/namespace.c:4179:1: warning: comparison of distinct pointer types ('long (*)(const char *, const char *)' and 'long (*)(const char *, const char *)') [-Wcompare-distinct-pointer-types]
fs/namespace.c:4647:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, unsigned int, struct mount_attr *, size_t)' (aka 'long (*)(int, const char *, unsigned int, struct mount_attr *, unsigned int)') and 'long (*)(int, const char *, unsigned int, struct mount_attr *, size_t)' (aka 'long (*)(int, const char *, unsigned int, struct mount_attr *, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/namespace.c:5000:1: warning: comparison of distinct pointer types ('long (*)(const struct mnt_id_req *, struct statmount *, size_t, unsigned int)' (aka 'long (*)(const struct mnt_id_req *, struct statmount *, unsigned int, unsigned int)') and 'long (*)(const struct mnt_id_req *, struct statmount *, size_t, unsigned int)' (aka 'long (*)(const struct mnt_id_req *, struct statmount *, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/namespace.c:5083:1: warning: comparison of distinct pointer types ('long (*)(const struct mnt_id_req *, u64 *, size_t, unsigned int)' (aka 'long (*)(const struct mnt_id_req *, unsigned long long *, unsigned int, unsigned int)') and 'long (*)(const struct mnt_id_req *, u64 *, size_t, unsigned int)' (aka 'long (*)(const struct mnt_id_req *, unsigned long long *, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/open.c:1428:1: warning: comparison of distinct pointer types ('long (*)(const char *, int, umode_t)' (aka 'long (*)(const char *, int, unsigned short)') and 'long (*)(const char *, int, umode_t)' (aka 'long (*)(const char *, int, unsigned short)')) [-Wcompare-distinct-pointer-types]
fs/open.c:1435:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, int, umode_t)' (aka 'long (*)(int, const char *, int, unsigned short)') and 'long (*)(int, const char *, int, umode_t)' (aka 'long (*)(int, const char *, int, unsigned short)')) [-Wcompare-distinct-pointer-types]
fs/open.c:1443:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, struct open_how *, size_t)' (aka 'long (*)(int, const char *, struct open_how *, unsigned int)') and 'long (*)(int, const char *, struct open_how *, size_t)' (aka 'long (*)(int, const char *, struct open_how *, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/open.c:144:1: warning: comparison of distinct pointer types ('long (*)(const char *, long)' and 'long (*)(const char *, long)') [-Wcompare-distinct-pointer-types]
fs/open.c:1582:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, unsigned int, unsigned int)' and 'long (*)(unsigned int, unsigned int, unsigned int)') [-Wcompare-distinct-pointer-types]
fs/open.c:205:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, off_t)' (aka 'long (*)(unsigned int, long)') and 'long (*)(unsigned int, off_t)' (aka 'long (*)(unsigned int, long)')) [-Wcompare-distinct-pointer-types]
fs/open.c:220:1: warning: comparison of distinct pointer types ('long (*)(const char *, u32, u32)' (aka 'long (*)(const char *, unsigned int, unsigned int)') and 'long (*)(const char *, u32, u32)' (aka 'long (*)(const char *, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/open.c:234:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, u32, u32)' (aka 'long (*)(unsigned int, unsigned int, unsigned int)') and 'long (*)(unsigned int, u32, u32)' (aka 'long (*)(unsigned int, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/open.c:369:1: warning: comparison of distinct pointer types ('long (*)(int, int, u32, u32, u32, u32)' (aka 'long (*)(int, int, unsigned int, unsigned int, unsigned int, unsigned int)') and 'long (*)(int, int, u32, u32, u32, u32)' (aka 'long (*)(int, int, unsigned int, unsigned int, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/open.c:540:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, int)' and 'long (*)(int, const char *, int)') [-Wcompare-distinct-pointer-types]
fs/open.c:545:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, int, int)' and 'long (*)(int, const char *, int, int)') [-Wcompare-distinct-pointer-types]
fs/open.c:551:1: warning: comparison of distinct pointer types ('long (*)(const char *, int)' and 'long (*)(const char *, int)') [-Wcompare-distinct-pointer-types]
fs/open.c:556:1: warning: comparison of distinct pointer types ('long (*)(const char *)' and 'long (*)(const char *)') [-Wcompare-distinct-pointer-types]
fs/open.c:582:1: warning: comparison of distinct pointer types ('long (*)(unsigned int)' and 'long (*)(unsigned int)') [-Wcompare-distinct-pointer-types]
fs/open.c:673:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, umode_t)' (aka 'long (*)(unsigned int, unsigned short)') and 'long (*)(unsigned int, umode_t)' (aka 'long (*)(unsigned int, unsigned short)')) [-Wcompare-distinct-pointer-types]
fs/open.c:712:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, umode_t, unsigned int)' (aka 'long (*)(int, const char *, unsigned short, unsigned int)') and 'long (*)(int, const char *, umode_t, unsigned int)' (aka 'long (*)(int, const char *, unsigned short, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/open.c:718:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, umode_t)' (aka 'long (*)(int, const char *, unsigned short)') and 'long (*)(int, const char *, umode_t)' (aka 'long (*)(int, const char *, unsigned short)')) [-Wcompare-distinct-pointer-types]
fs/open.c:724:1: warning: comparison of distinct pointer types ('long (*)(const char *, umode_t)' (aka 'long (*)(const char *, unsigned short)') and 'long (*)(const char *, umode_t)' (aka 'long (*)(const char *, unsigned short)')) [-Wcompare-distinct-pointer-types]
fs/open.c:837:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, uid_t, gid_t, int)' (aka 'long (*)(int, const char *, unsigned int, unsigned int, int)') and 'long (*)(int, const char *, uid_t, gid_t, int)' (aka 'long (*)(int, const char *, unsigned int, unsigned int, int)')) [-Wcompare-distinct-pointer-types]
fs/open.c:843:1: warning: comparison of distinct pointer types ('long (*)(const char *, uid_t, gid_t)' (aka 'long (*)(const char *, unsigned int, unsigned int)') and 'long (*)(const char *, uid_t, gid_t)' (aka 'long (*)(const char *, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/open.c:879:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, uid_t, gid_t)' (aka 'long (*)(unsigned int, unsigned int, unsigned int)') and 'long (*)(unsigned int, uid_t, gid_t)' (aka 'long (*)(unsigned int, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/pipe.c:1038:1: warning: comparison of distinct pointer types ('long (*)(int *, int)' and 'long (*)(int *, int)') [-Wcompare-distinct-pointer-types]
fs/pipe.c:1043:1: warning: comparison of distinct pointer types ('long (*)(int *)' and 'long (*)(int *)') [-Wcompare-distinct-pointer-types]
fs/read_write.c:1100:1: warning: comparison of distinct pointer types ('long (*)(unsigned long, const struct iovec *, unsigned long)' and 'long (*)(unsigned long, const struct iovec *, unsigned long)') [-Wcompare-distinct-pointer-types]
fs/read_write.c:1158:1: warning: comparison of distinct pointer types ('long (*)(unsigned long, const struct iovec *, unsigned long, u32, u32)' (aka 'long (*)(unsigned long, const struct iovec *, unsigned long, unsigned int, unsigned int)') and 'long (*)(unsigned long, const struct iovec *, unsigned long, u32, u32)' (aka 'long (*)(unsigned long, const struct iovec *, unsigned long, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/read_write.c:1167:1: warning: comparison of distinct pointer types ('long (*)(unsigned long, const struct iovec *, unsigned long, u32, u32, rwf_t)' (aka 'long (*)(unsigned long, const struct iovec *, unsigned long, unsigned int, unsigned int, int)') and 'long (*)(unsigned long, const struct iovec *, unsigned long, u32, u32, rwf_t)' (aka 'long (*)(unsigned long, const struct iovec *, unsigned long, unsigned int, unsigned int, int)')) [-Wcompare-distinct-pointer-types]
fs/read_write.c:1330:1: warning: comparison of distinct pointer types ('long (*)(int, int, off_t *, size_t)' (aka 'long (*)(int, int, long *, unsigned int)') and 'long (*)(int, int, off_t *, size_t)' (aka 'long (*)(int, int, long *, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/read_write.c:1349:1: warning: comparison of distinct pointer types ('long (*)(int, int, loff_t *, size_t)' (aka 'long (*)(int, int, long long *, unsigned int)') and 'long (*)(int, int, loff_t *, size_t)' (aka 'long (*)(int, int, long long *, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/read_write.c:1576:1: warning: comparison of distinct pointer types ('long (*)(int, loff_t *, int, loff_t *, size_t, unsigned int)' (aka 'long (*)(int, long long *, int, long long *, unsigned int, unsigned int)') and 'long (*)(int, loff_t *, int, loff_t *, size_t, unsigned int)' (aka 'long (*)(int, long long *, int, long long *, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/read_write.c:311:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, off_t, unsigned int)' (aka 'long (*)(unsigned int, long, unsigned int)') and 'long (*)(unsigned int, off_t, unsigned int)' (aka 'long (*)(unsigned int, long, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/read_write.c:325:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, unsigned long, unsigned long, loff_t *, unsigned int)' (aka 'long (*)(unsigned int, unsigned long, unsigned long, long long *, unsigned int)') and 'long (*)(unsigned int, unsigned long, unsigned long, loff_t *, unsigned int)' (aka 'long (*)(unsigned int, unsigned long, unsigned long, long long *, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/read_write.c:627:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, char *, size_t)' (aka 'long (*)(unsigned int, char *, unsigned int)') and 'long (*)(unsigned int, char *, size_t)' (aka 'long (*)(unsigned int, char *, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/read_write.c:652:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, const char *, size_t)' (aka 'long (*)(unsigned int, const char *, unsigned int)') and 'long (*)(unsigned int, const char *, size_t)' (aka 'long (*)(unsigned int, const char *, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/read_write.c:688:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, char *, size_t, u32, u32)' (aka 'long (*)(unsigned int, char *, unsigned int, unsigned int, unsigned int)') and 'long (*)(unsigned int, char *, size_t, u32, u32)' (aka 'long (*)(unsigned int, char *, unsigned int, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/read_write.c:734:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, const char *, size_t, u32, u32)' (aka 'long (*)(unsigned int, const char *, unsigned int, unsigned int, unsigned int)') and 'long (*)(unsigned int, const char *, size_t, u32, u32)' (aka 'long (*)(unsigned int, const char *, unsigned int, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/readdir.c:220:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, struct old_linux_dirent *, unsigned int)' and 'long (*)(unsigned int, struct old_linux_dirent *, unsigned int)') [-Wcompare-distinct-pointer-types]
fs/readdir.c:311:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, struct linux_dirent *, unsigned int)' and 'long (*)(unsigned int, struct linux_dirent *, unsigned int)') [-Wcompare-distinct-pointer-types]
fs/readdir.c:394:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, struct linux_dirent64 *, unsigned int)' and 'long (*)(unsigned int, struct linux_dirent64 *, unsigned int)') [-Wcompare-distinct-pointer-types]
fs/select.c:1069:1: warning: comparison of distinct pointer types ('long (*)(struct pollfd *, unsigned int, int)' and 'long (*)(struct pollfd *, unsigned int, int)') [-Wcompare-distinct-pointer-types]
fs/select.c:1102:1: warning: comparison of distinct pointer types ('long (*)(struct pollfd *, unsigned int, struct __kernel_timespec *, const sigset_t *, size_t)' (aka 'long (*)(struct pollfd *, unsigned int, struct __kernel_timespec *, const sigset_t *, unsigned int)') and 'long (*)(struct pollfd *, unsigned int, struct __kernel_timespec *, const sigset_t *, size_t)' (aka 'long (*)(struct pollfd *, unsigned int, struct __kernel_timespec *, const sigset_t *, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/select.c:726:1: warning: comparison of distinct pointer types ('long (*)(int, fd_set *, fd_set *, fd_set *, struct __kernel_old_timeval *)' (aka 'long (*)(int, __kernel_fd_set *, __kernel_fd_set *, __kernel_fd_set *, struct __kernel_old_timeval *)') and 'long (*)(int, fd_set *, fd_set *, fd_set *, struct __kernel_old_timeval *)' (aka 'long (*)(int, __kernel_fd_set *, __kernel_fd_set *, __kernel_fd_set *, struct __kernel_old_timeval *)')) [-Wcompare-distinct-pointer-types]
fs/select.c:795:1: warning: comparison of distinct pointer types ('long (*)(int, fd_set *, fd_set *, fd_set *, struct __kernel_timespec *, void *)' (aka 'long (*)(int, __kernel_fd_set *, __kernel_fd_set *, __kernel_fd_set *, struct __kernel_timespec *, void *)') and 'long (*)(int, fd_set *, fd_set *, fd_set *, struct __kernel_timespec *, void *)' (aka 'long (*)(int, __kernel_fd_set *, __kernel_fd_set *, __kernel_fd_set *, struct __kernel_timespec *, void *)')) [-Wcompare-distinct-pointer-types]
fs/select.c:830:1: warning: comparison of distinct pointer types ('long (*)(struct sel_arg_struct *)' and 'long (*)(struct sel_arg_struct *)') [-Wcompare-distinct-pointer-types]
fs/signalfd.c:310:1: warning: comparison of distinct pointer types ('long (*)(int, sigset_t *, size_t, int)' (aka 'long (*)(int, sigset_t *, unsigned int, int)') and 'long (*)(int, sigset_t *, size_t, int)' (aka 'long (*)(int, sigset_t *, unsigned int, int)')) [-Wcompare-distinct-pointer-types]
fs/signalfd.c:322:1: warning: comparison of distinct pointer types ('long (*)(int, sigset_t *, size_t)' (aka 'long (*)(int, sigset_t *, unsigned int)') and 'long (*)(int, sigset_t *, size_t)' (aka 'long (*)(int, sigset_t *, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/splice.c:1598:1: warning: comparison of distinct pointer types ('long (*)(int, const struct iovec *, unsigned long, unsigned int)' and 'long (*)(int, const struct iovec *, unsigned long, unsigned int)') [-Wcompare-distinct-pointer-types]
fs/splice.c:1634:1: warning: comparison of distinct pointer types ('long (*)(int, loff_t *, int, loff_t *, size_t, unsigned int)' (aka 'long (*)(int, long long *, int, long long *, unsigned int, unsigned int)') and 'long (*)(int, loff_t *, int, loff_t *, size_t, unsigned int)' (aka 'long (*)(int, long long *, int, long long *, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/splice.c:2006:1: warning: comparison of distinct pointer types ('long (*)(int, int, size_t, unsigned int)' (aka 'long (*)(int, int, unsigned int, unsigned int)') and 'long (*)(int, int, size_t, unsigned int)' (aka 'long (*)(int, int, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/stat.c:353:1: warning: comparison of distinct pointer types ('long (*)(const char *, struct __old_kernel_stat *)' and 'long (*)(const char *, struct __old_kernel_stat *)') [-Wcompare-distinct-pointer-types]
fs/stat.c:379:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, struct __old_kernel_stat *)' and 'long (*)(unsigned int, struct __old_kernel_stat *)') [-Wcompare-distinct-pointer-types]
fs/stat.c:437:1: warning: comparison of distinct pointer types ('long (*)(const char *, struct stat *)' and 'long (*)(const char *, struct stat *)') [-Wcompare-distinct-pointer-types]
fs/stat.c:475:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, struct stat *)' and 'long (*)(unsigned int, struct stat *)') [-Wcompare-distinct-pointer-types]
fs/stat.c:523:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, char *, int)' and 'long (*)(int, const char *, char *, int)') [-Wcompare-distinct-pointer-types]
fs/stat.c:529:1: warning: comparison of distinct pointer types ('long (*)(const char *, char *, int)' and 'long (*)(const char *, char *, int)') [-Wcompare-distinct-pointer-types]
fs/stat.c:578:1: warning: comparison of distinct pointer types ('long (*)(const char *, struct stat64 *)' and 'long (*)(const char *, struct stat64 *)') [-Wcompare-distinct-pointer-types]
fs/stat.c:602:1: warning: comparison of distinct pointer types ('long (*)(unsigned long, struct stat64 *)' and 'long (*)(unsigned long, struct stat64 *)') [-Wcompare-distinct-pointer-types]
fs/stat.c:613:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, struct stat64 *, int)' and 'long (*)(int, const char *, struct stat64 *, int)') [-Wcompare-distinct-pointer-types]
fs/stat.c:700:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, unsigned int, unsigned int, struct statx *)' and 'long (*)(int, const char *, unsigned int, unsigned int, struct statx *)') [-Wcompare-distinct-pointer-types]
fs/statfs.c:192:1: warning: comparison of distinct pointer types ('long (*)(const char *, struct statfs *)' and 'long (*)(const char *, struct statfs *)') [-Wcompare-distinct-pointer-types]
fs/statfs.c:201:1: warning: comparison of distinct pointer types ('long (*)(const char *, size_t, struct statfs64 *)' (aka 'long (*)(const char *, unsigned int, struct statfs64 *)') and 'long (*)(const char *, size_t, struct statfs64 *)' (aka 'long (*)(const char *, unsigned int, struct statfs64 *)')) [-Wcompare-distinct-pointer-types]
fs/statfs.c:213:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, struct statfs *)' and 'long (*)(unsigned int, struct statfs *)') [-Wcompare-distinct-pointer-types]
fs/statfs.c:222:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, size_t, struct statfs64 *)' (aka 'long (*)(unsigned int, unsigned int, struct statfs64 *)') and 'long (*)(unsigned int, size_t, struct statfs64 *)' (aka 'long (*)(unsigned int, unsigned int, struct statfs64 *)')) [-Wcompare-distinct-pointer-types]
fs/statfs.c:248:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, struct ustat *)' and 'long (*)(unsigned int, struct ustat *)') [-Wcompare-distinct-pointer-types]
fs/sync.c:149:1: warning: comparison of distinct pointer types ('long (*)(int)' and 'long (*)(int)') [-Wcompare-distinct-pointer-types]
fs/sync.c:218:1: warning: comparison of distinct pointer types ('long (*)(unsigned int)' and 'long (*)(unsigned int)') [-Wcompare-distinct-pointer-types]
fs/sync.c:385:1: warning: comparison of distinct pointer types ('long (*)(int, u32, u32, u32, u32, unsigned int)' (aka 'long (*)(int, unsigned int, unsigned int, unsigned int, unsigned int, unsigned int)') and 'long (*)(int, u32, u32, u32, u32, unsigned int)' (aka 'long (*)(int, unsigned int, unsigned int, unsigned int, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/timerfd.c:410:1: warning: comparison of distinct pointer types ('long (*)(int, int)' and 'long (*)(int, int)') [-Wcompare-distinct-pointer-types]
fs/timerfd.c:574:1: warning: comparison of distinct pointer types ('long (*)(int, int, const struct __kernel_itimerspec *, struct __kernel_itimerspec *)' and 'long (*)(int, int, const struct __kernel_itimerspec *, struct __kernel_itimerspec *)') [-Wcompare-distinct-pointer-types]
fs/timerfd.c:592:1: warning: comparison of distinct pointer types ('long (*)(int, struct __kernel_itimerspec *)' and 'long (*)(int, struct __kernel_itimerspec *)') [-Wcompare-distinct-pointer-types]
fs/utimes.c:148:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, struct __kernel_timespec *, int)' and 'long (*)(int, const char *, struct __kernel_timespec *, int)') [-Wcompare-distinct-pointer-types]
fs/xattr.c:683:1: warning: comparison of distinct pointer types ('long (*)(const char *, const char *, const void *, size_t, int)' (aka 'long (*)(const char *, const char *, const void *, unsigned int, int)') and 'long (*)(const char *, const char *, const void *, size_t, int)' (aka 'long (*)(const char *, const char *, const void *, unsigned int, int)')) [-Wcompare-distinct-pointer-types]
fs/xattr.c:697:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, const void *, size_t, int)' (aka 'long (*)(int, const char *, const void *, unsigned int, int)') and 'long (*)(int, const char *, const void *, size_t, int)' (aka 'long (*)(int, const char *, const void *, unsigned int, int)')) [-Wcompare-distinct-pointer-types]
fs/xattr.c:796:1: warning: comparison of distinct pointer types ('long (*)(const char *, const char *, void *, size_t)' (aka 'long (*)(const char *, const char *, void *, unsigned int)') and 'long (*)(const char *, const char *, void *, size_t)' (aka 'long (*)(const char *, const char *, void *, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/xattr.c:808:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, void *, size_t)' (aka 'long (*)(int, const char *, void *, unsigned int)') and 'long (*)(int, const char *, void *, size_t)' (aka 'long (*)(int, const char *, void *, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/xattr.c:873:1: warning: comparison of distinct pointer types ('long (*)(const char *, char *, size_t)' (aka 'long (*)(const char *, char *, unsigned int)') and 'long (*)(const char *, char *, size_t)' (aka 'long (*)(const char *, char *, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/xattr.c:885:1: warning: comparison of distinct pointer types ('long (*)(int, char *, size_t)' (aka 'long (*)(int, char *, unsigned int)') and 'long (*)(int, char *, size_t)' (aka 'long (*)(int, char *, unsigned int)')) [-Wcompare-distinct-pointer-types]
fs/xattr.c:942:1: warning: comparison of distinct pointer types ('long (*)(const char *, const char *)' and 'long (*)(const char *, const char *)') [-Wcompare-distinct-pointer-types]
fs/xattr.c:954:1: warning: comparison of distinct pointer types ('long (*)(int, const char *)' and 'long (*)(int, const char *)') [-Wcompare-distinct-pointer-types]
include/linux/syscalls.h:210:25: error: conflicting types for 'sys_mips_pipe'; have 'long int(void)'
include/linux/syscalls.h:245:39: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
include/linux/syscalls.h:250:25: error: conflicting types for 'sys_oabi_ipc'; have 'long int(uint,  int,  int,  int,  void *)' {aka 'long int(unsigned int,  int,  int,  int,  void *)'}
include/linux/syscalls.h:250:25: error: conflicting types for 'sys_oabi_semtimedop'; have 'long int(int,  struct oabi_sembuf *, unsigned int)'
include/linux/syscalls.h:250:25: error: conflicting types for 'sys_oabi_sendto'; have 'long int(int,  void *, size_t,  unsigned int)' {aka 'long int(int,  void *, unsigned int,  unsigned int)'}
io_uring/io_uring.c:3182:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, u32, u32, u32, const void *, size_t)' (aka 'long (*)(unsigned int, unsigned int, unsigned int, unsigned int, const void *, unsigned int)') and 'long (*)(unsigned int, u32, u32, u32, const void *, size_t)' (aka 'long (*)(unsigned int, unsigned int, unsigned int, unsigned int, const void *, unsigned int)')) [-Wcompare-distinct-pointer-types]
io_uring/io_uring.c:3665:1: warning: comparison of distinct pointer types ('long (*)(u32, struct io_uring_params *)' (aka 'long (*)(unsigned int, struct io_uring_params *)') and 'long (*)(u32, struct io_uring_params *)' (aka 'long (*)(unsigned int, struct io_uring_params *)')) [-Wcompare-distinct-pointer-types]
io_uring/register.c:577:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, unsigned int, void *, unsigned int)' and 'long (*)(unsigned int, unsigned int, void *, unsigned int)') [-Wcompare-distinct-pointer-types]
kernel/capability.c:141:1: warning: comparison of distinct pointer types ('long (*)(cap_user_header_t, cap_user_data_t)' (aka 'long (*)(struct __user_cap_header_struct *, struct __user_cap_data_struct *)') and 'long (*)(cap_user_header_t, cap_user_data_t)' (aka 'long (*)(struct __user_cap_header_struct *, struct __user_cap_data_struct *)')) [-Wcompare-distinct-pointer-types]
kernel/capability.c:220:1: warning: comparison of distinct pointer types ('long (*)(cap_user_header_t, const cap_user_data_t)' (aka 'long (*)(struct __user_cap_header_struct *, struct __user_cap_data_struct *const)') and 'long (*)(cap_user_header_t, const cap_user_data_t)' (aka 'long (*)(struct __user_cap_header_struct *, struct __user_cap_data_struct *const)')) [-Wcompare-distinct-pointer-types]
kernel/exec_domain.c:38:1: warning: comparison of distinct pointer types ('long (*)(unsigned int)' and 'long (*)(unsigned int)') [-Wcompare-distinct-pointer-types]
kernel/exit.c:1718:1: warning: comparison of distinct pointer types ('long (*)(int, pid_t, struct siginfo *, int, struct rusage *)' (aka 'long (*)(int, int, struct siginfo *, int, struct rusage *)') and 'long (*)(int, pid_t, struct siginfo *, int, struct rusage *)' (aka 'long (*)(int, int, struct siginfo *, int, struct rusage *)')) [-Wcompare-distinct-pointer-types]
kernel/exit.c:1810:1: warning: comparison of distinct pointer types ('long (*)(pid_t, int *, int, struct rusage *)' (aka 'long (*)(int, int *, int, struct rusage *)') and 'long (*)(pid_t, int *, int, struct rusage *)' (aka 'long (*)(int, int *, int, struct rusage *)')) [-Wcompare-distinct-pointer-types]
kernel/exit.c:1829:1: warning: comparison of distinct pointer types ('long (*)(pid_t, int *, int)' (aka 'long (*)(int, int *, int)') and 'long (*)(pid_t, int *, int)' (aka 'long (*)(int, int *, int)')) [-Wcompare-distinct-pointer-types]
kernel/exit.c:988:1: warning: comparison of distinct pointer types ('long (*)(int)' and 'long (*)(int)') [-Wcompare-distinct-pointer-types]
kernel/fork.c:1936:1: warning: comparison of distinct pointer types ('long (*)(int *)' and 'long (*)(int *)') [-Wcompare-distinct-pointer-types]
kernel/fork.c:2908:1: warning: comparison of distinct pointer types ('long (*)(unsigned long, unsigned long, int *, unsigned long, int *)' and 'long (*)(unsigned long, unsigned long, int *, unsigned long, int *)') [-Wcompare-distinct-pointer-types]
kernel/fork.c:3080:1: warning: comparison of distinct pointer types ('long (*)(struct clone_args *, size_t)' (aka 'long (*)(struct clone_args *, unsigned int)') and 'long (*)(struct clone_args *, size_t)' (aka 'long (*)(struct clone_args *, unsigned int)')) [-Wcompare-distinct-pointer-types]
kernel/fork.c:3394:1: warning: comparison of distinct pointer types ('long (*)(unsigned long)' and 'long (*)(unsigned long)') [-Wcompare-distinct-pointer-types]
kernel/futex/syscalls.c:160:1: warning: comparison of distinct pointer types ('long (*)(u32 *, int, u32, const struct __kernel_timespec *, u32 *, u32)' (aka 'long (*)(unsigned int *, int, unsigned int, const struct __kernel_timespec *, unsigned int *, unsigned int)') and 'long (*)(u32 *, int, u32, const struct __kernel_timespec *, u32 *, u32)' (aka 'long (*)(unsigned int *, int, unsigned int, const struct __kernel_timespec *, unsigned int *, unsigned int)')) [-Wcompare-distinct-pointer-types]
kernel/futex/syscalls.c:28:1: warning: comparison of distinct pointer types ('long (*)(struct robust_list_head *, size_t)' (aka 'long (*)(struct robust_list_head *, unsigned int)') and 'long (*)(struct robust_list_head *, size_t)' (aka 'long (*)(struct robust_list_head *, unsigned int)')) [-Wcompare-distinct-pointer-types]
kernel/futex/syscalls.c:290:1: warning: comparison of distinct pointer types ('long (*)(struct futex_waitv *, unsigned int, unsigned int, struct __kernel_timespec *, clockid_t)' (aka 'long (*)(struct futex_waitv *, unsigned int, unsigned int, struct __kernel_timespec *, int)') and 'long (*)(struct futex_waitv *, unsigned int, unsigned int, struct __kernel_timespec *, clockid_t)' (aka 'long (*)(struct futex_waitv *, unsigned int, unsigned int, struct __kernel_timespec *, int)')) [-Wcompare-distinct-pointer-types]
kernel/futex/syscalls.c:338:1: warning: comparison of distinct pointer types ('long (*)(void *, unsigned long, int, unsigned int)' and 'long (*)(void *, unsigned long, int, unsigned int)') [-Wcompare-distinct-pointer-types]
kernel/futex/syscalls.c:370:1: warning: comparison of distinct pointer types ('long (*)(void *, unsigned long, unsigned long, unsigned int, struct __kernel_timespec *, clockid_t)' (aka 'long (*)(void *, unsigned long, unsigned long, unsigned int, struct __kernel_timespec *, int)') and 'long (*)(void *, unsigned long, unsigned long, unsigned int, struct __kernel_timespec *, clockid_t)' (aka 'long (*)(void *, unsigned long, unsigned long, unsigned int, struct __kernel_timespec *, int)')) [-Wcompare-distinct-pointer-types]
kernel/futex/syscalls.c:414:1: warning: comparison of distinct pointer types ('long (*)(struct futex_waitv *, unsigned int, int, int)' and 'long (*)(struct futex_waitv *, unsigned int, int, int)') [-Wcompare-distinct-pointer-types]
kernel/futex/syscalls.c:48:1: warning: comparison of distinct pointer types ('long (*)(int, struct robust_list_head **, size_t *)' (aka 'long (*)(int, struct robust_list_head **, unsigned int *)') and 'long (*)(int, struct robust_list_head **, size_t *)' (aka 'long (*)(int, struct robust_list_head **, unsigned int *)')) [-Wcompare-distinct-pointer-types]
kernel/groups.c:161:1: warning: comparison of distinct pointer types ('long (*)(int, gid_t *)' (aka 'long (*)(int, unsigned int *)') and 'long (*)(int, gid_t *)' (aka 'long (*)(int, unsigned int *)')) [-Wcompare-distinct-pointer-types]
kernel/nsproxy.c:547:1: warning: comparison of distinct pointer types ('long (*)(int, int)' and 'long (*)(int, int)') [-Wcompare-distinct-pointer-types]
kernel/pid.c:629:1: warning: comparison of distinct pointer types ('long (*)(pid_t, unsigned int)' (aka 'long (*)(int, unsigned int)') and 'long (*)(pid_t, unsigned int)' (aka 'long (*)(int, unsigned int)')) [-Wcompare-distinct-pointer-types]
kernel/pid.c:746:1: warning: comparison of distinct pointer types ('long (*)(int, int, unsigned int)' and 'long (*)(int, int, unsigned int)') [-Wcompare-distinct-pointer-types]
kernel/printk/printk.c:1824:1: warning: comparison of distinct pointer types ('long (*)(int, char *, int)' and 'long (*)(int, char *, int)') [-Wcompare-distinct-pointer-types]
kernel/ptrace.c:1258:1: warning: comparison of distinct pointer types ('long (*)(long, long, unsigned long, unsigned long)' and 'long (*)(long, long, unsigned long, unsigned long)') [-Wcompare-distinct-pointer-types]
kernel/reboot.c:715:1: warning: comparison of distinct pointer types ('long (*)(int, int, unsigned int, void *)' and 'long (*)(int, int, unsigned int, void *)') [-Wcompare-distinct-pointer-types]
kernel/sched/core.c:7361:1: warning: comparison of distinct pointer types ('long (*)(int)' and 'long (*)(int)') [-Wcompare-distinct-pointer-types]
kernel/sched/core.c:8125:1: warning: comparison of distinct pointer types ('long (*)(pid_t, int, struct sched_param *)' (aka 'long (*)(int, int, struct sched_param *)') and 'long (*)(pid_t, int, struct sched_param *)' (aka 'long (*)(int, int, struct sched_param *)')) [-Wcompare-distinct-pointer-types]
kernel/sched/core.c:8140:1: warning: comparison of distinct pointer types ('long (*)(pid_t, struct sched_param *)' (aka 'long (*)(int, struct sched_param *)') and 'long (*)(pid_t, struct sched_param *)' (aka 'long (*)(int, struct sched_param *)')) [-Wcompare-distinct-pointer-types]
kernel/sched/core.c:8151:1: warning: comparison of distinct pointer types ('long (*)(pid_t, struct sched_attr *, unsigned int)' (aka 'long (*)(int, struct sched_attr *, unsigned int)') and 'long (*)(pid_t, struct sched_attr *, unsigned int)' (aka 'long (*)(int, struct sched_attr *, unsigned int)')) [-Wcompare-distinct-pointer-types]
kernel/sched/core.c:8186:1: warning: comparison of distinct pointer types ('long (*)(pid_t)' (aka 'long (*)(int)') and 'long (*)(pid_t)' (aka 'long (*)(int)')) [-Wcompare-distinct-pointer-types]
kernel/sched/core.c:8290:1: warning: comparison of distinct pointer types ('long (*)(pid_t, struct sched_attr *, unsigned int, unsigned int)' (aka 'long (*)(int, struct sched_attr *, unsigned int, unsigned int)') and 'long (*)(pid_t, struct sched_attr *, unsigned int, unsigned int)' (aka 'long (*)(int, struct sched_attr *, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
kernel/sched/core.c:8481:1: warning: comparison of distinct pointer types ('long (*)(pid_t, unsigned int, unsigned long *)' (aka 'long (*)(int, unsigned int, unsigned long *)') and 'long (*)(pid_t, unsigned int, unsigned long *)' (aka 'long (*)(int, unsigned int, unsigned long *)')) [-Wcompare-distinct-pointer-types]
kernel/sched/core.c:9140:1: warning: comparison of distinct pointer types ('long (*)(pid_t, struct __kernel_timespec *)' (aka 'long (*)(int, struct __kernel_timespec *)') and 'long (*)(pid_t, struct __kernel_timespec *)' (aka 'long (*)(int, struct __kernel_timespec *)')) [-Wcompare-distinct-pointer-types]
kernel/sched/membarrier.c:625:1: warning: comparison of distinct pointer types ('long (*)(int, unsigned int, int)' and 'long (*)(int, unsigned int, int)') [-Wcompare-distinct-pointer-types]
kernel/signal.c:3193:1: warning: comparison of distinct pointer types ('long (*)(int, sigset_t *, sigset_t *, size_t)' (aka 'long (*)(int, sigset_t *, sigset_t *, unsigned int)') and 'long (*)(int, sigset_t *, sigset_t *, size_t)' (aka 'long (*)(int, sigset_t *, sigset_t *, unsigned int)')) [-Wcompare-distinct-pointer-types]
kernel/signal.c:3265:1: warning: comparison of distinct pointer types ('long (*)(sigset_t *, size_t)' (aka 'long (*)(sigset_t *, unsigned int)') and 'long (*)(sigset_t *, size_t)' (aka 'long (*)(sigset_t *, unsigned int)')) [-Wcompare-distinct-pointer-types]
kernel/signal.c:3679:1: warning: comparison of distinct pointer types ('long (*)(const sigset_t *, siginfo_t *, const struct __kernel_timespec *, size_t)' (aka 'long (*)(const sigset_t *, struct siginfo *, const struct __kernel_timespec *, unsigned int)') and 'long (*)(const sigset_t *, siginfo_t *, const struct __kernel_timespec *, size_t)' (aka 'long (*)(const sigset_t *, struct siginfo *, const struct __kernel_timespec *, unsigned int)')) [-Wcompare-distinct-pointer-types]
kernel/signal.c:3824:1: warning: comparison of distinct pointer types ('long (*)(pid_t, int)' (aka 'long (*)(int, int)') and 'long (*)(pid_t, int)' (aka 'long (*)(int, int)')) [-Wcompare-distinct-pointer-types]
kernel/signal.c:3899:1: warning: comparison of distinct pointer types ('long (*)(int, int, siginfo_t *, unsigned int)' (aka 'long (*)(int, int, struct siginfo *, unsigned int)') and 'long (*)(int, int, siginfo_t *, unsigned int)' (aka 'long (*)(int, int, struct siginfo *, unsigned int)')) [-Wcompare-distinct-pointer-types]
kernel/signal.c:4026:1: warning: comparison of distinct pointer types ('long (*)(pid_t, pid_t, int)' (aka 'long (*)(int, int, int)') and 'long (*)(pid_t, pid_t, int)' (aka 'long (*)(int, int, int)')) [-Wcompare-distinct-pointer-types]
kernel/signal.c:4070:1: warning: comparison of distinct pointer types ('long (*)(pid_t, int, siginfo_t *)' (aka 'long (*)(int, int, struct siginfo *)') and 'long (*)(pid_t, int, siginfo_t *)' (aka 'long (*)(int, int, struct siginfo *)')) [-Wcompare-distinct-pointer-types]
kernel/signal.c:4110:1: warning: comparison of distinct pointer types ('long (*)(pid_t, pid_t, int, siginfo_t *)' (aka 'long (*)(int, int, int, struct siginfo *)') and 'long (*)(pid_t, pid_t, int, siginfo_t *)' (aka 'long (*)(int, int, int, struct siginfo *)')) [-Wcompare-distinct-pointer-types]
kernel/signal.c:4301:1: warning: comparison of distinct pointer types ('long (*)(const stack_t *, stack_t *)' (aka 'long (*)(const struct sigaltstack *, struct sigaltstack *)') and 'long (*)(const struct sigaltstack *, struct sigaltstack *)') [-Wcompare-distinct-pointer-types]
kernel/signal.c:4397:1: warning: comparison of distinct pointer types ('long (*)(old_sigset_t *)' (aka 'long (*)(unsigned long *)') and 'long (*)(old_sigset_t *)' (aka 'long (*)(unsigned long *)')) [-Wcompare-distinct-pointer-types]
kernel/signal.c:4436:1: warning: comparison of distinct pointer types ('long (*)(int, old_sigset_t *, old_sigset_t *)' (aka 'long (*)(int, unsigned long *, unsigned long *)') and 'long (*)(int, old_sigset_t *, old_sigset_t *)' (aka 'long (*)(int, unsigned long *, unsigned long *)')) [-Wcompare-distinct-pointer-types]
kernel/signal.c:4484:1: warning: comparison of distinct pointer types ('long (*)(int, const struct sigaction *, struct sigaction *, size_t)' (aka 'long (*)(int, const struct sigaction *, struct sigaction *, unsigned int)') and 'long (*)(int, const struct sigaction *, struct sigaction *, size_t)' (aka 'long (*)(int, const struct sigaction *, struct sigaction *, unsigned int)')) [-Wcompare-distinct-pointer-types]
kernel/signal.c:4556:1: warning: comparison of distinct pointer types ('long (*)(int, const struct old_sigaction *, struct old_sigaction *)' and 'long (*)(int, const struct old_sigaction *, struct old_sigaction *)') [-Wcompare-distinct-pointer-types]
kernel/signal.c:4660:1: warning: comparison of distinct pointer types ('long (*)(int, __sighandler_t)' (aka 'long (*)(int, void (*)(int))') and 'long (*)(int, __sighandler_t)' (aka 'long (*)(int, void (*)(int))')) [-Wcompare-distinct-pointer-types]
kernel/signal.c:4744:1: warning: comparison of distinct pointer types ('long (*)(int, int, old_sigset_t)' (aka 'long (*)(int, int, unsigned long)') and 'long (*)(int, int, old_sigset_t)' (aka 'long (*)(int, int, unsigned long)')) [-Wcompare-distinct-pointer-types]
kernel/sys.c:1032:1: warning: comparison of distinct pointer types ('long (*)(struct tms *)' and 'long (*)(struct tms *)') [-Wcompare-distinct-pointer-types]
kernel/sys.c:1082:1: warning: comparison of distinct pointer types ('long (*)(pid_t, pid_t)' (aka 'long (*)(int, int)') and 'long (*)(pid_t, pid_t)' (aka 'long (*)(int, int)')) [-Wcompare-distinct-pointer-types]
kernel/sys.c:1181:1: warning: comparison of distinct pointer types ('long (*)(pid_t)' (aka 'long (*)(int)') and 'long (*)(pid_t)' (aka 'long (*)(int)')) [-Wcompare-distinct-pointer-types]
kernel/sys.c:1315:1: warning: comparison of distinct pointer types ('long (*)(struct new_utsname *)' and 'long (*)(struct new_utsname *)') [-Wcompare-distinct-pointer-types]
kernel/sys.c:1336:1: warning: comparison of distinct pointer types ('long (*)(struct old_utsname *)' and 'long (*)(struct old_utsname *)') [-Wcompare-distinct-pointer-types]
kernel/sys.c:1356:1: warning: comparison of distinct pointer types ('long (*)(struct oldold_utsname *)' and 'long (*)(struct oldold_utsname *)') [-Wcompare-distinct-pointer-types]
kernel/sys.c:1383:1: warning: comparison of distinct pointer types ('long (*)(char *, int)' and 'long (*)(char *, int)') [-Wcompare-distinct-pointer-types]
kernel/sys.c:1527:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, struct rlimit *)' and 'long (*)(unsigned int, struct rlimit *)') [-Wcompare-distinct-pointer-types]
kernel/sys.c:1693:1: warning: comparison of distinct pointer types ('long (*)(pid_t, unsigned int, const struct rlimit64 *, struct rlimit64 *)' (aka 'long (*)(int, unsigned int, const struct rlimit64 *, struct rlimit64 *)') and 'long (*)(pid_t, unsigned int, const struct rlimit64 *, struct rlimit64 *)' (aka 'long (*)(int, unsigned int, const struct rlimit64 *, struct rlimit64 *)')) [-Wcompare-distinct-pointer-types]
kernel/sys.c:1880:1: warning: comparison of distinct pointer types ('long (*)(int, struct rusage *)' and 'long (*)(int, struct rusage *)') [-Wcompare-distinct-pointer-types]
kernel/sys.c:1906:1: warning: comparison of distinct pointer types ('long (*)(int)' and 'long (*)(int)') [-Wcompare-distinct-pointer-types]
kernel/sys.c:227:1: warning: comparison of distinct pointer types ('long (*)(int, int, int)' and 'long (*)(int, int, int)') [-Wcompare-distinct-pointer-types]
kernel/sys.c:2457:1: warning: comparison of distinct pointer types ('long (*)(int, unsigned long, unsigned long, unsigned long, unsigned long)' and 'long (*)(int, unsigned long, unsigned long, unsigned long, unsigned long)') [-Wcompare-distinct-pointer-types]
kernel/sys.c:2792:1: warning: comparison of distinct pointer types ('long (*)(unsigned int *, unsigned int *, struct getcpu_cache *)' and 'long (*)(unsigned int *, unsigned int *, struct getcpu_cache *)') [-Wcompare-distinct-pointer-types]
kernel/sys.c:2872:1: warning: comparison of distinct pointer types ('long (*)(struct sysinfo *)' and 'long (*)(struct sysinfo *)') [-Wcompare-distinct-pointer-types]
kernel/sys.c:297:1: warning: comparison of distinct pointer types ('long (*)(int, int)' and 'long (*)(int, int)') [-Wcompare-distinct-pointer-types]
kernel/sys.c:437:1: warning: comparison of distinct pointer types ('long (*)(gid_t, gid_t)' (aka 'long (*)(unsigned int, unsigned int)') and 'long (*)(gid_t, gid_t)' (aka 'long (*)(unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
kernel/sys.c:483:1: warning: comparison of distinct pointer types ('long (*)(gid_t)' (aka 'long (*)(unsigned int)') and 'long (*)(gid_t)' (aka 'long (*)(unsigned int)')) [-Wcompare-distinct-pointer-types]
kernel/sys.c:603:1: warning: comparison of distinct pointer types ('long (*)(uid_t, uid_t)' (aka 'long (*)(unsigned int, unsigned int)') and 'long (*)(uid_t, uid_t)' (aka 'long (*)(unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
kernel/sys.c:666:1: warning: comparison of distinct pointer types ('long (*)(uid_t)' (aka 'long (*)(unsigned int)') and 'long (*)(uid_t)' (aka 'long (*)(unsigned int)')) [-Wcompare-distinct-pointer-types]
kernel/sys.c:751:1: warning: comparison of distinct pointer types ('long (*)(uid_t, uid_t, uid_t)' (aka 'long (*)(unsigned int, unsigned int, unsigned int)') and 'long (*)(uid_t, uid_t, uid_t)' (aka 'long (*)(unsigned int, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
kernel/sys.c:756:1: warning: comparison of distinct pointer types ('long (*)(uid_t *, uid_t *, uid_t *)' (aka 'long (*)(unsigned int *, unsigned int *, unsigned int *)') and 'long (*)(uid_t *, uid_t *, uid_t *)' (aka 'long (*)(unsigned int *, unsigned int *, unsigned int *)')) [-Wcompare-distinct-pointer-types]
kernel/sys.c:840:1: warning: comparison of distinct pointer types ('long (*)(gid_t, gid_t, gid_t)' (aka 'long (*)(unsigned int, unsigned int, unsigned int)') and 'long (*)(gid_t, gid_t, gid_t)' (aka 'long (*)(unsigned int, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
kernel/sys.c:845:1: warning: comparison of distinct pointer types ('long (*)(gid_t *, gid_t *, gid_t *)' (aka 'long (*)(unsigned int *, unsigned int *, unsigned int *)') and 'long (*)(gid_t *, gid_t *, gid_t *)' (aka 'long (*)(unsigned int *, unsigned int *, unsigned int *)')) [-Wcompare-distinct-pointer-types]
kernel/time/itimer.c:113:1: warning: comparison of distinct pointer types ('long (*)(int, struct __kernel_old_itimerval *)' and 'long (*)(int, struct __kernel_old_itimerval *)') [-Wcompare-distinct-pointer-types]
kernel/time/itimer.c:306:1: warning: comparison of distinct pointer types ('long (*)(unsigned int)' and 'long (*)(unsigned int)') [-Wcompare-distinct-pointer-types]
kernel/time/itimer.c:332:1: warning: comparison of distinct pointer types ('long (*)(int, struct __kernel_old_itimerval *, struct __kernel_old_itimerval *)' and 'long (*)(int, struct __kernel_old_itimerval *, struct __kernel_old_itimerval *)') [-Wcompare-distinct-pointer-types]
kernel/time/posix-timers.c:1113:1: warning: comparison of distinct pointer types ('long (*)(const clockid_t, const struct __kernel_timespec *)' (aka 'long (*)(const int, const struct __kernel_timespec *)') and 'long (*)(clockid_t, const struct __kernel_timespec *)' (aka 'long (*)(int, const struct __kernel_timespec *)')) [-Wcompare-distinct-pointer-types]
kernel/time/posix-timers.c:1132:1: warning: comparison of distinct pointer types ('long (*)(const clockid_t, struct __kernel_timespec *)' (aka 'long (*)(const int, struct __kernel_timespec *)') and 'long (*)(clockid_t, struct __kernel_timespec *)' (aka 'long (*)(int, struct __kernel_timespec *)')) [-Wcompare-distinct-pointer-types]
kernel/time/posix-timers.c:1162:1: warning: comparison of distinct pointer types ('long (*)(const clockid_t, struct __kernel_timex *)' (aka 'long (*)(const int, struct __kernel_timex *)') and 'long (*)(clockid_t, struct __kernel_timex *)' (aka 'long (*)(int, struct __kernel_timex *)')) [-Wcompare-distinct-pointer-types]
kernel/time/posix-timers.c:1373:1: warning: comparison of distinct pointer types ('long (*)(const clockid_t, int, const struct __kernel_timespec *, struct __kernel_timespec *)' (aka 'long (*)(const int, int, const struct __kernel_timespec *, struct __kernel_timespec *)') and 'long (*)(clockid_t, int, const struct __kernel_timespec *, struct __kernel_timespec *)' (aka 'long (*)(int, int, const struct __kernel_timespec *, struct __kernel_timespec *)')) [-Wcompare-distinct-pointer-types]
kernel/time/posix-timers.c:530:1: warning: comparison of distinct pointer types ('long (*)(const clockid_t, struct sigevent *, timer_t *)' (aka 'long (*)(const int, struct sigevent *, int *)') and 'long (*)(clockid_t, struct sigevent *, timer_t *)' (aka 'long (*)(int, struct sigevent *, int *)')) [-Wcompare-distinct-pointer-types]
kernel/time/posix-timers.c:719:1: warning: comparison of distinct pointer types ('long (*)(timer_t, struct __kernel_itimerspec *)' (aka 'long (*)(int, struct __kernel_itimerspec *)') and 'long (*)(timer_t, struct __kernel_itimerspec *)' (aka 'long (*)(int, struct __kernel_itimerspec *)')) [-Wcompare-distinct-pointer-types]
kernel/time/posix-timers.c:767:1: warning: comparison of distinct pointer types ('long (*)(timer_t)' (aka 'long (*)(int)') and 'long (*)(timer_t)' (aka 'long (*)(int)')) [-Wcompare-distinct-pointer-types]
kernel/time/posix-timers.c:940:1: warning: comparison of distinct pointer types ('long (*)(timer_t, int, const struct __kernel_itimerspec *, struct __kernel_itimerspec *)' (aka 'long (*)(int, int, const struct __kernel_itimerspec *, struct __kernel_itimerspec *)') and 'long (*)(timer_t, int, const struct __kernel_itimerspec *, struct __kernel_itimerspec *)' (aka 'long (*)(int, int, const struct __kernel_itimerspec *, struct __kernel_itimerspec *)')) [-Wcompare-distinct-pointer-types]
kernel/time/time.c:140:1: warning: comparison of distinct pointer types ('long (*)(struct __kernel_old_timeval *, struct timezone *)' and 'long (*)(struct __kernel_old_timeval *, struct timezone *)') [-Wcompare-distinct-pointer-types]
kernel/uid16.c:154:1: warning: comparison of distinct pointer types ('long (*)(int, old_gid_t *)' (aka 'long (*)(int, unsigned short *)') and 'long (*)(int, old_gid_t *)' (aka 'long (*)(int, unsigned short *)')) [-Wcompare-distinct-pointer-types]
kernel/uid16.c:23:1: warning: comparison of distinct pointer types ('long (*)(const char *, old_uid_t, old_gid_t)' (aka 'long (*)(const char *, unsigned short, unsigned short)') and 'long (*)(const char *, old_uid_t, old_gid_t)' (aka 'long (*)(const char *, unsigned short, unsigned short)')) [-Wcompare-distinct-pointer-types]
kernel/uid16.c:33:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, old_uid_t, old_gid_t)' (aka 'long (*)(unsigned int, unsigned short, unsigned short)') and 'long (*)(unsigned int, old_uid_t, old_gid_t)' (aka 'long (*)(unsigned int, unsigned short, unsigned short)')) [-Wcompare-distinct-pointer-types]
kernel/uid16.c:38:1: warning: comparison of distinct pointer types ('long (*)(old_gid_t, old_gid_t)' (aka 'long (*)(unsigned short, unsigned short)') and 'long (*)(old_gid_t, old_gid_t)' (aka 'long (*)(unsigned short, unsigned short)')) [-Wcompare-distinct-pointer-types]
kernel/uid16.c:43:1: warning: comparison of distinct pointer types ('long (*)(old_gid_t)' (aka 'long (*)(unsigned short)') and 'long (*)(old_gid_t)' (aka 'long (*)(unsigned short)')) [-Wcompare-distinct-pointer-types]
kernel/uid16.c:48:1: warning: comparison of distinct pointer types ('long (*)(old_uid_t, old_uid_t)' (aka 'long (*)(unsigned short, unsigned short)') and 'long (*)(old_uid_t, old_uid_t)' (aka 'long (*)(unsigned short, unsigned short)')) [-Wcompare-distinct-pointer-types]
kernel/uid16.c:53:1: warning: comparison of distinct pointer types ('long (*)(old_uid_t)' (aka 'long (*)(unsigned short)') and 'long (*)(old_uid_t)' (aka 'long (*)(unsigned short)')) [-Wcompare-distinct-pointer-types]
kernel/uid16.c:58:1: warning: comparison of distinct pointer types ('long (*)(old_uid_t, old_uid_t, old_uid_t)' (aka 'long (*)(unsigned short, unsigned short, unsigned short)') and 'long (*)(old_uid_t, old_uid_t, old_uid_t)' (aka 'long (*)(unsigned short, unsigned short, unsigned short)')) [-Wcompare-distinct-pointer-types]
kernel/uid16.c:64:1: warning: comparison of distinct pointer types ('long (*)(old_uid_t *, old_uid_t *, old_uid_t *)' (aka 'long (*)(unsigned short *, unsigned short *, unsigned short *)') and 'long (*)(old_uid_t *, old_uid_t *, old_uid_t *)' (aka 'long (*)(unsigned short *, unsigned short *, unsigned short *)')) [-Wcompare-distinct-pointer-types]
kernel/uid16.c:81:1: warning: comparison of distinct pointer types ('long (*)(old_gid_t, old_gid_t, old_gid_t)' (aka 'long (*)(unsigned short, unsigned short, unsigned short)') and 'long (*)(old_gid_t, old_gid_t, old_gid_t)' (aka 'long (*)(unsigned short, unsigned short, unsigned short)')) [-Wcompare-distinct-pointer-types]
kernel/uid16.c:87:1: warning: comparison of distinct pointer types ('long (*)(old_gid_t *, old_gid_t *, old_gid_t *)' (aka 'long (*)(unsigned short *, unsigned short *, unsigned short *)') and 'long (*)(old_gid_t *, old_gid_t *, old_gid_t *)' (aka 'long (*)(unsigned short *, unsigned short *, unsigned short *)')) [-Wcompare-distinct-pointer-types]
ld.lld: error: undefined symbol: __arm64_sys_getxattrat
ld.lld: error: undefined symbol: __arm64_sys_listxattrat
ld.lld: error: undefined symbol: __arm64_sys_removexattrat
ld.lld: error: undefined symbol: __arm64_sys_setxattrat
ld.lld: error: undefined symbol: __arm64_sys_uretprobe
ld.lld: error: undefined symbol: __ia32_sys_fadvise64_64_6
ld.lld: error: undefined symbol: __powerpc_sys_fadvise64
ld.lld: error: undefined symbol: __riscv_sys_getxattrat
ld.lld: error: undefined symbol: __riscv_sys_listxattrat
ld.lld: error: undefined symbol: __riscv_sys_removexattrat
ld.lld: error: undefined symbol: __riscv_sys_setxattrat
ld.lld: error: undefined symbol: __riscv_sys_uretprobe
ld.lld: error: undefined symbol: __x64_sys_fadvise64
ld: arch/x86/entry/syscall_32.o:(.rodata+0xb80): undefined reference to `__ia32_sys_fadvise64_64_6'
ld: arch/x86/entry/syscall_64.o:(.rodata+0x1568): undefined reference to `__x64_sys_fadvise64'
mm/fadvise.c:238:1: warning: comparison of distinct pointer types ('long (*)(int, u32, u32, u32, u32, int)' (aka 'long (*)(int, unsigned int, unsigned int, unsigned int, unsigned int, int)') and 'long (*)(int, u32, u32, u32, u32, int)' (aka 'long (*)(int, unsigned int, unsigned int, unsigned int, unsigned int, int)')) [-Wcompare-distinct-pointer-types]
mm/fadvise.c:251:1: warning: comparison of distinct pointer types ('long (*)(int, u32, u32, size_t, int)' (aka 'long (*)(int, unsigned int, unsigned int, unsigned int, int)') and 'long (*)(int, u32, u32, size_t, int)' (aka 'long (*)(int, unsigned int, unsigned int, unsigned int, int)')) [-Wcompare-distinct-pointer-types]
mm/filemap.c:4372:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, struct cachestat_range *, struct cachestat *, unsigned int)' and 'long (*)(unsigned int, struct cachestat_range *, struct cachestat *, unsigned int)') [-Wcompare-distinct-pointer-types]
mm/madvise.c:1479:1: warning: comparison of distinct pointer types ('long (*)(unsigned long, size_t, int)' (aka 'long (*)(unsigned long, unsigned int, int)') and 'long (*)(unsigned long, size_t, int)' (aka 'long (*)(unsigned long, unsigned int, int)')) [-Wcompare-distinct-pointer-types]
mm/madvise.c:1484:1: warning: comparison of distinct pointer types ('long (*)(int, const struct iovec *, size_t, int, unsigned int)' (aka 'long (*)(int, const struct iovec *, unsigned int, int, unsigned int)') and 'long (*)(int, const struct iovec *, size_t, int, unsigned int)' (aka 'long (*)(int, const struct iovec *, unsigned int, int, unsigned int)')) [-Wcompare-distinct-pointer-types]
mm/mincore.c:232:1: warning: comparison of distinct pointer types ('long (*)(unsigned long, size_t, unsigned char *)' (aka 'long (*)(unsigned long, unsigned int, unsigned char *)') and 'long (*)(unsigned long, size_t, unsigned char *)' (aka 'long (*)(unsigned long, unsigned int, unsigned char *)')) [-Wcompare-distinct-pointer-types]
mm/mlock.c:670:1: warning: comparison of distinct pointer types ('long (*)(unsigned long, size_t)' (aka 'long (*)(unsigned long, unsigned int)') and 'long (*)(unsigned long, size_t)' (aka 'long (*)(unsigned long, unsigned int)')) [-Wcompare-distinct-pointer-types]
mm/mlock.c:675:1: warning: comparison of distinct pointer types ('long (*)(unsigned long, size_t, int)' (aka 'long (*)(unsigned long, unsigned int, int)') and 'long (*)(unsigned long, size_t, int)' (aka 'long (*)(unsigned long, unsigned int, int)')) [-Wcompare-distinct-pointer-types]
mm/mlock.c:753:1: warning: comparison of distinct pointer types ('long (*)(int)' and 'long (*)(int)') [-Wcompare-distinct-pointer-types]
mm/mmap.c:1450:1: warning: comparison of distinct pointer types ('long (*)(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)' and 'long (*)(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)') [-Wcompare-distinct-pointer-types]
mm/mmap.c:1467:1: warning: comparison of distinct pointer types ('long (*)(struct mmap_arg_struct *)' and 'long (*)(struct mmap_arg_struct *)') [-Wcompare-distinct-pointer-types]
mm/mmap.c:178:1: warning: comparison of distinct pointer types ('long (*)(unsigned long)' and 'long (*)(unsigned long)') [-Wcompare-distinct-pointer-types]
mm/mmap.c:3052:1: warning: comparison of distinct pointer types ('long (*)(unsigned long, size_t)' (aka 'long (*)(unsigned long, unsigned int)') and 'long (*)(unsigned long, size_t)' (aka 'long (*)(unsigned long, unsigned int)')) [-Wcompare-distinct-pointer-types]
mm/mmap.c:3062:1: warning: comparison of distinct pointer types ('long (*)(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)' and 'long (*)(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)') [-Wcompare-distinct-pointer-types]
mm/mprotect.c:838:1: warning: comparison of distinct pointer types ('long (*)(unsigned long, size_t, unsigned long)' (aka 'long (*)(unsigned long, unsigned int, unsigned long)') and 'long (*)(unsigned long, size_t, unsigned long)' (aka 'long (*)(unsigned long, unsigned int, unsigned long)')) [-Wcompare-distinct-pointer-types]
mm/mremap.c:993:1: warning: comparison of distinct pointer types ('long (*)(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)' and 'long (*)(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)') [-Wcompare-distinct-pointer-types]
mm/msync.c:32:1: warning: comparison of distinct pointer types ('long (*)(unsigned long, size_t, int)' (aka 'long (*)(unsigned long, unsigned int, int)') and 'long (*)(unsigned long, size_t, int)' (aka 'long (*)(unsigned long, unsigned int, int)')) [-Wcompare-distinct-pointer-types]
mm/oom_kill.c:1199:1: warning: comparison of distinct pointer types ('long (*)(int, unsigned int)' and 'long (*)(int, unsigned int)') [-Wcompare-distinct-pointer-types]
mm/readahead.c:757:1: warning: comparison of distinct pointer types ('long (*)(int, u32, u32, size_t)' (aka 'long (*)(int, unsigned int, unsigned int, unsigned int)') and 'long (*)(int, u32, u32, size_t)' (aka 'long (*)(int, unsigned int, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
powerpc-linux-ld: arch/powerpc/kernel/systbl.o:(.rodata+0x3f8): undefined reference to `__powerpc_sys_fadvise64_64_2'
riscv64-linux-ld: arch/riscv/kernel/syscall_table.o:(.rodata+0xe78): undefined reference to `__riscv_sys_setxattrat'
riscv64-linux-ld: arch/riscv/kernel/syscall_table.o:(.rodata+0xe80): undefined reference to `__riscv_sys_getxattrat'
riscv64-linux-ld: arch/riscv/kernel/syscall_table.o:(.rodata+0xe88): undefined reference to `__riscv_sys_listxattrat'
riscv64-linux-ld: arch/riscv/kernel/syscall_table.o:(.rodata+0xe90): undefined reference to `__riscv_sys_removexattrat'
riscv64-linux-ld: arch/riscv/kernel/syscall_table.o:(.rodata+0xe98): undefined reference to `__riscv_sys_uretprobe'
sparc64-linux-ld: (.text+0x230c8): undefined reference to `sys_fadvise64'
syscall_32.c:(.text+0x6c2): undefined reference to `__ia32_sys_fadvise64_64_6'

Unverified Error/Warning (likely false positive, please contact us if interested):

arch/arm/kernel/entry-common.S: asm/syscall_table_oabi.h is included more than once.

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arc-allmodconfig
|   |-- arch-arc-include-generated-asm-syscall_table_32.h:error:sys_getxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-arc-include-generated-asm-syscall_table_32.h:error:sys_listxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-arc-include-generated-asm-syscall_table_32.h:error:sys_removexattrat-undeclared-here-(not-in-a-function)
|   `-- arch-arc-include-generated-asm-syscall_table_32.h:error:sys_setxattrat-undeclared-here-(not-in-a-function)
|-- arc-allnoconfig
|   |-- arch-arc-include-generated-asm-syscall_table_32.h:error:sys_getxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-arc-include-generated-asm-syscall_table_32.h:error:sys_listxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-arc-include-generated-asm-syscall_table_32.h:error:sys_removexattrat-undeclared-here-(not-in-a-function)
|   `-- arch-arc-include-generated-asm-syscall_table_32.h:error:sys_setxattrat-undeclared-here-(not-in-a-function)
|-- arc-allyesconfig
|   |-- arch-arc-include-generated-asm-syscall_table_32.h:error:sys_getxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-arc-include-generated-asm-syscall_table_32.h:error:sys_listxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-arc-include-generated-asm-syscall_table_32.h:error:sys_removexattrat-undeclared-here-(not-in-a-function)
|   `-- arch-arc-include-generated-asm-syscall_table_32.h:error:sys_setxattrat-undeclared-here-(not-in-a-function)
|-- arc-randconfig-001-20240718
|   |-- arch-arc-include-generated-asm-syscall_table_32.h:error:sys_getxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-arc-include-generated-asm-syscall_table_32.h:error:sys_listxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-arc-include-generated-asm-syscall_table_32.h:error:sys_removexattrat-undeclared-here-(not-in-a-function)
|   `-- arch-arc-include-generated-asm-syscall_table_32.h:error:sys_setxattrat-undeclared-here-(not-in-a-function)
|-- arc-randconfig-002-20240718
|   |-- arch-arc-include-generated-asm-syscall_table_32.h:error:sys_getxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-arc-include-generated-asm-syscall_table_32.h:error:sys_listxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-arc-include-generated-asm-syscall_table_32.h:error:sys_removexattrat-undeclared-here-(not-in-a-function)
|   `-- arch-arc-include-generated-asm-syscall_table_32.h:error:sys_setxattrat-undeclared-here-(not-in-a-function)
|-- arm-allyesconfig
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:addr-undeclared-(first-use-in-this-function)
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:addrlen-undeclared-(first-use-in-this-function)
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:fifth-undeclared-(first-use-in-this-function)
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:too-few-arguments-to-function-__sys_sendmsg
|   |-- arch-arm-kernel-sys_oabi-compat.c:error:too-many-arguments-to-function-sys_oabi_sendto
|   |-- arch-arm-kernel-sys_oabi-compat.c:warning:control-reaches-end-of-non-void-function
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_oabi_ipc-have-long-int(uint-int-int-int-void-)-aka-long-int(unsigned-int-int-int-int-void-)
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_oabi_sendto-have-long-int(int-void-size_t-unsigned-int)-aka-long-int(int-void-unsigned-int-unsigned-int)
|   `-- include-linux-syscalls.h:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arm-randconfig-004-20240718
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_oabi_semtimedop-have-long-int(int-struct-oabi_sembuf-unsigned-int)
|-- arm64-allnoconfig
|   `-- arch-arm64-include-asm-syscalls.h:error:unknown-type-name-compat_size_t
|-- arm64-randconfig-001-20240718
|   |-- ld.lld:error:undefined-symbol:__arm64_sys_getxattrat
|   |-- ld.lld:error:undefined-symbol:__arm64_sys_listxattrat
|   |-- ld.lld:error:undefined-symbol:__arm64_sys_removexattrat
|   |-- ld.lld:error:undefined-symbol:__arm64_sys_setxattrat
|   `-- ld.lld:error:undefined-symbol:__arm64_sys_uretprobe
|-- arm64-randconfig-002-20240718
|   `-- arch-arm64-include-asm-syscalls.h:error:unknown-type-name-compat_size_t
|-- arm64-randconfig-003-20240718
|   |-- aarch64-linux-ld:arch-arm64-kernel-sys.o:(.rodata):undefined-reference-to-__arm64_sys_fadvise64
|   |-- aarch64-linux-ld:arch-arm64-kernel-sys.o:(.rodata):undefined-reference-to-__arm64_sys_getxattrat
|   |-- aarch64-linux-ld:arch-arm64-kernel-sys.o:(.rodata):undefined-reference-to-__arm64_sys_listxattrat
|   |-- aarch64-linux-ld:arch-arm64-kernel-sys.o:(.rodata):undefined-reference-to-__arm64_sys_removexattrat
|   |-- aarch64-linux-ld:arch-arm64-kernel-sys.o:(.rodata):undefined-reference-to-__arm64_sys_setxattrat
|   |-- aarch64-linux-ld:arch-arm64-kernel-sys.o:(.rodata):undefined-reference-to-__arm64_sys_uretprobe
|   `-- aarch64-linux-ld:arch-arm64-kernel-sys32.o:(.rodata):undefined-reference-to-__arm64_sys_fadvise64_64_2
|-- arm64-randconfig-004-20240718
|   `-- arch-arm64-include-asm-syscalls.h:error:unknown-type-name-compat_size_t
|-- csky-allnoconfig
|   |-- arch-csky-include-generated-asm-syscall_table_32.h:error:sys_getxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-csky-include-generated-asm-syscall_table_32.h:error:sys_listxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-csky-include-generated-asm-syscall_table_32.h:error:sys_removexattrat-undeclared-here-(not-in-a-function)
|   `-- arch-csky-include-generated-asm-syscall_table_32.h:error:sys_setxattrat-undeclared-here-(not-in-a-function)
|-- csky-randconfig-001-20240718
|   |-- arch-csky-include-generated-asm-syscall_table_32.h:error:sys_getxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-csky-include-generated-asm-syscall_table_32.h:error:sys_listxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-csky-include-generated-asm-syscall_table_32.h:error:sys_removexattrat-undeclared-here-(not-in-a-function)
|   `-- arch-csky-include-generated-asm-syscall_table_32.h:error:sys_setxattrat-undeclared-here-(not-in-a-function)
|-- csky-randconfig-002-20240718
|   |-- arch-csky-include-generated-asm-syscall_table_32.h:error:sys_getxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-csky-include-generated-asm-syscall_table_32.h:error:sys_listxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-csky-include-generated-asm-syscall_table_32.h:error:sys_removexattrat-undeclared-here-(not-in-a-function)
|   `-- arch-csky-include-generated-asm-syscall_table_32.h:error:sys_setxattrat-undeclared-here-(not-in-a-function)
|-- hexagon-allmodconfig
|   |-- arch-hexagon-include-generated-asm-syscall_table_32.h:error:use-of-undeclared-identifier-sys_getxattrat
|   |-- arch-hexagon-include-generated-asm-syscall_table_32.h:error:use-of-undeclared-identifier-sys_listxattrat
|   |-- arch-hexagon-include-generated-asm-syscall_table_32.h:error:use-of-undeclared-identifier-sys_removexattrat
|   `-- arch-hexagon-include-generated-asm-syscall_table_32.h:error:use-of-undeclared-identifier-sys_setxattrat
|-- hexagon-allnoconfig
|   |-- arch-hexagon-include-generated-asm-syscall_table_32.h:error:use-of-undeclared-identifier-sys_getxattrat
|   |-- arch-hexagon-include-generated-asm-syscall_table_32.h:error:use-of-undeclared-identifier-sys_listxattrat
|   |-- arch-hexagon-include-generated-asm-syscall_table_32.h:error:use-of-undeclared-identifier-sys_removexattrat
|   `-- arch-hexagon-include-generated-asm-syscall_table_32.h:error:use-of-undeclared-identifier-sys_setxattrat
|-- hexagon-allyesconfig
|   |-- arch-hexagon-include-generated-asm-syscall_table_32.h:error:use-of-undeclared-identifier-sys_getxattrat
|   |-- arch-hexagon-include-generated-asm-syscall_table_32.h:error:use-of-undeclared-identifier-sys_listxattrat
|   |-- arch-hexagon-include-generated-asm-syscall_table_32.h:error:use-of-undeclared-identifier-sys_removexattrat
|   `-- arch-hexagon-include-generated-asm-syscall_table_32.h:error:use-of-undeclared-identifier-sys_setxattrat
|-- hexagon-randconfig-001-20240718
|   |-- arch-hexagon-include-generated-asm-syscall_table_32.h:error:use-of-undeclared-identifier-sys_getxattrat
|   |-- arch-hexagon-include-generated-asm-syscall_table_32.h:error:use-of-undeclared-identifier-sys_listxattrat
|   |-- arch-hexagon-include-generated-asm-syscall_table_32.h:error:use-of-undeclared-identifier-sys_removexattrat
|   `-- arch-hexagon-include-generated-asm-syscall_table_32.h:error:use-of-undeclared-identifier-sys_setxattrat
|-- hexagon-randconfig-002-20240718
|   |-- arch-hexagon-include-generated-asm-syscall_table_32.h:error:use-of-undeclared-identifier-sys_getxattrat
|   |-- arch-hexagon-include-generated-asm-syscall_table_32.h:error:use-of-undeclared-identifier-sys_listxattrat
|   |-- arch-hexagon-include-generated-asm-syscall_table_32.h:error:use-of-undeclared-identifier-sys_removexattrat
|   `-- arch-hexagon-include-generated-asm-syscall_table_32.h:error:use-of-undeclared-identifier-sys_setxattrat
|-- i386-allmodconfig
|   |-- arch-x86-include-asm-syscall_wrapper.h:error:sys_vm86-undeclared-here-(not-in-a-function)
|   `-- arch-x86-include-asm-syscall_wrapper.h:error:sys_vm86old-undeclared-here-(not-in-a-function)
|-- i386-allyesconfig
|   |-- arch-x86-include-asm-syscall_wrapper.h:error:sys_vm86-undeclared-here-(not-in-a-function)
|   `-- arch-x86-include-asm-syscall_wrapper.h:error:sys_vm86old-undeclared-here-(not-in-a-function)
|-- i386-buildonly-randconfig-002-20240718
|   |-- ld:arch-x86-entry-syscall_32.o:(.rodata):undefined-reference-to-__ia32_sys_fadvise64_64_6
|   `-- syscall_32.c:(.text):undefined-reference-to-__ia32_sys_fadvise64_64_6
|-- i386-randconfig-004-20240718
|   |-- arch-x86-kernel-vm86_32.c:error:incompatible-function-pointer-types-initializing-long-(-)(struct-vm86_struct-)-with-an-expression-of-type-long-(const-char-umode_t-unsigned-int)-(aka-long-(const-char-u
|   |-- arch-x86-kernel-vm86_32.c:error:incompatible-function-pointer-types-initializing-long-(-)(unsigned-long-unsigned-long)-with-an-expression-of-type-long-(unsigned-long-unsigned-long-unsigned-long-unsign
|   |-- arch-x86-kernel-vm86_32.c:error:use-of-undeclared-identifier-sys_vm86
|   `-- arch-x86-kernel-vm86_32.c:error:use-of-undeclared-identifier-sys_vm86old
|-- i386-randconfig-005-20240718
|   `-- ld.lld:error:undefined-symbol:__ia32_sys_fadvise64_64_6
|-- i386-randconfig-011-20240718
|   |-- arch-x86-include-asm-syscall_wrapper.h:error:sys_vm86-undeclared-here-(not-in-a-function)
|   `-- arch-x86-include-asm-syscall_wrapper.h:error:sys_vm86old-undeclared-here-(not-in-a-function)
|-- i386-randconfig-012-20240718
|   |-- arch-x86-include-asm-syscall_wrapper.h:error:sys_vm86-undeclared-here-(not-in-a-function)
|   `-- arch-x86-include-asm-syscall_wrapper.h:error:sys_vm86old-undeclared-here-(not-in-a-function)
|-- i386-randconfig-013-20240718
|   |-- arch-x86-include-asm-syscall_wrapper.h:error:sys_vm86-undeclared-here-(not-in-a-function)
|   `-- arch-x86-include-asm-syscall_wrapper.h:error:sys_vm86old-undeclared-here-(not-in-a-function)
|-- loongarch-allmodconfig
|   |-- arch-loongarch-include-generated-asm-syscall_table_64.h:error:sys_getxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-loongarch-include-generated-asm-syscall_table_64.h:error:sys_listxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-loongarch-include-generated-asm-syscall_table_64.h:error:sys_removexattrat-undeclared-here-(not-in-a-function)
|   |-- arch-loongarch-include-generated-asm-syscall_table_64.h:error:sys_setxattrat-undeclared-here-(not-in-a-function)
|   `-- arch-loongarch-include-generated-asm-syscall_table_64.h:error:sys_uretprobe-undeclared-here-(not-in-a-function)
|-- loongarch-allyesconfig
|   |-- arch-loongarch-include-generated-asm-syscall_table_64.h:error:sys_getxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-loongarch-include-generated-asm-syscall_table_64.h:error:sys_listxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-loongarch-include-generated-asm-syscall_table_64.h:error:sys_removexattrat-undeclared-here-(not-in-a-function)
|   |-- arch-loongarch-include-generated-asm-syscall_table_64.h:error:sys_setxattrat-undeclared-here-(not-in-a-function)
|   `-- arch-loongarch-include-generated-asm-syscall_table_64.h:error:sys_uretprobe-undeclared-here-(not-in-a-function)
|-- loongarch-randconfig-001-20240718
|   |-- arch-loongarch-include-generated-asm-syscall_table_64.h:error:sys_getxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-loongarch-include-generated-asm-syscall_table_64.h:error:sys_listxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-loongarch-include-generated-asm-syscall_table_64.h:error:sys_removexattrat-undeclared-here-(not-in-a-function)
|   |-- arch-loongarch-include-generated-asm-syscall_table_64.h:error:sys_setxattrat-undeclared-here-(not-in-a-function)
|   `-- arch-loongarch-include-generated-asm-syscall_table_64.h:error:sys_uretprobe-undeclared-here-(not-in-a-function)
|-- loongarch-randconfig-002-20240718
|   |-- arch-loongarch-include-generated-asm-syscall_table_64.h:error:sys_getxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-loongarch-include-generated-asm-syscall_table_64.h:error:sys_listxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-loongarch-include-generated-asm-syscall_table_64.h:error:sys_removexattrat-undeclared-here-(not-in-a-function)
|   |-- arch-loongarch-include-generated-asm-syscall_table_64.h:error:sys_setxattrat-undeclared-here-(not-in-a-function)
|   `-- arch-loongarch-include-generated-asm-syscall_table_64.h:error:sys_uretprobe-undeclared-here-(not-in-a-function)
|-- mips-allmodconfig
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_mips_pipe-have-long-int(void)
|-- mips-cobalt_defconfig
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_mips_pipe-have-long-int(void)
|-- mips-ip27_defconfig
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_mips_pipe-have-long-int(void)
|-- nios2-allnoconfig
|   |-- arch-nios2-include-generated-asm-syscall_table_32.h:error:sys_getxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-nios2-include-generated-asm-syscall_table_32.h:error:sys_listxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-nios2-include-generated-asm-syscall_table_32.h:error:sys_removexattrat-undeclared-here-(not-in-a-function)
|   `-- arch-nios2-include-generated-asm-syscall_table_32.h:error:sys_setxattrat-undeclared-here-(not-in-a-function)
|-- nios2-randconfig-001-20240718
|   |-- arch-nios2-include-generated-asm-syscall_table_32.h:error:sys_getxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-nios2-include-generated-asm-syscall_table_32.h:error:sys_listxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-nios2-include-generated-asm-syscall_table_32.h:error:sys_removexattrat-undeclared-here-(not-in-a-function)
|   `-- arch-nios2-include-generated-asm-syscall_table_32.h:error:sys_setxattrat-undeclared-here-(not-in-a-function)
|-- nios2-randconfig-002-20240718
|   |-- arch-nios2-include-generated-asm-syscall_table_32.h:error:sys_getxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-nios2-include-generated-asm-syscall_table_32.h:error:sys_listxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-nios2-include-generated-asm-syscall_table_32.h:error:sys_removexattrat-undeclared-here-(not-in-a-function)
|   `-- arch-nios2-include-generated-asm-syscall_table_32.h:error:sys_setxattrat-undeclared-here-(not-in-a-function)
|-- openrisc-allnoconfig
|   |-- arch-openrisc-include-generated-asm-syscall_table_32.h:error:sys_getxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-openrisc-include-generated-asm-syscall_table_32.h:error:sys_listxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-openrisc-include-generated-asm-syscall_table_32.h:error:sys_removexattrat-undeclared-here-(not-in-a-function)
|   `-- arch-openrisc-include-generated-asm-syscall_table_32.h:error:sys_setxattrat-undeclared-here-(not-in-a-function)
|-- openrisc-allyesconfig
|   |-- arch-openrisc-include-generated-asm-syscall_table_32.h:error:sys_getxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-openrisc-include-generated-asm-syscall_table_32.h:error:sys_listxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-openrisc-include-generated-asm-syscall_table_32.h:error:sys_removexattrat-undeclared-here-(not-in-a-function)
|   `-- arch-openrisc-include-generated-asm-syscall_table_32.h:error:sys_setxattrat-undeclared-here-(not-in-a-function)
|-- openrisc-defconfig
|   |-- arch-openrisc-include-generated-asm-syscall_table_32.h:error:sys_getxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-openrisc-include-generated-asm-syscall_table_32.h:error:sys_listxattrat-undeclared-here-(not-in-a-function)
|   |-- arch-openrisc-include-generated-asm-syscall_table_32.h:error:sys_removexattrat-undeclared-here-(not-in-a-function)
|   `-- arch-openrisc-include-generated-asm-syscall_table_32.h:error:sys_setxattrat-undeclared-here-(not-in-a-function)
|-- powerpc-randconfig-003-20240718
|   `-- powerpc-linux-ld:arch-powerpc-kernel-systbl.o:(.rodata):undefined-reference-to-__powerpc_sys_fadvise64_64_2
|-- powerpc64-randconfig-003-20240718
|   `-- ld.lld:error:undefined-symbol:__powerpc_sys_fadvise64
|-- riscv-allnoconfig
|   |-- riscv64-linux-ld:arch-riscv-kernel-syscall_table.o:(.rodata):undefined-reference-to-__riscv_sys_getxattrat
|   |-- riscv64-linux-ld:arch-riscv-kernel-syscall_table.o:(.rodata):undefined-reference-to-__riscv_sys_listxattrat
|   |-- riscv64-linux-ld:arch-riscv-kernel-syscall_table.o:(.rodata):undefined-reference-to-__riscv_sys_removexattrat
|   |-- riscv64-linux-ld:arch-riscv-kernel-syscall_table.o:(.rodata):undefined-reference-to-__riscv_sys_setxattrat
|   `-- riscv64-linux-ld:arch-riscv-kernel-syscall_table.o:(.rodata):undefined-reference-to-__riscv_sys_uretprobe
|-- riscv-defconfig
|   |-- ld.lld:error:undefined-symbol:__riscv_sys_getxattrat
|   |-- ld.lld:error:undefined-symbol:__riscv_sys_listxattrat
|   |-- ld.lld:error:undefined-symbol:__riscv_sys_removexattrat
|   |-- ld.lld:error:undefined-symbol:__riscv_sys_setxattrat
|   `-- ld.lld:error:undefined-symbol:__riscv_sys_uretprobe
|-- sparc64-randconfig-001-20240718
|   |-- (.text):undefined-reference-to-sys_fadvise64
|   |-- (.text):undefined-reference-to-sys_fadvise64_64_6
|   `-- sparc64-linux-ld:(.text):undefined-reference-to-sys_fadvise64
|-- um-allnoconfig
|   |-- arch-x86-um-ldt.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-void-unsigned-long)-and-long-(-)(int-void-unsigned-long)-)
|   |-- arch-x86-um-sys_call_table_32.c:fatal-error:asm-syscalls_32.h-file-not-found
|   |-- arch-x86-um-syscalls_32.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-unsigned-long)-and-long-(-)(int-unsigned-long)-)
|   |-- arch-x86-um-tls_32.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(struct-user_desc-)-and-long-(-)(struct-user_desc-)-)
|   |-- block-ioprio.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-int)-and-long-(-)(int-int)-)
|   |-- block-ioprio.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-int-int)-and-long-(-)(int-int-int)-)
|   |-- drivers-char-random.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(char-size_t-unsigned-int)-(aka-long-(-)(char-unsigned-int-unsigned-int)-)-and-long-(-)(char-size_t-unsigned-int)-(aka-long
|   |-- fs-aio.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(aio_context_t)-(aka-long-(-)(unsigned-long)-)-and-long-(-)(aio_context_t)-(aka-long-(-)(unsigned-long)-))
|   |-- fs-aio.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(aio_context_t-long-long-struct-io_event-struct-__kernel_timespec-const-struct-__aio_sigset-)-(aka-long-(-)(unsigned-long-long-long-stru
|   |-- fs-aio.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(aio_context_t-long-struct-iocb-)-(aka-long-(-)(unsigned-long-long-struct-iocb-)-)-and-long-(-)(aio_context_t-long-struct-iocb-)-(aka-lo
|   |-- fs-aio.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(aio_context_t-struct-iocb-struct-io_event-)-(aka-long-(-)(unsigned-long-struct-iocb-struct-io_event-)-)-and-long-(-)(aio_context_t-stru
|   |-- fs-aio.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-aio_context_t-)-(aka-long-(-)(unsigned-int-unsigned-long-)-)-and-long-(-)(unsigned-int-aio_context_t-)-(aka-long-(-)(unsig
|   |-- fs-d_path.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(char-unsigned-long)-and-long-(-)(char-unsigned-long)-)
|   |-- fs-eventfd.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int)-and-long-(-)(unsigned-int)-)
|   |-- fs-eventfd.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-int)-and-long-(-)(unsigned-int-int)-)
|   |-- fs-eventpoll.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int)-and-long-(-)(int)-)
|   |-- fs-eventpoll.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-int-int-struct-epoll_event-)-and-long-(-)(int-int-int-struct-epoll_event-)-)
|   |-- fs-eventpoll.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-struct-epoll_event-int-const-struct-__kernel_timespec-const-sigset_t-size_t)-(aka-long-(-)(int-struct-epoll_event-int-const-s
|   |-- fs-eventpoll.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-struct-epoll_event-int-int)-and-long-(-)(int-struct-epoll_event-int-int)-)
|   |-- fs-eventpoll.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-struct-epoll_event-int-int-const-sigset_t-size_t)-(aka-long-(-)(int-struct-epoll_event-int-int-const-sigset_t-unsigned-int)-)
|   |-- fs-exec.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-const-char-const-const-char-const-)-and-long-(-)(const-char-const-char-const-const-char-const-)-)
|   |-- fs-exec.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-const-char-const-const-char-const-int)-and-long-(-)(int-const-char-const-char-const-const-char-const-int)-)
|   |-- fs-fcntl.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-unsigned-int-unsigned-long)-and-long-(-)(unsigned-int-unsigned-int-unsigned-long)-)
|   |-- fs-fhandle.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-struct-file_handle-int-int)-and-long-(-)(int-const-char-struct-file_handle-int-int)-)
|   |-- fs-fhandle.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-struct-file_handle-int)-and-long-(-)(int-struct-file_handle-int)-)
|   |-- fs-file.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int)-and-long-(-)(unsigned-int)-)
|   |-- fs-file.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-unsigned-int)-and-long-(-)(unsigned-int-unsigned-int)-)
|   |-- fs-file.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-unsigned-int-int)-and-long-(-)(unsigned-int-unsigned-int-int)-)
|   |-- fs-filesystems.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-unsigned-long-unsigned-long)-and-long-(-)(int-unsigned-long-unsigned-long)-)
|   |-- fs-fsopen.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-unsigned-int)-and-long-(-)(const-char-unsigned-int)-)
|   |-- fs-fsopen.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-unsigned-int)-and-long-(-)(int-const-char-unsigned-int)-)
|   |-- fs-fsopen.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-unsigned-int-const-char-const-void-int)-and-long-(-)(int-unsigned-int-const-char-const-void-int)-)
|   |-- fs-ioctl.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-unsigned-int-unsigned-long)-and-long-(-)(unsigned-int-unsigned-int-unsigned-long)-)
|   |-- fs-locks.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-unsigned-int)-and-long-(-)(unsigned-int-unsigned-int)-)
|   |-- fs-namei.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-)-and-long-(-)(const-char-)-)
|   |-- fs-namei.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-const-char-)-and-long-(-)(const-char-const-char-)-)
|   |-- fs-namei.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-int-const-char-)-and-long-(-)(const-char-int-const-char-)-)
|   |-- fs-namei.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-umode_t)-(aka-long-(-)(const-char-unsigned-short)-)-and-long-(-)(const-char-umode_t)-(aka-long-(-)(const-char-unsigned-sho
|   |-- fs-namei.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-umode_t-unsigned-int)-(aka-long-(-)(const-char-unsigned-short-unsigned-int)-)-and-long-(-)(const-char-umode_t-unsigned-int
|   |-- fs-namei.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-int)-and-long-(-)(int-const-char-int)-)
|   |-- fs-namei.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-int-const-char-)-and-long-(-)(int-const-char-int-const-char-)-)
|   |-- fs-namei.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-int-const-char-int)-and-long-(-)(int-const-char-int-const-char-int)-)
|   |-- fs-namei.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-int-const-char-unsigned-int)-and-long-(-)(int-const-char-int-const-char-unsigned-int)-)
|   |-- fs-namei.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-umode_t)-(aka-long-(-)(int-const-char-unsigned-short)-)-and-long-(-)(int-const-char-umode_t)-(aka-long-(-)(int-const-c
|   |-- fs-namei.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-umode_t-unsigned-int)-(aka-long-(-)(int-const-char-unsigned-short-unsigned-int)-)-and-long-(-)(int-const-char-umode_t-
|   |-- fs-namespace.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(char-)-and-long-(-)(char-)-)
|   |-- fs-namespace.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(char-char-char-unsigned-long-void-)-and-long-(-)(char-char-char-unsigned-long-void-)-)
|   |-- fs-namespace.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(char-int)-and-long-(-)(char-int)-)
|   |-- fs-namespace.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-const-char-)-and-long-(-)(const-char-const-char-)-)
|   |-- fs-namespace.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-struct-mnt_id_req-struct-statmount-size_t-unsigned-int)-(aka-long-(-)(const-struct-mnt_id_req-struct-statmount-unsigned-int
|   |-- fs-namespace.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-struct-mnt_id_req-u64-size_t-unsigned-int)-(aka-long-(-)(const-struct-mnt_id_req-unsigned-long-long-unsigned-int-unsigned-i
|   |-- fs-namespace.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-int-const-char-unsigned-int)-and-long-(-)(int-const-char-int-const-char-unsigned-int)-)
|   |-- fs-namespace.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-unsigned-int)-and-long-(-)(int-const-char-unsigned-int)-)
|   |-- fs-namespace.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-unsigned-int-struct-mount_attr-size_t)-(aka-long-(-)(int-const-char-unsigned-int-struct-mount_attr-unsigned-int)-)
|   |-- fs-namespace.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-unsigned-int-unsigned-int)-and-long-(-)(int-unsigned-int-unsigned-int)-)
|   |-- fs-open.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-)-and-long-(-)(const-char-)-)
|   |-- fs-open.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-int)-and-long-(-)(const-char-int)-)
|   |-- fs-open.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-int-umode_t)-(aka-long-(-)(const-char-int-unsigned-short)-)-and-long-(-)(const-char-int-umode_t)-(aka-long-(-)(const-char-i
|   |-- fs-open.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-long)-and-long-(-)(const-char-long)-)
|   |-- fs-open.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-u32-u32)-(aka-long-(-)(const-char-unsigned-int-unsigned-int)-)-and-long-(-)(const-char-u32-u32)-(aka-long-(-)(const-char-un
|   |-- fs-open.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-uid_t-gid_t)-(aka-long-(-)(const-char-unsigned-int-unsigned-int)-)-and-long-(-)(const-char-uid_t-gid_t)-(aka-long-(-)(const
|   |-- fs-open.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-umode_t)-(aka-long-(-)(const-char-unsigned-short)-)-and-long-(-)(const-char-umode_t)-(aka-long-(-)(const-char-unsigned-shor
|   |-- fs-open.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-int)-and-long-(-)(int-const-char-int)-)
|   |-- fs-open.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-int-int)-and-long-(-)(int-const-char-int-int)-)
|   |-- fs-open.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-int-umode_t)-(aka-long-(-)(int-const-char-int-unsigned-short)-)-and-long-(-)(int-const-char-int-umode_t)-(aka-long-(-)(
|   |-- fs-open.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-struct-open_how-size_t)-(aka-long-(-)(int-const-char-struct-open_how-unsigned-int)-)-and-long-(-)(int-const-char-struct
|   |-- fs-open.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-uid_t-gid_t-int)-(aka-long-(-)(int-const-char-unsigned-int-unsigned-int-int)-)-and-long-(-)(int-const-char-uid_t-gid_t-
|   |-- fs-open.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-umode_t)-(aka-long-(-)(int-const-char-unsigned-short)-)-and-long-(-)(int-const-char-umode_t)-(aka-long-(-)(int-const-ch
|   |-- fs-open.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-umode_t-unsigned-int)-(aka-long-(-)(int-const-char-unsigned-short-unsigned-int)-)-and-long-(-)(int-const-char-umode_t-u
|   |-- fs-open.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-int-u32-u32-u32-u32)-(aka-long-(-)(int-int-unsigned-int-unsigned-int-unsigned-int-unsigned-int)-)-and-long-(-)(int-int-u32-u32-u32
|   |-- fs-open.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int)-and-long-(-)(unsigned-int)-)
|   |-- fs-open.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-off_t)-(aka-long-(-)(unsigned-int-long)-)-and-long-(-)(unsigned-int-off_t)-(aka-long-(-)(unsigned-int-long)-))
|   |-- fs-open.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-u32-u32)-(aka-long-(-)(unsigned-int-unsigned-int-unsigned-int)-)-and-long-(-)(unsigned-int-u32-u32)-(aka-long-(-)(unsigne
|   |-- fs-open.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-uid_t-gid_t)-(aka-long-(-)(unsigned-int-unsigned-int-unsigned-int)-)-and-long-(-)(unsigned-int-uid_t-gid_t)-(aka-long-(-)
|   |-- fs-open.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-umode_t)-(aka-long-(-)(unsigned-int-unsigned-short)-)-and-long-(-)(unsigned-int-umode_t)-(aka-long-(-)(unsigned-int-unsig
|   |-- fs-open.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-unsigned-int-unsigned-int)-and-long-(-)(unsigned-int-unsigned-int-unsigned-int)-)
|   |-- fs-pipe.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-)-and-long-(-)(int-)-)
|   |-- fs-pipe.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-int)-and-long-(-)(int-int)-)
|   |-- fs-read_write.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-int-loff_t-size_t)-(aka-long-(-)(int-int-long-long-unsigned-int)-)-and-long-(-)(int-int-loff_t-size_t)-(aka-long-(-)(int-int
|   |-- fs-read_write.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-int-off_t-size_t)-(aka-long-(-)(int-int-long-unsigned-int)-)-and-long-(-)(int-int-off_t-size_t)-(aka-long-(-)(int-int-long-u
|   |-- fs-read_write.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-loff_t-int-loff_t-size_t-unsigned-int)-(aka-long-(-)(int-long-long-int-long-long-unsigned-int-unsigned-int)-)-and-long-(-)(i
|   |-- fs-read_write.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-char-size_t)-(aka-long-(-)(unsigned-int-char-unsigned-int)-)-and-long-(-)(unsigned-int-char-size_t)-(aka-long-(-)(u
|   |-- fs-read_write.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-char-size_t-u32-u32)-(aka-long-(-)(unsigned-int-char-unsigned-int-unsigned-int-unsigned-int)-)-and-long-(-)(unsigne
|   |-- fs-read_write.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-const-char-size_t)-(aka-long-(-)(unsigned-int-const-char-unsigned-int)-)-and-long-(-)(unsigned-int-const-char-size_
|   |-- fs-read_write.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-const-char-size_t-u32-u32)-(aka-long-(-)(unsigned-int-const-char-unsigned-int-unsigned-int-unsigned-int)-)-and-long
|   |-- fs-read_write.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-off_t-unsigned-int)-(aka-long-(-)(unsigned-int-long-unsigned-int)-)-and-long-(-)(unsigned-int-off_t-unsigned-int)-(
|   |-- fs-read_write.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-unsigned-long-unsigned-long-loff_t-unsigned-int)-(aka-long-(-)(unsigned-int-unsigned-long-unsigned-long-long-long-u
|   |-- fs-read_write.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-long-const-struct-iovec-unsigned-long)-and-long-(-)(unsigned-long-const-struct-iovec-unsigned-long)-)
|   |-- fs-read_write.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-long-const-struct-iovec-unsigned-long-u32-u32)-(aka-long-(-)(unsigned-long-const-struct-iovec-unsigned-long-unsigned-in
|   |-- fs-read_write.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-long-const-struct-iovec-unsigned-long-u32-u32-rwf_t)-(aka-long-(-)(unsigned-long-const-struct-iovec-unsigned-long-unsig
|   |-- fs-readdir.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-struct-linux_dirent-unsigned-int)-and-long-(-)(unsigned-int-struct-linux_dirent-unsigned-int)-)
|   |-- fs-readdir.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-struct-linux_dirent64-unsigned-int)-and-long-(-)(unsigned-int-struct-linux_dirent64-unsigned-int)-)
|   |-- fs-readdir.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-struct-old_linux_dirent-unsigned-int)-and-long-(-)(unsigned-int-struct-old_linux_dirent-unsigned-int)-)
|   |-- fs-select.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-fd_set-fd_set-fd_set-struct-__kernel_old_timeval-)-(aka-long-(-)(int-__kernel_fd_set-__kernel_fd_set-__kernel_fd_set-struct-__ke
|   |-- fs-select.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-fd_set-fd_set-fd_set-struct-__kernel_timespec-void-)-(aka-long-(-)(int-__kernel_fd_set-__kernel_fd_set-__kernel_fd_set-struct-__
|   |-- fs-select.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(struct-pollfd-unsigned-int-int)-and-long-(-)(struct-pollfd-unsigned-int-int)-)
|   |-- fs-select.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(struct-pollfd-unsigned-int-struct-__kernel_timespec-const-sigset_t-size_t)-(aka-long-(-)(struct-pollfd-unsigned-int-struct-__kernel_
|   |-- fs-select.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(struct-sel_arg_struct-)-and-long-(-)(struct-sel_arg_struct-)-)
|   |-- fs-signalfd.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-sigset_t-size_t)-(aka-long-(-)(int-sigset_t-unsigned-int)-)-and-long-(-)(int-sigset_t-size_t)-(aka-long-(-)(int-sigset_t-unsig
|   |-- fs-signalfd.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-sigset_t-size_t-int)-(aka-long-(-)(int-sigset_t-unsigned-int-int)-)-and-long-(-)(int-sigset_t-size_t-int)-(aka-long-(-)(int-si
|   |-- fs-splice.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-struct-iovec-unsigned-long-unsigned-int)-and-long-(-)(int-const-struct-iovec-unsigned-long-unsigned-int)-)
|   |-- fs-splice.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-int-size_t-unsigned-int)-(aka-long-(-)(int-int-unsigned-int-unsigned-int)-)-and-long-(-)(int-int-size_t-unsigned-int)-(aka-long-
|   |-- fs-splice.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-loff_t-int-loff_t-size_t-unsigned-int)-(aka-long-(-)(int-long-long-int-long-long-unsigned-int-unsigned-int)-)-and-long-(-)(int-l
|   |-- fs-stat.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-char-int)-and-long-(-)(const-char-char-int)-)
|   |-- fs-stat.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-struct-__old_kernel_stat-)-and-long-(-)(const-char-struct-__old_kernel_stat-)-)
|   |-- fs-stat.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-struct-stat-)-and-long-(-)(const-char-struct-stat-)-)
|   |-- fs-stat.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-struct-stat64-)-and-long-(-)(const-char-struct-stat64-)-)
|   |-- fs-stat.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-char-int)-and-long-(-)(int-const-char-char-int)-)
|   |-- fs-stat.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-struct-stat64-int)-and-long-(-)(int-const-char-struct-stat64-int)-)
|   |-- fs-stat.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-unsigned-int-unsigned-int-struct-statx-)-and-long-(-)(int-const-char-unsigned-int-unsigned-int-struct-statx-)-)
|   |-- fs-stat.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-struct-__old_kernel_stat-)-and-long-(-)(unsigned-int-struct-__old_kernel_stat-)-)
|   |-- fs-stat.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-struct-stat-)-and-long-(-)(unsigned-int-struct-stat-)-)
|   |-- fs-stat.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-long-struct-stat64-)-and-long-(-)(unsigned-long-struct-stat64-)-)
|   |-- fs-statfs.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-size_t-struct-statfs64-)-(aka-long-(-)(const-char-unsigned-int-struct-statfs64-)-)-and-long-(-)(const-char-size_t-struct-
|   |-- fs-statfs.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-struct-statfs-)-and-long-(-)(const-char-struct-statfs-)-)
|   |-- fs-statfs.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-size_t-struct-statfs64-)-(aka-long-(-)(unsigned-int-unsigned-int-struct-statfs64-)-)-and-long-(-)(unsigned-int-size_t-s
|   |-- fs-statfs.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-struct-statfs-)-and-long-(-)(unsigned-int-struct-statfs-)-)
|   |-- fs-statfs.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-struct-ustat-)-and-long-(-)(unsigned-int-struct-ustat-)-)
|   |-- fs-sync.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int)-and-long-(-)(int)-)
|   |-- fs-sync.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-u32-u32-u32-u32-unsigned-int)-(aka-long-(-)(int-unsigned-int-unsigned-int-unsigned-int-unsigned-int-unsigned-int)-)-and-long-(-)(i
|   |-- fs-sync.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int)-and-long-(-)(unsigned-int)-)
|   |-- fs-timerfd.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-int)-and-long-(-)(int-int)-)
|   |-- fs-timerfd.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-int-const-struct-__kernel_itimerspec-struct-__kernel_itimerspec-)-and-long-(-)(int-int-const-struct-__kernel_itimerspec-struct-
|   |-- fs-timerfd.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-struct-__kernel_itimerspec-)-and-long-(-)(int-struct-__kernel_itimerspec-)-)
|   |-- fs-utimes.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-struct-__kernel_timespec-int)-and-long-(-)(int-const-char-struct-__kernel_timespec-int)-)
|   |-- fs-xattr.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-char-size_t)-(aka-long-(-)(const-char-char-unsigned-int)-)-and-long-(-)(const-char-char-size_t)-(aka-long-(-)(const-char-c
|   |-- fs-xattr.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-const-char-)-and-long-(-)(const-char-const-char-)-)
|   |-- fs-xattr.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-const-char-const-void-size_t-int)-(aka-long-(-)(const-char-const-char-const-void-unsigned-int-int)-)-and-long-(-)(const-ch
|   |-- fs-xattr.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-const-char-void-size_t)-(aka-long-(-)(const-char-const-char-void-unsigned-int)-)-and-long-(-)(const-char-const-char-void-s
|   |-- fs-xattr.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-char-size_t)-(aka-long-(-)(int-char-unsigned-int)-)-and-long-(-)(int-char-size_t)-(aka-long-(-)(int-char-unsigned-int)-))
|   |-- fs-xattr.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-)-and-long-(-)(int-const-char-)-)
|   |-- fs-xattr.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-const-void-size_t-int)-(aka-long-(-)(int-const-char-const-void-unsigned-int-int)-)-and-long-(-)(int-const-char-const-v
|   |-- fs-xattr.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-char-void-size_t)-(aka-long-(-)(int-const-char-void-unsigned-int)-)-and-long-(-)(int-const-char-void-size_t)-(aka-long-(-)(
|   |-- io_uring-io_uring.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(u32-struct-io_uring_params-)-(aka-long-(-)(unsigned-int-struct-io_uring_params-)-)-and-long-(-)(u32-struct-io_uring_params-)
|   |-- io_uring-io_uring.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-u32-u32-u32-const-void-size_t)-(aka-long-(-)(unsigned-int-unsigned-int-unsigned-int-unsigned-int-const-void-uns
|   |-- io_uring-register.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-unsigned-int-void-unsigned-int)-and-long-(-)(unsigned-int-unsigned-int-void-unsigned-int)-)
|   |-- kernel-capability.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(cap_user_header_t-cap_user_data_t)-(aka-long-(-)(struct-__user_cap_header_struct-struct-__user_cap_data_struct-)-)-and-long-
|   |-- kernel-capability.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(cap_user_header_t-const-cap_user_data_t)-(aka-long-(-)(struct-__user_cap_header_struct-struct-__user_cap_data_struct-const)-
|   |-- kernel-exec_domain.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int)-and-long-(-)(unsigned-int)-)
|   |-- kernel-exit.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int)-and-long-(-)(int)-)
|   |-- kernel-exit.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-pid_t-struct-siginfo-int-struct-rusage-)-(aka-long-(-)(int-int-struct-siginfo-int-struct-rusage-)-)-and-long-(-)(int-pid_t-str
|   |-- kernel-exit.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(pid_t-int-int)-(aka-long-(-)(int-int-int)-)-and-long-(-)(pid_t-int-int)-(aka-long-(-)(int-int-int)-))
|   |-- kernel-exit.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(pid_t-int-int-struct-rusage-)-(aka-long-(-)(int-int-int-struct-rusage-)-)-and-long-(-)(pid_t-int-int-struct-rusage-)-(aka-long-(-)
|   |-- kernel-fork.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-)-and-long-(-)(int-)-)
|   |-- kernel-fork.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(struct-clone_args-size_t)-(aka-long-(-)(struct-clone_args-unsigned-int)-)-and-long-(-)(struct-clone_args-size_t)-(aka-long-(-)(str
|   |-- kernel-fork.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-long)-and-long-(-)(unsigned-long)-)
|   |-- kernel-fork.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-long-unsigned-long-int-unsigned-long-int-)-and-long-(-)(unsigned-long-unsigned-long-int-unsigned-long-int-)-)
|   |-- kernel-futex-syscalls.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-struct-robust_list_head-size_t-)-(aka-long-(-)(int-struct-robust_list_head-unsigned-int-)-)-and-long-(-)(int-struct-
|   |-- kernel-futex-syscalls.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(struct-futex_waitv-unsigned-int-int-int)-and-long-(-)(struct-futex_waitv-unsigned-int-int-int)-)
|   |-- kernel-futex-syscalls.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(struct-futex_waitv-unsigned-int-unsigned-int-struct-__kernel_timespec-clockid_t)-(aka-long-(-)(struct-futex_waitv-unsign
|   |-- kernel-futex-syscalls.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(struct-robust_list_head-size_t)-(aka-long-(-)(struct-robust_list_head-unsigned-int)-)-and-long-(-)(struct-robust_list_he
|   |-- kernel-futex-syscalls.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(u32-int-u32-const-struct-__kernel_timespec-u32-u32)-(aka-long-(-)(unsigned-int-int-unsigned-int-const-struct-__kernel_ti
|   |-- kernel-futex-syscalls.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(void-unsigned-long-int-unsigned-int)-and-long-(-)(void-unsigned-long-int-unsigned-int)-)
|   |-- kernel-futex-syscalls.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(void-unsigned-long-unsigned-long-unsigned-int-struct-__kernel_timespec-clockid_t)-(aka-long-(-)(void-unsigned-long-unsig
|   |-- kernel-groups.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-gid_t-)-(aka-long-(-)(int-unsigned-int-)-)-and-long-(-)(int-gid_t-)-(aka-long-(-)(int-unsigned-int-)-))
|   |-- kernel-nsproxy.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-int)-and-long-(-)(int-int)-)
|   |-- kernel-pid.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-int-unsigned-int)-and-long-(-)(int-int-unsigned-int)-)
|   |-- kernel-pid.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(pid_t-unsigned-int)-(aka-long-(-)(int-unsigned-int)-)-and-long-(-)(pid_t-unsigned-int)-(aka-long-(-)(int-unsigned-int)-))
|   |-- kernel-printk-printk.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-char-int)-and-long-(-)(int-char-int)-)
|   |-- kernel-ptrace.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(long-long-unsigned-long-unsigned-long)-and-long-(-)(long-long-unsigned-long-unsigned-long)-)
|   |-- kernel-reboot.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-int-unsigned-int-void-)-and-long-(-)(int-int-unsigned-int-void-)-)
|   |-- kernel-sched-core.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int)-and-long-(-)(int)-)
|   |-- kernel-sched-core.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(pid_t)-(aka-long-(-)(int)-)-and-long-(-)(pid_t)-(aka-long-(-)(int)-))
|   |-- kernel-sched-core.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(pid_t-int-struct-sched_param-)-(aka-long-(-)(int-int-struct-sched_param-)-)-and-long-(-)(pid_t-int-struct-sched_param-)-(aka
|   |-- kernel-sched-core.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(pid_t-struct-__kernel_timespec-)-(aka-long-(-)(int-struct-__kernel_timespec-)-)-and-long-(-)(pid_t-struct-__kernel_timespec-
|   |-- kernel-sched-core.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(pid_t-struct-sched_attr-unsigned-int)-(aka-long-(-)(int-struct-sched_attr-unsigned-int)-)-and-long-(-)(pid_t-struct-sched_at
|   |-- kernel-sched-core.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(pid_t-struct-sched_attr-unsigned-int-unsigned-int)-(aka-long-(-)(int-struct-sched_attr-unsigned-int-unsigned-int)-)-and-long
|   |-- kernel-sched-core.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(pid_t-struct-sched_param-)-(aka-long-(-)(int-struct-sched_param-)-)-and-long-(-)(pid_t-struct-sched_param-)-(aka-long-(-)(in
|   |-- kernel-sched-core.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(pid_t-unsigned-int-unsigned-long-)-(aka-long-(-)(int-unsigned-int-unsigned-long-)-)-and-long-(-)(pid_t-unsigned-int-unsigned
|   |-- kernel-sched-membarrier.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-unsigned-int-int)-and-long-(-)(int-unsigned-int-int)-)
|   |-- kernel-signal.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-sigset_t-siginfo_t-const-struct-__kernel_timespec-size_t)-(aka-long-(-)(const-sigset_t-struct-siginfo-const-struct-__kerne
|   |-- kernel-signal.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-stack_t-stack_t-)-(aka-long-(-)(const-struct-sigaltstack-struct-sigaltstack-)-)-and-long-(-)(const-struct-sigaltstack-stru
|   |-- kernel-signal.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-__sighandler_t)-(aka-long-(-)(int-void-(-)(int))-)-and-long-(-)(int-__sighandler_t)-(aka-long-(-)(int-void-(-)(int))-))
|   |-- kernel-signal.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-struct-old_sigaction-struct-old_sigaction-)-and-long-(-)(int-const-struct-old_sigaction-struct-old_sigaction-)-)
|   |-- kernel-signal.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-struct-sigaction-struct-sigaction-size_t)-(aka-long-(-)(int-const-struct-sigaction-struct-sigaction-unsigned-int)-)-an
|   |-- kernel-signal.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-int-old_sigset_t)-(aka-long-(-)(int-int-unsigned-long)-)-and-long-(-)(int-int-old_sigset_t)-(aka-long-(-)(int-int-unsigned-l
|   |-- kernel-signal.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-int-siginfo_t-unsigned-int)-(aka-long-(-)(int-int-struct-siginfo-unsigned-int)-)-and-long-(-)(int-int-siginfo_t-unsigned-int
|   |-- kernel-signal.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-old_sigset_t-old_sigset_t-)-(aka-long-(-)(int-unsigned-long-unsigned-long-)-)-and-long-(-)(int-old_sigset_t-old_sigset_t-)-(
|   |-- kernel-signal.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-sigset_t-sigset_t-size_t)-(aka-long-(-)(int-sigset_t-sigset_t-unsigned-int)-)-and-long-(-)(int-sigset_t-sigset_t-size_t)-(ak
|   |-- kernel-signal.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(old_sigset_t-)-(aka-long-(-)(unsigned-long-)-)-and-long-(-)(old_sigset_t-)-(aka-long-(-)(unsigned-long-)-))
|   |-- kernel-signal.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(pid_t-int)-(aka-long-(-)(int-int)-)-and-long-(-)(pid_t-int)-(aka-long-(-)(int-int)-))
|   |-- kernel-signal.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(pid_t-int-siginfo_t-)-(aka-long-(-)(int-int-struct-siginfo-)-)-and-long-(-)(pid_t-int-siginfo_t-)-(aka-long-(-)(int-int-struct-s
|   |-- kernel-signal.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(pid_t-pid_t-int)-(aka-long-(-)(int-int-int)-)-and-long-(-)(pid_t-pid_t-int)-(aka-long-(-)(int-int-int)-))
|   |-- kernel-signal.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(pid_t-pid_t-int-siginfo_t-)-(aka-long-(-)(int-int-int-struct-siginfo-)-)-and-long-(-)(pid_t-pid_t-int-siginfo_t-)-(aka-long-(-)(
|   |-- kernel-signal.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(sigset_t-size_t)-(aka-long-(-)(sigset_t-unsigned-int)-)-and-long-(-)(sigset_t-size_t)-(aka-long-(-)(sigset_t-unsigned-int)-))
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(char-int)-and-long-(-)(char-int)-)
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(gid_t)-(aka-long-(-)(unsigned-int)-)-and-long-(-)(gid_t)-(aka-long-(-)(unsigned-int)-))
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(gid_t-gid_t)-(aka-long-(-)(unsigned-int-unsigned-int)-)-and-long-(-)(gid_t-gid_t)-(aka-long-(-)(unsigned-int-unsigned-int)-))
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(gid_t-gid_t-gid_t)-(aka-long-(-)(unsigned-int-unsigned-int-unsigned-int)-)-and-long-(-)(gid_t-gid_t-gid_t)-(aka-long-(-)(unsigned-i
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(gid_t-gid_t-gid_t-)-(aka-long-(-)(unsigned-int-unsigned-int-unsigned-int-)-)-and-long-(-)(gid_t-gid_t-gid_t-)-(aka-long-(-)(unsigne
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int)-and-long-(-)(int)-)
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-int)-and-long-(-)(int-int)-)
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-int-int)-and-long-(-)(int-int-int)-)
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-struct-rusage-)-and-long-(-)(int-struct-rusage-)-)
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-unsigned-long-unsigned-long-unsigned-long-unsigned-long)-and-long-(-)(int-unsigned-long-unsigned-long-unsigned-long-unsigned-lo
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(pid_t)-(aka-long-(-)(int)-)-and-long-(-)(pid_t)-(aka-long-(-)(int)-))
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(pid_t-pid_t)-(aka-long-(-)(int-int)-)-and-long-(-)(pid_t-pid_t)-(aka-long-(-)(int-int)-))
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(pid_t-unsigned-int-const-struct-rlimit64-struct-rlimit64-)-(aka-long-(-)(int-unsigned-int-const-struct-rlimit64-struct-rlimit64-)-)
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(struct-new_utsname-)-and-long-(-)(struct-new_utsname-)-)
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(struct-old_utsname-)-and-long-(-)(struct-old_utsname-)-)
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(struct-oldold_utsname-)-and-long-(-)(struct-oldold_utsname-)-)
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(struct-sysinfo-)-and-long-(-)(struct-sysinfo-)-)
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(struct-tms-)-and-long-(-)(struct-tms-)-)
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(uid_t)-(aka-long-(-)(unsigned-int)-)-and-long-(-)(uid_t)-(aka-long-(-)(unsigned-int)-))
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(uid_t-uid_t)-(aka-long-(-)(unsigned-int-unsigned-int)-)-and-long-(-)(uid_t-uid_t)-(aka-long-(-)(unsigned-int-unsigned-int)-))
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(uid_t-uid_t-uid_t)-(aka-long-(-)(unsigned-int-unsigned-int-unsigned-int)-)-and-long-(-)(uid_t-uid_t-uid_t)-(aka-long-(-)(unsigned-i
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(uid_t-uid_t-uid_t-)-(aka-long-(-)(unsigned-int-unsigned-int-unsigned-int-)-)-and-long-(-)(uid_t-uid_t-uid_t-)-(aka-long-(-)(unsigne
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-struct-rlimit-)-and-long-(-)(unsigned-int-struct-rlimit-)-)
|   |-- kernel-sys.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-unsigned-int-struct-getcpu_cache-)-and-long-(-)(unsigned-int-unsigned-int-struct-getcpu_cache-)-)
|   |-- kernel-time-itimer.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-struct-__kernel_old_itimerval-)-and-long-(-)(int-struct-__kernel_old_itimerval-)-)
|   |-- kernel-time-itimer.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-struct-__kernel_old_itimerval-struct-__kernel_old_itimerval-)-and-long-(-)(int-struct-__kernel_old_itimerval-struct-__k
|   |-- kernel-time-itimer.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int)-and-long-(-)(unsigned-int)-)
|   |-- kernel-time-posix-timers.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-clockid_t-const-struct-__kernel_timespec-)-(aka-long-(-)(const-int-const-struct-__kernel_timespec-)-)-and-long-
|   |-- kernel-time-posix-timers.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-clockid_t-int-const-struct-__kernel_timespec-struct-__kernel_timespec-)-(aka-long-(-)(const-int-int-const-struc
|   |-- kernel-time-posix-timers.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-clockid_t-struct-__kernel_timespec-)-(aka-long-(-)(const-int-struct-__kernel_timespec-)-)-and-long-(-)(clockid_
|   |-- kernel-time-posix-timers.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-clockid_t-struct-__kernel_timex-)-(aka-long-(-)(const-int-struct-__kernel_timex-)-)-and-long-(-)(clockid_t-stru
|   |-- kernel-time-posix-timers.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-clockid_t-struct-sigevent-timer_t-)-(aka-long-(-)(const-int-struct-sigevent-int-)-)-and-long-(-)(clockid_t-stru
|   |-- kernel-time-posix-timers.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(timer_t)-(aka-long-(-)(int)-)-and-long-(-)(timer_t)-(aka-long-(-)(int)-))
|   |-- kernel-time-posix-timers.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(timer_t-int-const-struct-__kernel_itimerspec-struct-__kernel_itimerspec-)-(aka-long-(-)(int-int-const-struct-__kernel
|   |-- kernel-time-posix-timers.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(timer_t-struct-__kernel_itimerspec-)-(aka-long-(-)(int-struct-__kernel_itimerspec-)-)-and-long-(-)(timer_t-struct-__k
|   |-- kernel-time-time.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(struct-__kernel_old_timeval-struct-timezone-)-and-long-(-)(struct-__kernel_old_timeval-struct-timezone-)-)
|   |-- kernel-uid16.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(const-char-old_uid_t-old_gid_t)-(aka-long-(-)(const-char-unsigned-short-unsigned-short)-)-and-long-(-)(const-char-old_uid_t-old_g
|   |-- kernel-uid16.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-old_gid_t-)-(aka-long-(-)(int-unsigned-short-)-)-and-long-(-)(int-old_gid_t-)-(aka-long-(-)(int-unsigned-short-)-))
|   |-- kernel-uid16.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(old_gid_t)-(aka-long-(-)(unsigned-short)-)-and-long-(-)(old_gid_t)-(aka-long-(-)(unsigned-short)-))
|   |-- kernel-uid16.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(old_gid_t-old_gid_t)-(aka-long-(-)(unsigned-short-unsigned-short)-)-and-long-(-)(old_gid_t-old_gid_t)-(aka-long-(-)(unsigned-shor
|   |-- kernel-uid16.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(old_gid_t-old_gid_t-old_gid_t)-(aka-long-(-)(unsigned-short-unsigned-short-unsigned-short)-)-and-long-(-)(old_gid_t-old_gid_t-old
|   |-- kernel-uid16.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(old_gid_t-old_gid_t-old_gid_t-)-(aka-long-(-)(unsigned-short-unsigned-short-unsigned-short-)-)-and-long-(-)(old_gid_t-old_gid_t-o
|   |-- kernel-uid16.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(old_uid_t)-(aka-long-(-)(unsigned-short)-)-and-long-(-)(old_uid_t)-(aka-long-(-)(unsigned-short)-))
|   |-- kernel-uid16.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(old_uid_t-old_uid_t)-(aka-long-(-)(unsigned-short-unsigned-short)-)-and-long-(-)(old_uid_t-old_uid_t)-(aka-long-(-)(unsigned-shor
|   |-- kernel-uid16.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(old_uid_t-old_uid_t-old_uid_t)-(aka-long-(-)(unsigned-short-unsigned-short-unsigned-short)-)-and-long-(-)(old_uid_t-old_uid_t-old
|   |-- kernel-uid16.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(old_uid_t-old_uid_t-old_uid_t-)-(aka-long-(-)(unsigned-short-unsigned-short-unsigned-short-)-)-and-long-(-)(old_uid_t-old_uid_t-o
|   |-- kernel-uid16.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-old_uid_t-old_gid_t)-(aka-long-(-)(unsigned-int-unsigned-short-unsigned-short)-)-and-long-(-)(unsigned-int-old_uid_t
|   |-- mm-fadvise.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-u32-u32-size_t-int)-(aka-long-(-)(int-unsigned-int-unsigned-int-unsigned-int-int)-)-and-long-(-)(int-u32-u32-size_t-int)-(aka-l
|   |-- mm-fadvise.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-u32-u32-u32-u32-int)-(aka-long-(-)(int-unsigned-int-unsigned-int-unsigned-int-unsigned-int-int)-)-and-long-(-)(int-u32-u32-u32-
|   |-- mm-filemap.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-int-struct-cachestat_range-struct-cachestat-unsigned-int)-and-long-(-)(unsigned-int-struct-cachestat_range-struct-cachesta
|   |-- mm-madvise.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-const-struct-iovec-size_t-int-unsigned-int)-(aka-long-(-)(int-const-struct-iovec-unsigned-int-int-unsigned-int)-)-and-long-(-)(
|   |-- mm-madvise.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-long-size_t-int)-(aka-long-(-)(unsigned-long-unsigned-int-int)-)-and-long-(-)(unsigned-long-size_t-int)-(aka-long-(-)(unsi
|   |-- mm-mincore.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-long-size_t-unsigned-char-)-(aka-long-(-)(unsigned-long-unsigned-int-unsigned-char-)-)-and-long-(-)(unsigned-long-size_t-u
|   |-- mm-mlock.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int)-and-long-(-)(int)-)
|   |-- mm-mlock.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-long-size_t)-(aka-long-(-)(unsigned-long-unsigned-int)-)-and-long-(-)(unsigned-long-size_t)-(aka-long-(-)(unsigned-long-unsi
|   |-- mm-mlock.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-long-size_t-int)-(aka-long-(-)(unsigned-long-unsigned-int-int)-)-and-long-(-)(unsigned-long-size_t-int)-(aka-long-(-)(unsign
|   |-- mm-mmap.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(struct-mmap_arg_struct-)-and-long-(-)(struct-mmap_arg_struct-)-)
|   |-- mm-mmap.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-long)-and-long-(-)(unsigned-long)-)
|   |-- mm-mmap.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-long-size_t)-(aka-long-(-)(unsigned-long-unsigned-int)-)-and-long-(-)(unsigned-long-size_t)-(aka-long-(-)(unsigned-long-unsig
|   |-- mm-mmap.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-long-unsigned-long-unsigned-long-unsigned-long-unsigned-long)-and-long-(-)(unsigned-long-unsigned-long-unsigned-long-unsigned
|   |-- mm-mmap.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-long-unsigned-long-unsigned-long-unsigned-long-unsigned-long-unsigned-long)-and-long-(-)(unsigned-long-unsigned-long-unsigned
|   |-- mm-mprotect.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-long-size_t-unsigned-long)-(aka-long-(-)(unsigned-long-unsigned-int-unsigned-long)-)-and-long-(-)(unsigned-long-size_t-un
|   |-- mm-mremap.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-long-unsigned-long-unsigned-long-unsigned-long-unsigned-long)-and-long-(-)(unsigned-long-unsigned-long-unsigned-long-unsign
|   |-- mm-msync.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(unsigned-long-size_t-int)-(aka-long-(-)(unsigned-long-unsigned-int-int)-)-and-long-(-)(unsigned-long-size_t-int)-(aka-long-(-)(unsign
|   |-- mm-oom_kill.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-unsigned-int)-and-long-(-)(int-unsigned-int)-)
|   `-- mm-readahead.c:warning:comparison-of-distinct-pointer-types-(-long-(-)(int-u32-u32-size_t)-(aka-long-(-)(int-unsigned-int-unsigned-int-unsigned-int)-)-and-long-(-)(int-u32-u32-size_t)-(aka-long-(-)(in
|-- um-i386_defconfig
|   `-- arch-x86-um-sys_call_table_32.c:fatal-error:asm-syscalls_32.h:No-such-file-or-directory
|-- x86_64-allnoconfig
|   |-- arch-arm-kernel-entry-common.S:asm-syscall_table_oabi.h-is-included-more-than-once.
|   `-- arch-x86-include-asm-syscalls.h:warning:declaration-of-struct-stat64-will-not-be-visible-outside-of-this-function
|-- x86_64-buildonly-randconfig-001-20240718
|   `-- arch-x86-include-asm-syscalls.h:warning:struct-stat64-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- x86_64-buildonly-randconfig-003-20240718
|   `-- arch-x86-include-asm-syscalls.h:warning:declaration-of-struct-stat64-will-not-be-visible-outside-of-this-function
|-- x86_64-buildonly-randconfig-004-20240718
|   `-- ld.lld:error:undefined-symbol:__x64_sys_fadvise64
|-- x86_64-buildonly-randconfig-006-20240718
|   `-- arch-x86-include-asm-syscalls.h:warning:declaration-of-struct-stat64-will-not-be-visible-outside-of-this-function
|-- x86_64-randconfig-005-20240718
|   `-- ld.lld:error:undefined-symbol:__ia32_sys_fadvise64_64_6
|-- x86_64-randconfig-012-20240718
|   |-- arch-x86-include-generated-asm-syscall_table_32.h:(.text):undefined-reference-to-__ia32_sys_fadvise64_64_6
|   |-- arch-x86-include-generated-asm-syscall_table_64.h:(.text):undefined-reference-to-__x64_sys_fadvise64
|   `-- ld:arch-x86-entry-syscall_64.o:(.rodata):undefined-reference-to-__x64_sys_fadvise64
|-- x86_64-randconfig-014-20240718
|   `-- ld.lld:error:undefined-symbol:__ia32_sys_fadvise64_64_6
|-- x86_64-randconfig-075-20240718
|   `-- ld.lld:error:undefined-symbol:__ia32_sys_fadvise64_64_6
`-- x86_64-randconfig-076-20240718
    `-- ld.lld:error:undefined-symbol:__ia32_sys_fadvise64_64_6

elapsed time: 1104m

configs tested: 159
configs skipped: 3

tested configs:
alpha                            alldefconfig   gcc-13.3.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240718   gcc-13.2.0
arc                   randconfig-002-20240718   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-14.1.0
arm                            hisi_defconfig   gcc-14.1.0
arm                   randconfig-001-20240718   clang-19
arm                   randconfig-002-20240718   gcc-14.1.0
arm                   randconfig-003-20240718   clang-19
arm                   randconfig-004-20240718   gcc-14.1.0
arm                           spitz_defconfig   gcc-14.1.0
arm                       versatile_defconfig   gcc-14.1.0
arm                         vf610m4_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240718   clang-15
arm64                 randconfig-002-20240718   clang-19
arm64                 randconfig-003-20240718   gcc-14.1.0
arm64                 randconfig-004-20240718   clang-19
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240718   gcc-14.1.0
csky                  randconfig-002-20240718   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240718   clang-19
hexagon               randconfig-002-20240718   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240718   gcc-11
i386         buildonly-randconfig-002-20240718   gcc-7
i386         buildonly-randconfig-003-20240718   gcc-13
i386         buildonly-randconfig-004-20240718   clang-18
i386         buildonly-randconfig-005-20240718   gcc-9
i386         buildonly-randconfig-006-20240718   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240718   gcc-13
i386                  randconfig-002-20240718   gcc-13
i386                  randconfig-003-20240718   clang-18
i386                  randconfig-004-20240718   clang-18
i386                  randconfig-005-20240718   clang-18
i386                  randconfig-006-20240718   clang-18
i386                  randconfig-011-20240718   gcc-13
i386                  randconfig-012-20240718   gcc-13
i386                  randconfig-013-20240718   gcc-10
i386                  randconfig-014-20240718   clang-18
i386                  randconfig-015-20240718   clang-18
i386                  randconfig-016-20240718   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240718   gcc-14.1.0
loongarch             randconfig-002-20240718   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         amcore_defconfig   gcc-14.1.0
m68k                           virt_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                         cobalt_defconfig   gcc-13.2.0
mips                           ip27_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240718   gcc-14.1.0
nios2                 randconfig-002-20240718   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240718   gcc-14.1.0
parisc                randconfig-002-20240718   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                 canyonlands_defconfig   clang-19
powerpc                   microwatt_defconfig   gcc-13.2.0
powerpc                 mpc834x_itx_defconfig   clang-19
powerpc                      ppc6xx_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240718   clang-17
powerpc               randconfig-002-20240718   clang-19
powerpc               randconfig-003-20240718   gcc-14.1.0
powerpc                     tqm8548_defconfig   clang-19
powerpc64             randconfig-001-20240718   clang-19
powerpc64             randconfig-002-20240718   gcc-14.1.0
powerpc64             randconfig-003-20240718   clang-19
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240718   clang-17
riscv                 randconfig-002-20240718   clang-19
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240718   clang-19
s390                  randconfig-002-20240718   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                         apsh4a3a_defconfig   gcc-14.1.0
sh                        apsh4ad0a_defconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240718   gcc-14.1.0
sh                    randconfig-002-20240718   gcc-14.1.0
sh                        sh7763rdp_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240718   gcc-14.1.0
sparc64               randconfig-002-20240718   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240718   clang-19
um                    randconfig-002-20240718   clang-15
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240718   gcc-11
x86_64       buildonly-randconfig-002-20240718   clang-18
x86_64       buildonly-randconfig-003-20240718   clang-18
x86_64       buildonly-randconfig-004-20240718   clang-18
x86_64       buildonly-randconfig-005-20240718   clang-18
x86_64       buildonly-randconfig-006-20240718   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240718   gcc-13
x86_64                randconfig-002-20240718   gcc-13
x86_64                randconfig-003-20240718   clang-18
x86_64                randconfig-004-20240718   gcc-13
x86_64                randconfig-005-20240718   clang-18
x86_64                randconfig-006-20240718   clang-18
x86_64                randconfig-011-20240718   clang-18
x86_64                randconfig-012-20240718   gcc-9
x86_64                randconfig-013-20240718   clang-18
x86_64                randconfig-014-20240718   clang-18
x86_64                randconfig-015-20240718   clang-18
x86_64                randconfig-016-20240718   clang-18
x86_64                randconfig-071-20240718   clang-18
x86_64                randconfig-072-20240718   clang-18
x86_64                randconfig-073-20240718   clang-18
x86_64                randconfig-074-20240718   gcc-9
x86_64                randconfig-075-20240718   clang-18
x86_64                randconfig-076-20240718   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240718   gcc-14.1.0
xtensa                randconfig-002-20240718   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

