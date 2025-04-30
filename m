Return-Path: <linux-arch+bounces-11763-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE0FAA54EF
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 21:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C53B9E7321
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 19:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5911EFF96;
	Wed, 30 Apr 2025 19:42:37 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06761EF09B;
	Wed, 30 Apr 2025 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746042156; cv=none; b=s3RM7aX/lu2c1CHsBb0xVoDC4PxLsVlLbSFrH9y6Oc3dwCCNG26/joNNuGGFWNXoA7OXCMOvF2GDWlJn3A3hTRWDvxrl851qsRfOmPjE8pRaJdnh5ZCuJon/MGqPBrRZccEkEvNxV12TrLADzdelUez1Pw4lGlQfzxaASMbCsAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746042156; c=relaxed/simple;
	bh=m2le8MbqpO1CEE28derdicybxKozm8oIgSSxhBO1DF8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DpwArWhNlvBI4UgoDlm0CWJv7eeLGenzwpv26kFaky36LAHgGX4qf+1suXhSL1OVFB1N3XtTGdHzmcD9fxGNgDw9pin3lQcZ4+UpCejsSr6GmBoETqHwzBKPLFh+OkKVb+LfA2Dod4PbTttA6cRuwoV21G/rR9iZgR6UjJEW418=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A76CC4CEE7;
	Wed, 30 Apr 2025 19:42:24 +0000 (UTC)
Date: Wed, 30 Apr 2025 15:42:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-perf-users@vger.kernel.org, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, rcu@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Daniel Wagner <dwagner@suse.de>, Petr Tesarik
 <ptesarik@suse.com>, Nicolas Saenz Julienne <nsaenz@amazon.com>, Frederic
 Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Sean Christopherson
 <seanjc@google.com>, Juergen Gross <jgross@suse.com>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.amakhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H.
 Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, Naveen N
 Rao <naveen@kernel.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Kees Cook
 <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda
 <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Rong Xu
 <xur@google.com>, Rafael Aquini <aquini@redhat.com>, Song Liu
 <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Dan Carpenter
 <dan.carpenter@linaro.org>, Brian Gerst <brgerst@gmail.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Benjamin Berg
 <benjamin.berg@intel.com>, Vishal Annapurve <vannapurve@google.com>, Randy
 Dunlap <rdunlap@infradead.org>, John Stultz <jstultz@google.com>, Tiezhu
 Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v5 00/25] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
Message-ID: <20250430154228.1d6306b4@gandalf.local.home>
In-Reply-To: <019f6713-cfbd-466b-8fb5-dcd982cf8644@intel.com>
References: <20250429113242.998312-1-vschneid@redhat.com>
	<fefcd1a6-f146-4f3c-b28b-f907e7346ddd@intel.com>
	<20250430132047.01d48647@gandalf.local.home>
	<019f6713-cfbd-466b-8fb5-dcd982cf8644@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Apr 2025 11:07:35 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 4/30/25 10:20, Steven Rostedt wrote:
> > On Tue, 29 Apr 2025 09:11:57 -0700
> > Dave Hansen <dave.hansen@intel.com> wrote:
> >   
> >> I don't think we should do this series.  
> > 
> > Could you provide more rationale for your decision.  
> 
> I talked about it a bit in here:
> 
> > https://lore.kernel.org/all/408ebd8b-4bfb-4c4f-b118-7fe853c6e897@intel.com/  

Hmm, that's easily missed. But thanks for linking it.

> 
> But, basically, this series puts a new onus on the entry code: it can't
> touch the vmalloc() area ... except the LDT ... and except the PEBS
> buffers. If anyone touches vmalloc()'d memory (or anything else that
> eventually gets deferred), they crash. They _only_ crash on these
> NOHZ_FULL systems.
> 
> Putting new restrictions on the entry code is really nasty. Let's say a
> new hardware feature showed up that touched vmalloc()'d memory in the
> entry code. Probably, nobody would notice until they got that new
> hardware and tried to do a NOHZ_FULL workload. It might take years to
> uncover, once that hardware was out in the wild.
> 
> I have a substantial number of gray hairs from dealing with corner cases
> in the entry code.
> 
> You _could_ make it more debuggable. Could you make this work for all
> tasks, not just NOHZ_FULL? The same logic _should_ apply. It would be
> inefficient, but would provide good debugging coverage.
> 
> I also mentioned this earlier, but PTI could be leveraged here to ensure
> that the TLB is flushed properly. You could have the rule that anything
> mapped into the user page table can't have a deferred flush and then do
> deferred flushes at SWITCH_TO_KERNEL_CR3 time. Yeah, that's in
> arch-specific assembly, but it's a million times easier to reason about
> because the window where a deferred-flush allocation might bite you is
> so small.
> 
> Look at the syscall code for instance:
> 
> > SYM_CODE_START(entry_SYSCALL_64)
> >         swapgs
> >         movq    %rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
> >         SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp  
> 
> You can _trivially_ audit this and know that swapgs doesn't touch memory
> and that as long as PER_CPU_VAR()s and the process stack don't have
> their mappings munged and flushes deferred that this would be correct.

Hmm, so there is still a path for this?

At least if it added more ways to debug it, and some other changes to make
the locations where vmalloc is dangerous smaller?

> 
> >> If folks want this functionality, they should get a new CPU that can
> >> flush the TLB without IPIs.  
> > 
> > That's a pretty heavy handed response. I'm not sure that's always a
> > feasible solution.
> > 
> > From my experience in the world, software has always been around to fix the
> > hardware, not the other way around ;-)  
> 
> Both AMD and Intel have hardware to do it. ARM CPUs do it too, I think.
> You can go buy the Intel hardware off the shelf today.

Sure, but changing CPUs on machines is not always that feasible either.

-- Steve

