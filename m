Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A302725529B
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 03:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgH1Bfj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 21:35:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbgH1Bfi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 21:35:38 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5049A21532
        for <linux-arch@vger.kernel.org>; Fri, 28 Aug 2020 01:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598578537;
        bh=tiwxfT4ZMLpMEWhyNE2BjdBuHmjGuQJ6mucgE6D9qkc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uRmcfm+eR0WIlwue7S9+eANKIDrpY5M+F5fBcTFGN90g2h81uyWfSVhceV5DbbGrg
         /Oe5GG3/y3AnqLUHitHWCx3ciML13KjKruPDw0fiif4jRsXq3GE3Z+Zx6IsOfaqJNf
         nVVeHjN2y0rW8BdIxt1ec8TPXeNOAQvJn+5LmDI4=
Received: by mail-wm1-f47.google.com with SMTP id w2so6623969wmi.1
        for <linux-arch@vger.kernel.org>; Thu, 27 Aug 2020 18:35:37 -0700 (PDT)
X-Gm-Message-State: AOAM532otKj69F+Gmsqstp27mt9Pe2tlHA1NWtWMDceN86TEo2JHv2+M
        kqx1Jzb7CdWABTlRb9EGLaZdkiRJeE/Sn4z+lns9Tg==
X-Google-Smtp-Source: ABdhPJyYDWVWk+/eFi0FJX/LuTNS1lOPnideF7PaS5X0ejA+L68tTArSn1hMT49k/7qw7ckWeiQo1VUVs2+8b5+fEY8=
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr303768wmk.176.1598578535632;
 Thu, 27 Aug 2020 18:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <a770d45d-b147-a8c5-b7f8-30d668cbed84@intel.com>
 <4BDFD364-798C-4537-A88E-F94F101F524B@amacapital.net> <CAMe9rOoTjSwRSPuqP6RKkDzPA_VPh5gVYRVFJ-ezAD4Et-FUng@mail.gmail.com>
In-Reply-To: <CAMe9rOoTjSwRSPuqP6RKkDzPA_VPh5gVYRVFJ-ezAD4Et-FUng@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 27 Aug 2020 18:35:22 -0700
X-Gmail-Original-Message-ID: <CALCETrW=-ahC7GUCCyX7nPjCHfG3tiyDespud2Z7UbB6yWWWAA@mail.gmail.com>
Message-ID: <CALCETrW=-ahC7GUCCyX7nPjCHfG3tiyDespud2Z7UbB6yWWWAA@mail.gmail.com>
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 27, 2020 at 12:38 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Thu, Aug 27, 2020 at 11:56 AM Andy Lutomirski <luto@amacapital.net> wr=
ote:
> >
> >
> >
> > > On Aug 27, 2020, at 11:13 AM, Yu, Yu-cheng <yu-cheng.yu@intel.com> wr=
ote:
> > >
> > > =EF=BB=BFOn 8/27/2020 6:36 AM, Florian Weimer wrote:
> > >> * H. J. Lu:
> > >>>> On Thu, Aug 27, 2020 at 6:19 AM Florian Weimer <fweimer@redhat.com=
> wrote:
> > >>>>>
> > >>>>> * Dave Martin:
> > >>>>>
> > >>>>>> You're right that this has implications: for i386, libc probably=
 pulls
> > >>>>>> more arguments off the stack than are really there in some situa=
tions.
> > >>>>>> This isn't a new problem though.  There are already generic prct=
ls with
> > >>>>>> fewer than 4 args that are used on x86.
> > >>>>>
> > >>>>> As originally posted, glibc prctl would have to know that it has =
to pull
> > >>>>> an u64 argument off the argument list for ARCH_X86_CET_DISABLE.  =
But
> > >>>>> then the u64 argument is a problem for arch_prctl as well.
> > >>>>>
> > >>>
> > >>> Argument of ARCH_X86_CET_DISABLE is int and passed in register.
> > >> The commit message and the C source say otherwise, I think (not sure
> > >> about the C source, not a kernel hacker).
> > >
> > > H.J. Lu suggested that we fix x86 arch_prctl() to take four arguments=
, and then keep MMAP_SHSTK as an arch_prctl().  Because now the map flags a=
nd size are all in registers, this also solves problems being pointed out e=
arlier.  Without a wrapper, the shadow stack mmap call (from user space) wi=
ll be:
> > >
> > > syscall(_NR_arch_prctl, ARCH_X86_CET_MMAP_SHSTK, size, MAP_32BIT).
> >
> > I admit I don=E2=80=99t see a show stopping technical reason we can=E2=
=80=99t add arguments to an existing syscall, but I=E2=80=99m pretty sure i=
t=E2=80=99s unprecedented, and it doesn=E2=80=99t seem like a good idea.
>
> prctl prototype is:
>
> extern int prctl (int __option, ...)
>
> and implemented in kernel as:
>
>       int prctl(int option, unsigned long arg2, unsigned long arg3,
>                  unsigned long arg4, unsigned long arg5);
>
> Not all prctl operations take all 5 arguments.   It also applies
> to arch_prctl.  It is quite normal for different operations of
> arch_prctl to take different numbers of arguments.

If by "quite normal" you mean "does not happen", then I agree.

In any event, I will not have anything to do with a patch that changes
an existing syscall signature unless Linus personally acks it.  So if
you want to email him and linux-abi, be my guest.
