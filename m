Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D0A20E482
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388856AbgF2V0D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgF2Smr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:47 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F242C033C2D;
        Mon, 29 Jun 2020 11:26:35 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUE-002Dy4-34; Mon, 29 Jun 2020 18:26:34 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 39/41] regset: kill ->get()
Date:   Mon, 29 Jun 2020 19:26:26 +0100
Message-Id: <20200629182628.529995-39-viro@ZenIV.linux.org.uk>
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

no instances left

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/regset.h | 22 ----------------------
 kernel/regset.c        | 24 +++++-------------------
 2 files changed, 5 insertions(+), 41 deletions(-)

diff --git a/include/linux/regset.h b/include/linux/regset.h
index 567a4b63f469..eeabf5cbbbd7 100644
--- a/include/linux/regset.h
+++ b/include/linux/regset.h
@@ -82,27 +82,6 @@ static inline int membuf_write(struct membuf *s, const void *v, size_t size)
 typedef int user_regset_active_fn(struct task_struct *target,
 				  const struct user_regset *regset);
 
-/**
- * user_regset_get_fn - type of @get function in &struct user_regset
- * @target:	thread being examined
- * @regset:	regset being examined
- * @pos:	offset into the regset data to access, in bytes
- * @count:	amount of data to copy, in bytes
- * @kbuf:	if not %NULL, a kernel-space pointer to copy into
- * @ubuf:	if @kbuf is %NULL, a user-space pointer to copy into
- *
- * Fetch register values.  Return %0 on success; -%EIO or -%ENODEV
- * are usual failure returns.  The @pos and @count values are in
- * bytes, but must be properly aligned.  If @kbuf is non-null, that
- * buffer is used and @ubuf is ignored.  If @kbuf is %NULL, then
- * ubuf gives a userland pointer to access directly, and an -%EFAULT
- * return value is possible.
- */
-typedef int user_regset_get_fn(struct task_struct *target,
-			       const struct user_regset *regset,
-			       unsigned int pos, unsigned int count,
-			       void *kbuf, void __user *ubuf);
-
 typedef int user_regset_get2_fn(struct task_struct *target,
 			       const struct user_regset *regset,
 			       struct membuf to);
@@ -235,7 +214,6 @@ typedef unsigned int user_regset_get_size_fn(struct task_struct *target,
  * omitted when there is an @active function and it returns zero.
  */
 struct user_regset {
-	user_regset_get_fn		*get;
 	user_regset_get2_fn		*get2;
 	user_regset_set_fn		*set;
 	user_regset_active_fn		*active;
diff --git a/kernel/regset.c b/kernel/regset.c
index c548fb9f0943..592d90fc13f9 100644
--- a/kernel/regset.c
+++ b/kernel/regset.c
@@ -11,7 +11,7 @@ static int __regset_get(struct task_struct *target,
 	void *p = *data, *to_free = NULL;
 	int res;
 
-	if (!regset->get && !regset->get2)
+	if (!regset->get2)
 		return -EOPNOTSUPP;
 	if (size > regset->n * regset->size)
 		size = regset->n * regset->size;
@@ -20,28 +20,14 @@ static int __regset_get(struct task_struct *target,
 		if (!p)
 			return -ENOMEM;
 	}
-	if (regset->get2) {
-		res = regset->get2(target, regset,
-				   (struct membuf){.p = p, .left = size});
-		if (res < 0) {
-			kfree(to_free);
-			return res;
-		}
-		*data = p;
-		return size - res;
-	}
-	res = regset->get(target, regset, 0, size, p, NULL);
-	if (unlikely(res < 0)) {
+	res = regset->get2(target, regset,
+			   (struct membuf){.p = p, .left = size});
+	if (res < 0) {
 		kfree(to_free);
 		return res;
 	}
 	*data = p;
-	if (regset->get_size) { // arm64-only kludge, will go away
-		unsigned max_size = regset->get_size(target, regset);
-		if (size > max_size)
-			size = max_size;
-	}
-	return size;
+	return size - res;
 }
 
 int regset_get(struct task_struct *target,
-- 
2.11.0

