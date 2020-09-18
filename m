Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C813226FE63
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 15:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgIRNZh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 09:25:37 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:41303 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgIRNZe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 09:25:34 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N9cDF-1kVVpo4405-015YFr; Fri, 18 Sep 2020 15:24:54 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        kexec@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/4] kexec: remove compat_sys_kexec_load syscall
Date:   Fri, 18 Sep 2020 15:24:37 +0200
Message-Id: <20200918132439.1475479-3-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200918132439.1475479-1-arnd@arndb.de>
References: <20200918132439.1475479-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NJV12PC5uxHD6FHaymSw/m+fKF3lrpRL0+xIfBJY/upUA40WgzH
 KmBGGRhf7ViI9Js6Mz/Ot3F/q2M7IJhHX1WV3zAX6FWE9LWgPs1gS0xpPr6z4xwpyJC0cn0
 2C2PNchxF3SJx831h49joBkUjqGichrslId8sn11FcMO5FePhsWZRcLVtoixpZbddz6WtM7
 wt7TzDPzR0wbaZUPMKfmg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:I0GYqFxUFmE=:e3A+aS5+r/jNowggCIDS5c
 iuFnpSLvFrK81QG8B9kJMKmx2NbMNGItr5LhwSMucubx5qDFfCMF2uaajF8o/wDY0k9kqQ/s5
 7bEUFAoA//NAheNzPoweE9VNRhCh6Ntbz35P8dNaZiU680WT0RoWJJ+TLwx3RvPlCXOrS89ri
 hN3DnnYoX4/WR4ITEDovHshVn+QB6N/Ttgvtz2Z9LlyF8G4gP9vR0rIJeb3hjJhKkxQU8Rv7D
 A0lxQEwfBgaUdLo7+9EW/y1SbNT7ZxVWRl4iyvyYOmIxoKXF5TC4Fwk8dEBCAxoPeHh1az5c1
 MZwv+3SOoPetG35mef/4pcziWRY+PNU66y7baQpVJHHLUMKU0tTFHvLU2Gn3L43e9r+k5+1Cx
 jDNsZ4S1SuT7nIXNt8xHKxsHf/N09/m2lMBNPAc1QBExSVylLh37vpNv0iufAG9RyLjuIHU5u
 Ms3AMjTnNkLBVVw3bS2zmnrShVT0Kgt6d0i4Ik60XytFsvLWexuFEdE7QeAhW0UgLi6xODrxD
 XJlEkxGikHJs/paqraDf7ygs5Og1v2yaPtivaHsKLfpX7eR+NgxIRHpBxnO52b+qjRS4zky9I
 b3EOorUJ3MSl3DpEC0DiAk+n6VFUkNmmrQQagdhjRm5qR7sw07QI4nvUdWgeS8g5WSsBJTEqw
 TgQ81sr3rklYxymsWlFoq6fUlUVkvNp8NaM/bm1uXwkVRm7aq9eTsYCYiiMI3B1jRia6Yhd1y
 McJgYa5z1ZlbsTD8hHKFMMiCD0tInDKEeOh1t4D0ka9goDZLeJyQKvVKzjheLYGYYPwQ7zH5h
 2dn/1h98zQh2VN5K3sb9bp24OicLYaJ+v4EAwTK9vbcUrBgWIR/0W/AjDTHQVHGhdvI5A1D
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The compat version of sys_kexec_load() uses compat_alloc_user_space to
convert the user-provided arguments into the native format.

Move the conversion into the regular implementation with
an in_compat_syscall() check to simplify it and avoid the
compat_alloc_user_space() call.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/unistd32.h         |  2 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl |  2 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl |  2 +-
 arch/parisc/kernel/syscalls/syscall.tbl   |  2 +-
 arch/powerpc/kernel/syscalls/syscall.tbl  |  2 +-
 arch/s390/kernel/syscalls/syscall.tbl     |  2 +-
 arch/sparc/kernel/syscalls/syscall.tbl    |  2 +-
 arch/x86/entry/syscalls/syscall_32.tbl    |  2 +-
 arch/x86/entry/syscalls/syscall_64.tbl    |  2 +-
 include/linux/compat.h                    |  6 --
 include/uapi/asm-generic/unistd.h         |  2 +-
 kernel/kexec.c                            | 75 ++++++-----------------
 12 files changed, 29 insertions(+), 72 deletions(-)

diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 734860ac7cf9..b6517df74037 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -705,7 +705,7 @@ __SYSCALL(__NR_getcpu, sys_getcpu)
 #define __NR_epoll_pwait 346
 __SYSCALL(__NR_epoll_pwait, compat_sys_epoll_pwait)
 #define __NR_kexec_load 347
-__SYSCALL(__NR_kexec_load, compat_sys_kexec_load)
+__SYSCALL(__NR_kexec_load, sys_kexec_load)
 #define __NR_utimensat 348
 __SYSCALL(__NR_utimensat, sys_utimensat_time32)
 #define __NR_signalfd 349
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index f9df9edb67a4..ad157aab4c09 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -282,7 +282,7 @@
 271	n32	move_pages			compat_sys_move_pages
 272	n32	set_robust_list			compat_sys_set_robust_list
 273	n32	get_robust_list			compat_sys_get_robust_list
-274	n32	kexec_load			compat_sys_kexec_load
+274	n32	kexec_load			sys_kexec_load
 275	n32	getcpu				sys_getcpu
 276	n32	epoll_pwait			compat_sys_epoll_pwait
 277	n32	ioprio_set			sys_ioprio_set
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 195b43cf27c8..57baf6c8008f 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -322,7 +322,7 @@
 308	o32	move_pages			sys_move_pages			compat_sys_move_pages
 309	o32	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
 310	o32	get_robust_list			sys_get_robust_list		compat_sys_get_robust_list
-311	o32	kexec_load			sys_kexec_load			compat_sys_kexec_load
+311	o32	kexec_load			sys_kexec_load
 312	o32	getcpu				sys_getcpu
 313	o32	epoll_pwait			sys_epoll_pwait			compat_sys_epoll_pwait
 314	o32	ioprio_set			sys_ioprio_set
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index def64d221cd4..778bf166d7bd 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -336,7 +336,7 @@
 297	common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
 298	common	statfs64		sys_statfs64			compat_sys_statfs64
 299	common	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
-300	common	kexec_load		sys_kexec_load			compat_sys_kexec_load
+300	common	kexec_load		sys_kexec_load
 301	32	utimensat		sys_utimensat_time32
 301	64	utimensat		sys_utimensat
 302	common	signalfd		sys_signalfd			compat_sys_signalfd
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index c2d737ff2e7b..f128ba8b9a71 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -350,7 +350,7 @@
 265	64	mq_timedreceive			sys_mq_timedreceive
 266	nospu	mq_notify			sys_mq_notify			compat_sys_mq_notify
 267	nospu	mq_getsetattr			sys_mq_getsetattr		compat_sys_mq_getsetattr
-268	nospu	kexec_load			sys_kexec_load			compat_sys_kexec_load
+268	nospu	kexec_load			sys_kexec_load
 269	nospu	add_key				sys_add_key
 270	nospu	request_key			sys_request_key
 271	nospu	keyctl				sys_keyctl			compat_sys_keyctl
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 10456bc936fb..d45952058be2 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -283,7 +283,7 @@
 274  common	mq_timedreceive		sys_mq_timedreceive		sys_mq_timedreceive_time32
 275  common	mq_notify		sys_mq_notify			compat_sys_mq_notify
 276  common	mq_getsetattr		sys_mq_getsetattr		compat_sys_mq_getsetattr
-277  common	kexec_load		sys_kexec_load			compat_sys_kexec_load
+277  common	kexec_load		sys_kexec_load			sys_kexec_load
 278  common	add_key			sys_add_key			sys_add_key
 279  common	request_key		sys_request_key			sys_request_key
 280  common	keyctl			sys_keyctl			compat_sys_keyctl
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 4af114e84f20..a46edcdd950d 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -369,7 +369,7 @@
 303	common	mbind			sys_mbind			compat_sys_mbind
 304	common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
 305	common	set_mempolicy		sys_set_mempolicy		compat_sys_set_mempolicy
-306	common	kexec_load		sys_kexec_load			compat_sys_kexec_load
+306	common	kexec_load		sys_kexec_load			sys_kexec_load
 307	common	move_pages		sys_move_pages			compat_sys_move_pages
 308	common	getcpu			sys_getcpu
 309	common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 3db3d8823dc8..7e4140b78aad 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -294,7 +294,7 @@
 280	i386	mq_timedreceive		sys_mq_timedreceive_time32
 281	i386	mq_notify		sys_mq_notify			compat_sys_mq_notify
 282	i386	mq_getsetattr		sys_mq_getsetattr		compat_sys_mq_getsetattr
-283	i386	kexec_load		sys_kexec_load			compat_sys_kexec_load
+283	i386	kexec_load		sys_kexec_load			sys_kexec_load
 284	i386	waitid			sys_waitid			compat_sys_waitid
 # 285 sys_setaltroot
 286	i386	add_key			sys_add_key
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f30d6ae9a688..9986f5f08278 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -384,7 +384,7 @@
 525	x32	sigaltstack		compat_sys_sigaltstack
 526	x32	timer_create		compat_sys_timer_create
 527	x32	mq_notify		compat_sys_mq_notify
-528	x32	kexec_load		compat_sys_kexec_load
+528	x32	kexec_load		sys_kexec_load
 529	x32	waitid			compat_sys_waitid
 530	x32	set_robust_list		compat_sys_set_robust_list
 531	x32	get_robust_list		compat_sys_get_robust_list
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 3d96a841bd49..a7a5a0ff59ef 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -643,12 +643,6 @@ asmlinkage long compat_sys_setitimer(int which,
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
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 995b36c2ea7d..83f1fc7fd3d7 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -342,7 +342,7 @@ __SC_COMP(__NR_setitimer, sys_setitimer, compat_sys_setitimer)
 
 /* kernel/kexec.c */
 #define __NR_kexec_load 104
-__SC_COMP(__NR_kexec_load, sys_kexec_load, compat_sys_kexec_load)
+__SYSCALL(__NR_kexec_load, sys_kexec_load)
 
 /* kernel/module.c */
 #define __NR_init_module 105
diff --git a/kernel/kexec.c b/kernel/kexec.c
index f977786fe498..1ef7d3dc906f 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -29,7 +29,25 @@ static int copy_user_segment_list(struct kimage *image,
 	/* Read in the segments */
 	image->nr_segments = nr_segments;
 	segment_bytes = nr_segments * sizeof(*segments);
-	ret = copy_from_user(image->segment, segments, segment_bytes);
+	if (in_compat_syscall()) {
+		struct compat_kexec_segment __user *cs = (void __user *)segments;
+		struct compat_kexec_segment segment;
+		int i;
+		for (i=0; i< nr_segments; i++) {
+			copy_from_user(&segment, &cs[i], sizeof(segment));
+			if (ret)
+				break;
+
+			image->segment[i] = (struct kexec_segment) {
+				.buf   = compat_ptr(segment.buf),
+				.bufsz = segment.bufsz,
+				.mem   = segment.mem,
+				.memsz = segment.memsz,
+			};
+		}
+	} else {
+		ret = copy_from_user(image->segment, segments, segment_bytes);
+	}
 	if (ret)
 		ret = -EFAULT;
 
@@ -264,58 +282,3 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 
 	return result;
 }
-
-#ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
-		       compat_ulong_t, nr_segments,
-		       struct compat_kexec_segment __user *, segments,
-		       compat_ulong_t, flags)
-{
-	struct compat_kexec_segment in;
-	struct kexec_segment out, __user *ksegments;
-	unsigned long i, result;
-
-	result = kexec_load_check(nr_segments, flags);
-	if (result)
-		return result;
-
-	/* Don't allow clients that don't understand the native
-	 * architecture to do anything.
-	 */
-	if ((flags & KEXEC_ARCH_MASK) == KEXEC_ARCH_DEFAULT)
-		return -EINVAL;
-
-	ksegments = compat_alloc_user_space(nr_segments * sizeof(out));
-	for (i = 0; i < nr_segments; i++) {
-		result = copy_from_user(&in, &segments[i], sizeof(in));
-		if (result)
-			return -EFAULT;
-
-		out.buf   = compat_ptr(in.buf);
-		out.bufsz = in.bufsz;
-		out.mem   = in.mem;
-		out.memsz = in.memsz;
-
-		result = copy_to_user(&ksegments[i], &out, sizeof(out));
-		if (result)
-			return -EFAULT;
-	}
-
-	/* Because we write directly to the reserved memory
-	 * region when loading crash kernels we need a mutex here to
-	 * prevent multiple crash  kernels from attempting to load
-	 * simultaneously, and to prevent a crash kernel from loading
-	 * over the top of a in use crash kernel.
-	 *
-	 * KISS: always take the mutex.
-	 */
-	if (!mutex_trylock(&kexec_mutex))
-		return -EBUSY;
-
-	result = do_kexec_load(entry, nr_segments, ksegments, flags);
-
-	mutex_unlock(&kexec_mutex);
-
-	return result;
-}
-#endif
-- 
2.27.0

