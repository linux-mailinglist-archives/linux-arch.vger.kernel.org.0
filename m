Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A6458BC08
	for <lists+linux-arch@lfdr.de>; Sun,  7 Aug 2022 19:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiHGReN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 7 Aug 2022 13:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiHGReM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 7 Aug 2022 13:34:12 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE4738A5
        for <linux-arch@vger.kernel.org>; Sun,  7 Aug 2022 10:34:10 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-31f443e276fso61750767b3.1
        for <linux-arch@vger.kernel.org>; Sun, 07 Aug 2022 10:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=aS6EBaNIN10+OZPUpR/4ogKAkoJ9rFIL98FCoXlnNSA=;
        b=XpLWeHmLSgilVTC/YVDJdenSdO9VgEXau1/zbqRnkcJxD/8EfTAnvBvtediAfBDduT
         yCm30ilSyBucIjn2Mi1MvxCG+jlUqTrB5qyK3AUFwqvaMyAqde4A3I265GlRWFIXINCP
         TPdJKp96tRb7p/cuTGjalES/FKWxaCpZdLftBKK/a4AHpG/wgikOIFWOcy72yQRxVi8S
         QoiQizprHh0nnRIovr8RqCM+6QlzZlw40e1oO9C9MRg0lgbttWi0LCqtcsPXTolLCD3j
         855X9875RDQl75VEJ5hHCk5GqYr3V2eaLjOcPL21BC0b6vzBiGf4A5U1aW8gCItyNapE
         YZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=aS6EBaNIN10+OZPUpR/4ogKAkoJ9rFIL98FCoXlnNSA=;
        b=qgHBOIBm+jiqVT6oR50DUczm6ZuglwkpmDkeDRPeMwmPnrCO6CSxyK9eOfSS50As6+
         KdKk5FSYUdo8j8QVBY1tdbU1Hxjl3oMZXBL1KaITLYrvo5Tk+2hM78Jbfes8kVfhNXDP
         66j6l9LMVNgz4zIlhyBXwJO+FzxNpXi4jWqZIbE7Lq8mWcy091POhQmLzfJdQip43g3Q
         zyhr7055XXvkTGfSUYlr20CB4sCBgxP8Mu+CDU887+9PfZveD7B5YZ1iUgWaoiQJWXYV
         C7oj1wtwfr+dPRrAW127sIHlXKfuCnudLfXMyoINxQPn/dm7Wv9pOEa/mYfYd0ViQfbD
         YjdA==
X-Gm-Message-State: ACgBeo2IS4moXQGXBU02fFjhsuBrqcYdxxVdt8JcUXc4noX4WRn0wi9T
        6jvKXKKoIjjMvQ0eys1tzeb068tgS29ClmJClexG4g==
X-Google-Smtp-Source: AA6agR6MFeUG2On+7vQSONsbltpXDjqOVg5KhQR92T7QmMYljWwNRhhzj3YFZU8Dlaejm2j4GyGExjq1payzBN1lTaA=
X-Received: by 2002:a0d:c7c3:0:b0:31e:9622:c4f6 with SMTP id
 j186-20020a0dc7c3000000b0031e9622c4f6mr14640035ywd.144.1659893650000; Sun, 07
 Aug 2022 10:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-5-glider@google.com>
 <CANpmjNN28k3B1-nX=gtdJxZ4MS=bF+CuPG1EFp5fC2TDQUU=4Q@mail.gmail.com>
In-Reply-To: <CANpmjNN28k3B1-nX=gtdJxZ4MS=bF+CuPG1EFp5fC2TDQUU=4Q@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Sun, 7 Aug 2022 19:33:33 +0200
Message-ID: <CAG_fn=UQ2g9KjixL4Hsbw04r75VB2bp_X7F3RzE4twDro+Xi_Q@mail.gmail.com>
Subject: Re: [PATCH v4 04/45] x86: asm: instrument usercopy in get_user() and __put_user_size()
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 7, 2022 at 12:13 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, 1 Jul 2022 at 16:23, Alexander Potapenko <glider@google.com> wrot=
e:
> >
> > Use hooks from instrumented.h to notify bug detection tools about
> > usercopy events in get_user() and put_user_size().
> >
> > It's still unclear how to instrument put_user(), which assumes that
> > instrumentation code doesn't clobber RAX.
>
> do_put_user_call() has a comment about KASAN clobbering %ax, doesn't
> this also apply to KMSAN? If not, could we have a <asm/instrumented.h>
> that provides helpers to push registers on the stack and pop them back
> on return?

In fact, yes, it is rather simple to not clobber %ax.
A more important aspect of instrumenting get_user()/put_user() is to
always evaluate `x` and `ptr` only once, because sometimes these
macros get called like `put_user(v, sp++)`.
I might have confused the effects of evaluating sp++ twice with some
register clobbering.

> Also it seems the test robot complained about this patch.
Will fix in v5.
>
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > ---
> > Link: https://linux-review.googlesource.com/id/Ia9f12bfe5832623250e20f1=
859fdf5cc485a2fce
> > ---
> >  arch/x86/include/asm/uaccess.h | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uacc=
ess.h
> > index 913e593a3b45f..1a8b5a234474f 100644
> > --- a/arch/x86/include/asm/uaccess.h
> > +++ b/arch/x86/include/asm/uaccess.h
> > @@ -5,6 +5,7 @@
> >   * User space memory access functions
> >   */
> >  #include <linux/compiler.h>
> > +#include <linux/instrumented.h>
> >  #include <linux/kasan-checks.h>
> >  #include <linux/string.h>
> >  #include <asm/asm.h>
> > @@ -99,11 +100,13 @@ extern int __get_user_bad(void);
> >         int __ret_gu;                                                  =
 \
> >         register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);           =
 \
> >         __chk_user_ptr(ptr);                                           =
 \
> > +       instrument_copy_from_user_before((void *)&(x), ptr, sizeof(*(pt=
r))); \
> >         asm volatile("call __" #fn "_%P4"                              =
 \
> >                      : "=3Da" (__ret_gu), "=3Dr" (__val_gu),           =
     \
> >                         ASM_CALL_CONSTRAINT                            =
 \
> >                      : "0" (ptr), "i" (sizeof(*(ptr))));               =
 \
> >         (x) =3D (__force __typeof__(*(ptr))) __val_gu;                 =
   \
> > +       instrument_copy_from_user_after((void *)&(x), ptr, sizeof(*(ptr=
)), 0); \
> >         __builtin_expect(__ret_gu, 0);                                 =
 \
> >  })
> >
> > @@ -248,7 +251,9 @@ extern void __put_user_nocheck_8(void);
> >
> >  #define __put_user_size(x, ptr, size, label)                          =
 \
> >  do {                                                                  =
 \
> > +       __typeof__(*(ptr)) __pus_val =3D x;                            =
   \
> >         __chk_user_ptr(ptr);                                           =
 \
> > +       instrument_copy_to_user(ptr, &(__pus_val), size);              =
 \
> >         switch (size) {                                                =
 \
> >         case 1:                                                        =
 \
> >                 __put_user_goto(x, ptr, "b", "iq", label);             =
 \
> > @@ -286,6 +291,7 @@ do {                                               =
                         \
> >  #define __get_user_size(x, ptr, size, label)                          =
 \
> >  do {                                                                  =
 \
> >         __chk_user_ptr(ptr);                                           =
 \
> > +       instrument_copy_from_user_before((void *)&(x), ptr, size);     =
 \
> >         switch (size) {                                                =
 \
> >         case 1: {                                                      =
 \
> >                 unsigned char x_u8__;                                  =
 \
> > @@ -305,6 +311,7 @@ do {                                               =
                         \
> >         default:                                                       =
 \
> >                 (x) =3D __get_user_bad();                              =
   \
> >         }                                                              =
 \
> > +       instrument_copy_from_user_after((void *)&(x), ptr, size, 0);   =
 \
> >  } while (0)
> >
> >  #define __get_user_asm(x, addr, itype, ltype, label)                  =
 \
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
