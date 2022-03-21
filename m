Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2A94E2A6E
	for <lists+linux-arch@lfdr.de>; Mon, 21 Mar 2022 15:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242756AbiCUOZB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 10:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350373AbiCUOVA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 10:21:00 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8357C17709A
        for <linux-arch@vger.kernel.org>; Mon, 21 Mar 2022 07:13:35 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id i4so11952037qti.7
        for <linux-arch@vger.kernel.org>; Mon, 21 Mar 2022 07:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SpcQ2fQs0B6gsc0zmrC1AWzw07HBH7voJSyZVgn+CmY=;
        b=YMmPb6ufUoPO1xJawFqx/pw7tcukS4GdHAOpTMI6TNm1HeyLUsenwKkAlmFC5sskS9
         G+wNHb8XVZRirIOXD5IKpxnzUczJMsQkb3lb26bM4xIpkG0BSfd+K9hOZug87/lkap3n
         loetXdhMOO4esSZ12p6xttO72PGLNa5Hjolu+3w+yQPa2P/PJi6jx/BzjMHrk3CRVets
         x7Dsj4N9NW7rj0axqNTcVj/HX2wMlYDfqvxQ/+uge9Lm786bX2wDZMSBj82IRVskN39c
         UY8Q8tqzp7am3VQ1xUTUHBNkExHsBO5n5rJvr14CodpI8BFubxJhna6n/VaZsQlP+qru
         6A0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SpcQ2fQs0B6gsc0zmrC1AWzw07HBH7voJSyZVgn+CmY=;
        b=xZODZnWevRMwoY62X45j90YV39A+/1uxAuGAuUNK8AyWovrlTnRUInJelZwCo2hVLI
         ChF0Q/R4gh9o2N0MdQPezdVrw73r061Z9kWVi90tQkbO/JG5I7Pakoi2GrkIH/j9Db6d
         8GqlN/uis0kF9Xz2tAt1wS0ivTY/q0b11HY9wCju+oTLrW2j6epHtKW183qthWOiSEgN
         ZzZQBgATMQWq29NYcadan1I8ltS+Bz4haWpdTlxfohHBtytKUkizCGh0uuPf+q5GzkXx
         kRwagGQwZnl81RvBEiL8cRmDqlMLMwqsMd/BSN4TMjQAO1iLFZKYsE9wIxvoYUoEFPbE
         hK4Q==
X-Gm-Message-State: AOAM533731rrYJW32kWqYOh28CK3NPFHNBcyaH3ajIidYSo8ZybtnFhx
        p+P8Zb03ZDr2wfpxf7eLY2UpQHWpn8kYjdlayksJzQ==
X-Google-Smtp-Source: ABdhPJyWAH+sDRJ270zMfxco+YyNWJFwLR4+S6xqqYj7oSaBnbkhA+KnL9o9TtC8VsgFFIuLqvJvGIdWalshA80NzoM=
X-Received: by 2002:a05:622a:1709:b0:2e1:2cbd:6139 with SMTP id
 h9-20020a05622a170900b002e12cbd6139mr16332484qtk.578.1647872011635; Mon, 21
 Mar 2022 07:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211214162050.660953-1-glider@google.com> <20211214162050.660953-14-glider@google.com>
 <YbjHerrHit/ZqXYs@kroah.com> <CAG_fn=XX3vbuo=cyG8C1Syv_JXiQ1rnfoffKqEc-N8uLei5T2A@mail.gmail.com>
 <Yby5Rwr0jgAcK4th@kroah.com>
In-Reply-To: <Yby5Rwr0jgAcK4th@kroah.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 21 Mar 2022 15:12:55 +0100
Message-ID: <CAG_fn=V1bCUkrE_d2hwm+XVip35pRspHzjYaXhU_PfyJE0QwoA@mail.gmail.com>
Subject: Re: [PATCH 13/43] kmsan: add KMSAN runtime core
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
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
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

> >
> > Just to make sure I don't misunderstand - for example for "kmsan: mm:
> > call KMSAN hooks from SLUB code", would it be better to pull the code
> > in mm/kmsan/core.c implementing kmsan_slab_alloc() and
> > kmsan_slab_free() into that patch?
>
> Yes.
>
> > I thought maintainers would prefer to have patches to their code
> > separated from KMSAN code, but if it's not true, I can surely fix
> > that.
>
> As a maintainer, I want to know what the function call that you just
> added to my subsystem to call does.  Wouldn't you?  Put it all in the
> same patch.

Ok, will be done in v2, thanks!

> Think about submitting a patch series as telling a story.  You need to
> show the progression forward of the feature so that everyone can
> understand what is going on.  To just throw tiny snippets at us is
> impossible to follow along with what your goal is.
>
> You want reviewers to be able to easily see if the things you describe
> being done in the changelog actually are implemented in the diff.
> Dividing stuff up by files does not show that at all.
>
> thanks,
>
> greg k-h



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherweise
erhalten haben sollten, leiten Sie diese bitte nicht an jemand anderes
weiter, l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen Sie =
mich
bitte wissen, dass die E-Mail an die falsche Person gesendet wurde.


This e-mail is confidential. If you received this communication by
mistake, please don't forward it to anyone else, please erase all
copies and attachments, and please let me know that it has gone to the
wrong person.
