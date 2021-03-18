Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C0A340D0A
	for <lists+linux-arch@lfdr.de>; Thu, 18 Mar 2021 19:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhCRSb4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Mar 2021 14:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbhCRSbb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Mar 2021 14:31:31 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A418BC061761
        for <linux-arch@vger.kernel.org>; Thu, 18 Mar 2021 11:31:30 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id z8so8707148ljm.12
        for <linux-arch@vger.kernel.org>; Thu, 18 Mar 2021 11:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dIq1u4ifgyugV1ACzu3RDx53gglMvtefOsgSWU4C8lM=;
        b=snpnSGrQTZXRRsNjmoqbl9JHu/I7UN8FEcOkqpvGjCwRpvZjL0M9XIK5ymYGrbOTJL
         y74RZpTikwDnkxWYzrkBcIJfSMHUlS/Q7E0etZrTjj9c+OrIRFf2J6QtI9N6h0DGhTVd
         kv2tbLJx43Bn8dua4d7zrxsSeJ/9kHWIKT+FZB8BfJ2WpDQISl13YpRaq8ogfdUObui4
         ANf799SetNqMPPGE+ICKB+5jTCYwfCTQIFeaFeMtyAAT3Ox44i6CXsrz+bDS6C45uBmS
         XnLsSm+mloV7/aQwPuSe6LfG3NmCZdWVErqJF4RhLhWhMabPsrnY7EhRG+X86sMwPNm0
         h96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dIq1u4ifgyugV1ACzu3RDx53gglMvtefOsgSWU4C8lM=;
        b=ffkrFMUtkbOunTit+L4dV/eRSMLreZnIKvRj743DVzvUlPmWREP7jSmbjC3pW0m0de
         AaA11XSQ0wxVdAfd885RFnaPWtlxKYGJmaBq5YY0c23Olrr/8475/Eg+sZajIUaIolRM
         ZthG3UZ27pebTXXDuSsi+H4KDCf+q/vkaAd/wepVR6gmF7XzqA+Rb7xgA32lTUPJpjXx
         vJ5dZwpA5HEIOMRpW1ACXv6LaiiSLtFlhgJguUw8En+mQS9Q/mwQjFYmd64vUyU8ciui
         6f9qAgwzWWUS99NjtTydQJe1+LGFi4u9adTMM4eNGa5nKZJfdYmeIsOwbm2F3chUASgH
         nXtg==
X-Gm-Message-State: AOAM532vI5BrOeXtglO3+5mS46YhcCB3e3lMWMxvN/9MmQnbQi+au8IE
        uOZk8LLgRajl8iV9KoF4FqP1iaQbpuAe7zKNzMWJwQ==
X-Google-Smtp-Source: ABdhPJxYI4Ni5EeKFZJ4EUZUt0SbxaXz+OFmajEMvrj1cKw0K3kwb/rWVM/Z9Oi8E17uksIN9MDcE9zE/SN+K0kwRow=
X-Received: by 2002:a2e:b008:: with SMTP id y8mr5765845ljk.233.1616092288700;
 Thu, 18 Mar 2021 11:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com> <20210318171111.706303-10-samitolvanen@google.com>
In-Reply-To: <20210318171111.706303-10-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Mar 2021 11:31:16 -0700
Message-ID: <CAKwvOdn1mkq1GL0nobyvpiAHMzA6rmvmdd_UfauO9YLs5rUAVw@mail.gmail.com>
Subject: Re: [PATCH v2 09/17] lib/list_sort: fix function type mismatches
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 18, 2021 at 10:11 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Casting the comparison function to a different type trips indirect
> call Control-Flow Integrity (CFI) checking. Remove the additional
> consts from cmp_func, and the now unneeded casts.
>
> Fixes: 043b3f7b6388 ("lib/list_sort: simplify and remove MAX_LIST_LENGTH_BITS")
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  lib/list_sort.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/list_sort.c b/lib/list_sort.c
> index 52f0c258c895..b14accf4ef83 100644
> --- a/lib/list_sort.c
> +++ b/lib/list_sort.c
> @@ -8,7 +8,7 @@
>  #include <linux/list.h>
>
>  typedef int __attribute__((nonnull(2,3))) (*cmp_func)(void *,
> -               struct list_head const *, struct list_head const *);
> +               struct list_head *, struct list_head *);
>
>  /*
>   * Returns a list organized in an intermediate format suited
> @@ -227,7 +227,7 @@ void list_sort(void *priv, struct list_head *head,

There's definitely some const confusion going on around here.
Comparison functions that modify their in/out parameters are a code
smell, and I wonder if any exist in tree?

I think it would be better to enforce one signature for cmp_func
throughout lib/list_sort.c and the tree, either const or not, but not
a mix of both.  I know `const` is messy because it tends to propagate
everywhere, so I don't care which is preferred (making cmp_func have
const qualified params or not, though if we're already being pedantic
about which params are non-null...), but something like this might be
nicer:

```
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 5132f64a5cee..d475b3cfd06f 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -75,7 +75,8 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
        blk_mq_run_hw_queue(hctx, true);
 }

-static int sched_rq_cmp(void *priv, struct list_head *a, struct list_head *b)
+static int sched_rq_cmp(void *priv, const struct list_head *a,
+               const struct list_head *b)
 {
        struct request *rqa = container_of(a, struct request, queuelist);
        struct request *rqb = container_of(b, struct request, queuelist);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2e825a7a3606..9ed063ffdb27 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1905,7 +1905,8 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx
*hctx, struct blk_mq_ctx *ctx,
        spin_unlock(&ctx->lock);
 }

-static int plug_rq_cmp(void *priv, struct list_head *a, struct list_head *b)
+static int plug_rq_cmp(void *priv, const struct list_head *a,
+               const struct list_head *b)
 {
        struct request *rqa = container_of(a, struct request, queuelist);
        struct request *rqb = container_of(b, struct request, queuelist);
diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 1ac67d4505e0..5a3a343499f6 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1290,7 +1290,8 @@ EXPORT_SYMBOL(drm_mode_prune_invalid);
  * Negative if @lh_a is better than @lh_b, zero if they're equivalent, or
  * positive if @lh_b is better than @lh_a.
  */
-static int drm_mode_compare(void *priv, struct list_head *lh_a,
struct list_head *lh_b)
+static int drm_mode_compare(void *priv, const struct list_head *lh_a,
+               const struct list_head *lh_b)
 {
        struct drm_display_mode *a = list_entry(lh_a, struct
drm_display_mode, head);
        struct drm_display_mode *b = list_entry(lh_b, struct
drm_display_mode, head);
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_user.c
b/drivers/gpu/drm/i915/gt/intel_engine_user.c
index 34e6096f196e..7586dffd27d3 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_user.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_user.c
@@ -49,7 +49,8 @@ static const u8 uabi_classes[] = {
        [VIDEO_ENHANCEMENT_CLASS] = I915_ENGINE_CLASS_VIDEO_ENHANCE,
 };

-static int engine_cmp(void *priv, struct list_head *A, struct list_head *B)
+static int engine_cmp(void *priv, const struct list_head *A,
+               const struct list_head *B)
 {
        const struct intel_engine_cs *a =
                container_of((struct rb_node *)A, typeof(*a), uabi_node);
diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 4c2a9fe30067..4493ef0c715e 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -354,8 +354,8 @@ static unsigned int ext4_getfsmap_find_sb(struct
super_block *sb,

 /* Compare two fsmap items. */
 static int ext4_getfsmap_compare(void *priv,
-                                struct list_head *a,
-                                struct list_head *b)
+                                const struct list_head *a,
+                                const struct list_head *b)
 {
        struct ext4_fsmap *fa;
        struct ext4_fsmap *fb;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 414769a6ad11..0129e6bab985 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1155,7 +1155,8 @@ iomap_ioend_try_merge(struct iomap_ioend *ioend,
struct list_head *more_ioends,
 EXPORT_SYMBOL_GPL(iomap_ioend_try_merge);

 static int
-iomap_ioend_compare(void *priv, struct list_head *a, struct list_head *b)
+iomap_ioend_compare(void *priv, const struct list_head *a,
+               const struct list_head *b)
 {
        struct iomap_ioend *ia = container_of(a, struct iomap_ioend, io_list);
        struct iomap_ioend *ib = container_of(b, struct iomap_ioend, io_list);
diff --git a/include/linux/list_sort.h b/include/linux/list_sort.h
index 20f178c24e9d..4fe9cb94d0d1 100644
--- a/include/linux/list_sort.h
+++ b/include/linux/list_sort.h
@@ -6,8 +6,9 @@

 struct list_head;

+typedef int __attribute__((nonnull(2,3))) (*cmp_func)(void *,
+               struct list_head const *, struct list_head const *);
+
 __attribute__((nonnull(2,3)))
-void list_sort(void *priv, struct list_head *head,
-              int (*cmp)(void *priv, struct list_head *a,
-                         struct list_head *b));
+void list_sort(void *priv, struct list_head *head, cmp_func cmp);
 #endif
diff --git a/lib/list_sort.c b/lib/list_sort.c
index 52f0c258c895..6cfac649c4a6 100644
--- a/lib/list_sort.c
+++ b/lib/list_sort.c
@@ -7,9 +7,6 @@
 #include <linux/list_sort.h>
 #include <linux/list.h>

-typedef int __attribute__((nonnull(2,3))) (*cmp_func)(void *,
-               struct list_head const *, struct list_head const *);
-
 /*
  * Returns a list organized in an intermediate format suited
  * to chaining of merge() calls: null-terminated, no reserved or
@@ -185,9 +182,7 @@ static void merge_final(void *priv, cmp_func cmp,
struct list_head *head,
  * 2^(k+1) - 1 (second merge of case 5 when x == 2^(k-1) - 1).
  */
 __attribute__((nonnull(2,3)))
-void list_sort(void *priv, struct list_head *head,
-               int (*cmp)(void *priv, struct list_head *a,
-                       struct list_head *b))
+void list_sort(void *priv, struct list_head *head, cmp_func cmp)
 {
        struct list_head *list = head->next, *pending = NULL;
        size_t count = 0;       /* Count of pending */
```
There are probably more instances in the tree to clean up, but that
compiles with x86_64 defconfig, and I'm sure it doesn't suffer the CFI
issue from the cast.

>                 if (likely(bits)) {
>                         struct list_head *a = *tail, *b = a->prev;
>
> -                       a = merge(priv, (cmp_func)cmp, b, a);
> +                       a = merge(priv, cmp, b, a);
>                         /* Install the merged result in place of the inputs */
>                         a->prev = b->prev;
>                         *tail = a;
> @@ -249,10 +249,10 @@ void list_sort(void *priv, struct list_head *head,
>
>                 if (!next)
>                         break;
> -               list = merge(priv, (cmp_func)cmp, pending, list);
> +               list = merge(priv, cmp, pending, list);
>                 pending = next;
>         }
>         /* The final merge, rebuilding prev links */
> -       merge_final(priv, (cmp_func)cmp, head, pending, list);
> +       merge_final(priv, cmp, head, pending, list);
>  }
>  EXPORT_SYMBOL(list_sort);
> --
> 2.31.0.291.g576ba9dcdaf-goog
>


-- 
Thanks,
~Nick Desaulniers
