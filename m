Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490851D5CC2
	for <lists+linux-arch@lfdr.de>; Sat, 16 May 2020 01:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgEOX3W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 19:29:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:35114 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgEOX3W (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 19:29:22 -0400
IronPort-SDR: Te6tVlZ4H8esYvBKf4VzLXeM4UeBIK5Owu2s8FoNo2AiM7caw3MSqucV4LYHX7ZeyYyA6KSXk1
 U7YH+49adwVQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 16:29:21 -0700
IronPort-SDR: IoQHQ7Aja3QhD6qRzWqPVBUWBoQOL1EJr/FpkY+SCYqCGUk+vxeiaxlkUzDDbh5UCksehvEAzg
 qGF6fDvwNfJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; 
   d="scan'208";a="263345083"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga003.jf.intel.com with ESMTP; 15 May 2020 16:29:20 -0700
Message-ID: <b09658f92eb66c1d1be509813939b9ed827f9cf0.camel@intel.com>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
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
Date:   Fri, 15 May 2020 16:29:25 -0700
In-Reply-To: <32235ffc-6e6c-fb3d-80c4-a0478e2d0e0f@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
         <20200429220732.31602-2-yu-cheng.yu@intel.com>
         <b5197a8d-5d8b-e1f7-68d4-58d80261904c@intel.com>
         <dd5b9bab31ecf247a0b4890e22bfbb486ff52001.camel@intel.com>
         <5cc163ff9058d1b27778e5f0a016c88a3b1a1598.camel@intel.com>
         <b0581ddc-0d99-cbcf-278e-0be55ba939a0@intel.com>
         <44c055342bda4fb4730703f987ae35195d1d0c38.camel@intel.com>
         <32235ffc-6e6c-fb3d-80c4-a0478e2d0e0f@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2020-05-15 at 15:43 -0700, Dave Hansen wrote:
> On 5/15/20 2:33 PM, Yu-cheng Yu wrote:
> > On Fri, 2020-05-15 at 11:39 -0700, Dave Hansen wrote:
> > > On 5/12/20 4:20 PM, Yu-cheng Yu wrote:
> > > Can a binary compiled with CET run without CET?
> > 
> > Yes, but a few details:
> > 
> > - The shadow stack is transparent to the application.  A CET application does
> > not have anything different from a non-CET application.  However, if a CET
> > application uses any CET instructions (e.g. INCSSP), it must first check if CET
> > is turned on.
> > - If an application is compiled for IBT, the compiler inserts ENDBRs at branch
> > targets.  These are nops if IBT is not on.
> 
> I appreciate the detailed response, but it wasn't quite what I was
> asking.  Let's ignore IBT for now and just talk about shadow stacks.
> 
> An app compiled with the new ELF flags and running on a CET-enabled
> kernel and CPU will start off with shadow stacks allocated and enabled,
> right?  It can turn its shadow stack off per-thread with the new prctl.
>  But, otherwise, it's stuck, the only way to turn shadow stacks off at
> startup would be editing the binary.
> 
> Basically, if there ends up being a bug in an app that violates the
> shadow stack rules, the app is broken, period.  The only recourse is to
> have the kernel disable CET and reboot.
> 
> Is that right?

You must be talking about init or any of the system daemons, right?
Assuming we let the app itself start CET with an arch_prctl(), why would that be
different from the current approach?

> > > Can a binary compiled without CET run CET-enabled code?
> > 
> > Partially yes, but in reality somewhat difficult.
> ...
> > - If a not-CET application does fork(), and the child wants to turn on CET, it
> > would be difficult to manage the stack frames, unless the child knows what is is
> > doing.  
> 
> It might be hard to do, but it is possible with the patches you posted?

It is possible to add an arch_prctl() to turn on CET.  That is simple from the
kernel's perspective, but difficult for the application.  Once the app enables
shadow stack, it has to take care not to return beyond the function call layers
before that point.  It can no longer do longjmp or ucontext swaps to anything
before that point.  It will also be complicated if the app enables shadow stack
in a signal handler.

>  I think you're saying that the CET-enabled binary would do
> arch_setup_elf_property() when it was first exec()'d.  Later, it could
> use the new prctl(ARCH_X86_CET_DISABLE) to disable its shadow stack,
> then fork() and the child would not be using CET.  Right?
> 
> What is ARCH_X86_CET_DISABLE used for, anyway?

Both the parent and the child can do ARCH_X86_CET_DISABLE, if CET is not locked.

> > The JIT examples I mentioned previously run with CET enabled from the
> > beginning.  Do you have a reason to do this?  In other words, if the JIT code
> > needs CET, the app could have started with CET in the first place.
> 
> Let's say I have a JIT'd sandbox.  I want the sandbox to be
> CET-protected, but the JIT engine itself not to be.

I do not have any objections to this use case, but it needs some cautions as
stated above.  It will be much easier and cleaner if the sandbox is in a
separate exec'ed task with CET on.

> > - If you are asking about dlopen(), the library will have the same setting as
> > the main application.  Do you have any reason to have a library running with
> > CET, but the application does not have CET?
> 
> Sure, using old binaries.  That's why IBT has a legacy bitmap and things
> like MPX had ways of jumping into old non-enabled binaries.

If the app has CET, but libs do not, then bitmap can help.
If the app does not have CET, we don't run the libs with CET, right?  This is
the case right now.

> > > Can different threads in a process have different CET enabling state?
> > 
> > Yes, if the parent starts with CET, children can turn it off.
> 
> How would that work, though?  clone() by default will copy the parent
> xsave state, which means it will be CET-enabled, which means it needs a
> shadow stack.  So, if I want a CET-free child thread, I need to clone(),
> then turn CET off, then free the shadow stack?

Yes, the child itself turns off CET.

> > > Does this *code* work?  Could you please indicate which JITs have been
> > > enabled to use the code in this series?  How much of the new ABI is in use?
> > 
> > JIT does not necessarily use all of the ABI.  The JIT changes mainly fix stack
> > frames and insert ENDBRs.  I do not work on JIT.  What I found is LLVM JIT fixes
> > are tested and in the master branch.  Sljit fixes are in the release.
> 
> Huh, so who is using the new prctl() ABIs?

Any code can use the ABI, but JIT code CET-enabling part mostly do not use these
new prctl()'s, except, probably to get CET status.

> > > Where are the selftests/ for this new ABI?  Were you planning on
> > > submitting any with this series?
> > 
> > The ABI is more related to the application side, and therefore most suitable for
> > GLIBC unit tests.
> 
> I was mostly concerned with the kernel selftests.  The things in
> tools/testing/selftests/x86 in the kernel tree.

I have run them with CET enabled.  All of them pass, except for the following:
Sigreturn from 64-bit to 32-bit fails, because shadow stack is at a 64-bit
address.  This is understandable.

> > The more complicated areas such as pthreads, signals, ucontext,
> > fork() are all included there.  I have been constantly running these 
> > tests without any problems.  I can provide more details if testing is
> > the concern.
> 
> For something this complicated, with new kernel ABIs, we need an
> in-kernel sefltest.
> 
> MPX was not that much different from this feature.  It required a
> boatload of compiler and linker changes to function.  Yet, there was a
> simple in-kernel test for it that didn't require *any* of that big pile
> of toolchain bits.
> 
> Is there a reason we don't have one of those for CET?

I have a quick test that checks shadow stack and ibt in both main program and in
signals.  Currently it is public on Github.  If that is desired, I can submit it
to the mailing list.

Yu-cheng

