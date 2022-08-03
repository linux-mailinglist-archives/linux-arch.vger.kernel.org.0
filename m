Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6284D588AC8
	for <lists+linux-arch@lfdr.de>; Wed,  3 Aug 2022 12:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbiHCKxA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Aug 2022 06:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbiHCKw7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Aug 2022 06:52:59 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7FF1B79C
        for <linux-arch@vger.kernel.org>; Wed,  3 Aug 2022 03:52:58 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-324293f1414so132679927b3.0
        for <linux-arch@vger.kernel.org>; Wed, 03 Aug 2022 03:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=LqDMaGMw0T+ovR4GLNrEVT1Q3GLoKKe4dcxLcnnMrZA=;
        b=YKAJ6QXbZIhkT3Xmd6FWvDPkFho7Hjuv/Wh58jcWd+I9G2elpkGAgN4forWLLDQRy4
         QPdPlGnQ5e5hlv3bEG8vZsrzYAtkMLhw75chtHIrnki8zO1lbRhWYL7hB4JbKCGwkUHa
         8gGr8QlAfaY9Os415IOARJlFy7NJKZxjv7aicl0cobhRLd3POHojWXbJWf9EucirB+Ca
         IL4700Mkm2XUSEH/yqV4fnafLcPE414CO9RDkAz1Wwv5aSJo4xEstCmnnz+PdTERyaTU
         ksuehVQ/NWbNNtZwBmVJ6Q8pRB4gpeB9ijAqdYJAopGxK9geWEKNwQpT9zSrGk6Mdpsp
         hPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=LqDMaGMw0T+ovR4GLNrEVT1Q3GLoKKe4dcxLcnnMrZA=;
        b=ix+FlW67Xs5+paOQBWPz4ZyRoiXnWs2CAnv+BtSht8vm/srnyN4yMHWY1peAUN0vFl
         oi4nSdLryauE+VVjS5JGYnhJrRcu17kIyOYXFFEzpfYNwp5UMsRqPvnBlzYaCY9CJo8t
         MnjlfKZItn1O4GtC5k7phyHt4pBk5MwcB+XFRsKn2TBsxgIJmIz2MUTf//2Dr1W6zWe/
         bcQoPyEhZeqBM7Hx32iTSs6iavuKGuj9MCxHOBRXGHtYPp6OdL5TVnr78y+P5NfcTIBC
         BTve/ubg+b2Lb6WJTZ0koQ1EOC6XP7SRLqDi/4T3D5JB8m+KQL0eV5MSAHKnxzSZrB4H
         80xA==
X-Gm-Message-State: ACgBeo3cwCId6JJ0yTsCRBM2UOjKf+iY1lVlRav+Nf/ZO3+1BwftOlxG
        LxXuuiPgUP+Ko+M789YB58IbdDWvAZdWWhcXv1JuEw==
X-Google-Smtp-Source: AA6agR5WAGq9D89DtPNI5QF8vsk8Az038NQPg4OdgRIxIEyXWMSOCAA7pV513VpmDmKIEks58MaUiTi/I61PQxYwaRU=
X-Received: by 2002:a0d:c7c3:0:b0:31e:9622:c4f6 with SMTP id
 j186-20020a0dc7c3000000b0031e9622c4f6mr22504287ywd.144.1659523978073; Wed, 03
 Aug 2022 03:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-34-glider@google.com>
 <CANpmjNMpCow-pwqQnw8aHRUZKuBcOUU4On=JgEgysT8SBTrz6g@mail.gmail.com>
In-Reply-To: <CANpmjNMpCow-pwqQnw8aHRUZKuBcOUU4On=JgEgysT8SBTrz6g@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 3 Aug 2022 12:52:21 +0200
Message-ID: <CAG_fn=Xf_VTgYPk8Bnk2Kc9JCArnaRUO-kKFREh6rDpqC3t1eg@mail.gmail.com>
Subject: Re: [PATCH v4 33/45] x86: kmsan: disable instrumentation of
 unsupported code
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 12, 2022 at 3:44 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, 1 Jul 2022 at 16:24, 'Alexander Potapenko' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> [...]
> > ---
> >  arch/x86/boot/Makefile            | 1 +
> >  arch/x86/boot/compressed/Makefile | 1 +
> >  arch/x86/entry/vdso/Makefile      | 3 +++
> >  arch/x86/kernel/Makefile          | 2 ++
> >  arch/x86/kernel/cpu/Makefile      | 1 +
> >  arch/x86/mm/Makefile              | 2 ++
> >  arch/x86/realmode/rm/Makefile     | 1 +
> >  lib/Makefile                      | 2 ++
> [...]
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -272,6 +272,8 @@ obj-$(CONFIG_POLYNOMIAL) +=3D polynomial.o
> >  CFLAGS_stackdepot.o +=3D -fno-builtin
> >  obj-$(CONFIG_STACKDEPOT) +=3D stackdepot.o
> >  KASAN_SANITIZE_stackdepot.o :=3D n
> > +# In particular, instrumenting stackdepot.c with KMSAN will result in =
infinite
> > +# recursion.
> >  KMSAN_SANITIZE_stackdepot.o :=3D n
> >  KCOV_INSTRUMENT_stackdepot.o :=3D n
>
> This is generic code and not x86, should it have been in the earlier patc=
h?
Ack.


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
