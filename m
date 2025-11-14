Return-Path: <linux-arch+bounces-14789-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CC1C5E504
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 17:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98EC93E33D4
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 16:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0664322768;
	Fri, 14 Nov 2025 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFKJbFmP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D3F2857FA;
	Fri, 14 Nov 2025 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763137267; cv=none; b=fV2OkPPrLPYEqzs3lzYNLqi61iPTWNGm3EsMf2Xsn/otc2RvLf2cr/MHysJtxEHJPkkB2ojYHl5n0ul2XcyAZPETlpyGtnmdk6+NkjIM1Tby7FF/YYiHHBgXU85nIf7qQUIljCjxse/oog4P2s5lQsI/xP0BDvuTUPHo5bEmQvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763137267; c=relaxed/simple;
	bh=sdAOBvzBQbQ58hWdafyr1VicSS+CMEqs0nYJg4IbVNc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rlaREvJG/TnbnFFwqICeiVApXVc2ImXezU26qnjE+kb0lrKI8opdBJmgK1iQX8N1pU/KxuxKtMczY+GCmonv5aiHzW0ToHOt6MR35mr4o0/7gAACtfvsdZm88/GT09v/R3N1l0KbMWqUOeOPKyYH1geLBFD1OEs14xC9sSyEg1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFKJbFmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BFCC19421;
	Fri, 14 Nov 2025 16:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763137267;
	bh=sdAOBvzBQbQ58hWdafyr1VicSS+CMEqs0nYJg4IbVNc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=HFKJbFmP9Ujt3AKc7/UDrJzlJi7JumxeosLUkWEyPeklpq5OZZt72yyohcI3A8DjR
	 Q5Vh2zAeFMd2IiCnte0N/XnGK6DNbDRQ/7YvQ5lhwqg9RolCuYDSpfKJqS1B0vZukv
	 WRM5Cfpv4s2uQBT9XQpMmVhLg7RU2QrLO7TehZVkVvfsiLOIriL0AHuR7xxhksMb0r
	 rQ1Xr54dcBhj8eF/NMqOjBRjmPKn9v4PpWEBURevuz0YH6yMHvvs4zxmhQOC1HiZt1
	 eaXuznue691T9OUZ0Tb36FWCOYcv7m6yoU4B67wWFVQhqHzZSTrRZF2fY0n7ubjqfK
	 3ELPPESaDQuog==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2A926F4006D;
	Fri, 14 Nov 2025 11:21:05 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 14 Nov 2025 11:21:05 -0500
X-ME-Sender: <xms:8FYXaX1xeo7cwPzIqK0lN7OWVpvdACGCH0_QR-xqptpdj06yrqDiMg>
    <xme:8FYXaQ5044wGZzeghlvmdCODRvYE2agaizWczUnN-jUKKWRJl7iq7FAPf_6mDi1Nk
    _cq58VZC_S-DwQ4rAg_2zGQMltJ_hj7flJjkLTIUdudS5euDrsHNIs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddtvdelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:8VYXaavy2Rcw5_KExroGJoSP4RswQNujNsiylB0Zboj1MLJmYGXRMQ>
    <xmx:8VYXaZY6rZhPaBTbMRdgxZfVoWO_tE57Uf8RTZRFKYMUkM6OhPqO7w>
    <xmx:8VYXaXq_i9JHyksMPvKjGa4dS9KQQoAc-nePruIhtsmCgMAuL00tWQ>
    <xmx:8VYXaQqiB1qrgBqZ3MW1P6T2OaapMG_gHq2V-9XZpin12vZyrdLMFw>
    <xmx:8VYXaUXaaOeVLlHat2d5uQs_qjo-uL7EhSwfZcFtiahVbx-tqC236JT4>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D4A0C700054; Fri, 14 Nov 2025 11:21:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATddxb8eqn9V
Date: Fri, 14 Nov 2025 08:20:42 -0800
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
Message-Id: <c4768cf3-f131-44e6-9b25-ebeb633f32ee@app.fastmail.com>
In-Reply-To: <20251114150133.1056710-1-vschneid@redhat.com>
References: <20251114150133.1056710-1-vschneid@redhat.com>
Subject: Re: [PATCH v7 00/31] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Nov 14, 2025, at 7:01 AM, Valentin Schneider wrote:
> Context
> =======
>
> We've observed within Red Hat that isolated, NOHZ_FULL CPUs running a
> pure-userspace application get regularly interrupted by IPIs sent from
> housekeeping CPUs. Those IPIs are caused by activity on the housekeeping CPUs
> leading to various on_each_cpu() calls, e.g.:
>

> The heart of this series is the thought that while we cannot remove NOHZ_FULL
> CPUs from the list of CPUs targeted by these IPIs, they may not have to execute
> the callbacks immediately. Anything that only affects kernelspace can wait
> until the next user->kernel transition, providing it can be executed "early
> enough" in the entry code.
>

I want to point out that there's another option here, although anyone trying to implement it would be fighting against quite a lot of history.

Logically, each CPU is in one of a handful of states: user mode, idle, normal kernel mode (possibly subdivided into IRQ, etc), and a handful of very narrow windows, hopefully uninstrumented and not accessing any PTEs that might be invalid, in the entry and exit paths where any state in memory could be out of sync with actual CPU state.  (The latter includes right after the CPU switches to kernel mode, for example.)  And NMI and MCE and whatever weird "security" entry types that Intel and AMD love to add.

The way the kernel *currently* deals with this has two big historical oddities:

1. The entry and exit code cares about ti_flags, which is per-*task*, which means that atomically poking it from other CPUs involves the runqueue lock or other shenanigans (see the idle nr_polling code for example), and also that it's not accessible from the user page tables if PTI is on.

2. The actual heavyweight atomic part (context tracking) was built for RCU, and it's sort or bolted on, and, as you've observed in this series, it's really quite awkward to do things that aren't RCU using context tracking.

If this were a greenfield project, I think there's a straightforward approach that's much nicer: stick everything into a single percpu flags structure.  Imagine we have cpu_flags, which tracks both the current state of the CPU and what work needs to be done on state changes.  On exit to user mode, we would atomically set the mode to USER and make sure we don't touch anything like vmalloc space after that.  On entry back to kernel mode, we would avoid vmalloc space, etc, then atomically switch to kernel mode and read out whatever deferred work is needed.  As an optimization, if nothing in the current configuration needs atomic state tracking, the state could be left at USER_OR_KERNEL and the overhead of an extra atomic op at entry and exit could be avoided.

And RCU would hook into *that* instead of having its own separate set of hooks.

I think that actually doing this would be a big improvement and would also be a serious project.  There's a lot of code that would get touched, and the existing context tracking code is subtle and confusing.  And, as mentioned, ti_flags has the wrong scope.

It's *possible* that one could avoid making ti_flags percpu either by extensive use of the runqueue locks or by borrowing a kludge from the idle code.  For the latter, right now, the reason that the wake-from-idle code works is that the optimized path only happens if the idle thread/cpu is "polling", and it's impossible for the idle ti_flags to be polling while the CPU isn't actually idle.  We could similarly observe that, if a ti_flags says it's in USER mode *and* is on, say, cpu 3, then cpu 3 is most definitely in USER mode.  So someone could try shoving the CPU number into ti_flags :-p   (USER means actually user or in the late exit / early entry path.)

Anyway, benefits of this whole approach would include considerably (IMO) increased comprehensibility compared to the current tangled ct code and much more straightforward addition of new things that happen to a target CPU conditionally depending on its mode.  And, if the flags word was actually per cpu, it could be mapped such that SWITCH_TO_KERNEL_CR3 would use it -- there could be a single CR3 write (and maybe CR4/invpcid depending on whether a zapped mapping is global) and the flush bit could depend on whether a flush is needed.  And there would be basically no chance that a bug that accessed invalidated-but-not-flushed kernel data could be undetected -- in PTI mode, any such access would page fault!  Similarly, if kernel text pokes deferred the flush and serialization, the only code that could execute before noticing the deferred flush would be the user-CR3 code.

Oh, any another primitive would be possible: one CPU could plausibly execute another CPU's interrupts or soft-irqs or whatever by taking a special lock that would effectively pin the remote CPU in user mode -- you'd set a flag in the target cpu_flags saying "pin in USER mode" and the transition on that CPU to kernel mode would then spin on entry to kernel mode and wait for the lock to be released.  This could plausibly get a lot of the on_each_cpu callers to switch over in one fell swoop: anything that needs to synchronize to the remote CPU but does not need to poke its actual architectural state could be executed locally while the remote CPU is pinned.

--Andy

