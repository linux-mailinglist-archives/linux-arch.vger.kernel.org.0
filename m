Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7A536E21A
	for <lists+linux-arch@lfdr.de>; Thu, 29 Apr 2021 01:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhD1XVr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 19:21:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:64609 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229762AbhD1XVq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Apr 2021 19:21:46 -0400
IronPort-SDR: m8YbVTk4MRTQhtrAmssv13nqEqiStmC64357fBvY1XH8+ByTlArMRZJNB2QC96F3EcNSJiMv+k
 D27y/qReIefg==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="260827167"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="260827167"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 16:21:00 -0700
IronPort-SDR: TrwTu1/OF8qs0lC1qNUs2nYoZwr4G8MCIAphjrqGp83fIaNWNKuTxX4Q1GfaiIOSsr6MsZZgUl
 E5u9Shlt5ILA==
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="430555433"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.133.34]) ([10.209.133.34])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 16:20:56 -0700
Subject: Re: extending ucontext (Re: [PATCH v26 25/30] x86/cet/shstk: Handle
 signals for shadow stack)
To:     Andy Lutomirski <luto@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
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
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-26-yu-cheng.yu@intel.com>
 <CALCETrVTeYfzO-XWh+VwTuKCyPyp-oOMGH=QR_msG9tPQ4xPmA@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <f6e61dae-9805-c855-8873-7481ceb7ea79@intel.com>
Date:   Wed, 28 Apr 2021 16:20:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVTeYfzO-XWh+VwTuKCyPyp-oOMGH=QR_msG9tPQ4xPmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/28/2021 4:03 PM, Andy Lutomirski wrote:
> On Tue, Apr 27, 2021 at 1:44 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>
>> When shadow stack is enabled, a task's shadow stack states must be saved
>> along with the signal context and later restored in sigreturn.  However,
>> currently there is no systematic facility for extending a signal context.
>> There is some space left in the ucontext, but changing ucontext is likely
>> to create compatibility issues and there is not enough space for further
>> extensions.
>>
>> Introduce a signal context extension struct 'sc_ext', which is used to save
>> shadow stack restore token address.  The extension is located above the fpu
>> states, plus alignment.  The struct can be extended (such as the ibt's
>> wait_endbr status to be introduced later), and sc_ext.total_size field
>> keeps track of total size.
> 
> I still don't like this.
> 
> Here's how the signal layout works, for better or for worse:
> 
> The kernel has:
> 
> struct rt_sigframe {
>      char __user *pretcode;
>      struct ucontext uc;
>      struct siginfo info;
>      /* fp state follows here */
> };
> 
> This is roughly the actual signal frame.  But userspace does not have
> this struct declared, and user code does not know the sizes of the
> fields.  So it's accessed in a nonsensical way.  The signal handler
> function is passed a pointer to the whole sigframe implicitly in RSP,
> a pointer to &frame->info in RSI, anda pointer to &frame->uc in RDX.
> User code can *find* the fp state by following a pointer from
> mcontext, which is, in turn, found via uc:
> 
> struct ucontext {
>      unsigned long      uc_flags;
>      struct ucontext  *uc_link;
>      stack_t          uc_stack;
>      struct sigcontext uc_mcontext;  <-- fp pointer is in here
>      sigset_t      uc_sigmask;    /* mask last for extensibility */
> };
> 
> The kernel, in sigreturn, works a bit differently.  The sigreturn
> variants know the base address of the frame but don't have the benefit
> of receiving pointers to the fields.  So instead the kernel takes
> advantage of the fact that it knows the offset to uc and parses uc
> accordingly.  And the kernel follows the pointer in mcontext to find
> the fp state.  The latter bit is quite important later.  The kernel
> does not parse info at all.
> 
> The fp state is its own mess.  When XSAVE happened, Intel kindly (?)
> gave us a software defined area between the "legacy" x87 region and
> the modern supposedly extensible part.  Linux sticks the following
> structure in that hole:
> 
> struct _fpx_sw_bytes {
>      /*
>       * If set to FP_XSTATE_MAGIC1 then this is an xstate context.
>       * 0 if a legacy frame.
>       */
>      __u32                magic1;
> 
>      /*
>       * Total size of the fpstate area:
>       *
>       *  - if magic1 == 0 then it's sizeof(struct _fpstate)
>       *  - if magic1 == FP_XSTATE_MAGIC1 then it's sizeof(struct _xstate)
>       *    plus extensions (if any)
>       */
>      __u32                extended_size;
> 
>      /*
>       * Feature bit mask (including FP/SSE/extended state) that is present
>       * in the memory layout:
>       */
>      __u64                xfeatures;
> 
>      /*
>       * Actual XSAVE state size, based on the xfeatures saved in the layout.
>       * 'extended_size' is greater than 'xstate_size':
>       */
>      __u32                xstate_size;
> 
>      /* For future use: */
>      __u32                padding[7];
> };
> 
> 
> That's where we are right now upstream.  The kernel has a parser for
> the FPU state that is bugs piled upon bugs and is going to have to be
> rewritten sometime soon.  On top of all this, we have two upcoming
> features, both of which require different kinds of extensions:
> 
> 1. AVX-512.  (Yeah, you thought this story was over a few years ago,
> but no.  And AMX makes it worse.)  To make a long story short, we
> promised user code many years ago that a signal frame fit in 2048
> bytes with some room to spare.  With AVX-512 this is false.  With AMX
> it's so wrong it's not even funny.  The only way out of the mess
> anyone has come up with involves making the length of the FPU state
> vary depending on which features are INIT, i.e. making it more compact
> than "compact" mode is.  This has a side effect: it's no longer
> possible to modify the state in place, because enabling a feature with
> no space allocated will make the structure bigger, and the stack won't
> have room.  Fortunately, one can relocate the entire FPU state, update
> the pointer in mcontext, and the kernel will happily follow the
> pointer.  So new code on a new kernel using a super-compact state
> could expand the state by allocating new memory (on the heap? very
> awkwardly on the stack?) and changing the pointer.  For all we know,
> some code already fiddles with the pointer.  This is great, except
> that your patch sticks more data at the end of the FPU block that no
> one is expecting, and your sigreturn code follows that pointer, and
> will read off into lala land.
> 
> 2. CET.  CET wants us to find a few more bytes somewhere, and those
> bytes logically belong in ucontext, and here we are.
> 
> This is *almost*, but not quite, easy: struct ucontext is already
> variable length!  Unfortunately, the whole variable length portion is
> used up by uc_sigmask.  So I propose that we introduce a brand new
> bona fide extension mechanism.  It works like this:
> 
> First, we add a struct ucontext_extension at the end.  It looks like:
> 
> struct ucontext_extension {
>    u64 length;  /* sizeof(struct ucontext_extension) */
>    u64 flags;  /* we will want this some day */
>    [CET stuff here]
>    [future stuff here]
> };
> 
> And we locate it by scrounging a word somewhere in ucontext to give
> the offset from the beginning of struct ucontext to
> ucontext_extension.  We indicate the presence of this feature using a
> new uc_flags bit.  I can think of a couple of vaguely reasonable
> places:
> 
> a) the reserved word in sigcontext.  This is fine for x86 but not so
> great if other architectures want to do this.
> 
> b) uc_link.  Fine everywhere but powerpc.  Oops.
> 
> c) use the high bits of uc_flags.  After all, once we add extensions,
> we don't need new flags, so we can steal 16 high bits of uc_flags for
> this.
> 
> I think I'm in favor of (c).  We do:
> 
> (uc_flags & 0xffff0000) == 0: extension not present
> 
> Otherwise the extension region is at ucontext + (uc_flags >> 16).
> 
> And sigreturn finds the extension the same way, because CRIU can
> already migrate a signal frame from one kernel to another, your patch
> breaks this, and having sigreturn hardcode the offset would also break
> it.
> 
> What do you think?
> 

There are a lot of things in here.  I think I could create some patches 
for ucontext_extension and send out for discussion.  Thanks for 
explaining this!

Yu-cheng
