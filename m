Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47229571AFE
	for <lists+linux-arch@lfdr.de>; Tue, 12 Jul 2022 15:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiGLNSb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Jul 2022 09:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGLNSa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jul 2022 09:18:30 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF1E283
        for <linux-arch@vger.kernel.org>; Tue, 12 Jul 2022 06:18:29 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-31c9b70c382so80577887b3.6
        for <linux-arch@vger.kernel.org>; Tue, 12 Jul 2022 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yN+yeyjG1qKP+1Pj2TR7+x/fenSy0T+ddQvCTNkV1Ls=;
        b=fBcmdT6+YMs4piRTz5Sr7ynpMyL/p7DjbGuZ32eCTQYuReOs5CBMA9O4CMKpsWxxLq
         3ARnZYA98gIdNGUdEd4KYhAGBnyq/p9gGBL5uN+C1AIJzxZK1InLNicvc59GIMrng+Q/
         mPq+tov5jKhbhkLIeAD3XimDlFt/PoeFxsAaSa7/3YlLb071e3aMV+ptS1cUwSIXwVmj
         uDZTVr90c74Z+e3VDhhut0h1ktJVstt5fmb8xeamtEgp4vamysStf7XG/wYS+XUvJpDF
         C4ebjAljczwVhtJiWIWNcvPMLwKXxuoKmdAB3zaTbTvVB5tJC9RblrxUxif/gprsiJ7u
         Kgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yN+yeyjG1qKP+1Pj2TR7+x/fenSy0T+ddQvCTNkV1Ls=;
        b=VQzX9DzcZDgOFptt2eXJbMy3D/5gZg9JmmVEb9seWTwep5kPKOccj2D83b3K+IidE/
         dleMWdcuMG2vTd7dqGKRirKYv9kBq162oF/euCRjsD1BRWMIyvBg2HWRrO/FvpxWiYR/
         gSWgp7NDfET6+mUKFswnzCVCsa8SqF9J0whLOsRUyB0UMmpFajpZYJXVhQdI8ikQKJqN
         P/xzzizRtrOjApQFEpENpCCy/Kvg8GoKA+dFV/5FcGzpiAqCoMWBB2kx6RKrVCa1kNPB
         e6dMbVxE94O+A/cybJTzdUD+Q3tAYWLNN2g00YiADAauz+Sh/hELNqiW0y3DCK/seFrS
         zcZw==
X-Gm-Message-State: AJIora8F2DFD2D6o9sdN52Sd5xQqaQpjh9TLwQQEBBXrV8aNaHo939LX
        ILc5O2lFcXxwOKQK2UnknNHCwIiEPtV6mD74qI0w4g==
X-Google-Smtp-Source: AGRyM1tgsq0Rbbz7l2T+zkElBbmdhgsmeESq4xi/ePNMZnuYjmX+i7wxg7Pmaa67LvwsMvx7HpYYd87U070XIBP7KVQ=
X-Received: by 2002:a81:4685:0:b0:31c:1bd1:56c7 with SMTP id
 t127-20020a814685000000b0031c1bd156c7mr24638722ywa.333.1657631908790; Tue, 12
 Jul 2022 06:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-17-glider@google.com>
In-Reply-To: <20220701142310.2188015-17-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 Jul 2022 15:17:52 +0200
Message-ID: <CANpmjNOM8RdTPF_JeoiJahkLPPj6jH2s=hyTOSQpXzTBSDqeAQ@mail.gmail.com>
Subject: Re: [PATCH v4 16/45] kmsan: handle task creation and exiting
To:     Alexander Potapenko <glider@google.com>
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
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 1 Jul 2022 at 16:24, 'Alexander Potapenko' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Tell KMSAN that a new task is created, so the tool creates a backing
> metadata structure for that task.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
> v2:
>  -- move implementation of kmsan_task_create() and kmsan_task_exit() here
>
> v4:
>  -- change sizeof(type) to sizeof(*ptr)
>
> Link: https://linux-review.googlesource.com/id/I0f41c3a1c7d66f7e14aabcfdfc7c69addb945805
> ---
>  include/linux/kmsan.h | 17 +++++++++++++++++
>  kernel/exit.c         |  2 ++
>  kernel/fork.c         |  2 ++
>  mm/kmsan/core.c       | 10 ++++++++++
>  mm/kmsan/hooks.c      | 19 +++++++++++++++++++
>  mm/kmsan/kmsan.h      |  2 ++
>  6 files changed, 52 insertions(+)
>
> diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
> index fd76cea338878..b71e2032222e9 100644
> --- a/include/linux/kmsan.h
> +++ b/include/linux/kmsan.h
> @@ -16,6 +16,7 @@
>
>  struct page;
>  struct kmem_cache;
> +struct task_struct;
>
>  #ifdef CONFIG_KMSAN
>
> @@ -42,6 +43,14 @@ struct kmsan_ctx {
>         bool allow_reporting;
>  };
>
> +void kmsan_task_create(struct task_struct *task);
> +
> +/**
> + * kmsan_task_exit() - Notify KMSAN that a task has exited.
> + * @task: task about to finish.
> + */
> +void kmsan_task_exit(struct task_struct *task);
> +
>  /**
>   * kmsan_alloc_page() - Notify KMSAN about an alloc_pages() call.
>   * @page:  struct page pointer returned by alloc_pages().
> @@ -163,6 +172,14 @@ void kmsan_iounmap_page_range(unsigned long start, unsigned long end);
>
>  #else
>
> +static inline void kmsan_task_create(struct task_struct *task)
> +{
> +}
> +
> +static inline void kmsan_task_exit(struct task_struct *task)
> +{
> +}
> +
>  static inline int kmsan_alloc_page(struct page *page, unsigned int order,
>                                    gfp_t flags)
>  {
> diff --git a/kernel/exit.c b/kernel/exit.c
> index f072959fcab7f..1784b7a741ddd 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -60,6 +60,7 @@
>  #include <linux/writeback.h>
>  #include <linux/shm.h>
>  #include <linux/kcov.h>
> +#include <linux/kmsan.h>
>  #include <linux/random.h>
>  #include <linux/rcuwait.h>
>  #include <linux/compat.h>
> @@ -741,6 +742,7 @@ void __noreturn do_exit(long code)
>         WARN_ON(tsk->plug);
>
>         kcov_task_exit(tsk);
> +       kmsan_task_exit(tsk);
>
>         coredump_task_exit(tsk);
>         ptrace_event(PTRACE_EVENT_EXIT, code);
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9d44f2d46c696..6dfca6f00ec82 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -37,6 +37,7 @@
>  #include <linux/fdtable.h>
>  #include <linux/iocontext.h>
>  #include <linux/key.h>
> +#include <linux/kmsan.h>
>  #include <linux/binfmts.h>
>  #include <linux/mman.h>
>  #include <linux/mmu_notifier.h>
> @@ -1026,6 +1027,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
>         tsk->worker_private = NULL;
>
>         kcov_task_init(tsk);
> +       kmsan_task_create(tsk);
>         kmap_local_fork(tsk);
>
>  #ifdef CONFIG_FAULT_INJECTION
> diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
> index 16fb8880a9c6d..7eabed03ed10b 100644
> --- a/mm/kmsan/core.c
> +++ b/mm/kmsan/core.c
> @@ -44,6 +44,16 @@ bool kmsan_enabled __read_mostly;
>   */
>  DEFINE_PER_CPU(struct kmsan_ctx, kmsan_percpu_ctx);
>
> +void kmsan_internal_task_create(struct task_struct *task)
> +{
> +       struct kmsan_ctx *ctx = &task->kmsan_ctx;
> +       struct thread_info *info = current_thread_info();
> +
> +       __memset(ctx, 0, sizeof(*ctx));
> +       ctx->allow_reporting = true;
> +       kmsan_internal_unpoison_memory(info, sizeof(*info), false);
> +}
> +
>  void kmsan_internal_poison_memory(void *address, size_t size, gfp_t flags,
>                                   unsigned int poison_flags)
>  {
> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> index 052e17b7a717d..43a529569053d 100644
> --- a/mm/kmsan/hooks.c
> +++ b/mm/kmsan/hooks.c
> @@ -26,6 +26,25 @@
>   * skipping effects of functions like memset() inside instrumented code.
>   */
>
> +void kmsan_task_create(struct task_struct *task)
> +{
> +       kmsan_enter_runtime();
> +       kmsan_internal_task_create(task);
> +       kmsan_leave_runtime();
> +}
> +EXPORT_SYMBOL(kmsan_task_create);
> +
> +void kmsan_task_exit(struct task_struct *task)
> +{
> +       struct kmsan_ctx *ctx = &task->kmsan_ctx;
> +
> +       if (!kmsan_enabled || kmsan_in_runtime())
> +               return;
> +
> +       ctx->allow_reporting = false;
> +}
> +EXPORT_SYMBOL(kmsan_task_exit);

Why are these EXPORT_SYMBOL? Will they be used from some kernel module?
