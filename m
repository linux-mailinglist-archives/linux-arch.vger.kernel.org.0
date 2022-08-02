Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15740587F3E
	for <lists+linux-arch@lfdr.de>; Tue,  2 Aug 2022 17:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbiHBPt3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Aug 2022 11:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237425AbiHBPtH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Aug 2022 11:49:07 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B890717E1C
        for <linux-arch@vger.kernel.org>; Tue,  2 Aug 2022 08:48:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z17so13728188wrq.4
        for <linux-arch@vger.kernel.org>; Tue, 02 Aug 2022 08:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=At7GobCcr6Y9heni/Yduc1l7sWHbyaA1znBRmpamTcU=;
        b=k0qIjj7CJX3r48zFSSvRSE7fKJFlSgjDIhA8mzTd0ZcpMPn12XJ6fIc2KYUaTigCd4
         YTisP+v+bOYKSmD39f3LvDFr2wmoBrlXjEjnEd1DcEx1/IqfjINPjtUZ1BFHlx4j0Jmz
         LkMV6go6TkzA0Dxo8MRefBSAf8hO5p80YdxlJUhRzLS/CU3z/Ia60UibzxP6Bg6YSTQn
         +zDdo7F+GVJagu52I/SHqEOVJFdD2+28QTwXq6Ao1VL+DUTX45ePo6q0GGNYWwWYdZ5R
         g+0wA7U+Jy12i61t6eA5aow37U8Z0u+DjFYtVziFw3KpTKwXYg33h4L/SJGumTZPW654
         1v3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=At7GobCcr6Y9heni/Yduc1l7sWHbyaA1znBRmpamTcU=;
        b=50wW0gZamEpG57C/7TMH73PBjd0SKwnE74f+i+XqQhPc4VSm1onD+V2Tug4fUpHSvr
         YP7hBTq5sNQMdHwJrdUtzI0rBbqFZ++IANFivtMBLhU+hthK96qZFCC1qd579NTtFugU
         yUnIQGDvHPEprmQMeqC9WfWKWDuaqAVD+ltxTo6cbWlZRoZEwLgH92zzQgsTiYFKdFSg
         DKOQiWv4iYOP+HMhLSMKFyWd3LrqFokkBbvXpI8i1lEe0GqzRhw8/uP/JCeZkc1ODxHw
         F+lgrfigXZMjL4ilh0cJ0YZ719ur58dXRHJEWbaUy74tXdcXxaGKkERxQzS/QZxScN1w
         9M6g==
X-Gm-Message-State: ACgBeo0cvEVn4kBi8c3dXRsl8xOLljjv+fh1GHslk3QhV37m2tdyMi/1
        fFj1kVYdDorvi/9MIDCof+hR3zziyfhOVCvw/qN6UQ==
X-Google-Smtp-Source: AA6agR7sJpNI3jbui+JxLBQdGVQkDKwSDyZdyGBwAfJb7lo5F2di5P6ZlWKItvxslBAeDMYE4hWgwQfIZ27Du4ierS8=
X-Received: by 2002:a05:6000:2c1:b0:220:5f91:62de with SMTP id
 o1-20020a05600002c100b002205f9162demr8238093wry.715.1659455304037; Tue, 02
 Aug 2022 08:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-17-glider@google.com>
 <CANpmjNOM8RdTPF_JeoiJahkLPPj6jH2s=hyTOSQpXzTBSDqeAQ@mail.gmail.com>
In-Reply-To: <CANpmjNOM8RdTPF_JeoiJahkLPPj6jH2s=hyTOSQpXzTBSDqeAQ@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 2 Aug 2022 17:47:47 +0200
Message-ID: <CAG_fn=Xu+sGe-6Yv9J8LDScOP-eBze4iNqCsyY2igirHKPCt7g@mail.gmail.com>
Subject: Re: [PATCH v4 16/45] kmsan: handle task creation and exiting
To:     Marco Elver <elver@google.com>
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
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 12, 2022 at 3:18 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, 1 Jul 2022 at 16:24, 'Alexander Potapenko' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > Tell KMSAN that a new task is created, so the tool creates a backing
> > metadata structure for that task.
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > ---
> > v2:
> >  -- move implementation of kmsan_task_create() and kmsan_task_exit() here
> >
> > v4:
> >  -- change sizeof(type) to sizeof(*ptr)
> >
> > Link: https://linux-review.googlesource.com/id/I0f41c3a1c7d66f7e14aabcfdfc7c69addb945805
> > ---
> >  include/linux/kmsan.h | 17 +++++++++++++++++
> >  kernel/exit.c         |  2 ++
> >  kernel/fork.c         |  2 ++
> >  mm/kmsan/core.c       | 10 ++++++++++
> >  mm/kmsan/hooks.c      | 19 +++++++++++++++++++
> >  mm/kmsan/kmsan.h      |  2 ++
> >  6 files changed, 52 insertions(+)
> >
> > diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
> > index fd76cea338878..b71e2032222e9 100644
> > --- a/include/linux/kmsan.h
> > +++ b/include/linux/kmsan.h
> > @@ -16,6 +16,7 @@
> >
> >  struct page;
> >  struct kmem_cache;
> > +struct task_struct;
> >
> >  #ifdef CONFIG_KMSAN
> >
> > @@ -42,6 +43,14 @@ struct kmsan_ctx {
> >         bool allow_reporting;
> >  };
> >
> > +void kmsan_task_create(struct task_struct *task);
> > +
> > +/**
> > + * kmsan_task_exit() - Notify KMSAN that a task has exited.
> > + * @task: task about to finish.
> > + */
> > +void kmsan_task_exit(struct task_struct *task);
> > +
> >  /**
> >   * kmsan_alloc_page() - Notify KMSAN about an alloc_pages() call.
> >   * @page:  struct page pointer returned by alloc_pages().
> > @@ -163,6 +172,14 @@ void kmsan_iounmap_page_range(unsigned long start, unsigned long end);
> >
> >  #else
> >
> > +static inline void kmsan_task_create(struct task_struct *task)
> > +{
> > +}
> > +
> > +static inline void kmsan_task_exit(struct task_struct *task)
> > +{
> > +}
> > +
> >  static inline int kmsan_alloc_page(struct page *page, unsigned int order,
> >                                    gfp_t flags)
> >  {
> > diff --git a/kernel/exit.c b/kernel/exit.c
> > index f072959fcab7f..1784b7a741ddd 100644
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -60,6 +60,7 @@
> >  #include <linux/writeback.h>
> >  #include <linux/shm.h>
> >  #include <linux/kcov.h>
> > +#include <linux/kmsan.h>
> >  #include <linux/random.h>
> >  #include <linux/rcuwait.h>
> >  #include <linux/compat.h>
> > @@ -741,6 +742,7 @@ void __noreturn do_exit(long code)
> >         WARN_ON(tsk->plug);
> >
> >         kcov_task_exit(tsk);
> > +       kmsan_task_exit(tsk);
> >
> >         coredump_task_exit(tsk);
> >         ptrace_event(PTRACE_EVENT_EXIT, code);
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 9d44f2d46c696..6dfca6f00ec82 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -37,6 +37,7 @@
> >  #include <linux/fdtable.h>
> >  #include <linux/iocontext.h>
> >  #include <linux/key.h>
> > +#include <linux/kmsan.h>
> >  #include <linux/binfmts.h>
> >  #include <linux/mman.h>
> >  #include <linux/mmu_notifier.h>
> > @@ -1026,6 +1027,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
> >         tsk->worker_private = NULL;
> >
> >         kcov_task_init(tsk);
> > +       kmsan_task_create(tsk);
> >         kmap_local_fork(tsk);
> >
> >  #ifdef CONFIG_FAULT_INJECTION
> > diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
> > index 16fb8880a9c6d..7eabed03ed10b 100644
> > --- a/mm/kmsan/core.c
> > +++ b/mm/kmsan/core.c
> > @@ -44,6 +44,16 @@ bool kmsan_enabled __read_mostly;
> >   */
> >  DEFINE_PER_CPU(struct kmsan_ctx, kmsan_percpu_ctx);
> >
> > +void kmsan_internal_task_create(struct task_struct *task)
> > +{
> > +       struct kmsan_ctx *ctx = &task->kmsan_ctx;
> > +       struct thread_info *info = current_thread_info();
> > +
> > +       __memset(ctx, 0, sizeof(*ctx));
> > +       ctx->allow_reporting = true;
> > +       kmsan_internal_unpoison_memory(info, sizeof(*info), false);
> > +}
> > +
> >  void kmsan_internal_poison_memory(void *address, size_t size, gfp_t flags,
> >                                   unsigned int poison_flags)
> >  {
> > diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> > index 052e17b7a717d..43a529569053d 100644
> > --- a/mm/kmsan/hooks.c
> > +++ b/mm/kmsan/hooks.c
> > @@ -26,6 +26,25 @@
> >   * skipping effects of functions like memset() inside instrumented code.
> >   */
> >
> > +void kmsan_task_create(struct task_struct *task)
> > +{
> > +       kmsan_enter_runtime();
> > +       kmsan_internal_task_create(task);
> > +       kmsan_leave_runtime();
> > +}
> > +EXPORT_SYMBOL(kmsan_task_create);
> > +
> > +void kmsan_task_exit(struct task_struct *task)
> > +{
> > +       struct kmsan_ctx *ctx = &task->kmsan_ctx;
> > +
> > +       if (!kmsan_enabled || kmsan_in_runtime())
> > +               return;
> > +
> > +       ctx->allow_reporting = false;
> > +}
> > +EXPORT_SYMBOL(kmsan_task_exit);
>
> Why are these EXPORT_SYMBOL? Will they be used from some kernel module?

You're right, most of them will not. Will fix.
