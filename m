Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D374E275C
	for <lists+linux-arch@lfdr.de>; Mon, 21 Mar 2022 14:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiCUNTy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 09:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347806AbiCUNTv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 09:19:51 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDFC22BE9
        for <linux-arch@vger.kernel.org>; Mon, 21 Mar 2022 06:18:21 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id bp39so91130qtb.6
        for <linux-arch@vger.kernel.org>; Mon, 21 Mar 2022 06:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TQ5DlndeeL1f8ja+gUYUVQpHHaIrThDTIuKyf0ppDTc=;
        b=LIRTe+Eafb9scj4JV2xH2RID6I1OGtDAZhtFmMZjaSpAoscNtWTI3rrhlkkhwkAI8d
         lxNzMRzHjCGHa+i1t92Dp7lRCxzfAttZ/Q9Hg0HPkk6JdV9t8bSixip+EbBHX1VZDiO5
         pcerS60YzGYqUsQDa0b6EYqO/Bm4EtCwINiVYkhLjHAB/e8VsXliPXsV7dajsqig5Wic
         eJfMN6eE2JTFjri9e1JJ2oE3BVOrsBSmJ5UihOLHs9KxZdvLgHiDbOurrvuPLuhiLPHF
         DLJXp8tRVFiXxpnI6AYG+ojp5dmN+uYY6I1CWoRlTJm+0o1khQ3RlL+/9hKLlWRTFSQW
         9bBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TQ5DlndeeL1f8ja+gUYUVQpHHaIrThDTIuKyf0ppDTc=;
        b=xbwCz9PqkrezNw5woCmVAqOriXsMeHExpxVrJSTBxwxfizSU5yra0NQ42FiUH6us2i
         BcoQ8sMWmnvxjvAql/5xUonqViV4Aogwm4ObMx/YMs2g6gDA5SPHJXqwzYcsy0L2+3cI
         NCIwMLsCw1HB+8OeU75T/Lbm1N5KNQv37t9lJIKL4wb0NNKnL/6jsh9HnurN2ml+mVZG
         fuDk362PuqOVyEbh4bTFbdAYzn1IgHfBostPT1eUy4VGfU8uu0HVf297SNk7lQL7B9KC
         8QkHKIxL72l647J0jjMk70ct+jXb3oIcbyjrJOAokcxjMR+8r34u+xf6xrOAhvFJbuH6
         PoFg==
X-Gm-Message-State: AOAM533qsgqsHlj9MESIwpocaegRGju7NTCBJi0zNFCcrfUXk35ZiTEY
        WsVRpUQE7eIeYBkPatV4+p5e/AHZqYai9NwNduYZ1g==
X-Google-Smtp-Source: ABdhPJwVmUD3yoMMw5kXu4JqJXi4wUkn2PlRIab4lbVgU5Iae1T4ofWbeudwh+1zEUcmvCn/AbwF6c2nWPK2J/sGW+8=
X-Received: by 2002:ac8:5809:0:b0:2e1:f0bc:2e88 with SMTP id
 g9-20020ac85809000000b002e1f0bc2e88mr14516126qtg.138.1647868700564; Mon, 21
 Mar 2022 06:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211214162050.660953-1-glider@google.com> <20211214162050.660953-14-glider@google.com>
 <CACT4Y+Y_torRwzh0eDMn+pJh=YT26hGrAPA499WqN1dV+4bDHA@mail.gmail.com>
In-Reply-To: <CACT4Y+Y_torRwzh0eDMn+pJh=YT26hGrAPA499WqN1dV+4bDHA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 21 Mar 2022 14:17:44 +0100
Message-ID: <CAG_fn=WvjRCNH+F65QuuCnrmLcicz1zu0s-uu8DrmUtr0tcZ7Q@mail.gmail.com>
Subject: Re: [PATCH 13/43] kmsan: add KMSAN runtime core
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
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
Content-Transfer-Encoding: quoted-printable
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

> > +       KMSAN_WARN_ON(!src_slots || !dst_slots);
> > +       KMSAN_WARN_ON((src_slots < 1) || (dst_slots < 1));
>
> The above 2 checks look equivalent.
Right, I'll drop the first one.

> > +       KMSAN_WARN_ON((src_slots - dst_slots > 1) ||
> > +                     (dst_slots - src_slots < -1));
> > +       backwards =3D dst > src;
> > +       i =3D backwards ? min(src_slots, dst_slots) - 1 : 0;
> > +       iter =3D backwards ? -1 : 1;
> > +
> > +       align_shadow_src =3D
> > +               (u32 *)ALIGN_DOWN((u64)shadow_src, KMSAN_ORIGIN_SIZE);
> > +       for (step =3D 0; step < min(src_slots, dst_slots); step++, i +=
=3D iter) {
> > +               KMSAN_WARN_ON(i < 0);
> > +               shadow =3D align_shadow_src[i];
> > +               if (i =3D=3D 0) {
> > +                       /*
> > +                        * If |src| isn't aligned on KMSAN_ORIGIN_SIZE,=
 don't
> > +                        * look at the first |src % KMSAN_ORIGIN_SIZE| =
bytes
> > +                        * of the first shadow slot.
> > +                        */
> > +                       skip_bits =3D ((u64)src % KMSAN_ORIGIN_SIZE) * =
8;
> > +                       shadow =3D (shadow << skip_bits) >> skip_bits;
>
> Is this correct?...
> For the first slot we want to ignore some of the first (low) bits. To
> ignore low bits we need to shift right and then left, no?

Yes, you are right, I forgot about the endianness. Will try to add
some tests for this case.

> > +               }
> > +               if (i =3D=3D src_slots - 1) {
> > +                       /*
> > +                        * If |src + n| isn't aligned on
> > +                        * KMSAN_ORIGIN_SIZE, don't look at the last
> > +                        * |(src + n) % KMSAN_ORIGIN_SIZE| bytes of the
> > +                        * last shadow slot.
> > +                        */
> > +                       skip_bits =3D (((u64)src + n) % KMSAN_ORIGIN_SI=
ZE) * 8;
> > +                       shadow =3D (shadow >> skip_bits) << skip_bits;
>
> Same here.
Done
>


> This can be a bit shorted and w/o the temp var as:
>
> new_origin =3D kmsan_internal_chain_origin(old_origin);
> /*
> * kmsan_internal_chain_origin() may return
> * NULL, but we don't want to lose the previous
> * origin value.
> */
> if (!new_origin)
>    new_origin =3D old_origin;

Done.

>
>
> > +               }
> > +               if (shadow)
> > +                       origin_dst[i] =3D new_origin;
>
> Are we sure that origin_dst is aligned here?
Yes, kmsan_get_metadata(..., KMSAN_META_ORIGIN) always returns aligned poin=
ters.



--
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
