Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122B426FD53
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 14:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgIRMrP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 08:47:15 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:36235 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgIRMrE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 08:47:04 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M8Qme-1kNfdU10s4-004WgL; Fri, 18 Sep 2020 14:46:36 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 7/9] ARM: oabi-compat: rework fcntl64() emulation
Date:   Fri, 18 Sep 2020 14:46:22 +0200
Message-Id: <20200918124624.1469673-8-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200918124624.1469673-1-arnd@arndb.de>
References: <20200918124624.1469673-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tgHAPjFkzbmCrE0bFNFXx5gUKVFkZULUnNl2Z7bJY7N2qHCsD2v
 KxA9/gMyrAyTOk65mT0VC7GjVFiG99ZMfH+CIhQ0T1DD7tfV2JfILE0v1H2uYUBsV5kjCpL
 qLV+hvKw7tDTD40FdC3n7sRHdoOYJpdAHcojUvWic/8qS5523SKEc/J45k3v22gNJgeqI8C
 HOs5NKWBB8JUnW1iHNDVg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XydK1/HE+Ug=:asvyqVorczkPh2fDmcWUGN
 j8hUN9gPSeVltl6iGMiZRMS05l42B7/+fQQQNLJj3OJFM7MOvbcaX72mx+BGyQnQBjmIHSZVP
 2+3SW23PCJrtj199P0S5UQhas0UQzwFtb2nCK1B1s9G+s5PIGmAQUHAcGQ75C+PKch1j+9cYB
 ym9vb+W/SWOdHaTyrJ2qY6j2gJWcHyWFmt1H1Mt3ifleR8dRqvzzkk0tcyfMREZ1hN6e1Q8oi
 5N8kGpzuffwapvoVDP8oInvunl/fFhUQIZODLY782dWmx5gn69kokGGNtsSPpGWzZNVsiozln
 tsDPdRm0/aHcyEsdz74d3d8+Gh7t5ujxOBCjv0pQu7/yKOc/s6uWohlNj+JVKltZ3pDDunPZg
 xIyAtZ24zdriKQBI/I8rbff/zsA1ix7JDbZfYW2Mp30sVuO9t/4M2e8NvN1BGRJtRY77iLbzB
 //ombsiWgpJNTuLZCMM13xnm7xvkktLe58dXXgLXBLhSbwUi//BkZ9/EvbMtrGa/A9WAISPGG
 Ea8z/7rxsTnmf1e1Hil8w/5NyBf5r9qwkHqMaruWnntagzAfYmpU2vfp5NGLFm8fnu4A7u/12
 MMIlPRxsZMSPQomGdMLAFuZw1xRzb4P9wdn3jJa0Ohf+4bDA597mO1XbhgGBs85MBsD2vP+uo
 Ch8SZpqlrpcUBTquaGqFI1+CCB3dj3qbNalb+denOuQ3os14KBWr1yKuUO/jlusIHcQk06jM0
 UOwMy2QrJifGnazzd7Fw8IkI09qe9wxHyEzniBCVTl3n8Qd6d2yOOJgp9+6NIujTxNCg+p5+P
 BINOjwEUFesVaPmeHU4r+3a/zCoCA85viYsnq4lBYvxpJbsYEO0BYeaCXAq+PF8slF1bfrU
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

