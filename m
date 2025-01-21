Return-Path: <linux-arch+bounces-9839-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C89A17F4F
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 15:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E1D1888ED5
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 14:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3901F12EE;
	Tue, 21 Jan 2025 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXH6cakO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0E81487F6;
	Tue, 21 Jan 2025 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737468024; cv=none; b=TmatCLmkgW3c57hVsNuVDHqoq9xoWSLWEIHqJ3YuHbh6VYoU+EofUxfqfQC6E9M119d6+guZiAoI6nZNJbyc21dzL67IBvT0U3SEo0bNEMHProXxg2hODKrrmB7dbXbkn8gh86xtx1NCrOBYXeY2cVKv4ird+lgWcizG8ieFti4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737468024; c=relaxed/simple;
	bh=Q5S9rJetTl9cgCroBUGkg7SOjKEl71T4cDyTy00Ssfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCwJCtObWkcQLZU+pjgmoJ/stcoua9YmzpiugY0auhm/IBV7rl4f/FmvwcQAhLky8cu4AeopsQBM0bqz4gil9F2yS+3YLM+V24/uIb7dNzHXEyDn4mTgZqmo1DK4A8HjRKMv0PcGduJOESZfQB3rIshdR+VZB8js3IrIa//O60o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXH6cakO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C8CC4CEE0;
	Tue, 21 Jan 2025 14:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737468023;
	bh=Q5S9rJetTl9cgCroBUGkg7SOjKEl71T4cDyTy00Ssfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FXH6cakOFkqIb5zaMucRt18L87yvpwVZGaJxUhREOt4P68rgom62uMZqy68vIiJxY
	 vC1cXMrRMcOwMAfmuxLEZ5bndo3NE4WwazkktDRZnaa3oxsql1H5GUr7t+fwMIx0bz
	 XkAJkUT9nkasLdUoZuBKZrBbotzPsLrjgcHMO3sqMz38POYs+eMlsXPGM73jQ0n8iK
	 MmzoQzjKnN6ACmqf4QPGnpglxf6uAX3/BRM7U3tqtHBoHNE7h6KqKMl22hpV4arvIi
	 4EBHxuw1qzMJUStZM7S/rcVySHrJR+84rbhK+Ss3scFXmd7IzHbUAqqT0NZChxotoD
	 A/lQ8LRjiOvEw==
Date: Tue, 21 Jan 2025 15:00:20 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
	linux-arch@vger.kernel.org, rcu@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Rong Xu <xur@google.com>,
	Nicolas Saenz Julienne <nsaenzju@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Jinghao Jia <jinghao7@illinois.edu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 04/30] rcutorture: Make TREE04 use
 CONFIG_RCU_DYNTICKS_TORTURE
Message-ID: <Z4-odFAImP-_uLV7@localhost.localdomain>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-5-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250114175143.81438-5-vschneid@redhat.com>

Le Tue, Jan 14, 2025 at 06:51:17PM +0100, Valentin Schneider a écrit :
> We now have an RCU_EXPERT config for testing small-sized RCU dynticks
> counter:  CONFIG_RCU_DYNTICKS_TORTURE.
> 
> Modify scenario TREE04 to exercise to use this config in order to test a
> ridiculously small counter (2 bits).
> 
> Link: http://lore.kernel.org/r/4c2cb573-168f-4806-b1d9-164e8276e66a@paulmck-laptop
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  tools/testing/selftests/rcutorture/configs/rcu/TREE04 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> index dc4985064b3ad..67caf4276bb01 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> @@ -16,3 +16,4 @@ CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
>  CONFIG_RCU_EXPERT=y
>  CONFIG_RCU_EQS_DEBUG=y
>  CONFIG_RCU_LAZY=y
> +CONFIG_RCU_DYNTICKS_TORTURE=y

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


> -- 
> 2.43.0
> 
> 

