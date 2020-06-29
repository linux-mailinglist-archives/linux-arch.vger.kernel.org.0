Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E304420D1CB
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 20:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgF2Snw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 14:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbgF2Smw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:52 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8E3C033C1F;
        Mon, 29 Jun 2020 11:26:33 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUA-002DuZ-9w; Mon, 29 Jun 2020 18:26:30 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 17/41] copy_regset_to_user(): do all copyout at once.
Date:   Mon, 29 Jun 2020 19:26:04 +0100
Message-Id: <20200629182628.529995-17-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Turn copy_regset_to_user() into regset_get_alloc() + copy_to_user().
Now all ->get() calls have a kernel buffer as destination.

Note that we'd already eliminated the callers of copy_regset_to_user()
with non-zero offset; now that argument is simply unused.

Uninlined, while we are at it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/regset.h | 29 ++++-------------------------
 kernel/regset.c        | 26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/include/linux/regset.h b/include/linux/regset.h
index 968a032922d5..af57c1db1924 100644
--- a/include/linux/regset.h
+++ b/include/linux/regset.h
@@ -362,31 +362,10 @@ extern int regset_get_alloc(struct task_struct *target,
 			    unsigned int size,
 			    void **data);
 
-/**
- * copy_regset_to_user - fetch a thread's user_regset data into user memory
- * @target:	thread to be examined
- * @view:	&struct user_regset_view describing user thread machine state
- * @setno:	index in @view->regsets
- * @offset:	offset into the regset data, in bytes
- * @size:	amount of data to copy, in bytes
- * @data:	user-mode pointer to copy into
- */
-static inline int copy_regset_to_user(struct task_struct *target,
-				      const struct user_regset_view *view,
-				      unsigned int setno,
-				      unsigned int offset, unsigned int size,
-				      void __user *data)
-{
-	const struct user_regset *regset = &view->regsets[setno];
-
-	if (!regset->get)
-		return -EOPNOTSUPP;
-
-	if (!access_ok(data, size))
-		return -EFAULT;
-
-	return regset->get(target, regset, offset, size, NULL, data);
-}
+extern int copy_regset_to_user(struct task_struct *target,
+			       const struct user_regset_view *view,
+			       unsigned int setno, unsigned int offset,
+			       unsigned int size, void __user *data);
 
 /**
  * copy_regset_from_user - store into thread's user_regset data from user memory
diff --git a/kernel/regset.c b/kernel/regset.c
index 6b39fa0993ec..0a610983ce43 100644
--- a/kernel/regset.c
+++ b/kernel/regset.c
@@ -52,3 +52,29 @@ int regset_get_alloc(struct task_struct *target,
 	return __regset_get(target, regset, size, data);
 }
 EXPORT_SYMBOL(regset_get_alloc);
+
+/**
+ * copy_regset_to_user - fetch a thread's user_regset data into user memory
+ * @target:	thread to be examined
+ * @view:	&struct user_regset_view describing user thread machine state
+ * @setno:	index in @view->regsets
+ * @offset:	offset into the regset data, in bytes
+ * @size:	amount of data to copy, in bytes
+ * @data:	user-mode pointer to copy into
+ */
+int copy_regset_to_user(struct task_struct *target,
+			const struct user_regset_view *view,
+			unsigned int setno,
+			unsigned int offset, unsigned int size,
+			void __user *data)
+{
+	const struct user_regset *regset = &view->regsets[setno];
+	void *buf;
+	int ret;
+
+	ret = regset_get_alloc(target, regset, size, &buf);
+	if (ret > 0)
+		ret = copy_to_user(data, buf, ret) ? -EFAULT : 0;
+	kfree(buf);
+	return ret;
+}
-- 
2.11.0

