Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159B43711C3
	for <lists+linux-arch@lfdr.de>; Mon,  3 May 2021 08:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhECG6u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 3 May 2021 02:58:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34649 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhECG6t (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 3 May 2021 02:58:49 -0400
X-Greylist: delayed 3195 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 May 2021 02:58:49 EDT
Received: from [IPv6:2601:646:8602:8be1:c08d:3145:af85:af1c] ([IPv6:2601:646:8602:8be1:c08d:3145:af85:af1c])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14363Tu2908670
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sun, 2 May 2021 23:03:30 -0700
Authentication-Results: mail.zytor.com; dkim=permerror (bad message/signature format)
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-Id: <202105030603.14363Tu2908670@mail.zytor.com>
Date:   Sun, 02 May 2021 23:03:06 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CALCETrWnxd9-dGdYsw5LC+iRffAmuSzzDQGde8nYQdFJyFYp9Q@mail.gmail.com>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com> <20210427204315.24153-26-yu-cheng.yu@intel.com> <CALCETrVTeYfzO-XWh+VwTuKCyPyp-oOMGH=QR_msG9tPQ4xPmA@mail.gmail.com> <8fd86049-930d-c9b7-379c-56c02a12cd77@intel.com> <CALCETrX9z-73wpy-SCy8NE1XfQgXAN0mCmjv0jXDDomMyS7TKg@mail.gmail.com> <CALCETrWnxd9-dGdYsw5LC+iRffAmuSzzDQGde8nYQdFJyFYp9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: extending ucontext (Re: [PATCH v26 25/30] x86/cet/shstk: Handle signals for shadow stack)
To:     Andy Lutomirski <luto@kernel.org>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
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
        Vedvyas.Shanbhogue@zytor.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

<vedvyas.shanbhogue@intel.com>,Dave Martin <Dave.Martin@arm.com>,Weijiang Yang <weijiang.yang@intel.com>,Pengfei Xu <pengfei.xu@intel.com>,Haitao Huang <haitao.huang@intel.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <2360408E-9967-469C-96AF-E8AC40044021@zytor.com>

There are a few words at the end of the FXSAVE area for software use for this reason: so we can extend the signal frame – originally to enable saving the XSAVE state but that doesn't use up the whole software available area.

On May 2, 2021 4:23:49 PM PDT, Andy Lutomirski <luto@kernel.org> wrote:
>On Fri, Apr 30, 2021 at 10:47 AM Andy Lutomirski <luto@kernel.org>
>wrote:
>>
>> On Fri, Apr 30, 2021 at 10:00 AM Yu, Yu-cheng <yu-cheng.yu@intel.com>
>wrote:
>> >
>> > On 4/28/2021 4:03 PM, Andy Lutomirski wrote:
>> > > On Tue, Apr 27, 2021 at 1:44 PM Yu-cheng Yu
><yu-cheng.yu@intel.com> wrote:
>> > >>
>> > >> When shadow stack is enabled, a task's shadow stack states must
>be saved
>> > >> along with the signal context and later restored in sigreturn. 
>However,
>> > >> currently there is no systematic facility for extending a signal
>context.
>> > >> There is some space left in the ucontext, but changing ucontext
>is likely
>> > >> to create compatibility issues and there is not enough space for
>further
>> > >> extensions.
>> > >>
>> > >> Introduce a signal context extension struct 'sc_ext', which is
>used to save
>> > >> shadow stack restore token address.  The extension is located
>above the fpu
>> > >> states, plus alignment.  The struct can be extended (such as the
>ibt's
>> > >> wait_endbr status to be introduced later), and sc_ext.total_size
>field
>> > >> keeps track of total size.
>> > >
>> > > I still don't like this.
>> > >
>> > > Here's how the signal layout works, for better or for worse:
>> > >
>> > > The kernel has:
>> > >
>> > > struct rt_sigframe {
>> > >      char __user *pretcode;
>> > >      struct ucontext uc;
>> > >      struct siginfo info;
>> > >      /* fp state follows here */
>> > > };
>> > >
>> > > This is roughly the actual signal frame.  But userspace does not
>have
>> > > this struct declared, and user code does not know the sizes of
>the
>> > > fields.  So it's accessed in a nonsensical way.  The signal
>handler
>> > > function is passed a pointer to the whole sigframe implicitly in
>RSP,
>> > > a pointer to &frame->info in RSI, anda pointer to &frame->uc in
>RDX.
>> > > User code can *find* the fp state by following a pointer from
>> > > mcontext, which is, in turn, found via uc:
>> > >
>> > > struct ucontext {
>> > >      unsigned long      uc_flags;
>> > >      struct ucontext  *uc_link;
>> > >      stack_t          uc_stack;
>> > >      struct sigcontext uc_mcontext;  <-- fp pointer is in here
>> > >      sigset_t      uc_sigmask;    /* mask last for extensibility
>*/
>> > > };
>> > >
>> > > The kernel, in sigreturn, works a bit differently.  The sigreturn
>> > > variants know the base address of the frame but don't have the
>benefit
>> > > of receiving pointers to the fields.  So instead the kernel takes
>> > > advantage of the fact that it knows the offset to uc and parses
>uc
>> > > accordingly.  And the kernel follows the pointer in mcontext to
>find
>> > > the fp state.  The latter bit is quite important later.  The
>kernel
>> > > does not parse info at all.
>> > >
>> > > The fp state is its own mess.  When XSAVE happened, Intel kindly
>(?)
>> > > gave us a software defined area between the "legacy" x87 region
>and
>> > > the modern supposedly extensible part.  Linux sticks the
>following
>> > > structure in that hole:
>> > >
>> > > struct _fpx_sw_bytes {
>> > >      /*
>> > >       * If set to FP_XSTATE_MAGIC1 then this is an xstate
>context.
>> > >       * 0 if a legacy frame.
>> > >       */
>> > >      __u32                magic1;
>> > >
>> > >      /*
>> > >       * Total size of the fpstate area:
>> > >       *
>> > >       *  - if magic1 == 0 then it's sizeof(struct _fpstate)
>> > >       *  - if magic1 == FP_XSTATE_MAGIC1 then it's sizeof(struct
>_xstate)
>> > >       *    plus extensions (if any)
>> > >       */
>> > >      __u32                extended_size;
>> > >
>> > >      /*
>> > >       * Feature bit mask (including FP/SSE/extended state) that
>is present
>> > >       * in the memory layout:
>> > >       */
>> > >      __u64                xfeatures;
>> > >
>> > >      /*
>> > >       * Actual XSAVE state size, based on the xfeatures saved in
>the layout.
>> > >       * 'extended_size' is greater than 'xstate_size':
>> > >       */
>> > >      __u32                xstate_size;
>> > >
>> > >      /* For future use: */
>> > >      __u32                padding[7];
>> > > };
>> > >
>> > >
>> > > That's where we are right now upstream.  The kernel has a parser
>for
>> > > the FPU state that is bugs piled upon bugs and is going to have
>to be
>> > > rewritten sometime soon.  On top of all this, we have two
>upcoming
>> > > features, both of which require different kinds of extensions:
>> > >
>> > > 1. AVX-512.  (Yeah, you thought this story was over a few years
>ago,
>> > > but no.  And AMX makes it worse.)  To make a long story short, we
>> > > promised user code many years ago that a signal frame fit in 2048
>> > > bytes with some room to spare.  With AVX-512 this is false.  With
>AMX
>> > > it's so wrong it's not even funny.  The only way out of the mess
>> > > anyone has come up with involves making the length of the FPU
>state
>> > > vary depending on which features are INIT, i.e. making it more
>compact
>> > > than "compact" mode is.  This has a side effect: it's no longer
>> > > possible to modify the state in place, because enabling a feature
>with
>> > > no space allocated will make the structure bigger, and the stack
>won't
>> > > have room.  Fortunately, one can relocate the entire FPU state,
>update
>> > > the pointer in mcontext, and the kernel will happily follow the
>> > > pointer.  So new code on a new kernel using a super-compact state
>> > > could expand the state by allocating new memory (on the heap?
>very
>> > > awkwardly on the stack?) and changing the pointer.  For all we
>know,
>> > > some code already fiddles with the pointer.  This is great,
>except
>> > > that your patch sticks more data at the end of the FPU block that
>no
>> > > one is expecting, and your sigreturn code follows that pointer,
>and
>> > > will read off into lala land.
>> > >
>> >
>> > Then, what about we don't do that at all.  Is it possible from now
>on we
>> > don't stick more data at the end, and take the relocating-fpu
>approach?
>> >
>> > > 2. CET.  CET wants us to find a few more bytes somewhere, and
>those
>> > > bytes logically belong in ucontext, and here we are.
>> > >
>> >
>> > Fortunately, we can spare CET the need of ucontext extension.  When
>the
>> > kernel handles sigreturn, the user-mode shadow stack pointer is
>right at
>> > the restore token.  There is no need to put that in ucontext.
>>
>> That seems entirely reasonable.  This might also avoid needing to
>> teach CRIU about CET at all.
>
>Wait, what's the actual shadow stack token format?  And is the token
>on the new stack or the old stack when sigaltstack is in use?  For
>that matter, is there any support for an alternate shadow stack for
>signals?
>
>--Andy

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
