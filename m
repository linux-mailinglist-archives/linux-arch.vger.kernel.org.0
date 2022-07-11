Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17A157088B
	for <lists+linux-arch@lfdr.de>; Mon, 11 Jul 2022 18:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiGKQuW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Jul 2022 12:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiGKQuW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jul 2022 12:50:22 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB0E32BA0
        for <linux-arch@vger.kernel.org>; Mon, 11 Jul 2022 09:50:19 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-31c89111f23so55707507b3.0
        for <linux-arch@vger.kernel.org>; Mon, 11 Jul 2022 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m736QbvuW1TAkCAGJYZ6QP23qiPikZXAhNz97EPWCnA=;
        b=fNwvIw0Y4vT9l4lfxZhl821T0VMScIgkn+Eu6UGBMesjGzbBo2YrZmzcvHS3475l00
         J7dwrApc25c3SyMrFeckVnsinVaqxVSUX4GDZvDO10hHgBTiwFT3sgov5xQJBNaz6HSH
         twezozjpwvwh4W0tQ1ga5icjyEkcGX1yqIaX4WlMs3RFHzvwZ7Dd3VyMHqjSYFMiesH5
         rJfmN7a4niO4xzyPSLCchOEWdMem9pjeJ4pet3cSQSzOi7S/FKq1Ntc+xuxfBSQT67HR
         X+W/7D0cGJ92I5qbF7uvme+gDBcvAmh9OxZorik/JAzisYKp08YeFTAt+A09ksk6SvPy
         nVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m736QbvuW1TAkCAGJYZ6QP23qiPikZXAhNz97EPWCnA=;
        b=V/dWZ6I2X/0mxNzazOvjnOBgtK8rU1jvePA23s7plOzE+TuwKS1bCBQPXIoG2nJ0V3
         lWah5/2Tg5+Lkche4ImNHtfRiimy1O/mC5GBbuiN+SZCQcvN5KUp98blx9XL+O2d4zg4
         2ZIxEchCEK2XG45EaBx2Bts7qitPJZ09Ne5ebloepBS8j1vKzPLOj8CiwqxHQUpDQpn6
         efSAzip47f38DLJf+PmJl6cgZHSGNtXoipNTmCbugMQVnZ1PHN/WK7qJ9MJNWFpWS0i2
         phIVCZfl5hkFPQ9RoiHHjr/lj/6rx/dJEyCfP2Og7J3ROR6OMqDhXcMH+0OUUYobgYVl
         ns5Q==
X-Gm-Message-State: AJIora9797pfOGSvIxAb3R8Ol+iwOiG/tqPqxLZNn6h8gRwjZOPHWite
        JGE+PRTMvDm22UYCor92p4qMX4XyYEWszZLOIK0UmQ==
X-Google-Smtp-Source: AGRyM1vGcBOAHMPicj1DHxjO44MTKlHcL8CGKX7zeP8jVESsBfV2M1mKLUdqCttvN5o8EeV4YVQ7MU+IjLZuiIlcKMI=
X-Received: by 2002:a0d:cf07:0:b0:31d:17cb:ec11 with SMTP id
 r7-20020a0dcf07000000b0031d17cbec11mr20826537ywd.264.1657558217787; Mon, 11
 Jul 2022 09:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-12-glider@google.com>
In-Reply-To: <20220701142310.2188015-12-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 11 Jul 2022 18:49:41 +0200
Message-ID: <CANpmjNMrEdNdsz6rxkrpiJNREB+GSkx4B=LwPLWYmwVhdjVA4g@mail.gmail.com>
Subject: Re: [PATCH v4 11/45] kmsan: add KMSAN runtime core
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

On Fri, 1 Jul 2022 at 16:23, 'Alexander Potapenko' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> For each memory location KernelMemorySanitizer maintains two types of
> metadata:
> 1. The so-called shadow of that location - =D0=B0 byte:byte mapping descr=
ibing
>    whether or not individual bits of memory are initialized (shadow is 0)
>    or not (shadow is 1).
> 2. The origins of that location - =D0=B0 4-byte:4-byte mapping containing
>    4-byte IDs of the stack traces where uninitialized values were
>    created.
>
> Each struct page now contains pointers to two struct pages holding
> KMSAN metadata (shadow and origins) for the original struct page.
> Utility routines in mm/kmsan/core.c and mm/kmsan/shadow.c handle the
> metadata creation, addressing, copying and checking.
> mm/kmsan/report.c performs error reporting in the cases an uninitialized
> value is used in a way that leads to undefined behavior.
>
> KMSAN compiler instrumentation is responsible for tracking the metadata
> along with the kernel memory. mm/kmsan/instrumentation.c provides the
> implementation for instrumentation hooks that are called from files
> compiled with -fsanitize=3Dkernel-memory.
>
> To aid parameter passing (also done at instrumentation level), each
> task_struct now contains a struct kmsan_task_state used to track the
> metadata of function parameters and return values for that task.
>
> Finally, this patch provides CONFIG_KMSAN that enables KMSAN, and
> declares CFLAGS_KMSAN, which are applied to files compiled with KMSAN.
> The KMSAN_SANITIZE:=3Dn Makefile directive can be used to completely
> disable KMSAN instrumentation for certain files.
>
> Similarly, KMSAN_ENABLE_CHECKS:=3Dn disables KMSAN checks and makes newly
> created stack memory initialized.
>
> Users can also use functions from include/linux/kmsan-checks.h to mark
> certain memory regions as uninitialized or initialized (this is called
> "poisoning" and "unpoisoning") or check that a particular region is
> initialized.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Acked-by: Marco Elver <elver@google.com>

Overall looks clean and well organized now.

> ---
> v2:
>  -- as requested by Greg K-H, moved hooks for different subsystems to res=
pective patches,
>     rewrote the patch description;
>  -- addressed comments by Dmitry Vyukov;
>  -- added a note about KMSAN being not intended for production use.
>  -- fix case of unaligned dst in kmsan_internal_memmove_metadata()
>
> v3:
>  -- print build IDs in reports where applicable
>  -- drop redundant filter_irq_stacks(), unpoison the local passed to __st=
ack_depot_save()
>  -- remove a stray BUG()
>
> v4: (mostly fixes suggested by Marco Elver)
>  -- add missing SPDX headers
>  -- move CC_IS_CLANG && CLANG_VERSION under HAVE_KMSAN_COMPILER
>  -- replace occurrences of |var| with @var
>  -- reflow KMSAN_WARN_ON(), fix code comments
>  -- remove x86-specific code from shadow.c to improve portability
>  -- convert kmsan_report_lock to raw spinlock
>  -- add enter_runtime/exit_runtime around kmsan_internal_memmove_metadata=
()
>  -- remove unnecessary include from kmsan.h (reported by <lkp@intel.com>)
>  -- introduce CONFIG_KMSAN_CHECK_PARAM_RETVAL (on by default), which
>     maps to -fsanitize-memory-param-retval and makes KMSAN eagerly check
>     values passed as function parameters and returned from functions.
>  -- use real shadow in instrumented functions called from runtime
>
> Link: https://linux-review.googlesource.com/id/I9b71bfe3425466c97159f9de0=
062e5e8e4fec866
> ---
>  Makefile                     |   1 +
>  include/linux/kmsan-checks.h |  64 +++++
>  include/linux/kmsan.h        |  46 ++++
>  include/linux/mm_types.h     |  12 +
>  include/linux/sched.h        |   5 +
>  lib/Kconfig.debug            |   1 +
>  lib/Kconfig.kmsan            |  50 ++++
>  mm/Makefile                  |   1 +
>  mm/kmsan/Makefile            |  23 ++
>  mm/kmsan/core.c              | 458 +++++++++++++++++++++++++++++++++++
>  mm/kmsan/hooks.c             |  66 +++++
>  mm/kmsan/instrumentation.c   | 271 +++++++++++++++++++++
>  mm/kmsan/kmsan.h             | 190 +++++++++++++++
>  mm/kmsan/report.c            | 211 ++++++++++++++++
>  mm/kmsan/shadow.c            | 147 +++++++++++
>  scripts/Makefile.kmsan       |   8 +
>  scripts/Makefile.lib         |   9 +
>  17 files changed, 1563 insertions(+)
>  create mode 100644 include/linux/kmsan-checks.h
>  create mode 100644 include/linux/kmsan.h
>  create mode 100644 lib/Kconfig.kmsan
>  create mode 100644 mm/kmsan/Makefile
>  create mode 100644 mm/kmsan/core.c
>  create mode 100644 mm/kmsan/hooks.c
>  create mode 100644 mm/kmsan/instrumentation.c
>  create mode 100644 mm/kmsan/kmsan.h
>  create mode 100644 mm/kmsan/report.c
>  create mode 100644 mm/kmsan/shadow.c
>  create mode 100644 scripts/Makefile.kmsan
>
> diff --git a/Makefile b/Makefile
> index 8973b285ce6c7..7c93482f6df3d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1014,6 +1014,7 @@ include-y                 :=3D scripts/Makefile.ext=
rawarn
>  include-$(CONFIG_DEBUG_INFO)   +=3D scripts/Makefile.debug
>  include-$(CONFIG_KASAN)                +=3D scripts/Makefile.kasan
>  include-$(CONFIG_KCSAN)                +=3D scripts/Makefile.kcsan
> +include-$(CONFIG_KMSAN)                +=3D scripts/Makefile.kmsan
>  include-$(CONFIG_UBSAN)                +=3D scripts/Makefile.ubsan
>  include-$(CONFIG_KCOV)         +=3D scripts/Makefile.kcov
>  include-$(CONFIG_RANDSTRUCT)   +=3D scripts/Makefile.randstruct
> diff --git a/include/linux/kmsan-checks.h b/include/linux/kmsan-checks.h
> new file mode 100644
> index 0000000000000..a6522a0c28df9
> --- /dev/null
> +++ b/include/linux/kmsan-checks.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * KMSAN checks to be used for one-off annotations in subsystems.
> + *
> + * Copyright (C) 2017-2022 Google LLC
> + * Author: Alexander Potapenko <glider@google.com>
> + *
> + */
> +
> +#ifndef _LINUX_KMSAN_CHECKS_H
> +#define _LINUX_KMSAN_CHECKS_H
> +
> +#include <linux/types.h>
> +
> +#ifdef CONFIG_KMSAN
> +
> +/**
> + * kmsan_poison_memory() - Mark the memory range as uninitialized.
> + * @address: address to start with.
> + * @size:    size of buffer to poison.
> + * @flags:   GFP flags for allocations done by this function.
> + *
> + * Until other data is written to this range, KMSAN will treat it as
> + * uninitialized. Error reports for this memory will reference the call =
site of
> + * kmsan_poison_memory() as origin.
> + */
> +void kmsan_poison_memory(const void *address, size_t size, gfp_t flags);
> +
> +/**
> + * kmsan_unpoison_memory() -  Mark the memory range as initialized.
> + * @address: address to start with.
> + * @size:    size of buffer to unpoison.
> + *
> + * Until other data is written to this range, KMSAN will treat it as
> + * initialized.
> + */
> +void kmsan_unpoison_memory(const void *address, size_t size);
> +
> +/**
> + * kmsan_check_memory() - Check the memory range for being initialized.
> + * @address: address to start with.
> + * @size:    size of buffer to check.
> + *
> + * If any piece of the given range is marked as uninitialized, KMSAN wil=
l report
> + * an error.
> + */
> +void kmsan_check_memory(const void *address, size_t size);
> +
> +#else
> +
> +static inline void kmsan_poison_memory(const void *address, size_t size,
> +                                      gfp_t flags)
> +{
> +}
> +static inline void kmsan_unpoison_memory(const void *address, size_t siz=
e)
> +{
> +}
> +static inline void kmsan_check_memory(const void *address, size_t size)
> +{
> +}
> +
> +#endif
> +
> +#endif /* _LINUX_KMSAN_CHECKS_H */
> diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
> new file mode 100644
> index 0000000000000..99e48c6b049d9
> --- /dev/null
> +++ b/include/linux/kmsan.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * KMSAN API for subsystems.
> + *
> + * Copyright (C) 2017-2022 Google LLC
> + * Author: Alexander Potapenko <glider@google.com>
> + *
> + */
> +#ifndef _LINUX_KMSAN_H
> +#define _LINUX_KMSAN_H
> +
> +#include <linux/gfp.h>
> +#include <linux/kmsan-checks.h>
> +#include <linux/stackdepot.h>
> +#include <linux/types.h>
> +
> +struct page;

Either I'm not looking hard enough, but I can't see where this is used
in this file.

> +#ifdef CONFIG_KMSAN
> +
> +/* These constants are defined in the MSan LLVM instrumentation pass. */
> +#define KMSAN_RETVAL_SIZE 800
> +#define KMSAN_PARAM_SIZE 800
> +
> +struct kmsan_context_state {
> +       char param_tls[KMSAN_PARAM_SIZE];
> +       char retval_tls[KMSAN_RETVAL_SIZE];
> +       char va_arg_tls[KMSAN_PARAM_SIZE];
> +       char va_arg_origin_tls[KMSAN_PARAM_SIZE];
> +       u64 va_arg_overflow_size_tls;
> +       char param_origin_tls[KMSAN_PARAM_SIZE];
> +       depot_stack_handle_t retval_origin_tls;
> +};
> +
> +#undef KMSAN_PARAM_SIZE
> +#undef KMSAN_RETVAL_SIZE
> +
> +struct kmsan_ctx {
> +       struct kmsan_context_state cstate;
> +       int kmsan_in_runtime;
> +       bool allow_reporting;
> +};
> +
> +#endif
> +
> +#endif /* _LINUX_KMSAN_H */
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index c29ab4c0cd5c6..3cc0ebdd9625f 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -218,6 +218,18 @@ struct page {
>                                            not kmapped, ie. highmem) */
>  #endif /* WANT_PAGE_VIRTUAL */
>
> +#ifdef CONFIG_KMSAN
> +       /*
> +        * KMSAN metadata for this page:
> +        *  - shadow page: every bit indicates whether the corresponding
> +        *    bit of the original page is initialized (0) or not (1);
> +        *  - origin page: every 4 bytes contain an id of the stack trace
> +        *    where the uninitialized value was created.
> +        */
> +       struct page *kmsan_shadow;
> +       struct page *kmsan_origin;
> +#endif
> +
>  #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
>         int _last_cpupid;
>  #endif
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index c46f3a63b758f..f9bb2c954e794 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -14,6 +14,7 @@
>  #include <linux/pid.h>
>  #include <linux/sem.h>
>  #include <linux/shm.h>
> +#include <linux/kmsan.h>
>  #include <linux/mutex.h>
>  #include <linux/plist.h>
>  #include <linux/hrtimer.h>
> @@ -1353,6 +1354,10 @@ struct task_struct {
>  #endif
>  #endif
>
> +#ifdef CONFIG_KMSAN
> +       struct kmsan_ctx                kmsan_ctx;
> +#endif
> +
>  #if IS_ENABLED(CONFIG_KUNIT)
>         struct kunit                    *kunit_test;
>  #endif
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2e24db4bff192..59819e6fa5865 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -963,6 +963,7 @@ config DEBUG_STACKOVERFLOW
>
>  source "lib/Kconfig.kasan"
>  source "lib/Kconfig.kfence"
> +source "lib/Kconfig.kmsan"
>
>  endmenu # "Memory Debugging"
>
> diff --git a/lib/Kconfig.kmsan b/lib/Kconfig.kmsan
> new file mode 100644
> index 0000000000000..8f768d4034e3c
> --- /dev/null
> +++ b/lib/Kconfig.kmsan
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config HAVE_ARCH_KMSAN
> +       bool
> +
> +config HAVE_KMSAN_COMPILER
> +       # Clang versions <14.0.0 also support -fsanitize=3Dkernel-memory,=
 but not
> +       # all the features necessary to build the kernel with KMSAN.
> +       depends on CC_IS_CLANG && CLANG_VERSION >=3D 140000
> +       def_bool $(cc-option,-fsanitize=3Dkernel-memory -mllvm -msan-disa=
ble-checks=3D1)
> +
> +config HAVE_KMSAN_PARAM_RETVAL
> +       # Separate check for -fsanitize-memory-param-retval support.
> +       depends on CC_IS_CLANG && CLANG_VERSION >=3D 140000
> +       def_bool $(cc-option,-fsanitize=3Dkernel-memory -fsanitize-memory=
-param-retval)
> +
> +
> +config KMSAN
> +       bool "KMSAN: detector of uninitialized values use"
> +       depends on HAVE_ARCH_KMSAN && HAVE_KMSAN_COMPILER
> +       depends on SLUB && DEBUG_KERNEL && !KASAN && !KCSAN
> +       select STACKDEPOT
> +       select STACKDEPOT_ALWAYS_INIT
> +       help
> +         KernelMemorySanitizer (KMSAN) is a dynamic detector of uses of
> +         uninitialized values in the kernel. It is based on compiler
> +         instrumentation provided by Clang and thus requires Clang to bu=
ild.
> +
> +         An important note is that KMSAN is not intended for production =
use,
> +         because it drastically increases kernel memory footprint and sl=
ows
> +         the whole system down.
> +
> +         See <file:Documentation/dev-tools/kmsan.rst> for more details.
> +
> +if KMSAN
> +
> +config KMSAN_CHECK_PARAM_RETVAL
> +       bool "Check for uninitialized values passed to and returned from =
functions"
> +       default HAVE_KMSAN_PARAM_RETVAL
> +       help
> +         If the compiler supports -fsanitize-memory-param-retval, KMSAN =
will
> +         eagerly check every function parameter passed by value and ever=
y
> +         function return value.
> +
> +         Disabling KMSAN_CHECK_PARAM_RETVAL will result in tracking shad=
ow for
> +         function parameters and return values across function borders. =
This
> +         is a more relaxed mode, but it generates more instrumentation c=
ode and
> +         may potentially report errors in corner cases when non-instrume=
nted
> +         functions call instrumented ones.
> +
> +endif
> diff --git a/mm/Makefile b/mm/Makefile
> index 6f9ffa968a1a1..ff96830153221 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -89,6 +89,7 @@ obj-$(CONFIG_SLAB) +=3D slab.o
>  obj-$(CONFIG_SLUB) +=3D slub.o
>  obj-$(CONFIG_KASAN)    +=3D kasan/
>  obj-$(CONFIG_KFENCE) +=3D kfence/
> +obj-$(CONFIG_KMSAN)    +=3D kmsan/
>  obj-$(CONFIG_FAILSLAB) +=3D failslab.o
>  obj-$(CONFIG_MEMTEST)          +=3D memtest.o
>  obj-$(CONFIG_MIGRATION) +=3D migrate.o
> diff --git a/mm/kmsan/Makefile b/mm/kmsan/Makefile
> new file mode 100644
> index 0000000000000..550ad8625e4f9
> --- /dev/null
> +++ b/mm/kmsan/Makefile
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for KernelMemorySanitizer (KMSAN).
> +#
> +#
> +obj-y :=3D core.o instrumentation.o hooks.o report.o shadow.o
> +
> +KMSAN_SANITIZE :=3D n
> +KCOV_INSTRUMENT :=3D n
> +UBSAN_SANITIZE :=3D n
> +
> +# Disable instrumentation of KMSAN runtime with other tools.
> +CC_FLAGS_KMSAN_RUNTIME :=3D -fno-stack-protector
> +CC_FLAGS_KMSAN_RUNTIME +=3D $(call cc-option,-fno-conserve-stack)
> +CC_FLAGS_KMSAN_RUNTIME +=3D -DDISABLE_BRANCH_PROFILING
> +
> +CFLAGS_REMOVE.o =3D $(CC_FLAGS_FTRACE)
> +
> +CFLAGS_core.o :=3D $(CC_FLAGS_KMSAN_RUNTIME)
> +CFLAGS_hooks.o :=3D $(CC_FLAGS_KMSAN_RUNTIME)
> +CFLAGS_instrumentation.o :=3D $(CC_FLAGS_KMSAN_RUNTIME)
> +CFLAGS_report.o :=3D $(CC_FLAGS_KMSAN_RUNTIME)
> +CFLAGS_shadow.o :=3D $(CC_FLAGS_KMSAN_RUNTIME)
> diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
> new file mode 100644
> index 0000000000000..16fb8880a9c6d
> --- /dev/null
> +++ b/mm/kmsan/core.c
> @@ -0,0 +1,458 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KMSAN runtime library.
> + *
> + * Copyright (C) 2017-2022 Google LLC
> + * Author: Alexander Potapenko <glider@google.com>
> + *
> + */
> +
> +#include <asm/page.h>
> +#include <linux/compiler.h>
> +#include <linux/export.h>
> +#include <linux/highmem.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/kmsan.h>
> +#include <linux/memory.h>
> +#include <linux/mm.h>
> +#include <linux/mm_types.h>
> +#include <linux/mmzone.h>
> +#include <linux/percpu-defs.h>
> +#include <linux/preempt.h>
> +#include <linux/slab.h>
> +#include <linux/stackdepot.h>
> +#include <linux/stacktrace.h>
> +#include <linux/types.h>
> +#include <linux/vmalloc.h>
> +
> +#include "../slab.h"
> +#include "kmsan.h"
> +
> +/*
> + * Avoid creating too long origin chains, these are unlikely to particip=
ate in
> + * real reports.
> + */
> +#define MAX_CHAIN_DEPTH 7
> +#define NUM_SKIPPED_TO_WARN 10000
> +
> +bool kmsan_enabled __read_mostly;
> +
> +/*
> + * Per-CPU KMSAN context to be used in interrupts, where current->kmsan =
is
> + * unavaliable.
> + */
> +DEFINE_PER_CPU(struct kmsan_ctx, kmsan_percpu_ctx);
> +
> +void kmsan_internal_poison_memory(void *address, size_t size, gfp_t flag=
s,
> +                                 unsigned int poison_flags)
> +{
> +       u32 extra_bits =3D
> +               kmsan_extra_bits(/*depth*/ 0, poison_flags & KMSAN_POISON=
_FREE);
> +       bool checked =3D poison_flags & KMSAN_POISON_CHECK;
> +       depot_stack_handle_t handle;
> +
> +       handle =3D kmsan_save_stack_with_flags(flags, extra_bits);
> +       kmsan_internal_set_shadow_origin(address, size, -1, handle, check=
ed);
> +}
> +
> +void kmsan_internal_unpoison_memory(void *address, size_t size, bool che=
cked)
> +{
> +       kmsan_internal_set_shadow_origin(address, size, 0, 0, checked);
> +}
> +
> +depot_stack_handle_t kmsan_save_stack_with_flags(gfp_t flags,
> +                                                unsigned int extra)
> +{
> +       unsigned long entries[KMSAN_STACK_DEPTH];
> +       unsigned int nr_entries;
> +
> +       nr_entries =3D stack_trace_save(entries, KMSAN_STACK_DEPTH, 0);
> +
> +       /* Don't sleep (see might_sleep_if() in __alloc_pages_nodemask())=
. */
> +       flags &=3D ~__GFP_DIRECT_RECLAIM;
> +
> +       return __stack_depot_save(entries, nr_entries, extra, flags, true=
);
> +}
> +
> +/* Copy the metadata following the memmove() behavior. */
> +void kmsan_internal_memmove_metadata(void *dst, void *src, size_t n)
> +{
> +       depot_stack_handle_t old_origin =3D 0, new_origin =3D 0;
> +       int src_slots, dst_slots, i, iter, step, skip_bits;
> +       depot_stack_handle_t *origin_src, *origin_dst;
> +       void *shadow_src, *shadow_dst;
> +       u32 *align_shadow_src, shadow;
> +       bool backwards;
> +
> +       shadow_dst =3D kmsan_get_metadata(dst, KMSAN_META_SHADOW);
> +       if (!shadow_dst)
> +               return;
> +       KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(dst, n));
> +
> +       shadow_src =3D kmsan_get_metadata(src, KMSAN_META_SHADOW);
> +       if (!shadow_src) {
> +               /*
> +                * @src is untracked: zero out destination shadow, ignore=
 the
> +                * origins, we're done.
> +                */
> +               __memset(shadow_dst, 0, n);
> +               return;
> +       }
> +       KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(src, n));
> +
> +       __memmove(shadow_dst, shadow_src, n);
> +
> +       origin_dst =3D kmsan_get_metadata(dst, KMSAN_META_ORIGIN);
> +       origin_src =3D kmsan_get_metadata(src, KMSAN_META_ORIGIN);
> +       KMSAN_WARN_ON(!origin_dst || !origin_src);
> +       src_slots =3D (ALIGN((u64)src + n, KMSAN_ORIGIN_SIZE) -
> +                    ALIGN_DOWN((u64)src, KMSAN_ORIGIN_SIZE)) /
> +                   KMSAN_ORIGIN_SIZE;
> +       dst_slots =3D (ALIGN((u64)dst + n, KMSAN_ORIGIN_SIZE) -
> +                    ALIGN_DOWN((u64)dst, KMSAN_ORIGIN_SIZE)) /
> +                   KMSAN_ORIGIN_SIZE;
> +       KMSAN_WARN_ON((src_slots < 1) || (dst_slots < 1));
> +       KMSAN_WARN_ON((src_slots - dst_slots > 1) ||
> +                     (dst_slots - src_slots < -1));
> +
> +       backwards =3D dst > src;
> +       i =3D backwards ? min(src_slots, dst_slots) - 1 : 0;
> +       iter =3D backwards ? -1 : 1;
> +
> +       align_shadow_src =3D
> +               (u32 *)ALIGN_DOWN((u64)shadow_src, KMSAN_ORIGIN_SIZE);
> +       for (step =3D 0; step < min(src_slots, dst_slots); step++, i +=3D=
 iter) {
> +               KMSAN_WARN_ON(i < 0);
> +               shadow =3D align_shadow_src[i];
> +               if (i =3D=3D 0) {
> +                       /*
> +                        * If @src isn't aligned on KMSAN_ORIGIN_SIZE, do=
n't
> +                        * look at the first @src % KMSAN_ORIGIN_SIZE byt=
es
> +                        * of the first shadow slot.
> +                        */
> +                       skip_bits =3D ((u64)src % KMSAN_ORIGIN_SIZE) * 8;
> +                       shadow =3D (shadow >> skip_bits) << skip_bits;
> +               }
> +               if (i =3D=3D src_slots - 1) {
> +                       /*
> +                        * If @src + n isn't aligned on
> +                        * KMSAN_ORIGIN_SIZE, don't look at the last
> +                        * (@src + n) % KMSAN_ORIGIN_SIZE bytes of the
> +                        * last shadow slot.
> +                        */
> +                       skip_bits =3D (((u64)src + n) % KMSAN_ORIGIN_SIZE=
) * 8;
> +                       shadow =3D (shadow << skip_bits) >> skip_bits;
> +               }
> +               /*
> +                * Overwrite the origin only if the corresponding
> +                * shadow is nonempty.
> +                */
> +               if (origin_src[i] && (origin_src[i] !=3D old_origin) && s=
hadow) {
> +                       old_origin =3D origin_src[i];
> +                       new_origin =3D kmsan_internal_chain_origin(old_or=
igin);
> +                       /*
> +                        * kmsan_internal_chain_origin() may return
> +                        * NULL, but we don't want to lose the previous
> +                        * origin value.
> +                        */
> +                       if (!new_origin)
> +                               new_origin =3D old_origin;
> +               }
> +               if (shadow)
> +                       origin_dst[i] =3D new_origin;
> +               else
> +                       origin_dst[i] =3D 0;
> +       }
> +       /*
> +        * If dst_slots is greater than src_slots (i.e.
> +        * dst_slots =3D=3D src_slots + 1), there is an extra origin slot=
 at the
> +        * beginning or end of the destination buffer, for which we take =
the
> +        * origin from the previous slot.
> +        * This is only done if the part of the source shadow correspondi=
ng to
> +        * slot is non-zero.
> +        *
> +        * E.g. if we copy 8 aligned bytes that are marked as uninitializ=
ed
> +        * and have origins o111 and o222, to an unaligned buffer with of=
fset 1,
> +        * these two origins are copied to three origin slots, so one of =
then
> +        * needs to be duplicated, depending on the copy direction (@back=
wards)
> +        *
> +        *   src shadow: |uuuu|uuuu|....|
> +        *   src origin: |o111|o222|....|
> +        *
> +        * backwards =3D 0:
> +        *   dst shadow: |.uuu|uuuu|u...|
> +        *   dst origin: |....|o111|o222| - fill the empty slot with o111
> +        * backwards =3D 1:
> +        *   dst shadow: |.uuu|uuuu|u...|
> +        *   dst origin: |o111|o222|....| - fill the empty slot with o222
> +        */
> +       if (src_slots < dst_slots) {
> +               if (backwards) {
> +                       shadow =3D align_shadow_src[src_slots - 1];
> +                       skip_bits =3D (((u64)dst + n) % KMSAN_ORIGIN_SIZE=
) * 8;
> +                       shadow =3D (shadow << skip_bits) >> skip_bits;
> +                       if (shadow)
> +                               /* src_slots > 0, therefore dst_slots is =
at least 2 */
> +                               origin_dst[dst_slots - 1] =3D origin_dst[=
dst_slots - 2];
> +               } else {
> +                       shadow =3D align_shadow_src[0];
> +                       skip_bits =3D ((u64)dst % KMSAN_ORIGIN_SIZE) * 8;
> +                       shadow =3D (shadow >> skip_bits) << skip_bits;
> +                       if (shadow)
> +                               origin_dst[0] =3D origin_dst[1];
> +               }
> +       }
> +}
> +
> +depot_stack_handle_t kmsan_internal_chain_origin(depot_stack_handle_t id=
)
> +{
> +       unsigned long entries[3];
> +       u32 extra_bits;
> +       int depth;
> +       bool uaf;
> +
> +       if (!id)
> +               return id;
> +       /*
> +        * Make sure we have enough spare bits in @id to hold the UAF bit=
 and
> +        * the chain depth.
> +        */
> +       BUILD_BUG_ON((1 << STACK_DEPOT_EXTRA_BITS) <=3D (MAX_CHAIN_DEPTH =
<< 1));
> +
> +       extra_bits =3D stack_depot_get_extra_bits(id);
> +       depth =3D kmsan_depth_from_eb(extra_bits);
> +       uaf =3D kmsan_uaf_from_eb(extra_bits);
> +
> +       if (depth >=3D MAX_CHAIN_DEPTH) {
> +               static atomic_long_t kmsan_skipped_origins;
> +               long skipped =3D atomic_long_inc_return(&kmsan_skipped_or=
igins);
> +
> +               if (skipped % NUM_SKIPPED_TO_WARN =3D=3D 0) {
> +                       pr_warn("not chained %ld origins\n", skipped);
> +                       dump_stack();
> +                       kmsan_print_origin(id);
> +               }
> +               return id;
> +       }
> +       depth++;
> +       extra_bits =3D kmsan_extra_bits(depth, uaf);
> +
> +       entries[0] =3D KMSAN_CHAIN_MAGIC_ORIGIN;
> +       entries[1] =3D kmsan_save_stack_with_flags(GFP_ATOMIC, 0);
> +       entries[2] =3D id;
> +       /*
> +        * @entries is a local var in non-instrumented code, so KMSAN doe=
s not
> +        * know it is initialized. Explicitly unpoison it to avoid false
> +        * positives when __stack_depot_save() passes it to instrumented =
code.
> +        */
> +       kmsan_internal_unpoison_memory(entries, sizeof(entries), false);
> +       return __stack_depot_save(entries, ARRAY_SIZE(entries), extra_bit=
s,
> +                                 GFP_ATOMIC, true);
> +}
> +
> +void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
> +                                     u32 origin, bool checked)
> +{
> +       u64 address =3D (u64)addr;
> +       void *shadow_start;
> +       u32 *origin_start;
> +       size_t pad =3D 0;
> +       int i;
> +
> +       KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(addr, size));
> +       shadow_start =3D kmsan_get_metadata(addr, KMSAN_META_SHADOW);
> +       if (!shadow_start) {
> +               /*
> +                * kmsan_metadata_is_contiguous() is true, so either all =
shadow
> +                * and origin pages are NULL, or all are non-NULL.
> +                */
> +               if (checked) {
> +                       pr_err("%s: not memsetting %ld bytes starting at =
%px, because the shadow is NULL\n",
> +                              __func__, size, addr);
> +                       KMSAN_WARN_ON(true);
> +               }
> +               return;
> +       }
> +       __memset(shadow_start, b, size);
> +
> +       if (!IS_ALIGNED(address, KMSAN_ORIGIN_SIZE)) {
> +               pad =3D address % KMSAN_ORIGIN_SIZE;
> +               address -=3D pad;
> +               size +=3D pad;
> +       }
> +       size =3D ALIGN(size, KMSAN_ORIGIN_SIZE);
> +       origin_start =3D
> +               (u32 *)kmsan_get_metadata((void *)address, KMSAN_META_ORI=
GIN);
> +
> +       for (i =3D 0; i < size / KMSAN_ORIGIN_SIZE; i++)
> +               origin_start[i] =3D origin;
> +}
> +
> +struct page *kmsan_vmalloc_to_page_or_null(void *vaddr)
> +{
> +       struct page *page;
> +
> +       if (!kmsan_internal_is_vmalloc_addr(vaddr) &&
> +           !kmsan_internal_is_module_addr(vaddr))
> +               return NULL;
> +       page =3D vmalloc_to_page(vaddr);
> +       if (pfn_valid(page_to_pfn(page)))
> +               return page;
> +       else
> +               return NULL;
> +}
> +
> +void kmsan_internal_check_memory(void *addr, size_t size, const void *us=
er_addr,
> +                                int reason)
> +{
> +       depot_stack_handle_t cur_origin =3D 0, new_origin =3D 0;
> +       unsigned long addr64 =3D (unsigned long)addr;
> +       depot_stack_handle_t *origin =3D NULL;
> +       unsigned char *shadow =3D NULL;
> +       int cur_off_start =3D -1;
> +       int i, chunk_size;
> +       size_t pos =3D 0;
> +
> +       if (!size)
> +               return;
> +       KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(addr, size));
> +       while (pos < size) {
> +               chunk_size =3D min(size - pos,
> +                                PAGE_SIZE - ((addr64 + pos) % PAGE_SIZE)=
);
> +               shadow =3D kmsan_get_metadata((void *)(addr64 + pos),
> +                                           KMSAN_META_SHADOW);
> +               if (!shadow) {
> +                       /*
> +                        * This page is untracked. If there were uninitia=
lized
> +                        * bytes before, report them.
> +                        */
> +                       if (cur_origin) {
> +                               kmsan_enter_runtime();
> +                               kmsan_report(cur_origin, addr, size,
> +                                            cur_off_start, pos - 1, user=
_addr,
> +                                            reason);
> +                               kmsan_leave_runtime();
> +                       }
> +                       cur_origin =3D 0;
> +                       cur_off_start =3D -1;
> +                       pos +=3D chunk_size;
> +                       continue;
> +               }
> +               for (i =3D 0; i < chunk_size; i++) {
> +                       if (!shadow[i]) {
> +                               /*
> +                                * This byte is unpoisoned. If there were
> +                                * poisoned bytes before, report them.
> +                                */
> +                               if (cur_origin) {
> +                                       kmsan_enter_runtime();
> +                                       kmsan_report(cur_origin, addr, si=
ze,
> +                                                    cur_off_start, pos +=
 i - 1,
> +                                                    user_addr, reason);
> +                                       kmsan_leave_runtime();
> +                               }
> +                               cur_origin =3D 0;
> +                               cur_off_start =3D -1;
> +                               continue;
> +                       }
> +                       origin =3D kmsan_get_metadata((void *)(addr64 + p=
os + i),
> +                                                   KMSAN_META_ORIGIN);
> +                       KMSAN_WARN_ON(!origin);
> +                       new_origin =3D *origin;
> +                       /*
> +                        * Encountered new origin - report the previous
> +                        * uninitialized range.
> +                        */
> +                       if (cur_origin !=3D new_origin) {
> +                               if (cur_origin) {
> +                                       kmsan_enter_runtime();
> +                                       kmsan_report(cur_origin, addr, si=
ze,
> +                                                    cur_off_start, pos +=
 i - 1,
> +                                                    user_addr, reason);
> +                                       kmsan_leave_runtime();
> +                               }
> +                               cur_origin =3D new_origin;
> +                               cur_off_start =3D pos + i;
> +                       }
> +               }
> +               pos +=3D chunk_size;
> +       }
> +       KMSAN_WARN_ON(pos !=3D size);
> +       if (cur_origin) {
> +               kmsan_enter_runtime();
> +               kmsan_report(cur_origin, addr, size, cur_off_start, pos -=
 1,
> +                            user_addr, reason);
> +               kmsan_leave_runtime();
> +       }
> +}
> +
> +bool kmsan_metadata_is_contiguous(void *addr, size_t size)
> +{
> +       char *cur_shadow =3D NULL, *next_shadow =3D NULL, *cur_origin =3D=
 NULL,
> +            *next_origin =3D NULL;
> +       u64 cur_addr =3D (u64)addr, next_addr =3D cur_addr + PAGE_SIZE;
> +       depot_stack_handle_t *origin_p;
> +       bool all_untracked =3D false;
> +
> +       if (!size)
> +               return true;
> +
> +       /* The whole range belongs to the same page. */
> +       if (ALIGN_DOWN(cur_addr + size - 1, PAGE_SIZE) =3D=3D
> +           ALIGN_DOWN(cur_addr, PAGE_SIZE))
> +               return true;
> +
> +       cur_shadow =3D kmsan_get_metadata((void *)cur_addr, /*is_origin*/=
 false);
> +       if (!cur_shadow)
> +               all_untracked =3D true;
> +       cur_origin =3D kmsan_get_metadata((void *)cur_addr, /*is_origin*/=
 true);
> +       if (all_untracked && cur_origin)
> +               goto report;
> +
> +       for (; next_addr < (u64)addr + size;
> +            cur_addr =3D next_addr, cur_shadow =3D next_shadow,
> +            cur_origin =3D next_origin, next_addr +=3D PAGE_SIZE) {
> +               next_shadow =3D kmsan_get_metadata((void *)next_addr, fal=
se);
> +               next_origin =3D kmsan_get_metadata((void *)next_addr, tru=
e);
> +               if (all_untracked) {
> +                       if (next_shadow || next_origin)
> +                               goto report;
> +                       if (!next_shadow && !next_origin)
> +                               continue;
> +               }
> +               if (((u64)cur_shadow =3D=3D ((u64)next_shadow - PAGE_SIZE=
)) &&
> +                   ((u64)cur_origin =3D=3D ((u64)next_origin - PAGE_SIZE=
)))
> +                       continue;
> +               goto report;
> +       }
> +       return true;
> +
> +report:
> +       pr_err("%s: attempting to access two shadow page ranges.\n", __fu=
nc__);
> +       pr_err("Access of size %ld at %px.\n", size, addr);
> +       pr_err("Addresses belonging to different ranges: %px and %px\n",
> +              (void *)cur_addr, (void *)next_addr);
> +       pr_err("page[0].shadow: %px, page[1].shadow: %px\n", cur_shadow,
> +              next_shadow);
> +       pr_err("page[0].origin: %px, page[1].origin: %px\n", cur_origin,
> +              next_origin);
> +       origin_p =3D kmsan_get_metadata(addr, KMSAN_META_ORIGIN);
> +       if (origin_p) {
> +               pr_err("Origin: %08x\n", *origin_p);
> +               kmsan_print_origin(*origin_p);
> +       } else {
> +               pr_err("Origin: unavailable\n");
> +       }
> +       return false;
> +}
> +
> +bool kmsan_internal_is_module_addr(void *vaddr)
> +{
> +       return ((u64)vaddr >=3D MODULES_VADDR) && ((u64)vaddr < MODULES_E=
ND);
> +}
> +
> +bool kmsan_internal_is_vmalloc_addr(void *addr)
> +{
> +       return ((u64)addr >=3D VMALLOC_START) && ((u64)addr < VMALLOC_END=
);
> +}
> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> new file mode 100644
> index 0000000000000..4ac62fa67a02a
> --- /dev/null
> +++ b/mm/kmsan/hooks.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KMSAN hooks for kernel subsystems.
> + *
> + * These functions handle creation of KMSAN metadata for memory allocati=
ons.
> + *
> + * Copyright (C) 2018-2022 Google LLC
> + * Author: Alexander Potapenko <glider@google.com>
> + *
> + */
> +
> +#include <linux/cacheflush.h>
> +#include <linux/gfp.h>
> +#include <linux/mm.h>
> +#include <linux/mm_types.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +
> +#include "../internal.h"
> +#include "../slab.h"
> +#include "kmsan.h"
> +
> +/*
> + * Instrumented functions shouldn't be called under
> + * kmsan_enter_runtime()/kmsan_leave_runtime(), because this will lead t=
o
> + * skipping effects of functions like memset() inside instrumented code.
> + */
> +
> +/* Functions from kmsan-checks.h follow. */
> +void kmsan_poison_memory(const void *address, size_t size, gfp_t flags)
> +{
> +       if (!kmsan_enabled || kmsan_in_runtime())
> +               return;
> +       kmsan_enter_runtime();
> +       /* The users may want to poison/unpoison random memory. */
> +       kmsan_internal_poison_memory((void *)address, size, flags,
> +                                    KMSAN_POISON_NOCHECK);
> +       kmsan_leave_runtime();
> +}
> +EXPORT_SYMBOL(kmsan_poison_memory);
> +
> +void kmsan_unpoison_memory(const void *address, size_t size)
> +{
> +       unsigned long ua_flags;
> +
> +       if (!kmsan_enabled || kmsan_in_runtime())
> +               return;
> +
> +       ua_flags =3D user_access_save();
> +       kmsan_enter_runtime();
> +       /* The users may want to poison/unpoison random memory. */
> +       kmsan_internal_unpoison_memory((void *)address, size,
> +                                      KMSAN_POISON_NOCHECK);
> +       kmsan_leave_runtime();
> +       user_access_restore(ua_flags);
> +}
> +EXPORT_SYMBOL(kmsan_unpoison_memory);
> +
> +void kmsan_check_memory(const void *addr, size_t size)
> +{
> +       if (!kmsan_enabled)
> +               return;
> +       return kmsan_internal_check_memory((void *)addr, size, /*user_add=
r*/ 0,
> +                                          REASON_ANY);
> +}
> +EXPORT_SYMBOL(kmsan_check_memory);
> diff --git a/mm/kmsan/instrumentation.c b/mm/kmsan/instrumentation.c
> new file mode 100644
> index 0000000000000..1b705162be8c2
> --- /dev/null
> +++ b/mm/kmsan/instrumentation.c
> @@ -0,0 +1,271 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KMSAN compiler API.
> + *
> + * This file implements __msan_XXX hooks that Clang inserts into the cod=
e
> + * compiled with -fsanitize=3Dkernel-memory.
> + * See Documentation/dev-tools/kmsan.rst for more information on how KMS=
AN
> + * instrumentation works.
> + *
> + * Copyright (C) 2017-2022 Google LLC
> + * Author: Alexander Potapenko <glider@google.com>
> + *
> + */
> +
> +#include "kmsan.h"
> +#include <linux/gfp.h>
> +#include <linux/mm.h>
> +#include <linux/uaccess.h>
> +
> +static inline bool is_bad_asm_addr(void *addr, uintptr_t size, bool is_s=
tore)
> +{
> +       if ((u64)addr < TASK_SIZE)
> +               return true;
> +       if (!kmsan_get_metadata(addr, KMSAN_META_SHADOW))
> +               return true;
> +       return false;
> +}
> +
> +static inline struct shadow_origin_ptr
> +get_shadow_origin_ptr(void *addr, u64 size, bool store)
> +{
> +       unsigned long ua_flags =3D user_access_save();
> +       struct shadow_origin_ptr ret;
> +
> +       ret =3D kmsan_get_shadow_origin_ptr(addr, size, store);
> +       user_access_restore(ua_flags);
> +       return ret;
> +}
> +
> +/* Get shadow and origin pointers for a memory load with non-standard si=
ze. */
> +struct shadow_origin_ptr __msan_metadata_ptr_for_load_n(void *addr,
> +                                                       uintptr_t size)
> +{
> +       return get_shadow_origin_ptr(addr, size, /*store*/ false);
> +}
> +EXPORT_SYMBOL(__msan_metadata_ptr_for_load_n);
> +
> +/* Get shadow and origin pointers for a memory store with non-standard s=
ize. */
> +struct shadow_origin_ptr __msan_metadata_ptr_for_store_n(void *addr,
> +                                                        uintptr_t size)
> +{
> +       return get_shadow_origin_ptr(addr, size, /*store*/ true);
> +}
> +EXPORT_SYMBOL(__msan_metadata_ptr_for_store_n);
> +
> +/*
> + * Declare functions that obtain shadow/origin pointers for loads and st=
ores
> + * with fixed size.
> + */
> +#define DECLARE_METADATA_PTR_GETTER(size)                               =
       \
> +       struct shadow_origin_ptr __msan_metadata_ptr_for_load_##size(    =
      \
> +               void *addr)                                              =
      \
> +       {                                                                =
      \
> +               return get_shadow_origin_ptr(addr, size, /*store*/ false)=
;     \
> +       }                                                                =
      \
> +       EXPORT_SYMBOL(__msan_metadata_ptr_for_load_##size);              =
      \
> +       struct shadow_origin_ptr __msan_metadata_ptr_for_store_##size(   =
      \
> +               void *addr)                                              =
      \
> +       {                                                                =
      \
> +               return get_shadow_origin_ptr(addr, size, /*store*/ true);=
      \
> +       }                                                                =
      \
> +       EXPORT_SYMBOL(__msan_metadata_ptr_for_store_##size)
> +
> +DECLARE_METADATA_PTR_GETTER(1);
> +DECLARE_METADATA_PTR_GETTER(2);
> +DECLARE_METADATA_PTR_GETTER(4);
> +DECLARE_METADATA_PTR_GETTER(8);
> +
> +/*
> + * Handle a memory store performed by inline assembly. KMSAN conservativ=
ely
> + * attempts to unpoison the outputs of asm() directives to prevent false
> + * positives caused by missed stores.
> + */
> +void __msan_instrument_asm_store(void *addr, uintptr_t size)
> +{
> +       unsigned long ua_flags;
> +
> +       if (!kmsan_enabled || kmsan_in_runtime())
> +               return;
> +
> +       ua_flags =3D user_access_save();
> +       /*
> +        * Most of the accesses are below 32 bytes. The two exceptions so=
 far
> +        * are clwb() (64 bytes) and FPU state (512 bytes).
> +        * It's unlikely that the assembly will touch more than 512 bytes=
.
> +        */
> +       if (size > 512) {
> +               WARN_ONCE(1, "assembly store size too big: %ld\n", size);
> +               size =3D 8;
> +       }
> +       if (is_bad_asm_addr(addr, size, /*is_store*/ true)) {
> +               user_access_restore(ua_flags);
> +               return;
> +       }
> +       kmsan_enter_runtime();
> +       /* Unpoisoning the memory on best effort. */
> +       kmsan_internal_unpoison_memory(addr, size, /*checked*/ false);
> +       kmsan_leave_runtime();
> +       user_access_restore(ua_flags);
> +}
> +EXPORT_SYMBOL(__msan_instrument_asm_store);
> +
> +/* Handle llvm.memmove intrinsic. */
> +void *__msan_memmove(void *dst, const void *src, uintptr_t n)
> +{
> +       void *result;
> +
> +       result =3D __memmove(dst, src, n);
> +       if (!n)
> +               /* Some people call memmove() with zero length. */
> +               return result;
> +       if (!kmsan_enabled || kmsan_in_runtime())
> +               return result;
> +
> +       kmsan_enter_runtime();
> +       kmsan_internal_memmove_metadata(dst, (void *)src, n);
> +       kmsan_leave_runtime();
> +
> +       return result;
> +}
> +EXPORT_SYMBOL(__msan_memmove);
> +
> +/* Handle llvm.memcpy intrinsic. */
> +void *__msan_memcpy(void *dst, const void *src, uintptr_t n)
> +{
> +       void *result;
> +
> +       result =3D __memcpy(dst, src, n);
> +       if (!n)
> +               /* Some people call memcpy() with zero length. */
> +               return result;
> +
> +       if (!kmsan_enabled || kmsan_in_runtime())
> +               return result;
> +
> +       kmsan_enter_runtime();
> +       /* Using memmove instead of memcpy doesn't affect correctness. */
> +       kmsan_internal_memmove_metadata(dst, (void *)src, n);
> +       kmsan_leave_runtime();
> +
> +       return result;
> +}
> +EXPORT_SYMBOL(__msan_memcpy);
> +
> +/* Handle llvm.memset intrinsic. */
> +void *__msan_memset(void *dst, int c, uintptr_t n)
> +{
> +       void *result;
> +
> +       result =3D __memset(dst, c, n);
> +       if (!kmsan_enabled || kmsan_in_runtime())
> +               return result;
> +
> +       kmsan_enter_runtime();
> +       /*
> +        * Clang doesn't pass parameter metadata here, so it is impossibl=
e to
> +        * use shadow of @c to set up the shadow for @dst.
> +        */
> +       kmsan_internal_unpoison_memory(dst, n, /*checked*/ false);
> +       kmsan_leave_runtime();
> +
> +       return result;
> +}
> +EXPORT_SYMBOL(__msan_memset);
> +
> +/*
> + * Create a new origin from an old one. This is done when storing an
> + * uninitialized value to memory. When reporting an error, KMSAN unrolls=
 and
> + * prints the whole chain of stores that preceded the use of this value.
> + */
> +depot_stack_handle_t __msan_chain_origin(depot_stack_handle_t origin)
> +{
> +       depot_stack_handle_t ret =3D 0;
> +       unsigned long ua_flags;
> +
> +       if (!kmsan_enabled || kmsan_in_runtime())
> +               return ret;
> +
> +       ua_flags =3D user_access_save();
> +
> +       /* Creating new origins may allocate memory. */
> +       kmsan_enter_runtime();
> +       ret =3D kmsan_internal_chain_origin(origin);
> +       kmsan_leave_runtime();
> +       user_access_restore(ua_flags);
> +       return ret;
> +}
> +EXPORT_SYMBOL(__msan_chain_origin);
> +
> +/* Poison a local variable when entering a function. */
> +void __msan_poison_alloca(void *address, uintptr_t size, char *descr)
> +{
> +       depot_stack_handle_t handle;
> +       unsigned long entries[4];
> +       unsigned long ua_flags;
> +
> +       if (!kmsan_enabled || kmsan_in_runtime())
> +               return;
> +
> +       ua_flags =3D user_access_save();
> +       entries[0] =3D KMSAN_ALLOCA_MAGIC_ORIGIN;
> +       entries[1] =3D (u64)descr;
> +       entries[2] =3D (u64)__builtin_return_address(0);
> +       /*
> +        * With frame pointers enabled, it is possible to quickly fetch t=
he
> +        * second frame of the caller stack without calling the unwinder.
> +        * Without them, simply do not bother.
> +        */
> +       if (IS_ENABLED(CONFIG_UNWINDER_FRAME_POINTER))
> +               entries[3] =3D (u64)__builtin_return_address(1);
> +       else
> +               entries[3] =3D 0;
> +
> +       /* stack_depot_save() may allocate memory. */
> +       kmsan_enter_runtime();
> +       handle =3D stack_depot_save(entries, ARRAY_SIZE(entries), GFP_ATO=
MIC);
> +       kmsan_leave_runtime();
> +
> +       kmsan_internal_set_shadow_origin(address, size, -1, handle,
> +                                        /*checked*/ true);
> +       user_access_restore(ua_flags);
> +}
> +EXPORT_SYMBOL(__msan_poison_alloca);
> +
> +/* Unpoison a local variable. */
> +void __msan_unpoison_alloca(void *address, uintptr_t size)
> +{
> +       if (!kmsan_enabled || kmsan_in_runtime())
> +               return;
> +
> +       kmsan_enter_runtime();
> +       kmsan_internal_unpoison_memory(address, size, /*checked*/ true);
> +       kmsan_leave_runtime();
> +}
> +EXPORT_SYMBOL(__msan_unpoison_alloca);
> +
> +/*
> + * Report that an uninitialized value with the given origin was used in =
a way
> + * that constituted undefined behavior.
> + */
> +void __msan_warning(u32 origin)
> +{
> +       if (!kmsan_enabled || kmsan_in_runtime())
> +               return;
> +       kmsan_enter_runtime();
> +       kmsan_report(origin, /*address*/ 0, /*size*/ 0,
> +                    /*off_first*/ 0, /*off_last*/ 0, /*user_addr*/ 0,
> +                    REASON_ANY);
> +       kmsan_leave_runtime();
> +}
> +EXPORT_SYMBOL(__msan_warning);
> +
> +/*
> + * At the beginning of an instrumented function, obtain the pointer to
> + * `struct kmsan_context_state` holding the metadata for function parame=
ters.
> + */
> +struct kmsan_context_state *__msan_get_context_state(void)
> +{
> +       return &kmsan_get_context()->cstate;
> +}
> +EXPORT_SYMBOL(__msan_get_context_state);
> diff --git a/mm/kmsan/kmsan.h b/mm/kmsan/kmsan.h
> new file mode 100644
> index 0000000000000..d3c400ca097ba
> --- /dev/null
> +++ b/mm/kmsan/kmsan.h
> @@ -0,0 +1,190 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Functions used by the KMSAN runtime.
> + *
> + * Copyright (C) 2017-2022 Google LLC
> + * Author: Alexander Potapenko <glider@google.com>
> + *
> + */
> +
> +#ifndef __MM_KMSAN_KMSAN_H
> +#define __MM_KMSAN_KMSAN_H
> +
> +#include <asm/pgtable_64_types.h>
> +#include <linux/irqflags.h>
> +#include <linux/sched.h>
> +#include <linux/stackdepot.h>
> +#include <linux/stacktrace.h>
> +#include <linux/nmi.h>
> +#include <linux/mm.h>
> +#include <linux/printk.h>
> +
> +#define KMSAN_ALLOCA_MAGIC_ORIGIN 0xabcd0100
> +#define KMSAN_CHAIN_MAGIC_ORIGIN 0xabcd0200
> +
> +#define KMSAN_POISON_NOCHECK 0x0
> +#define KMSAN_POISON_CHECK 0x1
> +#define KMSAN_POISON_FREE 0x2
> +
> +#define KMSAN_ORIGIN_SIZE 4
> +
> +#define KMSAN_STACK_DEPTH 64
> +
> +#define KMSAN_META_SHADOW (false)
> +#define KMSAN_META_ORIGIN (true)
> +
> +extern bool kmsan_enabled;
> +extern int panic_on_kmsan;
> +
> +/*
> + * KMSAN performs a lot of consistency checks that are currently enabled=
 by
> + * default. BUG_ON is normally discouraged in the kernel, unless used fo=
r
> + * debugging, but KMSAN itself is a debugging tool, so it makes little s=
ense to
> + * recover if something goes wrong.
> + */
> +#define KMSAN_WARN_ON(cond)                                            \
> +       ({                                                              \
> +               const bool __cond =3D WARN_ON(cond);                     =
 \
> +               if (unlikely(__cond)) {                                 \
> +                       WRITE_ONCE(kmsan_enabled, false);               \
> +                       if (panic_on_kmsan) {                           \
> +                               /* Can't call panic() here because */   \
> +                               /* of uaccess checks. */                \
> +                               BUG();                                  \
> +                       }                                               \
> +               }                                                       \
> +               __cond;                                                 \
> +       })
> +
> +/*
> + * A pair of metadata pointers to be returned by the instrumentation fun=
ctions.
> + */
> +struct shadow_origin_ptr {
> +       void *shadow, *origin;
> +};
> +
> +struct shadow_origin_ptr kmsan_get_shadow_origin_ptr(void *addr, u64 siz=
e,
> +                                                    bool store);
> +void *kmsan_get_metadata(void *addr, bool is_origin);
> +
> +enum kmsan_bug_reason {
> +       REASON_ANY,
> +       REASON_COPY_TO_USER,
> +       REASON_SUBMIT_URB,
> +};
> +
> +void kmsan_print_origin(depot_stack_handle_t origin);
> +
> +/**
> + * kmsan_report() - Report a use of uninitialized value.
> + * @origin:    Stack ID of the uninitialized value.
> + * @address:   Address at which the memory access happens.
> + * @size:      Memory access size.
> + * @off_first: Offset (from @address) of the first byte to be reported.
> + * @off_last:  Offset (from @address) of the last byte to be reported.
> + * @user_addr: When non-NULL, denotes the userspace address to which the=
 kernel
> + *             is leaking data.
> + * @reason:    Error type from enum kmsan_bug_reason.
> + *
> + * kmsan_report() prints an error message for a consequent group of byte=
s
> + * sharing the same origin. If an uninitialized value is used in a compa=
rison,
> + * this function is called once without specifying the addresses. When c=
hecking
> + * a memory range, KMSAN may call kmsan_report() multiple times with the=
 same
> + * @address, @size, @user_addr and @reason, but different @off_first and
> + * @off_last corresponding to different @origin values.
> + */
> +void kmsan_report(depot_stack_handle_t origin, void *address, int size,
> +                 int off_first, int off_last, const void *user_addr,
> +                 enum kmsan_bug_reason reason);
> +
> +DECLARE_PER_CPU(struct kmsan_ctx, kmsan_percpu_ctx);
> +
> +static __always_inline struct kmsan_ctx *kmsan_get_context(void)
> +{
> +       return in_task() ? &current->kmsan_ctx : raw_cpu_ptr(&kmsan_percp=
u_ctx);
> +}
> +
> +/*
> + * When a compiler hook or KMSAN runtime function is invoked, it may mak=
e a
> + * call to instrumented code and eventually call itself recursively. To =
avoid
> + * that, we guard the runtime entry regions with
> + * kmsan_enter_runtime()/kmsan_leave_runtime() and exit the hook if
> + * kmsan_in_runtime() is true.
> + *
> + * Non-runtime code may occasionally get executed in nested IRQs from th=
e
> + * runtime code (e.g. when called via smp_call_function_single()). Becau=
se some
> + * KMSAN routines may take locks (e.g. for memory allocation), we conser=
vatively
> + * bail out instead of calling them. To minimize the effect of this (pot=
entially
> + * missing initialization events) kmsan_in_runtime() is not checked in
> + * non-blocking runtime functions.
> + */
> +static __always_inline bool kmsan_in_runtime(void)
> +{
> +       if ((hardirq_count() >> HARDIRQ_SHIFT) > 1)
> +               return true;
> +       return kmsan_get_context()->kmsan_in_runtime;
> +}
> +
> +static __always_inline void kmsan_enter_runtime(void)
> +{
> +       struct kmsan_ctx *ctx;
> +
> +       ctx =3D kmsan_get_context();
> +       KMSAN_WARN_ON(ctx->kmsan_in_runtime++);
> +}
> +
> +static __always_inline void kmsan_leave_runtime(void)
> +{
> +       struct kmsan_ctx *ctx =3D kmsan_get_context();
> +
> +       KMSAN_WARN_ON(--ctx->kmsan_in_runtime);
> +}
> +
> +depot_stack_handle_t kmsan_save_stack(void);
> +depot_stack_handle_t kmsan_save_stack_with_flags(gfp_t flags,
> +                                                unsigned int extra_bits)=
;
> +
> +/*
> + * Pack and unpack the origin chain depth and UAF flag to/from the extra=
 bits
> + * provided by the stack depot.
> + * The UAF flag is stored in the lowest bit, followed by the depth in th=
e upper
> + * bits.
> + * set_dsh_extra_bits() is responsible for clamping the value.
> + */
> +static __always_inline unsigned int kmsan_extra_bits(unsigned int depth,
> +                                                    bool uaf)
> +{
> +       return (depth << 1) | uaf;
> +}
> +
> +static __always_inline bool kmsan_uaf_from_eb(unsigned int extra_bits)
> +{
> +       return extra_bits & 1;
> +}
> +
> +static __always_inline unsigned int kmsan_depth_from_eb(unsigned int ext=
ra_bits)
> +{
> +       return extra_bits >> 1;
> +}
> +
> +/*
> + * kmsan_internal_ functions are supposed to be very simple and not requ=
ire the
> + * kmsan_in_runtime() checks.
> + */
> +void kmsan_internal_memmove_metadata(void *dst, void *src, size_t n);
> +void kmsan_internal_poison_memory(void *address, size_t size, gfp_t flag=
s,
> +                                 unsigned int poison_flags);
> +void kmsan_internal_unpoison_memory(void *address, size_t size, bool che=
cked);
> +void kmsan_internal_set_shadow_origin(void *address, size_t size, int b,
> +                                     u32 origin, bool checked);
> +depot_stack_handle_t kmsan_internal_chain_origin(depot_stack_handle_t id=
);
> +
> +bool kmsan_metadata_is_contiguous(void *addr, size_t size);
> +void kmsan_internal_check_memory(void *addr, size_t size, const void *us=
er_addr,
> +                                int reason);
> +bool kmsan_internal_is_module_addr(void *vaddr);
> +bool kmsan_internal_is_vmalloc_addr(void *addr);
> +
> +struct page *kmsan_vmalloc_to_page_or_null(void *vaddr);
> +
> +#endif /* __MM_KMSAN_KMSAN_H */
> diff --git a/mm/kmsan/report.c b/mm/kmsan/report.c
> new file mode 100644
> index 0000000000000..c298edcf49ee5
> --- /dev/null
> +++ b/mm/kmsan/report.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KMSAN error reporting routines.
> + *
> + * Copyright (C) 2019-2022 Google LLC
> + * Author: Alexander Potapenko <glider@google.com>
> + *
> + */
> +
> +#include <linux/console.h>
> +#include <linux/moduleparam.h>
> +#include <linux/stackdepot.h>
> +#include <linux/stacktrace.h>
> +#include <linux/uaccess.h>
> +
> +#include "kmsan.h"
> +
> +static DEFINE_RAW_SPINLOCK(kmsan_report_lock);
> +#define DESCR_SIZE 128
> +/* Protected by kmsan_report_lock */
> +static char report_local_descr[DESCR_SIZE];
> +int panic_on_kmsan __read_mostly;
> +
> +#ifdef MODULE_PARAM_PREFIX
> +#undef MODULE_PARAM_PREFIX
> +#endif
> +#define MODULE_PARAM_PREFIX "kmsan."
> +module_param_named(panic, panic_on_kmsan, int, 0);
> +
> +/*
> + * Skip internal KMSAN frames.
> + */
> +static int get_stack_skipnr(const unsigned long stack_entries[],
> +                           int num_entries)
> +{
> +       int len, skip;
> +       char buf[64];
> +
> +       for (skip =3D 0; skip < num_entries; ++skip) {
> +               len =3D scnprintf(buf, sizeof(buf), "%ps",
> +                               (void *)stack_entries[skip]);
> +
> +               /* Never show __msan_* or kmsan_* functions. */
> +               if ((strnstr(buf, "__msan_", len) =3D=3D buf) ||
> +                   (strnstr(buf, "kmsan_", len) =3D=3D buf))
> +                       continue;
> +
> +               /*
> +                * No match for runtime functions -- @skip entries to ski=
p to
> +                * get to first frame of interest.
> +                */
> +               break;
> +       }
> +
> +       return skip;
> +}
> +
> +/*
> + * Currently the descriptions of locals generated by Clang look as follo=
ws:
> + *   ----local_name@function_name
> + * We want to print only the name of the local, as other information in =
that
> + * description can be confusing.
> + * The meaningful part of the description is copied to a global buffer t=
o avoid
> + * allocating memory.
> + */
> +static char *pretty_descr(char *descr)
> +{
> +       int i, pos =3D 0, len =3D strlen(descr);
> +
> +       for (i =3D 0; i < len; i++) {
> +               if (descr[i] =3D=3D '@')
> +                       break;
> +               if (descr[i] =3D=3D '-')
> +                       continue;
> +               report_local_descr[pos] =3D descr[i];
> +               if (pos + 1 =3D=3D DESCR_SIZE)
> +                       break;
> +               pos++;
> +       }
> +       report_local_descr[pos] =3D 0;
> +       return report_local_descr;
> +}
> +
> +void kmsan_print_origin(depot_stack_handle_t origin)
> +{
> +       unsigned long *entries =3D NULL, *chained_entries =3D NULL;
> +       unsigned int nr_entries, chained_nr_entries, skipnr;
> +       void *pc1 =3D NULL, *pc2 =3D NULL;
> +       depot_stack_handle_t head;
> +       unsigned long magic;
> +       char *descr =3D NULL;
> +
> +       if (!origin)
> +               return;
> +
> +       while (true) {
> +               nr_entries =3D stack_depot_fetch(origin, &entries);
> +               magic =3D nr_entries ? entries[0] : 0;
> +               if ((nr_entries =3D=3D 4) && (magic =3D=3D KMSAN_ALLOCA_M=
AGIC_ORIGIN)) {
> +                       descr =3D (char *)entries[1];
> +                       pc1 =3D (void *)entries[2];
> +                       pc2 =3D (void *)entries[3];
> +                       pr_err("Local variable %s created at:\n",
> +                              pretty_descr(descr));
> +                       if (pc1)
> +                               pr_err(" %pSb\n", pc1);
> +                       if (pc2)
> +                               pr_err(" %pSb\n", pc2);
> +                       break;
> +               }
> +               if ((nr_entries =3D=3D 3) && (magic =3D=3D KMSAN_CHAIN_MA=
GIC_ORIGIN)) {
> +                       head =3D entries[1];
> +                       origin =3D entries[2];
> +                       pr_err("Uninit was stored to memory at:\n");
> +                       chained_nr_entries =3D
> +                               stack_depot_fetch(head, &chained_entries)=
;
> +                       kmsan_internal_unpoison_memory(
> +                               chained_entries,
> +                               chained_nr_entries * sizeof(*chained_entr=
ies),
> +                               /*checked*/ false);
> +                       skipnr =3D get_stack_skipnr(chained_entries,
> +                                                 chained_nr_entries);
> +                       stack_trace_print(chained_entries + skipnr,
> +                                         chained_nr_entries - skipnr, 0)=
;
> +                       pr_err("\n");
> +                       continue;
> +               }
> +               pr_err("Uninit was created at:\n");
> +               if (nr_entries) {
> +                       skipnr =3D get_stack_skipnr(entries, nr_entries);
> +                       stack_trace_print(entries + skipnr, nr_entries - =
skipnr,
> +                                         0);
> +               } else {
> +                       pr_err("(stack is not available)\n");
> +               }
> +               break;
> +       }
> +}
> +
> +void kmsan_report(depot_stack_handle_t origin, void *address, int size,
> +                 int off_first, int off_last, const void *user_addr,
> +                 enum kmsan_bug_reason reason)
> +{
> +       unsigned long stack_entries[KMSAN_STACK_DEPTH];
> +       int num_stack_entries, skipnr;
> +       char *bug_type =3D NULL;
> +       unsigned long ua_flags;
> +       bool is_uaf;
> +
> +       if (!kmsan_enabled)
> +               return;
> +       if (!current->kmsan_ctx.allow_reporting)
> +               return;
> +       if (!origin)
> +               return;
> +
> +       current->kmsan_ctx.allow_reporting =3D false;
> +       ua_flags =3D user_access_save();
> +       raw_spin_lock(&kmsan_report_lock);
> +       pr_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> +       is_uaf =3D kmsan_uaf_from_eb(stack_depot_get_extra_bits(origin));
> +       switch (reason) {
> +       case REASON_ANY:
> +               bug_type =3D is_uaf ? "use-after-free" : "uninit-value";
> +               break;
> +       case REASON_COPY_TO_USER:
> +               bug_type =3D is_uaf ? "kernel-infoleak-after-free" :
> +                                         "kernel-infoleak";
> +               break;
> +       case REASON_SUBMIT_URB:
> +               bug_type =3D is_uaf ? "kernel-usb-infoleak-after-free" :
> +                                         "kernel-usb-infoleak";
> +               break;
> +       }
> +
> +       num_stack_entries =3D
> +               stack_trace_save(stack_entries, KMSAN_STACK_DEPTH, 1);
> +       skipnr =3D get_stack_skipnr(stack_entries, num_stack_entries);
> +
> +       pr_err("BUG: KMSAN: %s in %pSb\n",
> +              bug_type, (void *)stack_entries[skipnr]);
> +       stack_trace_print(stack_entries + skipnr, num_stack_entries - ski=
pnr,
> +                         0);
> +       pr_err("\n");
> +
> +       kmsan_print_origin(origin);
> +
> +       if (size) {
> +               pr_err("\n");
> +               if (off_first =3D=3D off_last)
> +                       pr_err("Byte %d of %d is uninitialized\n", off_fi=
rst,
> +                              size);
> +               else
> +                       pr_err("Bytes %d-%d of %d are uninitialized\n",
> +                              off_first, off_last, size);
> +       }
> +       if (address)
> +               pr_err("Memory access of size %d starts at %px\n", size,
> +                      address);
> +       if (user_addr && reason =3D=3D REASON_COPY_TO_USER)
> +               pr_err("Data copied to user address %px\n", user_addr);
> +       pr_err("\n");
> +       dump_stack_print_info(KERN_ERR);
> +       pr_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> +       add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> +       raw_spin_unlock(&kmsan_report_lock);
> +       if (panic_on_kmsan)
> +               panic("kmsan.panic set ...\n");
> +       user_access_restore(ua_flags);
> +       current->kmsan_ctx.allow_reporting =3D true;
> +}
> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
> new file mode 100644
> index 0000000000000..e5ad2972d7362
> --- /dev/null
> +++ b/mm/kmsan/shadow.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KMSAN shadow implementation.
> + *
> + * Copyright (C) 2017-2022 Google LLC
> + * Author: Alexander Potapenko <glider@google.com>
> + *
> + */
> +
> +#include <asm/kmsan.h>
> +#include <asm/tlbflush.h>
> +#include <linux/cacheflush.h>
> +#include <linux/memblock.h>
> +#include <linux/mm_types.h>
> +#include <linux/percpu-defs.h>
> +#include <linux/slab.h>
> +#include <linux/smp.h>
> +#include <linux/stddef.h>
> +
> +#include "../internal.h"
> +#include "kmsan.h"
> +
> +#define shadow_page_for(page) ((page)->kmsan_shadow)
> +
> +#define origin_page_for(page) ((page)->kmsan_origin)
> +
> +static void *shadow_ptr_for(struct page *page)
> +{
> +       return page_address(shadow_page_for(page));
> +}
> +
> +static void *origin_ptr_for(struct page *page)
> +{
> +       return page_address(origin_page_for(page));
> +}
> +
> +static bool page_has_metadata(struct page *page)
> +{
> +       return shadow_page_for(page) && origin_page_for(page);
> +}
> +
> +static void set_no_shadow_origin_page(struct page *page)
> +{
> +       shadow_page_for(page) =3D NULL;
> +       origin_page_for(page) =3D NULL;
> +}
> +
> +/*
> + * Dummy load and store pages to be used when the real metadata is unava=
ilable.
> + * There are separate pages for loads and stores, so that every load ret=
urns a
> + * zero, and every store doesn't affect other loads.
> + */
> +static char dummy_load_page[PAGE_SIZE] __aligned(PAGE_SIZE);
> +static char dummy_store_page[PAGE_SIZE] __aligned(PAGE_SIZE);
> +
> +static unsigned long vmalloc_meta(void *addr, bool is_origin)
> +{
> +       unsigned long addr64 =3D (unsigned long)addr, off;
> +
> +       KMSAN_WARN_ON(is_origin && !IS_ALIGNED(addr64, KMSAN_ORIGIN_SIZE)=
);
> +       if (kmsan_internal_is_vmalloc_addr(addr)) {
> +               off =3D addr64 - VMALLOC_START;
> +               return off + (is_origin ? KMSAN_VMALLOC_ORIGIN_START :
> +                                               KMSAN_VMALLOC_SHADOW_STAR=
T);
> +       }
> +       if (kmsan_internal_is_module_addr(addr)) {
> +               off =3D addr64 - MODULES_VADDR;
> +               return off + (is_origin ? KMSAN_MODULES_ORIGIN_START :
> +                                               KMSAN_MODULES_SHADOW_STAR=
T);
> +       }
> +       return 0;
> +}
> +
> +static struct page *virt_to_page_or_null(void *vaddr)
> +{
> +       if (kmsan_virt_addr_valid(vaddr))
> +               return virt_to_page(vaddr);
> +       else
> +               return NULL;
> +}
> +
> +struct shadow_origin_ptr kmsan_get_shadow_origin_ptr(void *address, u64 =
size,
> +                                                    bool store)
> +{
> +       struct shadow_origin_ptr ret;
> +       void *shadow;
> +
> +       /*
> +        * Even if we redirect this memory access to the dummy page, it w=
ill
> +        * go out of bounds.
> +        */
> +       KMSAN_WARN_ON(size > PAGE_SIZE);
> +
> +       if (!kmsan_enabled)
> +               goto return_dummy;
> +
> +       KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(address, size));
> +       shadow =3D kmsan_get_metadata(address, KMSAN_META_SHADOW);
> +       if (!shadow)
> +               goto return_dummy;
> +
> +       ret.shadow =3D shadow;
> +       ret.origin =3D kmsan_get_metadata(address, KMSAN_META_ORIGIN);
> +       return ret;
> +
> +return_dummy:
> +       if (store) {
> +               /* Ignore this store. */
> +               ret.shadow =3D dummy_store_page;
> +               ret.origin =3D dummy_store_page;
> +       } else {
> +               /* This load will return zero. */
> +               ret.shadow =3D dummy_load_page;
> +               ret.origin =3D dummy_load_page;
> +       }
> +       return ret;
> +}
> +
> +/*
> + * Obtain the shadow or origin pointer for the given address, or NULL if=
 there's
> + * none. The caller must check the return value for being non-NULL if ne=
eded.
> + * The return value of this function should not depend on whether we're =
in the
> + * runtime or not.
> + */
> +void *kmsan_get_metadata(void *address, bool is_origin)
> +{
> +       u64 addr =3D (u64)address, pad, off;
> +       struct page *page;
> +
> +       if (is_origin && !IS_ALIGNED(addr, KMSAN_ORIGIN_SIZE)) {
> +               pad =3D addr % KMSAN_ORIGIN_SIZE;
> +               addr -=3D pad;
> +       }
> +       address =3D (void *)addr;
> +       if (kmsan_internal_is_vmalloc_addr(address) ||
> +           kmsan_internal_is_module_addr(address))
> +               return (void *)vmalloc_meta(address, is_origin);
> +
> +       page =3D virt_to_page_or_null(address);
> +       if (!page)
> +               return NULL;
> +       if (!page_has_metadata(page))
> +               return NULL;
> +       off =3D addr % PAGE_SIZE;
> +
> +       return (is_origin ? origin_ptr_for(page) : shadow_ptr_for(page)) =
+ off;
> +}
> diff --git a/scripts/Makefile.kmsan b/scripts/Makefile.kmsan
> new file mode 100644
> index 0000000000000..b5b0aa61322ec
> --- /dev/null
> +++ b/scripts/Makefile.kmsan
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +kmsan-cflags :=3D -fsanitize=3Dkernel-memory
> +
> +ifdef CONFIG_KMSAN_CHECK_PARAM_RETVAL
> +kmsan-cflags +=3D -fsanitize-memory-param-retval
> +endif
> +
> +export CFLAGS_KMSAN :=3D $(kmsan-cflags)
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index d1425778664b9..46ebf7cb081f6 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -157,6 +157,15 @@ _c_flags +=3D $(if $(patsubst n%,, \
>  endif
>  endif
>
> +ifeq ($(CONFIG_KMSAN),y)
> +_c_flags +=3D $(if $(patsubst n%,, \
> +               $(KMSAN_SANITIZE_$(basetarget).o)$(KMSAN_SANITIZE)y), \
> +               $(CFLAGS_KMSAN))
> +_c_flags +=3D $(if $(patsubst n%,, \
> +               $(KMSAN_ENABLE_CHECKS_$(basetarget).o)$(KMSAN_ENABLE_CHEC=
KS)y), \
> +               , -mllvm -msan-disable-checks=3D1)
> +endif
> +
>  ifeq ($(CONFIG_UBSAN),y)
>  _c_flags +=3D $(if $(patsubst n%,, \
>                 $(UBSAN_SANITIZE_$(basetarget).o)$(UBSAN_SANITIZE)$(CONFI=
G_UBSAN_SANITIZE_ALL)), \
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/20220701142310.2188015-12-glider%40google.com.
