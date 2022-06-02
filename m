Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E22553B7AF
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jun 2022 13:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiFBLU4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jun 2022 07:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbiFBLUz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jun 2022 07:20:55 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F082A80FD
        for <linux-arch@vger.kernel.org>; Thu,  2 Jun 2022 04:20:53 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id p13so7755272ybm.1
        for <linux-arch@vger.kernel.org>; Thu, 02 Jun 2022 04:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6r6Vaw+wZvpxvKWw2pORFiU+DbCU4N7wdhOQeTbklfc=;
        b=m0OEpK597X7Jm59IE3NiU7ra1ljGWT0v9rqyVt5WF+xQOU8MX3XqOxTO6lWuU168Nb
         KxAHL5oIcH5PH/Gzsck3NoHWIY20v/090PzZzAOHKR/Q7sLMTPk4CAIApvN8p6TFUYEY
         B6ilnZQslx3vho5a8lpxJP2cT72tTfzsQINEA8OEEkBIravpJHh0rtCsH6mbhoe9bE75
         vWWTVU5S0rMTNNv1kFizVCJn3Xi5fCuyO+quUQubNBerWcS4Rq7dz4/eZEydDOylA11O
         t6fiOh8MrUCSJOTqc87gmkjxh0W91Et7HG+v/nZJqCjF3hMiaqITAmaUYZR8VnyCg8gM
         3Ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6r6Vaw+wZvpxvKWw2pORFiU+DbCU4N7wdhOQeTbklfc=;
        b=gFbt4qpkgRA7zbexOnEwAhJEku4FMfhFSlNXeOpod3tLzEbh8ogiTfpbocKS15OBnF
         66jC2mwSSR/28VBvTq+g6bQWXF+44ScRNY/ZOP3L6zsoI7Rd0gIOOKU39ae7T1riMMJA
         VXELT98BNCmYGJ2OvmChT19ZU6V64WgRPTEdZYOJjaOjKcG21uVAEuwa4x8hswv/Si3c
         Yf7yNyYG4MJLikN/T5hQdhSEqD82oqvqfrdqPQ6MOU156Liz0jIxYYI4AcSf9OpKpnXv
         QGvNWOf7U+AGhz4U4KI4Rr/qcA144S36/m5/OWEONDG7m8ZJnLGsYJuJHGpko5JLa1+C
         lTGw==
X-Gm-Message-State: AOAM531QzES8rP/MWcbkpHjegH32ZEhgZPkc7INc856eW/4nHYxtkzSf
        K1ESpxrQdIbsYRgGraFTwbcU1a6dhbITFppRjSIcbg==
X-Google-Smtp-Source: ABdhPJxI8RjbLjO2b9SZDaxy2qFIb8juG6DprYWcrXQV0N+mLi1jIj6L/wKi/ae5MVHdUK1h3xajcbA/Z66IiOGwWWo=
X-Received: by 2002:a5b:4c7:0:b0:65d:313:6270 with SMTP id u7-20020a5b04c7000000b0065d03136270mr4614359ybp.363.1654168852326;
 Thu, 02 Jun 2022 04:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220426164315.625149-1-glider@google.com> <20220426164315.625149-6-glider@google.com>
 <CAK8P3a2eDDAAQ8RiQi0B+Jk4KvGeMk+pe78RB+bB9qwTTyhuag@mail.gmail.com>
In-Reply-To: <CAK8P3a2eDDAAQ8RiQi0B+Jk4KvGeMk+pe78RB+bB9qwTTyhuag@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 2 Jun 2022 13:20:16 +0200
Message-ID: <CAG_fn=X601D5RtbkOMjZEKL+ZyQZG5Ddw7Uv=MOivbceAxPBAg@mail.gmail.com>
Subject: Re: [PATCH v3 05/46] x86: asm: instrument usercopy in get_user() and __put_user_size()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Christoph Hellwig <hch@lst.de>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Apr 27, 2022 at 9:15 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Apr 26, 2022 at 6:42 PM Alexander Potapenko <glider@google.com> w=
rote:
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
>
> Isn't "ptr" the original pointer here? I think what happened with the
> reported warning is that you get one output line for every instance this
> is used in. There should probably be a
>
>       __auto_type __ptr =3D (ptr);
>
> at the beginning of the macro to ensure that 'ptr' is only evaluated once=
.
>
> >>> arch/x86/kernel/signal.c:360:9: sparse: sparse: incorrect type in arg=
ument 1 (different address spaces) @@     expected void [noderef] __user *t=
o @@     got unsigned long long [usertype] * @@
>
> It would also make sense to add the missing __user annotation in this lin=
e, but
> I suspect there are others like it in drivers.
>
>       Arnd

I ran sparse locally, and it is actually the missing __user
annotations in signal.c that cause these reports.

The following patch:

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index e439eb14325fa..68537dbffa545 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -355,7 +355,7 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *=
set,
         * reasons and because gdb uses it as a signature to notice
         * signal handler stack frames.
         */
-       unsafe_put_user(*((u64 *)&retcode), (u64 *)frame->retcode, Efault);
+       unsafe_put_user(*((u64 *)&retcode), (__user u64
*)frame->retcode, Efault);
        user_access_end();

        /* Set up registers for signal handler */
@@ -415,7 +415,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ks=
ig,
         * reasons and because gdb uses it as a signature to notice
         * signal handler stack frames.
         */
-       unsafe_put_user(*((u64 *)&rt_retcode), (u64 *)frame->retcode, Efaul=
t);
+       unsafe_put_user(*((u64 *)&rt_retcode), (__user u64
*)frame->retcode, Efault);
        unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault=
);
        unsafe_put_sigmask(set, frame, Efault);
        user_access_end();

appears to fix sparse warnings.



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
