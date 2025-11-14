Return-Path: <linux-arch+bounces-14790-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A880FC5E872
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 18:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73713420804
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 17:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85E82D662D;
	Fri, 14 Nov 2025 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SilCQx3X"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC972D594A;
	Fri, 14 Nov 2025 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140979; cv=none; b=Vv07bG8no8eLsclLswk+yKGsLPhLB0NK+XQypyuDBLwy/DQJCYYOnblkr+CQharSJj9RlpRJJqHjx9JGOqnOIJN6HVRe+CNEHs2D7XZzgD32c0oYaEa+fr43THgdEB9lneHWcfkeSJEvx6IdbjztATXKD9rh4WS2Q7CudkV7K1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140979; c=relaxed/simple;
	bh=Wn21IOPfie55Agjgm4yTzq64wt8lPfqbNjOydlIl3ks=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=a5WAR+MeXYZiaDGei7Z6woVvfC9A7FdbYi/t9nqXzz8YcYJ1Htfr01w3U1eLIJB9JgVTHlZQjHcC1zlPfOekNJUMQ7iRU+8w2duGL1gzeYDJA0IGk0MY9pKnEr3R5MdGAMDWWIllbqP+dZOzu3LepELSVcwOjVlR++Zqyio8C6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SilCQx3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3554C2BCAF;
	Fri, 14 Nov 2025 17:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763140979;
	bh=Wn21IOPfie55Agjgm4yTzq64wt8lPfqbNjOydlIl3ks=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=SilCQx3XmZ/NT8jwjxoviXOlaW0MBhdKaK6ghe5sIAgoz9gNP5gqiGgaBzCDfxJZ2
	 uwfxVWw9QqMQf3GbzhmEL3u6qpm8JOKoFwj8Q7DAuUncFSOrJM/hzT6qwnHvwqvbfQ
	 oDrzf/fHlG/2xevvDVaAtI02uGwk1Pv+dAR79Ks1zmz/u3yWKFR5UOt0JXli8z4LnR
	 KTi5T+TeAhz1F5mjqdf98BKqgS8vj9Tp0ZwQoPoleNSgSmWtvgvTrEfi11mRoMfNNI
	 SSI1qvuG5BkP5bBCd95C1BWlAQl3+FrhQcJj8NmGaoz0snW0FJ6l60v4DX0whLV1QC
	 pJGqjk8r/bbPA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 89FE8F4007E;
	Fri, 14 Nov 2025 12:22:56 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 14 Nov 2025 12:22:56 -0500
X-ME-Sender: <xms:cGUXabwEqVEpa1Pu5wTjk4joAbVQryrNMlkH96m6Rqbgt7emLRj7LA>
    <xme:cGUXaeG_FuBKBhhpWNSN54290UOZDu1nnTWl9eTRn5OyT5oiOC7K0UK5QkLRFRCCH
    _hZOI__w0Gxd-nD_URIR5GlTla4_kE-BTWFle1bK4W2HQwmeUxvlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddtgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehnugih
    ucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepkefhieejfedvueejheehiefgvdfhjeefjeelvdfghfelgeejudevleej
    uddvvefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudekheei
    fedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrd
    hluhhtohdruhhspdhnsggprhgtphhtthhopeegkedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhgsrghrohhnsegrkhgrmhgrihdrtghomhdprhgtphhtthhopegsphesrg
    hlihgvnhekrdguvgdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthht
    ohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehmrghthhhivg
    hurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdprhgtphhtthhopegsohhq
    uhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehurhgviihkihesghhmrg
    hilhdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhr
    tghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:cGUXaUDpJ_uK79SK7Sbacr87uFV8wZEsIf2pIISOfwTkBCtvWlzrEw>
    <xmx:cGUXae5Y61eVBcZCaJHzDtO62XxeGCqtc9VUtRcQqNlU6sq2BPHPDw>
    <xmx:cGUXaR33ueH3p4j58OA_EkrtZ_VytmnamzZ896qedlQfrBIvZjLmpg>
    <xmx:cGUXafVOzTzxUTLUMYvZY7NoWG8psGhITslD4bm_amg0iRE7ssFf3w>
    <xmx:cGUXaWk7Pm5SeQEG2tIMjhRAiJsTdItwmKq4_ZH92byZlKEjJy-RgVcM>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 490B2700063; Fri, 14 Nov 2025 12:22:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATddxb8eqn9V
Date: Fri, 14 Nov 2025 09:22:35 -0800
From: "Andy Lutomirski" <luto@kernel.org>
To: "Valentin Schneider" <vschneid@redhat.com>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org, rcu@vger.kernel.org,
 "the arch/x86 maintainers" <x86@kernel.org>,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>,
 "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Paolo Bonzini" <pbonzini@redhat.com>, "Arnd Bergmann" <arnd@arndb.de>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Jason Baron" <jbaron@akamai.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Ard Biesheuvel" <ardb@kernel.org>,
 "Sami Tolvanen" <samitolvanen@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Josh Triplett" <josh@joshtriplett.org>,
 "Boqun Feng" <boqun.feng@gmail.com>,
 "Uladzislau Rezki" <urezki@gmail.com>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Mel Gorman" <mgorman@suse.de>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Han Shen" <shenhan@google.com>, "Rik van Riel" <riel@surriel.com>,
 "Jann Horn" <jannh@google.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Oleg Nesterov" <oleg@redhat.com>, "Juri Lelli" <juri.lelli@redhat.com>,
 "Clark Williams" <williams@redhat.com>,
 "Yair Podemsky" <ypodemsk@redhat.com>,
 "Marcelo Tosatti" <mtosatti@redhat.com>,
 "Daniel Wagner" <dwagner@suse.de>, "Petr Tesarik" <ptesarik@suse.com>,
 "Shrikanth Hegde" <sshegde@linux.ibm.com>
Message-Id: <beb46a02-b902-438b-8b6d-b5f0d7ad0ae6@app.fastmail.com>
In-Reply-To: <c4768cf3-f131-44e6-9b25-ebeb633f32ee@app.fastmail.com>
References: <20251114150133.1056710-1-vschneid@redhat.com>
 <c4768cf3-f131-44e6-9b25-ebeb633f32ee@app.fastmail.com>
Subject: Re: [PATCH v7 00/31] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Nov 14, 2025, at 8:20 AM, Andy Lutomirski wrote:
> On Fri, Nov 14, 2025, at 7:01 AM, Valentin Schneider wrote:
>> Context
>> =======
>>
>> We've observed within Red Hat that isolated, NOHZ_FULL CPUs running a
>> pure-userspace application get regularly interrupted by IPIs sent from
>> housekeeping CPUs. Those IPIs are caused by activity on the housekeeping CPUs
>> leading to various on_each_cpu() calls, e.g.:
>>
>
>> The heart of this series is the thought that while we cannot remove NOHZ_FULL
>> CPUs from the list of CPUs targeted by these IPIs, they may not have to execute
>> the callbacks immediately. Anything that only affects kernelspace can wait
>> until the next user->kernel transition, providing it can be executed "early
>> enough" in the entry code.
>>
>
> I want to point out that there's another option here, although anyone 
> trying to implement it would be fighting against quite a lot of history.
>
> Logically, each CPU is in one of a handful of states: user mode, idle, 
> normal kernel mode (possibly subdivided into IRQ, etc), and a handful 
> of very narrow windows, hopefully uninstrumented and not accessing any 
> PTEs that might be invalid, in the entry and exit paths where any state 
> in memory could be out of sync with actual CPU state.  (The latter 
> includes right after the CPU switches to kernel mode, for example.)  
> And NMI and MCE and whatever weird "security" entry types that Intel 
> and AMD love to add.
>
> The way the kernel *currently* deals with this has two big historical oddities:
>
> 1. The entry and exit code cares about ti_flags, which is per-*task*, 
> which means that atomically poking it from other CPUs involves the 
> runqueue lock or other shenanigans (see the idle nr_polling code for 
> example), and also that it's not accessible from the user page tables 
> if PTI is on.
>
> 2. The actual heavyweight atomic part (context tracking) was built for 
> RCU, and it's sort or bolted on, and, as you've observed in this 
> series, it's really quite awkward to do things that aren't RCU using 
> context tracking.
>
> If this were a greenfield project, I think there's a straightforward 
> approach that's much nicer: stick everything into a single percpu flags 
> structure.  Imagine we have cpu_flags, which tracks both the current 
> state of the CPU and what work needs to be done on state changes.  On 
> exit to user mode, we would atomically set the mode to USER and make 
> sure we don't touch anything like vmalloc space after that.  On entry 
> back to kernel mode, we would avoid vmalloc space, etc, then atomically 
> switch to kernel mode and read out whatever deferred work is needed.  
> As an optimization, if nothing in the current configuration needs 
> atomic state tracking, the state could be left at USER_OR_KERNEL and 
> the overhead of an extra atomic op at entry and exit could be avoided.
>
> And RCU would hook into *that* instead of having its own separate set of hooks.
>
> I think that actually doing this would be a big improvement and would 
> also be a serious project.  There's a lot of code that would get 
> touched, and the existing context tracking code is subtle and 
> confusing.  And, as mentioned, ti_flags has the wrong scope.
>
> It's *possible* that one could avoid making ti_flags percpu either by 
> extensive use of the runqueue locks or by borrowing a kludge from the 
> idle code.  For the latter, right now, the reason that the 
> wake-from-idle code works is that the optimized path only happens if 
> the idle thread/cpu is "polling", and it's impossible for the idle 
> ti_flags to be polling while the CPU isn't actually idle.  We could 
> similarly observe that, if a ti_flags says it's in USER mode *and* is 
> on, say, cpu 3, then cpu 3 is most definitely in USER mode.  So someone 
> could try shoving the CPU number into ti_flags :-p   (USER means 
> actually user or in the late exit / early entry path.)
>
> Anyway, benefits of this whole approach would include considerably 
> (IMO) increased comprehensibility compared to the current tangled ct 
> code and much more straightforward addition of new things that happen 
> to a target CPU conditionally depending on its mode.  And, if the flags 
> word was actually per cpu, it could be mapped such that 
> SWITCH_TO_KERNEL_CR3 would use it -- there could be a single CR3 write 
> (and maybe CR4/invpcid depending on whether a zapped mapping is global) 
> and the flush bit could depend on whether a flush is needed.  And there 
> would be basically no chance that a bug that accessed 
> invalidated-but-not-flushed kernel data could be undetected -- in PTI 
> mode, any such access would page fault!  Similarly, if kernel text 
> pokes deferred the flush and serialization, the only code that could 
> execute before noticing the deferred flush would be the user-CR3 code.
>
> Oh, any another primitive would be possible: one CPU could plausibly 
> execute another CPU's interrupts or soft-irqs or whatever by taking a 
> special lock that would effectively pin the remote CPU in user mode -- 
> you'd set a flag in the target cpu_flags saying "pin in USER mode" and 
> the transition on that CPU to kernel mode would then spin on entry to 
> kernel mode and wait for the lock to be released.  This could plausibly 
> get a lot of the on_each_cpu callers to switch over in one fell swoop: 
> anything that needs to synchronize to the remote CPU but does not need 
> to poke its actual architectural state could be executed locally while 
> the remote CPU is pinned.

Following up, I think that x86 can do this all with a single atomic (in the common case) per usermode round trip.  Imagine:

struct fancy_cpu_state {
  u32 work; // <-- writable by any CPU
  u32 status; // <-- readable anywhere; writable locally
};

status includes KERNEL, USER, and maybe INDETERMINATE.  (INDETERMINATE means USER but we're not committing to doing work.)

Exit to user mode:

atomic_set(&my_state->status, USER);

(or, in the lazy case, set to INDETERMINATE instead.)

Entry from user mode, with IRQs off, before switching to kernel CR3:

if (my_state->status == INDETERMINATE) {
  // we were lazy and we never promised to do work atomically.
  atomic_set(&my_state->status, KERNEL);
  this_entry_work = 0;
} else {
  // we were not lazy and we promised we would do work atomically
  atomic exchange the entire state to { .work = 0, .status = KERNEL }
  this_entry_work = (whatever we just read);
}

if (PTI) {
  switch to kernel CR3 *and flush if this_entry_work says to flush*
} else {
  flush if this_entry_work says to flush;
}

do the rest of the work;



I suppose that a lot of the stuff in ti_flags could merge into here, but it could be done one bit at a time when people feel like doing so.  And I imagine, but I'm very far from confident, that RCU could use this instead of the current context tracking code.


The idea behind INDETERMINATE is that there are plenty of workloads that frequently switch between user and kernel mode and that would rather accept a few IPIs to avoid the heavyweight atomic operation on user -> kernel transitions.  So the default behavior could be to do KERNEL -> INDETERMINATE instead of KERNEL -> USER, but code that wants to be in user mode for a long time could go all the way to USER.  We could make it sort of automatic by noticing that we're returning from an IRQ without a context switch and go to USER (so we would get at most one unneeded IPI per normal user entry), and we could have some nice API for a program that intends to hang out in user mode for a very long time (cpu isolation users, for example) to tell the kernel to go immediately into USER mode.  (Don't we already have something that could be used for this purpose?)

Hmm, now I wonder if it would make sense for the default behavior of Linux to be like that.  We could call it ONEHZ.  It's like NOHZ_FULL except that user threads that don't do syscalls get one single timer tick instead of many or none.


Anyway, I think my proposal is pretty good *if* RCU could be made to use it -- the existing context tracking code is fairly expensive, and I don't think we want to invent a new context-tracking-like mechanism if we still need to do the existing thing.

--Andy

