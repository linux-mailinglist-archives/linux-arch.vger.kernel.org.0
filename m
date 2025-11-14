Return-Path: <linux-arch+bounces-14794-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EBCC5F2D1
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 21:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 730014E58BD
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 20:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D5B326952;
	Fri, 14 Nov 2025 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD3Rt3k3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AAD312806;
	Fri, 14 Nov 2025 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763150636; cv=none; b=EooUYJl7ShILQSYQq4pElFdufPy7vilkBBwDNerWM4Sj0I+qvPv13PwXUw6LwbghDGwlH/x7r9Pch3NWKVzhgboxojXsJA6PmgQO6p+velNrqfLAlllfHxxCpGJRsJ3mzpCF4Kxx+f8s4LgcPoe9TnE+rTZT1MAkwsg8iJepfm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763150636; c=relaxed/simple;
	bh=ltEnvjxgD9o5H99nXke6/+81fhB8uRaYASSf5TBrxjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwqACnTHn6IO6iDzulLdTiMiLn45Lcvzs2B1C6k8cWP+TtaqmPz8y6rWV5FfXHxGn9bHdkxPSR4iWaeHYuO6xjGXzbdvMZTcevQDCHsdD+SxVkFdYusvDPu4EmxjUHhmRzYhj586nn9UmAJzqcDHoJdFFsM6xxPTteC21IsRcWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GD3Rt3k3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DECC116B1;
	Fri, 14 Nov 2025 20:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763150635;
	bh=ltEnvjxgD9o5H99nXke6/+81fhB8uRaYASSf5TBrxjw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=GD3Rt3k398YaNy0snptghC6M1FcoQLmz1T1NW8gFp2GlUnnx2r1VNwWRF+OrxloKM
	 Xq0krpMXxGm/MmrdoInP+AJh+3BJtEXQ1dnYis908LSwh/KtKH51I+8cZvUpBysh4U
	 8S4ZjVPwZduREnryFARAilnYZlF9rkV2TPBW13rkNdvFLLaEMCa17kUiu6kjrXrZpy
	 sYf3C8mSVL17jK+7+LXWLtbs9y+hoGyedXt2Xi8reo3XgQieX7v8I/gPH95VhJbruo
	 16YmOAJwpPV/0wptucfhkclY70FCQd76Rm7MoWYNYHPewBIJNSmo1Or/9PBal8ed1M
	 PaHLt0IphElGw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4208ECE0C91; Fri, 14 Nov 2025 12:03:55 -0800 (PST)
Date: Fri, 14 Nov 2025 12:03:55 -0800
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
Message-ID: <b3472cb3-86fa-4687-bfce-3b9a1bf4ff36@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251114150133.1056710-1-vschneid@redhat.com>
 <c4768cf3-f131-44e6-9b25-ebeb633f32ee@app.fastmail.com>
 <beb46a02-b902-438b-8b6d-b5f0d7ad0ae6@app.fastmail.com>
 <89398bdf-4dad-4976-8eb9-1e86032c8794@paulmck-laptop>
 <1a911310-4ca5-45a4-b9bf-5f37c6ab238e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a911310-4ca5-45a4-b9bf-5f37c6ab238e@app.fastmail.com>

On Fri, Nov 14, 2025 at 10:45:08AM -0800, Andy Lutomirski wrote:
> 
> 
> On Fri, Nov 14, 2025, at 10:14 AM, Paul E. McKenney wrote:
> > On Fri, Nov 14, 2025 at 09:22:35AM -0800, Andy Lutomirski wrote:
> >> 
> 
> >> > Oh, any another primitive would be possible: one CPU could plausibly 
> >> > execute another CPU's interrupts or soft-irqs or whatever by taking a 
> >> > special lock that would effectively pin the remote CPU in user mode -- 
> >> > you'd set a flag in the target cpu_flags saying "pin in USER mode" and 
> >> > the transition on that CPU to kernel mode would then spin on entry to 
> >> > kernel mode and wait for the lock to be released.  This could plausibly 
> >> > get a lot of the on_each_cpu callers to switch over in one fell swoop: 
> >> > anything that needs to synchronize to the remote CPU but does not need 
> >> > to poke its actual architectural state could be executed locally while 
> >> > the remote CPU is pinned.
> >
> > It would be necessary to arrange for the remote CPU to remain pinned
> > while the local CPU executed on its behalf.  Does the above approach
> > make that happen without re-introducing our current context-tracking
> > overhead and complexity?
> 
> Using the pseudo-implementation farther down, I think this would be like:
> 
> if (my_state->status == INDETERMINATE) {
>    // we were lazy and we never promised to do work atomically.
>    atomic_set(&my_state->status, KERNEL);
>    this_entry_work = 0;
>    /* we are definitely not pinned in this path */
> } else {
>    // we were not lazy and we promised we would do work atomically
>    atomic exchange the entire state to { .work = 0, .status = KERNEL }
>    this_entry_work = (whatever we just read);
>    if (this_entry_work & PINNED) {
>      u32 this_cpu_pin_count = this_cpu_ptr(pin_count);
>      while (atomic_read(&this_cpu_pin_count)) {
>        cpu_relax();
>      }
>    }
>  }
> 
> and we'd have something like:
> 
> bool try_pin_remote_cpu(int cpu)
> {
>     u32 *remote_pin_count = ...;
>     struct fancy_cpu_state *remote_state = ...;
>     atomic_inc(remote_pin_count);  // optimistic
> 
>     // Hmm, we do not want that read to get reordered with the inc, so we probably
>     // need a full barrier or seq_cst.  How does Linux spell that?  C++ has atomic::load
>     // with seq_cst and maybe the optimizer can do the right thing.  Maybe it's:
>     smp_mb__after_atomic();
> 
>     if (atomic_read(&remote_state->status) == USER) {
>       // Okay, it's genuinely pinned.
>       return true;
> 
>       // egads, if this is some arch with very weak ordering,
>       // do we need to be concerned that we just took a lock but we
>       // just did a relaxed read and therefore a subsequent access
>       // that thinks it's locked might appear to precede the load and therefore
>       // somehow get surprisingly seen out of order by the target cpu?
>       // maybe we wanted atomic_read_acquire above instead?
>     } else {
>       // We might not have successfully pinned it
>       atomic_dec(remote_pin_count);
>     }
> }
> 
> void unpin_remote_cpu(int cpu)
> {
>     atomic_dec(remote_pin_count();
> }
> 
> and we'd use it like:
> 
> if (try_pin_remote_cpu(cpu)) {
>   // do something useful
> } else {
>   send IPI;
> }
> 
> but we'd really accumulate the set of CPUs that need the IPIs and do them all at once.
> 
> I ran the theorem prover that lives inside my head on this code using the assumption that the machine is a well-behaved x86 system and it said "yeah, looks like it might be correct".  I trust an actual formalized system or someone like you who is genuinely very good at this stuff much more than I trust my initial impression :)

Let's start with requirements, non-traditional though that might be. ;-)

An "RCU idle" CPU is either in deep idle or executing in nohz_full
userspace.

1.	If the RCU grace-period kthread sees an RCU-idle CPU, then:

	a.	Everything that this CPU did before entering RCU-idle
		state must be visible to sufficiently later code executed
		by the grace-period kthread, and:

	b.	Everything that the CPU will do after exiting RCU-idle
		state must *not* have been visible to the grace-period
		kthread sufficiently prior to having sampled this
		CPU's state.

2.	If the RCU grace-period kthread sees an RCU-nonidle CPU, then
	it depends on whether this is the same nonidle sojourn as was
	initially seen.  (If the kthread initially saw the CPU in an
	RCU-idle state, it would not have bothered resampling.)

	a.	If this is the same nonidle sojourn, then there are no
		ordering requirements.	RCU must continue to wait on
		this CPU.

	b.	Otherwise, everything that this CPU did before entering
		its last RCU-idle state must be visible to sufficiently
		later code executed by the grace-period kthread.
		Similar to (1a) above.

3.	If a given CPU quickly switches into and out of RCU-idle
	state, and it is always in RCU-nonidle state whenever the RCU
	grace-period kthread looks, RCU must still realize that this
	CPU has passed through at least one quiescent state.

	This is why we have a counter for RCU rather than just a
	simple state.

The usual way to handle (1a) and (2b) is make the update marking entry
to the RCU-idle state have release semantics and to make the operation
that the RCU grace-period kthread uses to sample the CPU's state have
acquire semantics.

The usual way to handle (1b) is to have a full barrier after the update
marking exit from the RCU-idle state and another full barrier before the
operation that the RCU grace-period kthread uses to sample the CPU's
state.  The "sufficiently" allows some wiggle room on the placement
of both full barriers.  A full barrier can be smp_mb() or some fully
ordered atomic operation.

I will let Valentin and Frederic check the current code.  ;-)

> >> Following up, I think that x86 can do this all with a single atomic (in the common case) per usermode round trip.  Imagine:
> >> 
> >> struct fancy_cpu_state {
> >>   u32 work; // <-- writable by any CPU
> >>   u32 status; // <-- readable anywhere; writable locally
> >> };
> >> 
> >> status includes KERNEL, USER, and maybe INDETERMINATE.  (INDETERMINATE means USER but we're not committing to doing work.)
> >> 
> >> Exit to user mode:
> >> 
> >> atomic_set(&my_state->status, USER);
> >
> > We need ordering in the RCU nohz_full case.  If the grace-period kthread
> > sees the status as USER, all the preceding KERNEL code's effects must
> > be visible to the grace-period kthread.
> 
> Sorry, I'm speaking lazy x86 programmer here.  Maybe I mean atomic_set_release.  I want, roughly, the property that anyone who remotely observes USER can rely on the target cpu subsequently going through the atomic exchange path above.  I think even relaxed ought to be good enough for that one most architectures, but there are some potentially nasty complications involving that fact that this mixes operations on a double word and a single word that's part of the double word.

Please see the requirements laid out above.

> >> (or, in the lazy case, set to INDETERMINATE instead.)
> >> 
> >> Entry from user mode, with IRQs off, before switching to kernel CR3:
> >> 
> >> if (my_state->status == INDETERMINATE) {
> >>   // we were lazy and we never promised to do work atomically.
> >>   atomic_set(&my_state->status, KERNEL);
> >>   this_entry_work = 0;
> >> } else {
> >>   // we were not lazy and we promised we would do work atomically
> >>   atomic exchange the entire state to { .work = 0, .status = KERNEL }
> >>   this_entry_work = (whatever we just read);
> >> }
> >
> > If this atomic exchange is fully ordered (as opposed to, say, _relaxed),
> > then this works in that if the grace-period kthread sees USER, its prior
> > references are guaranteed not to see later kernel-mode references from
> > that CPU.
> 
> Yep, that's the intent of my pseudocode.  On x86 this would be a plain 64-bit lock xchg -- I don't think cmpxchg is needed.  (I like to write lock even when it's implicit to avoid needing to trust myself to remember precisely which instructions imply it.)

OK, then the atomic exchange provides all the ordering that the update
ever needs.

> >> if (PTI) {
> >>   switch to kernel CR3 *and flush if this_entry_work says to flush*
> >> } else {
> >>   flush if this_entry_work says to flush;
> >> }
> >> 
> >> do the rest of the work;
> >> 
> >> 
> >> 
> >> I suppose that a lot of the stuff in ti_flags could merge into here, but it could be done one bit at a time when people feel like doing so.  And I imagine, but I'm very far from confident, that RCU could use this instead of the current context tracking code.
> >
> > RCU currently needs pretty heavy-duty ordering to reliably detect the
> > other CPUs' quiescent states without needing to wake them from idle, or,
> > in the nohz_full case, interrupt their userspace execution.  Not saying
> > it is impossible, but it will need extreme care.
> 
> Is the thingy above heavy-duty enough?  Perhaps more relevantly, could RCU do this *instead* of the current CT hooks on architectures that implement it, and/or could RCU arrange for the ct hooks to be cheap no-ops on architectures that support the thingy above.  By "could" I mean "could be done without absolutely massive refactoring and without the resulting code being an unmaintainable disaster?  I'm sure any sufficiently motivated human or LLM could pull off the unmaintainable disaster version.  I bet I could even do it myself!)

I write broken and unmaintainable code all the time, having more than 50
years of experience doing so.  This is one reason we have rcutorture.  ;-)

RCU used to do its own CT-like hooks.  Merging them into the actual
context-tracking code reduced the entry/exit overhead significantly.

I am not seeing how the third requirement above is met, though.  I have
not verified the sampling code that the RCU grace-period kthread is
supposed to use because I am not seeing it right off-hand.

> >> The idea behind INDETERMINATE is that there are plenty of workloads that frequently switch between user and kernel mode and that would rather accept a few IPIs to avoid the heavyweight atomic operation on user -> kernel transitions.  So the default behavior could be to do KERNEL -> INDETERMINATE instead of KERNEL -> USER, but code that wants to be in user mode for a long time could go all the way to USER.  We could make it sort of automatic by noticing that we're returning from an IRQ without a context switch and go to USER (so we would get at most one unneeded IPI per normal user entry), and we could have some nice API for a program that intends to hang out in user mode for a very long time (cpu isolation users, for example) to tell the kernel to go immediately into USER mode.  (Don't we already have something that could be used for this purpose?)
> >
> > RCU *could* do an smp_call_function_single() when the CPU failed
> > to respond, perhaps in a manner similar to how it already forces a
> > given CPU out of nohz_full state if that CPU has been executing in the
> > kernel for too long.  The real-time guys might not be amused, though.
> > Especially those real-time guys hitting sub-microsecond latencies.
> 
> It wouldn't be outrageous to have real-time imply the full USER transition.

We could have special code for RT, but this of course increases the
complexity.  Which might be justified by sufficient speedup.

> >> Hmm, now I wonder if it would make sense for the default behavior of Linux to be like that.  We could call it ONEHZ.  It's like NOHZ_FULL except that user threads that don't do syscalls get one single timer tick instead of many or none.
> >> 
> >> 
> >> Anyway, I think my proposal is pretty good *if* RCU could be made to use it -- the existing context tracking code is fairly expensive, and I don't think we want to invent a new context-tracking-like mechanism if we still need to do the existing thing.
> >
> > If you build with CONFIG_NO_HZ_FULL=n, do you still get the heavyweight
> > operations when transitioning between kernel and user execution?
> 
> No.  And I even tested approximately this a couple weeks ago for unrelated reasons.  The only unnecessary heavy-weight thing we're doing in a syscall loop with mitigations off is the RDTSC for stack randomization.

OK, so why not just build your kernels with CONFIG_NO_HZ_FULL=n and be happy?

> But I did that test on a machine that would absolutely benefit from the IPI suppression that the OP is talking about here, and I think it would be really quite nice if a default distro kernel with a more or less default distribution could be easily convinced to run a user thread without interrupting it.  It's a little bit had that NO_HZ_FULL is still an exotic non-default thing, IMO.

And yes, many distros enable NO_HZ_FULL by default.  I will refrain from
suggesting additional static branches.  ;-)

							Thanx, Paul

