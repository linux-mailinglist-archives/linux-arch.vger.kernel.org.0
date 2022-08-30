Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADD55A672A
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 17:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiH3PVx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 11:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiH3PVx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 11:21:53 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D41B656C
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 08:21:51 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-324ec5a9e97so281311577b3.7
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 08:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=uqfm/6R6fkKJnneVeLdLuiqY/mudrNlydjep/s3PwB8=;
        b=YBKdHJyH76npWUrSAFcUV5WdHEmW7p6mf76VnDUTwkYdX1Ctop0BxBlxjtklfAUy+L
         kGBJ/XLJfJkHwuol0EPZKeoZF4lnqtdCIt56B6sQCWHGkC8wz5dxGgeyn00uZPAjHoaV
         zx05izzXoEEVDbWnPO7oxx6V+hor5z4Eahig2z9dPJucnHAUz/Xxi52JnxQQpnLrPlt4
         9RzApL6ulclDreuMV+yNVhRPd+Lqt22wNVo1grU99eXMre0PbMwYrp832TA+MkW/Nfeu
         fOfUuTNN7im+QkWFHQNh4Rexf2f4yOxB+nNzGhhY3RR0Q/LqPfKH/r3/yKosz34QywEy
         ooJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=uqfm/6R6fkKJnneVeLdLuiqY/mudrNlydjep/s3PwB8=;
        b=5ufvb0TCGm5thxEivlS1ShRtUYF2V21rmnRWuurAvmLgImyYZv9+cwh083HmyEbT3F
         SXFR0LlRW4Td/HeOK6TqWiW7e0aTk4x8hi2GW5ZvYNjNXS2qvBzFpKJhfdNnSQUeKtLW
         XlPBm0LcP1h3DXkKJJWEeLeEl8ks1ubcwRibt25J/vWEuwSjpjHYmiEXPn2DXXER1ety
         SlVYvP7jxInemqCBp80jU/xExgtlhuPR1TI5vWLGcytHpq5Uh4CUXSMORqkGZTo/liAM
         hU5VOvp7rnlbez9QtyYmnB0/R4r7GeDNW9w9w+DpSZ22PjR3yYtouC6ABgSThkMYmnt/
         XjGg==
X-Gm-Message-State: ACgBeo0i1AxsnAqLtzbLngog/4k6ZjtMWvy0OnmN1XXv/TaEDTyBslY4
        O4LWZuBZKfP1gQ1fE5KQ1ycTXw0bOO2Okoylhblz7A==
X-Google-Smtp-Source: AA6agR76ifppksQ4LEuS/e9x46ItocAdXbDDSCTZn2SNIVT/gChusn8HH9OwXZXE65iVWnOTgRgUrmp5Y+UCuFj8ldc=
X-Received: by 2002:a81:b71c:0:b0:340:bb98:fb38 with SMTP id
 v28-20020a81b71c000000b00340bb98fb38mr12971069ywh.428.1661872910913; Tue, 30
 Aug 2022 08:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220826150807.723137-1-glider@google.com> <20220826150807.723137-5-glider@google.com>
 <51077555-5341-cf53-78bb-842d2e39d1ec@csgroup.eu>
In-Reply-To: <51077555-5341-cf53-78bb-842d2e39d1ec@csgroup.eu>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 30 Aug 2022 17:21:14 +0200
Message-ID: <CAG_fn=V6aQZGkq0HdhzXFCm1Qbn6GHdQd0dYESBup4Lz7hXV5Q@mail.gmail.com>
Subject: Re: [PATCH v5 04/44] x86: asm: instrument usercopy in get_user() and put_user()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
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
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Tue, Aug 30, 2022 at 5:06 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 26/08/2022 =C3=A0 17:07, Alexander Potapenko a =C3=A9crit :
> > Use hooks from instrumented.h to notify bug detection tools about
> > usercopy events in variations of get_user() and put_user().
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > ---
> > v5:
> >   -- handle put_user(), make sure to not evaluate pointer/value twice
> >
> > Link: https://linux-review.googlesource.com/id/Ia9f12bfe5832623250e20f1=
859fdf5cc485a2fce
> > ---
> >   arch/x86/include/asm/uaccess.h | 22 +++++++++++++++-------
> >   1 file changed, 15 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uacc=
ess.h
> > index 913e593a3b45f..c1b8982899eca 100644
> > --- a/arch/x86/include/asm/uaccess.h
> > +++ b/arch/x86/include/asm/uaccess.h
> > @@ -5,6 +5,7 @@
> >    * User space memory access functions
> >    */
> >   #include <linux/compiler.h>
> > +#include <linux/instrumented.h>
> >   #include <linux/kasan-checks.h>
> >   #include <linux/string.h>
> >   #include <asm/asm.h>
> > @@ -103,6 +104,7 @@ extern int __get_user_bad(void);
> >                    : "=3Da" (__ret_gu), "=3Dr" (__val_gu),             =
   \
> >                       ASM_CALL_CONSTRAINT                             \
> >                    : "0" (ptr), "i" (sizeof(*(ptr))));                \
> > +     instrument_get_user(__val_gu);                                  \
>
> Where is that instrument_get_user() defined ? I can't find it neither in
> v6.0-rc3 nor in linux-next.
>
> >       (x) =3D (__force __typeof__(*(ptr))) __val_gu;                   =
 \
> >       __builtin_expect(__ret_gu, 0);                                  \
> >   })
>
> Christophe

Yeah, as mentioned above, I should've put an empty declaration of it
in include/linux/instrumented.h, but failed to. I'll fix this in v6.
The "real" implementation of instrument_get_user() will appear in
"instrumented.h: add KMSAN support"

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
