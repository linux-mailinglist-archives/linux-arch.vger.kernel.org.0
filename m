Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3317571B93
	for <lists+linux-arch@lfdr.de>; Tue, 12 Jul 2022 15:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbiGLNoP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Jul 2022 09:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiGLNoL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jul 2022 09:44:11 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59772181
        for <linux-arch@vger.kernel.org>; Tue, 12 Jul 2022 06:44:08 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id y195so14051887yby.0
        for <linux-arch@vger.kernel.org>; Tue, 12 Jul 2022 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MyQuL5EzG5eMdd3tjqHgbmALZQ6QoMWn3xa4SlD7s1A=;
        b=XsmwdUhnV9Nrh1SGSj3JOV2MR95zR+WwDM8KHyqTK6nHKRO0cezI02yyceFlwPZoGf
         LD9hFog+Z5JS+mZ9fFL2w/Ykf6nXujJFNCtizbi6oqD1uCF9yqBSB8/MHRkkvvEDdyDU
         I3o5KHJ4r9ziBNn2dgCp2K5rjLiCyIM+WlUOiQyuM078Q8jJrwxq7cktVsi42HspunWN
         TAGH4SZCzymam+0/ttGe45EPW7yHZMPm/1FIpA/kzCIQRFMrVyyuL0gR4qVqjjuD9NLH
         ifM7a1uFz8TXyJoivkCURiXWYCFNRU3TydpTR5nKVX4hBL3m9C/5ri4ubLU+E01uShRG
         jdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MyQuL5EzG5eMdd3tjqHgbmALZQ6QoMWn3xa4SlD7s1A=;
        b=pruhNd8EkiAw4iqAPI0CKlXr5w4z5mOcFN9TwJ1mJmbbtX9pJ7I8pIsGghpHPthPFb
         kCBn7BUeYgK2eMi/EYI6zI7IRKk5LQzdfjgAq5x6x/HmFBY2yy1sgkcG7RzS8A8G7LWU
         60kZjZv6zs+NqYjc7aOFAYD86OUUIJXkb5NEAikZ+pPekZIBeuSyflyhhWjpib4dHoch
         x8iQmEVoQa9ToYw6118xZDwjM05Qo20mv66XtI+aFDgm+QcV6I1f0bh4so+klMN6j8xr
         hIJp1e+5C/uTLWLltxv1zHHa4jhYzO5tGDV2UvWzJicf00yUMwaY1bkFQe9a+VoGdkK7
         rX1w==
X-Gm-Message-State: AJIora/1uTA+YhNQsmrx2F0k2c8sGgkPt1nGqtzQikhN3GM6Ceg3MWYQ
        QxjDsCSi+q+HSijGBoOdcdRC7lHuCRSxhtO79fjmLA==
X-Google-Smtp-Source: AGRyM1tJAHsdZLmYiI5P+T53CpbIO2hs/5gCoOEJtbFHqMVTgNWTq1cDtAtMQvatMTbVUxcRky7bRa+o9m1YQjjdVwc=
X-Received: by 2002:a25:1583:0:b0:668:e74a:995f with SMTP id
 125-20020a251583000000b00668e74a995fmr23207491ybv.1.1657633447949; Tue, 12
 Jul 2022 06:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-34-glider@google.com>
In-Reply-To: <20220701142310.2188015-34-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 Jul 2022 15:43:31 +0200
Message-ID: <CANpmjNMpCow-pwqQnw8aHRUZKuBcOUU4On=JgEgysT8SBTrz6g@mail.gmail.com>
Subject: Re: [PATCH v4 33/45] x86: kmsan: disable instrumentation of
 unsupported code
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
[...]
> ---
>  arch/x86/boot/Makefile            | 1 +
>  arch/x86/boot/compressed/Makefile | 1 +
>  arch/x86/entry/vdso/Makefile      | 3 +++
>  arch/x86/kernel/Makefile          | 2 ++
>  arch/x86/kernel/cpu/Makefile      | 1 +
>  arch/x86/mm/Makefile              | 2 ++
>  arch/x86/realmode/rm/Makefile     | 1 +
>  lib/Makefile                      | 2 ++
[...]
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -272,6 +272,8 @@ obj-$(CONFIG_POLYNOMIAL) += polynomial.o
>  CFLAGS_stackdepot.o += -fno-builtin
>  obj-$(CONFIG_STACKDEPOT) += stackdepot.o
>  KASAN_SANITIZE_stackdepot.o := n
> +# In particular, instrumenting stackdepot.c with KMSAN will result in infinite
> +# recursion.
>  KMSAN_SANITIZE_stackdepot.o := n
>  KCOV_INSTRUMENT_stackdepot.o := n

This is generic code and not x86, should it have been in the earlier patch?
