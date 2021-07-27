Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AD33D78E5
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 16:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbhG0Ouz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 10:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236885AbhG0Otz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Jul 2021 10:49:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E17B061B1C;
        Tue, 27 Jul 2021 14:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627397389;
        bh=X2nOSkrct+//jg3b+OT1UZgDOHMaIVr8tgJbcn/ga38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V+WiBM2iDbed3S1lXCoei/5xc4g9DGGgtA7pQH+Qt2I0K75Zf9pW+nLnvSJsmWMsn
         OtUgqYRzsktYPf4ptO3uAEHupQ2j2Z1LvZBuQEODEo+wbREcD7QmyNFaanGzy3VxIV
         qXyX7Gh68Yb0a28bx83e5+ssQh+AUZ53tPzxV/dbN1rt4A+0GeykrotU+na3SJyyRW
         2d70Pt+1i2MspZipYViyOKhxjJNQXobIIeBDDO/VX+l2Gq/SuZxDfMRgikY+zCVCOI
         IMWAyiJbdJVI+ssjiefmVwFlPzpb42f3pr1v9jBJxkzz6xU92ZoqmRjL4HMdaQG0d6
         XWAUl2F/L1O4Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christoph Hellwig <hch@infradead.org>,
        Feng Tang <feng.tang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 5/6] compat: remove some compat entry points
Date:   Tue, 27 Jul 2021 16:48:58 +0200
Message-Id: <20210727144859.4150043-6-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210727144859.4150043-1-arnd@kernel.org>
References: <20210727144859.4150043-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

These are all handled correctly when calling the native
system call entry point, so remove the special cases.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/unistd32.h         | 10 +++---
 arch/mips/kernel/syscalls/syscall_n32.tbl | 10 +++---
 arch/mips/kernel/syscalls/syscall_o32.tbl | 10 +++---
 arch/parisc/kernel/syscalls/syscall.tbl   |  8 ++---
 arch/powerpc/kernel/syscalls/syscall.tbl  | 10 +++---
 arch/s390/kernel/syscalls/syscall.tbl     | 10 +++---
 arch/sparc/kernel/syscalls/syscall.tbl    | 10 +++---
 arch/x86/entry/syscalls/syscall_32.tbl    |  4 +--
 arch/x86/entry/syscalls/syscall_64.tbl    |  2 +-
 include/linux/compat.h                    | 20 ------------
 include/uapi/asm-generic/unistd.h         | 10 +++---
 kernel/sys_ni.c                           |  5 ---
 mm/mempolicy.c                            | 37 -----------------------
 mm/migrate.c                              | 13 --------
 14 files changed, 42 insertions(+), 117 deletions(-)

diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 99ffcafc736c..8a5cf6daf7c0 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -649,11 +649,11 @@ __SYSCALL(__NR_inotify_add_watch, sys_inotify_add_watch)
 #define __NR_inotify_rm_watch 318
 __SYSCALL(__NR_inotify_rm_watch, sys_inotify_rm_watch)
 #define __NR_mbind 319
-__SYSCALL(__NR_mbind, compat_sys_mbind)
+__SYSCALL(__NR_mbind, sys_mbind)
 #define __NR_get_mempolicy 320
-__SYSCALL(__NR_get_mempolicy, compat_sys_get_mempolicy)
+__SYSCALL(__NR_get_mempolicy, sys_get_mempolicy)
 #define __NR_set_mempolicy 321
-__SYSCALL(__NR_set_mempolicy, compat_sys_set_mempolicy)
+__SYSCALL(__NR_set_mempolicy, sys_set_mempolicy)
 #define __NR_openat 322
 __SYSCALL(__NR_openat, compat_sys_openat)
 #define __NR_mkdirat 323
@@ -699,7 +699,7 @@ __SYSCALL(__NR_tee, sys_tee)
 #define __NR_vmsplice 343
 __SYSCALL(__NR_vmsplice, sys_vmsplice)
 #define __NR_move_pages 344
-__SYSCALL(__NR_move_pages, compat_sys_move_pages)
+__SYSCALL(__NR_move_pages, sys_move_pages)
 #define __NR_getcpu 345
 __SYSCALL(__NR_getcpu, sys_getcpu)
 #define __NR_epoll_pwait 346
@@ -811,7 +811,7 @@ __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_io_pgetevents 399
 __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
 #define __NR_migrate_pages 400
-__SYSCALL(__NR_migrate_pages, compat_sys_migrate_pages)
+__SYSCALL(__NR_migrate_pages, sys_migrate_pages)
 #define __NR_kexec_file_load 401
 __SYSCALL(__NR_kexec_file_load, sys_kexec_file_load)
 /* 402 is unused */
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index c2d2e19abea8..c42378dbb1c2 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -239,9 +239,9 @@
 228	n32	clock_nanosleep			sys_clock_nanosleep_time32
 229	n32	tgkill				sys_tgkill
 230	n32	utimes				sys_utimes_time32
-231	n32	mbind				compat_sys_mbind
-232	n32	get_mempolicy			compat_sys_get_mempolicy
-233	n32	set_mempolicy			compat_sys_set_mempolicy
+231	n32	mbind				sys_mbind
+232	n32	get_mempolicy			sys_get_mempolicy
+233	n32	set_mempolicy			sys_set_mempolicy
 234	n32	mq_open				compat_sys_mq_open
 235	n32	mq_unlink			sys_mq_unlink
 236	n32	mq_timedsend			sys_mq_timedsend_time32
@@ -258,7 +258,7 @@
 247	n32	inotify_init			sys_inotify_init
 248	n32	inotify_add_watch		sys_inotify_add_watch
 249	n32	inotify_rm_watch		sys_inotify_rm_watch
-250	n32	migrate_pages			compat_sys_migrate_pages
+250	n32	migrate_pages			sys_migrate_pages
 251	n32	openat				sys_openat
 252	n32	mkdirat				sys_mkdirat
 253	n32	mknodat				sys_mknodat
@@ -279,7 +279,7 @@
 268	n32	sync_file_range			sys_sync_file_range
 269	n32	tee				sys_tee
 270	n32	vmsplice			sys_vmsplice
-271	n32	move_pages			compat_sys_move_pages
+271	n32	move_pages			sys_move_pages
 272	n32	set_robust_list			compat_sys_set_robust_list
 273	n32	get_robust_list			compat_sys_get_robust_list
 274	n32	kexec_load			compat_sys_kexec_load
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 253f2cd70b6b..5ff8ef9d8a04 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -279,9 +279,9 @@
 265	o32	clock_nanosleep			sys_clock_nanosleep_time32
 266	o32	tgkill				sys_tgkill
 267	o32	utimes				sys_utimes_time32
-268	o32	mbind				sys_mbind			compat_sys_mbind
-269	o32	get_mempolicy			sys_get_mempolicy		compat_sys_get_mempolicy
-270	o32	set_mempolicy			sys_set_mempolicy		compat_sys_set_mempolicy
+268	o32	mbind				sys_mbind
+269	o32	get_mempolicy			sys_get_mempolicy
+270	o32	set_mempolicy			sys_set_mempolicy
 271	o32	mq_open				sys_mq_open			compat_sys_mq_open
 272	o32	mq_unlink			sys_mq_unlink
 273	o32	mq_timedsend			sys_mq_timedsend_time32
@@ -298,7 +298,7 @@
 284	o32	inotify_init			sys_inotify_init
 285	o32	inotify_add_watch		sys_inotify_add_watch
 286	o32	inotify_rm_watch		sys_inotify_rm_watch
-287	o32	migrate_pages			sys_migrate_pages		compat_sys_migrate_pages
+287	o32	migrate_pages			sys_migrate_pages
 288	o32	openat				sys_openat			compat_sys_openat
 289	o32	mkdirat				sys_mkdirat
 290	o32	mknodat				sys_mknodat
@@ -319,7 +319,7 @@
 305	o32	sync_file_range			sys_sync_file_range		sys32_sync_file_range
 306	o32	tee				sys_tee
 307	o32	vmsplice			sys_vmsplice
-308	o32	move_pages			sys_move_pages			compat_sys_move_pages
+308	o32	move_pages			sys_move_pages
 309	o32	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
 310	o32	get_robust_list			sys_get_robust_list		compat_sys_get_robust_list
 311	o32	kexec_load			sys_kexec_load			compat_sys_kexec_load
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index e26187b9ab87..21be3d200e7b 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -292,9 +292,9 @@
 258	32	clock_nanosleep		sys_clock_nanosleep_time32
 258	64	clock_nanosleep		sys_clock_nanosleep
 259	common	tgkill			sys_tgkill
-260	common	mbind			sys_mbind			compat_sys_mbind
-261	common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
-262	common	set_mempolicy		sys_set_mempolicy		compat_sys_set_mempolicy
+260	common	mbind			sys_mbind
+261	common	get_mempolicy		sys_get_mempolicy
+262	common	set_mempolicy		sys_set_mempolicy
 # 263 was vserver
 264	common	add_key			sys_add_key
 265	common	request_key		sys_request_key
@@ -331,7 +331,7 @@
 292	64	sync_file_range		sys_sync_file_range
 293	common	tee			sys_tee
 294	common	vmsplice		sys_vmsplice
-295	common	move_pages		sys_move_pages			compat_sys_move_pages
+295	common	move_pages		sys_move_pages
 296	common	getcpu			sys_getcpu
 297	common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
 298	common	statfs64		sys_statfs64			compat_sys_statfs64
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index aef2a290e71a..9e237232d108 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -330,10 +330,10 @@
 256	64	sys_debug_setcontext		sys_ni_syscall
 256	spu	sys_debug_setcontext		sys_ni_syscall
 # 257 reserved for vserver
-258	nospu	migrate_pages			sys_migrate_pages		compat_sys_migrate_pages
-259	nospu	mbind				sys_mbind			compat_sys_mbind
-260	nospu	get_mempolicy			sys_get_mempolicy		compat_sys_get_mempolicy
-261	nospu	set_mempolicy			sys_set_mempolicy		compat_sys_set_mempolicy
+258	nospu	migrate_pages			sys_migrate_pages
+259	nospu	mbind				sys_mbind
+260	nospu	get_mempolicy			sys_get_mempolicy
+261	nospu	set_mempolicy			sys_set_mempolicy
 262	nospu	mq_open				sys_mq_open			compat_sys_mq_open
 263	nospu	mq_unlink			sys_mq_unlink
 264	32	mq_timedsend			sys_mq_timedsend_time32
@@ -381,7 +381,7 @@
 298	common	faccessat			sys_faccessat
 299	common	get_robust_list			sys_get_robust_list		compat_sys_get_robust_list
 300	common	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
-301	common	move_pages			sys_move_pages			compat_sys_move_pages
+301	common	move_pages			sys_move_pages
 302	common	getcpu				sys_getcpu
 303	nospu	epoll_pwait			sys_epoll_pwait			compat_sys_epoll_pwait
 304	32	utimensat			sys_utimensat_time32
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 64d51ab5a8b4..81bff2ffe6c0 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -274,9 +274,9 @@
 265  common	statfs64		sys_statfs64			compat_sys_statfs64
 266  common	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
 267  common	remap_file_pages	sys_remap_file_pages		sys_remap_file_pages
-268  common	mbind			sys_mbind			compat_sys_mbind
-269  common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
-270  common	set_mempolicy		sys_set_mempolicy		compat_sys_set_mempolicy
+268  common	mbind			sys_mbind			sys_mbind
+269  common	get_mempolicy		sys_get_mempolicy		sys_get_mempolicy
+270  common	set_mempolicy		sys_set_mempolicy		sys_set_mempolicy
 271  common	mq_open			sys_mq_open			compat_sys_mq_open
 272  common	mq_unlink		sys_mq_unlink			sys_mq_unlink
 273  common	mq_timedsend		sys_mq_timedsend		sys_mq_timedsend_time32
@@ -293,7 +293,7 @@
 284  common	inotify_init		sys_inotify_init		sys_inotify_init
 285  common	inotify_add_watch	sys_inotify_add_watch		sys_inotify_add_watch
 286  common	inotify_rm_watch	sys_inotify_rm_watch		sys_inotify_rm_watch
-287  common	migrate_pages		sys_migrate_pages		compat_sys_migrate_pages
+287  common	migrate_pages		sys_migrate_pages		sys_migrate_pages
 288  common	openat			sys_openat			compat_sys_openat
 289  common	mkdirat			sys_mkdirat			sys_mkdirat
 290  common	mknodat			sys_mknodat			sys_mknodat
@@ -317,7 +317,7 @@
 307  common	sync_file_range		sys_sync_file_range		compat_sys_s390_sync_file_range
 308  common	tee			sys_tee				sys_tee
 309  common	vmsplice		sys_vmsplice			sys_vmsplice
-310  common	move_pages		sys_move_pages			compat_sys_move_pages
+310  common	move_pages		sys_move_pages			sys_move_pages
 311  common	getcpu			sys_getcpu			sys_getcpu
 312  common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
 313  common	utimes			sys_utimes			sys_utimes_time32
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 603f5a821502..ea1660a933c0 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -365,12 +365,12 @@
 299	common	unshare			sys_unshare
 300	common	set_robust_list		sys_set_robust_list		compat_sys_set_robust_list
 301	common	get_robust_list		sys_get_robust_list		compat_sys_get_robust_list
-302	common	migrate_pages		sys_migrate_pages		compat_sys_migrate_pages
-303	common	mbind			sys_mbind			compat_sys_mbind
-304	common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
-305	common	set_mempolicy		sys_set_mempolicy		compat_sys_set_mempolicy
+302	common	migrate_pages		sys_migrate_pages
+303	common	mbind			sys_mbind
+304	common	get_mempolicy		sys_get_mempolicy
+305	common	set_mempolicy		sys_set_mempolicy
 306	common	kexec_load		sys_kexec_load			compat_sys_kexec_load
-307	common	move_pages		sys_move_pages			compat_sys_move_pages
+307	common	move_pages		sys_move_pages
 308	common	getcpu			sys_getcpu
 309	common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
 310	32	utimensat		sys_utimensat_time32
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ce763a12311c..f54c006603d6 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -286,7 +286,7 @@
 272	i386	fadvise64_64		sys_ia32_fadvise64_64
 273	i386	vserver
 274	i386	mbind			sys_mbind
-275	i386	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
+275	i386	get_mempolicy		sys_get_mempolicy
 276	i386	set_mempolicy		sys_set_mempolicy
 277	i386	mq_open			sys_mq_open			compat_sys_mq_open
 278	i386	mq_unlink		sys_mq_unlink
@@ -328,7 +328,7 @@
 314	i386	sync_file_range		sys_ia32_sync_file_range
 315	i386	tee			sys_tee
 316	i386	vmsplice		sys_vmsplice
-317	i386	move_pages		sys_move_pages			compat_sys_move_pages
+317	i386	move_pages		sys_move_pages
 318	i386	getcpu			sys_getcpu
 319	i386	epoll_pwait		sys_epoll_pwait
 320	i386	utimensat		sys_utimensat_time32
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f6b57799c1ea..f3dfb5b97e15 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -397,7 +397,7 @@
 530	x32	set_robust_list		compat_sys_set_robust_list
 531	x32	get_robust_list		compat_sys_get_robust_list
 532	x32	vmsplice		sys_vmsplice
-533	x32	move_pages		compat_sys_move_pages
+533	x32	move_pages		sys_move_pages
 534	x32	preadv			compat_sys_preadv64
 535	x32	pwritev			compat_sys_pwritev64
 536	x32	rt_tgsigqueueinfo	compat_sys_rt_tgsigqueueinfo
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 3a2ac5afee30..2d42cebd1fb8 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -799,26 +799,6 @@ asmlinkage long compat_sys_execve(const char __user *filename, const compat_uptr
 /* mm/fadvise.c: No generic prototype for fadvise64_64 */
 
 /* mm/, CONFIG_MMU only */
-asmlinkage long compat_sys_mbind(compat_ulong_t start, compat_ulong_t len,
-				 compat_ulong_t mode,
-				 compat_ulong_t __user *nmask,
-				 compat_ulong_t maxnode, compat_ulong_t flags);
-asmlinkage long compat_sys_get_mempolicy(int __user *policy,
-					 compat_ulong_t __user *nmask,
-					 compat_ulong_t maxnode,
-					 compat_ulong_t addr,
-					 compat_ulong_t flags);
-asmlinkage long compat_sys_set_mempolicy(int mode, compat_ulong_t __user *nmask,
-					 compat_ulong_t maxnode);
-asmlinkage long compat_sys_migrate_pages(compat_pid_t pid,
-		compat_ulong_t maxnode, const compat_ulong_t __user *old_nodes,
-		const compat_ulong_t __user *new_nodes);
-asmlinkage long compat_sys_move_pages(pid_t pid, compat_ulong_t nr_pages,
-				      __u32 __user *pages,
-				      const int __user *nodes,
-				      int __user *status,
-				      int flags);
-
 asmlinkage long compat_sys_rt_tgsigqueueinfo(compat_pid_t tgid,
 					compat_pid_t pid, int sig,
 					struct compat_siginfo __user *uinfo);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a9d6fcd95f42..cde0439913b4 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -673,15 +673,15 @@ __SYSCALL(__NR_madvise, sys_madvise)
 #define __NR_remap_file_pages 234
 __SYSCALL(__NR_remap_file_pages, sys_remap_file_pages)
 #define __NR_mbind 235
-__SC_COMP(__NR_mbind, sys_mbind, compat_sys_mbind)
+__SYSCALL(__NR_mbind, sys_mbind)
 #define __NR_get_mempolicy 236
-__SC_COMP(__NR_get_mempolicy, sys_get_mempolicy, compat_sys_get_mempolicy)
+__SYSCALL(__NR_get_mempolicy, sys_get_mempolicy)
 #define __NR_set_mempolicy 237
-__SC_COMP(__NR_set_mempolicy, sys_set_mempolicy, compat_sys_set_mempolicy)
+__SYSCALL(__NR_set_mempolicy, sys_set_mempolicy)
 #define __NR_migrate_pages 238
-__SC_COMP(__NR_migrate_pages, sys_migrate_pages, compat_sys_migrate_pages)
+__SYSCALL(__NR_migrate_pages, sys_migrate_pages)
 #define __NR_move_pages 239
-__SC_COMP(__NR_move_pages, sys_move_pages, compat_sys_move_pages)
+__SYSCALL(__NR_move_pages, sys_move_pages)
 #endif
 
 #define __NR_rt_tgsigqueueinfo 240
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 30971b1dd4a9..52c27ecf5ff7 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -291,15 +291,10 @@ COND_SYSCALL(madvise);
 COND_SYSCALL(process_madvise);
 COND_SYSCALL(remap_file_pages);
 COND_SYSCALL(mbind);
-COND_SYSCALL_COMPAT(mbind);
 COND_SYSCALL(get_mempolicy);
-COND_SYSCALL_COMPAT(get_mempolicy);
 COND_SYSCALL(set_mempolicy);
-COND_SYSCALL_COMPAT(set_mempolicy);
 COND_SYSCALL(migrate_pages);
-COND_SYSCALL_COMPAT(migrate_pages);
 COND_SYSCALL(move_pages);
-COND_SYSCALL_COMPAT(move_pages);
 
 COND_SYSCALL(perf_event_open);
 COND_SYSCALL(accept4);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 9bc5dabdb7a7..6fdfc8ab6770 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1647,43 +1647,6 @@ SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
 	return kernel_get_mempolicy(policy, nmask, maxnode, addr, flags);
 }
 
-#ifdef CONFIG_COMPAT
-
-COMPAT_SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
-		       compat_ulong_t __user *, nmask,
-		       compat_ulong_t, maxnode,
-		       compat_ulong_t, addr, compat_ulong_t, flags)
-{
-	return kernel_get_mempolicy(policy, (unsigned long __user *)nmask,
-				    maxnode, addr, flags);
-}
-
-COMPAT_SYSCALL_DEFINE3(set_mempolicy, int, mode, compat_ulong_t __user *, nmask,
-		       compat_ulong_t, maxnode)
-{
-	return kernel_set_mempolicy(mode, (unsigned long __user *)nmask, maxnode);
-}
-
-COMPAT_SYSCALL_DEFINE6(mbind, compat_ulong_t, start, compat_ulong_t, len,
-		       compat_ulong_t, mode, compat_ulong_t __user *, nmask,
-		       compat_ulong_t, maxnode, compat_ulong_t, flags)
-{
-	return kernel_mbind(start, len, mode, (unsigned long __user *)nmask,
-			    maxnode, flags);
-}
-
-COMPAT_SYSCALL_DEFINE4(migrate_pages, compat_pid_t, pid,
-		       compat_ulong_t, maxnode,
-		       const compat_ulong_t __user *, old_nodes,
-		       const compat_ulong_t __user *, new_nodes)
-{
-	return kernel_migrate_pages(pid, maxnode,
-				    (const unsigned long __user *)old_nodes,
-				    (const unsigned long __user *)new_nodes);
-}
-
-#endif /* CONFIG_COMPAT */
-
 bool vma_migratable(struct vm_area_struct *vma)
 {
 	if (vma->vm_flags & (VM_IO | VM_PFNMAP))
diff --git a/mm/migrate.c b/mm/migrate.c
index 60634d2653b9..266ae1837b6a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1967,19 +1967,6 @@ SYSCALL_DEFINE6(move_pages, pid_t, pid, unsigned long, nr_pages,
 	return kernel_move_pages(pid, nr_pages, pages, nodes, status, flags);
 }
 
-#ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE6(move_pages, pid_t, pid, compat_ulong_t, nr_pages,
-		       compat_uptr_t __user *, pages,
-		       const int __user *, nodes,
-		       int __user *, status,
-		       int, flags)
-{
-	return kernel_move_pages(pid, nr_pages,
-				 (const void __user *__user *)pages,
-				 nodes, status, flags);
-}
-#endif /* CONFIG_COMPAT */
-
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * Returns true if this is a safe migration target node for misplaced NUMA
-- 
2.29.2

