Return-Path: <linux-arch+bounces-14386-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 890B3C15C6E
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 17:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28A2E35177C
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 16:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160CE283FEE;
	Tue, 28 Oct 2025 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gT6/ILOP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FCB27B4E1;
	Tue, 28 Oct 2025 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668713; cv=none; b=YFM1QDdwfBxFSZDhaJtUEzD24qYuRVU4GiEAX+gsU2HJZY7e1KdZEFUR6AAHJhB15FzOXUecytFSvxTFP/tm479JhaGhSJIQpG+cbiYPp4jjm2xt0Jhtp5t8J0oCV8ureVHAgYzipa0KtYoDts5jPuGcCr1yybUU0w5AWyC+Kl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668713; c=relaxed/simple;
	bh=g+HYr74fOIJBF8//IeX1u6hGkpfR/MyO8jpC8AyplAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2D2fUGFBAk5AyDSjceTQvtH6vrBhia2jZIq3qc8XVJdL09x04qU2tNpsVXrUhZMnbKPgaDZsJUKPo1dlMA+TB1pQ3bQVOs0pZGcY1R0ReratD875aLst3NlXV0bpJfwX6gs03tiF0Ggir7uKa0fv2B2TrW1bKkL8gluQj/iUK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gT6/ILOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDAFC4CEE7;
	Tue, 28 Oct 2025 16:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761668710;
	bh=g+HYr74fOIJBF8//IeX1u6hGkpfR/MyO8jpC8AyplAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gT6/ILOPpDox4LIC0P6mrQkn27cKKS8sqA59JphgtIkj6muwgaA3Fo1qkj+3hwr0x
	 Lec8ctwO62yUgf5b+f8NOys9+imyW63Awoi+zjDc6vUMX7ItNvFhAbXVixsle20+AM
	 DCYjg9wWsW+BmN8WmVOnXKeoK7KRXl7UfDuM55FDXrP20wubQGruqEIuyl7uN1vem3
	 z1RjIXGmQ+jItDnSIQZ94NMGu9r4D1Cc2Yx7w4rRGmNHf87sUEhnNQJTnZxj1eJJBt
	 Bp2v2DXxUkTbIAPy+fj+FmsmIlW78U0n3bUpKvn+IC4BArPQhxPUJb7TwK5EWFOiU5
	 OFSj9z0ZySqFA==
Date: Tue, 28 Oct 2025 17:25:07 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>, Phil Auld <pauld@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
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
Message-ID: <aQDuY3rgOK-L8D04@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251010153839.151763-1-vschneid@redhat.com>

+Cc Phil Auld

Le Fri, Oct 10, 2025 at 05:38:10PM +0200, Valentin Schneider a écrit :
> Patches
> =======
> 
> o Patches 1-2 are standalone objtool cleanups.

Would be nice to get these merged.

> o Patches 3-4 add an RCU testing feature.

I'm taking this one.

> 
> o Patches 5-6 add infrastructure for annotating static keys and static calls
>   that may be used in noinstr code (courtesy of Josh).
> o Patches 7-20 use said annotations on relevant keys / calls.
> o Patch 21 enforces proper usage of said annotations (courtesy of Josh).
> 
> o Patch 22 deals with detecting NOINSTR text in modules

Not sure how to route those. If we wait for each individual subsystem,
this may take a while.

> o Patches 23-24 deal with kernel text sync IPIs

I would be fine taking those (the concerns I had are just details)
but they depend on all the annotations. Alternatively I can take the whole
thing but then we'll need some acks.
 
> o Patches 25-29 deal with kernel range TLB flush IPIs

I'll leave these more time for now ;o)
And if they ever go somewhere, it should be through x86 tree.

Also, here is another candidate usecase for this deferral thing.
I remember Phil Auld complaining that stop_machine() on CPU offlining was
a big problem for nohz_full. Especially while we are working on
a cpuset interface to toggle nohz_full but this will require the CPUs
to be offline.

So my point is that when a CPU goes offline, stop_machine() puts all
CPUs into a loop with IRQs disabled. CPUs in userspace could possibly
escape that since they don't touch the kernel anyway. But as soon as
they enter the kernel, they should either acquire the final state of
stop_machine if completed or join the global loop if in the middle.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

