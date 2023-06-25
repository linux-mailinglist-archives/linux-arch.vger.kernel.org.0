Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3224173D553
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jun 2023 01:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjFYXwg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Jun 2023 19:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFYXwf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Jun 2023 19:52:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3473EE43
        for <linux-arch@vger.kernel.org>; Sun, 25 Jun 2023 16:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4D2560C5B
        for <linux-arch@vger.kernel.org>; Sun, 25 Jun 2023 23:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFD9C433AD
        for <linux-arch@vger.kernel.org>; Sun, 25 Jun 2023 23:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687737151;
        bh=MarIaZK1/h6d3gcEiuGdnJtH9oNLc/Ovu23/aiJiCSM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hbqJNI1gUFnY6PFzJ9wzyiY63PNbBSWGH/MnkuKmSI7n3FiLgYwpY079Mf3Zt8+iF
         vAgDP64cfvCIJtyf0cOklyayxAdgOgfmMtKIi9FxR4Di5bCz7VYMWIsScPUv0kxWke
         c09JkzDwKY7C4TEIyUZxLJ0cWbfPUWWqH2UiSkrAwEtc8R01Kvlr4k6BezAbVgyHXX
         OCG/+4SgCm+lZ5OuqJ8bk71yraz3gOFnvO+LWoExE2bZmBGzk3f6RCVpclnUaZbXg9
         +du7KBS56umf6AIAD5xcbKIvwto0Zz4ZcgMr/526VEJ9jQPu17eS1u3FjGqfyEPyIA
         JApO7bScUz7Gw==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51d7f350758so2581596a12.3
        for <linux-arch@vger.kernel.org>; Sun, 25 Jun 2023 16:52:31 -0700 (PDT)
X-Gm-Message-State: AC+VfDyxzS4bdgDbda8JdR43+/UE7Yl5KultaSTO6qMo37HEZ+TjwgWd
        1SD5KBEE14sF7SUQXeDsl8DS2G+rcrbPIWmDOuaLcA==
X-Google-Smtp-Source: ACHHUZ4SsLYGJn0dfSXxFKaC+b/PwcoJ8iANFo8WWh8nomaO+sSfLwffHOMAkFtQJoYhfIZGagMbWTVvbeBhHgGqx6c=
X-Received: by 2002:a17:907:3ea3:b0:987:3f34:88ea with SMTP id
 hs35-20020a1709073ea300b009873f3488eamr23437525ejc.58.1687737148936; Sun, 25
 Jun 2023 16:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <ZImZ6eUxf5DdLYpe@arm.com> <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
 <ZJAWMSLfSaHOD1+X@arm.com> <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
 <ZJFukYxRbU1MZlQn@arm.com> <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
 <ZJLgp29mM3BLb3xa@arm.com> <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
 <ZJQR7slVHvjeCQG8@arm.com> <CALCETrW+30_a2QQE-yw9djVFPxSxm7-c2FZFwZ50dOEmnmkeDA@mail.gmail.com>
 <ZJR545en+dYx399c@arm.com>
In-Reply-To: <ZJR545en+dYx399c@arm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 25 Jun 2023 16:52:16 -0700
X-Gmail-Original-Message-ID: <CALCETrWGQ+xZggnjqV4zGrj8LJa4iWLqfF9-VnyfHeWg7agv9w@mail.gmail.com>
Message-ID: <CALCETrWGQ+xZggnjqV4zGrj8LJa4iWLqfF9-VnyfHeWg7agv9w@mail.gmail.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack description
To:     "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
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
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 22, 2023 at 9:43=E2=80=AFAM szabolcs.nagy@arm.com
<szabolcs.nagy@arm.com> wrote:
>
> The 06/22/2023 08:26, Andy Lutomirski wrote:
> > On Thu, Jun 22, 2023 at 2:28=E2=80=AFAM szabolcs.nagy@arm.com
> > <szabolcs.nagy@arm.com> wrote:
> > >
> > > The 06/21/2023 18:54, Edgecombe, Rick P wrote:
> > > > On Wed, 2023-06-21 at 12:36 +0100, szabolcs.nagy@arm.com wrote:
> > > > > > The 06/20/2023 19:34, Edgecombe, Rick P wrote:
> > > > > > > > I actually did a POC for this, but rejected it. The problem=
 is,
> > > > > > > > if
> > > > > > > > there is a shadow stack overflow at that point then the ker=
nel
> > > > > > > > > > can't
> > > > > > > > push the shadow stack token to the old stack. And shadow st=
ack
> > > > > > > > > > overflow
> > > > > > > > is exactly the alt shadow stack use case. So it doesn't rea=
lly
> > > > > > > > > > solve
> > > > > > > > the problem.
> > > > > >
> > > > > > the restore token in the alt shstk case does not regress anythi=
ng
> > > > > > but
> > > > > > makes some use-cases work.
> > > > > >
> > > > > > alt shadow stack is important if code tries to jump in and out =
of
> > > > > > signal handlers (dosemu does this with swapcontext) and for tha=
t a
> > > > > > restore token is needed.
> > > > > >
> > > > > > alt shadow stack is important if the original shstk did not
> > > > > > overflow
> > > > > > but the signal handler would overflow it (small thread stack, h=
uge
> > > > > > sigaltstack case).
> > > > > >
> > > > > > alt shadow stack is also important for crash reporting on shstk
> > > > > > overflow even if longjmp does not work then. longjmp to a
> > > > > > makecontext
> > > > > > stack would still work and longjmp back to the original stack c=
an
> > > > > > be
> > > > > > made to mostly work by an altshstk option to overwrite the top
> > > > > > entry
> > > > > > with a restore token on overflow (this can break unwinding thou=
gh).
> > > > > >
> > > >
> > > > There was previously a request to create an alt shadow stack for th=
e
> > > > purpose of handling shadow stack overflow. So you are now suggestin=
g to
> > > > to exclude that and instead target a different use case for alt sha=
dow
> > > > stack?
> > >
> > > that is not what i said.
> > >
> > > > But I'm not sure how much we should change the ABI at this point si=
nce
> > > > we are constrained by existing userspace. If you read the history, =
we
> > > > may end up needing to deprecate the whole elf bit for this and othe=
r
> > > > reasons.
> > >
> > > i'm not against deprecating the elf bit, but i think binary
> > > marking will be difficult for this kind of feature no matter what
> > > (code may be incompatible for complex runtime dependent reasons).
> > >
> > > > So should we struggle to find a way to grow the existing ABI withou=
t
> > > > disturbing the existing userspace? Or should we start with somethin=
g,
> > > > finally, and see where we need to grow and maybe get a chance at a
> > > > fresh start to grow it?
> > > >
> > > > Like, maybe 3 people will show up saying "hey, I *really* need to u=
se
> > > > shadow stack and longjmp from a ucontext stack", and no one says
> > > > anything about shadow stack overflow. Then we know what to do. And
> > > > maybe dosemu decides it doesn't need to implement shadow stack (hig=
hly
> > > > likely I would think). Now that I think about it, AFAIU SS_AUTODISA=
RM
> > > > was created for dosemu, and the alt shadow stack patch adopted this
> > > > behavior. So it's speculation that there is even a problem in that
> > > > scenario.
> > > >
> > > > Or maybe people just enable WRSS for longjmp() and directly jump ba=
ck
> > > > to the setjmp() point. Do most people want fast setjmp/longjmp() at=
 the
> > > > cost of a little security?
> > > >
> > > > Even if, with enough discussion, we could optimize for all
> > > > hypotheticals without real user feedback, I don't see how it helps
> > > > users to hold shadow stack. So I think we should move forward with =
the
> > > > current ABI.
> > >
> > > you may not get a second chance to fix a security feature.
> > > it will be just disabled if it causes problems.
> >
> > *I* would use altshadowstack.
> >
> > I run a production system (that cares about correctness *and*
> > performance, but that's not really relevant here -- SHSTK ought to be
> > fast).  And, if it crashes, I want to know why.  So I handle SIGSEGV,
> > etc so I have good logs if it crashes.  And I want those same logs if
> > I overflow the stack.
> >
> > That being said, I have no need for longjmp or siglongjmp for this.  I
> > use exit(2) to escape.
>
> the same crash handler that prints a log on shstk overflow should
> work when a different cause of SIGSEGV is recoverable via longjmp.
> to me this means that alt shstk must work with longjmp at least in
> the non-shstk overflow case (which can be declared non-recoverable).

Sure, but how many SIGSEGV handlers would use altshadowstack and
*also, in the same handler* ever resume?  Not mine.  Obviously I'm
only one sample.

>
> > For what it's worth, setjmp/longjmp is a bad API.  The actual pattern
> > that ought to work well (and that could be supported well by fancy
> > compilers and non-C languages, as I understand it) is more like a
> > function call that has two ways out.  Like this (pseudo-C):
> >
> > void function(struct better_jmp_buf &buf, args...)
> > {
> >    ...
> >        if (condition)
> >           better_long_jump(buf);  // long jumps out!
> >        // could also pass buf to another function
> >    ...
> >        // could also return normally
> > }
> >
> > better_call_with_jmp_buf(function, args);
> >
> > *This* could support altshadowstack just fine.  And many users might
> > be okay with the understanding that, if altshadowstack is on, you have
> > to use a better long jump to get out (or a normal sigreturn or _exit).
>
> i don't understand why this would work fine when longjmp does not.
> how does the shstk switch happen?

Ugh, I think this may have some issues given how the ISA works.  Sigh.

I was imagining that better_call_with_jmp_buf would push a restore
token on the shadow stack, then call the passed-in function, then, on
a successful return, INCSSP over the token and continue on.
better_long_jump() would RSTORSSP to the saved token.

But I'm not sure how to write the token without WRUSS.

What *could* be done, which would be nasty and
sigaltshadowstack-specific, is to have a jump out of a signal handler
provide a pointer to the signal frame (siginfo_t or ucontext pointer),
and the kernel would assist it in switching the shadow stack back.
Eww.

--Andy

>
> > No one is getting an altshadowstack signal handler without code
> > changes.
>
> assuming the same component is doing the alt shstk setup as the
> longjmp.
>
> > siglongjmp() could support altshadowstack with help from the kernel,
> > but we probably don't want to go there.
>
> what kind of help? maybe we need that help..
>
> e.g. if the signal frame token is detected by longjmp on
> the shstk then doing an rt_sigreturn with the right signal
> frame context allows longjmp to continue unwinding the shstk.
> however kernel sigcontext layout can change so userspace may
> not know it so longjmp needs a helper, but only in the jump
> across signal frame case.
>
> (this is a different design than what i proposed earlier,
> it also makes longjmp from alt shstk work without wrss,
> the downside is that longjmp across makecontext needs a
> separate solution then which implies that all shstk needs
> a detectable token at the end of the shstk.. so again
> something that we have to get right now and cannot add
> later.)
