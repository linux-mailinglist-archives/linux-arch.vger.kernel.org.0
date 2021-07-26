Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6B13D5B11
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 16:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhGZNbk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 09:31:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234398AbhGZNbc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Jul 2021 09:31:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CEF360560;
        Mon, 26 Jul 2021 14:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627308721;
        bh=k/+0BZVT585d7LUcyfp2e8qjSIzc/iRFeep7rM6abm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BDqgP1ODlxzPWY/5clREbQWr4CDGiw84LHLWwYuRndOlHCJ/eg631+MMGzxold+li
         smxh4VUWITzTdBiGdQiDlZR5LCSNQ6H4FaM9oJmwiVDEsbPyVk4g8tUs4zxQEBVygd
         jbHQLoX8ouYmFOPkJvdTojD5fnxq0ceq/zZBoufSV9SYflQKMNCv02pPa7z8A2x09g
         P6fGt7mcplSy8Ra7HoJ14AQtA4ApJ3AHtliHyFFY9x/y78xpfSRIkm4rI0XfdCoStu
         YsQ4VICijEoSlCbntQOktrM7x+Z7BVzhkgP91FOv4ZZwGvEuM43Eit+LlfuZ07YUBW
         dwrgNm44IQOwg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v5 07/10] ARM: oabi-compat: rework fcntl64() emulation
Date:   Mon, 26 Jul 2021 16:11:38 +0200
Message-Id: <20210726141141.2839385-8-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210726141141.2839385-1-arnd@kernel.org>
References: <20210726141141.2839385-1-arnd@kernel.org>
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
index 5ea365c35ca5..223ee46b6e75 100644
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
2.29.2

