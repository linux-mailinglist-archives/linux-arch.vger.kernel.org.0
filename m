Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC48E289032
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 19:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387791AbgJIRnG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 13:43:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733006AbgJIRmo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 13:42:44 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B043A22227
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 17:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602265364;
        bh=gUOFuwn0cjC/he11EKalMfxi4MeQUBOwGoQDNcWNbT8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vUhERsT7oViNCbN1yktcMSLrq2UoiL+noUEm/Nye3+FW9gP3EmlaS86YkwsSmaEix
         VKEv0b99m6WYBTuDlZn2jRkrcKSPZWQCkuG0rlY9WIYSzqWA12nvkNsx/DBwy+Z+Qu
         294/O/M6pWO1Cn6Y2Yz1mQFSimhCMSQLopcfyo3Q=
Received: by mail-wr1-f54.google.com with SMTP id i1so5021955wro.1
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2020 10:42:43 -0700 (PDT)
X-Gm-Message-State: AOAM532h/SCLw46lhYE2+3UTF6spPK/6iWCinjwqSWGV3T1txzvyMo1K
        eFLcaqHE5jTPb/lKtqLItK72NsmdwI0BhpzSbz5WPw==
X-Google-Smtp-Source: ABdhPJzf70K4oYcxfMAjLVRVkzKqNGakkCA08giq0JSBoVJW1VDse/vwgNbdxjH+Vx69hTz8VQgAVnajSUf1U4ZTUOo=
X-Received: by 2002:a5d:5281:: with SMTP id c1mr16067721wrv.184.1602265362208;
 Fri, 09 Oct 2020 10:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <d0e4077e-129f-6823-dcea-a101ef626e8c@intel.com>
 <99B32E59-CFF2-4756-89BD-AEA0021F355F@amacapital.net> <d9099183dadde8fe675e1b10e589d13b0d46831f.camel@intel.com>
 <CALCETrWuhPE3A7eWC=ERJa7i7jLtsXnfu04PKUFJ-Gybro+p=Q@mail.gmail.com>
 <b8797fcd-9d70-5749-2277-ef61f2e1be1f@intel.com> <CALCETrWvWAxEuyteLaPmmu-r5LcWdh_DuW4JAOh3pVD4skWoBQ@mail.gmail.com>
 <CALCETrVvob1dbdWSvaB0ZK1kJ19o9ZKy=U3tFifwOR++_xk=zA@mail.gmail.com>
 <dd4310bd-a76b-cf19-4f12-0b52d7bc483d@intel.com> <CALCETrXgde6yHTKw1Njnxp9cANp6Ee8bmG9C2X4e-Fz0ZZCuBw@mail.gmail.com>
 <CAMe9rOonjX-b46sJ3AYSJZV84d=oU6-KhScnk5vksVqoLgQ90A@mail.gmail.com>
 <CALCETrWoGXDDEvy10LoYVY6c_tkpMVABhCy+8pse9Rw8L9L=5A@mail.gmail.com>
 <79d1e67d-2394-1ce6-3bad-cce24ba792bd@intel.com> <CALCETrU-pjSFBGBROukA8dtSUmft9E1j86oS16Lw0Oz1yzv8Gw@mail.gmail.com>
 <ac8da604-3dff-ddb2-f530-2a256da3618d@intel.com>
In-Reply-To: <ac8da604-3dff-ddb2-f530-2a256da3618d@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 9 Oct 2020 10:42:30 -0700
X-Gmail-Original-Message-ID: <CALCETrWhdM4NOhvzhNyChV9FaiBTjrQwzN+neMnY0FtHDforZQ@mail.gmail.com>
Message-ID: <CALCETrWhdM4NOhvzhNyChV9FaiBTjrQwzN+neMnY0FtHDforZQ@mail.gmail.com>
Subject: Re: [PATCH v13 8/8] x86/vsyscall/64: Fixup Shadow Stack and Indirect
 Branch Tracking for vsyscall emulation
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, "H.J. Lu" <hjl.tools@gmail.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
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
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 6, 2020 at 12:09 PM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>
> On 10/1/2020 10:26 AM, Andy Lutomirski wrote:
> > On Thu, Oct 1, 2020 at 9:51 AM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
> >>
> >> On 9/30/2020 6:10 PM, Andy Lutomirski wrote:
> >>> On Wed, Sep 30, 2020 at 6:01 PM H.J. Lu <hjl.tools@gmail.com> wrote:
> >>>>
> >>>> On Wed, Sep 30, 2020 at 4:44 PM Andy Lutomirski <luto@kernel.org> wrote:
> >>
> >> [...]
> >>
> >>>>>>>>>     From 09803e66dca38d7784e32687d0693550948199ed Mon Sep 17 00:00:00 2001
> >>>>>>>>> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> >>>>>>>>> Date: Thu, 29 Nov 2018 14:15:38 -0800
> >>>>>>>>> Subject: [PATCH v13 8/8] x86/vsyscall/64: Fixup Shadow Stack and
> >>>>>>>>> Indirect Branch
> >>>>>>>>>      Tracking for vsyscall emulation
> >>>>>>>>>
> >>>>>>>>> Vsyscall entry points are effectively branch targets.  Mark them with
> >>>>>>>>> ENDBR64 opcodes.  When emulating the RET instruction, unwind shadow stack
> >>>>>>>>> and reset IBT state machine.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>
> [...]
>
> >>>>>>>>
> >>>>>>>
> >>>>>>> For what it's worth, I think there is an alternative.  If you all
> >>>>>>> (userspace people, etc) can come up with a credible way for a user
> >>>>>>> program to statically declare that it doesn't need vsyscalls, then we
> >>>>>>> could make SHSTK depend on *that*, and we could avoid this mess.  This
> >>>>>>> breaks orthogonality, but it's probably a decent outcome.
> >>>>>>>
> >>>>>>
> >>>>>> Would an arch_prctl(DISABLE_VSYSCALL) work?  The kernel then sets a
> >>>>>> thread flag, and in emulate_vsyscall(), checks the flag.
> >>>>>>
> >>>>>> When CET is enabled, ld-linux will do DISABLE_VSYSCALL.
> >>>>>>
> >>>>>> How is that?
> >>>>>
> >>>>> Backwards, no?  Presumably vsyscall needs to be disabled before or
> >>>>> concurrently with CET being enabled, not after.
> >>>>>
> >>>>> I think the solution of making vsyscall emulation work correctly with
> >>>>> CET is going to be better and possibly more straightforward.
> >>>>>
> >>>>
> >>>> We can do
> >>>>
> >>>> 1. Add ARCH_X86_DISABLE_VSYSCALL to disable the vsyscall page.
> >>>> 2. If CPU supports CET and the program is CET enabled:
> >>>>       a. Disable the vsyscall page.
> >>>>       b. Pass control to user.
> >>>>       c. Enable the vsyscall page when ARCH_X86_CET_DISABLE is called.
> >>>>
> >>>> So when control is passed from kernel to user, the vsyscall page is
> >>>> disabled if the program
> >>>> is CET enabled.
> >>>
> >>> Let me say this one more time:
> >>>
> >>> If we have a per-process vsyscall disable control and a per-process
> >>> CET control, we are going to keep those settings orthogonal.  I'm
> >>> willing to entertain an option in which enabling SHSTK without also
> >>> disabling vsyscalls is disallowed, We are *not* going to have any CET
> >>> flags magically disable vsyscalls, though, and we are not going to
> >>> have a situation where disabling vsyscalls on process startup requires
> >>> enabling SHSTK.
> >>>
> >>> Any possible static vsyscall controls (and CET controls, for that
> >>> matter) also need to come with some explanation of whether they are
> >>> properties set on the ELF loader, the ELF program being loaded, or
> >>> both.  And this explanation needs to cover what happens when old
> >>> binaries link against new libc versions and vice versa.  A new
> >>> CET-enabled binary linked against old libc running on a new kernel
> >>> that is expected to work on a non-CET CPU MUST work on a CET CPU, too.
> >>>
> >>> Right now, literally the only thing preventing vsyscall emulation from
> >>> coexisting with SHSTK is that the implementation eeds work.
> >>>
> >>> So your proposal is rejected.  Sorry.
> >>>
> >> I think, even with shadow stack/ibt enabled, we can still allow XONLY
> >> without too much mess.
> >>
> >> What about this?
> >>
> >> Thanks,
> >> Yu-cheng
> >>
> >> ======
> >>
> >> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c
> >> b/arch/x86/entry/vsyscall/vsyscall_64.c
> >> index 8b0b32ac7791..d39da0a15521 100644
> >> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> >> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> >> @@ -48,16 +48,16 @@
> >>    static enum { EMULATE, XONLY, NONE } vsyscall_mode __ro_after_init =
> >>    #ifdef CONFIG_LEGACY_VSYSCALL_NONE
> >>           NONE;
> >> -#elif defined(CONFIG_LEGACY_VSYSCALL_XONLY)
> >> +#elif defined(CONFIG_LEGACY_VSYSCALL_XONLY) || defined(CONFIG_X86_CET)
> >>           XONLY;
> >> -#else
> >> +#else
> >>           EMULATE;
> >>    #endif
> >
> > I don't get it.
> >
> > First, you can't do any of this based on config -- it must be runtime.
> >
> > Second, and more importantly, I don't see how XONLY helps at all.  The
> > (non-executable) text that's exposed to user code in EMULATE mode is
> > trivial to get right with CET -- your code already handles it.  It's
> > the emulation code (that runs identically in EMULATE and XONLY mode)
> > that's tricky.
> >
>
> Hi,
>
> There has been some ambiguity in my previous proposals.  To make things
> clear, I created a patch for arch_prctl(VSYSCALL_CTL), which controls
> the TIF_VSYSCALL_DISABLE flag.  It is entirely orthogonal to shadow
> stack or IBT.  On top of the patch, we can do SET_PERSONALITY2() to
> disable vsyscall, e.g.

NAK.  Let me try explaining again.

>
> ======
> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index 0e1be2a13359..c730ff00bc62 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -394,6 +394,19 @@ struct arch_elf_state {
>         .gnu_property = 0,      \
>   }
>
> +#define SET_PERSONALITY2(ex, state)                            \
> +do {                                                           \
> +       unsigned int has_cet;                                   \
> +                                                               \
> +       has_cet = GNU_PROPERTY_X86_FEATURE_1_SHSTK |            \
> +                 GNU_PROPERTY_X86_FEATURE_1_IBT;               \
> +                                                               \
> +       if ((state)->gnu_property & has_cet)                    \
> +               set_thread_flag(TIF_VSYSCALL_DISABLE);          \
> +                                                               \
> +       SET_PERSONALITY(ex);                                    \
> +} while (0)
> +

This is not what "orthogonal" means.  If the bits were orthogonal, the
logic would be:

if (gnu_property & DISABLE_VSYSCALL)
  disable vsyscall;
if (gnu_property & SHSTK)
  enable SHSTK;
if (gnu_property & IBT);
  enable IBT;

and, if necessarily (although I still think it would be preferable not
to do this):

if ((gnu_property & (DISABLE_VSYSCALL | SHSTK)) == SHSTK)
  return -EINVAL;

As far as I'm concerned, you have two choices:

a) Make SHSTK work *correctly* with vsyscall emulation.

b) Add a high quality mechanism to disable vsyscall emulation and make
SHSTK depend on that.

As far as I'm concerned, (a) is preferable.  Ideally we'd get (a)
*and* a high quality vsyscall emulation disable mechanism with no
dependencies.


> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c
> b/arch/x86/entry/vsyscall/vsyscall_64.c
> index 44c33103a955..fe8f3db6d21b 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -127,6 +127,9 @@ bool emulate_vsyscall(unsigned long error_code,
>         long ret;
>         unsigned long orig_dx;
>
> +       if (test_thread_flag(TIF_VSYSCALL_DISABLE))
> +               return false;
> +

This needs to be per-mm, not per-thread.  There's a patch floating
around that gets us about a quarter of the way there.  I'm not
convinced that CET should wait for this to finish.
