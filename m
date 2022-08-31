Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF8C5A775B
	for <lists+linux-arch@lfdr.de>; Wed, 31 Aug 2022 09:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiHaHSU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Aug 2022 03:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiHaHRh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Aug 2022 03:17:37 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22D222287
        for <linux-arch@vger.kernel.org>; Wed, 31 Aug 2022 00:13:58 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-33dc31f25f9so298820317b3.11
        for <linux-arch@vger.kernel.org>; Wed, 31 Aug 2022 00:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Sfi1gRWe3Pv4hFkp/2mywI4Y2D7k7G63OFzJO6B3Cn8=;
        b=BelMdRwxcWgK2FmiETN4G0SMTYvwzt3LlM2rfO25SUvWxisPd4IWOIrSByXa1hbiwF
         vmaRPnWjODVluEAX7l4xmbCRNwk9RAFsQ0sP8K32o7INXBKiULH0UBx2QEZ16KUNp/el
         20wTqhpaXdBraJaexGf64vLELpmkvO7Wl4i1ORnixOMIQ6lr20xKynjKXeUR28+kwhTA
         ZOtgBCMmRmxsWkLUGMiGSQgUQpOkDZ0mZF99D9OjGyGGWwQEt8jjxmgqN2ur4BZkofJs
         qfS/U5ymRnoqgtV10bC1SZ/s6Gd6C8ltlP2lXZ5zAySrQptuFH8c6QyT9W001JQtxRix
         /JJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Sfi1gRWe3Pv4hFkp/2mywI4Y2D7k7G63OFzJO6B3Cn8=;
        b=sVxuY1m2AHjPFZYmpJqkkDApB1hHun1aTfYEvauBzhVnFgcYmGY61FB0CW1efrjcVs
         Dj3Zwj/BMy4raY1WLR/Voq1wTOpM027/azs10iPnOjqdhmFem0VbdsN/pxAby0G+QLRv
         BAPFHe+VkfHwO6sENvFZuv+SYV4r6Qcg3GYxeEMRuRX9vGWDt5YQk+6rH4Pj5EzOxKlr
         F7LdpS0FbE4zoexYTEVYtnJ6EggEftRQscpxK3jp93ZoUxAA6ohZeSsybGVLixFD6vFe
         I/LeQdhuVKwgRpcmzz2LvsCYei8hGhqJ5swWkm2MUb/wD9PcBwmljL1+yWl6OUebXRuw
         pr1A==
X-Gm-Message-State: ACgBeo2TYRum+5MsQq+dszK0PeiCcZ4BuioH8dk29h1KwrD+fzn63m38
        6o2R314WJCsVzrNvdTJeax6HyUlKykneWh2SO9VocQ==
X-Google-Smtp-Source: AA6agR7tofDr5ZjrWSlubPMSuX2jZCF3ilRWXqrSsYwrEPX0qY8vGVVVRDGrLg3wF1fahgLzPzyMJTTIzZcZF3k0WMU=
X-Received: by 2002:a81:b71c:0:b0:340:bb98:fb38 with SMTP id
 v28-20020a81b71c000000b00340bb98fb38mr15645113ywh.428.1661930037271; Wed, 31
 Aug 2022 00:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220826150807.723137-1-glider@google.com> <20220826150807.723137-5-glider@google.com>
 <20220826211729.e65d52e7919fee5c34d22efc@linux-foundation.org>
 <CAG_fn=Xpva_yx8oG-xi7jqJyM2YLcjNda+8ZyQPGBMV411XgMQ@mail.gmail.com>
 <20220829122452.cce41f2754c4e063f3ae8b75@linux-foundation.org>
 <CAG_fn=X6eZ6Cdrv5pivcROHi3D8uymdgh+EbnFasBap2a=0LQQ@mail.gmail.com>
 <20220830150549.afa67340c2f5eb33ff9615f4@linux-foundation.org>
 <CAOUHufZrb_gkxaWfCLuFodRtCwGGdYjo2wvFW7kTiTkRbg4XNQ@mail.gmail.com>
 <20220830160035.8baf16a7f40cf09963e8bc55@linux-foundation.org> <CAOUHufZQ5QV4_GaJU_SPYk-hNEWnnTxcE8EdpcPBHK6M3qSm-w@mail.gmail.com>
In-Reply-To: <CAOUHufZQ5QV4_GaJU_SPYk-hNEWnnTxcE8EdpcPBHK6M3qSm-w@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 31 Aug 2022 09:13:20 +0200
Message-ID: <CAG_fn=Vwxmc6VwbJObiHNiPaAt9tAV77RqFco=q7traPG5DxYw@mail.gmail.com>
Subject: Re: [PATCH v5 04/44] x86: asm: instrument usercopy in get_user() and put_user()
To:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Marco Elver <elver@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 31, 2022 at 1:07 AM Yu Zhao <yuzhao@google.com> wrote:
>
> On Tue, Aug 30, 2022 at 5:00 PM Andrew Morton <akpm@linux-foundation.org>=
 wrote:
> >
> > On Tue, 30 Aug 2022 16:25:24 -0600 Yu Zhao <yuzhao@google.com> wrote:
> >
> > > On Tue, Aug 30, 2022 at 4:05 PM Andrew Morton <akpm@linux-foundation.=
org> wrote:
> > > >
> > > > On Tue, 30 Aug 2022 16:23:44 +0200 Alexander Potapenko <glider@goog=
le.com> wrote:
> > > >
> > > > > >                  from init/do_mounts.c:2:
> > > > > > ./include/linux/page-flags.h: In function =E2=80=98page_fixed_f=
ake_head=E2=80=99:
> > > > > > ./include/linux/page-flags.h:226:36: error: invalid use of unde=
fined type =E2=80=98const struct page=E2=80=99
> > > > > >   226 |             test_bit(PG_head, &page->flags)) {
> > > > > >       |                                    ^~
> > > > > > ./include/linux/bitops.h:50:44: note: in definition of macro =
=E2=80=98bitop=E2=80=99
> > > > > >    50 |           __builtin_constant_p((uintptr_t)(addr) !=3D (=
uintptr_t)NULL) && \
> > > > > >       |                                            ^~~~
> > > > > > ./include/linux/page-flags.h:226:13: note: in expansion of macr=
o =E2=80=98test_bit=E2=80=99
> > > > > >   226 |             test_bit(PG_head, &page->flags)) {
> > > > > >       |             ^~~~~~~~
> > > > > > ...
> > > > >
> > > > > Gotcha, this is a circular dependency: mm_types.h -> sched.h ->
> > > > > kmsan.h -> gfp.h -> mmzone.h -> page-flags.h -> mm_types.h, where=
 the
> > > > > inclusion of sched.h into mm_types.h was only introduced in "mm:
> > > > > multi-gen LRU: support page table walks" - that's why the problem=
 was
> > > > > missing in other trees.
> > > >
> > > > Ah, thanks for digging that out.
> > > >
> > > > Yu, that inclusion is regrettable.
> > >
> > > Sorry for the trouble -- it's also superfluous because we don't call
> > > lru_gen_use_mm() when switching to the kernel.
> > >
> > > I've queued the following for now.
> >
> > Well, the rest of us want it too.
> >
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -3,7 +3,6 @@
> > >  #define _LINUX_MM_TYPES_H
> > >
> > >  #include <linux/mm_types_task.h>
> > > -#include <linux/sched.h>
> > >
> > >  #include <linux/auxvec.h>
> > >  #include <linux/kref.h>
> > > @@ -742,8 +741,7 @@ static inline void lru_gen_init_mm(struct mm_stru=
ct *mm)
> > >
> > >  static inline void lru_gen_use_mm(struct mm_struct *mm)
> > >  {
> > > -       if (!(current->flags & PF_KTHREAD))
> > > -               WRITE_ONCE(mm->lru_gen.bitmap, -1);
> > > +       WRITE_ONCE(mm->lru_gen.bitmap, -1);
> > >  }
> >
> > Doesn't apply.  I did:
> >
> > --- a/include/linux/mm_types.h~mm-multi-gen-lru-support-page-table-walk=
s-fix
> > +++ a/include/linux/mm_types.h
> > @@ -3,7 +3,6 @@
> >  #define _LINUX_MM_TYPES_H
> >
> >  #include <linux/mm_types_task.h>
> > -#include <linux/sched.h>
> >
> >  #include <linux/auxvec.h>
> >  #include <linux/kref.h>
> > @@ -742,11 +741,7 @@ static inline void lru_gen_init_mm(struc
> >
> >  static inline void lru_gen_use_mm(struct mm_struct *mm)
> >  {
> > -       /* unlikely but not a bug when racing with lru_gen_migrate_mm()=
 */
> > -       VM_WARN_ON_ONCE(list_empty(&mm->lru_gen.list));
>
> Yes. I got a report that somebody tripped over this "unlikely"
> condition (and ascertained it's not a bug). So I deleted this part as
> well.
>
> Will refresh the series around rc5. Thanks.

Guess I'd still proceed with splitting up kmsan.h just to be on the safe si=
de.

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
