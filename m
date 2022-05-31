Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3E5538F74
	for <lists+linux-arch@lfdr.de>; Tue, 31 May 2022 13:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbiEaLJN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 May 2022 07:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbiEaLJM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2022 07:09:12 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60E06543B
        for <linux-arch@vger.kernel.org>; Tue, 31 May 2022 04:09:02 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i11so23246359ybq.9
        for <linux-arch@vger.kernel.org>; Tue, 31 May 2022 04:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=89pC4XAY/z7UFh8pChBVS1ZQvKsoUeUASgbw5YbK0vc=;
        b=WH6nv9XGBBvYE/EJVsBsetFL3K/2dnsepRiPWWefvzuNQ2H08fhosgVIq+/jckp7vj
         6Cj1Sn6opNp7EklkkvlfTkPmNaJqKx1xgtcKy0XfStkK1NDdZ7bgndzjXpbKB9C9LzH/
         2qWuDEXvJsrvOfeCnxViRbjfj9Ld7kO66scYiiKJlHLTGXGnvWeMJ+5lrKhZL54lHRQU
         oCje1QHskhwX7U/E8I+KJzzTvgl8bAcOeFRtXSHGoPq0vHbpI4kt7iMW0m3Hw/A4nCUv
         oC98f8tV7utb+cmW5FYmD/BBYwuzhy6Ddyvz4sjCW428gRiZa5AfumF6y+GXRg+vY+rG
         o82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=89pC4XAY/z7UFh8pChBVS1ZQvKsoUeUASgbw5YbK0vc=;
        b=NmVaaEQv9L1cUi/du2w48ycd6shYp0zUVyrmH06i56aNBuLXbJITeL7YmxIcuN/Bj1
         c+iE0v9/ZcdMD4Lysq0ff4DGmXV3dg8kTsiiDiesA7C3IKsLJyqqgoFupcGgH77CGYKa
         a7esIZEXdGI75Qr5EThOWUIb6xq2AMxKx/p7S4B3JCsuVxTHsfuPBwf/HBlF3lwxddDV
         ywWFrVxMrnYbtzPHuGt8FE3WB8c4rORMk6AxoGtfVLiJfCxiTVfiWT+EiVmiV2UUeUbh
         coIFBUETfcQ4SVYqS6QPJ4TAcRdVeEx7cnGU1LDvEBLdxvMSm9AJpC3e8ns/42TJ0Cqt
         bCTw==
X-Gm-Message-State: AOAM531Tsqg6YhHbrRJzIfbHvqolBRFJxgPJGQLlBbugzSXZ6mAemTNA
        SUfr9z8gBxeKCuZK5U5Y3R8UZDsG0j2rBuk6Kh16Fw==
X-Google-Smtp-Source: ABdhPJywTFYvHz5jAKczkFsAZFFFicGIewXHdYyeYgIkc9vTXdb/QDU5I7aoOn74JYQWcbvKwZc70caiYP5VahUifsk=
X-Received: by 2002:a25:4585:0:b0:65d:49fc:7949 with SMTP id
 s127-20020a254585000000b0065d49fc7949mr1914785yba.307.1653995341430; Tue, 31
 May 2022 04:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220426164315.625149-1-glider@google.com> <20220426164315.625149-13-glider@google.com>
 <YmlOrxYCbAnVrV7r@elver.google.com>
In-Reply-To: <YmlOrxYCbAnVrV7r@elver.google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 31 May 2022 13:08:25 +0200
Message-ID: <CAG_fn=XvG5atw4qEOKRB0ZmBf5uMutFEV1zVVv6fUTtV_2+bBw@mail.gmail.com>
Subject: Re: [PATCH v3 12/46] kmsan: add KMSAN runtime core
To:     Marco Elver <elver@google.com>
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
Content-Transfer-Encoding: quoted-printable
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

On Wed, Apr 27, 2022 at 4:10 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Apr 26, 2022 at 06:42PM +0200, Alexander Potapenko wrote:
> > For each memory location KernelMemorySanitizer maintains two types of
> > metadata:
> > 1. The so-called shadow of that location - =D0=B0 byte:byte mapping des=
cribing
> >    whether or not individual bits of memory are initialized (shadow is =
0)
> >    or not (shadow is 1).
> > 2. The origins of that location - =D0=B0 4-byte:4-byte mapping containi=
ng
> >    4-byte IDs of the stack traces where uninitialized values were
> >    created.
> >
> > Each struct page now contains pointers to two struct pages holding
> > KMSAN metadata (shadow and origins) for the original struct page.
> > Utility routines in mm/kmsan/core.c and mm/kmsan/shadow.c handle the
> > metadata creation, addressing, copying and checking.
> > mm/kmsan/report.c performs error reporting in the cases an uninitialize=
d
> > value is used in a way that leads to undefined behavior.
> >
> > KMSAN compiler instrumentation is responsible for tracking the metadata
> > along with the kernel memory. mm/kmsan/instrumentation.c provides the
> > implementation for instrumentation hooks that are called from files
> > compiled with -fsanitize=3Dkernel-memory.
> >
> > To aid parameter passing (also done at instrumentation level), each
> > task_struct now contains a struct kmsan_task_state used to track the
> > metadata of function parameters and return values for that task.
> >
> > Finally, this patch provides CONFIG_KMSAN that enables KMSAN, and
> > declares CFLAGS_KMSAN, which are applied to files compiled with KMSAN.
> > The KMSAN_SANITIZE:=3Dn Makefile directive can be used to completely
> > disable KMSAN instrumentation for certain files.
> >
> > Similarly, KMSAN_ENABLE_CHECKS:=3Dn disables KMSAN checks and makes new=
ly
> > created stack memory initialized.
> >
> > Users can also use functions from include/linux/kmsan-checks.h to mark
> > certain memory regions as uninitialized or initialized (this is called
> > "poisoning" and "unpoisoning") or check that a particular region is
> > initialized.
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > ---
> > v2:
> >  -- as requested by Greg K-H, moved hooks for different subsystems to r=
espective patches,
> >     rewrote the patch description;
> >  -- addressed comments by Dmitry Vyukov;
> >  -- added a note about KMSAN being not intended for production use.
> >  -- fix case of unaligned dst in kmsan_internal_memmove_metadata()
> >
> > v3:
> >  -- print build IDs in reports where applicable
> >  -- drop redundant filter_irq_stacks(), unpoison the local passed to __=
stack_depot_save()
> >  -- remove a stray BUG()
> >
> > Link: https://linux-review.googlesource.com/id/I9b71bfe3425466c97159f9d=
e0062e5e8e4fec866
> > ---
> >  Makefile                     |   1 +
> >  include/linux/kmsan-checks.h |  64 +++++
> >  include/linux/kmsan.h        |  47 ++++
> >  include/linux/mm_types.h     |  12 +
> >  include/linux/sched.h        |   5 +
> >  lib/Kconfig.debug            |   1 +
> >  lib/Kconfig.kmsan            |  23 ++
> >  mm/Makefile                  |   1 +
> >  mm/kmsan/Makefile            |  18 ++
> >  mm/kmsan/core.c              | 458 +++++++++++++++++++++++++++++++++++
> >  mm/kmsan/hooks.c             |  66 +++++
> >  mm/kmsan/instrumentation.c   | 267 ++++++++++++++++++++
> >  mm/kmsan/kmsan.h             | 183 ++++++++++++++
> >  mm/kmsan/report.c            | 211 ++++++++++++++++
> >  mm/kmsan/shadow.c            | 186 ++++++++++++++
> >  scripts/Makefile.kmsan       |   1 +
> >  scripts/Makefile.lib         |   9 +
> >  17 files changed, 1553 insertions(+)
> >  create mode 100644 include/linux/kmsan-checks.h
> >  create mode 100644 include/linux/kmsan.h
> >  create mode 100644 lib/Kconfig.kmsan
> >  create mode 100644 mm/kmsan/Makefile
> >  create mode 100644 mm/kmsan/core.c
> >  create mode 100644 mm/kmsan/hooks.c
> >  create mode 100644 mm/kmsan/instrumentation.c
> >  create mode 100644 mm/kmsan/kmsan.h
> >  create mode 100644 mm/kmsan/report.c
> >  create mode 100644 mm/kmsan/shadow.c
> >  create mode 100644 scripts/Makefile.kmsan
> >
> > diff --git a/Makefile b/Makefile
> > index c3ec1ea423797..d3c7dcd9f0fea 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1009,6 +1009,7 @@ include-y                       :=3D scripts/Make=
file.extrawarn
> >  include-$(CONFIG_DEBUG_INFO) +=3D scripts/Makefile.debug
> >  include-$(CONFIG_KASAN)              +=3D scripts/Makefile.kasan
> >  include-$(CONFIG_KCSAN)              +=3D scripts/Makefile.kcsan
> > +include-$(CONFIG_KMSAN)              +=3D scripts/Makefile.kmsan
> >  include-$(CONFIG_UBSAN)              +=3D scripts/Makefile.ubsan
> >  include-$(CONFIG_KCOV)               +=3D scripts/Makefile.kcov
> >  include-$(CONFIG_GCC_PLUGINS)        +=3D scripts/Makefile.gcc-plugins
> > diff --git a/include/linux/kmsan-checks.h b/include/linux/kmsan-checks.=
h
> > new file mode 100644
> > index 0000000000000..a6522a0c28df9
> > --- /dev/null
> > +++ b/include/linux/kmsan-checks.h
> > @@ -0,0 +1,64 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * KMSAN checks to be used for one-off annotations in subsystems.
> > + *
> > + * Copyright (C) 2017-2022 Google LLC
> > + * Author: Alexander Potapenko <glider@google.com>
> > + *
> > + */
> > +
> > +#ifndef _LINUX_KMSAN_CHECKS_H
> > +#define _LINUX_KMSAN_CHECKS_H
> > +
> > +#include <linux/types.h>
> > +
> > +#ifdef CONFIG_KMSAN
> > +
> > +/**
> > + * kmsan_poison_memory() - Mark the memory range as uninitialized.
> > + * @address: address to start with.
> > + * @size:    size of buffer to poison.
> > + * @flags:   GFP flags for allocations done by this function.
> > + *
> > + * Until other data is written to this range, KMSAN will treat it as
> > + * uninitialized. Error reports for this memory will reference the cal=
l site of
> > + * kmsan_poison_memory() as origin.
> > + */
> > +void kmsan_poison_memory(const void *address, size_t size, gfp_t flags=
);
> > +
> > +/**
> > + * kmsan_unpoison_memory() -  Mark the memory range as initialized.
> > + * @address: address to start with.
> > + * @size:    size of buffer to unpoison.
> > + *
> > + * Until other data is written to this range, KMSAN will treat it as
> > + * initialized.
> > + */
> > +void kmsan_unpoison_memory(const void *address, size_t size);
> > +
> > +/**
> > + * kmsan_check_memory() - Check the memory range for being initialized=
.
> > + * @address: address to start with.
> > + * @size:    size of buffer to check.
> > + *
> > + * If any piece of the given range is marked as uninitialized, KMSAN w=
ill report
> > + * an error.
> > + */
> > +void kmsan_check_memory(const void *address, size_t size);
> > +
> > +#else
> > +
> > +static inline void kmsan_poison_memory(const void *address, size_t siz=
e,
> > +                                    gfp_t flags)
> > +{
> > +}
> > +static inline void kmsan_unpoison_memory(const void *address, size_t s=
ize)
> > +{
> > +}
> > +static inline void kmsan_check_memory(const void *address, size_t size=
)
> > +{
> > +}
> > +
> > +#endif
> > +
> > +#endif /* _LINUX_KMSAN_CHECKS_H */
> > diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
> > new file mode 100644
> > index 0000000000000..4e35f43eceaa9
> > --- /dev/null
> > +++ b/include/linux/kmsan.h
> > @@ -0,0 +1,47 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * KMSAN API for subsystems.
> > + *
> > + * Copyright (C) 2017-2022 Google LLC
> > + * Author: Alexander Potapenko <glider@google.com>
> > + *
> > + */
> > +#ifndef _LINUX_KMSAN_H
> > +#define _LINUX_KMSAN_H
> > +
> > +#include <linux/gfp.h>
> > +#include <linux/kmsan-checks.h>
> > +#include <linux/stackdepot.h>
> > +#include <linux/types.h>
> > +#include <linux/vmalloc.h>
> > +
> > +struct page;
> > +
> > +#ifdef CONFIG_KMSAN
> > +
> > +/* These constants are defined in the MSan LLVM instrumentation pass. =
*/
> > +#define KMSAN_RETVAL_SIZE 800
> > +#define KMSAN_PARAM_SIZE 800
> > +
> > +struct kmsan_context_state {
> > +     char param_tls[KMSAN_PARAM_SIZE];
> > +     char retval_tls[KMSAN_RETVAL_SIZE];
> > +     char va_arg_tls[KMSAN_PARAM_SIZE];
> > +     char va_arg_origin_tls[KMSAN_PARAM_SIZE];
> > +     u64 va_arg_overflow_size_tls;
> > +     char param_origin_tls[KMSAN_PARAM_SIZE];
> > +     depot_stack_handle_t retval_origin_tls;
> > +};
> > +
> > +#undef KMSAN_PARAM_SIZE
> > +#undef KMSAN_RETVAL_SIZE
> > +
> > +struct kmsan_ctx {
> > +     struct kmsan_context_state cstate;
> > +     int kmsan_in_runtime;
> > +     bool allow_reporting;
> > +};
> > +
> > +#endif
> > +
> > +#endif /* _LINUX_KMSAN_H */
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 8834e38c06a4f..85c97a2145f7e 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -218,6 +218,18 @@ struct page {
> >                                          not kmapped, ie. highmem) */
> >  #endif /* WANT_PAGE_VIRTUAL */
> >
> > +#ifdef CONFIG_KMSAN
> > +     /*
> > +      * KMSAN metadata for this page:
> > +      *  - shadow page: every bit indicates whether the corresponding
> > +      *    bit of the original page is initialized (0) or not (1);
> > +      *  - origin page: every 4 bytes contain an id of the stack trace
> > +      *    where the uninitialized value was created.
> > +      */
> > +     struct page *kmsan_shadow;
> > +     struct page *kmsan_origin;
> > +#endif
> > +
> >  #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
> >       int _last_cpupid;
> >  #endif
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index a8911b1f35aad..9e53624cd73ac 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -14,6 +14,7 @@
> >  #include <linux/pid.h>
> >  #include <linux/sem.h>
> >  #include <linux/shm.h>
> > +#include <linux/kmsan.h>
> >  #include <linux/mutex.h>
> >  #include <linux/plist.h>
> >  #include <linux/hrtimer.h>
> > @@ -1352,6 +1353,10 @@ struct task_struct {
> >  #endif
> >  #endif
> >
> > +#ifdef CONFIG_KMSAN
> > +     struct kmsan_ctx                kmsan_ctx;
> > +#endif
> > +
> >  #if IS_ENABLED(CONFIG_KUNIT)
> >       struct kunit                    *kunit_test;
> >  #endif
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 075cd25363ac3..b81670878acae 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -996,6 +996,7 @@ config DEBUG_STACKOVERFLOW
> >
> >  source "lib/Kconfig.kasan"
> >  source "lib/Kconfig.kfence"
> > +source "lib/Kconfig.kmsan"
> >
> >  endmenu # "Memory Debugging"
> >
> > diff --git a/lib/Kconfig.kmsan b/lib/Kconfig.kmsan
> > new file mode 100644
> > index 0000000000000..199f79d031f94
> > --- /dev/null
> > +++ b/lib/Kconfig.kmsan
> > @@ -0,0 +1,23 @@
>
> Missing SPDX-License-Identifier.
Will do in v4, thanks!

> > +config KMSAN
> > +     bool "KMSAN: detector of uninitialized values use"
> > +     depends on HAVE_ARCH_KMSAN && HAVE_KMSAN_COMPILER
> > +     depends on SLUB && DEBUG_KERNEL && !KASAN && !KCSAN
> > +     depends on CC_IS_CLANG && CLANG_VERSION >=3D 140000
>
> Shouldn't the "CC_IS_CLANG && CLANG_VERSION ..." check be a "depends on"
> in HAVE_KMSAN_COMPILER? That way all the compiler-related checks are
> confined to HAVE_KMSAN_COMPILER.
Good point, thanks!
I also think I can drop the excessive CC_IS_CLANG in the definition of
HAVE_KMSAN_COMPILER.

> I guess, it might also be worth mentioning why the version check is
> required at all (something about older compilers supporting
> fsanitize=3Dkernel-memory, but not having all features we need).
Done.

> > index 0000000000000..a80dde1de7048
> > --- /dev/null
> > +++ b/mm/kmsan/Makefile
> > @@ -0,0 +1,18 @@
>
> Makefile needs a SPDX-License-Identifier.
Done.


> > +     shadow_dst =3D kmsan_get_metadata(dst, KMSAN_META_SHADOW);
> > +     if (!shadow_dst)
> > +             return;
> > +     KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(dst, n));
> > +
> > +     shadow_src =3D kmsan_get_metadata(src, KMSAN_META_SHADOW);
> > +     if (!shadow_src) {
> > +             /*
> > +              * |src| is untracked: zero out destination shadow, ignor=
e the
>
> Probably doesn't matter too much, but for consistency elsewhere - @src?
Fixed here and in other places where |var| is used.

> > +                      * If |src| isn't aligned on KMSAN_ORIGIN_SIZE, d=
on't
> > +                      * look at the first |src % KMSAN_ORIGIN_SIZE| by=
tes
> > +                      * of the first shadow slot.
> > +                      */
E.g. here

> > +                     /*
> > +                      * If |src + n| isn't aligned on
> > +                      * KMSAN_ORIGIN_SIZE, don't look at the last
> > +                      * |(src + n) % KMSAN_ORIGIN_SIZE| bytes of the
> > +                      * last shadow slot.
> > +                      */
and here.



> > +
> > +extern bool kmsan_enabled;
> > +extern int panic_on_kmsan;
> > +
> > +/*
> > + * KMSAN performs a lot of consistency checks that are currently enabl=
ed by
> > + * default. BUG_ON is normally discouraged in the kernel, unless used =
for
> > + * debugging, but KMSAN itself is a debugging tool, so it makes little=
 sense to
> > + * recover if something goes wrong.
> > + */
> > +#define KMSAN_WARN_ON(cond)                                           =
         \
> > +     ({                                                               =
      \
> > +             const bool __cond =3D WARN_ON(cond);                     =
        \
> > +             if (unlikely(__cond)) {                                  =
      \
> > +                     WRITE_ONCE(kmsan_enabled, false);                =
      \
> > +                     if (panic_on_kmsan) {                            =
      \
> > +                             /* Can't call panic() here because */    =
      \
> > +                             /* of uaccess checks.*/                  =
      \
>
> space after '.'
Done; also reformatted the macro to use tabs instead of spaces.


> > +void kmsan_report(depot_stack_handle_t origin, void *address, int size=
,
> > +               int off_first, int off_last, const void *user_addr,
> > +               enum kmsan_bug_reason reason)
> > +{
> > +     unsigned long stack_entries[KMSAN_STACK_DEPTH];
> > +     int num_stack_entries, skipnr;
> > +     char *bug_type =3D NULL;
> > +     unsigned long flags, ua_flags;
> > +     bool is_uaf;
> > +
> > +     if (!kmsan_enabled)
> > +             return;
> > +     if (!current->kmsan_ctx.allow_reporting)
> > +             return;
> > +     if (!origin)
> > +             return;
> > +
> > +     current->kmsan_ctx.allow_reporting =3D false;
> > +     ua_flags =3D user_access_save();
> > +     spin_lock_irqsave(&kmsan_report_lock, flags);
>
> I think this might want to be a raw_spin_lock, since the reporting can
> be called from any context, including from within other raw_spin_lock'd
> critical sections (practically this will only matter in RT kernels).
(Marco elaborated off-list that lockdep will complain if a spin_lock
critical section is nested inside raw_spin_lock)
Thanks, done.

> Also, do you have to do lockdep_off/on() (like kernel/kcsan/report.c
> does, see comment there)?

I don't see lockdep reports from within mm/kmsan/report.c
However there's one boot-time report that I am struggling to comprehend:

DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5481 check_flags+0x63/0x=
180
...
 <TASK>
 lock_acquire+0x85/0x1c0 kernel/locking/lockdep.c:5638
 __raw_spin_lock_irqsave ./include/linux/spinlock_api_smp.h:110
 _raw_spin_lock_irqsave+0x129/0x220 kernel/locking/spinlock.c:162
 __stack_depot_save+0x1b1/0x4b0 lib/stackdepot.c:417
 stack_depot_save+0x13/0x20 lib/stackdepot.c:471
 __msan_poison_alloca+0x100/0x1a0 mm/kmsan/instrumentation.c:228
 _raw_spin_unlock_irqrestore ??:?
 arch_local_save_flags ./arch/x86/include/asm/irqflags.h:70
 arch_irqs_disabled ./arch/x86/include/asm/irqflags.h:130
 __raw_spin_unlock_irqrestore ./include/linux/spinlock_api_smp.h:151
 _raw_spin_unlock_irqrestore+0xc6/0x190 kernel/locking/spinlock.c:194
 tty_register_ldisc+0x15e/0x1c0 drivers/tty/tty_ldisc.c:68
 n_tty_init+0x2f/0x32 drivers/tty/n_tty.c:2418
 console_init+0x20/0x10d kernel/printk/printk.c:3220
 start_kernel+0x6f0/0xd23 init/main.c:1071
 x86_64_start_reservations+0x2a/0x2c arch/x86/kernel/head64.c:546
 x86_64_start_kernel+0xf5/0xfa arch/x86/kernel/head64.c:527
 secondary_startup_64_no_verify+0xc4/0xcb ??:?
 </TASK>

Perhaps we need to disable lockdep in stackdepot as well?

> > + */
> > +static int kmsan_phys_addr_valid(unsigned long addr)
>
> int -> bool ? (it already deviates from the original by using IS_ENABLED
> instead of #ifdef)

Makes sense.

> > + * Taken from arch/x86/mm/physaddr.c to avoid using an instrumented ve=
rsion.
> > + */
> > +static bool kmsan_virt_addr_valid(void *addr)
> > +{
> > +     unsigned long x =3D (unsigned long)addr;
> > +     unsigned long y =3D x - __START_KERNEL_map;
> > +
> > +     /* use the carry flag to determine if x was < __START_KERNEL_map =
*/
> > +     if (unlikely(x > y)) {
> > +             x =3D y + phys_base;
> > +
> > +             if (y >=3D KERNEL_IMAGE_SIZE)
> > +                     return false;
> > +     } else {
> > +             x =3D y + (__START_KERNEL_map - PAGE_OFFSET);
> > +
> > +             /* carry flag will be set if starting x was >=3D PAGE_OFF=
SET */
> > +             if ((x > y) || !kmsan_phys_addr_valid(x))
> > +                     return false;
> > +     }
> > +
> > +     return pfn_valid(x >> PAGE_SHIFT);
> > +}
>
> These seem quite x86-specific - to ease eventual porting to other
> architectures, it would make sense to introduce <asm/kmsan.h> which will
> have these 2 functions (and if there's anything else arch-specific like
> this, moving to <asm/kmsan.h> would help eventual ports).

Good idea, will do!
This part will probably need to go into "x86: kmsan: enable KMSAN
builds for x86"


> > +     if (is_origin && !IS_ALIGNED(addr, KMSAN_ORIGIN_SIZE)) {
> > +             pad =3D addr % KMSAN_ORIGIN_SIZE;
> > +             addr -=3D pad;
> > +     }
> > +     address =3D (void *)addr;
> > +     if (kmsan_internal_is_vmalloc_addr(address) ||
> > +         kmsan_internal_is_module_addr(address))
> > +             return (void *)vmalloc_meta(address, is_origin);
> > +
> > +     page =3D virt_to_page_or_null(address);
> > +     if (!page)
> > +             return NULL;
> > +     if (!page_has_metadata(page))
> > +             return NULL;
> > +     off =3D addr % PAGE_SIZE;
> > +
> > +     ret =3D (is_origin ? origin_ptr_for(page) : shadow_ptr_for(page))=
 + off;
>
> Just return this and avoid 'ret'?
Good catch. There was some debugging code in the middle, but now we
don't need ret.

>
> > +     return ret;
> > +}
> > diff --git a/scripts/Makefile.kmsan b/scripts/Makefile.kmsan
> > new file mode 100644
> > index 0000000000000..9793591f9855c
> > --- /dev/null
> > +++ b/scripts/Makefile.kmsan
> > @@ -0,0 +1 @@
>
> Makefile.kmsan needs SPDX-License-Identifier.
Done.





--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherweise
erhalten haben sollten, leiten Sie diese bitte nicht an jemand anderes
weiter, l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen Sie =
mich
bitte wissen, dass die E-Mail an die falsche Person gesendet wurde.


This e-mail is confidential. If you received this communication by
mistake, please don't forward it to anyone else, please erase all
copies and attachments, and please let me know that it has gone to the
wrong person.
