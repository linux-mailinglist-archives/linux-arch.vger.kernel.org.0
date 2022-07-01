Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB78563553
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiGAO0L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiGAOYz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:24:55 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF12403E2
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:24:02 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id ne36-20020a1709077ba400b00722d5f547d8so828365ejc.19
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MuviuQokEzhvfg2Z0+25mg/6MRU0laLu6ns1H0kafhg=;
        b=RS/M11ViQBiSN+sd81NPLXtCXBjB0FGsgDbLZu3p8F4GXPk0D+7t81g6tlYzjC+YwJ
         2W2SuOsDI6B6k+EbyeqLWQ5i6XoSdBB/+r1g2aJs+YxxhMsErmeKZJZA7jqnG5QhyArd
         kCQL6luWnGxlNT+6WLZVxu+1AO53PlCajPc408xi4cgug6IuYEuGFoJhtwpZh92pjpFi
         LUqCR9BfPmYNdTfDQrXf+Z9/vBRTPln7cJAJKvCI/ZLobPZOQV/2MT0+aDpNak9Etgjo
         y4ufCn34FXG2xJ2ki47OVbFCxLHBCiQiG9yCQJMgCp4FSLz2CJ4PyO19DAZvw0qWc0JD
         PPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MuviuQokEzhvfg2Z0+25mg/6MRU0laLu6ns1H0kafhg=;
        b=CYq8wJ8NB5GcvkFetfBTrydZd+G4snaG95aqn3uWdGEp373k4aHgcML8GL92uxQzYq
         No/oF6cLxzeXeC35qqFjDo7BVwHNloWDPLX3ZzrYEX1Q/LMD+lW2dQLMXGX1t30X0oC5
         7Ogyxwy1a8KgSdnkXtyEEUb9W8CVc47cpyuoO4NCGZBciUbKqZrInRrdN8BatpgPlDlj
         OegHuwynh8TmRY6lOWZPYJB/24DquRW7FYtQnHqtCLZ43JDZy8ISyez50BhOImXN2DZ/
         U7St/D8gkB6CwNptPXohpvrTyPG5hIr1Nt7jOUlIqg9Oko18gmX6TWpH6u9QDKCI46u6
         RxdA==
X-Gm-Message-State: AJIora/kyoYEyGBnrvYs1JJ1cxgVee2HfadB3iuRjGVauty2ldvXkcQp
        GmA9ARojcsH4awNSMWfUpnWkBBo6sTg=
X-Google-Smtp-Source: AGRyM1svvXk0uhgtL2lyHdhsMHh+dNlSgp0MiLj8ryXpF1AJlade1jJus8xhDzqNuinjfAclnUPFVASuizY=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a05:6402:430a:b0:435:8ec9:31ec with SMTP id
 m10-20020a056402430a00b004358ec931ecmr19482900edc.248.1656685440344; Fri, 01
 Jul 2022 07:24:00 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:41 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-17-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 16/45] kmsan: handle task creation and exiting
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

v4:
 -- change sizeof(type) to sizeof(*ptr)

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
index fd76cea338878..b71e2032222e9 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -16,6 +16,7 @@
 
 struct page;
 struct kmem_cache;
+struct task_struct;
 
 #ifdef CONFIG_KMSAN
 
@@ -42,6 +43,14 @@ struct kmsan_ctx {
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
@@ -163,6 +172,14 @@ void kmsan_iounmap_page_range(unsigned long start, unsigned long end);
 
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
index 9d44f2d46c696..6dfca6f00ec82 100644
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
@@ -1026,6 +1027,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->worker_private = NULL;
 
 	kcov_task_init(tsk);
+	kmsan_task_create(tsk);
 	kmap_local_fork(tsk);
 
 #ifdef CONFIG_FAULT_INJECTION
diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
index 16fb8880a9c6d..7eabed03ed10b 100644
--- a/mm/kmsan/core.c
+++ b/mm/kmsan/core.c
@@ -44,6 +44,16 @@ bool kmsan_enabled __read_mostly;
  */
 DEFINE_PER_CPU(struct kmsan_ctx, kmsan_percpu_ctx);
 
+void kmsan_internal_task_create(struct task_struct *task)
+{
+	struct kmsan_ctx *ctx = &task->kmsan_ctx;
+	struct thread_info *info = current_thread_info();
+
+	__memset(ctx, 0, sizeof(*ctx));
+	ctx->allow_reporting = true;
+	kmsan_internal_unpoison_memory(info, sizeof(*info), false);
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
index d3c400ca097ba..c7fb8666607e2 100644
--- a/mm/kmsan/kmsan.h
+++ b/mm/kmsan/kmsan.h
@@ -179,6 +179,8 @@ void kmsan_internal_set_shadow_origin(void *address, size_t size, int b,
 				      u32 origin, bool checked);
 depot_stack_handle_t kmsan_internal_chain_origin(depot_stack_handle_t id);
 
+void kmsan_internal_task_create(struct task_struct *task);
+
 bool kmsan_metadata_is_contiguous(void *addr, size_t size);
 void kmsan_internal_check_memory(void *addr, size_t size, const void *user_addr,
 				 int reason);
-- 
2.37.0.rc0.161.g10f37bed90-goog

