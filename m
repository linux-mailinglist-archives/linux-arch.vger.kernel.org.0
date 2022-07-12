Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACF2571C2D
	for <lists+linux-arch@lfdr.de>; Tue, 12 Jul 2022 16:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbiGLOSK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Jul 2022 10:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiGLORv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jul 2022 10:17:51 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC40B1948
        for <linux-arch@vger.kernel.org>; Tue, 12 Jul 2022 07:17:50 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-31cf1adbf92so82521737b3.4
        for <linux-arch@vger.kernel.org>; Tue, 12 Jul 2022 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rAqtnQvHicJEwVtFwBWlT2ImbHkxNKwCydMf49aDhZw=;
        b=aiMgzeBmgUZ/65gwB7z3OTtsJK0m68bYi/4uF0m2lufr7mlmeVAZPQ0CgoETjNHwN9
         OR5ql/M5renBykTr5vdYLobTW0XAP/UTlosdoJx2ANZqwzs8BK3tQGb/yRGemqhOPTB5
         iK99Fjwli6AAsLPKMn8lRm5+/LpczLnXvRM5mdBg7X8PI1Rb0wb3vtXNmwxva/MoP8Y9
         f0pMS7Ab2OR6Rz5JjkDq0qesIKRAysU1yuWv5n+e039Y8V30n/O9aqVLUMKQNiHTpAvR
         iguPu8aE/PvAAvswibB+IxoRaR7YpLvASj0kcPA4lDVbjhZ/A8OlDVlXCq4Uy6Acnz0a
         GKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rAqtnQvHicJEwVtFwBWlT2ImbHkxNKwCydMf49aDhZw=;
        b=XWGA0JKxaZxeItvIqbEmGWBViBkGf8C7uWR3So4pkGSmj/Ife77/XjwgBLGb4nJh8/
         j1w2pEAZAO8UgeHMF/Z7+nizolHikyDXWWDKzTEL+FaOIxHeG1WRaPZMUnd7t0Jorzxw
         CooBB+t7AJoUXEGq76pOBJctHrDLFi8To/j5lBqafzavbBrewiNX4QGy+FYphY8McLVH
         2GDirxygFUTA7BvRXm67ky3nuIBfgQYvrQEzRZ+VfLMF09GF2R6HO3l5HBgzb96zvhy1
         zUvK9GtFyQuwGfl4dUl0Un/Jf9cW+L6SCmhnNo7IfUQ8OLQxjb/ACE5w/tE1Snb69X4d
         gijg==
X-Gm-Message-State: AJIora9eYzvUq+KqXtGbbhQIdtqYqv7hqllmrb7sruLbE1+grCogFHnI
        V1jho4QlRm5ypS5vgy1YxTCzSH5KEGROKmUO0a8sIg==
X-Google-Smtp-Source: AGRyM1tKjPPwFYnKg+0p6eGc1mlWK6G9zJMRPDOrTPORWMifQA9yBH9S1buboNSiyORVrmetN+LzTUSEuucVV4I4Qr8=
X-Received: by 2002:a81:98d:0:b0:31c:921c:9783 with SMTP id
 135-20020a81098d000000b0031c921c9783mr25429483ywj.316.1657635469677; Tue, 12
 Jul 2022 07:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-8-glider@google.com>
In-Reply-To: <20220701142310.2188015-8-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 Jul 2022 16:17:14 +0200
Message-ID: <CANpmjNPmp9J_2T8yw4oTBp_beywg_o=e-A3Y9nVvcHhTio4hDg@mail.gmail.com>
Subject: Re: [PATCH v4 07/45] kmsan: introduce __no_sanitize_memory and __no_kmsan_checks
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 1 Jul 2022 at 16:23, Alexander Potapenko <glider@google.com> wrote:
>
> __no_sanitize_memory is a function attribute that instructs KMSAN to
> skip a function during instrumentation. This is needed to e.g. implement
> the noinstr functions.
>
> __no_kmsan_checks is a function attribute that makes KMSAN
> ignore the uninitialized values coming from the function's
> inputs, and initialize the function's outputs.
>
> Functions marked with this attribute can't be inlined into functions
> not marked with it, and vice versa. This behavior is overridden by
> __always_inline.
>
> __SANITIZE_MEMORY__ is a macro that's defined iff the file is
> instrumented with KMSAN. This is not the same as CONFIG_KMSAN, which is
> defined for every file.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Marco Elver <elver@google.com>



> ---
> Link: https://linux-review.googlesource.com/id/I004ff0360c918d3cd8b18767ddd1381c6d3281be
> ---
>  include/linux/compiler-clang.h | 23 +++++++++++++++++++++++
>  include/linux/compiler-gcc.h   |  6 ++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index c84fec767445d..4fa0cc4cbd2c8 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -51,6 +51,29 @@
>  #define __no_sanitize_undefined
>  #endif
>
> +#if __has_feature(memory_sanitizer)
> +#define __SANITIZE_MEMORY__
> +/*
> + * Unlike other sanitizers, KMSAN still inserts code into functions marked with
> + * no_sanitize("kernel-memory"). Using disable_sanitizer_instrumentation
> + * provides the behavior consistent with other __no_sanitize_ attributes,
> + * guaranteeing that __no_sanitize_memory functions remain uninstrumented.
> + */
> +#define __no_sanitize_memory __disable_sanitizer_instrumentation
> +
> +/*
> + * The __no_kmsan_checks attribute ensures that a function does not produce
> + * false positive reports by:
> + *  - initializing all local variables and memory stores in this function;
> + *  - skipping all shadow checks;
> + *  - passing initialized arguments to this function's callees.
> + */
> +#define __no_kmsan_checks __attribute__((no_sanitize("kernel-memory")))
> +#else
> +#define __no_sanitize_memory
> +#define __no_kmsan_checks
> +#endif
> +
>  /*
>   * Support for __has_feature(coverage_sanitizer) was added in Clang 13 together
>   * with no_sanitize("coverage"). Prior versions of Clang support coverage
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index a0c55eeaeaf16..63eb90eddad77 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -125,6 +125,12 @@
>  #define __SANITIZE_ADDRESS__
>  #endif
>
> +/*
> + * GCC does not support KMSAN.
> + */
> +#define __no_sanitize_memory
> +#define __no_kmsan_checks
> +
>  /*
>   * Turn individual warnings and errors on and off locally, depending
>   * on version.
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
