Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B4B280108
	for <lists+linux-arch@lfdr.de>; Thu,  1 Oct 2020 16:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732539AbgJAONn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Oct 2020 10:13:43 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:50239 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732413AbgJAONH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Oct 2020 10:13:07 -0400
Received: from threadripper.lan ([46.223.126.90]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MvbJw-1kepec1eTe-00shEs; Thu, 01 Oct 2020 16:12:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org
Subject: [PATCH v3 03/10] ARM: oabi-compat: add epoll_pwait handler
Date:   Thu,  1 Oct 2020 16:12:26 +0200
Message-Id: <20201001141233.119343-4-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201001141233.119343-1-arnd@arndb.de>
References: <20201001141233.119343-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cWWCYuRJriYKt0llInUlGsi6sGZrKAuOlwaggzj3/coCoUzqfLK
 tdhpTdf+H1PnSpU5qTRkfZCY1eCG1Cjc26hA5rHMOatSmHap4G/tHtXis84Mc+nDdeUaSjS
 PlQBkFWU32fdiDbaBtMFwdhbryJMvp4bYkfA1tB83+ywMKEBtsP41yb1F5scXxc27obsYYl
 e2PBjElmQm1a2yMG97plw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1EcS5jnnr5c=:1nhTSp9Le4lI6Ga8UCr5JX
 ipyTMFNr/ZP7v+X4Nv+sXpevyJjaGWoU3bmRuRFg41lsTEICDGn80l+k1ld6seKph2+6q2K5+
 bO9Kc4cwSs6KYjZ2k+XxJ8v7ThMQVqKLjWaNHd082KwpwKaqm2WD9OXB8PR6eB3VTG+U/fmci
 wYYlfW46pyc0F1RJGW2RW/0iud2hoOZQzFOnO3aEiv50e0+HSV+6mDhAT4d10Sc2elBtgfUnt
 i2JW60cF6AVPW4UpsI8PQ07ly1/EOe0NJ82Br6fqWl1Ts5OLWf6GJgpu0YngvC0VGa1anEcud
 IbX43EodVT/85TdzRFpvawl586wog/J/ico+QQrz9/hJppRGHWcxGqDqpeM4/eQQZL+2ehdSL
 WzQdmIeYblZCXeIWmpdvOzcoDPyx+eVnsv8Gjct0G5ibU6JD8129XNJe0FiqeEPNGwaBEolQ4
 8FoffRKSXJ6obHkMZMlyPhjCVM+39A/2ljYk2fGfFlED5YbHhB4ktz0ctaDgehZ+BdIS71d/y
 crzTKNN7I5YHtfReJWyjg4LgFpgoMI3LppDnAwXFmLQAn6d3V1m9z+7jVrPEi9jY9BETXXmP1
 u+17FAEZ+ICVJXW97PTALiByF5UQsDzfn68gPV+d2ihUq6WAqDN5k4h1ZNoz0BJfRoOKRWBO2
 8vQObH3r/eEbkG47hp/76MVrYdp6B2VCvkXOTJVnp092ZbDmiHVv1VhuOPC2uOZBZLJdVWjOH
 +I7iC88PjghCZ/dX7e5ii0Lb5R7ZGFkt/WIAIwHGg+6lLckIAehVXLBmB3Q1Sc99unfuBq6PJ
 VHM/WoRyYYZ6w/XYDjLofdAonNAqxxzrfRwkIbNE/A9okryX3sbushKiYtKaRXzdQV77VmV
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The epoll_wait() syscall has a special version for OABI compat
mode to convert the arguments to the EABI structure layout
of the kernel. However, the later epoll_pwait() syscall was
added in arch/arm in linux-2.6.32 without this conversion.

Use the same kind of handler for both.

Fixes: 369842658a36 ("ARM: 5677/1: ARM support for TIF_RESTORE_SIGMASK/pselect6/ppoll/epoll_pwait")
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/sys_oabi-compat.c | 37 ++++++++++++++++++++++++++++---
 arch/arm/tools/syscall.tbl        |  2 +-
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index 0203e545bbc8..a2b1ae01e5bf 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -264,9 +264,8 @@ asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
 	return do_epoll_ctl(epfd, op, fd, &kernel, false);
 }
 
-asmlinkage long sys_oabi_epoll_wait(int epfd,
-				    struct oabi_epoll_event __user *events,
-				    int maxevents, int timeout)
+static long do_oabi_epoll_wait(int epfd, struct oabi_epoll_event __user *events,
+			       int maxevents, int timeout)
 {
 	struct epoll_event *kbuf;
 	struct oabi_epoll_event e;
@@ -299,6 +298,38 @@ asmlinkage long sys_oabi_epoll_wait(int epfd,
 	return err ? -EFAULT : ret;
 }
 
+SYSCALL_DEFINE4(oabi_epoll_wait, int, epfd,
+		struct oabi_epoll_event __user *, events,
+		int, maxevents, int, timeout)
+{
+	return do_oabi_epoll_wait(epfd, events, maxevents, timeout);
+}
+
+/*
+ * Implement the event wait interface for the eventpoll file. It is the kernel
+ * part of the user space epoll_pwait(2).
+ */
+SYSCALL_DEFINE6(oabi_epoll_pwait, int, epfd,
+		struct oabi_epoll_event __user *, events, int, maxevents,
+		int, timeout, const sigset_t __user *, sigmask,
+		size_t, sigsetsize)
+{
+	int error;
+
+	/*
+	 * If the caller wants a certain signal mask to be set during the wait,
+	 * we apply it here.
+	 */
+	error = set_user_sigmask(sigmask, sigsetsize);
+	if (error)
+		return error;
+
+	error = do_oabi_epoll_wait(epfd, events, maxevents, timeout);
+	restore_saved_sigmask_unless(error == -EINTR);
+
+	return error;
+}
+
 struct oabi_sembuf {
 	unsigned short	sem_num;
 	short		sem_op;
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 171077cbf419..39a24bee7df8 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -360,7 +360,7 @@
 343	common	vmsplice		sys_vmsplice
 344	common	move_pages		sys_move_pages
 345	common	getcpu			sys_getcpu
-346	common	epoll_pwait		sys_epoll_pwait
+346	common	epoll_pwait		sys_epoll_pwait		sys_oabi_epoll_pwait
 347	common	kexec_load		sys_kexec_load
 348	common	utimensat		sys_utimensat_time32
 349	common	signalfd		sys_signalfd
-- 
2.27.0

