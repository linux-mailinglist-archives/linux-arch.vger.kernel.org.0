Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35CB680780
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jan 2023 09:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbjA3Ife (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Jan 2023 03:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbjA3Ifd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Jan 2023 03:35:33 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F458EB65
        for <linux-arch@vger.kernel.org>; Mon, 30 Jan 2023 00:35:32 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id s24so4284783vsi.12
        for <linux-arch@vger.kernel.org>; Mon, 30 Jan 2023 00:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SDsKqyepeY63ocyMIwF8lZiaR+pOTU94INwLNWf/i/Q=;
        b=ev6TkzkN+oz3Pn2cqYjBSUtXogA5QDLvcoqgoNESO5OALKcVKunZ5BNPhAn9OKgoB4
         J+T2sBUxdpcZpAOJxcBhw9LmGzLnIsuD+ImGdOHtBunOYmz3lYKdbYyejff7ZcgAY+bw
         LkIsBZ92PhyspTXo6Srnts7ZiMcO5R56TMmQyT+qGF9OZiSEqCGgJ+PxI8h7Z558UBj6
         jezwKhML1nM20ptbwlF2YOAHFlYT6yTh+fwWxDjDUZPX+xMMV3RGMZbEdfxD9ZOujRmy
         o2HXcwknMXLTfXxJIbeKJlOkDTI9wxjXOB2dwo3wGGsHwPRjtPmqZPYbDHLdJ6B/OUGH
         gjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDsKqyepeY63ocyMIwF8lZiaR+pOTU94INwLNWf/i/Q=;
        b=bWJlasotBoEzKCyg9K+LlLGYtzRY/Bo3mBCIIFjpTyk0XauVB/cjCHPOq0TLqzLpD1
         DNhNkKgtCSmQSR50j7LUPGxV12yDicsRtcncrATpyNhDHS1GUUv9Eqoy93j/2vA35lN+
         rgaKtqLqBvMzIP6imnxfXF0+zhEQPorKUxgejq9vENCpBmFNpN6Psl0LBHa22UfTdnVV
         eZzAi4BnBHlM8s9WMOVSG2Q8P8nC31ntjA0lIzgtaF5vHNm1sa89DnpAkBVwHe8fhGIY
         detAzsJnADOe/5jBN9ZPBMBBfaKoFFwZ5evow/ljYZ2PeJkBnF3KuXJfQlATO8zBaUuV
         Hswg==
X-Gm-Message-State: AO0yUKXGcndABTsf/+TX54YCJ2DDRMjawd1ItXhITZs9OYpMHyC8L19N
        rdesbn0Bc3JqLMxZ1Jkrcr3s1ehivttEdU2C5NP7vw==
X-Google-Smtp-Source: AK7set87heiUfKYTTgXopGPXqNCq9oqyYQ7M4JyNrCHVP6v7DUboxKAd6easHm0O08SmEKEthX056v5+58w841VaRu0=
X-Received: by 2002:a05:6102:3237:b0:3f4:eee1:d8c4 with SMTP id
 x23-20020a056102323700b003f4eee1d8c4mr514404vsf.19.1675067731131; Mon, 30 Jan
 2023 00:35:31 -0800 (PST)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-11-glider@google.com>
 <CANpmjNOYqXSw5+Sxt0+=oOUQ1iQKVtEYHv20=sh_9nywxXUyWw@mail.gmail.com>
 <CAG_fn=W2EUjS8AX1Odunq1==dV178s_-w3hQpyrFBr=Auo-Q-A@mail.gmail.com> <63b74a6e6a909_c81f0294a5@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <63b74a6e6a909_c81f0294a5@dwillia2-xfh.jf.intel.com.notmuch>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 30 Jan 2023 09:34:54 +0100
Message-ID: <CAG_fn=XNfrpTxWYYLnG5L-ogKmxvWvLGTzgqbT7sWxnFgnu7_w@mail.gmail.com>
Subject: Re: [PATCH v4 10/45] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Marco Elver <elver@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 5, 2023 at 11:09 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Alexander Potapenko wrote:
> > (+ Dan Williams)
> > (resending with patch context included)
> >
> > On Mon, Jul 11, 2022 at 6:27 PM Marco Elver <elver@google.com> wrote:
> > >
> > > On Fri, 1 Jul 2022 at 16:23, Alexander Potapenko <glider@google.com> wrote:
> > > >
> > > > KMSAN adds extra metadata fields to struct page, so it does not fit into
> > > > 64 bytes anymore.
> > >
> > > Does this somehow cause extra space being used in all kernel configs?
> > > If not, it would be good to note this in the commit message.
> > >
> > I actually couldn't verify this on QEMU, because the driver never got loaded.
> > Looks like this increases the amount of memory used by the nvdimm
> > driver in all kernel configs that enable it (including those that
> > don't use KMSAN), but I am not sure how much is that.
> >
> > Dan, do you know how bad increasing MAX_STRUCT_PAGE_SIZE can be?
>
> Apologies I missed this several months ago. The answer is that this
> causes everyone creating PMEM namespaces on v6.1+ to lose double the
> capacity of their namespace even when not using KMSAN which is too
> wasteful to tolerate. So, I think "6e9f05dc66f9 libnvdimm/pfn_dev:
> increase MAX_STRUCT_PAGE_SIZE" needs to be reverted and replaced with
> something like:
>
> diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
> index 79d93126453d..5693869b720b 100644
> --- a/drivers/nvdimm/Kconfig
> +++ b/drivers/nvdimm/Kconfig
> @@ -63,6 +63,7 @@ config NVDIMM_PFN
>         bool "PFN: Map persistent (device) memory"
>         default LIBNVDIMM
>         depends on ZONE_DEVICE
> +       depends on !KMSAN
>         select ND_CLAIM
>         help
>           Map persistent memory, i.e. advertise it to the memory
>

Looks like we still don't have a resolution for this problem.
I have the following options in mind:

1. Set MAX_STRUCT_PAGE_SIZE to 80 (i.e. increase it by 2*sizeof(struct
page *) added by KMSAN) instead of 128.
2. Disable storing of struct pages on device for KMSAN builds.

, but if those are infeasible, we can always go for:

3. Disable KMSAN for NVDIMM and reflect it in Documentation. I am
happy to send the patch if we decide this is the best option.
