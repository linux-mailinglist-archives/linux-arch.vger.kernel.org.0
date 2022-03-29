Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD374EAD6A
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbiC2Mn6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236577AbiC2MnV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:43:21 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA00224754
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:41:23 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id mm20-20020a170906cc5400b006dfec7725f3so8113571ejb.15
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KExSZOK6Ak71zPKr5IrSRQ27+lVgS6k5uhCxlphiTtg=;
        b=tC2AC8qcVBGGwy5YubyQq84+DV0rcKjoONhQrYq3TKU20eKqh0tvDqhPRf7gRqM4PT
         dJmEH+z3DLtHBAC40BR8tQ/MaqO0WsxWK2QMgj40Hw2S7T7BAU6mtiu18LqGVLCo5/Qo
         jIKc2qIgz1E97QzbvGKvXcUu6cxEFeypgm1jOEzMJ2+zTDI7QZ7lhF0Ldt76B+O9/+/p
         4pJKclD9Afk4fMQo1aDljx1Ws5Se+KObPjS8eyzNIzamBK0W0f/R7pNdSE7W8atZml4H
         uCyfBqUv6W9GA2MHL83z28IXWM2iPHYU3cZnXPjc+0QxA/mGQCWJHKnuELSvEXq12m1S
         7Z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KExSZOK6Ak71zPKr5IrSRQ27+lVgS6k5uhCxlphiTtg=;
        b=VrE1m+uJUzGN84jHFRnNHUadX1dz3BF0pLXoJRSUHekukt5C0U7ZzKbaQVjUh5Vvhi
         Lv9NUF2IF8abfJVebqdPN3V8NjnqdSoIhu6wPDaNW+OasxJ8dsNrS/8QFlUlacL5I9S8
         Q8CsCx0XvSe304sGF3Vep/6Y1X5ELpo2DaSiaz5rZdoSjvW2yg04dxxBvteWXMVCReFO
         b+LVgKUrF3RGGgOyEBvtvTCsD5l795G79UYgAfBSHYdvn1PXXHLiodtKohkcYF/lytl8
         WHgJxcsC7aXrTGciq8cSNFZ31A0bg33X/Kt1Q2CuFC5SlR6aHn5cRyIeGTjdbiAPLQpa
         bTZQ==
X-Gm-Message-State: AOAM533beXGQmTftzyUO7mJkYC6+tkZx/IPOinmiZNx6tsdpkTem0s7W
        /egD1Tp1Q/WH825ffr3upe0ZUhH2fKw=
X-Google-Smtp-Source: ABdhPJx++M+AfNEUSZZQiWR+2EsjU8nZXkRMWuKEK5h5tMt4uYSC+sCaPadi/60UsvXveKH0DEZLOUoc2uE=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:906:c092:b0:6cd:f3a1:a11e with SMTP id
 f18-20020a170906c09200b006cdf3a1a11emr33573510ejz.185.1648557680652; Tue, 29
 Mar 2022 05:41:20 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:39:48 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-20-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 19/48] kmsan: handle task creation and exiting
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
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

Tell KMSAN that a new task is created, so the tool creates a backing
metadata structure for that task.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
 -- move implementation of kmsan_task_create() and kmsan_task_exit() here

Link: https://linux-review.googlesource.com/id/I0f41c3a1c7d66f7e14aabcfdfc7c69addb945805
---
 include/linux/kmsan.h | 17 +++++++++++++++++
 kernel/exit.c         |  2 ++
 kernel/fork.c         |  2 ++
 mm/kmsan/core.c       | 10 ++++++++++
 mm/kmsan/hooks.c      | 19 +++++++++++++++++++
 mm/kmsan/kmsan.h      |  2 ++
 6 files changed, 52 insertions(+)

diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index ed3630068e2ef..dca42e0e91991 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -17,6 +17,7 @@
 
 struct page;
 struct kmem_cache;
+struct task_struct;
 
 #ifdef CONFIG_KMSAN
 
@@ -43,6 +44,14 @@ struct kmsan_ctx {
 	bool allow_reporting;
 };
 
+void kmsan_task_create(struct task_struct *task);
+
+/**
+ * kmsan_task_exit() - Notify KMSAN that a task has exited.
+ * @task: task about to finish.
+ */
+void kmsan_task_exit(struct task_struct *task);
+
 /**
  * kmsan_alloc_page() - Notify KMSAN about an alloc_pages() call.
  * @page:  struct page pointer returned by alloc_pages().
@@ -164,6 +173,14 @@ void kmsan_iounmap_page_range(unsigned long start, unsigned long end);
 
 #else
 
+static inline void kmsan_task_create(struct task_struct *task)
+{
+}
+
+static inline void kmsan_task_exit(struct task_struct *task)
+{
+}
+
 static inline int kmsan_alloc_page(struct page *page, unsigned int order,
 				   gfp_t flags)
 {
diff --git a/kernel/exit.c b/kernel/exit.c
index b00a25bb4ab93..15e1bf7fe1fa1 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -59,6 +59,7 @@
 #include <linux/writeback.h>
 #include <linux/shm.h>
 #include <linux/kcov.h>
+#include <linux/kmsan.h>
 #include <linux/random.h>
 #include <linux/rcuwait.h>
 #include <linux/compat.h>
@@ -752,6 +753,7 @@ void __noreturn do_exit(long code)
 	force_uaccess_begin();
 
 	kcov_task_exit(tsk);
+	kmsan_task_exit(tsk);
 
 	coredump_task_exit(tsk);
 	ptrace_event(PTRACE_EVENT_EXIT, code);
diff --git a/kernel/fork.c b/kernel/fork.c
index f1e89007f2288..f62c51d9cbfb1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -37,6 +37,7 @@
 #include <linux/fdtable.h>
 #include <linux/iocontext.h>
 #include <linux/key.h>
+#include <linux/kmsan.h>
 #include <linux/binfmts.h>
 #include <linux/mman.h>
 #include <linux/mmu_notifier.h>
@@ -956,6 +957,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	account_kernel_stack(tsk, 1);
 
 	kcov_task_init(tsk);
+	kmsan_task_create(tsk);
 	kmap_local_fork(tsk);
 
 #ifdef CONFIG_FAULT_INJECTION
diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
index f4196f274e754..8e594361332c6 100644
--- a/mm/kmsan/core.c
+++ b/mm/kmsan/core.c
@@ -44,6 +44,16 @@ bool kmsan_enabled __read_mostly;
  */
 DEFINE_PER_CPU(struct kmsan_ctx, kmsan_percpu_ctx);
 
+void kmsan_internal_task_create(struct task_struct *task)
+{
+	struct kmsan_ctx *ctx = &task->kmsan_ctx;
+
+	__memset(ctx, 0, sizeof(struct kmsan_ctx));
+	ctx->allow_reporting = true;
+	kmsan_internal_unpoison_memory(current_thread_info(),
+				       sizeof(struct thread_info), false);
+}
+
 void kmsan_internal_poison_memory(void *address, size_t size, gfp_t flags,
 				  unsigned int poison_flags)
 {
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index e7c3ff48ed5cd..a13e15ef2bfd5 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -26,6 +26,25 @@
  * skipping effects of functions like memset() inside instrumented code.
  */
 
+void kmsan_task_create(struct task_struct *task)
+{
+	kmsan_enter_runtime();
+	kmsan_internal_task_create(task);
+	kmsan_leave_runtime();
+}
+EXPORT_SYMBOL(kmsan_task_create);
+
+void kmsan_task_exit(struct task_struct *task)
+{
+	struct kmsan_ctx *ctx = &task->kmsan_ctx;
+
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+
+	ctx->allow_reporting = false;
+}
+EXPORT_SYMBOL(kmsan_task_exit);
+
 void kmsan_slab_alloc(struct kmem_cache *s, void *object, gfp_t flags)
 {
 	if (unlikely(object == NULL))
diff --git a/mm/kmsan/kmsan.h b/mm/kmsan/kmsan.h
index bfe38789950a6..a1b5900ffd97b 100644
--- a/mm/kmsan/kmsan.h
+++ b/mm/kmsan/kmsan.h
@@ -172,6 +172,8 @@ void kmsan_internal_set_shadow_origin(void *address, size_t size, int b,
 				      u32 origin, bool checked);
 depot_stack_handle_t kmsan_internal_chain_origin(depot_stack_handle_t id);
 
+void kmsan_internal_task_create(struct task_struct *task);
+
 bool kmsan_metadata_is_contiguous(void *addr, size_t size);
 void kmsan_internal_check_memory(void *addr, size_t size, const void *user_addr,
 				 int reason);
-- 
2.35.1.1021.g381101b075-goog

