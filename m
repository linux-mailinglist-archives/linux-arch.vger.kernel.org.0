Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C3F5BA915
	for <lists+linux-arch@lfdr.de>; Fri, 16 Sep 2022 11:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiIPJNX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Sep 2022 05:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiIPJNW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2022 05:13:22 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6DC6EF11
        for <linux-arch@vger.kernel.org>; Fri, 16 Sep 2022 02:13:21 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3457bc84d53so252816007b3.0
        for <linux-arch@vger.kernel.org>; Fri, 16 Sep 2022 02:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=St+IQCWJacJKbPUwjmk2zZiPvZUfUUJhCu0g3DwZrPg=;
        b=Tq8+3NsAcC3hZkWZbN2XInttxNbHcPBxQHaxd6kqBbQ+vcToc+f9RVGIsc931BWVYv
         4QDsKLv0z+ustpPusPz/B9AlixdY/+20yLQ3Nb+Fa7rupRd0naGOVpYYufmEQtlM5DII
         sx51DqRcgBgYykDI/ks3MxB7qjaAYnoqogbo/7wSk2d8PHFC9DklV/sGJpb1YdiGvdgE
         cPjNWVgiTi2YeBUpLJNpIVMferIDI3FBXMUngw00uukIFnVZglD7gSlfWfoPoLRHl1sl
         niGM24A+pcobtBMSFxFNvKxFgeoq4A8ILvrdqwFIbIlpjTDArgzldYkHsYo+IATVq7eN
         72WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=St+IQCWJacJKbPUwjmk2zZiPvZUfUUJhCu0g3DwZrPg=;
        b=gqwKqMLJDg5JrHrPd1twOaNrmb+VpW39Rwqr207hMiCU5e4OO2HR6NsTekiiIkg+vi
         6MBdgse+FUTQY9B0pehGaLm/U1X+2TAhni8bhA0KTbWeur2hBScUeLF4tjFKrWCUJm2c
         WH3fT1nyOQKjwDQIsshHevKs69bmgva5KV4y9k1D4lUrEZwPV1yARYD0V+Pdqa+K7pXS
         Sp4GgDVhuqbO+bgHzf5H+V8dxiQLHERM4ciFVWtu/kpZ58TB4Ozk8W7q3pg1TootXjCV
         IfCXoXYJxvGV2+VYh06GdyHXTYGN2jTLe63TBH6TFj/pZ4P61wd8/oEQwtpTyACcEV7f
         bpPw==
X-Gm-Message-State: ACrzQf2XvdiD6+GTYBrsB32fNvgnHKpiWNn4bzNWWArG02eVGxgCE7HB
        LZB6wF3EBDH3Y3TnuTZxYaXlFuUQIrRFYTP96DBPeA==
X-Google-Smtp-Source: AMsMyM6QGrLkBXMbfIPe1G5TGsi0HWQVWE4tx9McXMeIqkGsZpi9tdQNue2OLJQyPpOK052xbeGm8HDCACIsAHD0xIk=
X-Received: by 2002:a81:1409:0:b0:349:e8bb:1fdb with SMTP id
 9-20020a811409000000b00349e8bb1fdbmr3573010ywu.299.1663319600558; Fri, 16 Sep
 2022 02:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220915150417.722975-1-glider@google.com> <20220915150417.722975-28-glider@google.com>
 <20220915135838.8ad6df0363ccbd671d9641a1@linux-foundation.org>
In-Reply-To: <20220915135838.8ad6df0363ccbd671d9641a1@linux-foundation.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 16 Sep 2022 11:12:44 +0200
Message-ID: <CAG_fn=WJZBK_xypJ-D7NPjGeaQ8c3fs8Ji+-j+=O=9neZjTUBw@mail.gmail.com>
Subject: Re: [PATCH v7 27/43] kmsan: disable physical page merging in biovec
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
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

On Thu, Sep 15, 2022 at 10:58 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Thu, 15 Sep 2022 17:04:01 +0200 Alexander Potapenko <glider@google.com=
> wrote:
>
> > KMSAN metadata for adjacent physical pages may not be adjacent,
> > therefore accessing such pages together may lead to metadata
> > corruption.
> > We disable merging pages in biovec to prevent such corruptions.
> >
> > ...
> >
> > --- a/block/blk.h
> > +++ b/block/blk.h
> > @@ -88,6 +88,13 @@ static inline bool biovec_phys_mergeable(struct requ=
est_queue *q,
> >       phys_addr_t addr1 =3D page_to_phys(vec1->bv_page) + vec1->bv_offs=
et;
> >       phys_addr_t addr2 =3D page_to_phys(vec2->bv_page) + vec2->bv_offs=
et;
> >
> > +     /*
> > +      * Merging adjacent physical pages may not work correctly under K=
MSAN
> > +      * if their metadata pages aren't adjacent. Just disable merging.
> > +      */
> > +     if (IS_ENABLED(CONFIG_KMSAN))
> > +             return false;
> > +
> >       if (addr1 + vec1->bv_len !=3D addr2)
> >               return false;
> >       if (xen_domain() && !xen_biovec_phys_mergeable(vec1, vec2->bv_pag=
e))
>
> What are the runtime effects of this?  In other words, how much
> slowdown is this likely to cause in a reasonable worst-case?

To be honest, I have no idea. KMSAN already introduces a lot of
runtime overhead to every memory access, it's unlikely that disabling
some filesystem optimization will add anything on top of that.
Anyway, KMSAN is a debugging tool that is not supposed to be used in
production (there's a big boot-time warning about that now :) )

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
