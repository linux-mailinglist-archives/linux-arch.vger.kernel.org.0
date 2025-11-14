Return-Path: <linux-arch+bounces-14791-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD34FC5ECF4
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 19:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8032D3B87A0
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 18:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BC333B6F8;
	Fri, 14 Nov 2025 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jK8r0yvs"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEB82DA759;
	Fri, 14 Nov 2025 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144045; cv=none; b=eo7WqkiDoYJQ4GheoKAUWRm3GjCzyzv79Sm8mNeZP+OwNdxeP2YkRBXrIthH6Fe6aROy5VAiZ0BsCMxB1LHSSJwMkhMC7BCrKDl+1/01C25DbLN2Llv6ZTHk9SKtxBQ4zueqTskc33c1cT4AxZApP44lt83Kwnpvemd1D8IAPCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144045; c=relaxed/simple;
	bh=o+j5swFsnXgCqnE0eg6/H67kOI6QLdqW9fhbdgj4dN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLhN5E2nwXzGA8qxUCTISNIt64JsAbKFBpGRszF3TjbpR+GjhCkCSDJd1/eMMX1U/0lFebYeGRPCzb0iHZkLU6kaJcPHUSlqawNYClP4CXpaRO2iGNRFF/xYrXruQmjuMsMLteeWwJEERsxmsyN/heIqrBkcG4L3H7VX0RjXSv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jK8r0yvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5640C116B1;
	Fri, 14 Nov 2025 18:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763144044;
	bh=o+j5swFsnXgCqnE0eg6/H67kOI6QLdqW9fhbdgj4dN0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jK8r0yvsojY1rymY5knaXU/LO05zt8VRVgkyIxC7vQXIdN1SVPl5xhqyRA3ej7V5m
	 ZWVrw8lkCNfk1Bad7grOXshhcg0EoS0VYkJgVr8pwVjwQbXwDCnVmSpIKyVZcME/i9
	 3/KkH0B6hEgPEGvxRQ31RiaEdmyWfGw2B5TeafY8uJLJoR1IkF5rrl/4IerK9Tshaj
	 vX39a9LLOQ/BSkJ5+Tyodr09pvrvJb5B4ctrUoh9jdpCMNfmQiGJhsOYJZHFqb68Nf
	 Bf3vHlOW/b768iOvaBfw3TWNnIUk72mAhEfgKx4h81AEU5WAMUatwzdzSeoimZaxns
	 ToBGK/+oL0Xww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 13468CE0CA7; Fri, 14 Nov 2025 10:14:04 -0800 (PST)
Date: Fri, 14 Nov 2025 10:14:04 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org, rcu@vger.kernel.org,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Han Shen <shenhan@google.com>, Rik van Riel <riel@surriel.com>,
	Jann Horn <jannh@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Oleg Nesterov <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [PATCH v7 00/31] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
Message-ID: <89398bdf-4dad-4976-8eb9-1e86032c8794@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251114150133.1056710-1-vschneid@redhat.com>
 <c4768cf3-f131-44e6-9b25-ebeb633f32ee@app.fastmail.com>
 <beb46a02-b902-438b-8b6d-b5f0d7ad0ae6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beb46a02-b902-438b-8b6d-b5f0d7ad0ae6@app.fastmail.com>

On Fri, Nov 14, 2025 at 09:22:35AM -0800, Andy Lutomirski wrote:
> 
> 
> On Fri, Nov 14, 2025, at 8:20 AM, Andy Lutomirski wrote:
> > On Fri, Nov 14, 2025, at 7:01 AM, Valentin Schneider wrote:
> >> Context
> >> =======
> >>
> >> We've observed within Red Hat that isolated, NOHZ_FULL CPUs running a
> >> pure-userspace application get regularly interrupted by IPIs sent from
> >> housekeeping CPUs. Those IPIs are caused by activity on the housekeeping CPUs
> >> leading to various on_each_cpu() calls, e.g.:
> >>
> >
> >> The heart of this series is the thought that while we cannot remove NOHZ_FULL
> >> CPUs from the list of CPUs targeted by these IPIs, they may not have to execute
> >> the callbacks immediately. Anything that only affects kernelspace can wait
> >> until the next user->kernel transition, providing it can be executed "early
> >> enough" in the entry code.
> >>
> >
> > I want to point out that there's another option here, although anyone 
> > trying to implement it would be fighting against quite a lot of history.
> >
> > Logically, each CPU is in one of a handful of states: user mode, idle, 
> > normal kernel mode (possibly subdivided into IRQ, etc), and a handful 
> > of very narrow windows, hopefully uninstrumented and not accessing any 
> > PTEs that might be invalid, in the entry and exit paths where any state 
> > in memory could be out of sync with actual CPU state.  (The latter 
> > includes right after the CPU switches to kernel mode, for example.)  
> > And NMI and MCE and whatever weird "security" entry types that Intel 
> > and AMD love to add.
> >
> > The way the kernel *currently* deals with this has two big historical oddities:
> >
> > 1. The entry and exit code cares about ti_flags, which is per-*task*, 
> > which means that atomically poking it from other CPUs involves the 
> > runqueue lock or other shenanigans (see the idle nr_polling code for 
> > example), and also that it's not accessible from the user page tables 
> > if PTI is on.
> >
> > 2. The actual heavyweight atomic part (context tracking) was built for 
> > RCU, and it's sort or bolted on, and, as you've observed in this 
> > series, it's really quite awkward to do things that aren't RCU using 
> > context tracking.
> >
> > If this were a greenfield project, I think there's a straightforward 
> > approach that's much nicer: stick everything into a single percpu flags 
> > structure.  Imagine we have cpu_flags, which tracks both the current 
> > state of the CPU and what work needs to be done on state changes.  On 
> > exit to user mode, we would atomically set the mode to USER and make 
> > sure we don't touch anything like vmalloc space after that.  On entry 
> > back to kernel mode, we would avoid vmalloc space, etc, then atomically 
> > switch to kernel mode and read out whatever deferred work is needed.  
> > As an optimization, if nothing in the current configuration needs 
> > atomic state tracking, the state could be left at USER_OR_KERNEL and 
> > the overhead of an extra atomic op at entry and exit could be avoided.
> >
> > And RCU would hook into *that* instead of having its own separate set of hooks.

Please note that RCU needs to sample a given CPU's idle state from other
CPUs, and to have pretty heavy-duty ordering guarantees.  This is needed
to avoid RCU needing to wake up idle CPUs on the one hand or relying on
scheduling-clock interrupts waking up idle CPUs on the other.

Or am I missing the point of your suggestion?

> > I think that actually doing this would be a big improvement and would 
> > also be a serious project.  There's a lot of code that would get 
> > touched, and the existing context tracking code is subtle and 
> > confusing.  And, as mentioned, ti_flags has the wrong scope.

Serious care would certainly be needed!  ;-)

> > It's *possible* that one could avoid making ti_flags percpu either by 
> > extensive use of the runqueue locks or by borrowing a kludge from the 
> > idle code.  For the latter, right now, the reason that the 
> > wake-from-idle code works is that the optimized path only happens if 
> > the idle thread/cpu is "polling", and it's impossible for the idle 
> > ti_flags to be polling while the CPU isn't actually idle.  We could 
> > similarly observe that, if a ti_flags says it's in USER mode *and* is 
> > on, say, cpu 3, then cpu 3 is most definitely in USER mode.  So someone 
> > could try shoving the CPU number into ti_flags :-p   (USER means 
> > actually user or in the late exit / early entry path.)
> >
> > Anyway, benefits of this whole approach would include considerably 
> > (IMO) increased comprehensibility compared to the current tangled ct 
> > code and much more straightforward addition of new things that happen 
> > to a target CPU conditionally depending on its mode.  And, if the flags 
> > word was actually per cpu, it could be mapped such that 
> > SWITCH_TO_KERNEL_CR3 would use it -- there could be a single CR3 write 
> > (and maybe CR4/invpcid depending on whether a zapped mapping is global) 
> > and the flush bit could depend on whether a flush is needed.  And there 
> > would be basically no chance that a bug that accessed 
> > invalidated-but-not-flushed kernel data could be undetected -- in PTI 
> > mode, any such access would page fault!  Similarly, if kernel text 
> > pokes deferred the flush and serialization, the only code that could 
> > execute before noticing the deferred flush would be the user-CR3 code.
> >
> > Oh, any another primitive would be possible: one CPU could plausibly 
> > execute another CPU's interrupts or soft-irqs or whatever by taking a 
> > special lock that would effectively pin the remote CPU in user mode -- 
> > you'd set a flag in the target cpu_flags saying "pin in USER mode" and 
> > the transition on that CPU to kernel mode would then spin on entry to 
> > kernel mode and wait for the lock to be released.  This could plausibly 
> > get a lot of the on_each_cpu callers to switch over in one fell swoop: 
> > anything that needs to synchronize to the remote CPU but does not need 
> > to poke its actual architectural state could be executed locally while 
> > the remote CPU is pinned.

It would be necessary to arrange for the remote CPU to remain pinned
while the local CPU executed on its behalf.  Does the above approach
make that happen without re-introducing our current context-tracking
overhead and complexity?

> Following up, I think that x86 can do this all with a single atomic (in the common case) per usermode round trip.  Imagine:
> 
> struct fancy_cpu_state {
>   u32 work; // <-- writable by any CPU
>   u32 status; // <-- readable anywhere; writable locally
> };
> 
> status includes KERNEL, USER, and maybe INDETERMINATE.  (INDETERMINATE means USER but we're not committing to doing work.)
> 
> Exit to user mode:
> 
> atomic_set(&my_state->status, USER);

We need ordering in the RCU nohz_full case.  If the grace-period kthread
sees the status as USER, all the preceding KERNEL code's effects must
be visible to the grace-period kthread.

> (or, in the lazy case, set to INDETERMINATE instead.)
> 
> Entry from user mode, with IRQs off, before switching to kernel CR3:
> 
> if (my_state->status == INDETERMINATE) {
>   // we were lazy and we never promised to do work atomically.
>   atomic_set(&my_state->status, KERNEL);
>   this_entry_work = 0;
> } else {
>   // we were not lazy and we promised we would do work atomically
>   atomic exchange the entire state to { .work = 0, .status = KERNEL }
>   this_entry_work = (whatever we just read);
> }

If this atomic exchange is fully ordered (as opposed to, say, _relaxed),
then this works in that if the grace-period kthread sees USER, its prior
references are guaranteed not to see later kernel-mode references from
that CPU.

> if (PTI) {
>   switch to kernel CR3 *and flush if this_entry_work says to flush*
> } else {
>   flush if this_entry_work says to flush;
> }
> 
> do the rest of the work;
> 
> 
> 
> I suppose that a lot of the stuff in ti_flags could merge into here, but it could be done one bit at a time when people feel like doing so.  And I imagine, but I'm very far from confident, that RCU could use this instead of the current context tracking code.

RCU currently needs pretty heavy-duty ordering to reliably detect the
other CPUs' quiescent states without needing to wake them from idle, or,
in the nohz_full case, interrupt their userspace execution.  Not saying
it is impossible, but it will need extreme care.

> The idea behind INDETERMINATE is that there are plenty of workloads that frequently switch between user and kernel mode and that would rather accept a few IPIs to avoid the heavyweight atomic operation on user -> kernel transitions.  So the default behavior could be to do KERNEL -> INDETERMINATE instead of KERNEL -> USER, but code that wants to be in user mode for a long time could go all the way to USER.  We could make it sort of automatic by noticing that we're returning from an IRQ without a context switch and go to USER (so we would get at most one unneeded IPI per normal user entry), and we could have some nice API for a program that intends to hang out in user mode for a very long time (cpu isolation users, for example) to tell the kernel to go immediately into USER mode.  (Don't we already have something that could be used for this purpose?)

RCU *could* do an smp_call_function_single() when the CPU failed
to respond, perhaps in a manner similar to how it already forces a
given CPU out of nohz_full state if that CPU has been executing in the
kernel for too long.  The real-time guys might not be amused, though.
Especially those real-time guys hitting sub-microsecond latencies.

> Hmm, now I wonder if it would make sense for the default behavior of Linux to be like that.  We could call it ONEHZ.  It's like NOHZ_FULL except that user threads that don't do syscalls get one single timer tick instead of many or none.
> 
> 
> Anyway, I think my proposal is pretty good *if* RCU could be made to use it -- the existing context tracking code is fairly expensive, and I don't think we want to invent a new context-tracking-like mechanism if we still need to do the existing thing.

If you build with CONFIG_NO_HZ_FULL=n, do you still get the heavyweight
operations when transitioning between kernel and user execution?

							Thanx, Paul

