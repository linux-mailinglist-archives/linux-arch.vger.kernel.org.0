Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BC92A0A4F
	for <lists+linux-arch@lfdr.de>; Fri, 30 Oct 2020 16:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbgJ3Ptq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 11:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbgJ3Pto (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Oct 2020 11:49:44 -0400
Received: from localhost.localdomain (HSI-KBW-46-223-126-90.hsi.kabel-badenwuerttemberg.de [46.223.126.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B43B22241;
        Fri, 30 Oct 2020 15:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604072983;
        bh=Mx21NEzsW0sqOlRSKKtH114cIyZ8zXg4jMUbhna5VF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ugPQTkip7iCrZSHrqBz6Pc8ED6zMvRtbryCcPbLZLzqUBWWz6eL+SfaLIu5/pSc6V
         TS+HeRVtV2vG7RW/aipBaP6YOToLXIC/1wQbnJfLxsTA22Cfp/tGzuBNIK8DWVVd2Q
         CGoec7enG38Hfk3qgtSkzJ35WeM5bIJXZf0w67YQ=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        viro@zeniv.linux.org.uk, linus.walleij@linaro.org, arnd@arndb.de
Subject: [PATCH 7/9] ARM: oabi-compat: rework fcntl64() emulation
Date:   Fri, 30 Oct 2020 16:49:17 +0100
Message-Id: <20201030154919.1246645-7-arnd@kernel.org>
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

