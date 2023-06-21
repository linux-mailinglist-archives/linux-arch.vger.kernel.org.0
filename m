Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01FD7392CE
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 01:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjFUXCq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 19:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjFUXCl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 19:02:41 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77A41988;
        Wed, 21 Jun 2023 16:02:39 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5728df0a7d9so55612207b3.1;
        Wed, 21 Jun 2023 16:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687388559; x=1689980559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EonjXqlZ4D8ptk0fyiGcxPaVH14AHNXvs0vJu4xe1rA=;
        b=LgBLiu9YZDkdCSHBtfgTrgJfpiG5c06vVTO8/GkbYyyLWv8b1RsvdzLxmfkZ9IRWYw
         WySpmPfYPQvq05bfgfOOURITIQhVAR7KJSIVr4S7Eacr6q7oZF9Y/sTAg5vIkNG1fpju
         otpOn1jnkQ9mjc/lmng+dz8WTpW6mgEsDCzhEBHnd55qlirfLMhPqTCm3Tj6HyQXp09R
         FZyZf/PZho/ma6jtNyq5il9dklIIOLWDb3BLt+CLTVRUY98JOnYroFsITQEzZpu+C19j
         35vzzT9N4wz1BhgM1gbM5eZhE9q9Aesww9bSC1wwuIgWdlmU+oyzhwU1NSjWB+oJQtb3
         xSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687388559; x=1689980559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EonjXqlZ4D8ptk0fyiGcxPaVH14AHNXvs0vJu4xe1rA=;
        b=Iycbi1sh/G2sJZW2v6o5j7sRhdA8czdJytgB21zihbc5w04H/yWqr/HtpOMIY6wSVE
         /We5DM9CUHkFbAP2vTKLl4frRI1MJsGZKPOpPy6ZpZKw2918xqI48uZMMuG//bURE+/Q
         lqoskLV8KJeIEJZBlBWrvLlR0I3krFjLKRlG3pqtm6Nsya/7i5Ib40OVjroi83zQWajk
         gzZkdypp6l/1YiGP4Ix+VZZWu1n0m2JEpldWrHGzqLV+LWajgFqwBnLnvCqdSrPz8wUD
         8OlFaCb6jAcKAvo8WylLUNeTSy8dYr5pzsH5gnBNI08WEqf8VA4Q1CnSTzAey1FowKXi
         9r4A==
X-Gm-Message-State: AC+VfDzQh2tgWn+qSBbJBkwNc1IunxwEdUaHIrzfbNjPsy2tU91P7TZa
        Nh2rGruRQ93pgphI/hXqjr+txu4tnCLhOVf2RTQ=
X-Google-Smtp-Source: ACHHUZ7S5TWTLIchV69k6veztxecc49MVcmttpS65Et193n8mUQ2RiJSZ6ARoYqe2RCenoYR7TG2yZK+RNuAqsMBz/o=
X-Received: by 2002:a81:6942:0:b0:568:f2c:ee43 with SMTP id
 e63-20020a816942000000b005680f2cee43mr19871536ywc.2.1687388558964; Wed, 21
 Jun 2023 16:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <1f04fa59-6ca9-4f18-b138-6c33e164b6c2@sirena.org.uk>
 <49eabafa97032dec8ace7361bccae72c6ecf3860.camel@intel.com>
 <fc2ebfcf-8d91-4f07-a119-2aaec3aa099f@sirena.org.uk> <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
 <ZImZ6eUxf5DdLYpe@arm.com> <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
 <ZJAWMSLfSaHOD1+X@arm.com> <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
 <ZJFukYxRbU1MZlQn@arm.com> <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
 <ZJLgp29mM3BLb3xa@arm.com> <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
In-Reply-To: <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 21 Jun 2023 16:02:02 -0700
Message-ID: <CAMe9rOrmgfmy-7QGhNtU+ApUJgG1rKAC-oUvmGMeEm0LHFM0hw@mail.gmail.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack description
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 21, 2023 at 11:54=E2=80=AFAM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Wed, 2023-06-21 at 12:36 +0100, szabolcs.nagy@arm.com wrote:
> > > The 06/20/2023 19:34, Edgecombe, Rick P wrote:
> > > > > On Tue, 2023-06-20 at 10:17 +0100, szabolcs.nagy@arm.com wrote:
> > > > > > > if there is a fix that's good, i haven't seen it.
> > > > > > >
> > > > > > > my point was that the current unwinder works with current
> > > > > > > kernel
> > > > > > > patches, but does not allow future extensions which
> > > > > > > prevents
> > > > > > > sigaltshstk to work. the unwinder is not versioned so this
> > > > > > > cannot
> > > > > > > be fixed later. it only works if distros ensure shstk is
> > > > > > > disabled
> > > > > > > until the unwinder is fixed. (however there is no way to
> > > > > > > detect
> > > > > > > old unwinder if somebody builds gcc from source.)
> > > > >
> > > > > This is a problem the kernel is having to deal with, not
> > > > > causing. > > The
> > > > > userspace changes were upstreamed before the kernel. Userspace
> > > > > > > folks
> > > > > are adamantly against moving to a new elf bit, to start over
> > > > > with a
> > > > > clean slate. I tried everything to influence this and was not
> > > > > successful. So I'm still not sure what the proposal here is for
> > > > > the
> > > > > kernel.
> > >
> > > i agree, the glibc and libgcc patches should not have been accepted
> > > before a linux abi.
> > >
> > > but the other direction also holds: the linux patches should not be
> > > pushed before the userspace design is discussed. (the current code
> > > upstream is wrong, and new code for the proposed linux abi is not
> > > posted yet. this is not your fault, i'm saying it here, because the
> > > discussion is here.)
>
> This series has been discussed with glibc/gcc developers regularly
> throughout the enabling effort. In fact there have been ongoing
> discussions about future shadow stack functionality.
>
> It's not like this feature has been a fast or hidden effort. You are
> just walking into the tail end of it. (much of it predates my
> involvement BTW, including the initial glibc support)
>
> AFAIK HJ presented the enabling changes at some glibc meeting. The
> signal side of glibc is unchanged from what is already upstream. So I'm
> not sure characterizing it that way is fair. It seems you were not part
> of those old discussions, but that might be because your interest is
> new. In any case we are constrained by some of these earlier outcomes.
> More on that below.
>
> > >
> > > > > I am guessing that the fnon-call-exceptions/expanded frame size
> > > > > incompatibilities could end up causing something to grow an
> > > > > opt-in > > at
> > > > > some point.
> > >
> > > there are independent userspace components and not every component
> > > has a chance to opt-in.
> > >
> > > > > > > how does "fixed shadow stack signal frame size" relates to
> > > > > > > "-fnon-call-exceptions"?
> > > > > > >
> > > > > > > if there were instruction boundaries within a function
> > > > > > > where the
> > > > > > > ret addr is not yet pushed or already poped from the shstk
> > > > > > > then
> > > > > > > the flag would be relevant, but since push/pop happens
> > > > > > > atomically
> > > > > > > at function entry/return -fnon-call-exceptions makes no
> > > > > > > difference as far as shstk unwinding is concerned.
> > > > >
> > > > > As I said, the existing unwinding code for fnon-call-
> > > > > excecptions
> > > > > assumes a fixed shadow stack signal frame size of 8 bytes.
> > > > > Since > > the
> > > > > exception is thrown out of a signal, it needs to know how to
> > > > > unwind
> > > > > through the shadow stack signal frame.
> > >
> > > sorry but there is some misunderstanding about -fnon-call-
> > > exceptions.
> > >
> > > it is for emitting cleanup and exception handler data for a
> > > function
> > > such that throwing from certain instructions within that function
> > > works, while normally only throwing from calls work.
> > >
> > > it is not about *unwinding* from an async signal handler, which is
> > > -fasynchronous-unwind-tables and should always work on linux, nor
> > > for
> > > dealing with cleanup/exception handlers above the interrupted frame
> > > (likewise it works on linux without special cflags).
> > >
> > > as far as i can tell the current unwinder handles shstk unwinding
> > > correctly across signal handlers (sync or async and >
> > > cleanup/exceptions
> > > handlers too), i see no issue with "fixed shadow stack signal frame
> > > size of 8 bytes" other than future extensions and discontinous
> > > shstk.
>
> HJ, can you link your patch that makes it extensible and we can clear
> this up? Maybe the issue extends beyond fnon-call-exceptions, but that
> is where I reproduced it.

Here is the patch:

https://gitlab.com/x86-gcc/gcc/-/commit/aab4c24b67b5f05b72e52a3eaae005c2277=
710b9

> > >
> > > > > > > there is no magic, longjmp should be implemented as:
> > > > > > >
> > > > > > >         target_ssp =3D read from jmpbuf;
> > > > > > >         current_ssp =3D read ssp;
> > > > > > >         for (p =3D target_ssp; p !=3D current_ssp; p--) {
> > > > > > >                 if (*p =3D=3D restore-token) {
> > > > > > >                         // target_ssp is on a different
> > > > > > > shstk.
> > > > > > >                         switch_shstk_to(p);
> > > > > > >                         break;
> > > > > > >                 }
> > > > > > >         }
> > > > > > >         for (; p !=3D target_ssp; p++)
> > > > > > >                 // ssp is now on the same shstk as target.
> > > > > > >                 inc_ssp();
> > > > > > >
> > > > > > > this is what setcontext is doing and longjmp can do the
> > > > > > > same:
> > > > > > > for programs that always longjmp within the same shstk the
> > > > > > > first
> > > > > > > loop is just p =3D current_ssp, but it also works when
> > > > > > > longjmp
> > > > > > > target is on a different shstk assuming nothing is running
> > > > > > > on
> > > > > > > that shstk, which is only possible if there is a restore
> > > > > > > token
> > > > > > > on top.
> > > > > > >
> > > > > > > this implies if the kernel switches shstk on signal entry
> > > > > > > it has
> > > > > > > to add a restore-token on the switched away shstk.
> > > > >
> > > > > I actually did a POC for this, but rejected it. The problem is,
> > > > > if
> > > > > there is a shadow stack overflow at that point then the kernel
> > > > > > > can't
> > > > > push the shadow stack token to the old stack. And shadow stack
> > > > > > > overflow
> > > > > is exactly the alt shadow stack use case. So it doesn't really
> > > > > > > solve
> > > > > the problem.
> > >
> > > the restore token in the alt shstk case does not regress anything
> > > but
> > > makes some use-cases work.
> > >
> > > alt shadow stack is important if code tries to jump in and out of
> > > signal handlers (dosemu does this with swapcontext) and for that a
> > > restore token is needed.
> > >
> > > alt shadow stack is important if the original shstk did not
> > > overflow
> > > but the signal handler would overflow it (small thread stack, huge
> > > sigaltstack case).
> > >
> > > alt shadow stack is also important for crash reporting on shstk
> > > overflow even if longjmp does not work then. longjmp to a
> > > makecontext
> > > stack would still work and longjmp back to the original stack can
> > > be
> > > made to mostly work by an altshstk option to overwrite the top
> > > entry
> > > with a restore token on overflow (this can break unwinding though).
> > >
>
> There was previously a request to create an alt shadow stack for the
> purpose of handling shadow stack overflow. So you are now suggesting to
> to exclude that and instead target a different use case for alt shadow
> stack?
>
> But I'm not sure how much we should change the ABI at this point since
> we are constrained by existing userspace. If you read the history, we
> may end up needing to deprecate the whole elf bit for this and other
> reasons.
>
> So should we struggle to find a way to grow the existing ABI without
> disturbing the existing userspace? Or should we start with something,
> finally, and see where we need to grow and maybe get a chance at a
> fresh start to grow it?
>
> Like, maybe 3 people will show up saying "hey, I *really* need to use
> shadow stack and longjmp from a ucontext stack", and no one says
> anything about shadow stack overflow. Then we know what to do. And
> maybe dosemu decides it doesn't need to implement shadow stack (highly
> likely I would think). Now that I think about it, AFAIU SS_AUTODISARM
> was created for dosemu, and the alt shadow stack patch adopted this
> behavior. So it's speculation that there is even a problem in that
> scenario.
>
> Or maybe people just enable WRSS for longjmp() and directly jump back
> to the setjmp() point. Do most people want fast setjmp/longjmp() at the
> cost of a little security?
>
> Even if, with enough discussion, we could optimize for all
> hypotheticals without real user feedback, I don't see how it helps
> users to hold shadow stack. So I think we should move forward with the
> current ABI.
>
>


--=20
H.J.
