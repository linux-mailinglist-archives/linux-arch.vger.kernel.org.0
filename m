Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C7756358A
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiGAO35 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiGAO3H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:29:07 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABBE68A15
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:25:16 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31c095d07a8so19974767b3.18
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kErHaO8c2VDyOovKMTTPjLnffjCar7lX0B4oxY8ZYJM=;
        b=QikpwS8HSBicv3aiX5l18DFFItV5cAfTWljYQPRMj2W7svuU9foj5CYwNhPW5g1+1u
         bB4glo+uMZCRum5mXol+jHpQv/lgXI3n7dJV/CM+AV/P8K/r9Gy2E3HtcxQY9ID9PHSC
         wVw80I52aTXRRhG6Ci/za3zw0SD1eIdJQitn35q5f/DsJHwTzK0rEhzr2LJtogI15qw/
         PNVnInhl+jBMMMMjNB1XrOY7EpC2Lh+bCIf6lfRBYGnQduk/EEoxldI491nxYD8nls9J
         Xv49bFK0wQhLo1KkR4mkWE/FmlIpB/UN96BNNMS/ZsSyzjXx8nx8GEKrJFs5/vreJQ9A
         EF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kErHaO8c2VDyOovKMTTPjLnffjCar7lX0B4oxY8ZYJM=;
        b=a2OXX37Z0OhbxJskAe77x8i3TZvf7VTKMYlvEM+OwZzzJiCOD1tumhthh+iyzcpoXA
         L3TBgaRwu/1yM4FDTM9PAmuF68RmPV9JizDN4WT7M1Rm2xixhWo7Ogdu8I1kEb7FLC1V
         DnxvljTC3NCkDmvUxxK+NTZbLmfhEiHTXH7cxkZgDwymyG+4DvCzI/SimXAKP/OfToGt
         yup8trpjFCNK1Ya6rxPFtn73N9wgw+quBMCGxfnbmhYaSr/cKhE7FfiGRW0z3XH7cL/n
         tQ2UbK4ur7RD61M2aBA48WvRfYaSptxaWQOpZ2H2qTkvqox1Xhs9Q1BXy8mePURIzdn+
         +VeQ==
X-Gm-Message-State: AJIora89jfGrliYui0315+yUq7x1ySfBvTZ9Ad9938aA3YhLk4+no4dX
        VtOtJTxYwErDa65GL4d+q4JIZk0q1Ps=
X-Google-Smtp-Source: AGRyM1sNDBrS8JsvaLtaQ5Nuve5a/xxYqM8vAs8mLC9hMfdeY1tED78m34uqRhiFnJFi3MqtOhAJlCD8K7A=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a81:d82:0:b0:31b:fd6f:9005 with SMTP id
 124-20020a810d82000000b0031bfd6f9005mr16667693ywn.389.1656685510371; Fri, 01
 Jul 2022 07:25:10 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:23:06 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-42-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 41/45] entry: kmsan: introduce kmsan_unpoison_entry_regs()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

struct pt_regs passed into IRQ entry code is set up by uninstrumented
asm functions, therefore KMSAN may not notice the registers are
initialized.

kmsan_unpoison_entry_regs() unpoisons the contents of struct pt_regs,
preventing potential false positives. Unlike kmsan_unpoison_memory(),
it can be called under kmsan_in_runtime(), which is often the case in
IRQ entry code.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Ibfd7018ac847fd8e5491681f508ba5d14e4669cf
---
 include/linux/kmsan.h | 15 +++++++++++++++
 kernel/entry/common.c |  5 +++++
 mm/kmsan/hooks.c      | 27 +++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index e8b5c306c4aa1..c4412622b9a78 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -246,6 +246,17 @@ void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
  */
 void kmsan_handle_urb(const struct urb *urb, bool is_out);
 
+/**
+ * kmsan_unpoison_entry_regs() - Handle pt_regs in low-level entry code.
+ * @regs:	struct pt_regs pointer received from assembly code.
+ *
+ * KMSAN unpoisons the contents of the passed pt_regs, preventing potential
+ * false positive reports. Unlike kmsan_unpoison_memory(),
+ * kmsan_unpoison_entry_regs() can be called from the regions where
+ * kmsan_in_runtime() returns true, which is the case in early entry code.
+ */
+void kmsan_unpoison_entry_regs(const struct pt_regs *regs);
+
 #else
 
 static inline void kmsan_init_shadow(void)
@@ -342,6 +353,10 @@ static inline void kmsan_handle_urb(const struct urb *urb, bool is_out)
 {
 }
 
+static inline void kmsan_unpoison_entry_regs(const struct pt_regs *regs)
+{
+}
+
 #endif
 
 #endif /* _LINUX_KMSAN_H */
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 032f164abe7ce..055d3bdb0442c 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -5,6 +5,7 @@
 #include <linux/resume_user_mode.h>
 #include <linux/highmem.h>
 #include <linux/jump_label.h>
+#include <linux/kmsan.h>
 #include <linux/livepatch.h>
 #include <linux/audit.h>
 #include <linux/tick.h>
@@ -24,6 +25,7 @@ static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
 	user_exit_irqoff();
 
 	instrumentation_begin();
+	kmsan_unpoison_entry_regs(regs);
 	trace_hardirqs_off_finish();
 	instrumentation_end();
 }
@@ -352,6 +354,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 		lockdep_hardirqs_off(CALLER_ADDR0);
 		rcu_irq_enter();
 		instrumentation_begin();
+		kmsan_unpoison_entry_regs(regs);
 		trace_hardirqs_off_finish();
 		instrumentation_end();
 
@@ -367,6 +370,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	 */
 	lockdep_hardirqs_off(CALLER_ADDR0);
 	instrumentation_begin();
+	kmsan_unpoison_entry_regs(regs);
 	rcu_irq_enter_check_tick();
 	trace_hardirqs_off_finish();
 	instrumentation_end();
@@ -452,6 +456,7 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
 	rcu_nmi_enter();
 
 	instrumentation_begin();
+	kmsan_unpoison_entry_regs(regs);
 	trace_hardirqs_off_finish();
 	ftrace_nmi_enter();
 	instrumentation_end();
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 9aecbf2825837..c7528bcbb2f91 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -358,6 +358,33 @@ void kmsan_unpoison_memory(const void *address, size_t size)
 }
 EXPORT_SYMBOL(kmsan_unpoison_memory);
 
+/*
+ * Version of kmsan_unpoison_memory() that can be called from within the KMSAN
+ * runtime.
+ *
+ * Non-instrumented IRQ entry functions receive struct pt_regs from assembly
+ * code. Those regs need to be unpoisoned, otherwise using them will result in
+ * false positives.
+ * Using kmsan_unpoison_memory() is not an option in entry code, because the
+ * return value of in_task() is inconsistent - as a result, certain calls to
+ * kmsan_unpoison_memory() are ignored. kmsan_unpoison_entry_regs() ensures that
+ * the registers are unpoisoned even if kmsan_in_runtime() is true in the early
+ * entry code.
+ */
+void kmsan_unpoison_entry_regs(const struct pt_regs *regs)
+{
+	unsigned long ua_flags;
+
+	if (!kmsan_enabled)
+		return;
+
+	ua_flags = user_access_save();
+	kmsan_internal_unpoison_memory((void *)regs, sizeof(*regs),
+				       KMSAN_POISON_NOCHECK);
+	user_access_restore(ua_flags);
+}
+EXPORT_SYMBOL(kmsan_unpoison_entry_regs);
+
 void kmsan_check_memory(const void *addr, size_t size)
 {
 	if (!kmsan_enabled)
-- 
2.37.0.rc0.161.g10f37bed90-goog

