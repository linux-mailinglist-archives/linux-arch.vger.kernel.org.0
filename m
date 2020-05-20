Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168131DA6E7
	for <lists+linux-arch@lfdr.de>; Wed, 20 May 2020 03:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgETBE0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 May 2020 21:04:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgETBEZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 May 2020 21:04:25 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA1E20849
        for <linux-arch@vger.kernel.org>; Wed, 20 May 2020 01:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589936665;
        bh=PXXxP8uhFGUWNSwJ6Vc/qmk12yFcTacQV1nb6Sn0O9M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HEVOP/LCjo3d2AutI7sFJgWyNVejy9Uif8ss+JK94CYrJxteTKIyrlaeaaqumfv2A
         mk2hEnz5XtBap1jm9Tdq6jB5vh9i179lQ8J3CsbA4V7/XfqWU/6z/m0p9DPRZ0Qjpz
         yn9iEsdpEHP+5BvKfP/cKCZQX8KEETNthacRFe10=
Received: by mail-wm1-f49.google.com with SMTP id n5so1180302wmd.0
        for <linux-arch@vger.kernel.org>; Tue, 19 May 2020 18:04:24 -0700 (PDT)
X-Gm-Message-State: AOAM531jXCLMLeg3oexh7Et/bwVQ4TtHaLCHNFlaIATVprC/GiBZlAL3
        jdIEtXxfr5V7zmo1LQoU+R+gQHJbS0XmKLAuef4AsA==
X-Google-Smtp-Source: ABdhPJxRzLaRgKpPFo9hQLyxTV5/YLigR1ZRrqC8GQsn5VFgWv551/4M7QbnOdI+nhoskIp5Pe8gQBm7X9gB2HZu4wg=
X-Received: by 2002:a05:600c:2299:: with SMTP id 25mr2086671wmf.138.1589936663161;
 Tue, 19 May 2020 18:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <2eb98637-bd2d-dda6-7729-f06ea84256ca@intel.com> <58319765-891D-44B9-AF18-64492B01FF36@amacapital.net>
In-Reply-To: <58319765-891D-44B9-AF18-64492B01FF36@amacapital.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 18:04:11 -0700
X-Gmail-Original-Message-ID: <CALCETrWavh1_Atk=VPQbOoB5tY=zGWGukW8qjF51msKTJSJgQQ@mail.gmail.com>
Message-ID: <CALCETrWavh1_Atk=VPQbOoB5tY=zGWGukW8qjF51msKTJSJgQQ@mail.gmail.com>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 18, 2020 at 6:35 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
>
>
> > On May 18, 2020, at 5:38 PM, Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > =EF=BB=BFOn 5/18/20 4:47 PM, Yu-cheng Yu wrote:
> >>> On Fri, 2020-05-15 at 19:53 -0700, Yu-cheng Yu wrote:
> >>> On Fri, 2020-05-15 at 16:56 -0700, Dave Hansen wrote:
> >>>> On 5/15/20 4:29 PM, Yu-cheng Yu wrote:
> >>>>> [...]
> >>>>> I have run them with CET enabled.  All of them pass, except for the=
 following:
> >>>>> Sigreturn from 64-bit to 32-bit fails, because shadow stack is at a=
 64-bit
> >>>>> address.  This is understandable.
> >>>> [...]
> >>>> One a separate topic: You ran the selftests and one failed.  This is=
 a
> >>>> *MASSIVE* warning sign.  It should minimally be described in your co=
ver
> >>>> letter, and accompanied by a fix to the test case.  It is absolutely
> >>>> unacceptable to introduce a kernel feature that causes a test to fai=
l.
> >>>> You must either fix your kernel feature or you fix the test.
> >>>>
> >>>> This code can not be accepted until this selftests issue is rectifie=
d.
> >> The x86/sigreturn test constructs 32-bit ldt entries, and does sigretu=
rn from
> >> 64-bit to 32-bit context.  We do not have a way to construct a static =
32-bit
> >> shadow stack.
> >
> > Why? What's the limiting factor?  Hardware architecture?  Something in
> > the kernel?
> >
> >> Why do we want that?  I think we can simply run the test with CET
> >> disabled.
> >
> > The sadistic parts of selftests/x86 come from real bugs.  Either bugs
> > where the kernel fell over, or where behavior changed that broke apps.
> > I'd suggest doing some research on where that particular test case came
> > from.  Find the author of the test, look at the changelogs.
> >
> > If this is something that a real app does, this is a problem.  If it's =
a
> > sadistic test that Andy L added because it was an attack vector against
> > the entry code, it's a different story.
>
> There are quite a few tests that do these horrible things in there. IN my=
 personal opinion, sigreturn.c is one of the most important tests we have =
=E2=80=94 it does every horrible thing to the entry code that I thought of =
and that I could come up with a way of doing.  We have been saved from regr=
essing many times by these tests.  CET, and especially the CPL0 version of =
CET, is its own set of entry horror, and we need to keep these tests workin=
g.
>
> I assume the basic issue is that we call raise(), the context magically c=
hanges to 32-bit, but SSP has a 64-bit value, and horrors happen.  So I thi=
nk two things need to happen:
>
> 1. Someone needs to document what happens when IRET tries to put a 64-bit=
 value into SSP but CS is compat. Because Intel has plenty of history of do=
ing colossally broken things here. IOW you could easily be hitting a hardwa=
re design problem, not a software issue per se.
>
> 2. The test needs to work. Assuming the hardware doesn=E2=80=99t do somet=
hing utterly broken, either the 32-bit code needs to be adjusted to avoid a=
ny CALL
> or RET, or you need to write a little raise_on_32bit_shstk() func that sw=
itches to an SSP that fits in 32 bits, calls raise(), and switches back.  F=
rom memory, I didn=E2=80=99t think there was a CALl or RET, so I=E2=80=99m =
guessing that SSP is getting truncated when we round trip through CPL3 comp=
at mode and the result is that the kernel invoked the signal handler with t=
he wrong SSP.  Whoops.
>

Following up here, I think this needs attention from the H/W architects.

From the SDM:

SYSRET and SYSEXIT:

IF ShadowStackEnabled(CPL)
SSP =E2=86=90 IA32_PL3_SSP;
FI;

IRET:

IF ShadowStackEnabled(CPL)
IF CPL =3D 3
THEN tempSSP =E2=86=90 IA32_PL3_SSP; FI;
IF ((EFER.LMA AND CS.L) =3D 0 AND tempSSP[63:32] !=3D 0)
THEN #GP(0); FI;
SSP =E2=86=90 tempSSP

The semantics of actually executing in compat mode with SSP >=3D 2^32
are unclear.  If nothing else, VM exit will save the full SSP and a
subsequent VM entry will fail.

I don't know what the actual effect of operand-size-32 SYSRET or
SYSEXIT with too big a PL3_SSP will be, but I think it needs to be
documented.  Ideally it will not put the CPU in an invalid state.
Ideally it will also not fault, because SYSRET faults in particular
are fatal unless the vector uses IST, and please please please don't
force more ISTs on anyone.

So I think we may need to put this entire series on hold until we get
some answers, because I suspect we're going to have a nice little root
hole otherwise.
