Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45701565C66
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 18:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiGDQtw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 12:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbiGDQs7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 12:48:59 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E5F1104
        for <linux-arch@vger.kernel.org>; Mon,  4 Jul 2022 09:48:22 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id e80so10537486ybb.4
        for <linux-arch@vger.kernel.org>; Mon, 04 Jul 2022 09:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L5bopA3LB1XHVOlLQfcH6XEn+sIBVPJTuLNRtswn9CI=;
        b=c/CZzhgWMX3bbr5O6IqvVMfoZnAyutFGHBtOJxvRVUCpPzJ6Vh/OEsX9ddjDryLKuA
         JXrDh2Q0dZwecqh0Bc1ZmIHbvHv5ZYlF/3Cy4pp59N/hZZc+g6AzKwqaEjKE9n+w0L4P
         SGtbVNdzX60In90tk3zR5kKxLS65szG0+ctLVOkHwz7kJpsy0qBpVQiDktlwX2NIU037
         thbcpaGonmo+7T5qn/XqJZ7ApfK4ca3IKZojcWMlCA/qfHccaJFH1GvI7//8OsazLSHT
         DXnwVJ0N1MqLa9SonmmKK11lHhIqIejowfQl2WAJ84B2obL74Vlq/wGy/lbvhUw3aJva
         YrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L5bopA3LB1XHVOlLQfcH6XEn+sIBVPJTuLNRtswn9CI=;
        b=lrHtwJ3zoNcULPFimIXIRl28+p64KNW8zvytMk4ZH0bm7CHbQ7KvBfJLVom2Dt5xWw
         LnlPhilJBwe8W8LBAYhFOsymmBBU3jlesJtUCMoqWR3IS1zrCD1V5+rHxeMVkoOyw0yc
         i1F1Tzbg5hOL/iO+lXrseGUiPEQBExrffH9W20M6YduaCTpkNnHgJyWp19b+Mt/STVb/
         RI/92RLpc4mneq/lMth9rW/uuWl95Qy7gPp5MBX1tq4XU2RCZWjYMyoqguCYRd1Xz7dG
         jUq25AhHT5v6WYIQXjRro3CvllvixNCJyCQgtpzbSv0GJETOnqmM455KKkrU+MgTOZK+
         oplQ==
X-Gm-Message-State: AJIora/WGiHY8SgBaZyqmMRSeSfpp6Jst/LCkII6y+4o123JkhyZOQE0
        J3B8Rpe3pdZv4izMtH9Pu85LZ8nQwZNc6YMnBHbvLA==
X-Google-Smtp-Source: AGRyM1tLdo0rneMsHOCy50i0zEQc7jDRMizVYynxVyfcFXLv8SFU3m/8JPgrZi7jMpqg3yqU/ifuk0aRSs6UyJ9TJfg=
X-Received: by 2002:a25:a345:0:b0:66c:c670:6d13 with SMTP id
 d63-20020a25a345000000b0066cc6706d13mr33311155ybi.307.1656953301274; Mon, 04
 Jul 2022 09:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-44-glider@google.com>
 <CAHk-=wgbpot7nt966qvnSR25iea3ueO90RwC2DwHH=7ZyeZzvQ@mail.gmail.com>
 <YsJWCREA5xMfmmqx@ZenIV> <CAG_fn=V_vDVFNSJTOErNhzk7n=GRjZ_6U6Z=M-Jdmi=ekbS5+g@mail.gmail.com>
 <YsLuoFtki01gbmYB@ZenIV> <YsMOkXpp2HaOnVJN@ZenIV>
In-Reply-To: <YsMOkXpp2HaOnVJN@ZenIV>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 4 Jul 2022 18:47:45 +0200
Message-ID: <CAG_fn=Vbq59-zDG=JdOi3DXh29tXNRNQhPJ3PxTZBiY7Ph=Jug@mail.gmail.com>
Subject: Re: [PATCH v4 43/45] namei: initialize parameters passed to step_into()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
        Marco Elver <elver@google.com>,
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
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Vitaly Buka <vitalybuka@google.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
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

On Mon, Jul 4, 2022 at 6:00 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Jul 04, 2022 at 02:44:00PM +0100, Al Viro wrote:
> > On Mon, Jul 04, 2022 at 10:20:53AM +0200, Alexander Potapenko wrote:
> >
> > > What makes you think they are false positives? Is the scenario I
> > > described above:
> > >
> > > """
> > > In particular, if the call to lookup_fast() in walk_component()
> > > returns NULL, and lookup_slow() returns a valid dentry, then the
> > > `seq` and `inode` will remain uninitialized until the call to
> > > step_into()
> > > """
> > >
> > > impossible?
> >
> > Suppose step_into() has been called in non-RCU mode.  The first
> > thing it does is
> >       int err =3D handle_mounts(nd, dentry, &path, &seq);
> >       if (err < 0)
> >               return ERR_PTR(err);
> >
> > And handle_mounts() in non-RCU mode is
> >       path->mnt =3D nd->path.mnt;
> >       path->dentry =3D dentry;
> >       if (nd->flags & LOOKUP_RCU) {
> >               [unreachable code]
> >       }
> >       [code not touching seqp]
> >       if (unlikely(ret)) {
> >               [code not touching seqp]
> >       } else {
> >               *seqp =3D 0; /* out of RCU mode, so the value doesn't mat=
ter */
> >       }
> >       return ret;
> >
> > In other words, the value seq argument of step_into() used to have ends=
 up
> > being never fetched and, in case step_into() gets past that if (err < 0=
)
> > that value is replaced with zero before any further accesses.
> >
> > So it's a false positive; yes, strictly speaking compiler is allowd
> > to do anything whatsoever if it manages to prove that the value is
> > uninitialized.  Realistically, though, especially since unsigned int
> > is not allowed any trapping representations...
>
> FWIW, update (and yet untested) branch is in #work.namei.  Compared to th=
e
> previous, we store sampled ->d_seq of the next dentry in nd->next_seq,
> rather than bothering with local variables.  AFAICS, it ends up with
> better code that way.  And both ->seq and ->next_seq are zeroed at the
> moments when we switch to non-RCU mode (as well as non-RCU path_init()).
>
> IMO it looks saner that way.  NOTE: it still needs to be tested and proba=
bly
> reordered and massaged; it's not for merge at the moment.  Current cumula=
tive
> diff follows:

I confirm all KMSAN reports are gone as a result of applying this patch.


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
