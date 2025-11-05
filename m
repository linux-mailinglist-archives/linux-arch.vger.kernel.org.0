Return-Path: <linux-arch+bounces-14528-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C442C37327
	for <lists+linux-arch@lfdr.de>; Wed, 05 Nov 2025 18:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C39F4FF44E
	for <lists+linux-arch@lfdr.de>; Wed,  5 Nov 2025 17:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDD22F7446;
	Wed,  5 Nov 2025 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7Mf6l0a"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16169239E88;
	Wed,  5 Nov 2025 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364792; cv=none; b=Vq09r7z4GTrmB6srJ89qtod2uxtJGGmFzdNRAOvsd9NAOIBV3Srda7wlTNpscHhNRKnCKyDKzPh9v/x+TUfI5CGlJx76RXFz+F4ThjwFQQaUm23op1RlXxfYbWCZeDI4MuwlIewG7UpThnd7lX0I7yHfITvYHM/y86+RQwvP27o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364792; c=relaxed/simple;
	bh=woawi0pKo/kryyYybe6UTBTWMoVsh5qziqijASjnREk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bvz8rShcpQbPzWdjrT7/BwbIt492YUOY5iCXSQyaUdsoPc3VH7Ix3IGdSAgimoUIztvsKiV1T89l4wb98+21lezcizqcIeSZtoQWFVG8Zof6+YhGrQvE8B+/KNd+Q0ANpK4EJKzfRkuQhqtgA1/7CoYC1x52te/UWdH6gs+kTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7Mf6l0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1533CC4CEF5;
	Wed,  5 Nov 2025 17:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762364791;
	bh=woawi0pKo/kryyYybe6UTBTWMoVsh5qziqijASjnREk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X7Mf6l0akmdIq5iKgqrPQJacdZIwvZNDplWJ7ZFAiTj1m5jo/r4RZiwBnuufL7FJz
	 rvjLuH5kIUsBewW58/KIJ4AtGpjFM65vgcq5Mq40hqFViVaFYaMO3B+3S2DJBgREr8
	 Ydhgli/Ewi5GXUbKU7XplIRtFLKzGALUr+LrfoBKdNnCob1uuo8LERCMDso+bO1Ogb
	 2kFxvq6vNnlZJHsASSZyjiY4DFFHKnlLj9M1sIw8Xs7M5lI6s7rwKH+tP57RLGeYQo
	 I7shlbbDQcR6rzKbVlqZcx0moVDvOcKmF1aICmG6LscQYeQvqFcaYK64Yfrix1vGrk
	 oPe9jn359SAFw==
Date: Wed, 5 Nov 2025 18:46:28 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rcu@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
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
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v6 00/29] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
Message-ID: <aQuNdOEmPYkI03my@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <aQDuY3rgOK-L8D04@localhost.localdomain>
 <xhsmhzf9aov51.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <aQJLpSYz3jdazzdb@localhost.localdomain>
 <xhsmh8qgk5txe.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmh8qgk5txe.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

Le Wed, Nov 05, 2025 at 05:24:29PM +0100, Valentin Schneider a écrit :
> On 29/10/25 18:15, Frederic Weisbecker wrote:
> > Le Wed, Oct 29, 2025 at 11:32:58AM +0100, Valentin Schneider a écrit :
> >> I need to have a think about that one; one pain point I see is the context
> >> tracking work has to be NMI safe since e.g. an NMI can take us out of
> >> userspace. Another is that NOHZ-full CPUs need to be special cased in the
> >> stop machine queueing / completion.
> >>
> >> /me goes fetch a new notebook
> >
> > Something like the below (untested) ?
> >
> 
> Some minor nits below but otherwise that looks promising.
> 
> One problem I'm having however is reasoning about the danger zone; what
> forbidden actions could a NO_HZ_FULL CPU take when entering the kernel
> while take_cpu_down() is happening?
> 
> I'm actually not familiar with why we actually use stop_machine() for CPU
> hotplug; I see things like CPUHP_AP_SMPCFD_DYING::smpcfd_dying_cpu() or
> CPUHP_AP_TICK_DYING::tick_cpu_dying() expect other CPUs to be patiently
> spinning in multi_cpu_stop(), and I *think* nothing in the entry code up to
> context_tracking entry would disrupt that, but it's not a small thing to
> reason about.
> 
> AFAICT we need to reason about every .teardown callback from
> CPUHP_TEARDOWN_CPU to CPUHP_AP_OFFLINE and their explicit & implicit
> dependencies on other CPUs being STOP'd.

You're raising a very interesting question. The initial point of stop_machine()
is to synchronize this:

    set_cpu_online(cpu, 0)
    migrate timers;
    migrate hrtimers;
    flush IPIs;
    etc...

against this pattern:

    preempt_disable()
    if (cpu_online(cpu))
        queue something; // could be timer, IPI, etc...
    preempt_enable()

There have been attempts:

      https://lore.kernel.org/all/20241218171531.2217275-1-costa.shul@redhat.com/

And really it should be fine to just do:

    set_cpu_online(cpu, 0)
    synchronize_rcu()
    migrate / flush stuff

Probably we should try that instead of the busy loop I proposed
which only papers over the problem.

Of course there are other assumptions. For example the tick
timekeeper is migrated easily knowing that all online CPUs are
not idle (cf: tick_cpu_dying()). So I expect a few traps, with RCU
for example and indeed all these hotplug callbacks must be audited
one by one.

I'm not entirely unfamiliar with many of them. Let me see what I can do...

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

