Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53845AA3E0
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 01:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiIAXon (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Sep 2022 19:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiIAXom (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Sep 2022 19:44:42 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E915BA4B08
        for <linux-arch@vger.kernel.org>; Thu,  1 Sep 2022 16:44:40 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id i67so276029vkb.2
        for <linux-arch@vger.kernel.org>; Thu, 01 Sep 2022 16:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=E/w20BQSdzic7HV/DXA4w/RdjxH6IBYdbHhBUiDju7A=;
        b=d64iMYOScRb/kfj6GTe+dCDg7yBC91L/fdLc+4cxP5Pvcgx6qaOMzL6WLG9T2Qx03q
         AOJzYfb8Saf9iYFBLzhpB5XfRHYTDsbwIk1HRF7sZ4yEIweU88mUcura4/ZUPzv/4NRf
         /fXuTOfD3ASnWYUUoXWlU6BZ40RgqoR981eHf0lL6q0L2Tuy8xIjXC4mJgvOJ8/6hoCb
         TiYPMTEkZ6mxnEupyokGjyQwusEhbNpXe4N1AO5jRXUQqYaHmKnn3ajjMdUsXacezMJ5
         75x/FX2ZxhFjV1ivLvjjVGSjgXPHeiVdkEzWdRsF+WFhfH3KUckgvRvLwJY47vJe0SPX
         KY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=E/w20BQSdzic7HV/DXA4w/RdjxH6IBYdbHhBUiDju7A=;
        b=iSrS7KLDIm9tU2J0O2fArY3/IqtDMB9K3P7Q7wC+BkQ+4vivxWQasATZ3IhanbKXtA
         gmhhu8Na2oNEpZlAogGQRxmVhTwJ3F/2E/LZVQecEGLe0sfR7xwm9FWCIpDblAkjrj7p
         9EwPhReNK5M+q5UG3nvy3yW3yR4VyvhBE00m6O/d+4G7o5Qsxj7/KGTFpa1xuLOPRbH5
         5AoetkJyB3Joz9Y0Op/tdL0mNtv2XSiezgBQHD8+daF0E4XOB6NhIvQ9RspVmfU1Xite
         e3Gy2aM4wySMSRqRKdoffcBLfIqikFOKl5pxEhXHr4sVrKJ1FhLjCEz8k7/srGimVnG8
         akXw==
X-Gm-Message-State: ACgBeo0WYJH3FP6yqcvW8zuow+zuB5Bt+L21AHVI/NroBmOJWPfvm47f
        go1V1rSDlXAHUqqlNKZ1f4xTS6IKhYu+os9LP5hixg==
X-Google-Smtp-Source: AA6agR4FMwqqn0XOwg5/1luwsPx0Iw1rXdGs6d4W88tUlFkF3J5qguh/+CJfJWKYnI2txoV7pm8mMTJ+2OJH3G/vBRM=
X-Received: by 2002:a1f:2c8c:0:b0:394:76ba:b08c with SMTP id
 s134-20020a1f2c8c000000b0039476bab08cmr6966094vks.32.1662075879803; Thu, 01
 Sep 2022 16:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220826150807.723137-1-glider@google.com> <20220826150807.723137-5-glider@google.com>
 <20220826211729.e65d52e7919fee5c34d22efc@linux-foundation.org>
 <CAG_fn=Xpva_yx8oG-xi7jqJyM2YLcjNda+8ZyQPGBMV411XgMQ@mail.gmail.com>
 <20220829122452.cce41f2754c4e063f3ae8b75@linux-foundation.org>
 <CAG_fn=X6eZ6Cdrv5pivcROHi3D8uymdgh+EbnFasBap2a=0LQQ@mail.gmail.com> <20220830150549.afa67340c2f5eb33ff9615f4@linux-foundation.org>
In-Reply-To: <20220830150549.afa67340c2f5eb33ff9615f4@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 1 Sep 2022 17:44:03 -0600
Message-ID: <CAOUHufY91Eju-g1+xbUsGkGZ-cwBm78v+S_Air7Cp8mAnYJVYA@mail.gmail.com>
Subject: Re: [PATCH v5 04/44] x86: asm: instrument usercopy in get_user() and put_user()
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
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
        Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 30, 2022 at 4:05 PM Andrew Morton <akpm@linux-foundation.org> wrote:
...
> Yu, that inclusion is regrettable.  I don't think mm_types.h is an
> appropriate site for implementing lru_gen_use_mm() anyway.  Adding a
> new header is always the right fix for these things.  I'd suggest
> adding a new mglru.h (or whatever) and putting most/all of the mglru
> material in there.
>
> Also, the addition to kernel/sched/core.c wasn't clearly changelogged,
> is uncommented and I doubt if the sched developers know about it, let
> alone reviewed it.  Please give them a heads-up.

Adding Ingo, Peter, Juri and Vincent.

I added lru_gen_use_mm() (one store operation) to context_switch() in
kernel/sched/core.c, and I would appreciate it if you could take a
look and let me know if you have any concerns:
https://lore.kernel.org/r/20220815071332.627393-9-yuzhao@google.com/

I'll resend the series in a week or so, and cc you when that happens.

> The addition looks fairly benign, but core context_switch() is the
> sort of thing which people get rather defensive about and putting
> mm-specific stuff in there might be challenged.  Some quantitative
> justification of this optimization would be appropriate.

The commit message (from the above link) touches on the theory only:

    This patch uses the following optimizations when walking page tables:
    1. It tracks the usage of mm_struct's between context switches so that
       page table walkers can skip processes that have been sleeping since
       the last iteration.

Let me expand on this.

TLDR: lru_gen_use_mm() introduces an extra store operation whenever
switching to a new mm_struct, which sets a flag for page reclaim to
clear.

For systems that are NOT under memory pressure:
1. This is a new overhead.
2. I don't think it's measurable, hence can't be the last straw.
3. Assume it can be measured, the belief is that underutilized systems
should be sacrificed (to some degree) for the greater good.

For systems that are under memory pressure:
1. When this flag is set on a mm_struct, page reclaim knows that this
mm_struct has been used since the last time it cleared this flag. So
it's worth checking out this mm_struct (to clear the accessed bit).
2. The similar idea has been used on Android and ChromeOS: when an app
or a tab goes to the background, these systems (conditionally) call
MADV_COLD. The majority of GUI applications don't implement this idea.
MGLRU opts to do it for the benefit of them. How it benefits server
applications is unknown (uninteresting).
3. This optimization benefits arm64 v8.2+ more than x86, since x86
supports the accessed bit in non-leaf entries and therefore the search
space can be reduced based on that. On a 4GB ARM system with 40 Chrome
tabs opened and 5 tabs in active use, this optimization improves page
table walk performance by about 5%. The overall benefit is small but
measurable under heavy memory pressure.
4. The idea can be reused by other MM components, e.g., khugepaged.

Thanks.
