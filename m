Return-Path: <linux-arch+bounces-14383-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AF7C153CF
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 15:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F72C4E944A
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 14:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89419248F4D;
	Tue, 28 Oct 2025 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huHQXCvp"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BBD224AF1;
	Tue, 28 Oct 2025 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662958; cv=none; b=tVceoydioJrBqYZPc/PiSrRKs/t2jPxKfONK8p+T9+O5o6dY3eFb/gfi58dWHR4mUUz/Hn4Xb8lxKf7yi6nBxpW8dDbLqMnKBCxTjUR6l2NthEa1r4iRC4VNQVWJOPyt7MeWQshdKHBjzeaX1yZWf9m43xcQZu3XtnDj8jeAlQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662958; c=relaxed/simple;
	bh=/YcbY6Xd39AsABVLZZYIvhdW8ivhFU4lURFGb2RCZr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hxc8N413euu4Eh80TwLyO/1T/SyxEX37D6EuDw7H/WXKCuJ0RWQPLtjMpONpGAq6h1Lg2hfBGMxBvAJly95g4G5auA8ggM0/4CDQo8Lb8+7UZBhCa56LYelsPcARoSY9vUDYsgxD2BArkTv4SJcB3T5pKmdkNjoBPxZpIOrV1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huHQXCvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64951C4CEE7;
	Tue, 28 Oct 2025 14:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761662956;
	bh=/YcbY6Xd39AsABVLZZYIvhdW8ivhFU4lURFGb2RCZr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=huHQXCvp0W/S5F1ENdurMkw2WwJZbMBNDXAh91iSKf/vrNDl1NLBkoXJdUx/C19Qv
	 Z4qNcGgTCDjqG04Q8z3Gw4n7Ol2Hs4TiC0IGtfV35bwyLcbAG4VH3lZOOkEdiJR4uv
	 98GKb95kopcHzMuvU3H2025SulpKC226+6+rZMUmhwVvLSkelVU5+Fv/hfF6vOYswZ
	 XcZScHHzyBVq+mz32oPgQ0NUDZQKpY6cLjssBtvUS7RZby1k7TivV6VhaUkRZyqa69
	 4+Ez+WRvhuVyLYG73RXpS/ughenkh3oUdmNmmth4K/glGp+Eu28p8jOe+6mgl5gPer
	 pCdjOFhzrTR8g==
Date: Tue, 28 Oct 2025 15:49:14 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Nicolas Saenz Julienne <nsaenzju@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
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
Subject: Re: [PATCH v6 24/29] context_tracking,x86: Defer kernel text
 patching IPIs
Message-ID: <aQDX6hHV3b1-_wuF@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-25-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251010153839.151763-25-vschneid@redhat.com>

Le Fri, Oct 10, 2025 at 05:38:34PM +0200, Valentin Schneider a écrit :
> text_poke_bp_batch() sends IPIs to all online CPUs to synchronize
> them vs the newly patched instruction. CPUs that are executing in userspace
> do not need this synchronization to happen immediately, and this is
> actually harmful interference for NOHZ_FULL CPUs.
> 
> As the synchronization IPIs are sent using a blocking call, returning from
> text_poke_bp_batch() implies all CPUs will observe the patched
> instruction(s), and this should be preserved even if the IPI is deferred.
> In other words, to safely defer this synchronization, any kernel
> instruction leading to the execution of the deferred instruction
> sync (ct_work_flush()) must *not* be mutable (patchable) at runtime.
> 
> This means we must pay attention to mutable instructions in the early entry
> code:
> - alternatives
> - static keys
> - static calls
> - all sorts of probes (kprobes/ftrace/bpf/???)
> 
> The early entry code leading to ct_work_flush() is noinstr, which gets rid
> of the probes.
> 
> Alternatives are safe, because it's boot-time patching (before SMP is
> even brought up) which is before any IPI deferral can happen.
> 
> This leaves us with static keys and static calls.
> 
> Any static key used in early entry code should be only forever-enabled at
> boot time, IOW __ro_after_init (pretty much like alternatives). Exceptions
> are explicitly marked as allowed in .noinstr and will always generate an
> IPI when flipped.
> 
> The same applies to static calls - they should be only updated at boot
> time, or manually marked as an exception.
> 
> Objtool is now able to point at static keys/calls that don't respect this,
> and all static keys/calls used in early entry code have now been verified
> as behaving appropriately.
> 
> Leverage the new context_tracking infrastructure to defer sync_core() IPIs
> to a target CPU's next kernel entry.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

