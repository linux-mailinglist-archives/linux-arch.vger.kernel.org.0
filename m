Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353652A2AC3
	for <lists+linux-arch@lfdr.de>; Mon,  2 Nov 2020 13:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgKBMcl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Nov 2020 07:32:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728863AbgKBMcg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 2 Nov 2020 07:32:36 -0500
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C25A2242F;
        Mon,  2 Nov 2020 12:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604320353;
        bh=5W2Zvi8titKaenA3gFcqby+Kk7fj/3jloTaM6Atu/do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ow7IxHxZsFwascdxhV5wCtvxEQsdD1EfHvvEnKjOL0vJKNzqWSU28XOFxSkpirsoA
         fAZl6jKfQcWJzqVyMGx/KzrP9+nfgEFlJDVkH8RjPmmlW9rfDk/qAlly29oPQXcq5t
         4YTs44wMw5pFgjtUN2Jg5Hsz00mgxBcpHbamd0uw=
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [PATCH v2 4/4] compat: remove some compat entry points
Date:   Mon,  2 Nov 2020 13:31:51 +0100
Message-Id: <20201102123151.2860165-5-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201102123151.2860165-1-arnd@kernel.org>
References: <20201102123151.2860165-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

These are all handled correctly when calling the native
system call entry point, so remove the special cases.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/unistd32.h         | 12 ++++----
 arch/mips/kernel/syscalls/syscall_n32.tbl | 12 ++++----
 arch/mips/kernel/syscalls/syscall_o32.tbl | 12 ++++----
 arch/parisc/kernel/syscalls/syscall.tbl   | 10 +++---
 arch/powerpc/kernel/syscalls/syscall.tbl  | 12 ++++----
 arch/s390/kernel/syscalls/syscall.tbl     | 12 ++++----
 arch/sparc/kernel/syscalls/syscall.tbl    | 12 ++++----
 arch/x86/entry/syscall_x32.c              |  2 ++
 arch/x86/entry/syscalls/syscall_32.tbl    |  6 ++--
 arch/x86/entry/syscalls/syscall_64.tbl    |  4 +--
 include/linux/compat.h                    | 26 ----------------
 include/uapi/asm-generic/unistd.h         | 12 ++++----
 kernel/kexec.c                            | 23 ++------------
 kernel/sys_ni.c                           |  5 ---
 mm/mempolicy.c                            | 37 -----------------------
 mm/migrate.c                              | 13 --------
 16 files changed, 56 insertions(+), 154 deletions(-)

diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 107f08e03b9f..25ae90737207 100644
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
@@ -699,13 +699,13 @@ __SYSCALL(__NR_tee, sys_tee)
 #define __NR_vmsplice 343
 __SYSCALL(__NR_vmsplice, sys_vmsplice)
 #define __NR_move_pages 344
-__SYSCALL(__NR_move_pages, compat_sys_move_pages)
+__SYSCALL(__NR_move_pages, sys_move_pages)
 #define __NR_getcpu 345
 __SYSCALL(__NR_getcpu, sys_getcpu)
 #define __NR_epoll_pwait 346
 __SYSCALL(__NR_epoll_pwait, compat_sys_epoll_pwait)
 #define __NR_kexec_load 347
-__SYSCALL(__NR_kexec_load, compat_sys_kexec_load)
+__SYSCALL(__NR_kexec_load, sys_kexec_load)
 #define __NR_utimensat 348
 __SYSCALL(__NR_utimensat, sys_utimensat_time32)
 #define __NR_signalfd 349
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
index 32817c954435..fe1ce23b8e57 100644
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
@@ -279,10 +279,10 @@
 268	n32	sync_file_range			sys_sync_file_range
 269	n32	tee				sys_tee
 270	n32	vmsplice			sys_vmsplice
-271	n32	move_pages			compat_sys_move_pages
+271	n32	move_pages			sys_move_pages
 272	n32	set_robust_list			compat_sys_set_robust_list
 273	n32	get_robust_list			compat_sys_get_robust_list
-274	n32	kexec_load			compat_sys_kexec_load
+274	n32	kexec_load			sys_kexec_load
 275	n32	getcpu				sys_getcpu
 276	n32	epoll_pwait			compat_sys_epoll_pwait
 277	n32	ioprio_set			sys_ioprio_set
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 29f5f28cf5ce..96982414890f 100644
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
@@ -319,10 +319,10 @@
 305	o32	sync_file_range			sys_sync_file_range		sys32_sync_file_range
 306	o32	tee				sys_tee
 307	o32	vmsplice			sys_vmsplice
-308	o32	move_pages			sys_move_pages			compat_sys_move_pages
+308	o32	move_pages			sys_move_pages
 309	o32	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
 310	o32	get_robust_list			sys_get_robust_list		compat_sys_get_robust_list
-311	o32	kexec_load			sys_kexec_load			compat_sys_kexec_load
+311	o32	kexec_load			sys_kexec_load
 312	o32	getcpu				sys_getcpu
 313	o32	epoll_pwait			sys_epoll_pwait			compat_sys_epoll_pwait
 314	o32	ioprio_set			sys_ioprio_set
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index f375ea528e59..fe5ca85a0598 100644
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
@@ -331,12 +331,12 @@
 292	64	sync_file_range		sys_sync_file_range
 293	common	tee			sys_tee
 294	common	vmsplice		sys_vmsplice
-295	common	move_pages		sys_move_pages			compat_sys_move_pages
+295	common	move_pages		sys_move_pages
 296	common	getcpu			sys_getcpu
 297	common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
 298	common	statfs64		sys_statfs64			compat_sys_statfs64
 299	common	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
-300	common	kexec_load		sys_kexec_load			compat_sys_kexec_load
+300	common	kexec_load		sys_kexec_load
 301	32	utimensat		sys_utimensat_time32
 301	64	utimensat		sys_utimensat
 302	common	signalfd		sys_signalfd			compat_sys_signalfd
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 1275daec7fec..8e2cce038adc 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -338,10 +338,10 @@
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
@@ -350,7 +350,7 @@
 265	64	mq_timedreceive			sys_mq_timedreceive
 266	nospu	mq_notify			sys_mq_notify			compat_sys_mq_notify
 267	nospu	mq_getsetattr			sys_mq_getsetattr		compat_sys_mq_getsetattr
-268	nospu	kexec_load			sys_kexec_load			compat_sys_kexec_load
+268	nospu	kexec_load			sys_kexec_load
 269	nospu	add_key				sys_add_key
 270	nospu	request_key			sys_request_key
 271	nospu	keyctl				sys_keyctl			compat_sys_keyctl
@@ -389,7 +389,7 @@
 298	common	faccessat			sys_faccessat
 299	common	get_robust_list			sys_get_robust_list		compat_sys_get_robust_list
 300	common	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
-301	common	move_pages			sys_move_pages			compat_sys_move_pages
+301	common	move_pages			sys_move_pages
 302	common	getcpu				sys_getcpu
 303	nospu	epoll_pwait			sys_epoll_pwait			compat_sys_epoll_pwait
 304	32	utimensat			sys_utimensat_time32
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 28c168000483..2147a1e59165 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -274,16 +274,16 @@
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
 274  common	mq_timedreceive		sys_mq_timedreceive		sys_mq_timedreceive_time32
 275  common	mq_notify		sys_mq_notify			compat_sys_mq_notify
 276  common	mq_getsetattr		sys_mq_getsetattr		compat_sys_mq_getsetattr
-277  common	kexec_load		sys_kexec_load			compat_sys_kexec_load
+277  common	kexec_load		sys_kexec_load			sys_kexec_load
 278  common	add_key			sys_add_key			sys_add_key
 279  common	request_key		sys_request_key			sys_request_key
 280  common	keyctl			sys_keyctl			compat_sys_keyctl
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
index 78160260991b..522555e5f4a3 100644
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
-306	common	kexec_load		sys_kexec_load			compat_sys_kexec_load
-307	common	move_pages		sys_move_pages			compat_sys_move_pages
+302	common	migrate_pages		sys_migrate_pages
+303	common	mbind			sys_mbind
+304	common	get_mempolicy		sys_get_mempolicy
+305	common	set_mempolicy		sys_set_mempolicy
+306	common	kexec_load		sys_kexec_load
+307	common	move_pages		sys_move_pages
 308	common	getcpu			sys_getcpu
 309	common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
 310	32	utimensat		sys_utimensat_time32
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index f2fe0a33bcfd..921473281497 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -19,6 +19,8 @@
 #define __x32_sys_vmsplice	__x64_sys_vmsplice
 #define __x32_sys_process_vm_readv	__x64_sys_process_vm_readv
 #define __x32_sys_process_vm_writev	__x64_sys_process_vm_writev
+#define __x32_sys_kexec_load	__x64_sys_kexec_load
+#define __x32_sys_move_pages	__x64_sys_move_pages
 
 #define __SYSCALL_64(nr, sym)
 
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 0d0667a9fbd7..e6a8bec0d6a5 100644
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
@@ -294,7 +294,7 @@
 280	i386	mq_timedreceive		sys_mq_timedreceive_time32
 281	i386	mq_notify		sys_mq_notify			compat_sys_mq_notify
 282	i386	mq_getsetattr		sys_mq_getsetattr		compat_sys_mq_getsetattr
-283	i386	kexec_load		sys_kexec_load			compat_sys_kexec_load
+283	i386	kexec_load		sys_kexec_load
 284	i386	waitid			sys_waitid			compat_sys_waitid
 # 285 sys_setaltroot
 286	i386	add_key			sys_add_key
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
index 1f47e24fb65c..930fe4821fe8 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -385,12 +385,12 @@
 525	x32	sigaltstack		compat_sys_sigaltstack
 526	x32	timer_create		compat_sys_timer_create
 527	x32	mq_notify		compat_sys_mq_notify
-528	x32	kexec_load		compat_sys_kexec_load
+528	x32	kexec_load		sys_kexec_load
 529	x32	waitid			compat_sys_waitid
 530	x32	set_robust_list		compat_sys_set_robust_list
 531	x32	get_robust_list		compat_sys_get_robust_list
 532	x32	vmsplice		sys_vmsplice
-533	x32	move_pages		compat_sys_move_pages
+533	x32	move_pages		sys_move_pages
 534	x32	preadv			compat_sys_preadv64
 535	x32	pwritev			compat_sys_pwritev64
 536	x32	rt_tgsigqueueinfo	compat_sys_rt_tgsigqueueinfo
diff --git a/include/linux/compat.h b/include/linux/compat.h
index cd306889b35c..47496c5eb5eb 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -623,12 +623,6 @@ asmlinkage long compat_sys_setitimer(int which,
 				     struct old_itimerval32 __user *in,
 				     struct old_itimerval32 __user *out);
 
-/* kernel/kexec.c */
-asmlinkage long compat_sys_kexec_load(compat_ulong_t entry,
-				      compat_ulong_t nr_segments,
-				      struct compat_kexec_segment __user *,
-				      compat_ulong_t flags);
-
 /* kernel/posix-timers.c */
 asmlinkage long compat_sys_timer_create(clockid_t which_clock,
 			struct compat_sigevent __user *timer_event_spec,
@@ -735,26 +729,6 @@ asmlinkage long compat_sys_execve(const char __user *filename, const compat_uptr
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
index 2056318988f7..2e9662aa1194 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -342,7 +342,7 @@ __SC_COMP(__NR_setitimer, sys_setitimer, compat_sys_setitimer)
 
 /* kernel/kexec.c */
 #define __NR_kexec_load 104
-__SC_COMP(__NR_kexec_load, sys_kexec_load, compat_sys_kexec_load)
+__SYSCALL(__NR_kexec_load, sys_kexec_load)
 
 /* kernel/module.c */
 #define __NR_init_module 105
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
diff --git a/kernel/kexec.c b/kernel/kexec.c
index ec04791eea3e..07a5d089ead0 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -258,9 +258,8 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	return 0;
 }
 
-static int kernel_kexec_load(unsigned long entry, unsigned long nr_segments,
-			     struct kexec_segment __user * segments,
-			     unsigned long flags)
+SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
+		struct kexec_segment __user *, segments, unsigned long, flags)
 {
 	int result;
 
@@ -290,21 +289,3 @@ static int kernel_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 	return result;
 }
-
-SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
-		struct kexec_segment __user *, segments, unsigned long, flags)
-{
-	return kernel_kexec_load(entry, nr_segments, segments, flags);
-}
-
-#ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
-		       compat_ulong_t, nr_segments,
-		       struct compat_kexec_segment __user *, segments,
-		       compat_ulong_t, flags)
-{
-	return kernel_kexec_load(entry, nr_segments,
-				 (struct kexec_segment __user *)segments,
-				 flags);
-}
-#endif
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index f27ac94d5fa7..4d8c314b061f 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -283,15 +283,10 @@ COND_SYSCALL(madvise);
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
index fb5e533667f6..ffe789c24773 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1643,43 +1643,6 @@ SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
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
index 016e39809ca5..6ba240012b08 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1977,19 +1977,6 @@ SYSCALL_DEFINE6(move_pages, pid_t, pid, unsigned long, nr_pages,
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
2.27.0

