Return-Path: <linux-arch+bounces-648-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F1E803CAE
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 19:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1A3280ECA
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 18:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516F62E859;
	Mon,  4 Dec 2023 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cIQTrzt1"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F2FAA;
	Mon,  4 Dec 2023 10:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AqgRiIU25Iyrb1pK/xZFkXqH0JgFhRw2lfSELu3vTXk=; b=cIQTrzt1QT6PLNkwG/peh1pk9J
	iy3i6f17zLKYQG7VAD4z8aVMiugj5WZAhoM+FfIv9erKT82aoryJFj57uOUx3cjsk2fGj0cTzKFhL
	TUpglAaD0ehEDE3dh5YKhJ7/4Wpb7LTxINIeWdjq8HX3+UljJsexKDLFi3RBih+ub7ti2qU2g0nEM
	5mjxCVasfnlsBaZPpOn1rxAW0GwiM0BZZYB0Vh06emJvmWcXIA/Yv1CEzvXbpZIC598IJAHiJ8vPv
	7ySr1nxlbGGM3y3xrQY35GS7h9PjBo7X/x7cKlh+Xwo0bf2vkk6wm2hLxpeysX19BOrfQROxpnxsQ
	RLg2Guuw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rADYi-004PeY-0v;
	Mon, 04 Dec 2023 18:20:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DCDDD300427; Mon,  4 Dec 2023 19:20:43 +0100 (CET)
Date: Mon, 4 Dec 2023 19:20:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-arch@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>,
	Michael Kelley <mikelley@microsoft.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCH 5/5] x86/tsc: Make __use_tsc __ro_after_init
Message-ID: <20231204182043.GB7299@noisy.programming.kicks-ass.net>
References: <20231120105528.760306-1-vschneid@redhat.com>
 <20231120105528.760306-6-vschneid@redhat.com>
 <20231120120553.GU8262@noisy.programming.kicks-ass.net>
 <xhsmhcyvlc3mi.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhcyvlc3mi.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Mon, Dec 04, 2023 at 05:51:49PM +0100, Valentin Schneider wrote:
> On 20/11/23 13:05, Peter Zijlstra wrote:
> > On Mon, Nov 20, 2023 at 11:55:28AM +0100, Valentin Schneider wrote:
> >> __use_tsc is only ever enabled in __init tsc_enable_sched_clock(), so mark
> >> it as __ro_after_init.
> >>
> >> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> >> ---
> >>  arch/x86/kernel/tsc.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> >> index 15f97c0abc9d0..f19b42ea40573 100644
> >> --- a/arch/x86/kernel/tsc.c
> >> +++ b/arch/x86/kernel/tsc.c
> >> @@ -44,7 +44,7 @@ EXPORT_SYMBOL(tsc_khz);
> >>  static int __read_mostly tsc_unstable;
> >>  static unsigned int __initdata tsc_early_khz;
> >>
> >> -static DEFINE_STATIC_KEY_FALSE(__use_tsc);
> >> +static DEFINE_STATIC_KEY_FALSE_RO(__use_tsc);
> >
> > So sure, we can absolutely do that, but do we want to take this one
> > further perhaps? "notsc" on x86_64 makes no sense what so ever. Lets
> > drag things into this millennium.
> >
> 
> Just to make sure I follow: currently, for the static key to be enabled, we
> (mostly) need:
> o X86_FEATURE_TSC is in CPUID
> o determine_cpu_tsc_frequencies()->pit_hpet_ptimer_calibrate_cpu() passes
> 
> IIUC all X86_64 systems have a TSC, so the CPUID feature should be a given.
> 
> AFAICT pit_hpt_ptimer_calibrate_cpu() relies on having either HPET or the
> ACPI PM timer, the latter should be widely available, though X86_PM_TIMER
> can be disabled via EXPERT - is that a fringe case we don't care about, or
> did I miss something? I don't really know this stuff, and I'm trying to
> write a changelog...

Ah, I was mostly just going by the fact that all of x86_64 have TSC and
disabling it makes no sense.

TSC calibration is always 'fun', but I don't know of a system where its
failure causes us to not use TSC, Thomas?

