Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69FE25C33D
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 16:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgICOrZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 10:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbgICOYg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 10:24:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FF5C06123C;
        Thu,  3 Sep 2020 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WnUT44U564BtTxR+CgxY1D0BXTu5a2MR+R2q2mWaxn8=; b=npobupm2FJ/ShjeQU9TdFnBhkM
        nPVNuPixcBkXw7gWQKCAmSY+n3xIY3Jrg7bEy2hQADLEiwj4hgfgufJEEOyrwvHXFGRF3nG9HKKYw
        Ecs708Q625fTF0Sp0UaDzkrCiGwe1LzKGi2UO3jMIFrmaPOD5ArD63EPQYApmj68a63R6WcB7SsJQ
        5cXErqx6Mijk7YBgwUeqEZsxUv428r0sFr9s+XqIapqDQrum3Hoj+5Z/mD2V60gLriQpLz//TW+iJ
        pLhxJafohAeOwbHCpmOeyfDf5esfLuvbGfSASzk/uuFoWQdAbsswQsEWZltKYegGfyKF3/+RxJ7Aq
        yBS/n+Pw==;
Received: from [2001:4bb8:184:af1:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDq8X-0004aj-UW; Thu, 03 Sep 2020 14:22:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/14] fs: don't allow kernel reads and writes without iter ops
Date:   Thu,  3 Sep 2020 16:22:33 +0200
Message-Id: <20200903142242.925828-6-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903142242.925828-1-hch@lst.de>
References: <20200903142242.925828-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Don't allow calling ->read or ->write with set_fs as a preparation for
killing off set_fs.  All the instances that we use kernel_read/write on
are using the iter ops already.

If a file has both the regular ->read/->write methods and the iter
variants those could have different semantics for messed up enough
drivers.  Also fails the kernel access to them in that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 fs/read_write.c | 67 +++++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 25 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 5db58b8c78d0dd..702c4301d9eb6b 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -419,27 +419,41 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
 	return ret;
 }
 
+static int warn_unsupported(struct file *file, const char *op)
+{
+	pr_warn_ratelimited(
+		"kernel %s not supported for file %pD4 (pid: %d comm: %.20s)\n",
+		op, file, current->pid, current->comm);
+	return -EINVAL;
+}
+
 ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 {
-	mm_segment_t old_fs = get_fs();
+	struct kvec iov = {
+		.iov_base	= buf,
+		.iov_len	= min_t(size_t, count, MAX_RW_COUNT),
+	};
+	struct kiocb kiocb;
+	struct iov_iter iter;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_READ)))
 		return -EINVAL;
 	if (!(file->f_mode & FMODE_CAN_READ))
 		return -EINVAL;
+	/*
+	 * Also fail if ->read_iter and ->read are both wired up as that
+	 * implies very convoluted semantics.
+	 */
+	if (unlikely(!file->f_op->read_iter || file->f_op->read))
+		return warn_unsupported(file, "read");
 
-	if (count > MAX_RW_COUNT)
-		count =  MAX_RW_COUNT;
-	set_fs(KERNEL_DS);
-	if (file->f_op->read)
-		ret = file->f_op->read(file, (void __user *)buf, count, pos);
-	else if (file->f_op->read_iter)
-		ret = new_sync_read(file, (void __user *)buf, count, pos);
-	else
-		ret = -EINVAL;
-	set_fs(old_fs);
+	init_sync_kiocb(&kiocb, file);
+	kiocb.ki_pos = *pos;
+	iov_iter_kvec(&iter, READ, &iov, 1, iov.iov_len);
+	ret = file->f_op->read_iter(&kiocb, &iter);
 	if (ret > 0) {
+		*pos = kiocb.ki_pos;
 		fsnotify_access(file);
 		add_rchar(current, ret);
 	}
@@ -510,28 +524,31 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
 /* caller is responsible for file_start_write/file_end_write */
 ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
 {
-	mm_segment_t old_fs;
-	const char __user *p;
+	struct kvec iov = {
+		.iov_base	= (void *)buf,
+		.iov_len	= min_t(size_t, count, MAX_RW_COUNT),
+	};
+	struct kiocb kiocb;
+	struct iov_iter iter;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_WRITE)))
 		return -EBADF;
 	if (!(file->f_mode & FMODE_CAN_WRITE))
 		return -EINVAL;
+	/*
+	 * Also fail if ->write_iter and ->write are both wired up as that
+	 * implies very convoluted semantics.
+	 */
+	if (unlikely(!file->f_op->write_iter || file->f_op->write))
+		return warn_unsupported(file, "write");
 
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	p = (__force const char __user *)buf;
-	if (count > MAX_RW_COUNT)
-		count =  MAX_RW_COUNT;
-	if (file->f_op->write)
-		ret = file->f_op->write(file, p, count, pos);
-	else if (file->f_op->write_iter)
-		ret = new_sync_write(file, p, count, pos);
-	else
-		ret = -EINVAL;
-	set_fs(old_fs);
+	init_sync_kiocb(&kiocb, file);
+	kiocb.ki_pos = *pos;
+	iov_iter_kvec(&iter, WRITE, &iov, 1, iov.iov_len);
+	ret = file->f_op->write_iter(&kiocb, &iter);
 	if (ret > 0) {
+		*pos = kiocb.ki_pos;
 		fsnotify_modify(file);
 		add_wchar(current, ret);
 	}
-- 
2.28.0

