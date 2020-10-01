Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15966280103
	for <lists+linux-arch@lfdr.de>; Thu,  1 Oct 2020 16:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbgJAONK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Oct 2020 10:13:10 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:39319 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732381AbgJAONE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Oct 2020 10:13:04 -0400
Received: from threadripper.lan ([46.223.126.90]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MLR9p-1k6ala2thD-00IXTP; Thu, 01 Oct 2020 16:12:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 07/10] ARM: oabi-compat: rework fcntl64() emulation
Date:   Thu,  1 Oct 2020 16:12:30 +0200
Message-Id: <20201001141233.119343-8-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201001141233.119343-1-arnd@arndb.de>
References: <20201001141233.119343-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3TKgNrSTMpXNYGaFmu+SKHQrcSCbfmgZhLqpwbUtnDHIn9vPu29
 oSkmHqaY7tsVWPZ2Ptkj1ib/NP/Dj6JPyQuSGpHXVR1Gqq30UVLFmv4Ia29rizLkAFHMdnl
 ozciaEsv5U1wTT6P8yVO75ZH+AeAXUIPO3efL7tlJ3g/x+yGiqwRxzgti7AONfBzTsd4hu2
 JhI+LZ53Zez1akbZmzfzw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:w4rV1cQPcYg=:EYlyzTuBZ/LUfCWS+MzcGD
 kMfyyUknM+NGlxu5WBpVCEYA1LRustzlIEARJoYZofCaPKT8/dorMGR5Hr3nvdkP1cIs6McH1
 qwT8N4mE9Q/ii5jF84vfiLgM3AddNFZbeXDLGOOGU5X/pyq4uSUY21T3O3icI+WZTF5pfyYpy
 9DuJbOAYpzMgK8MtlknyOgV93A/KijM5rxcuUglbkmTdgq1EEnDENMO0Glt/qE6weMaG+fsy6
 Krc1lkjbXQkIhPxHQg/6xnbepbCQN+0dshF18C3D/Zn4koW0EkRAb3XwvMRIsFfCB8ykkdHdB
 XSCv+v9HaIk7Guf6hFtuAXwLvZu7X4KUoAqs/cB+e/ZcMzs/Q9gkL0QhLfFVtgxZv9ftyBsyQ
 TD+rXPLIB/1q1M0/sbhCYec3Kpjd1QriCjO5mNR1iOnefl6VsAo7M/MTGvLJGsrKaqfsSCMYb
 L7KG8rfu8kd/OjXc0oL7N1EIcjHf9fzJS1xNyKOgTds2kzWlHP8mubFzySKwTc19CHJQ51qgo
 py0nbEm9jac3RR09S9gstqr8OGEkxH4O7d1g8uxinKK5xLLUGW129ZcRjQWwrxkfkIjJ6as3G
 2IIhS1mqvsh8dP7or52uNvPR6tiyxwePa7QT8/A7ghsJ/IyWHLpZjUW98AwBOdbP/Fhcz/dU8
 bJcj3ooA9MwkzpcyRqg85wPztd7M7JIdj08prwnymILsBvnMO+8aGRj45XaQb/3K+Wx0EDx8k
 Soqy/pKwglc2a6OAD8CqfxmS8hf7i9wXQMEBupL/22XLoqp9dU/TKBsVm+l2n0oOYyCe1o0bj
 fZfZIXsgGpQDcFiaZt66nmNuAc1OjREDo9MO8Y3cA6082coiaCG8i5fUQYhYo/D5qXXMpoT
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is one of the last users of get_fs(), and this is fairly easy to
change, since the infrastructure for it is already there.

The replacement here is essentially a copy of the existing fcntl64()
syscall entry function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/sys_oabi-compat.c | 93 ++++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 33 deletions(-)

diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index c3e63b73b6ae..3449e163ea88 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -194,56 +194,83 @@ struct oabi_flock64 {
 	pid_t	l_pid;
 } __attribute__ ((packed,aligned(4)));
 
-static long do_locks(unsigned int fd, unsigned int cmd,
-				 unsigned long arg)
+static int get_oabi_flock(struct flock64 *kernel, struct oabi_flock64 __user *arg)
 {
-	struct flock64 kernel;
 	struct oabi_flock64 user;
-	mm_segment_t fs;
-	long ret;
 
 	if (copy_from_user(&user, (struct oabi_flock64 __user *)arg,
 			   sizeof(user)))
 		return -EFAULT;
-	kernel.l_type	= user.l_type;
-	kernel.l_whence	= user.l_whence;
-	kernel.l_start	= user.l_start;
-	kernel.l_len	= user.l_len;
-	kernel.l_pid	= user.l_pid;
-
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = sys_fcntl64(fd, cmd, (unsigned long)&kernel);
-	set_fs(fs);
-
-	if (!ret && (cmd == F_GETLK64 || cmd == F_OFD_GETLK)) {
-		user.l_type	= kernel.l_type;
-		user.l_whence	= kernel.l_whence;
-		user.l_start	= kernel.l_start;
-		user.l_len	= kernel.l_len;
-		user.l_pid	= kernel.l_pid;
-		if (copy_to_user((struct oabi_flock64 __user *)arg,
-				 &user, sizeof(user)))
-			ret = -EFAULT;
-	}
-	return ret;
+
+	kernel->l_type	 = user.l_type;
+	kernel->l_whence = user.l_whence;
+	kernel->l_start	 = user.l_start;
+	kernel->l_len	 = user.l_len;
+	kernel->l_pid	 = user.l_pid;
+
+	return 0;
+}
+
+static int put_oabi_flock(struct flock64 *kernel, struct oabi_flock64 __user *arg)
+{
+	struct oabi_flock64 user;
+
+	user.l_type	= kernel->l_type;
+	user.l_whence	= kernel->l_whence;
+	user.l_start	= kernel->l_start;
+	user.l_len	= kernel->l_len;
+	user.l_pid	= kernel->l_pid;
+
+	if (copy_to_user((struct oabi_flock64 __user *)arg,
+			 &user, sizeof(user)))
+		return -EFAULT;
+
+	return 0;
 }
 
 asmlinkage long sys_oabi_fcntl64(unsigned int fd, unsigned int cmd,
 				 unsigned long arg)
 {
+	void __user *argp = (void __user *)arg;
+	struct fd f = fdget_raw(fd);
+	struct flock64 flock;
+	long err = -EBADF;
+
+	if (!f.file)
+		goto out;
+
 	switch (cmd) {
-	case F_OFD_GETLK:
-	case F_OFD_SETLK:
-	case F_OFD_SETLKW:
 	case F_GETLK64:
+	case F_OFD_GETLK:
+		err = security_file_fcntl(f.file, cmd, arg);
+		if (err)
+			break;
+		err = get_oabi_flock(&flock, argp);
+		if (err)
+			break;
+		err = fcntl_getlk64(f.file, cmd, &flock);
+		if (!err)
+		       err = put_oabi_flock(&flock, argp);
+		break;
 	case F_SETLK64:
 	case F_SETLKW64:
-		return do_locks(fd, cmd, arg);
-
+	case F_OFD_SETLK:
+	case F_OFD_SETLKW:
+		err = security_file_fcntl(f.file, cmd, arg);
+		if (err)
+			break;
+		err = get_oabi_flock(&flock, argp);
+		if (err)
+			break;
+		err = fcntl_setlk64(fd, f.file, cmd, &flock);
+		break;
 	default:
-		return sys_fcntl64(fd, cmd, arg);
+		err = sys_fcntl64(fd, cmd, arg);
+		break;
 	}
+	fdput(f);
+out:
+	return err;
 }
 
 struct oabi_epoll_event {
-- 
2.27.0

