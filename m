Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F863D5B0A
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 16:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbhGZNbf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 09:31:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234319AbhGZNb2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Jul 2021 09:31:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C5A060F55;
        Mon, 26 Jul 2021 14:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627308717;
        bh=nPzVCIo2pqMwWYsXiXIRKTQEfk7ehkcmHPxSp0XJK/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VondwzsMx71PMb92EXTHkqOifQII64w9qDYewxXJgZ73sARtzizlspKwSV8H4prVn
         15V56b/rcl5YOPNGD/H8jUfR7sGcxEqv7tfjHWTd05PgPnmF+Dm7cpdg11WxbQY3Du
         uF++csp6z35ojaqw3c0JuJKaLX66zW9LxV2nuyIg2RyWzWXW34Vl/I1hcMBVA1EOTw
         oj6jz+gweVTCjsyMcgOC48ab8NzkakFX0BbziHLGbUdy4+Ok6/dm0LUFOZJeZAQjuK
         PaTPSVCCBgsLfdvLmvUH9xl2WmP9xd5J54B195YkqeS2wLBXIgX8VJHcWcWc8m4/x/
         s4om4GwwdxloA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v5 05/10] ARM: oabi-compat: rework epoll_wait/epoll_pwait emulation
Date:   Mon, 26 Jul 2021 16:11:36 +0200
Message-Id: <20210726141141.2839385-6-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210726141141.2839385-1-arnd@kernel.org>
References: <20210726141141.2839385-1-arnd@kernel.org>
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
 arch/arm/include/asm/syscall.h    | 11 ++++
 arch/arm/kernel/sys_oabi-compat.c | 83 ++++++-------------------------
 arch/arm/tools/syscall.tbl        |  4 +-
 fs/eventpoll.c                    |  5 +-
 include/linux/eventpoll.h         | 18 +++++++
 5 files changed, 49 insertions(+), 72 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index f055e846a5cc..24c19d63ff0a 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -28,6 +28,17 @@ static inline int syscall_get_nr(struct task_struct *task,
 	return task_thread_info(task)->abi_syscall & __NR_SYSCALL_MASK;
 }
 
+static inline bool __in_oabi_syscall(struct task_struct *task)
+{
+	return IS_ENABLED(CONFIG_OABI_COMPAT) &&
+		(task_thread_info(task)->abi_syscall & __NR_OABI_SYSCALL_BASE);
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
index 443203fafb6b..1f6a433200f1 100644
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
@@ -264,87 +266,34 @@ asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
 
 	return do_epoll_ctl(epfd, op, fd, &kernel, false);
 }
-
-static long do_oabi_epoll_wait(int epfd, struct oabi_epoll_event __user *events,
-			       int maxevents, int timeout)
-{
-	struct epoll_event *kbuf;
-	struct oabi_epoll_event e;
-	mm_segment_t fs;
-	long ret, err, i;
-
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
 #else
 asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
 				   struct oabi_epoll_event __user *event)
 {
 	return -EINVAL;
 }
-
-asmlinkage long sys_oabi_epoll_wait(int epfd,
-				    struct oabi_epoll_event __user *events,
-				    int maxevents, int timeout)
-{
-	return -EINVAL;
-}
 #endif
 
-SYSCALL_DEFINE4(oabi_epoll_wait, int, epfd,
-		struct oabi_epoll_event __user *, events,
-		int, maxevents, int, timeout)
+struct epoll_event __user *
+epoll_put_uevent(__poll_t revents, __u64 data,
+		 struct epoll_event __user *uevent)
 {
-	return do_oabi_epoll_wait(epfd, events, maxevents, timeout);
-}
+	if (in_oabi_syscall()) {
+		struct oabi_epoll_event __user *oevent = (void __user *)uevent;
 
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
+		if (__put_user(revents, &oevent->events) ||
+		    __put_user(data, &oevent->data))
+			return NULL;
 
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
-#endif
 
 struct oabi_sembuf {
 	unsigned short	sem_num;
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 11d0b960b2c2..344424a9611f 100644
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
index 1e596e1d0bba..c90c4352325e 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1684,8 +1684,8 @@ static int ep_send_events(struct eventpoll *ep,
 		if (!revents)
 			continue;
 
-		if (__put_user(revents, &events->events) ||
-		    __put_user(epi->event.data, &events->data)) {
+		events = epoll_put_uevent(revents, epi->event.data, events);
+		if (!events) {
 			list_add(&epi->rdllink, &txlist);
 			ep_pm_stay_awake(epi);
 			if (!res)
@@ -1693,7 +1693,6 @@ static int ep_send_events(struct eventpoll *ep,
 			break;
 		}
 		res++;
-		events++;
 		if (epi->event.events & EPOLLONESHOT)
 			epi->event.events &= EP_PRIVATE_BITS;
 		else if (!(epi->event.events & EPOLLET)) {
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 593322c946e6..3337745d81bd 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -68,4 +68,22 @@ static inline void eventpoll_release(struct file *file) {}
 
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
2.29.2

