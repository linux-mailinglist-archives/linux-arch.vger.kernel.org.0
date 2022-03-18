Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9D04DDB62
	for <lists+linux-arch@lfdr.de>; Fri, 18 Mar 2022 15:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbiCROQJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Mar 2022 10:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237146AbiCROQH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2022 10:16:07 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE3824F290
        for <linux-arch@vger.kernel.org>; Fri, 18 Mar 2022 07:14:47 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id r1so6495468qvr.12
        for <linux-arch@vger.kernel.org>; Fri, 18 Mar 2022 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hJ1LZFGh9JrH4kLmBili/XVhpdUQ1ROx+3aGkRwtWcI=;
        b=ZQyTAMy/ScpfxQEloYqrCUcFgo6qloh6qWxRiKKAtZkyPrSuLS5yTxNvKXrtfyMeXC
         5qly6FgPCzATRsLI25+Q51/YesrhGC9wr1NEy+UDUqBTH1zmwVOQHfbGMLcM+RwZhwSC
         5rpt8CpNTz/z+PT/JhlyjUII85wYFh+tL8KLT/7YV4W94DFaynL7nxxZzX30zsGDls3S
         EJJLovQHLzYpe8LlrhMKCOXe1MBd8ZWgKCTogVt04cXQ+voExMLKKYvOcx8Rd8hMJgJX
         vvete9Y0IByOyVxi9/pEXtK1SxEAof+jaw9+Mz/cPfuUZlWmW5SApovgM288iSUU21Td
         PqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJ1LZFGh9JrH4kLmBili/XVhpdUQ1ROx+3aGkRwtWcI=;
        b=bAhkjnh11jJ6i26cYUV92qeVfbNqjc0F0zwEaEzKiC5zXTH05ZefLg+zctcaJfBOPq
         rJD4u6nSnzvJaC1kOcyOcZkU0Y792OdAZT+edmYbIBWNbAQbnT/QG6EaaB1PdDgM2ZnB
         uWFbJSizCBmtdpqLHoDmSuPVUsKDlCUs+NB6zn43GpOReK62wrjvhCI5z2uvsONQzGRb
         80u0lXB18I8x9sWqm4WxAym/AJ38BJeR6iV1fKhjkN+QxvDV/V7DuY86djvRP+FoX/xz
         0fjOYaWnoM/HRymUrM+DK99bxVWe8m1azKt+bf5PP0t+PdnaUyBAKt1He2VM1RABcoGj
         N30g==
X-Gm-Message-State: AOAM530ma57UlLgEJSTgzcT5dJ/JZIm7dxXlP2cTHV1Oj6cu8GX/dLkS
        tpjy0NNW7rkqiJ9msznVu/I/B1jjyoLxRNhO1x6miA==
X-Google-Smtp-Source: ABdhPJxvrcJRmBQ4O88N5dr023OMDX4aws1b92iUMNfld//QEeUr0i9SS+OlluqCchFGqXUdrKptwr+QUv1W5ylNiHE=
X-Received: by 2002:a05:6214:2342:b0:42d:7c8b:9eac with SMTP id
 hu2-20020a056214234200b0042d7c8b9eacmr7144475qvb.5.1647612886526; Fri, 18 Mar
 2022 07:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211214162050.660953-1-glider@google.com> <20211214162050.660953-11-glider@google.com>
 <YbnvTso+V6eZYGt+@FVFF77S0Q05N>
In-Reply-To: <YbnvTso+V6eZYGt+@FVFF77S0Q05N>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 18 Mar 2022 15:14:10 +0100
Message-ID: <CAG_fn=WWKsYULa-9UHLAWHgGOVjP-Zw8=Kxj4QEZQ5VDL55_Tw@mail.gmail.com>
Subject: Re: [PATCH 10/43] kmsan: pgtable: reduce vmalloc space
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
        Marco Elver <elver@google.com>,
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
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Dec 15, 2021 at 2:36 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Dec 14, 2021 at 05:20:17PM +0100, Alexander Potapenko wrote:
> > KMSAN is going to use 3/4 of existing vmalloc space to hold the
> > metadata, therefore we lower VMALLOC_END to make sure vmalloc() doesn't
> > allocate past the first 1/4.
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
>
> It might be worth adding an 'x86: ' prefix to the commit title, since this
> specifically affects x86 headers.

Makes sense, will do!
