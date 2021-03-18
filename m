Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A48340FE0
	for <lists+linux-arch@lfdr.de>; Thu, 18 Mar 2021 22:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhCRVbs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Mar 2021 17:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbhCRVbZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Mar 2021 17:31:25 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B29C061760
        for <linux-arch@vger.kernel.org>; Thu, 18 Mar 2021 14:31:25 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id l22so2365443vsr.13
        for <linux-arch@vger.kernel.org>; Thu, 18 Mar 2021 14:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tdIaU5y5aj4CvY8gHTbhPiKBxK+0c5ivS4PVgMAZKZ8=;
        b=VQHQ/IJvAGsBh7hccszXuTdFbZijYzXgXzXCIzA2a7dJpcH6fMreeEP4JQX8vzYKQw
         17gzUL7p9HLsJm+wzC+7kwxysSLLUOFU16pfSruy8k6oojzW6uUwDEqIIQ26n833XpIJ
         nRIT5osS4S0zWgKG08L3MvJDPQXbeiXJD6WWF5WIFCRxvrdTy84dUo63hUjFPxVpT7Qy
         r5rNK69CITHSj/xGsPVpV9x9ROfn6UB5BwpBhGwl6SCSaK4S3ZvoQ6/MX7DPhBlfODxu
         KDDy3/ne6shrgGrU4yEniwtyCra85G6v6KXM3roh3xjBdCjKrCkGBpOWV+Hs3zFkXA+U
         WlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tdIaU5y5aj4CvY8gHTbhPiKBxK+0c5ivS4PVgMAZKZ8=;
        b=EVdKhbj7IL39Wkri9Ymo4Dn0uE7EXnd2uTJm2oewE1Cma3ZkFl0yXhKYHLdQiaob9p
         hz+QGKTdxjaY71An0tUtEbqtmixj1qy/+NplSLJxONiNnI8BLGmw661/UH/QrXuGH+Xx
         JLZp/zv7aGerDBdIo4DomZlnN/jrtp0JUt66IJc3XkUuhkJq7GH3hvY7pzA1hSBi87zY
         Ed+nExoQ1JyH20Tgxu7Co7xh03Ua/dfN/X2veQzGYAEAcNHAsygn8ojMBV9zIrhdvAT1
         5qRHqvQAzJ+QDCA1qzdp2BfEv7e+WVjTXQ/W0SeSR8VS0oqifAdW53Koi0/jc0Uj5bND
         0rDQ==
X-Gm-Message-State: AOAM530tdNTA531TeSvV1t+sv0N5gMHuMCvPAZm/x9Y+01OcSvAKvx8D
        bg1woYN752t0FC1O1zia180FbAPflgFL/mXLOMNUIQ==
X-Google-Smtp-Source: ABdhPJxlimnSXWyxeVH26Hx7MVzsZM1C2wpNoVlO6BH9QnMVU1txUFQEowbO9H2O2Syt3coKLcU+m/27jcEX/CvNAbI=
X-Received: by 2002:a67:2803:: with SMTP id o3mr1129222vso.36.1616103083753;
 Thu, 18 Mar 2021 14:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
 <20210318171111.706303-10-samitolvanen@google.com> <CAKwvOdn1mkq1GL0nobyvpiAHMzA6rmvmdd_UfauO9YLs5rUAVw@mail.gmail.com>
In-Reply-To: <CAKwvOdn1mkq1GL0nobyvpiAHMzA6rmvmdd_UfauO9YLs5rUAVw@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 18 Mar 2021 14:31:11 -0700
Message-ID: <CABCJKucamBXi4LLLatcjHUOfPX7Pb8NO9Q19mGMX-PLhzCjF3A@mail.gmail.com>
Subject: Re: [PATCH v2 09/17] lib/list_sort: fix function type mismatches
To:     Nick Desaulniers <ndesaulniers@google.com>
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

On Thu, Mar 18, 2021 at 11:31 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Mar 18, 2021 at 10:11 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > Casting the comparison function to a different type trips indirect
> > call Control-Flow Integrity (CFI) checking. Remove the additional
> > consts from cmp_func, and the now unneeded casts.
> >
> > Fixes: 043b3f7b6388 ("lib/list_sort: simplify and remove MAX_LIST_LENGTH_BITS")
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> >  lib/list_sort.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/list_sort.c b/lib/list_sort.c
> > index 52f0c258c895..b14accf4ef83 100644
> > --- a/lib/list_sort.c
> > +++ b/lib/list_sort.c
> > @@ -8,7 +8,7 @@
> >  #include <linux/list.h>
> >
> >  typedef int __attribute__((nonnull(2,3))) (*cmp_func)(void *,
> > -               struct list_head const *, struct list_head const *);
> > +               struct list_head *, struct list_head *);
> >
> >  /*
> >   * Returns a list organized in an intermediate format suited
> > @@ -227,7 +227,7 @@ void list_sort(void *priv, struct list_head *head,
>
> There's definitely some const confusion going on around here.
> Comparison functions that modify their in/out parameters are a code
> smell, and I wonder if any exist in tree?
>
> I think it would be better to enforce one signature for cmp_func
> throughout lib/list_sort.c and the tree, either const or not, but not
> a mix of both.  I know `const` is messy because it tends to propagate
> everywhere, so I don't care which is preferred (making cmp_func have
> const qualified params or not, though if we're already being pedantic
> about which params are non-null...), but something like this might be
> nicer:

Sure, an alternative to removing the internal casts is to actually
change all the callers to use a comparison function with const
parameters. That's quite a bit more invasive, but I'm fine with that
approach too.

>
> ```
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 5132f64a5cee..d475b3cfd06f 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -75,7 +75,8 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
>         blk_mq_run_hw_queue(hctx, true);
>  }
>
> -static int sched_rq_cmp(void *priv, struct list_head *a, struct list_head *b)
> +static int sched_rq_cmp(void *priv, const struct list_head *a,
> +               const struct list_head *b)
>  {
>         struct request *rqa = container_of(a, struct request, queuelist);
>         struct request *rqb = container_of(b, struct request, queuelist);
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 2e825a7a3606..9ed063ffdb27 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1905,7 +1905,8 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx
> *hctx, struct blk_mq_ctx *ctx,
>         spin_unlock(&ctx->lock);
>  }
>
> -static int plug_rq_cmp(void *priv, struct list_head *a, struct list_head *b)
> +static int plug_rq_cmp(void *priv, const struct list_head *a,
> +               const struct list_head *b)
>  {
>         struct request *rqa = container_of(a, struct request, queuelist);
>         struct request *rqb = container_of(b, struct request, queuelist);
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index 1ac67d4505e0..5a3a343499f6 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -1290,7 +1290,8 @@ EXPORT_SYMBOL(drm_mode_prune_invalid);
>   * Negative if @lh_a is better than @lh_b, zero if they're equivalent, or
>   * positive if @lh_b is better than @lh_a.
>   */
> -static int drm_mode_compare(void *priv, struct list_head *lh_a,
> struct list_head *lh_b)
> +static int drm_mode_compare(void *priv, const struct list_head *lh_a,
> +               const struct list_head *lh_b)
>  {
>         struct drm_display_mode *a = list_entry(lh_a, struct
> drm_display_mode, head);
>         struct drm_display_mode *b = list_entry(lh_b, struct
> drm_display_mode, head);
> diff --git a/drivers/gpu/drm/i915/gt/intel_engine_user.c
> b/drivers/gpu/drm/i915/gt/intel_engine_user.c
> index 34e6096f196e..7586dffd27d3 100644
> --- a/drivers/gpu/drm/i915/gt/intel_engine_user.c
> +++ b/drivers/gpu/drm/i915/gt/intel_engine_user.c
> @@ -49,7 +49,8 @@ static const u8 uabi_classes[] = {
>         [VIDEO_ENHANCEMENT_CLASS] = I915_ENGINE_CLASS_VIDEO_ENHANCE,
>  };
>
> -static int engine_cmp(void *priv, struct list_head *A, struct list_head *B)
> +static int engine_cmp(void *priv, const struct list_head *A,
> +               const struct list_head *B)
>  {
>         const struct intel_engine_cs *a =
>                 container_of((struct rb_node *)A, typeof(*a), uabi_node);
> diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
> index 4c2a9fe30067..4493ef0c715e 100644
> --- a/fs/ext4/fsmap.c
> +++ b/fs/ext4/fsmap.c
> @@ -354,8 +354,8 @@ static unsigned int ext4_getfsmap_find_sb(struct
> super_block *sb,
>
>  /* Compare two fsmap items. */
>  static int ext4_getfsmap_compare(void *priv,
> -                                struct list_head *a,
> -                                struct list_head *b)
> +                                const struct list_head *a,
> +                                const struct list_head *b)
>  {
>         struct ext4_fsmap *fa;
>         struct ext4_fsmap *fb;
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 414769a6ad11..0129e6bab985 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1155,7 +1155,8 @@ iomap_ioend_try_merge(struct iomap_ioend *ioend,
> struct list_head *more_ioends,
>  EXPORT_SYMBOL_GPL(iomap_ioend_try_merge);
>
>  static int
> -iomap_ioend_compare(void *priv, struct list_head *a, struct list_head *b)
> +iomap_ioend_compare(void *priv, const struct list_head *a,
> +               const struct list_head *b)
>  {
>         struct iomap_ioend *ia = container_of(a, struct iomap_ioend, io_list);
>         struct iomap_ioend *ib = container_of(b, struct iomap_ioend, io_list);
> diff --git a/include/linux/list_sort.h b/include/linux/list_sort.h
> index 20f178c24e9d..4fe9cb94d0d1 100644
> --- a/include/linux/list_sort.h
> +++ b/include/linux/list_sort.h
> @@ -6,8 +6,9 @@
>
>  struct list_head;
>
> +typedef int __attribute__((nonnull(2,3))) (*cmp_func)(void *,
> +               struct list_head const *, struct list_head const *);
> +

Note that we already have cmp_func_t in linux/types.h, so something
like list_cmp_func_t would probably be more appropriate here.

>  __attribute__((nonnull(2,3)))
> -void list_sort(void *priv, struct list_head *head,
> -              int (*cmp)(void *priv, struct list_head *a,
> -                         struct list_head *b));
> +void list_sort(void *priv, struct list_head *head, cmp_func cmp);
>  #endif
> diff --git a/lib/list_sort.c b/lib/list_sort.c
> index 52f0c258c895..6cfac649c4a6 100644
> --- a/lib/list_sort.c
> +++ b/lib/list_sort.c
> @@ -7,9 +7,6 @@
>  #include <linux/list_sort.h>
>  #include <linux/list.h>
>
> -typedef int __attribute__((nonnull(2,3))) (*cmp_func)(void *,
> -               struct list_head const *, struct list_head const *);
> -
>  /*
>   * Returns a list organized in an intermediate format suited
>   * to chaining of merge() calls: null-terminated, no reserved or
> @@ -185,9 +182,7 @@ static void merge_final(void *priv, cmp_func cmp,
> struct list_head *head,
>   * 2^(k+1) - 1 (second merge of case 5 when x == 2^(k-1) - 1).
>   */
>  __attribute__((nonnull(2,3)))
> -void list_sort(void *priv, struct list_head *head,
> -               int (*cmp)(void *priv, struct list_head *a,
> -                       struct list_head *b))
> +void list_sort(void *priv, struct list_head *head, cmp_func cmp)
>  {
>         struct list_head *list = head->next, *pending = NULL;
>         size_t count = 0;       /* Count of pending */
> ```
> There are probably more instances in the tree to clean up, but that
> compiles with x86_64 defconfig, and I'm sure it doesn't suffer the CFI
> issue from the cast.

You indeed missed some callers, but after fixing all the remaining
ones too, arm64 and x86_64 allyesconfigs still seem to build just fine
for me:

 arch/arm64/kvm/vgic/vgic-its.c                         |    8 ++++----
 arch/arm64/kvm/vgic/vgic.c                             |    2 +-
 block/blk-mq-sched.c                                   |    2 +-
 block/blk-mq.c                                         |    2 +-
 drivers/acpi/nfit/core.c                               |    2 +-
 drivers/acpi/numa/hmat.c                               |    2 +-
 drivers/clk/keystone/sci-clk.c                         |    4 ++--
 drivers/gpu/drm/drm_modes.c                            |    2 +-
 drivers/gpu/drm/i915/gt/intel_engine_user.c            |    2 +-
 drivers/gpu/drm/i915/gvt/debugfs.c                     |    2 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c          |    2 +-
 drivers/gpu/drm/radeon/radeon_cs.c                     |    4 ++--
 drivers/infiniband/hw/usnic/usnic_uiom_interval_tree.c |    2 +-
 drivers/interconnect/qcom/bcm-voter.c                  |    2 +-
 drivers/md/raid5.c                                     |    2 +-
 drivers/misc/sram.c                                    |    4 ++--
 drivers/nvme/host/core.c                               |    2 +-
 drivers/pci/controller/cadence/pcie-cadence-host.c     |    3 ++-
 drivers/spi/spi-loopback-test.c                        |    2 +-
 fs/btrfs/raid56.c                                      |    2 +-
 fs/btrfs/tree-log.c                                    |    2 +-
 fs/btrfs/volumes.c                                     |    2 +-
 fs/ext4/fsmap.c                                        |    4 ++--
 fs/gfs2/glock.c                                        |    2 +-
 fs/gfs2/log.c                                          |    2 +-
 fs/gfs2/lops.c                                         |    2 +-
 fs/iomap/buffered-io.c                                 |    2 +-
 fs/ubifs/gc.c                                          |    6 +++---
 fs/ubifs/replay.c                                      |    4 ++--
 fs/xfs/scrub/bitmap.c                                  |    4 ++--
 fs/xfs/xfs_bmap_item.c                                 |    4 ++--
 fs/xfs/xfs_buf.c                                       |    4 ++--
 fs/xfs/xfs_extent_busy.c                               |    4 ++--
 fs/xfs/xfs_extent_busy.h                               |    2 +-
 fs/xfs/xfs_extfree_item.c                              |    4 ++--
 fs/xfs/xfs_refcount_item.c                             |    4 ++--
 fs/xfs/xfs_rmap_item.c                                 |    4 ++--
 include/linux/list_sort.h                              |    7 ++++---
 lib/list_sort.c                                        |   17 ++++++-----------
 lib/test_list_sort.c                                   |    2 +-
 net/tipc/name_table.c                                  |    4 ++--
 41 files changed, 68 insertions(+), 71 deletions(-)

I'll have to double check that all the affected code is actually
included in these builds, but if nobody objects and I don't run into
any issues, I'll include the patch in v3.

Sami
