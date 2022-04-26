Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14201510435
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349930AbiDZQuR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353260AbiDZQs6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:48:58 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AE932052
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:08 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id hs26-20020a1709073e9a00b006f3b957ebb4so837589ejc.7
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=d8pL6jrPvx0aomk5qPe/O8+76gWOKR1XrEif20OjnQY=;
        b=qHuNE5uJ2FDzh5HoUwOExyBkIzzUGi7u3r8cb1fmNh9JoURq8b/0KZazqEqktkONuv
         RSLViVqt3oajP2cDiy1OzrTVw7OGCCwD1o48WWrtmf3dphbUmtfJDJYJSX5YCXSpNfdF
         aXfERsMSgciWjwFSSbUv2J0vUdBe6KCUA+6Uqtn6lrlmCctTBymZW6DYKyoqZXJTtacd
         rnvL/jsjRqjNWe6PKbeI0qf9Va3S9UXaomO1/Ti1Zz7QraDNV7xVEPjV7ex+essI4Lra
         yDFX1T5khoEdzXqF+In8TAeLE7luEASOtTb9QCfHpF9L7qw2pr9BQJoomZYDCxZL6tCZ
         7FYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d8pL6jrPvx0aomk5qPe/O8+76gWOKR1XrEif20OjnQY=;
        b=1G5FWxh7tFS12hvRMMxdt5iVQTabND0mUL6hfQYVPDEGa/6KrDnm/6duanEAGk1ti2
         fCVx6/kktjlj8tFx/7IhrWQO5p0aC+yR2NA3F0xW9244UIjJCboSjL7HBjpRlmfFlt67
         v9EN6G6i8HN0zRyRqkTi0mzJDWDHWCPOaw6Qok14qFans04GUATMZUJHzaCassb4n3ON
         XYlXMQES3Z9h44HB0wgetqOlwrHIcnlOSQ1oy35HfMum9kfFObdB5KJAs9X2Ny3MGsoI
         ZS1LT25ZNZHSb+ovDXMkvOgFcjKnHWkwFBQS8ZGI1MtYLNS4/OkkkKe/OEtj91MeM0sX
         EyfA==
X-Gm-Message-State: AOAM5307TBKI0eomNAkRzqqn5W1DolRt2cwIeX21MKZhWc3CpB075j3d
        zdPxzROwIuJEd1183r2KcEmY+O7cHeU=
X-Google-Smtp-Source: ABdhPJxFI4DglMrNp8eiqcTF6h41+ZsecBuhf95AwThCb0V12de/kX/qAKmHnmtUDGFTwaevSaUDv/yKfZQ=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6402:486:b0:413:bd00:4f3f with SMTP id
 k6-20020a056402048600b00413bd004f3fmr26069921edv.103.1650991507458; Tue, 26
 Apr 2022 09:45:07 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:47 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-19-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 18/46] kmsan: handle task creation and exiting
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
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
index f072959fcab7f..1784b7a741ddd 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -60,6 +60,7 @@
 #include <linux/writeback.h>
 #include <linux/shm.h>
 #include <linux/kcov.h>
+#include <linux/kmsan.h>
 #include <linux/random.h>
 #include <linux/rcuwait.h>
 #include <linux/compat.h>
@@ -741,6 +742,7 @@ void __noreturn do_exit(long code)
 	WARN_ON(tsk->plug);
 
 	kcov_task_exit(tsk);
+	kmsan_task_exit(tsk);
 
 	coredump_task_exit(tsk);
 	ptrace_event(PTRACE_EVENT_EXIT, code);
diff --git a/kernel/fork.c b/kernel/fork.c
index 9796897560ab1..a6178bd28c409 100644
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
@@ -1027,6 +1028,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->worker_private = NULL;
 
 	kcov_task_init(tsk);
+	kmsan_task_create(tsk);
 	kmap_local_fork(tsk);
 
 #ifdef CONFIG_FAULT_INJECTION
diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
index 933d864d9d467..4b405abbb6c03 100644
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
index 052e17b7a717d..43a529569053d 100644
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
2.36.0.rc2.479.g8af0fa9b8e-goog

