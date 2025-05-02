Return-Path: <linux-arch+bounces-11799-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 978EFAA75DF
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 17:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355143A7912
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 15:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7834F2571D9;
	Fri,  2 May 2025 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VLicN+pt"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396762566;
	Fri,  2 May 2025 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746199322; cv=none; b=X9xZpeusoa0aCSiLPhurPgppFxsx1mdX9zuYSXtC7eV/dyYYq2AVqjqt+h4Pkg15umM1HkM38soImhaKJxYU7C0BtES/VTGtlxli7bSC+7w/O4BEvm9i3F8PrW8/XgzVbDvFyCtrxK7pNP2qgJUPiCvygMJbI6uGoyjRZNA2HZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746199322; c=relaxed/simple;
	bh=lOTz4fM30AMVEWlFBUzcvFWNPVkGYLhLbFmCBFLUSGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSLFbDUsm6Aoee+RBbbCjs6j5/lSoHQ3/xWCh9YXBofe5En5yNDHepoqo43iHNkPWc5NC0EWQBPItyuTM/ep/g7skykxox6ubqN92XcXHDaInfK8KPHVp+6WFQOm7k9z3q0re9SoS9b4CV5trTlavzlzZTALo4WChjS4+Hm6NPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VLicN+pt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=el7AZkw1ZRKHIxRciQGDkRJRuJhHBYcxb7Lx2vUA2VY=; b=VLicN+ptqmmrlGpkHyenbaJkO3
	UKl1u4ZcqZ7oWPbRw6dMMUxn72FaEy0WJ3uleLDo46IZAmhsK1s6PzstYFLXVCoeTFAELrE5DCXZV
	2a3xjeJXk3jd+MNSv440/ctFcN/2lRBE7zBjIvFKJhZ8qlHasISVIsAF7PhbVmOI9sTPnfKtBF/j0
	T5ii54POjzNHVsJRtQ6Eurq9+2ni0YwiVd6GYbIqODtfs42ci2vCC2IhgLIcfyKRhIXKA+++xBeTX
	7vzCcTdWbJuGqjLYTRZaDRmsGTt0uypAIK5VRc3biSMOf5Mo2j4U1WGyzwr0huO9Ilv8zAyVG14w8
	3oLsV5eQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAsBP-00000004E1V-1rsm;
	Fri, 02 May 2025 15:20:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D6C5B30057C; Fri,  2 May 2025 17:20:02 +0200 (CEST)
Date: Fri, 2 May 2025 17:20:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
	kvm@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	rcu@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>,
	Nicolas Saenz Julienne <nsaenz@amazon.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Naveen N Rao <naveen@kernel.org>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Rong Xu <xur@google.com>, Rafael Aquini <aquini@redhat.com>,
	Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Brian Gerst <brgerst@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	John Stultz <jstultz@google.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v5 00/25] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
Message-ID: <20250502152002.GX4439@noisy.programming.kicks-ass.net>
References: <20250429113242.998312-1-vschneid@redhat.com>
 <fefcd1a6-f146-4f3c-b28b-f907e7346ddd@intel.com>
 <20250430132047.01d48647@gandalf.local.home>
 <019f6713-cfbd-466b-8fb5-dcd982cf8644@intel.com>
 <20250502112216.GZ4198@noisy.programming.kicks-ass.net>
 <6c44fa0e-28ed-400e-aaf2-e0e0720d3811@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c44fa0e-28ed-400e-aaf2-e0e0720d3811@intel.com>

On Fri, May 02, 2025 at 07:33:55AM -0700, Dave Hansen wrote:
> On 5/2/25 04:22, Peter Zijlstra wrote:
> > On Wed, Apr 30, 2025 at 11:07:35AM -0700, Dave Hansen wrote:
> > 
> >> Both AMD and Intel have hardware to do it. ARM CPUs do it too, I think.
> >> You can go buy the Intel hardware off the shelf today.
> > To be fair, the Intel RAR thing is pretty horrific 🙁 Definitely
> > sub-par compared to the AMD and ARM things.
> > 
> > Furthermore, the paper states it is a uarch feature for SPR with no
> > guarantee future uarchs will get it (and to be fair, I'd prefer it if
> > they didn't).
> 
> I don't think any of that is set in stone, fwiw. It should be entirely
> possible to obtain a longer promise about its availability.
> 
> Or ask that AMD and Intel put their heads together in their fancy new
> x86 advisory group and figure out a single way forward. 

This might be a good thing regardless.

> > Furthermore, I suspect it will actually be slower than IPIs for anything
> > with more than 64 logical CPUs due to reduced parallelism.
> 
> Maybe my brain is crusty and I need to go back and read the spec, but I
> remember RAR using the normal old APIC programming that normal old TLB
> flush IPIs use. So they have similar restrictions. If it's inefficient
> to program a wide IPI, it's also inefficient to program a RAR operation.
> So the (theoretical) pro is that you program it like an IPI and it slots
> into the IPI code fairly easily. But the con is that it has the same
> limitations as IPIs.

The problem is in the request structure. Sending an IPI is an async
action. You do, done.

OTOH RAR has a request buffer where pending requests are put and 'polled'
for completion. This buffer does not have room for more than 64 CPUs.

This means that if you want to invalidate across more, you need to do it
in multiple batches.

So where IPI is:

 - IPI all CPUs
 - local invalidate
 - wait for completion

This then becomes:

 for ()
   - RAR some CPUs
   - wait for completion

Or so I thought to have understood, the paper isn't the easiest to read.

> I was actually concerned that INVLPGB won't be scalable. Since it
> doesn't have the ability to target specific CPUs in the ISA, it
> fundamentally need to either have a mechanism to reach all CPUs, or some
> way to know which TLB entries each CPU might have.
> 
> Maybe AMD has something super duper clever to limit the broadcast scope.
> But if they don't, then a small range flush on a small number of CPUs
> might end up being pretty expensive, relatively.

So the way I understand things:

Sending IPIs is sending a message on the interconnect. Mostly this is a
cacheline in size (because MESI). Sparc (v9?) has a fun feature where
you can actually put data payload in an IPI.

Now, we can target an IPI to a single CPU or to a (limited) set of CPU
or broadcast to all CPUs. In fact, targeted IPIs might still be
broadcast IPIs, except most CPUs will ignore it because it doesn't match
them.

TLBI broadcast is like sending IPIs to all CPUs, the message goes out,
everybody sees it.

Much like how snoop filters and the like function, a CPU can process
these messages async -- your CPU doesn't stall for a cacheline
invalidate message either (except ofcourse if it is actively using that
line). Same for TLBI, if the local TLB does not have anything that
matches, its done. Even if it does match, as long as nothing makes
active use of it, it can just drop the TLB entry without disturbing the
actual core.

Only if the CPU has a matching TLB entry *and* it is active, then we
have options. One option is to interrupt the core, another option is to
wait for it to stop using it.

IIUC the current AMD implementation does the 'interrupt' thing.

One thing to consider in all this is that if we TLBI for an executable
page, we should very much also wipe the u-ops cache and all such related
structures -- ARM might have an 'issue' here.

That is, I think the TLBI problem is very similar to the I in MESI --
except possibly simpler, because E must not happen until all CPUs
acknowledge I etc. TLBI does not have this, it has until the next
TLBSYNC.

Anyway, I'm not a hardware person, but this is how I understand these
things to work.

