Return-Path: <linux-arch+bounces-14384-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5A9C15AC9
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 17:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8551C1A61A07
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E259A34166C;
	Tue, 28 Oct 2025 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0Rjdky4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADC02D5924;
	Tue, 28 Oct 2025 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667159; cv=none; b=A3hkZvIaIE5rDyaXGLk1XsOvICspbnGFOv2ohQWfB8ezwe3LgD9Xds/NtG9o7f3aajZ1F+CxiI9+pA9xhKgX1kthGeIvK3hEup1A/xCsFzAAovbdAEtFrxiLMSgjbAETW5Omg58t+2tLY2XlAtFz/F3J1/83KNjX7MN2F6Zbyjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667159; c=relaxed/simple;
	bh=SDRIuqWM2TI7GYT8HdCkn7TBcJvTMa+nGGBd4kxLWaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LM8wB4FvWv6t0ONt4DiNcJ2pxHO15xcGD581IJGcMHq89GYl0GK7ejvzemNscQurTzSjWd7LzOfNCyaXcSZOhPdOEvnxKSZyXspQN2VifDUZ9tbLFmsjZqPVgqhUr+JH/AP0tBnRtELAfyhDeP3uGFG+6YU2+hbdT0mXz6LT/dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0Rjdky4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55CEC4CEE7;
	Tue, 28 Oct 2025 15:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761667159;
	bh=SDRIuqWM2TI7GYT8HdCkn7TBcJvTMa+nGGBd4kxLWaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h0Rjdky40XtCVRjoUUWv5rLiJ9ZMpCagJKFXeyfzHOGEHTGw9bKgoBDki9igeNVWF
	 hxxzLvARw99/t5f4Lqs+Dj5fZyVuN3fZZCRfCFM55ZeACJS/rijOr6rAqCQE7Hwid1
	 QyXcKn0xMZDkHD1ajCbuYBSCn+ENYdvO5PJWUuqfmfteG28nQwGE4UO2KHjBeLwl2c
	 hE32PRBdNnuYpqH0YyIEEpoBXAGIkGRuRSDfPq/9QdewsKj3LtsQ6g4eJFxD5TaKJO
	 HpEpDWwMqwcXSfnux9kuKahgFba9EgaGpASx7PAIM38ag+Pw/+fgAan6RlnvKpPKM4
	 jLUxM6PBiYL0w==
Date: Tue, 28 Oct 2025 16:59:16 +0100
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
Message-ID: <aQDoVAs5UZwQo-ds@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-28-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251010153839.151763-28-vschneid@redhat.com>

Le Fri, Oct 10, 2025 at 05:38:37PM +0200, Valentin Schneider a écrit :
> Deferring kernel range TLB flushes requires the guarantee that upon
> entering the kernel, no stale entry may be accessed. The simplest way to
> provide such a guarantee is to issue an unconditional flush upon switching
> to the kernel CR3, as this is the pivoting point where such stale entries
> may be accessed.
> 
> As this is only relevant to NOHZ_FULL, restrict the mechanism to NOHZ_FULL
> CPUs.
> 
> Note that the COALESCE_TLBI config option is introduced in a later commit,
> when the whole feature is implemented.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  arch/x86/entry/calling.h      | 26 +++++++++++++++++++++++---
>  arch/x86/kernel/asm-offsets.c |  1 +
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
> index 813451b1ddecc..19fb6de276eac 100644
> --- a/arch/x86/entry/calling.h
> +++ b/arch/x86/entry/calling.h
> @@ -9,6 +9,7 @@
>  #include <asm/ptrace-abi.h>
>  #include <asm/msr.h>
>  #include <asm/nospec-branch.h>
> +#include <asm/invpcid.h>
> 
>  /*
> 
> @@ -171,8 +172,27 @@ For 32-bit we have the following conventions - kernel is built with
> 	andq    $(~PTI_USER_PGTABLE_AND_PCID_MASK), \reg
>  .endm
> 
> -.macro COALESCE_TLBI
> +.macro COALESCE_TLBI scratch_reg:req
>  #ifdef CONFIG_COALESCE_TLBI
> +	/* No point in doing this for housekeeping CPUs */
> +	movslq  PER_CPU_VAR(cpu_number), \scratch_reg
> +	bt	\scratch_reg, tick_nohz_full_mask(%rip)
> +	jnc	.Lend_tlbi_\@

I assume it's not possible to have a static call/branch to
take care of all this ?

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

