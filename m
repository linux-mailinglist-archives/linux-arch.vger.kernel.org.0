Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD8FE31549
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2019 21:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfEaTXx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 May 2019 15:23:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44105 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbfEaTXw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 15:23:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so4548766pgp.11
        for <linux-arch@vger.kernel.org>; Fri, 31 May 2019 12:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=jkiS8/qpTY6k4aMdDFBf1DTvMrA5045OTYV2nSZG2vg=;
        b=H/yjc3arN6xUbtwwVp12DWz7qNU/s17Fs4bLR6X4Fuj03MrP2++69gZklsStFI/coI
         XRyG9EoVQzlGvzRS6WeMHD85ZST1O4aQ1KYVx9K8hW/AxpSP79pE73NPjzyrZEA0lKfU
         O4g1nuogm91vq3QFVI7XdKmcX4vLwdUS6qDEAE3z98slv9wfS3K4aX1nr6cwPx5HAHsk
         NmdmzxB//V/DB7Z80eBcoRjipK94SARiciuIo/AQD8zyoVfAxaKQdDVvfnRARXXmpP7a
         U6SCCFqPAgUfEB4BSaYk4LOjHkAHSIN3gtlm4f4dumK8AQSeUwiRnu1/lkhmETKIsxVZ
         G88Q==
X-Gm-Message-State: APjAAAX2IhbN1y9JPGFoH5o0FEmBqz7q9FYkzdDO4th4+1IUwX0U6Pyx
        8WqcN1LstH1Etb4FYZLLHl8zltbdvgQ=
X-Google-Smtp-Source: APXvYqzOAHJ0yUdwkya1vFOdq3ZwH6YKGgpG1m54T+h5FGeOO4XVr55bLfMFMFpkBP4Vym1mdvxJ/A==
X-Received: by 2002:a17:90a:c58b:: with SMTP id l11mr11650722pjt.56.1559330631558;
        Fri, 31 May 2019 12:23:51 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id s2sm7286629pfe.105.2019.05.31.12.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 12:23:51 -0700 (PDT)
Subject: [PATCH 2/5] Add fchmodat4(), a new syscall
Date:   Fri, 31 May 2019 12:12:01 -0700
Message-Id: <20190531191204.4044-3-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190531191204.4044-1-palmer@sifive.com>
References: <20190531191204.4044-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux-arch@vger.kernel.org, x86@kernel.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

man 3p says that fchmodat() takes a flags argument, but the Linux
syscall does not.  There doesn't appear to be a good userspace
workaround for this issue but the implementation in the kernel is pretty
straight-forward.  The specific use case where the missing flags came up
was WRT a fuse filesystem implemenation, but the functionality is pretty
generic so I'm assuming there would be other use cases.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 fs/open.c                | 21 +++++++++++++++++++--
 include/linux/syscalls.h |  5 +++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index a00350018a47..cfad7684e8d3 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -568,11 +568,17 @@ SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
 	return ksys_fchmod(fd, mode);
 }
 
-int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
+int do_fchmodat4(int dfd, const char __user *filename, umode_t mode, int flags)
 {
 	struct path path;
 	int error;
-	unsigned int lookup_flags = LOOKUP_FOLLOW;
+	unsigned int lookup_flags;
+
+	if (unlikely(flags & ~AT_SYMLINK_NOFOLLOW))
+		return -EINVAL;
+
+	lookup_flags = flags & AT_SYMLINK_NOFOLLOW ? 0 : LOOKUP_FOLLOW;
+
 retry:
 	error = user_path_at(dfd, filename, lookup_flags, &path);
 	if (!error) {
@@ -586,6 +592,17 @@ int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
 	return error;
 }
 
+SYSCALL_DEFINE4(fchmodat4, int, dfd, const char __user *, filename,
+		umode_t, mode, int, flags)
+{
+	return do_fchmodat4(dfd, filename, mode, flags);
+}
+
+int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
+{
+	return do_fchmodat4(dfd, filename, mode, 0);
+}
+
 SYSCALL_DEFINE3(fchmodat, int, dfd, const char __user *, filename,
 		umode_t, mode)
 {
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 396871b218f4..cb040a412a4c 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -435,6 +435,8 @@ asmlinkage long sys_chroot(const char __user *filename);
 asmlinkage long sys_fchmod(unsigned int fd, umode_t mode);
 asmlinkage long sys_fchmodat(int dfd, const char __user *filename,
 			     umode_t mode);
+asmlinkage long sys_fchmodat4(int dfd, const char __user *filename,
+			     umode_t mode, int flags);
 asmlinkage long sys_fchownat(int dfd, const char __user *filename, uid_t user,
 			     gid_t group, int flag);
 asmlinkage long sys_fchown(unsigned int fd, uid_t user, gid_t group);
@@ -1315,6 +1317,9 @@ static inline long ksys_link(const char __user *oldname,
 
 extern int do_fchmodat(int dfd, const char __user *filename, umode_t mode);
 
+extern int do_fchmodat4(int dfd, const char __user *filename, umode_t mode,
+			int flags);
+
 static inline int ksys_chmod(const char __user *filename, umode_t mode)
 {
 	return do_fchmodat(AT_FDCWD, filename, mode);
-- 
2.21.0

