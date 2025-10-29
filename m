Return-Path: <linux-arch+bounces-14393-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E69C19D6F
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 11:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3407563CAB
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 10:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8594B3396F7;
	Wed, 29 Oct 2025 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQHpiMhH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF1338906;
	Wed, 29 Oct 2025 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733897; cv=none; b=aGjsfPcwV2tFWtLtfla3baPsKum9VMLpOKfoece61kLESKHc1YWv7hw2aKYf8JMFRPEVwynyGFD+9mVg/GfJGW5dB3WZ8vyyGjElHAyCWvYE3kiUsjP8w9kQUXmhkHUDwwTpSQns6bc9TMP9lWc/c0VRfpWsc4CLLBvwOdccNio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733897; c=relaxed/simple;
	bh=Kk/z5xbjPIxTq926BScJO1YbAE6B21A/nQcvL+Stxjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bztdQpvm0KrA4pTKa1csPNOz3m2+mRLdE54U5Xv+SeyFNCGqvygYVhhPR68784rbn95k7xs2ebHeaHSclhzi/PhFktsKXnFogBqtBwNrvuCiPnX5iapsoECr+AnNVAyV5ZrPeFNuK8azpAyg3luxtj9jwX9kz10+gLS8pOa+g1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQHpiMhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4DAC116D0;
	Wed, 29 Oct 2025 10:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761733896;
	bh=Kk/z5xbjPIxTq926BScJO1YbAE6B21A/nQcvL+Stxjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mQHpiMhHIipyykg71nO9gr0ccOWvAw3jtxADhT6O9/iW0PpIiw/qmz5zVTUW3oo0Y
	 Yq4gg7lmHuk8qvkB8w7kGP3dJ/Es/yfXH9Z/5NpT3GdhmC3rdV4d9InuM6AE6YDHuy
	 66y1CBVkVJ47bCQATzwguaNY0rGy4czAnJJf2Xq0+TNv8MsAXP6t2uwOLwNqTFFpSC
	 b93q4JO88FSbhgGajCQoNTlTc5GzNikQEX4E8U13MGQNOniIiwlNgiHYmZ4xaVekC8
	 PXMEnG8bUYp8VmovluQl1CaebknBe933wtZ0M/W93tFXssHpX/nRz8xuoWt5VU0UOX
	 RCaW/NJFhcGtw==
Date: Wed, 29 Oct 2025 11:31:34 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
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
Subject: Re: [RFC PATCH v6 27/29] x86/mm/pti: Implement a TLB flush
 immediately after a switch to kernel CR3
Message-ID: <aQHtBudA4aw4a3gT@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-28-vschneid@redhat.com>
 <aQDoVAs5UZwQo-ds@localhost.localdomain>
 <xhsmh3472qah4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmh3472qah4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

Le Wed, Oct 29, 2025 at 11:16:23AM +0100, Valentin Schneider a écrit :
> On 28/10/25 16:59, Frederic Weisbecker wrote:
> > Le Fri, Oct 10, 2025 at 05:38:37PM +0200, Valentin Schneider a écrit :
> >> @@ -171,8 +172,27 @@ For 32-bit we have the following conventions - kernel is built with
> >>      andq    $(~PTI_USER_PGTABLE_AND_PCID_MASK), \reg
> >>  .endm
> >>
> >> -.macro COALESCE_TLBI
> >> +.macro COALESCE_TLBI scratch_reg:req
> >>  #ifdef CONFIG_COALESCE_TLBI
> >> +	/* No point in doing this for housekeeping CPUs */
> >> +	movslq  PER_CPU_VAR(cpu_number), \scratch_reg
> >> +	bt	\scratch_reg, tick_nohz_full_mask(%rip)
> >> +	jnc	.Lend_tlbi_\@
> >
> > I assume it's not possible to have a static call/branch to
> > take care of all this ?
> >
> 
> I think technically yes, but that would have to be a per-cpu patchable
> location, which would mean something like each CPU having its own copy of
> that text page... Unless there's some existing way to statically optimize
> 
>   if (cpumask_test_cpu(smp_processor_id(), mask))
> 
> where @mask is a boot-time constant (i.e. the nohz_full mask).

Or just check housekeeping_overriden static key before everything. This one is
enabled only if either nohz_full, isolcpus or cpuset isolated partition (well,
it's on the way for the last one) are running, but those are all niche, which
means you spare 99.999% kernel usecases.

Thanks.

> 
> > Thanks.
> >
> > --
> > Frederic Weisbecker
> > SUSE Labs
> 
> 

-- 
Frederic Weisbecker
SUSE Labs

