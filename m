Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7261F2552A9
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 03:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgH1BpF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 21:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgH1BpE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 21:45:04 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54847C061264;
        Thu, 27 Aug 2020 18:45:04 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d18so7912111iop.13;
        Thu, 27 Aug 2020 18:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=38INnuUjTFHLtUA45Nn3FEw2KFZHxnh4HKLBgG7stGo=;
        b=Cg3EujFIDQ7ni52SCf2uI5ywuinZ3kzuBBLKeWuvvsmlZi+nZW1GacVnRYRb82OETG
         fAFnbFLKVyW3S6tF3iWOKuTB6rjSoD4H+uG/d2K7frnQqskLDbVaOnYklfrNG+JCxRhR
         qU0ISgTQnbP+wfH65ANjq8NeHHXYA8bCIAZW8QcOjfrFW3K13/0sjaISbirCG1/NdTDr
         PTp9Ywpq7A9lqlMr2sigSv1JbSYcmrKRzepRgYIrhXL4g8rPD7MQUxShSf8ZotBMVaL0
         o2ubilfeETvKGvhGGp8/Nxy/e/NmNrYplbtL3YuL+aIrBe0G22q45/RRwVjr6txCEc9E
         vjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=38INnuUjTFHLtUA45Nn3FEw2KFZHxnh4HKLBgG7stGo=;
        b=EFZvZSZ8xVtufZ4vftnJFFnxxMEk4soapZ2wbShUWw7c/5sUW6DGNXnR4gtvk/76zG
         icxvN25S+TD7Q3+n6cRXJ5idaalz0Ymhj4n6o8HP/hPadv5U9STY1e8EjE9chg+MmqE3
         Fgvcmkq0OgjuSUD5hppD2H3R31uKgyhjsWCcxiHZ0ZmYxDGmJ5qRt2nZKgiGdcInkAzl
         LZhc2gHMIu+pHMfLgSGNQKuG56lcQNRLOgqKXweIHG7vi89yFz+GsR+blJXUo9Rci1k6
         kumbvvViauIhAStIi12VwQLR2Qe0v6c2PTCazTI6uMe55jLwmSVKSD8zeZ1RZrt4ZM10
         Rb4Q==
X-Gm-Message-State: AOAM533S0d/nOHiJeQ4MWATF8TVocRv84c1GnLGiblBViaJ26E4rF94T
        prP+s3ZQFHfQE18COqDXNak+Z3TzAxe/FB47v8w=
X-Google-Smtp-Source: ABdhPJypT+VAuP9IPpwXd6IBj34UiFng/du++myhAan6wmw240QaNF6nuqWJYF2cBL3zLW/ReOrrwwPSW69WMOa+FIA=
X-Received: by 2002:a5d:924c:: with SMTP id e12mr19523575iol.28.1598579103322;
 Thu, 27 Aug 2020 18:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <a770d45d-b147-a8c5-b7f8-30d668cbed84@intel.com>
 <4BDFD364-798C-4537-A88E-F94F101F524B@amacapital.net> <CAMe9rOoTjSwRSPuqP6RKkDzPA_VPh5gVYRVFJ-ezAD4Et-FUng@mail.gmail.com>
 <CALCETrW=-ahC7GUCCyX7nPjCHfG3tiyDespud2Z7UbB6yWWWAA@mail.gmail.com>
In-Reply-To: <CALCETrW=-ahC7GUCCyX7nPjCHfG3tiyDespud2Z7UbB6yWWWAA@mail.gmail.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 27 Aug 2020 18:44:27 -0700
Message-ID: <CAMe9rOrt5hz6qsNAxPgdKCOhRcKKESv-D3rxdSfraeJ-LFHM4w@mail.gmail.com>
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
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

On Thu, Aug 27, 2020 at 6:35 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Thu, Aug 27, 2020 at 12:38 PM H.J. Lu <hjl.tools@gmail.com> wrote:
> >
> > On Thu, Aug 27, 2020 at 11:56 AM Andy Lutomirski <luto@amacapital.net> =
wrote:
> > >
> > >
> > >
> > > > On Aug 27, 2020, at 11:13 AM, Yu, Yu-cheng <yu-cheng.yu@intel.com> =
wrote:
> > > >
> > > > =EF=BB=BFOn 8/27/2020 6:36 AM, Florian Weimer wrote:
> > > >> * H. J. Lu:
> > > >>>> On Thu, Aug 27, 2020 at 6:19 AM Florian Weimer <fweimer@redhat.c=
om> wrote:
> > > >>>>>
> > > >>>>> * Dave Martin:
> > > >>>>>
> > > >>>>>> You're right that this has implications: for i386, libc probab=
ly pulls
> > > >>>>>> more arguments off the stack than are really there in some sit=
uations.
> > > >>>>>> This isn't a new problem though.  There are already generic pr=
ctls with
> > > >>>>>> fewer than 4 args that are used on x86.
> > > >>>>>
> > > >>>>> As originally posted, glibc prctl would have to know that it ha=
s to pull
> > > >>>>> an u64 argument off the argument list for ARCH_X86_CET_DISABLE.=
  But
> > > >>>>> then the u64 argument is a problem for arch_prctl as well.
> > > >>>>>
> > > >>>
> > > >>> Argument of ARCH_X86_CET_DISABLE is int and passed in register.
> > > >> The commit message and the C source say otherwise, I think (not su=
re
> > > >> about the C source, not a kernel hacker).
> > > >
> > > > H.J. Lu suggested that we fix x86 arch_prctl() to take four argumen=
ts, and then keep MMAP_SHSTK as an arch_prctl().  Because now the map flags=
 and size are all in registers, this also solves problems being pointed out=
 earlier.  Without a wrapper, the shadow stack mmap call (from user space) =
will be:
> > > >
> > > > syscall(_NR_arch_prctl, ARCH_X86_CET_MMAP_SHSTK, size, MAP_32BIT).
> > >
> > > I admit I don=E2=80=99t see a show stopping technical reason we can=
=E2=80=99t add arguments to an existing syscall, but I=E2=80=99m pretty sur=
e it=E2=80=99s unprecedented, and it doesn=E2=80=99t seem like a good idea.
> >
> > prctl prototype is:
> >
> > extern int prctl (int __option, ...)
> >
> > and implemented in kernel as:
> >
> >       int prctl(int option, unsigned long arg2, unsigned long arg3,
> >                  unsigned long arg4, unsigned long arg5);
> >
> > Not all prctl operations take all 5 arguments.   It also applies
> > to arch_prctl.  It is quite normal for different operations of
> > arch_prctl to take different numbers of arguments.
>
> If by "quite normal" you mean "does not happen", then I agree.
>
> In any event, I will not have anything to do with a patch that changes
> an existing syscall signature unless Linus personally acks it.  So if
> you want to email him and linux-abi, be my guest.

Can you think of ANY issues of passing more arguments to arch_prctl?
syscall () provided by glibc always passes 6 arguments to the kernel.
Arguments are already in the registers.  What kind of problems do
you see?

--=20
H.J.
