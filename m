Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840F74E7406
	for <lists+linux-arch@lfdr.de>; Fri, 25 Mar 2022 14:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346495AbiCYNRa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Mar 2022 09:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346155AbiCYNR3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Mar 2022 09:17:29 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D57FBD2FB
        for <linux-arch@vger.kernel.org>; Fri, 25 Mar 2022 06:15:51 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id e203so5150383ybc.12
        for <linux-arch@vger.kernel.org>; Fri, 25 Mar 2022 06:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UVtmrpcYjsoxSNLprgvqR2q01AjSQZrSDBr9I2ujCrQ=;
        b=QunYh1X/vTWnm4E2/+QnA1pxI/i0Uo9LkqQfRz546sb9EOHXd8Vt+ShyU5kgd8ShBt
         peD0c61RkIzaxF0G9jkb/arKNspB0OeVJLspXCh/mJFP/m5gcxMksfvptI8eN7Jf4C4R
         1TQqwv9UubymjB2lHqOrLGPPBPluo2Ey1TYWiXGKeayHXMgiLpaxS7w2nY9AnyhGLRKi
         Gql3YU231CDmpycokTqC7ylPkkLOBeZz9uBhRfndabW/olS8mFGJzcH78T6CmCTAEo/5
         9lNcyGHWMvRMA69qw2qeBbMJ+zdBwV6V8e9Be99rMPwACAm6BLQYemx1tZNY6AN99z5+
         h8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UVtmrpcYjsoxSNLprgvqR2q01AjSQZrSDBr9I2ujCrQ=;
        b=XL3c9B0lherkDseg9NgZCbL+TcZG2KEdFkUKYZ8dq7sD2i6ETKpeykZPh4A+zmlWJv
         01SwsxdTYPztuNg14hOj+CHGh//H/6r/h2kzvLM7Kd0/1WyKrzmtK6aWm3gverCNA9r9
         4Wu0Pucmip5JMsaC7cKNWXQSIXayxth5FumBkvrgG8hzr2D8Tu2JdsHQ5d6ABsMG7FlS
         DTartkfrGrwJbaRWooINBAHhbCXlraQzUeZz1gsQ1T0naqv92291ghS29EAINF1Co9Ne
         wT5speHX/GzR+/E3s9UI/zeL9G75zIWzdxKmQJXm5aYq12nH5r0SZPp/Zir7VODswIoj
         XxPA==
X-Gm-Message-State: AOAM530+H0/u5+06ZA+52QNwNrHxXw2rrui210UZwiaBlPU/jlgkZE4x
        OOEQdzH0QIIMda5AWOpdhKFXOIOm+YP/NPEwRmyzpQ==
X-Google-Smtp-Source: ABdhPJw8jLmmkYMWCtGyb9SAEyWAmdLtUxmnI6j62OH72T/JezNOHDJSuka8BG+J+OQWwYh7kxgvHCtXaMopGrq5oY0=
X-Received: by 2002:a25:3750:0:b0:634:6b89:ca9f with SMTP id
 e77-20020a253750000000b006346b89ca9fmr9903674yba.363.1648214150074; Fri, 25
 Mar 2022 06:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211214162050.660953-1-glider@google.com> <20211214162050.660953-17-glider@google.com>
 <82de6739-a070-695b-bbc8-dfa931aa5e00@suse.cz>
In-Reply-To: <82de6739-a070-695b-bbc8-dfa931aa5e00@suse.cz>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 25 Mar 2022 14:15:13 +0100
Message-ID: <CAG_fn=UpzHLvmdsfTTet=j54N=HwYNn_z-n4GdqgBGhYb8eNEQ@mail.gmail.com>
Subject: Re: [PATCH 16/43] kmsan: mm: call KMSAN hooks from SLUB code
To:     Vlastimil Babka <vbabka@suse.cz>
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
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

> >  static inline void *get_freepointer(struct kmem_cache *s, void *object)
> >  {
> >       object = kasan_reset_tag(object);
> > -     return freelist_dereference(s, object + s->offset);
> > +     return kmsan_init(freelist_dereference(s, object + s->offset));
>
> ... but I don't see why it applies to get_freepointer() too? What am I missing?

Agreed, kmsan_init() is not needed here.

> >  }
> >
> >  static void prefetch_freepointer(const struct kmem_cache *s, void *object)
> > @@ -357,18 +361,28 @@ static void prefetch_freepointer(const struct kmem_cache *s, void *object)
> >       prefetchw(object + s->offset);
> >  }
> >
> > +/*
> > + * When running under KMSAN, get_freepointer_safe() may return an uninitialized
> > + * pointer value in the case the current thread loses the race for the next
> > + * memory chunk in the freelist. In that case this_cpu_cmpxchg_double() in
> > + * slab_alloc_node() will fail, so the uninitialized value won't be used, but
> > + * KMSAN will still check all arguments of cmpxchg because of imperfect
> > + * handling of inline assembly.
> > + * To work around this problem, use kmsan_init() to force initialize the
> > + * return value of get_freepointer_safe().
> > + */
> >  static inline void *get_freepointer_safe(struct kmem_cache *s, void *object)
> >  {
> >       unsigned long freepointer_addr;
> >       void *p;
> >
> >       if (!debug_pagealloc_enabled_static())
> > -             return get_freepointer(s, object);
> > +             return kmsan_init(get_freepointer(s, object));
>
> So here kmsan_init() is done twice?

Yeah, removing it from get_freepointer() does not introduce new
errors. I'll fix this in v2.
