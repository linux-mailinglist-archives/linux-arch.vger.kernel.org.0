Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B7B375D72
	for <lists+linux-arch@lfdr.de>; Fri,  7 May 2021 01:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhEFXcS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 May 2021 19:32:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231929AbhEFXcS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 May 2021 19:32:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7F74613E4
        for <linux-arch@vger.kernel.org>; Thu,  6 May 2021 23:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620343879;
        bh=IITCyoi4hOnQGgAjRVqRr7RtIsMxc4kk9HMuRUc4kAA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N1T6PTE+RFbWB3avXhdSDYjXOHf2b71uQ/fL3u21uoAsgpzSqs1hJmi8t9vLiEZQD
         g2JI3ttp49It3Px3GLiyljZuio2Y4JNFiUEu+9MX0hOEiEHw498EfzJwGZvLPaVnpg
         n12avQSqalGzT84BCL8hMWX4pUrMcJKLl7s1SbC1ofYM5HSIXuo+7E/uNo8GCd/5lE
         y83PyYHe69DjCpo/RiNgvNbbxRI5oH4ujIqMOPQ4j+xnnkaStQhq1ZXkCIrKXs1akQ
         FLrAGUxM2AZ56a+9dlvcD1u3W9cWAP0UPgucz1OqtLZfo2YawBsGyOGQYa8jGc8NkZ
         mu62RWDVchwtw==
Received: by mail-ej1-f54.google.com with SMTP id a4so10807952ejk.1
        for <linux-arch@vger.kernel.org>; Thu, 06 May 2021 16:31:19 -0700 (PDT)
X-Gm-Message-State: AOAM533vlPTU4y+Gh3eFNp1wKLI+B8JmO1rHjUsyE7Z/Kh0NmGIbySmd
        l4FQwpuv2WPUPilPNtYAWD6pVi6FuvmLpE7f2PnV0g==
X-Google-Smtp-Source: ABdhPJy/HzUeyVBBOPMQzBeIl7qYyB1Cn0Bw3qIUSRljI0+cxPtL7Jufl+V2qYgyD4Kr53bGa8ynkwEWn9q1gDRzC2M=
X-Received: by 2002:a17:906:c010:: with SMTP id e16mr7123175ejz.214.1620343878143;
 Thu, 06 May 2021 16:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210427204315.24153-1-yu-cheng.yu@intel.com> <20210427204315.24153-26-yu-cheng.yu@intel.com>
 <CALCETrVTeYfzO-XWh+VwTuKCyPyp-oOMGH=QR_msG9tPQ4xPmA@mail.gmail.com>
 <8fd86049-930d-c9b7-379c-56c02a12cd77@intel.com> <CALCETrX9z-73wpy-SCy8NE1XfQgXAN0mCmjv0jXDDomMyS7TKg@mail.gmail.com>
 <a7c332c8-9368-40b1-e221-ec921f7db948@intel.com> <5fc5dea4-0705-2aad-cf8f-7ff78a5e518a@intel.com>
 <bf16ab7e-bf27-68eb-efc9-c0468fb1c651@intel.com>
In-Reply-To: <bf16ab7e-bf27-68eb-efc9-c0468fb1c651@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 May 2021 16:31:06 -0700
X-Gmail-Original-Message-ID: <CALCETrWbOP_exK9cHT9vEDsQjorqC4SjhyU+gUzmGNdanO-enw@mail.gmail.com>
Message-ID: <CALCETrWbOP_exK9cHT9vEDsQjorqC4SjhyU+gUzmGNdanO-enw@mail.gmail.com>
Subject: Re: extending ucontext (Re: [PATCH v26 25/30] x86/cet/shstk: Handle
 signals for shadow stack)
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 6, 2021 at 3:05 PM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>
> On 5/4/2021 1:49 PM, Yu, Yu-cheng wrote:
> > On 4/30/2021 11:32 AM, Yu, Yu-cheng wrote:
> >> On 4/30/2021 10:47 AM, Andy Lutomirski wrote:
> >>> On Fri, Apr 30, 2021 at 10:00 AM Yu, Yu-cheng <yu-cheng.yu@intel.com>
> >>> wrote:
> >>>>
> >>>> On 4/28/2021 4:03 PM, Andy Lutomirski wrote:
> >>>>> On Tue, Apr 27, 2021 at 1:44 PM Yu-cheng Yu <yu-cheng.yu@intel.com>
> >>>>> wrote:
> >>>>>>
> >>>>>> When shadow stack is enabled, a task's shadow stack states must be
> >>>>>> saved
> >>>>>> along with the signal context and later restored in sigreturn.
> >>>>>> However,
> >>>>>> currently there is no systematic facility for extending a signal
> >>>>>> context.
> >>>>>> There is some space left in the ucontext, but changing ucontext is
> >>>>>> likely
> >>>>>> to create compatibility issues and there is not enough space for
> >>>>>> further
> >>>>>> extensions.
> >>>>>>
> >>>>>> Introduce a signal context extension struct 'sc_ext', which is
> >>>>>> used to save
> >>>>>> shadow stack restore token address.  The extension is located
> >>>>>> above the fpu
> >>>>>> states, plus alignment.  The struct can be extended (such as the
> >>>>>> ibt's
> >>>>>> wait_endbr status to be introduced later), and sc_ext.total_size
> >>>>>> field
> >>>>>> keeps track of total size.
> >>>>>
> >>>>> I still don't like this.
> >>>>>
>
> [...]
>
> >>>>>
> >>>>> That's where we are right now upstream.  The kernel has a parser for
> >>>>> the FPU state that is bugs piled upon bugs and is going to have to be
> >>>>> rewritten sometime soon.  On top of all this, we have two upcoming
> >>>>> features, both of which require different kinds of extensions:
> >>>>>
> >>>>> 1. AVX-512.  (Yeah, you thought this story was over a few years ago,
> >>>>> but no.  And AMX makes it worse.)  To make a long story short, we
> >>>>> promised user code many years ago that a signal frame fit in 2048
> >>>>> bytes with some room to spare.  With AVX-512 this is false.  With AMX
> >>>>> it's so wrong it's not even funny.  The only way out of the mess
> >>>>> anyone has come up with involves making the length of the FPU state
> >>>>> vary depending on which features are INIT, i.e. making it more compact
> >>>>> than "compact" mode is.  This has a side effect: it's no longer
> >>>>> possible to modify the state in place, because enabling a feature with
> >>>>> no space allocated will make the structure bigger, and the stack won't
> >>>>> have room.  Fortunately, one can relocate the entire FPU state, update
> >>>>> the pointer in mcontext, and the kernel will happily follow the
> >>>>> pointer.  So new code on a new kernel using a super-compact state
> >>>>> could expand the state by allocating new memory (on the heap? very
> >>>>> awkwardly on the stack?) and changing the pointer.  For all we know,
> >>>>> some code already fiddles with the pointer.  This is great, except
> >>>>> that your patch sticks more data at the end of the FPU block that no
> >>>>> one is expecting, and your sigreturn code follows that pointer, and
> >>>>> will read off into lala land.
> >>>>>
> >>>>
> >>>> Then, what about we don't do that at all.  Is it possible from now
> >>>> on we
> >>>> don't stick more data at the end, and take the relocating-fpu approach?
> >>>>
> >>>>> 2. CET.  CET wants us to find a few more bytes somewhere, and those
> >>>>> bytes logically belong in ucontext, and here we are.
> >>>>>
> >>>>
> >>>> Fortunately, we can spare CET the need of ucontext extension.  When the
> >>>> kernel handles sigreturn, the user-mode shadow stack pointer is
> >>>> right at
> >>>> the restore token.  There is no need to put that in ucontext.
> >>>
> >>> That seems entirely reasonable.  This might also avoid needing to
> >>> teach CRIU about CET at all.
> >>>
> >>>>
> >>>> However, the WAIT_ENDBR status needs to be saved/restored for signals.
> >>>> Since IBT is now dependent on shadow stack, we can use a spare bit of
> >>>> the shadow stack restore token for that.
> >>>
> >>> That seems like unnecessary ABI coupling.  We have plenty of bits in
> >>> uc_flags, and we have an entire reserved word in sigcontext.  How
> >>> about just sticking this bit in one of those places?
> >>
> >> Yes, I will make it UC_WAIT_ENDBR.
> >
> > Personally, I think an explicit flag is cleaner than using a reserved
> > word somewhere.  However, there is a small issue: ia32 has no uc_flags.
> >
> > This series can support legacy apps up to now.  But, instead of creating
> > too many special cases, perhaps we should drop CET support of ia32?
> >
> > Thoughts?

I'm really not thrilled about coupling IBT and SHSTK like this.

Here are a couple of possible solutions:

- Don't support IBT in 32-bit mode, or maybe just don't support IBT
with legacy 32-bit signals.  The actual mechanics of this could be
awkward.  Maybe we would reject the sigaction() call or the
IBT-enabling request if they conflict?

- Find some space in the signal frame for these flags.  Looking around
a bit, sigframe_ia32 has fpstate_unused, but I can imagine things like
CRIU getting very confused if it stops being unused.  sigframe_ia32
uses sigcontext_32, which has a bunch of reserved space in __gsh,
__fsh, etc.

rt_sigframe_ia32 has uc_flags, so this isn't a real problem.

I don't have a brilliant solution here.
