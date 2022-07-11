Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6E0570846
	for <lists+linux-arch@lfdr.de>; Mon, 11 Jul 2022 18:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiGKQ1G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Jul 2022 12:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiGKQ1F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jul 2022 12:27:05 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6667A51A
        for <linux-arch@vger.kernel.org>; Mon, 11 Jul 2022 09:27:04 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31caffa4a45so54714137b3.3
        for <linux-arch@vger.kernel.org>; Mon, 11 Jul 2022 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNiOG9VLTXfyIumAzSkdBTE4Ro/vczfTyGGlVgeFa4E=;
        b=TEsjKApZIm2eGVFXX6zjsDd7ABvdwUwkWxz0rYWMXDFUGDLUjnYfCbSEh8axaflEcf
         /XAr0TEV8rX+gPcA0+uljGw/dhOFVhYtwVaJfH/iJZzU8Zl9ttHoRuTvQCNKLVlL8au0
         3zPqttuKlbdSz8ISmN8t7W1UOYA8ZrDRI5lCKPMSixLQXgh7Jn8yPSiKsQw08yTUdZL0
         fLEnLlY1fQ4/ZXeGTZzytVnyhHPgk+fmSFRNyB3kHmNQtFfPUaq1d4vdLWJxwt9rEGwT
         oYED+Sgjnb2pGD++4nURXUCClA1/XfbK7RNX65wwZQAx6AsAxtCq6ItH03wFIU9LttK1
         POzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNiOG9VLTXfyIumAzSkdBTE4Ro/vczfTyGGlVgeFa4E=;
        b=4TZ5KARy+4FnjepNus8ctRU1Q3CZoUTuqna9YU7enLVuB0+OuyMcyQJgCyvlnCBsEn
         I2nbzWVRSl3qqAsMFhQfZN8ozoiwChpHAAkwpht4xh7tTcUg/dRrMFysxmxZ7lR1FAEa
         bFyjNkqx0Zp1lyynwa6AQ5syUXPzKoYWHag04DIZ6dsTBEC94w5WJZ69npHg0kOpk0Cj
         RyljI3vhq0V1XYOEddvSrtI3Nw7rAyslOZKAaWES7Vp9bBHQz8ehe427Ju64QUfWLnPY
         w2VFqJMZ8yvpiUPsbsH6QM2wScf3IaF+cWnnSQWhM9CJ7pJMWS9/6sYME5w0geeQgTx5
         gyIw==
X-Gm-Message-State: AJIora+LrKr3qPMXUyjcCvlW6wb4YiQr3iXCE9WFOGcQ7L4TwtmwD8kp
        IslAfNwD7u47LKQPOTgpp1nmzTn3dWlevDuSQUQTfw==
X-Google-Smtp-Source: AGRyM1vFc9Nz3PdQYWOkyhyxSAnFDy6tbKimAKMs5WJU/DJQWlYu903flN0tTaSuogpfrJrZGoq5RrujLcEOvlsW8HY=
X-Received: by 2002:a81:98d:0:b0:31c:921c:9783 with SMTP id
 135-20020a81098d000000b0031c921c9783mr20064789ywj.316.1657556823180; Mon, 11
 Jul 2022 09:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-11-glider@google.com>
In-Reply-To: <20220701142310.2188015-11-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 11 Jul 2022 18:26:27 +0200
Message-ID: <CANpmjNOYqXSw5+Sxt0+=oOUQ1iQKVtEYHv20=sh_9nywxXUyWw@mail.gmail.com>
Subject: Re: [PATCH v4 10/45] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
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
> KMSAN adds extra metadata fields to struct page, so it does not fit into
> 64 bytes anymore.

Does this somehow cause extra space being used in all kernel configs?
If not, it would be good to note this in the commit message.


> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Link: https://linux-review.googlesource.com/id/I353796acc6a850bfd7bb342aa1b63e616fc614f1
> ---
>  drivers/nvdimm/nd.h       | 2 +-
>  drivers/nvdimm/pfn_devs.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> index ec5219680092d..85ca5b4da3cf3 100644
> --- a/drivers/nvdimm/nd.h
> +++ b/drivers/nvdimm/nd.h
> @@ -652,7 +652,7 @@ void devm_namespace_disable(struct device *dev,
>                 struct nd_namespace_common *ndns);
>  #if IS_ENABLED(CONFIG_ND_CLAIM)
>  /* max struct page size independent of kernel config */
> -#define MAX_STRUCT_PAGE_SIZE 64
> +#define MAX_STRUCT_PAGE_SIZE 128
>  int nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap);
>  #else
>  static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index 0e92ab4b32833..61af072ac98f9 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -787,7 +787,7 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
>                  * when populating the vmemmap. This *should* be equal to
>                  * PMD_SIZE for most architectures.
>                  *
> -                * Also make sure size of struct page is less than 64. We
> +                * Also make sure size of struct page is less than 128. We
>                  * want to make sure we use large enough size here so that
>                  * we don't have a dynamic reserve space depending on
>                  * struct page size. But we also want to make sure we notice
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
