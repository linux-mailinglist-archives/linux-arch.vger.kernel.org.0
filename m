Return-Path: <linux-arch+bounces-5256-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A66F49278C2
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 16:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA87D1F24D59
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 14:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29311B1409;
	Thu,  4 Jul 2024 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qffokmIN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84F71B11E2;
	Thu,  4 Jul 2024 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103868; cv=none; b=Cbff02Bz0N63VAcC5sEUXvPk0JjERHlHu2ztkGQs3rbag86QKd+hH9SdGAJwGxPrY/7jhfbBX4lThU2FW/ZPWp8nNzzDg6df/OhqBemvJ5jMT9DDbWijT/K+I5oP6oubCXUVOxOneKMOtOGkelk5AZWRy3X5WLxGECL+Oq1Gz+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103868; c=relaxed/simple;
	bh=LzCB9rHr6mWYtZYhVa7GQUq5hqE5OAsOabdRGGdazf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oTf/F7jpXSGRP+ic+6gpdTMHtVkg3ahFufTaXHqAJ9Ko89mMRQ9NoHLppyu7IriaSLa2GkuztjWw8cZFikUMgVBQ14TYfcXia/CgU9wOftYb9uPabr/qgh734Rs+dRAx/XnprqZEfkqGmjcUizR+0/y64DZHhW9UHC065GDtwXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qffokmIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F784C4AF0B;
	Thu,  4 Jul 2024 14:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720103868;
	bh=LzCB9rHr6mWYtZYhVa7GQUq5hqE5OAsOabdRGGdazf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qffokmINUGG9tI5Mz72b5wcVRdCGL7ZqqiWPFzCIncfjnLWfCU6xaZO505WnyOQ7S
	 64Ap/z495DGBNy60wrVedaJGQnA6QKfxAS2+VlijoJmI25YQRB0HxPu6NnO5hRjCrQ
	 /Pft00cvhWTHdM2Ip27CsbO6klAr0KG9Icb6Xj71t9RX8axtDquvkwiQKnmLrl3dKI
	 yTHnkGpCvQU3IJ22CrYdi0HCcQGXSrTkrwpAULzVn5+Dr7awZmCtt5YGkyL8LV2nAd
	 q+IRzGdagF54xBJ33tcBaLXwsMQWETI/QEC7tSxczscv/LeddQahAbn5EUpjp14XDd
	 dCd1JTVYQeDuw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@quicinc.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Christian Brauner <brauner@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-openrisc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 09/17] arm64: convert unistd_32.h to syscall.tbl format
Date: Thu,  4 Jul 2024 16:36:03 +0200
Message-Id: <20240704143611.2979589-10-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240704143611.2979589-1-arnd@kernel.org>
References: <20240704143611.2979589-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This is a straight conversion from the old asm/unistd32.h into the
format used by 32-bit arm and most other architectures, calling scripts
to generate the asm/unistd32.h header and a new asm/syscalls32.h headers.

I used a semi-automated text replacement method to do the conversion,
and then used 'vimdiff' to synchronize the whitespace and the (unused)
names of the non-compat syscalls with the arm version.

There are two differences between the generated syscalls names and the
old version:

 - the old asm/unistd32.h contained only a __NR_sync_file_range2
   entry, while the arm32 version also defines
   __NR_arm_sync_file_range with the same number. I added this
   duplicate back in asm/unistd32.h.

 - __NR__sysctl was removed from the arm64 file a while ago, but
   all the tables still contain it. This should probably get removed
   everywhere but I added it here for consistency.

On top of that, the arm64 version does not contain any references to
the 32-bit OABI syscalls that are not supported by arm64. If we ever
want to share the file between arm32 and arm64, it would not be
hard to add support for both in one file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/Kbuild       |   7 +
 arch/arm64/include/asm/seccomp.h    |   2 +-
 arch/arm64/include/asm/unistd.h     |   2 -
 arch/arm64/include/asm/unistd32.h   | 939 +---------------------------
 arch/arm64/kernel/Makefile.syscalls |   5 +
 arch/arm64/kernel/sys32.c           |  17 +-
 arch/arm64/kernel/syscall.c         |   3 +-
 arch/arm64/tools/syscall_32.tbl     | 476 ++++++++++++++
 8 files changed, 503 insertions(+), 948 deletions(-)
 create mode 100644 arch/arm64/kernel/Makefile.syscalls
 create mode 100644 arch/arm64/tools/syscall_32.tbl

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 4b6d2d52053e..3fc45ef32e85 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -1,4 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
+syscall-y += syscall_table_32.h
+
+# arm32 syscall table used by lib/compat_audit.c:
+syscall-y += unistd_32.h
+# same constants with prefixes, used by vdso, seccomp and sigreturn:
+syscall-y += unistd_compat_32.h
+
 generic-y += early_ioremap.h
 generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
diff --git a/arch/arm64/include/asm/seccomp.h b/arch/arm64/include/asm/seccomp.h
index 30256233788b..d56164d3cac5 100644
--- a/arch/arm64/include/asm/seccomp.h
+++ b/arch/arm64/include/asm/seccomp.h
@@ -24,7 +24,7 @@
 #define SECCOMP_ARCH_NATIVE_NAME	"aarch64"
 #ifdef CONFIG_COMPAT
 # define SECCOMP_ARCH_COMPAT		AUDIT_ARCH_ARM
-# define SECCOMP_ARCH_COMPAT_NR	__NR_compat_syscalls
+# define SECCOMP_ARCH_COMPAT_NR		__NR_compat32_syscalls
 # define SECCOMP_ARCH_COMPAT_NAME	"arm"
 #endif
 
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 1346579f802f..55ac26355be4 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,8 +38,6 @@
 #define __ARM_NR_compat_cacheflush	(__ARM_NR_COMPAT_BASE + 2)
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
-
-#define __NR_compat_syscalls		463
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 1386e8e751f2..e0b1a0b57f75 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -1,938 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * AArch32 (compat) system call definitions.
- *
- * Copyright (C) 2001-2005 Russell King
- * Copyright (C) 2012 ARM Ltd.
- */
+#ifndef _UAPI__ASM_ARM_UNISTD_H
+#define _UAPI__ASM_ARM_UNISTD_H
 
-#ifndef __SYSCALL
-#define __SYSCALL(x, y)
-#endif
+#include <asm/unistd_32.h>
 
-#define __NR_restart_syscall 0
-__SYSCALL(__NR_restart_syscall, sys_restart_syscall)
-#define __NR_exit 1
-__SYSCALL(__NR_exit, sys_exit)
-#define __NR_fork 2
-__SYSCALL(__NR_fork, sys_fork)
-#define __NR_read 3
-__SYSCALL(__NR_read, sys_read)
-#define __NR_write 4
-__SYSCALL(__NR_write, sys_write)
-#define __NR_open 5
-__SYSCALL(__NR_open, compat_sys_open)
-#define __NR_close 6
-__SYSCALL(__NR_close, sys_close)
-			/* 7 was sys_waitpid */
-__SYSCALL(7, sys_ni_syscall)
-#define __NR_creat 8
-__SYSCALL(__NR_creat, sys_creat)
-#define __NR_link 9
-__SYSCALL(__NR_link, sys_link)
-#define __NR_unlink 10
-__SYSCALL(__NR_unlink, sys_unlink)
-#define __NR_execve 11
-__SYSCALL(__NR_execve, compat_sys_execve)
-#define __NR_chdir 12
-__SYSCALL(__NR_chdir, sys_chdir)
-			/* 13 was sys_time */
-__SYSCALL(13, sys_ni_syscall)
-#define __NR_mknod 14
-__SYSCALL(__NR_mknod, sys_mknod)
-#define __NR_chmod 15
-__SYSCALL(__NR_chmod, sys_chmod)
-#define __NR_lchown 16
-__SYSCALL(__NR_lchown, sys_lchown16)
-			/* 17 was sys_break */
-__SYSCALL(17, sys_ni_syscall)
-			/* 18 was sys_stat */
-__SYSCALL(18, sys_ni_syscall)
-#define __NR_lseek 19
-__SYSCALL(__NR_lseek, compat_sys_lseek)
-#define __NR_getpid 20
-__SYSCALL(__NR_getpid, sys_getpid)
-#define __NR_mount 21
-__SYSCALL(__NR_mount, sys_mount)
-			/* 22 was sys_umount */
-__SYSCALL(22, sys_ni_syscall)
-#define __NR_setuid 23
-__SYSCALL(__NR_setuid, sys_setuid16)
-#define __NR_getuid 24
-__SYSCALL(__NR_getuid, sys_getuid16)
-			/* 25 was sys_stime */
-__SYSCALL(25, sys_ni_syscall)
-#define __NR_ptrace 26
-__SYSCALL(__NR_ptrace, compat_sys_ptrace)
-			/* 27 was sys_alarm */
-__SYSCALL(27, sys_ni_syscall)
-			/* 28 was sys_fstat */
-__SYSCALL(28, sys_ni_syscall)
-#define __NR_pause 29
-__SYSCALL(__NR_pause, sys_pause)
-			/* 30 was sys_utime */
-__SYSCALL(30, sys_ni_syscall)
-			/* 31 was sys_stty */
-__SYSCALL(31, sys_ni_syscall)
-			/* 32 was sys_gtty */
-__SYSCALL(32, sys_ni_syscall)
-#define __NR_access 33
-__SYSCALL(__NR_access, sys_access)
-#define __NR_nice 34
-__SYSCALL(__NR_nice, sys_nice)
-			/* 35 was sys_ftime */
-__SYSCALL(35, sys_ni_syscall)
-#define __NR_sync 36
-__SYSCALL(__NR_sync, sys_sync)
-#define __NR_kill 37
-__SYSCALL(__NR_kill, sys_kill)
-#define __NR_rename 38
-__SYSCALL(__NR_rename, sys_rename)
-#define __NR_mkdir 39
-__SYSCALL(__NR_mkdir, sys_mkdir)
-#define __NR_rmdir 40
-__SYSCALL(__NR_rmdir, sys_rmdir)
-#define __NR_dup 41
-__SYSCALL(__NR_dup, sys_dup)
-#define __NR_pipe 42
-__SYSCALL(__NR_pipe, sys_pipe)
-#define __NR_times 43
-__SYSCALL(__NR_times, compat_sys_times)
-			/* 44 was sys_prof */
-__SYSCALL(44, sys_ni_syscall)
-#define __NR_brk 45
-__SYSCALL(__NR_brk, sys_brk)
-#define __NR_setgid 46
-__SYSCALL(__NR_setgid, sys_setgid16)
-#define __NR_getgid 47
-__SYSCALL(__NR_getgid, sys_getgid16)
-			/* 48 was sys_signal */
-__SYSCALL(48, sys_ni_syscall)
-#define __NR_geteuid 49
-__SYSCALL(__NR_geteuid, sys_geteuid16)
-#define __NR_getegid 50
-__SYSCALL(__NR_getegid, sys_getegid16)
-#define __NR_acct 51
-__SYSCALL(__NR_acct, sys_acct)
-#define __NR_umount2 52
-__SYSCALL(__NR_umount2, sys_umount)
-			/* 53 was sys_lock */
-__SYSCALL(53, sys_ni_syscall)
-#define __NR_ioctl 54
-__SYSCALL(__NR_ioctl, compat_sys_ioctl)
-#define __NR_fcntl 55
-__SYSCALL(__NR_fcntl, compat_sys_fcntl)
-			/* 56 was sys_mpx */
-__SYSCALL(56, sys_ni_syscall)
-#define __NR_setpgid 57
-__SYSCALL(__NR_setpgid, sys_setpgid)
-			/* 58 was sys_ulimit */
-__SYSCALL(58, sys_ni_syscall)
-			/* 59 was sys_olduname */
-__SYSCALL(59, sys_ni_syscall)
-#define __NR_umask 60
-__SYSCALL(__NR_umask, sys_umask)
-#define __NR_chroot 61
-__SYSCALL(__NR_chroot, sys_chroot)
-#define __NR_ustat 62
-__SYSCALL(__NR_ustat, compat_sys_ustat)
-#define __NR_dup2 63
-__SYSCALL(__NR_dup2, sys_dup2)
-#define __NR_getppid 64
-__SYSCALL(__NR_getppid, sys_getppid)
-#define __NR_getpgrp 65
-__SYSCALL(__NR_getpgrp, sys_getpgrp)
-#define __NR_setsid 66
-__SYSCALL(__NR_setsid, sys_setsid)
-#define __NR_sigaction 67
-__SYSCALL(__NR_sigaction, compat_sys_sigaction)
-			/* 68 was sys_sgetmask */
-__SYSCALL(68, sys_ni_syscall)
-			/* 69 was sys_ssetmask */
-__SYSCALL(69, sys_ni_syscall)
-#define __NR_setreuid 70
-__SYSCALL(__NR_setreuid, sys_setreuid16)
-#define __NR_setregid 71
-__SYSCALL(__NR_setregid, sys_setregid16)
-#define __NR_sigsuspend 72
-__SYSCALL(__NR_sigsuspend, sys_sigsuspend)
-#define __NR_sigpending 73
-__SYSCALL(__NR_sigpending, compat_sys_sigpending)
-#define __NR_sethostname 74
-__SYSCALL(__NR_sethostname, sys_sethostname)
-#define __NR_setrlimit 75
-__SYSCALL(__NR_setrlimit, compat_sys_setrlimit)
-			/* 76 was compat_sys_getrlimit */
-__SYSCALL(76, sys_ni_syscall)
-#define __NR_getrusage 77
-__SYSCALL(__NR_getrusage, compat_sys_getrusage)
-#define __NR_gettimeofday 78
-__SYSCALL(__NR_gettimeofday, compat_sys_gettimeofday)
-#define __NR_settimeofday 79
-__SYSCALL(__NR_settimeofday, compat_sys_settimeofday)
-#define __NR_getgroups 80
-__SYSCALL(__NR_getgroups, sys_getgroups16)
-#define __NR_setgroups 81
-__SYSCALL(__NR_setgroups, sys_setgroups16)
-			/* 82 was compat_sys_select */
-__SYSCALL(82, sys_ni_syscall)
-#define __NR_symlink 83
-__SYSCALL(__NR_symlink, sys_symlink)
-			/* 84 was sys_lstat */
-__SYSCALL(84, sys_ni_syscall)
-#define __NR_readlink 85
-__SYSCALL(__NR_readlink, sys_readlink)
-#define __NR_uselib 86
-__SYSCALL(__NR_uselib, sys_uselib)
-#define __NR_swapon 87
-__SYSCALL(__NR_swapon, sys_swapon)
-#define __NR_reboot 88
-__SYSCALL(__NR_reboot, sys_reboot)
-			/* 89 was sys_readdir */
-__SYSCALL(89, sys_ni_syscall)
-			/* 90 was sys_mmap */
-__SYSCALL(90, sys_ni_syscall)
-#define __NR_munmap 91
-__SYSCALL(__NR_munmap, sys_munmap)
-#define __NR_truncate 92
-__SYSCALL(__NR_truncate, compat_sys_truncate)
-#define __NR_ftruncate 93
-__SYSCALL(__NR_ftruncate, compat_sys_ftruncate)
-#define __NR_fchmod 94
-__SYSCALL(__NR_fchmod, sys_fchmod)
-#define __NR_fchown 95
-__SYSCALL(__NR_fchown, sys_fchown16)
-#define __NR_getpriority 96
-__SYSCALL(__NR_getpriority, sys_getpriority)
-#define __NR_setpriority 97
-__SYSCALL(__NR_setpriority, sys_setpriority)
-			/* 98 was sys_profil */
-__SYSCALL(98, sys_ni_syscall)
-#define __NR_statfs 99
-__SYSCALL(__NR_statfs, compat_sys_statfs)
-#define __NR_fstatfs 100
-__SYSCALL(__NR_fstatfs, compat_sys_fstatfs)
-			/* 101 was sys_ioperm */
-__SYSCALL(101, sys_ni_syscall)
-			/* 102 was sys_socketcall */
-__SYSCALL(102, sys_ni_syscall)
-#define __NR_syslog 103
-__SYSCALL(__NR_syslog, sys_syslog)
-#define __NR_setitimer 104
-__SYSCALL(__NR_setitimer, compat_sys_setitimer)
-#define __NR_getitimer 105
-__SYSCALL(__NR_getitimer, compat_sys_getitimer)
-#define __NR_stat 106
-__SYSCALL(__NR_stat, compat_sys_newstat)
-#define __NR_lstat 107
-__SYSCALL(__NR_lstat, compat_sys_newlstat)
-#define __NR_fstat 108
-__SYSCALL(__NR_fstat, compat_sys_newfstat)
-			/* 109 was sys_uname */
-__SYSCALL(109, sys_ni_syscall)
-			/* 110 was sys_iopl */
-__SYSCALL(110, sys_ni_syscall)
-#define __NR_vhangup 111
-__SYSCALL(__NR_vhangup, sys_vhangup)
-			/* 112 was sys_idle */
-__SYSCALL(112, sys_ni_syscall)
-			/* 113 was sys_syscall */
-__SYSCALL(113, sys_ni_syscall)
-#define __NR_wait4 114
-__SYSCALL(__NR_wait4, compat_sys_wait4)
-#define __NR_swapoff 115
-__SYSCALL(__NR_swapoff, sys_swapoff)
-#define __NR_sysinfo 116
-__SYSCALL(__NR_sysinfo, compat_sys_sysinfo)
-			/* 117 was sys_ipc */
-__SYSCALL(117, sys_ni_syscall)
-#define __NR_fsync 118
-__SYSCALL(__NR_fsync, sys_fsync)
-#define __NR_sigreturn 119
-__SYSCALL(__NR_sigreturn, compat_sys_sigreturn)
-#define __NR_clone 120
-__SYSCALL(__NR_clone, sys_clone)
-#define __NR_setdomainname 121
-__SYSCALL(__NR_setdomainname, sys_setdomainname)
-#define __NR_uname 122
-__SYSCALL(__NR_uname, sys_newuname)
-			/* 123 was sys_modify_ldt */
-__SYSCALL(123, sys_ni_syscall)
-#define __NR_adjtimex 124
-__SYSCALL(__NR_adjtimex, sys_adjtimex_time32)
-#define __NR_mprotect 125
-__SYSCALL(__NR_mprotect, sys_mprotect)
-#define __NR_sigprocmask 126
-__SYSCALL(__NR_sigprocmask, compat_sys_sigprocmask)
-			/* 127 was sys_create_module */
-__SYSCALL(127, sys_ni_syscall)
-#define __NR_init_module 128
-__SYSCALL(__NR_init_module, sys_init_module)
-#define __NR_delete_module 129
-__SYSCALL(__NR_delete_module, sys_delete_module)
-			/* 130 was sys_get_kernel_syms */
-__SYSCALL(130, sys_ni_syscall)
-#define __NR_quotactl 131
-__SYSCALL(__NR_quotactl, sys_quotactl)
-#define __NR_getpgid 132
-__SYSCALL(__NR_getpgid, sys_getpgid)
-#define __NR_fchdir 133
-__SYSCALL(__NR_fchdir, sys_fchdir)
-#define __NR_bdflush 134
-__SYSCALL(__NR_bdflush, sys_ni_syscall)
-#define __NR_sysfs 135
-__SYSCALL(__NR_sysfs, sys_sysfs)
-#define __NR_personality 136
-__SYSCALL(__NR_personality, sys_personality)
-			/* 137 was sys_afs_syscall */
-__SYSCALL(137, sys_ni_syscall)
-#define __NR_setfsuid 138
-__SYSCALL(__NR_setfsuid, sys_setfsuid16)
-#define __NR_setfsgid 139
-__SYSCALL(__NR_setfsgid, sys_setfsgid16)
-#define __NR__llseek 140
-__SYSCALL(__NR__llseek, sys_llseek)
-#define __NR_getdents 141
-__SYSCALL(__NR_getdents, compat_sys_getdents)
-#define __NR__newselect 142
-__SYSCALL(__NR__newselect, compat_sys_select)
-#define __NR_flock 143
-__SYSCALL(__NR_flock, sys_flock)
-#define __NR_msync 144
-__SYSCALL(__NR_msync, sys_msync)
-#define __NR_readv 145
-__SYSCALL(__NR_readv, sys_readv)
-#define __NR_writev 146
-__SYSCALL(__NR_writev, sys_writev)
-#define __NR_getsid 147
-__SYSCALL(__NR_getsid, sys_getsid)
-#define __NR_fdatasync 148
-__SYSCALL(__NR_fdatasync, sys_fdatasync)
-			/* 149 was sys_sysctl */
-__SYSCALL(149, sys_ni_syscall)
-#define __NR_mlock 150
-__SYSCALL(__NR_mlock, sys_mlock)
-#define __NR_munlock 151
-__SYSCALL(__NR_munlock, sys_munlock)
-#define __NR_mlockall 152
-__SYSCALL(__NR_mlockall, sys_mlockall)
-#define __NR_munlockall 153
-__SYSCALL(__NR_munlockall, sys_munlockall)
-#define __NR_sched_setparam 154
-__SYSCALL(__NR_sched_setparam, sys_sched_setparam)
-#define __NR_sched_getparam 155
-__SYSCALL(__NR_sched_getparam, sys_sched_getparam)
-#define __NR_sched_setscheduler 156
-__SYSCALL(__NR_sched_setscheduler, sys_sched_setscheduler)
-#define __NR_sched_getscheduler 157
-__SYSCALL(__NR_sched_getscheduler, sys_sched_getscheduler)
-#define __NR_sched_yield 158
-__SYSCALL(__NR_sched_yield, sys_sched_yield)
-#define __NR_sched_get_priority_max 159
-__SYSCALL(__NR_sched_get_priority_max, sys_sched_get_priority_max)
-#define __NR_sched_get_priority_min 160
-__SYSCALL(__NR_sched_get_priority_min, sys_sched_get_priority_min)
-#define __NR_sched_rr_get_interval 161
-__SYSCALL(__NR_sched_rr_get_interval, sys_sched_rr_get_interval_time32)
-#define __NR_nanosleep 162
-__SYSCALL(__NR_nanosleep, sys_nanosleep_time32)
-#define __NR_mremap 163
-__SYSCALL(__NR_mremap, sys_mremap)
-#define __NR_setresuid 164
-__SYSCALL(__NR_setresuid, sys_setresuid16)
-#define __NR_getresuid 165
-__SYSCALL(__NR_getresuid, sys_getresuid16)
-			/* 166 was sys_vm86 */
-__SYSCALL(166, sys_ni_syscall)
-			/* 167 was sys_query_module */
-__SYSCALL(167, sys_ni_syscall)
-#define __NR_poll 168
-__SYSCALL(__NR_poll, sys_poll)
-#define __NR_nfsservctl 169
-__SYSCALL(__NR_nfsservctl, sys_ni_syscall)
-#define __NR_setresgid 170
-__SYSCALL(__NR_setresgid, sys_setresgid16)
-#define __NR_getresgid 171
-__SYSCALL(__NR_getresgid, sys_getresgid16)
-#define __NR_prctl 172
-__SYSCALL(__NR_prctl, sys_prctl)
-#define __NR_rt_sigreturn 173
-__SYSCALL(__NR_rt_sigreturn, compat_sys_rt_sigreturn)
-#define __NR_rt_sigaction 174
-__SYSCALL(__NR_rt_sigaction, compat_sys_rt_sigaction)
-#define __NR_rt_sigprocmask 175
-__SYSCALL(__NR_rt_sigprocmask, compat_sys_rt_sigprocmask)
-#define __NR_rt_sigpending 176
-__SYSCALL(__NR_rt_sigpending, compat_sys_rt_sigpending)
-#define __NR_rt_sigtimedwait 177
-__SYSCALL(__NR_rt_sigtimedwait, compat_sys_rt_sigtimedwait_time32)
-#define __NR_rt_sigqueueinfo 178
-__SYSCALL(__NR_rt_sigqueueinfo, compat_sys_rt_sigqueueinfo)
-#define __NR_rt_sigsuspend 179
-__SYSCALL(__NR_rt_sigsuspend, compat_sys_rt_sigsuspend)
-#define __NR_pread64 180
-__SYSCALL(__NR_pread64, compat_sys_aarch32_pread64)
-#define __NR_pwrite64 181
-__SYSCALL(__NR_pwrite64, compat_sys_aarch32_pwrite64)
-#define __NR_chown 182
-__SYSCALL(__NR_chown, sys_chown16)
-#define __NR_getcwd 183
-__SYSCALL(__NR_getcwd, sys_getcwd)
-#define __NR_capget 184
-__SYSCALL(__NR_capget, sys_capget)
-#define __NR_capset 185
-__SYSCALL(__NR_capset, sys_capset)
-#define __NR_sigaltstack 186
-__SYSCALL(__NR_sigaltstack, compat_sys_sigaltstack)
-#define __NR_sendfile 187
-__SYSCALL(__NR_sendfile, compat_sys_sendfile)
-			/* 188 reserved */
-__SYSCALL(188, sys_ni_syscall)
-			/* 189 reserved */
-__SYSCALL(189, sys_ni_syscall)
-#define __NR_vfork 190
-__SYSCALL(__NR_vfork, sys_vfork)
-#define __NR_ugetrlimit 191	/* SuS compliant getrlimit */
-__SYSCALL(__NR_ugetrlimit, compat_sys_getrlimit)		/* SuS compliant getrlimit */
-#define __NR_mmap2 192
-__SYSCALL(__NR_mmap2, compat_sys_aarch32_mmap2)
-#define __NR_truncate64 193
-__SYSCALL(__NR_truncate64, compat_sys_aarch32_truncate64)
-#define __NR_ftruncate64 194
-__SYSCALL(__NR_ftruncate64, compat_sys_aarch32_ftruncate64)
-#define __NR_stat64 195
-__SYSCALL(__NR_stat64, sys_stat64)
-#define __NR_lstat64 196
-__SYSCALL(__NR_lstat64, sys_lstat64)
-#define __NR_fstat64 197
-__SYSCALL(__NR_fstat64, sys_fstat64)
-#define __NR_lchown32 198
-__SYSCALL(__NR_lchown32, sys_lchown)
-#define __NR_getuid32 199
-__SYSCALL(__NR_getuid32, sys_getuid)
-#define __NR_getgid32 200
-__SYSCALL(__NR_getgid32, sys_getgid)
-#define __NR_geteuid32 201
-__SYSCALL(__NR_geteuid32, sys_geteuid)
-#define __NR_getegid32 202
-__SYSCALL(__NR_getegid32, sys_getegid)
-#define __NR_setreuid32 203
-__SYSCALL(__NR_setreuid32, sys_setreuid)
-#define __NR_setregid32 204
-__SYSCALL(__NR_setregid32, sys_setregid)
-#define __NR_getgroups32 205
-__SYSCALL(__NR_getgroups32, sys_getgroups)
-#define __NR_setgroups32 206
-__SYSCALL(__NR_setgroups32, sys_setgroups)
-#define __NR_fchown32 207
-__SYSCALL(__NR_fchown32, sys_fchown)
-#define __NR_setresuid32 208
-__SYSCALL(__NR_setresuid32, sys_setresuid)
-#define __NR_getresuid32 209
-__SYSCALL(__NR_getresuid32, sys_getresuid)
-#define __NR_setresgid32 210
-__SYSCALL(__NR_setresgid32, sys_setresgid)
-#define __NR_getresgid32 211
-__SYSCALL(__NR_getresgid32, sys_getresgid)
-#define __NR_chown32 212
-__SYSCALL(__NR_chown32, sys_chown)
-#define __NR_setuid32 213
-__SYSCALL(__NR_setuid32, sys_setuid)
-#define __NR_setgid32 214
-__SYSCALL(__NR_setgid32, sys_setgid)
-#define __NR_setfsuid32 215
-__SYSCALL(__NR_setfsuid32, sys_setfsuid)
-#define __NR_setfsgid32 216
-__SYSCALL(__NR_setfsgid32, sys_setfsgid)
-#define __NR_getdents64 217
-__SYSCALL(__NR_getdents64, sys_getdents64)
-#define __NR_pivot_root 218
-__SYSCALL(__NR_pivot_root, sys_pivot_root)
-#define __NR_mincore 219
-__SYSCALL(__NR_mincore, sys_mincore)
-#define __NR_madvise 220
-__SYSCALL(__NR_madvise, sys_madvise)
-#define __NR_fcntl64 221
-__SYSCALL(__NR_fcntl64, compat_sys_fcntl64)
-			/* 222 for tux */
-__SYSCALL(222, sys_ni_syscall)
-			/* 223 is unused */
-__SYSCALL(223, sys_ni_syscall)
-#define __NR_gettid 224
-__SYSCALL(__NR_gettid, sys_gettid)
-#define __NR_readahead 225
-__SYSCALL(__NR_readahead, compat_sys_aarch32_readahead)
-#define __NR_setxattr 226
-__SYSCALL(__NR_setxattr, sys_setxattr)
-#define __NR_lsetxattr 227
-__SYSCALL(__NR_lsetxattr, sys_lsetxattr)
-#define __NR_fsetxattr 228
-__SYSCALL(__NR_fsetxattr, sys_fsetxattr)
-#define __NR_getxattr 229
-__SYSCALL(__NR_getxattr, sys_getxattr)
-#define __NR_lgetxattr 230
-__SYSCALL(__NR_lgetxattr, sys_lgetxattr)
-#define __NR_fgetxattr 231
-__SYSCALL(__NR_fgetxattr, sys_fgetxattr)
-#define __NR_listxattr 232
-__SYSCALL(__NR_listxattr, sys_listxattr)
-#define __NR_llistxattr 233
-__SYSCALL(__NR_llistxattr, sys_llistxattr)
-#define __NR_flistxattr 234
-__SYSCALL(__NR_flistxattr, sys_flistxattr)
-#define __NR_removexattr 235
-__SYSCALL(__NR_removexattr, sys_removexattr)
-#define __NR_lremovexattr 236
-__SYSCALL(__NR_lremovexattr, sys_lremovexattr)
-#define __NR_fremovexattr 237
-__SYSCALL(__NR_fremovexattr, sys_fremovexattr)
-#define __NR_tkill 238
-__SYSCALL(__NR_tkill, sys_tkill)
-#define __NR_sendfile64 239
-__SYSCALL(__NR_sendfile64, sys_sendfile64)
-#define __NR_futex 240
-__SYSCALL(__NR_futex, sys_futex_time32)
-#define __NR_sched_setaffinity 241
-__SYSCALL(__NR_sched_setaffinity, compat_sys_sched_setaffinity)
-#define __NR_sched_getaffinity 242
-__SYSCALL(__NR_sched_getaffinity, compat_sys_sched_getaffinity)
-#define __NR_io_setup 243
-__SYSCALL(__NR_io_setup, compat_sys_io_setup)
-#define __NR_io_destroy 244
-__SYSCALL(__NR_io_destroy, sys_io_destroy)
-#define __NR_io_getevents 245
-__SYSCALL(__NR_io_getevents, sys_io_getevents_time32)
-#define __NR_io_submit 246
-__SYSCALL(__NR_io_submit, compat_sys_io_submit)
-#define __NR_io_cancel 247
-__SYSCALL(__NR_io_cancel, sys_io_cancel)
-#define __NR_exit_group 248
-__SYSCALL(__NR_exit_group, sys_exit_group)
-			/* 249 was lookup_dcookie */
-__SYSCALL(249, sys_ni_syscall)
-#define __NR_epoll_create 250
-__SYSCALL(__NR_epoll_create, sys_epoll_create)
-#define __NR_epoll_ctl 251
-__SYSCALL(__NR_epoll_ctl, sys_epoll_ctl)
-#define __NR_epoll_wait 252
-__SYSCALL(__NR_epoll_wait, sys_epoll_wait)
-#define __NR_remap_file_pages 253
-__SYSCALL(__NR_remap_file_pages, sys_remap_file_pages)
-			/* 254 for set_thread_area */
-__SYSCALL(254, sys_ni_syscall)
-			/* 255 for get_thread_area */
-__SYSCALL(255, sys_ni_syscall)
-#define __NR_set_tid_address 256
-__SYSCALL(__NR_set_tid_address, sys_set_tid_address)
-#define __NR_timer_create 257
-__SYSCALL(__NR_timer_create, compat_sys_timer_create)
-#define __NR_timer_settime 258
-__SYSCALL(__NR_timer_settime, sys_timer_settime32)
-#define __NR_timer_gettime 259
-__SYSCALL(__NR_timer_gettime, sys_timer_gettime32)
-#define __NR_timer_getoverrun 260
-__SYSCALL(__NR_timer_getoverrun, sys_timer_getoverrun)
-#define __NR_timer_delete 261
-__SYSCALL(__NR_timer_delete, sys_timer_delete)
-#define __NR_clock_settime 262
-__SYSCALL(__NR_clock_settime, sys_clock_settime32)
-#define __NR_clock_gettime 263
-__SYSCALL(__NR_clock_gettime, sys_clock_gettime32)
-#define __NR_clock_getres 264
-__SYSCALL(__NR_clock_getres, sys_clock_getres_time32)
-#define __NR_clock_nanosleep 265
-__SYSCALL(__NR_clock_nanosleep, sys_clock_nanosleep_time32)
-#define __NR_statfs64 266
-__SYSCALL(__NR_statfs64, compat_sys_aarch32_statfs64)
-#define __NR_fstatfs64 267
-__SYSCALL(__NR_fstatfs64, compat_sys_aarch32_fstatfs64)
-#define __NR_tgkill 268
-__SYSCALL(__NR_tgkill, sys_tgkill)
-#define __NR_utimes 269
-__SYSCALL(__NR_utimes, sys_utimes_time32)
-#define __NR_arm_fadvise64_64 270
-__SYSCALL(__NR_arm_fadvise64_64, compat_sys_aarch32_fadvise64_64)
-#define __NR_pciconfig_iobase 271
-__SYSCALL(__NR_pciconfig_iobase, sys_pciconfig_iobase)
-#define __NR_pciconfig_read 272
-__SYSCALL(__NR_pciconfig_read, sys_pciconfig_read)
-#define __NR_pciconfig_write 273
-__SYSCALL(__NR_pciconfig_write, sys_pciconfig_write)
-#define __NR_mq_open 274
-__SYSCALL(__NR_mq_open, compat_sys_mq_open)
-#define __NR_mq_unlink 275
-__SYSCALL(__NR_mq_unlink, sys_mq_unlink)
-#define __NR_mq_timedsend 276
-__SYSCALL(__NR_mq_timedsend, sys_mq_timedsend_time32)
-#define __NR_mq_timedreceive 277
-__SYSCALL(__NR_mq_timedreceive, sys_mq_timedreceive_time32)
-#define __NR_mq_notify 278
-__SYSCALL(__NR_mq_notify, compat_sys_mq_notify)
-#define __NR_mq_getsetattr 279
-__SYSCALL(__NR_mq_getsetattr, compat_sys_mq_getsetattr)
-#define __NR_waitid 280
-__SYSCALL(__NR_waitid, compat_sys_waitid)
-#define __NR_socket 281
-__SYSCALL(__NR_socket, sys_socket)
-#define __NR_bind 282
-__SYSCALL(__NR_bind, sys_bind)
-#define __NR_connect 283
-__SYSCALL(__NR_connect, sys_connect)
-#define __NR_listen 284
-__SYSCALL(__NR_listen, sys_listen)
-#define __NR_accept 285
-__SYSCALL(__NR_accept, sys_accept)
-#define __NR_getsockname 286
-__SYSCALL(__NR_getsockname, sys_getsockname)
-#define __NR_getpeername 287
-__SYSCALL(__NR_getpeername, sys_getpeername)
-#define __NR_socketpair 288
-__SYSCALL(__NR_socketpair, sys_socketpair)
-#define __NR_send 289
-__SYSCALL(__NR_send, sys_send)
-#define __NR_sendto 290
-__SYSCALL(__NR_sendto, sys_sendto)
-#define __NR_recv 291
-__SYSCALL(__NR_recv, compat_sys_recv)
-#define __NR_recvfrom 292
-__SYSCALL(__NR_recvfrom, compat_sys_recvfrom)
-#define __NR_shutdown 293
-__SYSCALL(__NR_shutdown, sys_shutdown)
-#define __NR_setsockopt 294
-__SYSCALL(__NR_setsockopt, sys_setsockopt)
-#define __NR_getsockopt 295
-__SYSCALL(__NR_getsockopt, sys_getsockopt)
-#define __NR_sendmsg 296
-__SYSCALL(__NR_sendmsg, compat_sys_sendmsg)
-#define __NR_recvmsg 297
-__SYSCALL(__NR_recvmsg, compat_sys_recvmsg)
-#define __NR_semop 298
-__SYSCALL(__NR_semop, sys_semop)
-#define __NR_semget 299
-__SYSCALL(__NR_semget, sys_semget)
-#define __NR_semctl 300
-__SYSCALL(__NR_semctl, compat_sys_old_semctl)
-#define __NR_msgsnd 301
-__SYSCALL(__NR_msgsnd, compat_sys_msgsnd)
-#define __NR_msgrcv 302
-__SYSCALL(__NR_msgrcv, compat_sys_msgrcv)
-#define __NR_msgget 303
-__SYSCALL(__NR_msgget, sys_msgget)
-#define __NR_msgctl 304
-__SYSCALL(__NR_msgctl, compat_sys_old_msgctl)
-#define __NR_shmat 305
-__SYSCALL(__NR_shmat, compat_sys_shmat)
-#define __NR_shmdt 306
-__SYSCALL(__NR_shmdt, sys_shmdt)
-#define __NR_shmget 307
-__SYSCALL(__NR_shmget, sys_shmget)
-#define __NR_shmctl 308
-__SYSCALL(__NR_shmctl, compat_sys_old_shmctl)
-#define __NR_add_key 309
-__SYSCALL(__NR_add_key, sys_add_key)
-#define __NR_request_key 310
-__SYSCALL(__NR_request_key, sys_request_key)
-#define __NR_keyctl 311
-__SYSCALL(__NR_keyctl, compat_sys_keyctl)
-#define __NR_semtimedop 312
-__SYSCALL(__NR_semtimedop, sys_semtimedop_time32)
-#define __NR_vserver 313
-__SYSCALL(__NR_vserver, sys_ni_syscall)
-#define __NR_ioprio_set 314
-__SYSCALL(__NR_ioprio_set, sys_ioprio_set)
-#define __NR_ioprio_get 315
-__SYSCALL(__NR_ioprio_get, sys_ioprio_get)
-#define __NR_inotify_init 316
-__SYSCALL(__NR_inotify_init, sys_inotify_init)
-#define __NR_inotify_add_watch 317
-__SYSCALL(__NR_inotify_add_watch, sys_inotify_add_watch)
-#define __NR_inotify_rm_watch 318
-__SYSCALL(__NR_inotify_rm_watch, sys_inotify_rm_watch)
-#define __NR_mbind 319
-__SYSCALL(__NR_mbind, sys_mbind)
-#define __NR_get_mempolicy 320
-__SYSCALL(__NR_get_mempolicy, sys_get_mempolicy)
-#define __NR_set_mempolicy 321
-__SYSCALL(__NR_set_mempolicy, sys_set_mempolicy)
-#define __NR_openat 322
-__SYSCALL(__NR_openat, compat_sys_openat)
-#define __NR_mkdirat 323
-__SYSCALL(__NR_mkdirat, sys_mkdirat)
-#define __NR_mknodat 324
-__SYSCALL(__NR_mknodat, sys_mknodat)
-#define __NR_fchownat 325
-__SYSCALL(__NR_fchownat, sys_fchownat)
-#define __NR_futimesat 326
-__SYSCALL(__NR_futimesat, sys_futimesat_time32)
-#define __NR_fstatat64 327
-__SYSCALL(__NR_fstatat64, sys_fstatat64)
-#define __NR_unlinkat 328
-__SYSCALL(__NR_unlinkat, sys_unlinkat)
-#define __NR_renameat 329
-__SYSCALL(__NR_renameat, sys_renameat)
-#define __NR_linkat 330
-__SYSCALL(__NR_linkat, sys_linkat)
-#define __NR_symlinkat 331
-__SYSCALL(__NR_symlinkat, sys_symlinkat)
-#define __NR_readlinkat 332
-__SYSCALL(__NR_readlinkat, sys_readlinkat)
-#define __NR_fchmodat 333
-__SYSCALL(__NR_fchmodat, sys_fchmodat)
-#define __NR_faccessat 334
-__SYSCALL(__NR_faccessat, sys_faccessat)
-#define __NR_pselect6 335
-__SYSCALL(__NR_pselect6, compat_sys_pselect6_time32)
-#define __NR_ppoll 336
-__SYSCALL(__NR_ppoll, compat_sys_ppoll_time32)
-#define __NR_unshare 337
-__SYSCALL(__NR_unshare, sys_unshare)
-#define __NR_set_robust_list 338
-__SYSCALL(__NR_set_robust_list, compat_sys_set_robust_list)
-#define __NR_get_robust_list 339
-__SYSCALL(__NR_get_robust_list, compat_sys_get_robust_list)
-#define __NR_splice 340
-__SYSCALL(__NR_splice, sys_splice)
-#define __NR_sync_file_range2 341
-__SYSCALL(__NR_sync_file_range2, compat_sys_aarch32_sync_file_range2)
-#define __NR_tee 342
-__SYSCALL(__NR_tee, sys_tee)
-#define __NR_vmsplice 343
-__SYSCALL(__NR_vmsplice, sys_vmsplice)
-#define __NR_move_pages 344
-__SYSCALL(__NR_move_pages, sys_move_pages)
-#define __NR_getcpu 345
-__SYSCALL(__NR_getcpu, sys_getcpu)
-#define __NR_epoll_pwait 346
-__SYSCALL(__NR_epoll_pwait, compat_sys_epoll_pwait)
-#define __NR_kexec_load 347
-__SYSCALL(__NR_kexec_load, compat_sys_kexec_load)
-#define __NR_utimensat 348
-__SYSCALL(__NR_utimensat, sys_utimensat_time32)
-#define __NR_signalfd 349
-__SYSCALL(__NR_signalfd, compat_sys_signalfd)
-#define __NR_timerfd_create 350
-__SYSCALL(__NR_timerfd_create, sys_timerfd_create)
-#define __NR_eventfd 351
-__SYSCALL(__NR_eventfd, sys_eventfd)
-#define __NR_fallocate 352
-__SYSCALL(__NR_fallocate, compat_sys_aarch32_fallocate)
-#define __NR_timerfd_settime 353
-__SYSCALL(__NR_timerfd_settime, sys_timerfd_settime32)
-#define __NR_timerfd_gettime 354
-__SYSCALL(__NR_timerfd_gettime, sys_timerfd_gettime32)
-#define __NR_signalfd4 355
-__SYSCALL(__NR_signalfd4, compat_sys_signalfd4)
-#define __NR_eventfd2 356
-__SYSCALL(__NR_eventfd2, sys_eventfd2)
-#define __NR_epoll_create1 357
-__SYSCALL(__NR_epoll_create1, sys_epoll_create1)
-#define __NR_dup3 358
-__SYSCALL(__NR_dup3, sys_dup3)
-#define __NR_pipe2 359
-__SYSCALL(__NR_pipe2, sys_pipe2)
-#define __NR_inotify_init1 360
-__SYSCALL(__NR_inotify_init1, sys_inotify_init1)
-#define __NR_preadv 361
-__SYSCALL(__NR_preadv, compat_sys_preadv)
-#define __NR_pwritev 362
-__SYSCALL(__NR_pwritev, compat_sys_pwritev)
-#define __NR_rt_tgsigqueueinfo 363
-__SYSCALL(__NR_rt_tgsigqueueinfo, compat_sys_rt_tgsigqueueinfo)
-#define __NR_perf_event_open 364
-__SYSCALL(__NR_perf_event_open, sys_perf_event_open)
-#define __NR_recvmmsg 365
-__SYSCALL(__NR_recvmmsg, compat_sys_recvmmsg_time32)
-#define __NR_accept4 366
-__SYSCALL(__NR_accept4, sys_accept4)
-#define __NR_fanotify_init 367
-__SYSCALL(__NR_fanotify_init, sys_fanotify_init)
-#define __NR_fanotify_mark 368
-__SYSCALL(__NR_fanotify_mark, compat_sys_fanotify_mark)
-#define __NR_prlimit64 369
-__SYSCALL(__NR_prlimit64, sys_prlimit64)
-#define __NR_name_to_handle_at 370
-__SYSCALL(__NR_name_to_handle_at, sys_name_to_handle_at)
-#define __NR_open_by_handle_at 371
-__SYSCALL(__NR_open_by_handle_at, compat_sys_open_by_handle_at)
-#define __NR_clock_adjtime 372
-__SYSCALL(__NR_clock_adjtime, sys_clock_adjtime32)
-#define __NR_syncfs 373
-__SYSCALL(__NR_syncfs, sys_syncfs)
-#define __NR_sendmmsg 374
-__SYSCALL(__NR_sendmmsg, compat_sys_sendmmsg)
-#define __NR_setns 375
-__SYSCALL(__NR_setns, sys_setns)
-#define __NR_process_vm_readv 376
-__SYSCALL(__NR_process_vm_readv, sys_process_vm_readv)
-#define __NR_process_vm_writev 377
-__SYSCALL(__NR_process_vm_writev, sys_process_vm_writev)
-#define __NR_kcmp 378
-__SYSCALL(__NR_kcmp, sys_kcmp)
-#define __NR_finit_module 379
-__SYSCALL(__NR_finit_module, sys_finit_module)
-#define __NR_sched_setattr 380
-__SYSCALL(__NR_sched_setattr, sys_sched_setattr)
-#define __NR_sched_getattr 381
-__SYSCALL(__NR_sched_getattr, sys_sched_getattr)
-#define __NR_renameat2 382
-__SYSCALL(__NR_renameat2, sys_renameat2)
-#define __NR_seccomp 383
-__SYSCALL(__NR_seccomp, sys_seccomp)
-#define __NR_getrandom 384
-__SYSCALL(__NR_getrandom, sys_getrandom)
-#define __NR_memfd_create 385
-__SYSCALL(__NR_memfd_create, sys_memfd_create)
-#define __NR_bpf 386
-__SYSCALL(__NR_bpf, sys_bpf)
-#define __NR_execveat 387
-__SYSCALL(__NR_execveat, compat_sys_execveat)
-#define __NR_userfaultfd 388
-__SYSCALL(__NR_userfaultfd, sys_userfaultfd)
-#define __NR_membarrier 389
-__SYSCALL(__NR_membarrier, sys_membarrier)
-#define __NR_mlock2 390
-__SYSCALL(__NR_mlock2, sys_mlock2)
-#define __NR_copy_file_range 391
-__SYSCALL(__NR_copy_file_range, sys_copy_file_range)
-#define __NR_preadv2 392
-__SYSCALL(__NR_preadv2, compat_sys_preadv2)
-#define __NR_pwritev2 393
-__SYSCALL(__NR_pwritev2, compat_sys_pwritev2)
-#define __NR_pkey_mprotect 394
-__SYSCALL(__NR_pkey_mprotect, sys_pkey_mprotect)
-#define __NR_pkey_alloc 395
-__SYSCALL(__NR_pkey_alloc, sys_pkey_alloc)
-#define __NR_pkey_free 396
-__SYSCALL(__NR_pkey_free, sys_pkey_free)
-#define __NR_statx 397
-__SYSCALL(__NR_statx, sys_statx)
-#define __NR_rseq 398
-__SYSCALL(__NR_rseq, sys_rseq)
-#define __NR_io_pgetevents 399
-__SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
-#define __NR_migrate_pages 400
-__SYSCALL(__NR_migrate_pages, sys_migrate_pages)
-#define __NR_kexec_file_load 401
-__SYSCALL(__NR_kexec_file_load, sys_kexec_file_load)
-/* 402 is unused */
-#define __NR_clock_gettime64 403
-__SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
-#define __NR_clock_settime64 404
-__SYSCALL(__NR_clock_settime64, sys_clock_settime)
-#define __NR_clock_adjtime64 405
-__SYSCALL(__NR_clock_adjtime64, sys_clock_adjtime)
-#define __NR_clock_getres_time64 406
-__SYSCALL(__NR_clock_getres_time64, sys_clock_getres)
-#define __NR_clock_nanosleep_time64 407
-__SYSCALL(__NR_clock_nanosleep_time64, sys_clock_nanosleep)
-#define __NR_timer_gettime64 408
-__SYSCALL(__NR_timer_gettime64, sys_timer_gettime)
-#define __NR_timer_settime64 409
-__SYSCALL(__NR_timer_settime64, sys_timer_settime)
-#define __NR_timerfd_gettime64 410
-__SYSCALL(__NR_timerfd_gettime64, sys_timerfd_gettime)
-#define __NR_timerfd_settime64 411
-__SYSCALL(__NR_timerfd_settime64, sys_timerfd_settime)
-#define __NR_utimensat_time64 412
-__SYSCALL(__NR_utimensat_time64, sys_utimensat)
-#define __NR_pselect6_time64 413
-__SYSCALL(__NR_pselect6_time64, compat_sys_pselect6_time64)
-#define __NR_ppoll_time64 414
-__SYSCALL(__NR_ppoll_time64, compat_sys_ppoll_time64)
-#define __NR_io_pgetevents_time64 416
-__SYSCALL(__NR_io_pgetevents_time64, compat_sys_io_pgetevents_time64)
-#define __NR_recvmmsg_time64 417
-__SYSCALL(__NR_recvmmsg_time64, compat_sys_recvmmsg_time64)
-#define __NR_mq_timedsend_time64 418
-__SYSCALL(__NR_mq_timedsend_time64, sys_mq_timedsend)
-#define __NR_mq_timedreceive_time64 419
-__SYSCALL(__NR_mq_timedreceive_time64, sys_mq_timedreceive)
-#define __NR_semtimedop_time64 420
-__SYSCALL(__NR_semtimedop_time64, sys_semtimedop)
-#define __NR_rt_sigtimedwait_time64 421
-__SYSCALL(__NR_rt_sigtimedwait_time64, compat_sys_rt_sigtimedwait_time64)
-#define __NR_futex_time64 422
-__SYSCALL(__NR_futex_time64, sys_futex)
-#define __NR_sched_rr_get_interval_time64 423
-__SYSCALL(__NR_sched_rr_get_interval_time64, sys_sched_rr_get_interval)
-#define __NR_pidfd_send_signal 424
-__SYSCALL(__NR_pidfd_send_signal, sys_pidfd_send_signal)
-#define __NR_io_uring_setup 425
-__SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
-#define __NR_io_uring_enter 426
-__SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
-#define __NR_io_uring_register 427
-__SYSCALL(__NR_io_uring_register, sys_io_uring_register)
-#define __NR_open_tree 428
-__SYSCALL(__NR_open_tree, sys_open_tree)
-#define __NR_move_mount 429
-__SYSCALL(__NR_move_mount, sys_move_mount)
-#define __NR_fsopen 430
-__SYSCALL(__NR_fsopen, sys_fsopen)
-#define __NR_fsconfig 431
-__SYSCALL(__NR_fsconfig, sys_fsconfig)
-#define __NR_fsmount 432
-__SYSCALL(__NR_fsmount, sys_fsmount)
-#define __NR_fspick 433
-__SYSCALL(__NR_fspick, sys_fspick)
-#define __NR_pidfd_open 434
-__SYSCALL(__NR_pidfd_open, sys_pidfd_open)
-#define __NR_clone3 435
-__SYSCALL(__NR_clone3, sys_clone3)
-#define __NR_close_range 436
-__SYSCALL(__NR_close_range, sys_close_range)
-#define __NR_openat2 437
-__SYSCALL(__NR_openat2, sys_openat2)
-#define __NR_pidfd_getfd 438
-__SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
-#define __NR_faccessat2 439
-__SYSCALL(__NR_faccessat2, sys_faccessat2)
-#define __NR_process_madvise 440
-__SYSCALL(__NR_process_madvise, sys_process_madvise)
-#define __NR_epoll_pwait2 441
-__SYSCALL(__NR_epoll_pwait2, compat_sys_epoll_pwait2)
-#define __NR_mount_setattr 442
-__SYSCALL(__NR_mount_setattr, sys_mount_setattr)
-#define __NR_quotactl_fd 443
-__SYSCALL(__NR_quotactl_fd, sys_quotactl_fd)
-#define __NR_landlock_create_ruleset 444
-__SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
-#define __NR_landlock_add_rule 445
-__SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
-#define __NR_landlock_restrict_self 446
-__SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
-#define __NR_process_mrelease 448
-__SYSCALL(__NR_process_mrelease, sys_process_mrelease)
-#define __NR_futex_waitv 449
-__SYSCALL(__NR_futex_waitv, sys_futex_waitv)
-#define __NR_set_mempolicy_home_node 450
-__SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
-#define __NR_cachestat 451
-__SYSCALL(__NR_cachestat, sys_cachestat)
-#define __NR_fchmodat2 452
-__SYSCALL(__NR_fchmodat2, sys_fchmodat2)
-#define __NR_map_shadow_stack 453
-__SYSCALL(__NR_map_shadow_stack, sys_map_shadow_stack)
-#define __NR_futex_wake 454
-__SYSCALL(__NR_futex_wake, sys_futex_wake)
-#define __NR_futex_wait 455
-__SYSCALL(__NR_futex_wait, sys_futex_wait)
-#define __NR_futex_requeue 456
-__SYSCALL(__NR_futex_requeue, sys_futex_requeue)
-#define __NR_statmount 457
-__SYSCALL(__NR_statmount, sys_statmount)
-#define __NR_listmount 458
-__SYSCALL(__NR_listmount, sys_listmount)
-#define __NR_lsm_get_self_attr 459
-__SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
-#define __NR_lsm_set_self_attr 460
-__SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
-#define __NR_lsm_list_modules 461
-__SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
-#define __NR_mseal 462
-__SYSCALL(__NR_mseal, sys_mseal)
+#define __NR_sync_file_range2           __NR_arm_sync_file_range
 
-/*
- * Please add new compat syscalls above this comment and update
- * __NR_compat_syscalls in asm/unistd.h.
- */
+#endif /* _UAPI__ASM_ARM_UNISTD_H */
diff --git a/arch/arm64/kernel/Makefile.syscalls b/arch/arm64/kernel/Makefile.syscalls
new file mode 100644
index 000000000000..1e14effb3921
--- /dev/null
+++ b/arch/arm64/kernel/Makefile.syscalls
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32 +=
+
+syscalltbl = arch/arm64/tools/syscall_%.tbl
diff --git a/arch/arm64/kernel/sys32.c b/arch/arm64/kernel/sys32.c
index fc40386afb1b..96bcfb907443 100644
--- a/arch/arm64/kernel/sys32.c
+++ b/arch/arm64/kernel/sys32.c
@@ -5,17 +5,12 @@
  * Copyright (C) 2015 ARM Ltd.
  */
 
-/*
- * Needed to avoid conflicting __NR_* macros between uapi/asm/unistd.h and
- * asm/unistd32.h.
- */
-#define __COMPAT_SYSCALL_NR
-
 #include <linux/compat.h>
 #include <linux/compiler.h>
 #include <linux/syscalls.h>
 
 #include <asm/syscall.h>
+#include <asm/unistd_compat_32.h>
 
 asmlinkage long compat_sys_sigreturn(void);
 asmlinkage long compat_sys_rt_sigreturn(void);
@@ -122,14 +117,16 @@ COMPAT_SYSCALL_DEFINE6(aarch32_fallocate, int, fd, int, mode,
 	return ksys_fallocate(fd, mode, arg_u64(offset), arg_u64(len));
 }
 
+#define __SYSCALL_WITH_COMPAT(nr, sym, compat) __SYSCALL(nr, compat)
+
 #undef __SYSCALL
 #define __SYSCALL(nr, sym)	asmlinkage long __arm64_##sym(const struct pt_regs *);
-#include <asm/unistd32.h>
+#include <asm/syscall_table_32.h>
 
 #undef __SYSCALL
 #define __SYSCALL(nr, sym)	[nr] = __arm64_##sym,
 
-const syscall_fn_t compat_sys_call_table[__NR_compat_syscalls] = {
-	[0 ... __NR_compat_syscalls - 1] = __arm64_sys_ni_syscall,
-#include <asm/unistd32.h>
+const syscall_fn_t compat_sys_call_table[__NR_compat32_syscalls] = {
+	[0 ... __NR_compat32_syscalls - 1] = __arm64_sys_ni_syscall,
+#include <asm/syscall_table_32.h>
 };
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 7230f6e20ab8..c442fcec6b9e 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -14,6 +14,7 @@
 #include <asm/syscall.h>
 #include <asm/thread_info.h>
 #include <asm/unistd.h>
+#include <asm/unistd_compat_32.h>
 
 long compat_arm_syscall(struct pt_regs *regs, int scno);
 long sys_ni_syscall(void);
@@ -153,7 +154,7 @@ void do_el0_svc(struct pt_regs *regs)
 #ifdef CONFIG_COMPAT
 void do_el0_svc_compat(struct pt_regs *regs)
 {
-	el0_svc_common(regs, regs->regs[7], __NR_compat_syscalls,
+	el0_svc_common(regs, regs->regs[7], __NR_compat32_syscalls,
 		       compat_sys_call_table);
 }
 #endif
diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_32.tbl
new file mode 100644
index 000000000000..9a37930d4e26
--- /dev/null
+++ b/arch/arm64/tools/syscall_32.tbl
@@ -0,0 +1,476 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# AArch32 (compat) system call definitions.
+#
+# Copyright (C) 2001-2005 Russell King
+# Copyright (C) 2012 ARM Ltd.
+#
+# This file corresponds to arch/arm/tools/syscall.tbl
+# for the native EABI syscalls and should be kept in sync
+# Instead of the OABI syscalls, it contains pointers to
+# the compat entry points where they differ from the native
+# syscalls.
+#
+0	common	restart_syscall		sys_restart_syscall
+1	common	exit			sys_exit
+2	common	fork			sys_fork
+3	common	read			sys_read
+4	common	write			sys_write
+5	common	open			sys_open		compat_sys_open
+6	common	close			sys_close
+# 7 was sys_waitpid
+8	common	creat			sys_creat
+9	common	link			sys_link
+10	common	unlink			sys_unlink
+11	common	execve			sys_execve		compat_sys_execve
+12	common	chdir			sys_chdir
+# 13 was sys_time
+14	common	mknod			sys_mknod
+15	common	chmod			sys_chmod
+16	common	lchown			sys_lchown16
+# 17 was sys_break
+# 18 was sys_stat
+19	common	lseek			sys_lseek		compat_sys_lseek
+20	common	getpid			sys_getpid
+21	common	mount			sys_mount
+# 22 was sys_umount
+23	common	setuid			sys_setuid16
+24	common	getuid			sys_getuid16
+# 25 was sys_stime
+26	common	ptrace			sys_ptrace		compat_sys_ptrace
+# 27 was sys_alarm
+# 28 was sys_fstat
+29	common	pause			sys_pause
+# 30 was sys_utime
+# 31 was sys_stty
+# 32 was sys_gtty
+33	common	access			sys_access
+34	common	nice			sys_nice
+# 35 was sys_ftime
+36	common	sync			sys_sync
+37	common	kill			sys_kill
+38	common	rename			sys_rename
+39	common	mkdir			sys_mkdir
+40	common	rmdir			sys_rmdir
+41	common	dup			sys_dup
+42	common	pipe			sys_pipe
+43	common	times			sys_times		compat_sys_times
+# 44 was sys_prof
+45	common	brk			sys_brk
+46	common	setgid			sys_setgid16
+47	common	getgid			sys_getgid16
+# 48 was sys_signal
+49	common	geteuid			sys_geteuid16
+50	common	getegid			sys_getegid16
+51	common	acct			sys_acct
+52	common	umount2			sys_umount
+# 53 was sys_lock
+54	common	ioctl			sys_ioctl		compat_sys_ioctl
+55	common	fcntl			sys_fcntl		compat_sys_fcntl
+# 56 was sys_mpx
+57	common	setpgid			sys_setpgid
+# 58 was sys_ulimit
+# 59 was sys_olduname
+60	common	umask			sys_umask
+61	common	chroot			sys_chroot
+62	common	ustat			sys_ustat		compat_sys_ustat
+63	common	dup2			sys_dup2
+64	common	getppid			sys_getppid
+65	common	getpgrp			sys_getpgrp
+66	common	setsid			sys_setsid
+67	common	sigaction		sys_sigaction		compat_sys_sigaction
+# 68 was sys_sgetmask
+# 69 was sys_ssetmask
+70	common	setreuid		sys_setreuid16
+71	common	setregid		sys_setregid16
+72	common	sigsuspend		sys_sigsuspend
+73	common	sigpending		sys_sigpending		compat_sys_sigpending
+74	common	sethostname		sys_sethostname
+75	common	setrlimit		sys_setrlimit		compat_sys_setrlimit
+# 76 was compat_sys_getrlimit
+77	common	getrusage		sys_getrusage		compat_sys_getrusage
+78	common	gettimeofday		sys_gettimeofday	compat_sys_gettimeofday
+79	common	settimeofday		sys_settimeofday	compat_sys_settimeofday
+80	common	getgroups		sys_getgroups16
+81	common	setgroups		sys_setgroups16
+# 82 was compat_sys_select
+83	common	symlink			sys_symlink
+# 84 was sys_lstat
+85	common	readlink		sys_readlink
+86	common	uselib			sys_uselib
+87	common	swapon			sys_swapon
+88	common	reboot			sys_reboot
+# 89 was sys_readdir
+# 90 was sys_mmap
+91	common	munmap			sys_munmap
+92	common	truncate		sys_truncate		compat_sys_truncate
+93	common	ftruncate		sys_ftruncate		compat_sys_ftruncate
+94	common	fchmod			sys_fchmod
+95	common	fchown			sys_fchown16
+96	common	getpriority		sys_getpriority
+97	common	setpriority		sys_setpriority
+# 98 was sys_profil
+99	common	statfs			sys_statfs		compat_sys_statfs
+100	common	fstatfs			sys_fstatfs		compat_sys_fstatfs
+# 101 was sys_ioperm
+# 102 was sys_socketcall
+103	common	syslog			sys_syslog
+104	common	setitimer		sys_setitimer		compat_sys_setitimer
+105	common	getitimer		sys_getitimer		compat_sys_getitimer
+106	common	stat			sys_newstat		compat_sys_newstat
+107	common	lstat			sys_newlstat		compat_sys_newlstat
+108	common	fstat			sys_newfstat		compat_sys_newfstat
+# 109 was sys_uname
+# 110 was sys_iopl
+111	common	vhangup			sys_vhangup
+# 112 was sys_idle
+# 113 was sys_syscall
+114	common	wait4			sys_wait4		compat_sys_wait4
+115	common	swapoff			sys_swapoff
+116	common	sysinfo			sys_sysinfo		compat_sys_sysinfo
+# 117 was sys_ipc
+118	common	fsync			sys_fsync
+119	common	sigreturn		sys_sigreturn_wrapper	compat_sys_sigreturn
+120	common	clone			sys_clone
+121	common	setdomainname		sys_setdomainname
+122	common	uname			sys_newuname
+# 123 was sys_modify_ldt
+124	common	adjtimex		sys_adjtimex_time32
+125	common	mprotect		sys_mprotect
+126	common	sigprocmask		sys_sigprocmask		compat_sys_sigprocmask
+# 127 was sys_create_module
+128	common	init_module		sys_init_module
+129	common	delete_module		sys_delete_module
+# 130 was sys_get_kernel_syms
+131	common	quotactl		sys_quotactl
+132	common	getpgid			sys_getpgid
+133	common	fchdir			sys_fchdir
+134	common	bdflush			sys_ni_syscall
+135	common	sysfs			sys_sysfs
+136	common	personality		sys_personality
+# 137 was sys_afs_syscall
+138	common	setfsuid		sys_setfsuid16
+139	common	setfsgid		sys_setfsgid16
+140	common	_llseek			sys_llseek
+141	common	getdents		sys_getdents		compat_sys_getdents
+142	common	_newselect		sys_select		compat_sys_select
+143	common	flock			sys_flock
+144	common	msync			sys_msync
+145	common	readv			sys_readv
+146	common	writev			sys_writev
+147	common	getsid			sys_getsid
+148	common	fdatasync		sys_fdatasync
+149	common	_sysctl			sys_ni_syscall
+150	common	mlock			sys_mlock
+151	common	munlock			sys_munlock
+152	common	mlockall		sys_mlockall
+153	common	munlockall		sys_munlockall
+154	common	sched_setparam		sys_sched_setparam
+155	common	sched_getparam		sys_sched_getparam
+156	common	sched_setscheduler	sys_sched_setscheduler
+157	common	sched_getscheduler	sys_sched_getscheduler
+158	common	sched_yield		sys_sched_yield
+159	common	sched_get_priority_max	sys_sched_get_priority_max
+160	common	sched_get_priority_min	sys_sched_get_priority_min
+161	common	sched_rr_get_interval	sys_sched_rr_get_interval_time32
+162	common	nanosleep		sys_nanosleep_time32
+163	common	mremap			sys_mremap
+164	common	setresuid		sys_setresuid16
+165	common	getresuid		sys_getresuid16
+# 166 was sys_vm86
+# 167 was sys_query_module
+168	common	poll			sys_poll
+169	common	nfsservctl		sys_ni_syscall
+170	common	setresgid		sys_setresgid16
+171	common	getresgid		sys_getresgid16
+172	common	prctl			sys_prctl
+173	common	rt_sigreturn		sys_rt_sigreturn_wrapper	compat_sys_rt_sigreturn
+174	common	rt_sigaction		sys_rt_sigaction	compat_sys_rt_sigaction
+175	common	rt_sigprocmask		sys_rt_sigprocmask	compat_sys_rt_sigprocmask
+176	common	rt_sigpending		sys_rt_sigpending	compat_sys_rt_sigpending
+177	common	rt_sigtimedwait		sys_rt_sigtimedwait_time32	compat_sys_rt_sigtimedwait_time32
+178	common	rt_sigqueueinfo		sys_rt_sigqueueinfo	compat_sys_rt_sigqueueinfo
+179	common	rt_sigsuspend		sys_rt_sigsuspend	compat_sys_rt_sigsuspend
+180	common	pread64			sys_pread64		compat_sys_aarch32_pread64
+181	common	pwrite64		sys_pwrite64		compat_sys_aarch32_pwrite64
+182	common	chown			sys_chown16
+183	common	getcwd			sys_getcwd
+184	common	capget			sys_capget
+185	common	capset			sys_capset
+186	common	sigaltstack		sys_sigaltstack		compat_sys_sigaltstack
+187	common	sendfile		sys_sendfile		compat_sys_sendfile
+# 188 reserved
+# 189 reserved
+190	common	vfork			sys_vfork
+# SuS compliant getrlimit
+191	common	ugetrlimit		sys_getrlimit		compat_sys_getrlimit
+192	common	mmap2			sys_mmap2		compat_sys_aarch32_mmap2
+193	common	truncate64		sys_truncate64		compat_sys_aarch32_truncate64
+194	common	ftruncate64		sys_ftruncate64		compat_sys_aarch32_ftruncate64
+195	common	stat64			sys_stat64
+196	common	lstat64			sys_lstat64
+197	common	fstat64			sys_fstat64
+198	common	lchown32		sys_lchown
+199	common	getuid32		sys_getuid
+200	common	getgid32		sys_getgid
+201	common	geteuid32		sys_geteuid
+202	common	getegid32		sys_getegid
+203	common	setreuid32		sys_setreuid
+204	common	setregid32		sys_setregid
+205	common	getgroups32		sys_getgroups
+206	common	setgroups32		sys_setgroups
+207	common	fchown32		sys_fchown
+208	common	setresuid32		sys_setresuid
+209	common	getresuid32		sys_getresuid
+210	common	setresgid32		sys_setresgid
+211	common	getresgid32		sys_getresgid
+212	common	chown32			sys_chown
+213	common	setuid32		sys_setuid
+214	common	setgid32		sys_setgid
+215	common	setfsuid32		sys_setfsuid
+216	common	setfsgid32		sys_setfsgid
+217	common	getdents64		sys_getdents64
+218	common	pivot_root		sys_pivot_root
+219	common	mincore			sys_mincore
+220	common	madvise			sys_madvise
+221	common	fcntl64			sys_fcntl64		compat_sys_fcntl64
+# 222 for tux
+# 223 is unused
+224	common	gettid			sys_gettid
+225	common	readahead		sys_readahead		compat_sys_aarch32_readahead
+226	common	setxattr		sys_setxattr
+227	common	lsetxattr		sys_lsetxattr
+228	common	fsetxattr		sys_fsetxattr
+229	common	getxattr		sys_getxattr
+230	common	lgetxattr		sys_lgetxattr
+231	common	fgetxattr		sys_fgetxattr
+232	common	listxattr		sys_listxattr
+233	common	llistxattr		sys_llistxattr
+234	common	flistxattr		sys_flistxattr
+235	common	removexattr		sys_removexattr
+236	common	lremovexattr		sys_lremovexattr
+237	common	fremovexattr		sys_fremovexattr
+238	common	tkill			sys_tkill
+239	common	sendfile64		sys_sendfile64
+240	common	futex			sys_futex_time32
+241	common	sched_setaffinity	sys_sched_setaffinity	compat_sys_sched_setaffinity
+242	common	sched_getaffinity	sys_sched_getaffinity	compat_sys_sched_getaffinity
+243	common	io_setup		sys_io_setup		compat_sys_io_setup
+244	common	io_destroy		sys_io_destroy
+245	common	io_getevents		sys_io_getevents_time32
+246	common	io_submit		sys_io_submit		compat_sys_io_submit
+247	common	io_cancel		sys_io_cancel
+248	common	exit_group		sys_exit_group
+249	common	lookup_dcookie		sys_ni_syscall
+250	common	epoll_create		sys_epoll_create
+251	common	epoll_ctl		sys_epoll_ctl
+252	common	epoll_wait		sys_epoll_wait
+253	common	remap_file_pages	sys_remap_file_pages
+# 254 for set_thread_area
+# 255 for get_thread_area
+256	common	set_tid_address		sys_set_tid_address
+257	common	timer_create		sys_timer_create	compat_sys_timer_create
+258	common	timer_settime		sys_timer_settime32
+259	common	timer_gettime		sys_timer_gettime32
+260	common	timer_getoverrun	sys_timer_getoverrun
+261	common	timer_delete		sys_timer_delete
+262	common	clock_settime		sys_clock_settime32
+263	common	clock_gettime		sys_clock_gettime32
+264	common	clock_getres		sys_clock_getres_time32
+265	common	clock_nanosleep		sys_clock_nanosleep_time32
+266	common	statfs64		sys_statfs64_wrapper	compat_sys_aarch32_statfs64
+267	common	fstatfs64		sys_fstatfs64_wrapper	compat_sys_aarch32_fstatfs64
+268	common	tgkill			sys_tgkill
+269	common	utimes			sys_utimes_time32
+270	common	arm_fadvise64_64	sys_arm_fadvise64_64	compat_sys_aarch32_fadvise64_64
+271	common	pciconfig_iobase	sys_pciconfig_iobase
+272	common	pciconfig_read		sys_pciconfig_read
+273	common	pciconfig_write		sys_pciconfig_write
+274	common	mq_open			sys_mq_open		compat_sys_mq_open
+275	common	mq_unlink		sys_mq_unlink
+276	common	mq_timedsend		sys_mq_timedsend_time32
+277	common	mq_timedreceive		sys_mq_timedreceive_time32
+278	common	mq_notify		sys_mq_notify		compat_sys_mq_notify
+279	common	mq_getsetattr		sys_mq_getsetattr	compat_sys_mq_getsetattr
+280	common	waitid			sys_waitid		compat_sys_waitid
+281	common	socket			sys_socket
+282	common	bind			sys_bind
+283	common	connect			sys_connect
+284	common	listen			sys_listen
+285	common	accept			sys_accept
+286	common	getsockname		sys_getsockname
+287	common	getpeername		sys_getpeername
+288	common	socketpair		sys_socketpair
+289	common	send			sys_send
+290	common	sendto			sys_sendto
+291	common	recv			sys_recv		compat_sys_recv
+292	common	recvfrom		sys_recvfrom		compat_sys_recvfrom
+293	common	shutdown		sys_shutdown
+294	common	setsockopt		sys_setsockopt
+295	common	getsockopt		sys_getsockopt
+296	common	sendmsg			sys_sendmsg		compat_sys_sendmsg
+297	common	recvmsg			sys_recvmsg		compat_sys_recvmsg
+298	common	semop			sys_semop
+299	common	semget			sys_semget
+300	common	semctl			sys_old_semctl		compat_sys_old_semctl
+301	common	msgsnd			sys_msgsnd		compat_sys_msgsnd
+302	common	msgrcv			sys_msgrcv		compat_sys_msgrcv
+303	common	msgget			sys_msgget
+304	common	msgctl			sys_old_msgctl		compat_sys_old_msgctl
+305	common	shmat			sys_shmat		compat_sys_shmat
+306	common	shmdt			sys_shmdt
+307	common	shmget			sys_shmget
+308	common	shmctl			sys_old_shmctl		compat_sys_old_shmctl
+309	common	add_key			sys_add_key
+310	common	request_key		sys_request_key
+311	common	keyctl			sys_keyctl		compat_sys_keyctl
+312	common	semtimedop		sys_semtimedop_time32
+313	common	vserver			sys_ni_syscall
+314	common	ioprio_set		sys_ioprio_set
+315	common	ioprio_get		sys_ioprio_get
+316	common	inotify_init		sys_inotify_init
+317	common	inotify_add_watch	sys_inotify_add_watch
+318	common	inotify_rm_watch	sys_inotify_rm_watch
+319	common	mbind			sys_mbind
+320	common	get_mempolicy		sys_get_mempolicy
+321	common	set_mempolicy		sys_set_mempolicy
+322	common	openat			sys_openat		compat_sys_openat
+323	common	mkdirat			sys_mkdirat
+324	common	mknodat			sys_mknodat
+325	common	fchownat		sys_fchownat
+326	common	futimesat		sys_futimesat_time32
+327	common	fstatat64		sys_fstatat64
+328	common	unlinkat		sys_unlinkat
+329	common	renameat		sys_renameat
+330	common	linkat			sys_linkat
+331	common	symlinkat		sys_symlinkat
+332	common	readlinkat		sys_readlinkat
+333	common	fchmodat		sys_fchmodat
+334	common	faccessat		sys_faccessat
+335	common	pselect6		sys_pselect6_time32	compat_sys_pselect6_time32
+336	common	ppoll			sys_ppoll_time32	compat_sys_ppoll_time32
+337	common	unshare			sys_unshare
+338	common	set_robust_list		sys_set_robust_list	compat_sys_set_robust_list
+339	common	get_robust_list		sys_get_robust_list	compat_sys_get_robust_list
+340	common	splice			sys_splice
+341	common	arm_sync_file_range	sys_sync_file_range2	compat_sys_aarch32_sync_file_range2
+342	common	tee			sys_tee
+343	common	vmsplice		sys_vmsplice
+344	common	move_pages		sys_move_pages
+345	common	getcpu			sys_getcpu
+346	common	epoll_pwait		sys_epoll_pwait		compat_sys_epoll_pwait
+347	common	kexec_load		sys_kexec_load		compat_sys_kexec_load
+348	common	utimensat		sys_utimensat_time32
+349	common	signalfd		sys_signalfd		compat_sys_signalfd
+350	common	timerfd_create		sys_timerfd_create
+351	common	eventfd			sys_eventfd
+352	common	fallocate		sys_fallocate		compat_sys_aarch32_fallocate
+353	common	timerfd_settime		sys_timerfd_settime32
+354	common	timerfd_gettime		sys_timerfd_gettime32
+355	common	signalfd4		sys_signalfd4		compat_sys_signalfd4
+356	common	eventfd2		sys_eventfd2
+357	common	epoll_create1		sys_epoll_create1
+358	common	dup3			sys_dup3
+359	common	pipe2			sys_pipe2
+360	common	inotify_init1		sys_inotify_init1
+361	common	preadv			sys_preadv		compat_sys_preadv
+362	common	pwritev			sys_pwritev		compat_sys_pwritev
+363	common	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo	compat_sys_rt_tgsigqueueinfo
+364	common	perf_event_open		sys_perf_event_open
+365	common	recvmmsg		sys_recvmmsg_time32	compat_sys_recvmmsg_time32
+366	common	accept4			sys_accept4
+367	common	fanotify_init		sys_fanotify_init
+368	common	fanotify_mark		sys_fanotify_mark	compat_sys_fanotify_mark
+369	common	prlimit64		sys_prlimit64
+370	common	name_to_handle_at	sys_name_to_handle_at
+371	common	open_by_handle_at	sys_open_by_handle_at	compat_sys_open_by_handle_at
+372	common	clock_adjtime		sys_clock_adjtime32
+373	common	syncfs			sys_syncfs
+374	common	sendmmsg		sys_sendmmsg		compat_sys_sendmmsg
+375	common	setns			sys_setns
+376	common	process_vm_readv	sys_process_vm_readv
+377	common	process_vm_writev	sys_process_vm_writev
+378	common	kcmp			sys_kcmp
+379	common	finit_module		sys_finit_module
+380	common	sched_setattr		sys_sched_setattr
+381	common	sched_getattr		sys_sched_getattr
+382	common	renameat2		sys_renameat2
+383	common	seccomp			sys_seccomp
+384	common	getrandom		sys_getrandom
+385	common	memfd_create		sys_memfd_create
+386	common	bpf			sys_bpf
+387	common	execveat		sys_execveat		compat_sys_execveat
+388	common	userfaultfd		sys_userfaultfd
+389	common	membarrier		sys_membarrier
+390	common	mlock2			sys_mlock2
+391	common	copy_file_range		sys_copy_file_range
+392	common	preadv2			sys_preadv2		compat_sys_preadv2
+393	common	pwritev2		sys_pwritev2		compat_sys_pwritev2
+394	common	pkey_mprotect		sys_pkey_mprotect
+395	common	pkey_alloc		sys_pkey_alloc
+396	common	pkey_free		sys_pkey_free
+397	common	statx			sys_statx
+398	common	rseq			sys_rseq
+399	common	io_pgetevents		sys_io_pgetevents_time32	compat_sys_io_pgetevents
+400	common	migrate_pages		sys_migrate_pages
+401	common	kexec_file_load		sys_kexec_file_load
+# 402 is unused
+403	common	clock_gettime64			sys_clock_gettime
+404	common	clock_settime64			sys_clock_settime
+405	common	clock_adjtime64			sys_clock_adjtime
+406	common	clock_getres_time64		sys_clock_getres
+407	common	clock_nanosleep_time64		sys_clock_nanosleep
+408	common	timer_gettime64			sys_timer_gettime
+409	common	timer_settime64			sys_timer_settime
+410	common	timerfd_gettime64		sys_timerfd_gettime
+411	common	timerfd_settime64		sys_timerfd_settime
+412	common	utimensat_time64		sys_utimensat
+413	common	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
+414	common	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
+416	common	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
+417	common	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
+418	common	mq_timedsend_time64		sys_mq_timedsend
+419	common	mq_timedreceive_time64		sys_mq_timedreceive
+420	common	semtimedop_time64		sys_semtimedop
+421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
+422	common	futex_time64			sys_futex
+423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
+428	common	open_tree			sys_open_tree
+429	common	move_mount			sys_move_mount
+430	common	fsopen				sys_fsopen
+431	common	fsconfig			sys_fsconfig
+432	common	fsmount				sys_fsmount
+433	common	fspick				sys_fspick
+434	common	pidfd_open			sys_pidfd_open
+435	common	clone3				sys_clone3
+436	common	close_range			sys_close_range
+437	common	openat2				sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
+440	common	process_madvise			sys_process_madvise
+441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
+443	common	quotactl_fd			sys_quotactl_fd
+444	common	landlock_create_ruleset		sys_landlock_create_ruleset
+445	common	landlock_add_rule		sys_landlock_add_rule
+446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
+449	common	futex_waitv			sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
+452	common	fchmodat2			sys_fchmodat2
+453	common	map_shadow_stack		sys_map_shadow_stack
+454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
+457	common	statmount			sys_statmount
+458	common	listmount			sys_listmount
+459	common	lsm_get_self_attr		sys_lsm_get_self_attr
+460	common	lsm_set_self_attr		sys_lsm_set_self_attr
+461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal				sys_mseal
-- 
2.39.2


