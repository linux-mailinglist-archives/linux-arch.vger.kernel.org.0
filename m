Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA795A2AA7
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243923AbiHZPL1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245674AbiHZPKU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:10:20 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646DDDDB6C
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:08:59 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id n7-20020a1c2707000000b003a638356355so1112014wmn.2
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=Oj/n9T6llj5wDAAKfJeFunm60o607TLggj1MRB6CXqU=;
        b=PxLdCUrn0I9r2KhoyjcHAgRjabnegFod8IN6xz54blzpZh/1HZMNwSAgdShD0YvvTh
         Zxa5m/TO4KXMsG3OReoI+v+75UBjGjQZGLkWHPGtaoCFJKvIQldeDs2TPHJBt92k+HBR
         GqPmBiuONAM/IYWYOjJo+NjVJdkfYt9fsorrmjsf8jhWXVxxLXlhRRcVPT7xJPiq3MGR
         sOERai0/gwO4NtaVb2+CTxwQIjtjIGirbBBqxUONp9htYRv0TtzY3VfMqWDgDmyiC71n
         pI0ppgM4t9DRD3K6ZENiNPm8eVLb/eKuoAsYeEkEZa3aYmpCTXb/EK1nCWbE6o9dPH2L
         xa+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=Oj/n9T6llj5wDAAKfJeFunm60o607TLggj1MRB6CXqU=;
        b=vDbFf2u6mg2ZRs7D6sTZEgZNIddvY2L6HOjWB24UX9PogRr/9S3Nalf7vBa/xL2VjX
         HX6QJzNJtjO2j4QJxI7VA9PqSSpfHOCytsq7GcArCijY2XvZVstBdLcdf1M17Sek/KNZ
         XJDGs/w6zS1ugHYNnqnG8pZbhxQcraAIDwZQF3JW9bekQOR37j2Px7wIKwBfA3FI0ocZ
         gTGlA0Hh6I1zb72S+5ZuzPV0eNdD7+icSdwTLPgqZecgo9nqUfn1lUOrLMyKBFfS+l1x
         J5CZfzw/6w+EaQ6Gcysfy8ugRRPg7aQeMDeVWiEnx7jR5Fv1EaSCRx1OEuTZ/np6Tw0S
         h/+A==
X-Gm-Message-State: ACgBeo2lokRX34xkucWnkP5eFtfDA3i4tIk2dc1IROhagGkX4ujwYAVh
        5B1LcqbICJnqjp/81cYSCGamrmy+Rc8=
X-Google-Smtp-Source: AA6agR5rvjq/H6vV+DBU+cdF375w+nJz6Qf5RMmSw4joFRAU0pGVVVqBSQBGZeHf42N72d45iOUQjmMAIWY=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a5d:6483:0:b0:225:7fb7:f163 with SMTP id
 o3-20020a5d6483000000b002257fb7f163mr49905wri.391.1661526537522; Fri, 26 Aug
 2022 08:08:57 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:39 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-17-glider@google.com>
Subject: [PATCH v5 16/44] kmsan: handle task creation and exiting
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

Tell KMSAN that a new task is created, so the tool creates a backing
metadata structure for that task.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
 -- move implementation of kmsan_task_create() and kmsan_task_exit() here

v4:
 -- change sizeof(type) to sizeof(*ptr)

v5:
 -- do not export KMSAN hooks that are not called from modules
 -- minor comment fix

Link: https://linux-review.googlesource.com/id/I0f41c3a1c7d66f7e14aabcfdfc7c69addb945805
---
 include/linux/kmsan.h | 21 +++++++++++++++++++++
 kernel/exit.c         |  2 ++
 kernel/fork.c         |  2 ++
 mm/kmsan/core.c       | 10 ++++++++++
 mm/kmsan/hooks.c      | 17 +++++++++++++++++
 mm/kmsan/kmsan.h      |  2 ++
 6 files changed, 54 insertions(+)

diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index fd76cea338878..5ec056380a43b 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -16,6 +16,7 @@
 
 struct page;
 struct kmem_cache;
+struct task_struct;
 
 #ifdef CONFIG_KMSAN
 
@@ -42,6 +43,18 @@ struct kmsan_ctx {
 	bool allow_reporting;
 };
 
+/**
+ * kmsan_task_create() - Initialize KMSAN state for the task.
+ * @task: task to initialize.
+ */
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
@@ -163,6 +176,14 @@ void kmsan_iounmap_page_range(unsigned long start, unsigned long end);
 
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
index 84021b24f79e3..f5d620c315662 100644
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
index 90c85b17bf698..7cf3eea01ceef 100644
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
index a5dec6e62b4ef..a640e0cccbb64 100644
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
index 519a7a1dcb4aa..4ab8c629acd0c 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -26,6 +26,23 @@
  * skipping effects of functions like memset() inside instrumented code.
  */
 
+void kmsan_task_create(struct task_struct *task)
+{
+	kmsan_enter_runtime();
+	kmsan_internal_task_create(task);
+	kmsan_leave_runtime();
+}
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
+
 void kmsan_slab_alloc(struct kmem_cache *s, void *object, gfp_t flags)
 {
 	if (unlikely(object == NULL))
diff --git a/mm/kmsan/kmsan.h b/mm/kmsan/kmsan.h
index 6b9deee3b7f32..04954b83c5d65 100644
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
2.37.2.672.g94769d06f0-goog

