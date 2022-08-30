Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54ECA5A6FFF
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 23:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiH3Vw4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 17:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiH3VwI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 17:52:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DC4901A4
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 14:50:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d135-20020a25688d000000b0069578d248abso726871ybc.21
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 14:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=k1RBq3yq4U5V/3OJ4fp4kBxfnryZ2+wdIlpTdmkxoTI=;
        b=VhiQWzTMcrdH+FaQQULhGR8WSlxfBOTth6dlvIbrF9tNsikpCPNZSCsVVNQzwya0+m
         inYdBoaJMW2SV4VMQbG9aeBgJRps+ez+XWS5k3Rur9K2IIy7JqKGimhHZpLDadEOC8jn
         mlaKyF5VrtiZ0WWLgSmcUKau4UWKqCVgLA42otcSHORATS4YZtKue2vIEn7FwP4yHe6S
         ZPXLk6/7AXcHQ83MkQ3/jShGMz5S5LOyBhJVZrkJyLThC9PcUD9ldyCOL0uzdDG1sb5M
         06MkPGxPeBa0aM/Evc6sFSslW/GhAWnvZBA8+PZrxcvSTvVlK9z1clRYSNWpN2i8rC4H
         SSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=k1RBq3yq4U5V/3OJ4fp4kBxfnryZ2+wdIlpTdmkxoTI=;
        b=InJLqfOhc953c5Pqb+/KlO6T88Mx2LF9J7G/lhaWdqOUrgqfQc1cndlj2FvVJVJjdj
         quIUTXqcLb54hVxTw2QbMatMzWVrE31Zujd4QBrRFiU7iEiLtqAi9Fbx9zBHvAEpDhJa
         e6qHe4jrYG2z7ApDAbMxHmnSyMV73P5FXUFrg+sQshyiWf1m3P0qF8xkIm0NxcfHXp5Z
         1ylrO0wWSFK0GDHDeSmHAOKgT7rOduxzKQXNFnsAserQ29hSGrP5HSii5p0JfDu9bJWk
         c4nK8NO2gwkIBAcbDG9TSh1I1Vj34QHqJP+RW3Kboi25pgPoK/hd/B8ETjY/z8GuCv4+
         LFog==
X-Gm-Message-State: ACgBeo1PSD0AnxrmxhEJHy4Yb1MSnqWVPtcr40EnROa2t5qkKtbylPCI
        2eUM4U3/QM6N5E6a2XZnqVE72+k6Jv8=
X-Google-Smtp-Source: AA6agR4708nF24x7XI3k0Gx9DyNo/OwdO20Vx8Uo0n79f6qJIllny6st9xxE+KwycAbaAtlsqzU8pt5cOBU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:a005:55b3:6c26:b3e4])
 (user=surenb job=sendgmr) by 2002:a25:ef45:0:b0:696:45b0:7b5d with SMTP id
 w5-20020a25ef45000000b0069645b07b5dmr12075882ybm.368.1661896216803; Tue, 30
 Aug 2022 14:50:16 -0700 (PDT)
Date:   Tue, 30 Aug 2022 14:49:09 -0700
In-Reply-To: <20220830214919.53220-1-surenb@google.com>
Mime-Version: 1.0
References: <20220830214919.53220-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830214919.53220-21-surenb@google.com>
Subject: [RFC PATCH 20/30] lib: introduce support for storing code tag context
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, changbin.du@intel.com, ytcoode@gmail.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
        elver@google.com, dvyukov@google.com, shakeelb@google.com,
        songmuchun@bytedance.com, arnd@arndb.de, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com, linux-mm@kvack.org,
        iommu@lists.linux.dev, kasan-dev@googlegroups.com,
        io-uring@vger.kernel.org, linux-arch@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add support for code tag context capture when registering a new code tag
type. When context capture for a specific code tag is enabled,
codetag_ref will point to a codetag_ctx object which can be attached
to an application-specific object storing code invocation context.
codetag_ctx has a pointer to its codetag_with_ctx object with embedded
codetag object in it. All context objects of the same code tag are placed
into codetag_with_ctx.ctx_head linked list. codetag.flag is used to
indicate when a context capture for the associated code tag is
initialized and enabled.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/codetag.h     |  50 +++++++++++++-
 include/linux/codetag_ctx.h |  48 +++++++++++++
 lib/codetag.c               | 134 ++++++++++++++++++++++++++++++++++++
 3 files changed, 231 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/codetag_ctx.h

diff --git a/include/linux/codetag.h b/include/linux/codetag.h
index 0c605417ebbe..57736ec77b45 100644
--- a/include/linux/codetag.h
+++ b/include/linux/codetag.h
@@ -5,8 +5,12 @@
 #ifndef _LINUX_CODETAG_H
 #define _LINUX_CODETAG_H
 
+#include <linux/container_of.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
+struct kref;
+struct codetag_ctx;
 struct codetag_iterator;
 struct codetag_type;
 struct seq_buf;
@@ -18,15 +22,38 @@ struct module;
  * an array of these.
  */
 struct codetag {
-	unsigned int flags; /* used in later patches */
+	unsigned int flags; /* has to be the first member shared with codetag_ctx */
 	unsigned int lineno;
 	const char *modname;
 	const char *function;
 	const char *filename;
 } __aligned(8);
 
+/* codetag_with_ctx flags */
+#define CTC_FLAG_CTX_PTR	(1 << 0)
+#define CTC_FLAG_CTX_READY	(1 << 1)
+#define CTC_FLAG_CTX_ENABLED	(1 << 2)
+
+/*
+ * Code tag with context capture support. Contains a list to store context for
+ * each tag hit, a lock protecting the list and a flag to indicate whether
+ * context capture is enabled for the tag.
+ */
+struct codetag_with_ctx {
+	struct codetag ct;
+	struct list_head ctx_head;
+	spinlock_t ctx_lock;
+} __aligned(8);
+
+/*
+ * Tag reference can point to codetag directly or indirectly via codetag_ctx.
+ * Direct codetag pointer is used when context capture is disabled or not
+ * supported. When context capture for the tag is used, the reference points
+ * to the codetag_ctx through which the codetag can be reached.
+ */
 union codetag_ref {
 	struct codetag *ct;
+	struct codetag_ctx *ctx;
 };
 
 struct codetag_range {
@@ -46,6 +73,7 @@ struct codetag_type_desc {
 			    struct codetag_module *cmod);
 	void (*module_unload)(struct codetag_type *cttype,
 			      struct codetag_module *cmod);
+	void (*free_ctx)(struct kref *ref);
 };
 
 struct codetag_iterator {
@@ -53,6 +81,7 @@ struct codetag_iterator {
 	struct codetag_module *cmod;
 	unsigned long mod_id;
 	struct codetag *ct;
+	struct codetag_ctx *ctx;
 };
 
 #define CODE_TAG_INIT {					\
@@ -63,9 +92,28 @@ struct codetag_iterator {
 	.flags		= 0,				\
 }
 
+static inline bool is_codetag_ctx_ref(union codetag_ref *ref)
+{
+	return !!(ref->ct->flags & CTC_FLAG_CTX_PTR);
+}
+
+static inline
+struct codetag_with_ctx *ct_to_ctc(struct codetag *ct)
+{
+	return container_of(ct, struct codetag_with_ctx, ct);
+}
+
 void codetag_lock_module_list(struct codetag_type *cttype, bool lock);
 struct codetag_iterator codetag_get_ct_iter(struct codetag_type *cttype);
 struct codetag *codetag_next_ct(struct codetag_iterator *iter);
+struct codetag_ctx *codetag_next_ctx(struct codetag_iterator *iter);
+
+bool codetag_enable_ctx(struct codetag_with_ctx *ctc, bool enable);
+static inline bool codetag_ctx_enabled(struct codetag_with_ctx *ctc)
+{
+	return !!(ctc->ct.flags & CTC_FLAG_CTX_ENABLED);
+}
+bool codetag_has_ctx(struct codetag_with_ctx *ctc);
 
 void codetag_to_text(struct seq_buf *out, struct codetag *ct);
 
diff --git a/include/linux/codetag_ctx.h b/include/linux/codetag_ctx.h
new file mode 100644
index 000000000000..e741484f0e08
--- /dev/null
+++ b/include/linux/codetag_ctx.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * code tag context
+ */
+#ifndef _LINUX_CODETAG_CTX_H
+#define _LINUX_CODETAG_CTX_H
+
+#include <linux/codetag.h>
+#include <linux/kref.h>
+
+/* Code tag hit context. */
+struct codetag_ctx {
+	unsigned int flags; /* has to be the first member shared with codetag */
+	struct codetag_with_ctx *ctc;
+	struct list_head node;
+	struct kref refcount;
+} __aligned(8);
+
+static inline struct codetag_ctx *kref_to_ctx(struct kref *refcount)
+{
+	return container_of(refcount, struct codetag_ctx, refcount);
+}
+
+static inline void add_ctx(struct codetag_ctx *ctx,
+			   struct codetag_with_ctx *ctc)
+{
+	kref_init(&ctx->refcount);
+	spin_lock(&ctc->ctx_lock);
+	ctx->flags = CTC_FLAG_CTX_PTR;
+	ctx->ctc = ctc;
+	list_add_tail(&ctx->node, &ctc->ctx_head);
+	spin_unlock(&ctc->ctx_lock);
+}
+
+static inline void rem_ctx(struct codetag_ctx *ctx,
+			   void (*free_ctx)(struct kref *refcount))
+{
+	struct codetag_with_ctx *ctc = ctx->ctc;
+
+	spin_lock(&ctc->ctx_lock);
+	/* ctx might have been removed while we were using it */
+	if (!list_empty(&ctx->node))
+		list_del_init(&ctx->node);
+	spin_unlock(&ctc->ctx_lock);
+	kref_put(&ctx->refcount, free_ctx);
+}
+
+#endif /* _LINUX_CODETAG_CTX_H */
diff --git a/lib/codetag.c b/lib/codetag.c
index 288ccfd5cbd0..2762fda5c016 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/codetag.h>
+#include <linux/codetag_ctx.h>
 #include <linux/idr.h>
 #include <linux/kallsyms.h>
 #include <linux/module.h>
@@ -91,6 +92,139 @@ struct codetag *codetag_next_ct(struct codetag_iterator *iter)
 	return ct;
 }
 
+static struct codetag_ctx *next_ctx_from_ct(struct codetag_iterator *iter)
+{
+	struct codetag_with_ctx *ctc;
+	struct codetag_ctx *ctx = NULL;
+	struct codetag *ct = iter->ct;
+
+	while (ct) {
+		if (!(ct->flags & CTC_FLAG_CTX_READY))
+			goto next;
+
+		ctc = ct_to_ctc(ct);
+		spin_lock(&ctc->ctx_lock);
+		if (!list_empty(&ctc->ctx_head)) {
+			ctx = list_first_entry(&ctc->ctx_head,
+					       struct codetag_ctx, node);
+			kref_get(&ctx->refcount);
+		}
+		spin_unlock(&ctc->ctx_lock);
+		if (ctx)
+			break;
+next:
+		ct = codetag_next_ct(iter);
+	}
+
+	iter->ctx = ctx;
+	return ctx;
+}
+
+struct codetag_ctx *codetag_next_ctx(struct codetag_iterator *iter)
+{
+	struct codetag_ctx *ctx = iter->ctx;
+	struct codetag_ctx *found = NULL;
+
+	lockdep_assert_held(&iter->cttype->mod_lock);
+
+	if (!ctx)
+		return next_ctx_from_ct(iter);
+
+	spin_lock(&ctx->ctc->ctx_lock);
+	/*
+	 * Do not advance if the object was isolated, restart at the same tag.
+	 */
+	if (!list_empty(&ctx->node)) {
+		if (list_is_last(&ctx->node, &ctx->ctc->ctx_head)) {
+			/* Finished with this tag, advance to the next */
+			codetag_next_ct(iter);
+		} else {
+			found = list_next_entry(ctx, node);
+			kref_get(&found->refcount);
+		}
+	}
+	spin_unlock(&ctx->ctc->ctx_lock);
+	kref_put(&ctx->refcount, iter->cttype->desc.free_ctx);
+
+	if (!found)
+		return next_ctx_from_ct(iter);
+
+	iter->ctx = found;
+	return found;
+}
+
+static struct codetag_type *find_cttype(struct codetag *ct)
+{
+	struct codetag_module *cmod;
+	struct codetag_type *cttype;
+	unsigned long mod_id;
+	unsigned long tmp;
+
+	mutex_lock(&codetag_lock);
+	list_for_each_entry(cttype, &codetag_types, link) {
+		down_read(&cttype->mod_lock);
+		idr_for_each_entry_ul(&cttype->mod_idr, cmod, tmp, mod_id) {
+			if (ct >= cmod->range.start && ct < cmod->range.stop) {
+				up_read(&cttype->mod_lock);
+				goto found;
+			}
+		}
+		up_read(&cttype->mod_lock);
+	}
+	cttype = NULL;
+found:
+	mutex_unlock(&codetag_lock);
+
+	return cttype;
+}
+
+bool codetag_enable_ctx(struct codetag_with_ctx *ctc, bool enable)
+{
+	struct codetag_type *cttype = find_cttype(&ctc->ct);
+
+	if (!cttype || !cttype->desc.free_ctx)
+		return false;
+
+	lockdep_assert_held(&cttype->mod_lock);
+	BUG_ON(!rwsem_is_locked(&cttype->mod_lock));
+
+	if (codetag_ctx_enabled(ctc) == enable)
+		return false;
+
+	if (enable) {
+		/* Initialize context capture fields only once */
+		if (!(ctc->ct.flags & CTC_FLAG_CTX_READY)) {
+			spin_lock_init(&ctc->ctx_lock);
+			INIT_LIST_HEAD(&ctc->ctx_head);
+			ctc->ct.flags |= CTC_FLAG_CTX_READY;
+		}
+		ctc->ct.flags |= CTC_FLAG_CTX_ENABLED;
+	} else {
+		/*
+		 * The list of context objects is intentionally left untouched.
+		 * It can be read back and if context capture is re-enablied it
+		 * will append new objects.
+		 */
+		ctc->ct.flags &= ~CTC_FLAG_CTX_ENABLED;
+	}
+
+	return true;
+}
+
+bool codetag_has_ctx(struct codetag_with_ctx *ctc)
+{
+	bool no_ctx;
+
+	if (!(ctc->ct.flags & CTC_FLAG_CTX_READY))
+		return false;
+
+	spin_lock(&ctc->ctx_lock);
+	no_ctx = list_empty(&ctc->ctx_head);
+	spin_unlock(&ctc->ctx_lock);
+
+	return !no_ctx;
+}
+
 void codetag_to_text(struct seq_buf *out, struct codetag *ct)
 {
 	seq_buf_printf(out, "%s:%u module:%s func:%s",
-- 
2.37.2.672.g94769d06f0-goog

