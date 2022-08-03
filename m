Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1735588998
	for <lists+linux-arch@lfdr.de>; Wed,  3 Aug 2022 11:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbiHCJpE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Aug 2022 05:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiHCJo4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Aug 2022 05:44:56 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8763C16E
        for <linux-arch@vger.kernel.org>; Wed,  3 Aug 2022 02:44:55 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-32269d60830so165937517b3.2
        for <linux-arch@vger.kernel.org>; Wed, 03 Aug 2022 02:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Y5TvyICc8d9t41nnsu7puTvMuWTSp2+6bN2hR6XdoD8=;
        b=FPrKKTFmIIrhXCK1a8bx0Gn0ZQdsswBQaJ6AcU4bdHhAv3FjPdWHeD6gFyulCFqoQf
         8Ev6qu/iHol/CbvKBcjHgoIJRJzq3MUTFoZsXmwDMcsi+Qzb+ioohmiHkQMiO584Xqcm
         3ufSvymy+GTp+Z/M7xxzl41Pr+8hzIqnNyWpVZwIQQnS8NGGru1KNkQquKQ9DH8ODztz
         nLkMaxwXBlaAiLiX+04wqiuxR8hikX1dzbdwP4lQQX314JMeqfcI9MDPPXug+QfyppfG
         a6grl/lOUGAxn6LNav8AW61Kc4S7JUpJqkDasX1rVL7l1cRykE+XrDWarl+uwQVvWPrv
         xvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Y5TvyICc8d9t41nnsu7puTvMuWTSp2+6bN2hR6XdoD8=;
        b=p07LFr85pbktp2elyJnJ+IL4UBCh8vremRqKcDiA9LcZ5G+CyqZ8Cnn8hp+cnjIRd2
         1rJ0oFLa1X89xcrkpvx3jA1b9i3NaAcbnL1u65JgZQUsc8lTZjrgvM8e1l7pVzjoW6HH
         rW6GiaHCE7slBRkHsnaWxIK3iAkjulTw9Ff7aCXdfFnTd6iv8rEofqPENXD6Z0euoIEQ
         1Dnou2KLrEwhT1Uzwv9lVe5paZ3QPelAbA2o5hjYBp45XlhGyK+auk4JrBJCV/h80fAy
         Pjzb7/iaABxKTWuc4+K2N3iInKYlRXTdy0lIkrmdnxemPMJL/LYqiGMc46TxDu/jZYSm
         Lb6g==
X-Gm-Message-State: ACgBeo2FyOL9M+0MZZCqRteHWbzc3jrDdh7F2Awgdli0x75BI6zD6rtp
        HDub3sBMa6ZM39U+mDlnLcZh8B20uU8bBdDEmwvvmw==
X-Google-Smtp-Source: AA6agR5d01Pm6wu3vbijZCaWwzO5G1sfm5AIHiHcJvlQ6r93IvYqNVc/zAhJ9di6/dSYm6ZI88xapY6TE2XXsAWQ/Ms=
X-Received: by 2002:a0d:d40d:0:b0:322:d4c0:c6f6 with SMTP id
 w13-20020a0dd40d000000b00322d4c0c6f6mr23100302ywd.428.1659519894650; Wed, 03
 Aug 2022 02:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-11-glider@google.com>
 <CANpmjNOYqXSw5+Sxt0+=oOUQ1iQKVtEYHv20=sh_9nywxXUyWw@mail.gmail.com>
In-Reply-To: <CANpmjNOYqXSw5+Sxt0+=oOUQ1iQKVtEYHv20=sh_9nywxXUyWw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 3 Aug 2022 11:44:18 +0200
Message-ID: <CAG_fn=W2EUjS8AX1Odunq1==dV178s_-w3hQpyrFBr=Auo-Q-A@mail.gmail.com>
Subject: Re: [PATCH v4 10/45] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
To:     Marco Elver <elver@google.com>,
        Dan Williams <dan.j.williams@intel.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

(+ Dan Williams)
(resending with patch context included)

On Mon, Jul 11, 2022 at 6:27 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, 1 Jul 2022 at 16:23, Alexander Potapenko <glider@google.com> wrot=
e:
> >
> > KMSAN adds extra metadata fields to struct page, so it does not fit int=
o
> > 64 bytes anymore.
>
> Does this somehow cause extra space being used in all kernel configs?
> If not, it would be good to note this in the commit message.
>
I actually couldn't verify this on QEMU, because the driver never got loade=
d.
Looks like this increases the amount of memory used by the nvdimm
driver in all kernel configs that enable it (including those that
don't use KMSAN), but I am not sure how much is that.

Dan, do you know how bad increasing MAX_STRUCT_PAGE_SIZE can be?

>
> > Signed-off-by: Alexander Potapenko <glider@google.com>
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> > ---
> > Link: https://linux-review.googlesource.com/id/I353796acc6a850bfd7bb342=
aa1b63e616fc614f1
> > ---
> >  drivers/nvdimm/nd.h       | 2 +-
> >  drivers/nvdimm/pfn_devs.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> > index ec5219680092d..85ca5b4da3cf3 100644
> > --- a/drivers/nvdimm/nd.h
> > +++ b/drivers/nvdimm/nd.h
> > @@ -652,7 +652,7 @@ void devm_namespace_disable(struct device *dev,
> >                 struct nd_namespace_common *ndns);
> >  #if IS_ENABLED(CONFIG_ND_CLAIM)
> >  /* max struct page size independent of kernel config */
> > -#define MAX_STRUCT_PAGE_SIZE 64
> > +#define MAX_STRUCT_PAGE_SIZE 128
> >  int nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)=
;
> >  #else
> >  static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
> > diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> > index 0e92ab4b32833..61af072ac98f9 100644
> > --- a/drivers/nvdimm/pfn_devs.c
> > +++ b/drivers/nvdimm/pfn_devs.c
> > @@ -787,7 +787,7 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
> >                  * when populating the vmemmap. This *should* be equal =
to
> >                  * PMD_SIZE for most architectures.
> >                  *
> > -                * Also make sure size of struct page is less than 64. =
We
> > +                * Also make sure size of struct page is less than 128.=
 We
> >                  * want to make sure we use large enough size here so t=
hat
> >                  * we don't have a dynamic reserve space depending on
> >                  * struct page size. But we also want to make sure we n=
otice
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
