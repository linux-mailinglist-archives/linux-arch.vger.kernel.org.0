Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199AF571929
	for <lists+linux-arch@lfdr.de>; Tue, 12 Jul 2022 13:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiGLLzk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Jul 2022 07:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiGLLzL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jul 2022 07:55:11 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E900B520B
        for <linux-arch@vger.kernel.org>; Tue, 12 Jul 2022 04:55:00 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 64so13482441ybt.12
        for <linux-arch@vger.kernel.org>; Tue, 12 Jul 2022 04:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OUm36JXbn2cFfASaBApIenl9AkY8jJt+kU3h2jjV/Do=;
        b=mlIxG6kQ1nJjyT6pnefCQ3hYABDyxXfo8vj7QqVR4W0A7RKYEtOLZa9MbrvvnIeMWR
         dfsXALkc0WEOD7PXmqQLiwLJ9xEBAysuby6yJKxj6646dvxPucmvvsZeyGqyiHsjL/GL
         /wqk0M7810Tm+4Nl/pBaBDlgMG3r6FU/a8y7b8hFbCrk8MOi8ARKr2IZ+H4FK9kdgidm
         o1sBcXYQMiH7/P2fq0YEUeWiPFgmGDtd/4ONHw7keEK/SPKD6yLtwB38/r44hQur7j9n
         zibhzt/o3QqDmHI8n+D5RAyIxVzPcB2S7X6hhOZi6r94M7FaOv56m0+LfqlZv8xH8OQO
         bNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OUm36JXbn2cFfASaBApIenl9AkY8jJt+kU3h2jjV/Do=;
        b=1yHTYINxSkyEAJv7iECSfUh1g2D5FYMFht9QGAu61CQ3319HiTZV3hG9iP2QPRJWh9
         liWH4Abwf3pcG7tsVIdUsKMFTJbyIOW/V5OITCOAut9+80hmqzo3jkef1BD7prleSXUE
         2BuNOh2hq5LCDpQCA23nz9oYdI17/X+qS+hw3QYosDsp3gWE4vi2NVvEWtzhH99sxS+O
         7SyErpf9qd/889SZ2Z6vevY/pEQIwsTGNk7WlsyupyR+nxPYkMsQ3XdwrU9upg0/1zjE
         JmBW/CJarBKjCG7p0soFzYB1NnJOwrPKBt4oEbo5l/TxyU/mP2KnchNqPu3Cb3XyeiC8
         w38w==
X-Gm-Message-State: AJIora/Uji+ZQLTg6nLWkDU/re7g1uI2223ahuHkbwh0N8SPvlM/JImn
        K/QHVjfssT2zLDwtVsxEiFN5z1M/CLj6AS6pTvafJA==
X-Google-Smtp-Source: AGRyM1ubexV4ZZio45G9VEs9ZwCCiwvszuvc+5DyA79Fo6d49h5TUMvqOxyRyX7e7kpx2hjZfwJJQpUJOqnmCD99wfo=
X-Received: by 2002:a25:2d59:0:b0:66e:32d3:7653 with SMTP id
 s25-20020a252d59000000b0066e32d37653mr21902834ybe.625.1657626899153; Tue, 12
 Jul 2022 04:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-13-glider@google.com>
In-Reply-To: <20220701142310.2188015-13-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 Jul 2022 13:54:23 +0200
Message-ID: <CANpmjNMjAzYtTOkc7m2j1qypjU6zYigKHwAcrHOJpRu0HCbKQA@mail.gmail.com>
Subject: Re: [PATCH v4 12/45] kmsan: disable instrumentation of unsupported
 common kernel code
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

On Fri, 1 Jul 2022 at 16:23, Alexander Potapenko <glider@google.com> wrote:
>
> EFI stub cannot be linked with KMSAN runtime, so we disable
> instrumentation for it.
>
> Instrumenting kcov, stackdepot or lockdep leads to infinite recursion
> caused by instrumentation hooks calling instrumented code again.
>
> This patch was previously part of "kmsan: disable KMSAN instrumentation
> for certain kernel parts", but was split away per Mark Rutland's
> request.

The "This patch..." paragraph feels out of place, and feels like it
should be part of a v4 changelog below ---.

> Signed-off-by: Alexander Potapenko <glider@google.com>

Otherwise,

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Link: https://linux-review.googlesource.com/id/I41ae706bd3474f074f6a870bfc3f0f90e9c720f7
> ---
>  drivers/firmware/efi/libstub/Makefile | 1 +
>  kernel/Makefile                       | 1 +
>  kernel/locking/Makefile               | 3 ++-
>  lib/Makefile                          | 1 +
>  4 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index d0537573501e9..81432d0c904b1 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -46,6 +46,7 @@ GCOV_PROFILE                  := n
>  # Sanitizer runtimes are unavailable and cannot be linked here.
>  KASAN_SANITIZE                 := n
>  KCSAN_SANITIZE                 := n
> +KMSAN_SANITIZE                 := n
>  UBSAN_SANITIZE                 := n
>  OBJECT_FILES_NON_STANDARD      := y
>
> diff --git a/kernel/Makefile b/kernel/Makefile
> index a7e1f49ab2b3b..e47f0526c987f 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -38,6 +38,7 @@ KCOV_INSTRUMENT_kcov.o := n
>  KASAN_SANITIZE_kcov.o := n
>  KCSAN_SANITIZE_kcov.o := n
>  UBSAN_SANITIZE_kcov.o := n
> +KMSAN_SANITIZE_kcov.o := n
>  CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack) -fno-stack-protector
>
>  # Don't instrument error handlers
> diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
> index d51cabf28f382..ea925731fa40f 100644
> --- a/kernel/locking/Makefile
> +++ b/kernel/locking/Makefile
> @@ -5,8 +5,9 @@ KCOV_INSTRUMENT         := n
>
>  obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
>
> -# Avoid recursion lockdep -> KCSAN -> ... -> lockdep.
> +# Avoid recursion lockdep -> sanitizer -> ... -> lockdep.
>  KCSAN_SANITIZE_lockdep.o := n
> +KMSAN_SANITIZE_lockdep.o := n
>
>  ifdef CONFIG_FUNCTION_TRACER
>  CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)
> diff --git a/lib/Makefile b/lib/Makefile
> index f99bf61f8bbc6..5056769d00bb6 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -272,6 +272,7 @@ obj-$(CONFIG_POLYNOMIAL) += polynomial.o
>  CFLAGS_stackdepot.o += -fno-builtin
>  obj-$(CONFIG_STACKDEPOT) += stackdepot.o
>  KASAN_SANITIZE_stackdepot.o := n
> +KMSAN_SANITIZE_stackdepot.o := n
>  KCOV_INSTRUMENT_stackdepot.o := n
>
>  obj-$(CONFIG_REF_TRACKER) += ref_tracker.o
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
