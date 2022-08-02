Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7925882F2
	for <lists+linux-arch@lfdr.de>; Tue,  2 Aug 2022 22:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiHBUIX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Aug 2022 16:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiHBUIV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Aug 2022 16:08:21 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E6552458
        for <linux-arch@vger.kernel.org>; Tue,  2 Aug 2022 13:08:19 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 7so25304317ybw.0
        for <linux-arch@vger.kernel.org>; Tue, 02 Aug 2022 13:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=0+45JLGnZfMHQQnDGOsiLF2twVwamYBrdFCbJu2NgIA=;
        b=jpPabckjsg0UsINT16ut9CdYerI58dLxrYvNEnswsOppm4SLNq927fz87yfpCaH5ax
         KCdBZVYZC28pn0Xy8fByE9dMhE8wzQotEbagoddzKwnhmnvTYqWbLwoaqdiRvLKYznys
         CDLFtlDEGzvhUJHY3YQ4kD6DifvKKLm9tOWmjDF+AGteoYwqr8Gj9xSmKj0lQf94Dano
         Puw4nNrcbkvpOKbaNJx5xdJXYf8omQ37KoH6c170mgLLZqbp5mz0WBiwi4EYEeWreMm1
         OZXxLAx2HCduvRAgAu+IL/1sB/WSkbDh8Yb6i+wC9qhoOFawUusYA9OF2v2VSChbKYhR
         WwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=0+45JLGnZfMHQQnDGOsiLF2twVwamYBrdFCbJu2NgIA=;
        b=ZIDpZEixrWauOkrISK9ZA+0Qz/EqP3ZTEx6d9u3Uem9NYETBhE/s2K3LWX11CjnkLW
         GuH7rzbTMz8AwB0Dt+aqjaunRRrkCQjujrmF/NsZ3IYKO1uqLLGE8tNfMnJS7z88JkK/
         CBidKaQOomTiCIOCOOkHYBVk1VOwBgL2dKTpzhmkgLH6eE+CP+wKMYIxpYEMBZ4P1iIG
         JLHmh1NQ1HKlFzYvtBmuC65jcEgUb+v62OcmB9BD82ZVTO27YqoAfJZ02m1Tqfete22G
         6mQewsvP/qO8tksZjV2ifqo8p1senhPkihUOSZrQPF2jZwW0xabzgyOyzuFIpk43HOAk
         PDww==
X-Gm-Message-State: ACgBeo1bJ3e2EoEPexInJvXni9YyXXOR/miWLMwpXP+qdFhQidpzsuMr
        TxpYVXE9O/wujt+bQNOMC8W7vL846VVzUajBe8UwHw==
X-Google-Smtp-Source: AA6agR6Xa8GLqLWKTmOgcXYKSoHfDZeq+GqS1CWYb5caYG2+9D4u6ak/0xp4JW7TREtw//VymY38BERkomb7kpPmXOI=
X-Received: by 2002:a25:bc3:0:b0:673:bc78:c095 with SMTP id
 186-20020a250bc3000000b00673bc78c095mr16344277ybl.376.1659470898706; Tue, 02
 Aug 2022 13:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-18-glider@google.com>
 <CANpmjNNh0SP53s0kg_Lj2HUVnY_9k_grm==q4w6Bbq4hLmKtHA@mail.gmail.com>
In-Reply-To: <CANpmjNNh0SP53s0kg_Lj2HUVnY_9k_grm==q4w6Bbq4hLmKtHA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 2 Aug 2022 22:07:42 +0200
Message-ID: <CAG_fn=ViHiYCWj0jmm1R=gSX0880-rQ-CA3VaEjiLnGkDN1G4w@mail.gmail.com>
Subject: Re: [PATCH v4 17/45] init: kmsan: call KMSAN initialization routines
To:     Marco Elver <elver@google.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 12, 2022 at 4:05 PM Marco Elver <elver@google.com> wrote:
>

> > +/**
> > + * kmsan_task_exit() - Notify KMSAN that a task has exited.
> > + * @task: task about to finish.
> > + */
> > +void kmsan_task_exit(struct task_struct *task);
>
> Something went wrong with patch shuffling here I think,
> kmsan_task_create + kmsan_task_exit decls are duplicated by this
> patch.
Right, I've messed it up. Will fix.

> > +
> > +struct page_pair {
>
> 'struct shadow_origin_pages' for a more descriptive name?
How about "metadata_page_pair"?

> > + * At the very end there may be leftover blocks in held_back[]. They a=
re
> > + * collected later by kmsan_memblock_discard().
> > + */
> > +bool kmsan_memblock_free_pages(struct page *page, unsigned int order)
> > +{
> > +       struct page *shadow, *origin;
>
> Can this just be 'struct page_pair'?

Not sure this is worth it. We'll save one line by assigning this
struct to held_back[order], but the call to kmsan_setup_meta() will
become more verbose.
(and passing a struct page_pair to kmsan_setup_meta() looks excessive).


> > +                     struct page *origin, int order)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < (1 << order); i++) {
>
> Noticed this in many places, but we can just make these "for (int i =3D..=
" now.
Fixed here and all over the runtime.

> > @@ -1731,6 +1731,9 @@ void __init memblock_free_pages(struct page *page=
, unsigned long pfn,
> >  {
> >         if (early_page_uninitialised(pfn))
> >                 return;
> > +       if (!kmsan_memblock_free_pages(page, order))
> > +               /* KMSAN will take care of these pages. */
> > +               return;
>
> Add {} because the then-statement is not right below the if.

Done.

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
