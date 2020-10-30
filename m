Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17542A0A4D
	for <lists+linux-arch@lfdr.de>; Fri, 30 Oct 2020 16:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgJ3Ptn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 11:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbgJ3Ptk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Oct 2020 11:49:40 -0400
Received: from localhost.localdomain (HSI-KBW-46-223-126-90.hsi.kabel-badenwuerttemberg.de [46.223.126.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 678A0206E9;
        Fri, 30 Oct 2020 15:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604072979;
        bh=v4W+rSkvG9WdcPfSNfBGl6XjWSXTtC1rvveEB/jtQ0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XqTBWM/aCsrmb4Tgi139hX/RSflNORGj9TBXdOTLU3VWg3oXN09auBrmiyxfD7l7s
         jP5NJCppEO2q8rAxXZgSlJP5r9YqZvxzDq+BRPp+fec+f8i1i7FravE+RhO6dmLMG2
         4mf65FFZgvd5YsjohMNAZd1o4yHtKx2Zv0l9npvo=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        viro@zeniv.linux.org.uk, linus.walleij@linaro.org, arnd@arndb.de
Subject: [PATCH 5/9] ARM: oabi-compat: rework epoll_wait/epoll_pwait emulation
Date:   Fri, 30 Oct 2020 16:49:15 +0100
Message-Id: <20201030154919.1246645-5-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201030154919.1246645-1-arnd@kernel.org>
References: <20201030154519.1245983-1-arnd@kernel.org>
 <20201030154919.1246645-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The epoll_wait() system call wrapper is one of the remaining users of
the set_fs() infrasturcture for Arm. Changing it to not require set_fs()
is rather complex unfortunately.

The approach I'm taking here is to allow architectures to override
the code that copies the output to user space, and let the oabi-compat
implementation check whether it is getting called from an EABI or OABI
system call based on the thread_info->syscall value.

The in_oabi_syscall() check here mirrors the in_compat_syscall() and
in_x32_syscall() helpers for 32-bit compat implementations on other
architectures.

Overall, the amount of code goes down, at least with the newly added
sys_oabi_epoll_pwait() helper getting removed again. The downside
is added complexity in the source code for the native implementation.
There should be no difference in runtime performance except for Arm
kernels with CONFIG_OABI_COMPAT enabled that now have to go through
an external function call to check which of the two variants to use.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/syscall.h    | 11 +++++
 arch/arm/kernel/sys_oabi-compat.c | 75 +++++++------------------------
 arch/arm/tools/syscall.tbl        |  4 +-
 fs/eventpoll.c                    |  5 +--
 include/linux/eventpoll.h         | 18 ++++++++
 5 files changed, 49 insertions(+), 64 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index 89898497edd6..9efb7b3384e5 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -28,6 +28,17 @@ static inline int syscall_get_nr(struct task_struct *task,
 	return task_thread_info(task)->syscall & ~__NR_OABI_SYSCALL_BASE;
 }
 
+static inline bool __in_oabi_syscall(struct task_struct *task)
+{
+	return IS_ENABLED(CONFIG_OABI_COMPAT) &&
+		(task_thread_info(task)->syscall & __NR_OABI_SYSCALL_BASE);
+}
+
+static inline bool in_oabi_syscall(void)
+{
+	return __in_oabi_syscall(current);
+}
+
 static inline void syscall_rollback(struct task_struct *task,
 				    struct pt_regs *regs)
 {
diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index a2b1ae01e5bf..f9d8e5be6ba0 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -83,6 +83,8 @@
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 
+#include <asm/syscall.h>
+
 struct oldabi_stat64 {
 	unsigned long long st_dev;
 	unsigned int	__pad1;
@@ -264,70 +266,25 @@ asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
 	return do_epoll_ctl(epfd, op, fd, &kernel, false);
 }
 
-static long do_oabi_epoll_wait(int epfd, struct oabi_epoll_event __user *events,
-			       int maxevents, int timeout)
+struct epoll_event __user *
+epoll_put_uevent(__poll_t revents, __u64 data,
+		 struct epoll_event __user *uevent)
 {
-	struct epoll_event *kbuf;
-	struct oabi_epoll_event e;
-	mm_segment_t fs;
-	long ret, err, i;
+	if (in_oabi_syscall()) {
+		struct oabi_epoll_event __user *oevent = (void __user *)uevent;
 
-	if (maxevents <= 0 ||
-			maxevents > (INT_MAX/sizeof(*kbuf)) ||
-			maxevents > (INT_MAX/sizeof(*events)))
-		return -EINVAL;
-	if (!access_ok(events, sizeof(*events) * maxevents))
-		return -EFAULT;
-	kbuf = kmalloc_array(maxevents, sizeof(*kbuf), GFP_KERNEL);
-	if (!kbuf)
-		return -ENOMEM;
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = sys_epoll_wait(epfd, kbuf, maxevents, timeout);
-	set_fs(fs);
-	err = 0;
-	for (i = 0; i < ret; i++) {
-		e.events = kbuf[i].events;
-		e.data = kbuf[i].data;
-		err = __copy_to_user(events, &e, sizeof(e));
-		if (err)
-			break;
-		events++;
-	}
-	kfree(kbuf);
-	return err ? -EFAULT : ret;
-}
+		if (__put_user(revents, &oevent->events) ||
+		    __put_user(data, &oevent->data))
+			return NULL;
 
-SYSCALL_DEFINE4(oabi_epoll_wait, int, epfd,
-		struct oabi_epoll_event __user *, events,
-		int, maxevents, int, timeout)
-{
-	return do_oabi_epoll_wait(epfd, events, maxevents, timeout);
-}
-
-/*
- * Implement the event wait interface for the eventpoll file. It is the kernel
- * part of the user space epoll_pwait(2).
- */
-SYSCALL_DEFINE6(oabi_epoll_pwait, int, epfd,
-		struct oabi_epoll_event __user *, events, int, maxevents,
-		int, timeout, const sigset_t __user *, sigmask,
-		size_t, sigsetsize)
-{
-	int error;
-
-	/*
-	 * If the caller wants a certain signal mask to be set during the wait,
-	 * we apply it here.
-	 */
-	error = set_user_sigmask(sigmask, sigsetsize);
-	if (error)
-		return error;
+		return (void __user *)(oevent+1);
+	}
 
-	error = do_oabi_epoll_wait(epfd, events, maxevents, timeout);
-	restore_saved_sigmask_unless(error == -EINTR);
+	if (__put_user(revents, &uevent->events) ||
+	    __put_user(data, &uevent->data))
+		return NULL;
 
-	return error;
+	return uevent+1;
 }
 
 struct oabi_sembuf {
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 330cf0aa04c4..2dd99f86e8a5 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -266,7 +266,7 @@
 249	common	lookup_dcookie		sys_lookup_dcookie
 250	common	epoll_create		sys_epoll_create
 251	common	epoll_ctl		sys_epoll_ctl		sys_oabi_epoll_ctl
-252	common	epoll_wait		sys_epoll_wait		sys_oabi_epoll_wait
+252	common	epoll_wait		sys_epoll_wait
 253	common	remap_file_pages	sys_remap_file_pages
 # 254 for set_thread_area
 # 255 for get_thread_area
@@ -360,7 +360,7 @@
 343	common	vmsplice		sys_vmsplice
 344	common	move_pages		sys_move_pages
 345	common	getcpu			sys_getcpu
-346	common	epoll_pwait		sys_epoll_pwait		sys_oabi_epoll_pwait
+346	common	epoll_pwait		sys_epoll_pwait
 347	common	kexec_load		sys_kexec_load
 348	common	utimensat		sys_utimensat_time32
 349	common	signalfd		sys_signalfd
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4df61129566d..a21e8dbbe567 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1743,8 +1743,8 @@ static __poll_t ep_send_events_proc(struct eventpoll *ep, struct list_head *head
 		if (!revents)
 			continue;
 
-		if (__put_user(revents, &uevent->events) ||
-		    __put_user(epi->event.data, &uevent->data)) {
+		uevent = epoll_put_uevent(revents, epi->event.data, uevent);
+		if (!uevent) {
 			list_add(&epi->rdllink, head);
 			ep_pm_stay_awake(epi);
 			if (!esed->res)
@@ -1752,7 +1752,6 @@ static __poll_t ep_send_events_proc(struct eventpoll *ep, struct list_head *head
 			return 0;
 		}
 		esed->res++;
-		uevent++;
 		if (epi->event.events & EPOLLONESHOT)
 			epi->event.events &= EP_PRIVATE_BITS;
 		else if (!(epi->event.events & EPOLLET)) {
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 8f000fada5a4..d1f13147ed69 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -77,4 +77,22 @@ static inline void eventpoll_release(struct file *file) {}
 
 #endif
 
+#if defined(CONFIG_ARM) && defined(CONFIG_OABI_COMPAT)
+/* ARM OABI has an incompatible struct layout and needs a special handler */
+extern struct epoll_event __user *
+epoll_put_uevent(__poll_t revents, __u64 data,
+		 struct epoll_event __user *uevent);
+#else
+static inline struct epoll_event __user *
+epoll_put_uevent(__poll_t revents, __u64 data,
+		 struct epoll_event __user *uevent)
+{
+	if (__put_user(revents, &uevent->events) ||
+	    __put_user(data, &uevent->data))
+		return NULL;
+
+	return uevent+1;
+}
+#endif
+
 #endif /* #ifndef _LINUX_EVENTPOLL_H */
-- 
2.27.0

