Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4BE573278
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jul 2022 11:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbiGMJ2s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Jul 2022 05:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbiGMJ2n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jul 2022 05:28:43 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C0915FF4
        for <linux-arch@vger.kernel.org>; Wed, 13 Jul 2022 02:28:41 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31c89111f23so106682097b3.0
        for <linux-arch@vger.kernel.org>; Wed, 13 Jul 2022 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YLa+B7g0k4vjWxV/5/J/yQw4cNuAt3dnRpzqWxr+dBM=;
        b=WCXPC3m3TqqYyHJ+uDfaD+33LK+kR0QTRuUNWFbQ/yiL1aUJNetddXLM+3nxPGejsh
         Ls/9+uJ8DBwyNtwZzS2bmCqOgmd64HDETf5lolZIerFBDUMyM10UXHSgqJRlGnaP6+Sr
         7WQw0xRdGLsRdqbYhZtYiXHgC+f9Xsu3UhqrEzWn4Z1/CSbfHNbd8LkOBe5qRW4ixNbs
         KyQ5sqcw9dz3EgF4DFFiG0BAHXiangGWZsG4iVmPViGONkbOq3wcpVyCIXBH+7zZmcO/
         M08jelPQe0TpKZi1+GOuZgf4DLn4ormxvV2r8Qjs/MYHhlBjn3biZ9auY1KBNWeaQ5Ps
         V8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YLa+B7g0k4vjWxV/5/J/yQw4cNuAt3dnRpzqWxr+dBM=;
        b=bcl4NbMFyhrOF1+uJQkcNexdfuzgmXUD4JCyOo+8cnAc8LtdhIVlFjuZdj5MVUcms5
         VuwXa+gSRSCrGruURlRTYNGezW27wsLsLy7lBX23xphUk+8nwu0VRHBCP8ibEHr9qzJh
         qSay1cOYIiPPNejTr5SCNQKYI28wlRoYeXQKnlS04IZdFhBlC3I9mM/2aGOTSeROPTWo
         DvIDeIO9btHWe7xTX0QhYIiwVn0ObCf+sOO0SuntFHOBHEmFCUiEn42/MCqRrUpCzCUs
         GPZuUS7OK6Et0WBpAhgCm7G+lahUMqCEid4CLtIqDlWcsKFcpFBySrBMPJN4JfjFmeUm
         /ygQ==
X-Gm-Message-State: AJIora88tIoR1BP6GYmjuKe//o5Jfoqegc1tfaol6Be/kz19yLRZtaHU
        TE1IMIG6gVPGSmaW127iV8GrnEoVg0mRTmfa2OEUeQ==
X-Google-Smtp-Source: AGRyM1uhGuFtib7Qkw+eg+f4MeHVwIDAHRzhZCC99tpjAc0xrKFlrRMHg2i9KL2/AC4ul/k3MxgtlGExoxaQBzv8w5I=
X-Received: by 2002:a81:5dd5:0:b0:31d:c5ac:e3c0 with SMTP id
 r204-20020a815dd5000000b0031dc5ace3c0mr667093ywb.264.1657704520206; Wed, 13
 Jul 2022 02:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-20-glider@google.com>
In-Reply-To: <20220701142310.2188015-20-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 13 Jul 2022 11:28:04 +0200
Message-ID: <CANpmjNNmZpw5P4y9XLT-GsfNOegNcQD=fZLFagHW=XsDqF2fxQ@mail.gmail.com>
Subject: Re: [PATCH v4 19/45] kmsan: unpoison @tlb in arch_tlb_gather_mmu()
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

On Fri, 1 Jul 2022 at 16:24, Alexander Potapenko <glider@google.com> wrote:
>
> This is a hack to reduce stackdepot pressure.

Will it cause false negatives or other issues? If not, I'd just call
it an optimization and not a hack.

> struct mmu_gather contains 7 1-bit fields packed into a 32-bit unsigned
> int value. The remaining 25 bits remain uninitialized and are never used,
> but KMSAN updates the origin for them in zap_pXX_range() in mm/memory.c,
> thus creating very long origin chains. This is technically correct, but
> consumes too much memory.
>
> Unpoisoning the whole structure will prevent creating such chains.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Acked-by: Marco Elver <elver@google.com>

> ---
> Link: https://linux-review.googlesource.com/id/I76abee411b8323acfdbc29bc3a60dca8cff2de77
> ---
>  mm/mmu_gather.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index a71924bd38c0d..add4244e5790d 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -1,6 +1,7 @@
>  #include <linux/gfp.h>
>  #include <linux/highmem.h>
>  #include <linux/kernel.h>
> +#include <linux/kmsan-checks.h>
>  #include <linux/mmdebug.h>
>  #include <linux/mm_types.h>
>  #include <linux/mm_inline.h>
> @@ -265,6 +266,15 @@ void tlb_flush_mmu(struct mmu_gather *tlb)
>  static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
>                              bool fullmm)
>  {
> +       /*
> +        * struct mmu_gather contains 7 1-bit fields packed into a 32-bit
> +        * unsigned int value. The remaining 25 bits remain uninitialized
> +        * and are never used, but KMSAN updates the origin for them in
> +        * zap_pXX_range() in mm/memory.c, thus creating very long origin
> +        * chains. This is technically correct, but consumes too much memory.
> +        * Unpoisoning the whole structure will prevent creating such chains.
> +        */
> +       kmsan_unpoison_memory(tlb, sizeof(*tlb));
>         tlb->mm = mm;
>         tlb->fullmm = fullmm;
>
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
