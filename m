Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F51326FE68
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 15:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgIRNZ4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 09:25:56 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:57539 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgIRNZz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 09:25:55 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MZSJa-1jwjJY2ZGQ-00WUcO; Fri, 18 Sep 2020 15:24:54 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        kexec@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4/4] mm: remove compat numa syscalls
Date:   Fri, 18 Sep 2020 15:24:39 +0200
Message-Id: <20200918132439.1475479-5-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200918132439.1475479-1-arnd@arndb.de>
References: <20200918132439.1475479-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gt/7jsO6Dyc7gK/yTYzO/EzJHFGXs7sJiuscLV4ApT8xDDd6BR9
 xkkLva8DnSsQvWGb64r6qawIdmrfuB5+sKA110qc4oiSR8/Y6hylhbEkpgD4lc2pELQUjnj
 PA9xWGNhRTO1GsOrmMNTC5oYCbourfPp8nbKfeoIWh/BgYYTKJ+R0Y1r9uFyUYusROoolCF
 1EyLfEwuv80mNrLk1y5aw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+N3o/UDh+UI=:gwlToYMW+N7V6XU9d1iNWb
 Qw5R4Sj5ufDtOMMLbew7YTjtBbHhTjfCVRgp3UYfdgvWeFhJYEXy6cwcuCH7XuEJCPLA20HWE
 E6ZwAfnRHiG4oTXvzyr++KNZhy5sm5AQQdzB6oON1guBXTOGxT7jmDBGZWMwMqad8HzyyaY30
 DLp+/bVvdsWrFx7PFkeA6qYJHapRLsXib4lOcdSJWD2kT3IgtHL+Rjsg7bs1VbYXe2UkpeC+d
 LB9zj97Oh2gNBy+jQWjRcAASd2EkA8mIKXCj/TmcZpKp6h46EJF9T+KV14ucfFgmRqbtklIX5
 yefY+ZcR9l5OlAvQLmuAxalbipHQ5yvl7B9K1zX85Hk5/dcZGoKGyJgVc7+C0fWtgIpR8aYl9
 n2WtttPZy7EnbJf1juCTiBvi4b8JisgiI197//DCiqpgcgyovNzFBJpGOKEtL3b45Tb/dA0Rp
 im+KfSdjjGlOWOLyi20lawtfpok0RSfOPTqfGueesiaYYA0qoRPQN06PfxyRjPxU1xQ6tC6cx
 KEGbLVJ85A7SB/RxI2NK9hdcHTjdTjhvLEzqOk4mrcY3ye7wMlr8MUcCrseXaMO4Mn5F6Uccb
 K+PJp56yH1CMp+gCQwA52ShcOi6XyY1H3043DYFITBx5UAXNg/59vlq5+lP8VNjS9YilzR+oF
 5PfxPVNyVbmwWxd5fhKoe+1OAB8mCathrxGbygZgdh7Ufx4Q2NSNmjRYbKSYgIw78wjqSLD1c
 RTOtF7Q5eLkG2LZT9ZYd5sUPnmxYS+rc2Cc6sB8eToQJ+/lgMD+9YRvdqFrYkYOXWF+Ja7Vvk
 WI47Jq6IWHAtU0+Kq16pLXmLCWkXs6SAj4LVxpH+XWg8sJ2XiPNz5NeryXiFlWjYlJU4QPZ
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The compat implementations for mbind, get_mempolicy, set_mempolicy
and migrate_pages are just there to handle the subtly different
layout of bitmaps on 32-bit hosts.

The compat implementation however lacks some of the checks that
are present in the native one, in particular for checking that
the extra bits are all zero when user space has a larger mask
size than the kernel. Worse, those extra bits do not get cleared
when copying in or out of the kernel, which can lead to incorrect
data as well.

Unify the implementation to handle the compat bitmap layout directly
in the get_nodes() and copy_nodes_to_user() helpers.  Splitting out
the get_bitmap() helper from get_nodes() also helps readability of the
native case.

On x86, two additional problems are addressed by this: compat tasks can
pass a bitmap at the end of a mapping, causing a fault when reading
across the page boundary for a 64-bit word. x32 tasks might also run
into problems with get_mempolicy corrupting data when an odd number of
32-bit words gets passed.

On parisc the migrate_pages() system call apparently had the wrong
calling convention, as big-endian architectures expect the words
inside of a bitmap to be swapped. This is not a problem though
since parisc has no NUMA support.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/unistd32.h         |   8 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl |   8 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl |   8 +-
 arch/parisc/kernel/syscalls/syscall.tbl   |   6 +-
 arch/powerpc/kernel/syscalls/syscall.tbl  |   8 +-
 arch/s390/kernel/syscalls/syscall.tbl     |   8 +-
 arch/sparc/kernel/syscalls/syscall.tbl    |   8 +-
 arch/x86/entry/syscalls/syscall_32.tbl    |   2 +-
 include/linux/compat.h                    |  15 --
 include/uapi/asm-generic/unistd.h         |   8 +-
 kernel/kexec.c                            |   6 +-
 kernel/sys_ni.c                           |   4 -
 mm/mempolicy.c                            | 193 +++++-----------------
 13 files changed, 79 insertions(+), 203 deletions(-)

diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index af793775ba98..31479f7120a0 100644
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
index 7fa1ca45e44c..15fda882d07e 100644
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
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 194c7fbeedf7..6591388a9d88 100644
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
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 5c17edaffe70..30f3c0146abf 100644
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
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 04fb42d7b377..4f5216320721 100644
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
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 3197965d45e9..70c0b830d14f 100644
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
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index e36ac364e61a..50ff839a2661 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -365,10 +365,10 @@
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
 306	common	kexec_load		sys_kexec_load			sys_kexec_load
 307	common	move_pages		sys_move_pages
 308	common	getcpu			sys_getcpu
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index b3263b8b2eae..d07c3fbd4697 100644
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
diff --git a/include/linux/compat.h b/include/linux/compat.h
index db1d7ac2c9e0..be06367b336c 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -749,21 +749,6 @@ asmlinkage long compat_sys_execve(const char __user *filename, const compat_uptr
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
-
 asmlinkage long compat_sys_rt_tgsigqueueinfo(compat_pid_t tgid,
 					compat_pid_t pid, int sig,
 					struct compat_siginfo __user *uinfo);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 4da51702fb21..4e31f9b68a8f 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -673,13 +673,13 @@ __SYSCALL(__NR_madvise, sys_madvise)
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
 __SYSCALL(__NR_move_pages, sys_move_pages)
 #endif
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 1ef7d3dc906f..0fecf2370be1 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -30,11 +30,13 @@ static int copy_user_segment_list(struct kimage *image,
 	image->nr_segments = nr_segments;
 	segment_bytes = nr_segments * sizeof(*segments);
 	if (in_compat_syscall()) {
-		struct compat_kexec_segment __user *cs = (void __user *)segments;
+		struct compat_kexec_segment __user *cs;
 		struct compat_kexec_segment segment;
 		int i;
+
+		cs = (struct compat_kexec_segment __user *)segments;
 		for (i=0; i< nr_segments; i++) {
-			copy_from_user(&segment, &cs[i], sizeof(segment));
+			ret = copy_from_user(&segment, &cs[i], sizeof(segment));
 			if (ret)
 				break;
 
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 783a24ceee88..0850111f888e 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -282,13 +282,9 @@ COND_SYSCALL(mincore);
 COND_SYSCALL(madvise);
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
 
 COND_SYSCALL(perf_event_open);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index eddbe4e56c73..2e1b90143b2c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1374,16 +1374,30 @@ static long do_mbind(unsigned long start, unsigned long len,
 /*
  * User space interface with variable sized bitmaps for nodelists.
  */
+static int get_bitmap(unsigned long *mask, const unsigned long __user *nmask,
+		      unsigned long maxnode)
+{
+	unsigned long nlongs = BITS_TO_LONGS(maxnode);
+	int ret;
+
+	if (in_compat_syscall())
+		ret = compat_get_bitmap(mask, (void __user *)nmask, maxnode);
+	else
+		ret = copy_from_user(mask, nmask, nlongs*sizeof(unsigned long));
+
+	if (ret)
+		return -EFAULT;
+
+	if (maxnode % BITS_PER_LONG)
+		mask[nlongs-1] &= (1UL << (maxnode % BITS_PER_LONG)) - 1;
+
+	return 0;
+}
 
 /* Copy a node mask from user space. */
 static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
 		     unsigned long maxnode)
 {
-	unsigned long k;
-	unsigned long t;
-	unsigned long nlongs;
-	unsigned long endmask;
-
 	--maxnode;
 	nodes_clear(*nodes);
 	if (maxnode == 0 || !nmask)
@@ -1391,49 +1405,29 @@ static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
 	if (maxnode > PAGE_SIZE*BITS_PER_BYTE)
 		return -EINVAL;
 
-	nlongs = BITS_TO_LONGS(maxnode);
-	if ((maxnode % BITS_PER_LONG) == 0)
-		endmask = ~0UL;
-	else
-		endmask = (1UL << (maxnode % BITS_PER_LONG)) - 1;
-
 	/*
 	 * When the user specified more nodes than supported just check
-	 * if the non supported part is all zero.
-	 *
-	 * If maxnode have more longs than MAX_NUMNODES, check
-	 * the bits in that area first. And then go through to
-	 * check the rest bits which equal or bigger than MAX_NUMNODES.
-	 * Otherwise, just check bits [MAX_NUMNODES, maxnode).
+	 * if the non supported part is all zero, one word at a time,
+	 * starting at the end.
 	 */
-	if (nlongs > BITS_TO_LONGS(MAX_NUMNODES)) {
-		for (k = BITS_TO_LONGS(MAX_NUMNODES); k < nlongs; k++) {
-			if (get_user(t, nmask + k))
-				return -EFAULT;
-			if (k == nlongs - 1) {
-				if (t & endmask)
-					return -EINVAL;
-			} else if (t)
-				return -EINVAL;
-		}
-		nlongs = BITS_TO_LONGS(MAX_NUMNODES);
-		endmask = ~0UL;
-	}
-
-	if (maxnode > MAX_NUMNODES && MAX_NUMNODES % BITS_PER_LONG != 0) {
-		unsigned long valid_mask = endmask;
+	while (maxnode > MAX_NUMNODES) {
+		unsigned long bits = min_t(unsigned long, maxnode, BITS_PER_LONG);
+		unsigned long t;
 
-		valid_mask &= ~((1UL << (MAX_NUMNODES % BITS_PER_LONG)) - 1);
-		if (get_user(t, nmask + nlongs - 1))
+		if (get_bitmap(&t, &nmask[maxnode / BITS_PER_LONG], bits))
 			return -EFAULT;
-		if (t & valid_mask)
+
+		if (maxnode - bits >= MAX_NUMNODES) {
+			maxnode -= bits;
+		} else {
+			maxnode = MAX_NUMNODES;
+			t &= ~((1UL << (MAX_NUMNODES % BITS_PER_LONG)) - 1);
+		}
+		if (t)
 			return -EINVAL;
 	}
 
-	if (copy_from_user(nodes_addr(*nodes), nmask, nlongs*sizeof(unsigned long)))
-		return -EFAULT;
-	nodes_addr(*nodes)[nlongs-1] &= endmask;
-	return 0;
+	return get_bitmap(nodes_addr(*nodes), nmask, maxnode);
 }
 
 /* Copy a kernel node mask to user space */
@@ -1442,6 +1436,10 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 {
 	unsigned long copy = ALIGN(maxnode-1, 64) / 8;
 	unsigned int nbytes = BITS_TO_LONGS(nr_node_ids) * sizeof(long);
+	bool compat = in_compat_syscall();
+
+	if (compat)
+		nbytes = BITS_TO_COMPAT_LONGS(nr_node_ids) * sizeof(compat_long_t);
 
 	if (copy > nbytes) {
 		if (copy > PAGE_SIZE)
@@ -1450,6 +1448,11 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 			return -EFAULT;
 		copy = nbytes;
 	}
+
+	if (compat)
+		return compat_put_bitmap((compat_ulong_t __user *)mask,
+					 nodes_addr(*nodes), maxnode);
+
 	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
 }
 
@@ -1641,116 +1644,6 @@ SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
 	return kernel_get_mempolicy(policy, nmask, maxnode, addr, flags);
 }
 
-#ifdef CONFIG_COMPAT
-
-COMPAT_SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
-		       compat_ulong_t __user *, nmask,
-		       compat_ulong_t, maxnode,
-		       compat_ulong_t, addr, compat_ulong_t, flags)
-{
-	long err;
-	unsigned long __user *nm = NULL;
-	unsigned long nr_bits, alloc_size;
-	DECLARE_BITMAP(bm, MAX_NUMNODES);
-
-	nr_bits = min_t(unsigned long, maxnode-1, nr_node_ids);
-	alloc_size = ALIGN(nr_bits, BITS_PER_LONG) / 8;
-
-	if (nmask)
-		nm = compat_alloc_user_space(alloc_size);
-
-	err = kernel_get_mempolicy(policy, nm, nr_bits+1, addr, flags);
-
-	if (!err && nmask) {
-		unsigned long copy_size;
-		copy_size = min_t(unsigned long, sizeof(bm), alloc_size);
-		err = copy_from_user(bm, nm, copy_size);
-		/* ensure entire bitmap is zeroed */
-		err |= clear_user(nmask, ALIGN(maxnode-1, 8) / 8);
-		err |= compat_put_bitmap(nmask, bm, nr_bits);
-	}
-
-	return err;
-}
-
-COMPAT_SYSCALL_DEFINE3(set_mempolicy, int, mode, compat_ulong_t __user *, nmask,
-		       compat_ulong_t, maxnode)
-{
-	unsigned long __user *nm = NULL;
-	unsigned long nr_bits, alloc_size;
-	DECLARE_BITMAP(bm, MAX_NUMNODES);
-
-	nr_bits = min_t(unsigned long, maxnode-1, MAX_NUMNODES);
-	alloc_size = ALIGN(nr_bits, BITS_PER_LONG) / 8;
-
-	if (nmask) {
-		if (compat_get_bitmap(bm, nmask, nr_bits))
-			return -EFAULT;
-		nm = compat_alloc_user_space(alloc_size);
-		if (copy_to_user(nm, bm, alloc_size))
-			return -EFAULT;
-	}
-
-	return kernel_set_mempolicy(mode, nm, nr_bits+1);
-}
-
-COMPAT_SYSCALL_DEFINE6(mbind, compat_ulong_t, start, compat_ulong_t, len,
-		       compat_ulong_t, mode, compat_ulong_t __user *, nmask,
-		       compat_ulong_t, maxnode, compat_ulong_t, flags)
-{
-	unsigned long __user *nm = NULL;
-	unsigned long nr_bits, alloc_size;
-	nodemask_t bm;
-
-	nr_bits = min_t(unsigned long, maxnode-1, MAX_NUMNODES);
-	alloc_size = ALIGN(nr_bits, BITS_PER_LONG) / 8;
-
-	if (nmask) {
-		if (compat_get_bitmap(nodes_addr(bm), nmask, nr_bits))
-			return -EFAULT;
-		nm = compat_alloc_user_space(alloc_size);
-		if (copy_to_user(nm, nodes_addr(bm), alloc_size))
-			return -EFAULT;
-	}
-
-	return kernel_mbind(start, len, mode, nm, nr_bits+1, flags);
-}
-
-COMPAT_SYSCALL_DEFINE4(migrate_pages, compat_pid_t, pid,
-		       compat_ulong_t, maxnode,
-		       const compat_ulong_t __user *, old_nodes,
-		       const compat_ulong_t __user *, new_nodes)
-{
-	unsigned long __user *old = NULL;
-	unsigned long __user *new = NULL;
-	nodemask_t tmp_mask;
-	unsigned long nr_bits;
-	unsigned long size;
-
-	nr_bits = min_t(unsigned long, maxnode - 1, MAX_NUMNODES);
-	size = ALIGN(nr_bits, BITS_PER_LONG) / 8;
-	if (old_nodes) {
-		if (compat_get_bitmap(nodes_addr(tmp_mask), old_nodes, nr_bits))
-			return -EFAULT;
-		old = compat_alloc_user_space(new_nodes ? size * 2 : size);
-		if (new_nodes)
-			new = old + size / sizeof(unsigned long);
-		if (copy_to_user(old, nodes_addr(tmp_mask), size))
-			return -EFAULT;
-	}
-	if (new_nodes) {
-		if (compat_get_bitmap(nodes_addr(tmp_mask), new_nodes, nr_bits))
-			return -EFAULT;
-		if (new == NULL)
-			new = compat_alloc_user_space(size);
-		if (copy_to_user(new, nodes_addr(tmp_mask), size))
-			return -EFAULT;
-	}
-	return kernel_migrate_pages(pid, nr_bits + 1, old, new);
-}
-
-#endif /* CONFIG_COMPAT */
-
 bool vma_migratable(struct vm_area_struct *vma)
 {
 	if (vma->vm_flags & (VM_IO | VM_PFNMAP))
-- 
2.27.0

