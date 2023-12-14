Return-Path: <linux-arch+bounces-1062-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F79813B97
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 21:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F941F214C3
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 20:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B986D1B1;
	Thu, 14 Dec 2023 20:35:51 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C136D1AD;
	Thu, 14 Dec 2023 20:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B920C433C8;
	Thu, 14 Dec 2023 20:35:48 +0000 (UTC)
Date: Thu, 14 Dec 2023 15:36:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Remove 32bit timestamp logic
Message-ID: <20231214153636.655e18ce@gandalf.local.home>
In-Reply-To: <CAHk-=wjjGEc0f4LLDxCTYvgD98kWqKy=89u=42JLRz5Qs3KKyA@mail.gmail.com>
References: <20231213211126.24f8c1dd@gandalf.local.home>
	<20231213214632.15047c40@gandalf.local.home>
	<CAHk-=whESMW2v0cd0Ye+AnV0Hp9j+Mm4BO2xJo93eQcC1xghUA@mail.gmail.com>
	<20231214115614.2cf5a40e@gandalf.local.home>
	<CAHk-=wjjGEc0f4LLDxCTYvgD98kWqKy=89u=42JLRz5Qs3KKyA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 11:44:55 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 14 Dec 2023 at 08:55, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > And yes, this does get called in NMI context.  
> 
> Not on an i486-class machine they won't. You don't have a local apic
> on those, and they won't have any NMI sources under our control (ie
> NMI does exist, but we're talking purely legacy NMI for "motherboard
> problems" like RAM parity errors etc)

Ah, so we should not worry about being in NMI context without a 64bit cmpxchg?

> 
> > I had a patch that added:
> >
> > +       /* ring buffer does cmpxchg, make sure it is safe in NMI context */
> > +       if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) &&
> > +           (unlikely(in_nmi()))) {
> > +               return NULL;
> > +       }  
> 
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG doesn't work on x86 in this context,
> because the issue is that yes, there's a safe 'cmpxchg', but that's
> not what you want.

Sorry, that's from another patch that I combined into this one that I added
in case there's architectures that have NMIs but need to avoid cmpxchg, as
this code does normal long word cmpxchg too. And that change *should* go to
you and stable. It's either just luck that things didn't crash on those
systems today. Or it happens so infrequently, nobody reported it.

> 
> You want the save cmpxchg64, which is an entirely different beast.

Understood, but this code has both. It's just that the "special" code I'm
removing does the 64-bit cmpxchg.

> 
> And honestly, I don't think that NMI_SAFE_CMPXCHG covers the
> double-word case anywhere else either, except purely by luck.

I still need to cover the normal cmpxchg. I'll keep that a separate patch.

> 
> In mm/slab.c, we also use a double-wide cmpxchg, and there the rule
> has literally been that it's conditional on
> 
>  (a) system_has_cmpxchg64() existing as a macro
> 
>  (b) using that macro to then gate - at runtime - whether it actually
> works or not
> 
> I think - but didn't check - that we essentially only enable the
> two-word case on x86 as a result, and fall back to the slow case on
> all other architectures - and on the i486 case.
> 
> That said, other architectures *do* have a working double-word
> cmpxchg, but I wouldn't guarantee it. For example, 32-bit arm does
> have one using ldrexd/strexd, but that only exists on arm v6+.
> 
> And guess what? You'll silently get a "disable interrupts, do it as a
> non-atomic load-store" on arm too for that case. And again, pre-v6 arm
> is about as relevant as i486 is, but my point is, that double-word
> cmpxchg you rely on simply DOES NOT EXIST on 32-bit platforms except
> under special circumstances.
> 
> So this isn't a "x86 is the odd man out". This is literally generic.
> 
> > Now back to my original question. Are you OK with me sending this to you
> > now, or should I send you just the subtle fixes to the 32-bit rb_time_*
> > code and keep this patch for the merge window?  
> 
> I'm absolutely not taking some untested random "let's do 64-bit
> cmpxchg that we know is broken on 32-bit using broken conditionals"
> shit.
> 
> What *would* work is that slab approach, which is essentially
> 
>   #ifndef system_has_cmpxchg64
>       #define system_has_cmpxchg64() false
>   #endif
> 
>         ...
>         if (!system_has_cmpxchg64())
>                 return error or slow case
> 
>         do_64bit_cmpxchg_case();
> 
> (although the slub case is much more indirect, and uses a
> __CMPXCHG_DOUBLE flag that only gets set when that define exists etc).
> 
> But that would literally cut off support for all non-x86 32-bit architectures.
> 
> So no. You need to forget about the whole "do a 64-bit cmpxchg on
> 32-bit architectures" as being some kind of solution in the short
> term.

But do all archs have an implementation of cmpxchg64, even if it requires
disabling interrupts? If not, then I definitely cannot remove this code.

If they all have an implementation, where some is just very slow, then that
is also perfectly fine. The only time cmpxchg64 gets called is on the slow
path, which is if an event is interrupted by an interrupt, and that
interrupt writes an event to the same buffer.

This doesn't happen often, and if it requires disabling interrupts, then
it shouldn't be much notice.

I just want to avoid the case that it will simply break, which is the NMI
case. In which case, would:

	if (!system_has_cmpxchg64() && in_nmi())
		return NULL;

Be OK?

-- Steve


