Return-Path: <linux-arch+bounces-1039-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 138A1813708
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 17:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02451F220CB
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 16:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E37E63DC4;
	Thu, 14 Dec 2023 16:55:30 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3875261FD8;
	Thu, 14 Dec 2023 16:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA510C433C8;
	Thu, 14 Dec 2023 16:55:28 +0000 (UTC)
Date: Thu, 14 Dec 2023 11:56:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Remove 32bit timestamp logic
Message-ID: <20231214115614.2cf5a40e@gandalf.local.home>
In-Reply-To: <CAHk-=whESMW2v0cd0Ye+AnV0Hp9j+Mm4BO2xJo93eQcC1xghUA@mail.gmail.com>
References: <20231213211126.24f8c1dd@gandalf.local.home>
	<20231213214632.15047c40@gandalf.local.home>
	<CAHk-=whESMW2v0cd0Ye+AnV0Hp9j+Mm4BO2xJo93eQcC1xghUA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 22:53:19 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 13 Dec 2023 at 18:45, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > tl;dr;  The ring-buffer timestamp requires a 64-bit cmpxchg to keep the
> > timestamps in sync (only in the slow paths). I was told that 64-bit cmpxchg
> > can be extremely slow on 32-bit architectures. So I created a rb_time_t
> > that on 64-bit was a normal local64_t type, and on 32-bit it's represented
> > by 3 32-bit words and a counter for synchronization. But this now requires
> > three 32-bit cmpxchgs for where one simple 64-bit cmpxchg would do.  
> 
> It's not that a 64-bit cmpxchg is even slow. It doesn't EXIST AT ALL
> on older 32-bit x86 machines.
> 
> Which is why we have
> 
>     arch/x86/lib/cmpxchg8b_emu.S
> 
> which emulates it on machines that don't have the CX8 capability
> ("CX8" being the x86 capability flag name for the cmpxchg8b
> instruction, aka 64-bit cmpxchg).
> 
> Which only works because those older 32-bit cpu's also don't do SMP,
> so there are no SMP cache coherency issues, only interrupt atomicity
> issues.
> 
> IOW, the way to do an atomic 64-bit cmpxchg on the affected hardware
> is to simply disable interrupts.
> 
> In other words - it's not just slow.  It's *really* slow. As in 10x
> slower, not "slightly slower".

Ah, I'm starting to remember this for the rationale in doing it.

I should have read up on the LWN article I even wrote about it!

  https://lwn.net/Articles/831892/

  "I mentioned that I used the local64 variants of operations like
   local_read/cmpxchg/etc. operations. Desnoyers went on to argue that the
   local64 operations on 32-bit machines were horrible in performance, and
   worse, some require that interrupts be disabled, meaning that they could
   not be used in NMI context."

And yes, this does get called in NMI context.

> 
> > We started discussing how much time this is actually saving to be worth the
> > complexity, and actually found some hardware to test. One Atom processor.  
> 
> That atom processor won't actually show the issue. It's much too
> recent. So your "test" is actually worthless.
> 
> And you probably did this all with a kernel config that had
> CONFIG_X86_CMPXCHG64 set anyway, which wouldn't even boot on a i486
> machine.
> 
> So in fact your test was probably doubly broken, in that not only
> didn't you test the slow case, you tested something that wouldn't even
> have worked in the environment where the slow case happened.
> 
> Now, the real question is if anybody cares about CPUs that don't have
> cmpxchg8b support.
> 
> IBecause in practice, it's really just old 486-class machines (and a
> couple of clone manufacturers who _claimed_ to be Pentium class, but
> weren't - there was also some odd thing with Windows breaking if you
> had CPUID claiming to support CX8
> 
> We dropped support for the original 80386 some time ago. I'd actually
> be willing to drop support for ll pre-cmpxchg8b machines, and get rid
> of the emulation.
> 
> I also suspect that from a perf angle, none of this matters. The
> emulation being slow probably is a non-issue, simply because even if
> you run on an old i486 machine, you probably won't be doing perf or
> tracing on it.

Thanks for the background.

I had a patch that added:

+       /* ring buffer does cmpxchg, make sure it is safe in NMI context */
+       if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) &&
+           (unlikely(in_nmi()))) {
+               return NULL;
+       }

But for ripping out this code, I should probably change that to:

       if ((!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) ||
	    (IS_ENABLED(X86_32) && !IS_ENABLED(X86_CMPXCHG64))) &&
           unlikely(in_nmi())) {
               return NULL;
       }

Not sure if there's other architectures that are affected by this (hence
why I Cc'd linux-arch).

I don't think anyone actually cares about the performance overhead of 486
doing 64-bit cmpxchg by disabling interrupts. Especially since this only
happens in the slow path (if an event interrupts the processing of another
event). If someone complains, we can always add back this code.

Now back to my original question. Are you OK with me sending this to you
now, or should I send you just the subtle fixes to the 32-bit rb_time_*
code and keep this patch for the merge window?

My preference is to get it in now and label it as stable, but I'm fine
either way.

-- Steve

