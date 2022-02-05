Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE69C4AAC72
	for <lists+linux-arch@lfdr.de>; Sat,  5 Feb 2022 21:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344067AbiBEUVv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Feb 2022 15:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbiBEUVu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Feb 2022 15:21:50 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE11C061348;
        Sat,  5 Feb 2022 12:21:49 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id y5-20020a17090aca8500b001b8127e3d3aso9429396pjt.3;
        Sat, 05 Feb 2022 12:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BelwKvGiNngYmwb1phL2hLEVwXRxowUsIgvaDY3aEhc=;
        b=S8VIICqQ4Esj/K7s636jZYgXjT+rBr1k8//aD6RwoFudz36QJzH7ba1Gv5Pig6JtFB
         57bZR+Rxw+cOERbx3Bmkw/vRZnd91e2qlHN3w4nP1cJJY6yLoajMqahDoeL+TXAfHxb4
         v+oBUIIp4GE383R4w56a8alreRrd95AtXjs+XUSBYG032joUj7m+qRKnWSS31AomhqE6
         WNpbt1gEnUR2LbNhzUyj+TzwzFYzoftixchVYyShJthta7LEND3i7IumHeSH5gxuuquF
         yvGdB9yZBWnyPPLm3lfp37YASgToGwcW9UqUO/YfaKyUNnsvz6r6USo6aQ/JG4bAjdyi
         x9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BelwKvGiNngYmwb1phL2hLEVwXRxowUsIgvaDY3aEhc=;
        b=ojYMJ8Gj8+qxBZ8kw3pqbsUC0yiQmNXh52IriaUMIMYmfoGnp52kl1auYr0gMUU9pp
         27QVEJ6h/UD3pxHwSFcMMMrsdeQE64OIp78pxTtVrTfXezmxPuge66vUj6Jp12zgGodu
         BXNn1cwweXa2O4XFf+GTrQyLLlND4hekHiE/s1u1vKPAgzCW+QK37dzADZsuzfDszrX+
         hZ/GCoC7KZIjxe4/DzGSoYhz3l60a+6MhqizTqxFeWKI4DmpWma37rYSWAbHCxkkcHt/
         zyGOVKNe0Q4N+ThwX++dxxXNtVbjHu5gDqLFVgf4oV/L9sJu+aVdq4lCQEm/MzKa0Pp4
         7QEw==
X-Gm-Message-State: AOAM532icQgU9/eaDgoWuWZq3AJRzYMgv3geUuG3WmdnXbR2ext5+xAB
        nKbAYxRSAEBa7i18r3kb5XODtuBbU7dBZU/gLdk=
X-Google-Smtp-Source: ABdhPJxjjaAO4+JvF6zsK509l0ZyRJEcv9J8F7QurQJrAt2Z309n50xEgtBefayuJQd5KG4TJ/898MwjPME4pGTMEPc=
X-Received: by 2002:a17:903:2350:: with SMTP id c16mr9700042plh.4.1644092508735;
 Sat, 05 Feb 2022 12:21:48 -0800 (PST)
MIME-Version: 1.0
References: <87fsozek0j.ffs@tglx> <a7e59ae16e0e05579b087caf4045e42b174e2167.camel@intel.com>
 <3421da7fc8474b6db0e265b20ffd28d0@AcuMS.aculab.com> <CAMe9rOonepEiRyoAyTGkDMQQhuyuoP4iTZJJhKGxgnq9vv=dLQ@mail.gmail.com>
 <9f948745435c4c9273131146d50fe6f328b91a78.camel@intel.com>
In-Reply-To: <9f948745435c4c9273131146d50fe6f328b91a78.camel@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Sat, 5 Feb 2022 12:21:12 -0800
Message-ID: <CAMe9rOq8LNdOdrVoVegyF9_DY6te+zGUJ7WQewWZ6sS1zag2Rw@mail.gmail.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 5, 2022 at 12:15 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Sat, 2022-02-05 at 05:29 -0800, H.J. Lu wrote:
> > On Sat, Feb 5, 2022 at 5:27 AM David Laight <David.Laight@aculab.com>
> > wrote:
> > >
> > > From: Edgecombe, Rick P
> > > > Sent: 04 February 2022 01:08
> > > > Hi Thomas,
> > > >
> > > > Thanks for feedback on the plan.
> > > >
> > > > On Thu, 2022-02-03 at 22:07 +0100, Thomas Gleixner wrote:
> > > > > > Until now, the enabling effort was trying to support both
> > > > > > Shadow
> > > > > > Stack and IBT.
> > > > > > This history will focus on a few areas of the shadow stack
> > > > > > development history
> > > > > > that I thought stood out.
> > > > > >
> > > > > >        Signals
> > > > > >        -------
> > > > > >        Originally signals placed the location of the shadow
> > > > > > stack
> > > > > > restore
> > > > > >        token inside the saved state on the stack. This was
> > > > > > problematic from a
> > > > > >        past ABI promises perspective. So the restore location
> > > > > > was
> > > > > > instead just
> > > > > >        assumed from the shadow stack pointer. This works
> > > > > > because in
> > > > > > normal
> > > > > >        allowed cases of calling sigreturn, the shadow stack
> > > > > > pointer
> > > > > > should be
> > > > > >        right at the restore token at that time. There is no
> > > > > > alternate shadow
> > > > > >        stack support. If an alt shadow stack is added later
> > > > > > we
> > > > > > would
> > > > > >        need to
> > > > >
> > > > > So how is that going to work? altstack is not an esoteric
> > > > > corner
> > > > > case.
> > > >
> > > > My understanding is that the main usages for the signal stack
> > > > were
> > > > handling stack overflows and corruption. Since the shadow stack
> > > > only
> > > > contains return addresses rather than large stack allocations,
> > > > and is
> > > > not generally writable or pivotable, I thought there was a good
> > > > possibility an alt shadow stack would not end up being especially
> > > > useful. Does it seem like reasonable guesswork?
> > >
> > > The other 'problem' is that it is valid to longjump out of a signal
> > > handler.
> > > These days you have to use siglongjmp() not longjmp() but it is
> > > still used.
> > >
> > > It is probably also valid to use siglongjmp() to jump from a nested
> > > signal handler into the outer handler.
> > > Given both signal handlers can have their own stack, there can be
> > > three
> > > stacks involved.
>
> So the scenario is?
>
> 1. Handle signal 1
> 2. sigsetjmp()
> 3. signalstack()
> 4. Handle signal 2 on alt stack
> 5. siglongjmp()
>
> I'll check that it is covered by the tests, but I think it should work
> in this series that has no alt shadow stack. I have only done a high
> level overview of how the shadow stack stuff, that doesn't involve the
> kernel, works in glibc. Sounds like I'll need to do a deeper dive.
>
> > >
> > > I think the shadow stack pointer has to be in ucontext - which also
> > > means the application can change it before returning from a signal.
>
> Yes we might need to change it to support alt shadow stacks. Can you
> elaborate why you think it has to be in ucontext? I was thinking of
> looking at three options for storing the ssp:
>  - Stored in the shadow stack like a token using WRUSS from the kernel.
>  - Stored on the kernel side using a hashmap that maps ucontext or
>    sigframe userspace address to ssp (this is of course similar to
>    storing in ucontext, except that the user can=E2=80=99t change the ssp=
).
>  - Stored writable in userspace in ucontext.
>
> But in this version, without alt shadow stacks, the shadow stack
> pointer is not stored in ucontext. This causes the limitation that
> userspace can only call sigreturn when it has returned back to a point
> where there is a restore token on the shadow stack (which was placed
> there by the kernel). This doesn=E2=80=99t mean it can=E2=80=99t switch t=
o a different
> shadow stack or handle a nested signal, but it limits the possibility
> for calling sigreturn with a totally different sigframe (like CRIU and
> SROP attacks do). It should hopefully be a helpful, protective
> limitation for most apps and I'm hoping CRIU can be fixed without
> removing it.
>
> I am not aware of other limitations to signals (besides normal shadow
> stack enforcement), but I could be missing it. And people's skepticism
> is making me want to go back over it with more scrutiny.
>
> > > In much the same way as all the segment registers can be changed
> > > leading to all the nasty bugs when the final 'return to user' code
> > > traps in kernel when loading invalid segment registers or executing
> > > iret.
>
> I don't think this is as difficult to avoid because userspace ssp has
> its own register that should not be accessed at that point, but I have
> not given this aspect enough analysis. Thanks for bringing it up.
>
> > >
> > > Hmmm... do shadow stacks mean that longjmp() has to be a system
> > > call?
> >
> > No.  setjmp/longjmp save and restore shadow stack pointer.
> >
>
> It sounds like it would help to write up in a lot more detail exactly
> how all the signal and specialer stack manipulation scenarios work in
> glibc.
>

setjmp/longjmp work on the same sigjmp_buf.  Shadow stack pointer
is saved and restored, just like any other callee-saved registers.


--=20
H.J.
