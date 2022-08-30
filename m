Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C2F5A715F
	for <lists+linux-arch@lfdr.de>; Wed, 31 Aug 2022 01:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiH3XH6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 19:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiH3XH5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 19:07:57 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E659E2E2
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 16:07:55 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id d126so12985639vsd.13
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 16:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Vynfz887MVYBr6yRDwVUmonMdQzXB6om2UVf81HGico=;
        b=RkRI1oprMfXXLpzBKkKjNEE0iBv/FK31O/Vsua3ZqNk5Jw/g1s21qy0kTygzKtnHfC
         lY9wR+G5UlcjIwAA4/39IeybLoAteKygD1Ow+DgBGPLpyRJ1v6W16eZKGEorS1bXrjhI
         4+Qcl6NLpMPAjU8VSXwekJNBCMdrndJ6vytCRXox2Hb4G1b25XWISysG2vBM3guf69op
         24L7hI6lu3HlJgn2PekWGQMvbjBOeYr8HzMgHuB12x91JrH53OLu7wEPNlXGeSiGgmUj
         rejb2k4cpa+RKoMggqHVM2isuE0e3U2zzPcNwVwrRuVBAwrpQIu2ss6QKoTL9+VQBtvH
         mh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Vynfz887MVYBr6yRDwVUmonMdQzXB6om2UVf81HGico=;
        b=nGgNZlJ/ePVgpoxei6WPsRTCz2Pg6qIiydovVeXTk3sBdgUsXwhkPIicj/P40V7oEq
         B71y9UawU3Ex6tI8l12ia8rYpb/Fs2JMISnaMNPykM3oHV9EJ/+1ea66poxdPwcCI9Ic
         tKQbXwxXauIpDgLzmyi9yeWMlFHCtAJMfzm3cBB4t2v/wIq761hdQFlAEmrTBb1XQzsO
         aFYrLOOJxni7re9xv/sj++6G34Av2ysy/HLRWE7n9aC573E+2nLxHtHuUavhcLYEqMgY
         fMr+ECnjXe2/tj5SGt+kcfyR0kXSaHxLqr3TkhJj7S9yAXl0Bb9uUx7mAeoWGzR9CK9L
         R9bA==
X-Gm-Message-State: ACgBeo2vdih13riygaOc8+DAYzYGHkFwdO+WgLlCiI9bckv8C1YKA6Fe
        ci0A1jN1waU/HgyZMKExeCJLLRaDDwLfIYfi3meusQ==
X-Google-Smtp-Source: AA6agR7+hhtQNr2WwEZoh61BOKtr4K7KVpgcvB0U7/bL9aMM3hfCAlmVJnFGNFxDqyRYeNjdxYV5Ue+xFWHIlN3sOxw=
X-Received: by 2002:a05:6102:e93:b0:390:d839:9aa2 with SMTP id
 l19-20020a0561020e9300b00390d8399aa2mr5153556vst.65.1661900873993; Tue, 30
 Aug 2022 16:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220826150807.723137-1-glider@google.com> <20220826150807.723137-5-glider@google.com>
 <20220826211729.e65d52e7919fee5c34d22efc@linux-foundation.org>
 <CAG_fn=Xpva_yx8oG-xi7jqJyM2YLcjNda+8ZyQPGBMV411XgMQ@mail.gmail.com>
 <20220829122452.cce41f2754c4e063f3ae8b75@linux-foundation.org>
 <CAG_fn=X6eZ6Cdrv5pivcROHi3D8uymdgh+EbnFasBap2a=0LQQ@mail.gmail.com>
 <20220830150549.afa67340c2f5eb33ff9615f4@linux-foundation.org>
 <CAOUHufZrb_gkxaWfCLuFodRtCwGGdYjo2wvFW7kTiTkRbg4XNQ@mail.gmail.com> <20220830160035.8baf16a7f40cf09963e8bc55@linux-foundation.org>
In-Reply-To: <20220830160035.8baf16a7f40cf09963e8bc55@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 30 Aug 2022 17:07:17 -0600
Message-ID: <CAOUHufZQ5QV4_GaJU_SPYk-hNEWnnTxcE8EdpcPBHK6M3qSm-w@mail.gmail.com>
Subject: Re: [PATCH v5 04/44] x86: asm: instrument usercopy in get_user() and put_user()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
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

On Tue, Aug 30, 2022 at 5:00 PM Andrew Morton <akpm@linux-foundation.org> w=
rote:
>
> On Tue, 30 Aug 2022 16:25:24 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > On Tue, Aug 30, 2022 at 4:05 PM Andrew Morton <akpm@linux-foundation.or=
g> wrote:
> > >
> > > On Tue, 30 Aug 2022 16:23:44 +0200 Alexander Potapenko <glider@google=
.com> wrote:
> > >
> > > > >                  from init/do_mounts.c:2:
> > > > > ./include/linux/page-flags.h: In function =E2=80=98page_fixed_fak=
e_head=E2=80=99:
> > > > > ./include/linux/page-flags.h:226:36: error: invalid use of undefi=
ned type =E2=80=98const struct page=E2=80=99
> > > > >   226 |             test_bit(PG_head, &page->flags)) {
> > > > >       |                                    ^~
> > > > > ./include/linux/bitops.h:50:44: note: in definition of macro =E2=
=80=98bitop=E2=80=99
> > > > >    50 |           __builtin_constant_p((uintptr_t)(addr) !=3D (ui=
ntptr_t)NULL) && \
> > > > >       |                                            ^~~~
> > > > > ./include/linux/page-flags.h:226:13: note: in expansion of macro =
=E2=80=98test_bit=E2=80=99
> > > > >   226 |             test_bit(PG_head, &page->flags)) {
> > > > >       |             ^~~~~~~~
> > > > > ...
> > > >
> > > > Gotcha, this is a circular dependency: mm_types.h -> sched.h ->
> > > > kmsan.h -> gfp.h -> mmzone.h -> page-flags.h -> mm_types.h, where t=
he
> > > > inclusion of sched.h into mm_types.h was only introduced in "mm:
> > > > multi-gen LRU: support page table walks" - that's why the problem w=
as
> > > > missing in other trees.
> > >
> > > Ah, thanks for digging that out.
> > >
> > > Yu, that inclusion is regrettable.
> >
> > Sorry for the trouble -- it's also superfluous because we don't call
> > lru_gen_use_mm() when switching to the kernel.
> >
> > I've queued the following for now.
>
> Well, the rest of us want it too.
>
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -3,7 +3,6 @@
> >  #define _LINUX_MM_TYPES_H
> >
> >  #include <linux/mm_types_task.h>
> > -#include <linux/sched.h>
> >
> >  #include <linux/auxvec.h>
> >  #include <linux/kref.h>
> > @@ -742,8 +741,7 @@ static inline void lru_gen_init_mm(struct mm_struct=
 *mm)
> >
> >  static inline void lru_gen_use_mm(struct mm_struct *mm)
> >  {
> > -       if (!(current->flags & PF_KTHREAD))
> > -               WRITE_ONCE(mm->lru_gen.bitmap, -1);
> > +       WRITE_ONCE(mm->lru_gen.bitmap, -1);
> >  }
>
> Doesn't apply.  I did:
>
> --- a/include/linux/mm_types.h~mm-multi-gen-lru-support-page-table-walks-=
fix
> +++ a/include/linux/mm_types.h
> @@ -3,7 +3,6 @@
>  #define _LINUX_MM_TYPES_H
>
>  #include <linux/mm_types_task.h>
> -#include <linux/sched.h>
>
>  #include <linux/auxvec.h>
>  #include <linux/kref.h>
> @@ -742,11 +741,7 @@ static inline void lru_gen_init_mm(struc
>
>  static inline void lru_gen_use_mm(struct mm_struct *mm)
>  {
> -       /* unlikely but not a bug when racing with lru_gen_migrate_mm() *=
/
> -       VM_WARN_ON_ONCE(list_empty(&mm->lru_gen.list));

Yes. I got a report that somebody tripped over this "unlikely"
condition (and ascertained it's not a bug). So I deleted this part as
well.

Will refresh the series around rc5. Thanks.
