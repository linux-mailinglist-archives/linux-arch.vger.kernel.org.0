Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E345E25FD57
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 17:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgIGPmL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 11:42:11 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:56407 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730200AbgIGPjl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 11:39:41 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MAORp-1kQ5023Wyx-00Bvxy; Mon, 07 Sep 2020 17:39:25 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@lst.de>,
        Russell King <rmk@arm.linux.org.uk>,
        Russell King <linux@armlinux.org.uk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linus.walleij@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] ARM: oabi-compat: rework fcntl64() emulation
Date:   Mon,  7 Sep 2020 17:36:48 +0200
Message-Id: <20200907153701.2981205-8-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200907153701.2981205-1-arnd@arndb.de>
References: <20200907153701.2981205-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iM3qzQMw61BcTGiic5QvpuR9DDlQ2H9fxdB7ia6fbwKIF2rg5p2
 V18En2TVQVNG4HbPQ2wa7eIIqALISwGgeXc1mmgLE5Je3OZh2qIdhV+YjlwP5SU30hRd2yS
 rx/WWztONnhHPkSV+3Zf5cVgLOhS3dyTBZMeeVNPAcm3O8lRFzxlV+SDTnM52bhDb7mGHsB
 +h5osVMZ5Ta9LTH4J0Vgw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:s60HJleClaw=:lbmhK3Xm/0z9REWma3f77D
 cMoqTTOR2LwDWRq6qlTcEar8Q4fy61sav0V1g9eHzmC4ndwEo9mShY2d0oyZkosycaqPYK4Q2
 +ZdNNgagoWe7M4yqiF8Y+lJSNKqVT5K64zXzLOGeUNjRVT8e/vYNnolbe+i9rZZygsue6If7Q
 gXeF6gFM4Bn/rn5fKLnjmyYrCMkV7q79vhbhj8XnJbHManeDG4SgtaXmAX5igex0UEVubqCfm
 kAkMiJYF2JsiudZxo4YOvhObQ68K2NPhhWeSx3wLqKB/pYElDKw0fAMSMV9lt8W/ixqLgd4/2
 EIBqMDe7/qh8t7QN5W2N5T5o2HaAiCxHzj8zfR2uLgOdFQlS2rC5bYoUJIwktjJwa2a2+ITno
 X4zkp+ob8HDpEgF5UreZ3s8/T31EkHUqYmhCRkFu++iqQzDFay94bGK0l96dOngXFQzbjCeTn
 e0zKR07k6sYB2oPrq18q6RVaWNuOu5PdfDcuT+/59Oopy0EkvuW17Nt/+x4G7jaZ8tx8mo/vR
 o3WnOpCd9WLRErMXxtyI7rhyw2eF9rfWC1V6wXNPcdCjja44utbhsA26vKatI6CCgIVnGpmEi
 8uScto1tfUrhNC1cgG6IMnpy3tAgfwFIbhw8SbLHpyHm1s2xFMdi/DhKh+FdKRG0qs+8jBrvC
 NjkIaSB6KVaMxKSJMr8V8NbcP4++mMiZDqXzHFN/xyeVIvHIKyFXolRxluhRsh7zwvbISumCk
 xITHajoFxmT1Rb3pS1IrtxPOytKvripyv9NMcSrpkDguIKa86ZFrQxc6f/MJOoXMKrlNI5Szu
 wdjlP49Lq+7yzbdCsttR3WU/sygLGgHQAFEXPEuI0leE8DP2S+0+VwaqNhBhJChtOVGGY+y
Sender: linux-arch-owner@vger.kernel.org
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
index d3c6460d13ca..13956d5e50d7 100644
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

