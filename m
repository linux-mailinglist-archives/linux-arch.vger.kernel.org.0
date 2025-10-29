Return-Path: <linux-arch+bounces-14410-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9370DC1BE5C
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 17:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03531427B77
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 14:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E2D2E0408;
	Wed, 29 Oct 2025 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbRDLF5b"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5C52DF3D1;
	Wed, 29 Oct 2025 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749582; cv=none; b=dtPxPV7qGJyyV727+Xluoj57YIJ9IWRzmmLzHRx2SIH68Akz1zr2srgpexL4+WLM1CYFU5CL4mptaINPL/0V1FvteC5OCB/9OVQLgIEBmo4Jq3CxfmieQlsr3hSu893eKIe/w7cFXWNSn8K7XwTHCg6vEnkcRRU+CyWJ2frUoUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749582; c=relaxed/simple;
	bh=DycaBBkGuqgEIP5677gSgx8QDJGofxkMNPMcP3M730o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUbBIM8BERGoI2Unr0pZKxDvnePgw0lAZXEnrm8/QAJ6Ls3FNKtBF+iKeIWtRM9SvGjGeob26NpirhjVb+zdaNknnIbJ/3S9KW6UhAebzCSv82oPKW/yCAxAVe7IVz0HGURl8Nzx9JIp5h5e5skMwd0OIsCRiA/x0urxnvn3QF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbRDLF5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C64C19423;
	Wed, 29 Oct 2025 14:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761749581;
	bh=DycaBBkGuqgEIP5677gSgx8QDJGofxkMNPMcP3M730o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NbRDLF5bQ+u4J4hiySQAVpBuc86Gn1rrbceqZEKYNWpKF9yoAhVdLiG/Nu9SRzin5
	 ddwOS2DAvBL0w6K59co5lqXWGrpHXdyA3+e94n4XKlatrRRprHxYDEy/DFtpqcJYjz
	 jGBmveuocLom0Tr99M8s/YfJisMETw3u7WfPV8VPmObP73KGTMrcXJF2ZKhuh5kL4K
	 FNZiQ5jjE+Qy5WcINDDA3sOHLfgNQyF9ljeM8CBlvKWvkNPOMLvSsJkY31UBeqPnRr
	 epdow2onJrow0Coha3Tk5/8X8R1mpOEWDHWRuB0t8h2sykd3/evOgK+UEPDUs1Kui5
	 FM7cF5Ys9ZgFA==
Date: Wed, 29 Oct 2025 15:52:58 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenzju@redhat.com>,
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
Subject: Re: [PATCH v6 23/29] context-tracking: Introduce work deferral
 infrastructure
Message-ID: <aQIqSq2FWyHg0Y3p@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-24-vschneid@redhat.com>
 <aQDMfu0tzecFzoGr@localhost.localdomain>
 <xhsmh5xbyqas1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmh5xbyqas1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

Le Wed, Oct 29, 2025 at 11:09:50AM +0100, Valentin Schneider a écrit :
> On 28/10/25 15:00, Frederic Weisbecker wrote:
> > Le Fri, Oct 10, 2025 at 05:38:33PM +0200, Valentin Schneider a écrit :
> >> +	old = atomic_read(&ct->state);
> >> +
> >> +	/*
> >> +	 * The work bit must only be set if the target CPU is not executing
> >> +	 * in kernelspace.
> >> +	 * CT_RCU_WATCHING is used as a proxy for that - if the bit is set, we
> >> +	 * know for sure the CPU is executing in the kernel whether that be in
> >> +	 * NMI, IRQ or process context.
> >> +	 * Set CT_RCU_WATCHING here and let the cmpxchg do the check for us;
> >> +	 * the state could change between the atomic_read() and the cmpxchg().
> >> +	 */
> >> +	old |= CT_RCU_WATCHING;
> >
> > Most of the time, the task should be either idle or in userspace. I'm still not
> > sure why you start with a bet that the CPU is in the kernel with RCU watching.
> >
> 
> Right I think I got that the wrong way around when I switched to using
> CT_RCU_WATCHING vs CT_STATE_KERNEL. That wants to be
> 
>   old &= ~CT_RCU_WATCHING;
> 
> i.e. bet the CPU is NOHZ-idle, if it's not the cmpxchg fails and we don't
> store the work bit.

Right.

> 
> >> +	/*
> >> +	 * Try setting the work until either
> >> +	 * - the target CPU has entered kernelspace
> >> +	 * - the work has been set
> >> +	 */
> >> +	do {
> >> +		ret = atomic_try_cmpxchg(&ct->state, &old, old | (work << CT_WORK_START));
> >> +	} while (!ret && !(old & CT_RCU_WATCHING));
> >
> > So this applies blindly to idle as well, right? It should work but note that
> > idle entry code before RCU watches is also fragile.
> >
> 
> Yeah I remember losing some hair trying to grok the idle entry situation;
> we could keep this purely NOHZ_FULL and have the deferral condition be:
> 
>   (ct->state & CT_STATE_USER) && !(ct->state & CT_RCU_WATCHING)

Well, after all what works for NOHZ_FULL should also work for idle. It's
preceded by entry code as well (or rather __cpuidle).

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

