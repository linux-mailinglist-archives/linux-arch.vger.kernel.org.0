Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BDC20D1AC
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 20:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgF2Smx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 14:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbgF2Smw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:52 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC33C033C14;
        Mon, 29 Jun 2020 11:26:31 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUA-002Duf-Du; Mon, 29 Jun 2020 18:26:30 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 18/41] regset: new method and helpers for it
Date:   Mon, 29 Jun 2020 19:26:05 +0100
Message-Id: <20200629182628.529995-18-viro@ZenIV.linux.org.uk>
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

->get2() takes task+regset+buffer, returns the amount of free space
left in the buffer on success and -E... on error.

buffer is represented as struct membuf - a pair of (kernel) pointer
and amount of space left

Primitives for writing to such:
	* membuf_write(buf, data, size)
	* membuf_zero(buf, size)
	* membuf_store(buf, value)

These are implemented as inlines (in case of membuf_store - a macro).
All writes are sequential; they become no-ops when there's no space
left.  Return value of all primitives is the amount of space left
after the operation, so they can be used as return values of ->get2().

Example of use:

// stores pt_regs of task + 64 bytes worth of zeroes + 32bit PID of task
int foo_get(struct task_struct *task, const struct regset *regset,
	    struct membuf to)
{
	membuf_write(&to, task_pt_regs(task), sizeof(struct pt_regs));
	membuf_zero(&to, 64);
	return membuf_store(&to, (u32)task_tgid_vnr(task));
}

regset_get()/regset_get_alloc() taught to use that thing if present.
By the end of the series all users of ->get() will be converted;
then ->get() and ->get_size() can go.

Note that unlike ->get() this thing always starts at offset 0 and,
since it only writes to kernel buffer, can't fail on copyout.
It can, of course, fail for other reasons, but those tend to
be less numerous.

The caller guarantees that the buffer size won't be bigger than
regset->n * regset->size.  That simplifies life for quite a few
instances.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/regset.h | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/regset.c        | 12 +++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/include/linux/regset.h b/include/linux/regset.h
index af57c1db1924..567a4b63f469 100644
--- a/include/linux/regset.h
+++ b/include/linux/regset.h
@@ -17,6 +17,52 @@
 struct task_struct;
 struct user_regset;
 
+struct membuf {
+	void *p;
+	size_t left;
+};
+
+static inline int membuf_zero(struct membuf *s, size_t size)
+{
+	if (s->left) {
+		if (size > s->left)
+			size = s->left;
+		memset(s->p, 0, size);
+		s->p += size;
+		s->left -= size;
+	}
+	return s->left;
+}
+
+static inline int membuf_write(struct membuf *s, const void *v, size_t size)
+{
+	if (s->left) {
+		if (size > s->left)
+			size = s->left;
+		memcpy(s->p, v, size);
+		s->p += size;
+		s->left -= size;
+	}
+	return s->left;
+}
+
+/* current s->p must be aligned for v; v must be a scalar */
+#define membuf_store(s, v)				\
+({							\
+	struct membuf *__s = (s);			\
+        if (__s->left) {				\
+		typeof(v) __v = (v);			\
+		size_t __size = sizeof(__v);		\
+		if (unlikely(__size > __s->left)) {	\
+			__size = __s->left;		\
+			memcpy(__s->p, &__v, __size);	\
+		} else {				\
+			*(typeof(__v + 0) *)__s->p = __v;	\
+		}					\
+		__s->p += __size;			\
+		__s->left -= __size;			\
+	}						\
+	__s->left;})
 
 /**
  * user_regset_active_fn - type of @active function in &struct user_regset
@@ -57,6 +103,10 @@ typedef int user_regset_get_fn(struct task_struct *target,
 			       unsigned int pos, unsigned int count,
 			       void *kbuf, void __user *ubuf);
 
+typedef int user_regset_get2_fn(struct task_struct *target,
+			       const struct user_regset *regset,
+			       struct membuf to);
+
 /**
  * user_regset_set_fn - type of @set function in &struct user_regset
  * @target:	thread being examined
@@ -186,6 +236,7 @@ typedef unsigned int user_regset_get_size_fn(struct task_struct *target,
  */
 struct user_regset {
 	user_regset_get_fn		*get;
+	user_regset_get2_fn		*get2;
 	user_regset_set_fn		*set;
 	user_regset_active_fn		*active;
 	user_regset_writeback_fn	*writeback;
diff --git a/kernel/regset.c b/kernel/regset.c
index 0a610983ce43..c548fb9f0943 100644
--- a/kernel/regset.c
+++ b/kernel/regset.c
@@ -11,7 +11,7 @@ static int __regset_get(struct task_struct *target,
 	void *p = *data, *to_free = NULL;
 	int res;
 
-	if (!regset->get)
+	if (!regset->get && !regset->get2)
 		return -EOPNOTSUPP;
 	if (size > regset->n * regset->size)
 		size = regset->n * regset->size;
@@ -20,6 +20,16 @@ static int __regset_get(struct task_struct *target,
 		if (!p)
 			return -ENOMEM;
 	}
+	if (regset->get2) {
+		res = regset->get2(target, regset,
+				   (struct membuf){.p = p, .left = size});
+		if (res < 0) {
+			kfree(to_free);
+			return res;
+		}
+		*data = p;
+		return size - res;
+	}
 	res = regset->get(target, regset, 0, size, p, NULL);
 	if (unlikely(res < 0)) {
 		kfree(to_free);
-- 
2.11.0

