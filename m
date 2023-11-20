Return-Path: <linux-arch+bounces-290-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AB47F12BB
	for <lists+linux-arch@lfdr.de>; Mon, 20 Nov 2023 13:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C7D3B21841
	for <lists+linux-arch@lfdr.de>; Mon, 20 Nov 2023 12:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB23D18E13;
	Mon, 20 Nov 2023 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RM6Qx7Fc"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA249BF;
	Mon, 20 Nov 2023 04:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/mR897q7LtgCvTlXKAE0rdoSN2j8b8aMcVPOdcccRpY=; b=RM6Qx7FcfEFB0lloIPereTideL
	+AYJNf5egfv1iuCehLcwN8dJk66EVzSqwJnMMUEhuV5TAtoSStumIRWuKu1Tyuns+s0LKpLPy0t/5
	dIo/vWXCY0oXNGJy/4xtNQC7ZgQDFV98EWphzMUqEf+Q/8iNT6nQzfdvQXpQ9vAaGzvlXIRF6fZg/
	m4tn3ybZvEH8spXzjXsC9eUEiIZmhh6261gFuf/eZffQib5S8BO76T9UKU5plOA8hllIe+6H/NG6z
	CV+4tZZ8Z7E7UWpvWTTqBjQOiogO3kSRrjo53cYWqKvLpVlRepARypnPJv9l8u1VOlAIaJp6Z0DTh
	92xDf1bA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r532I-004Sv4-SR; Mon, 20 Nov 2023 12:05:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F09DF300419; Mon, 20 Nov 2023 13:05:53 +0100 (CET)
Date: Mon, 20 Nov 2023 13:05:53 +0100
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
Message-ID: <20231120120553.GU8262@noisy.programming.kicks-ass.net>
References: <20231120105528.760306-1-vschneid@redhat.com>
 <20231120105528.760306-6-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120105528.760306-6-vschneid@redhat.com>

On Mon, Nov 20, 2023 at 11:55:28AM +0100, Valentin Schneider wrote:
> __use_tsc is only ever enabled in __init tsc_enable_sched_clock(), so mark
> it as __ro_after_init.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  arch/x86/kernel/tsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 15f97c0abc9d0..f19b42ea40573 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -44,7 +44,7 @@ EXPORT_SYMBOL(tsc_khz);
>  static int __read_mostly tsc_unstable;
>  static unsigned int __initdata tsc_early_khz;
>  
> -static DEFINE_STATIC_KEY_FALSE(__use_tsc);
> +static DEFINE_STATIC_KEY_FALSE_RO(__use_tsc);

So sure, we can absolutely do that, but do we want to take this one
further perhaps? "notsc" on x86_64 makes no sense what so ever. Lets
drag things into this millennium.

---

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 15f97c0abc9d..4cfcf5946162 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -44,7 +44,9 @@ EXPORT_SYMBOL(tsc_khz);
 static int __read_mostly tsc_unstable;
 static unsigned int __initdata tsc_early_khz;
 
+#ifndef CONFIG_X86_64
 static DEFINE_STATIC_KEY_FALSE(__use_tsc);
+#endif
 
 int tsc_clocksource_reliable;
 
@@ -230,24 +232,26 @@ static void __init cyc2ns_init_secondary_cpus(void)
  */
 noinstr u64 native_sched_clock(void)
 {
-	if (static_branch_likely(&__use_tsc)) {
-		u64 tsc_now = rdtsc();
+#ifndef CONFIG_X86_64
+	if (!static_branch_unlikely(&__use_tsc)) {
+		/*
+		 * Fall back to jiffies if there's no TSC available:
+		 * ( But note that we still use it if the TSC is marked
+		 *   unstable. We do this because unlike Time Of Day,
+		 *   the scheduler clock tolerates small errors and it's
+		 *   very important for it to be as fast as the platform
+		 *   can achieve it. )
+		 */
 
-		/* return the value in ns */
-		return __cycles_2_ns(tsc_now);
+		/* No locking but a rare wrong value is not a big deal: */
+		return (jiffies_64 - INITIAL_JIFFIES) * (1000000000 / HZ);
 	}
+#endif
 
-	/*
-	 * Fall back to jiffies if there's no TSC available:
-	 * ( But note that we still use it if the TSC is marked
-	 *   unstable. We do this because unlike Time Of Day,
-	 *   the scheduler clock tolerates small errors and it's
-	 *   very important for it to be as fast as the platform
-	 *   can achieve it. )
-	 */
+	u64 tsc_now = rdtsc();
 
-	/* No locking but a rare wrong value is not a big deal: */
-	return (jiffies_64 - INITIAL_JIFFIES) * (1000000000 / HZ);
+	/* return the value in ns */
+	return __cycles_2_ns(tsc_now);
 }
 
 /*
@@ -291,7 +295,8 @@ int check_tsc_unstable(void)
 }
 EXPORT_SYMBOL_GPL(check_tsc_unstable);
 
-#ifdef CONFIG_X86_TSC
+#ifndef CONFIG_X86_64
+#if defined(CONFIG_X86_TSC
 int __init notsc_setup(char *str)
 {
 	mark_tsc_unstable("boot parameter notsc");
@@ -310,6 +315,7 @@ int __init notsc_setup(char *str)
 #endif
 
 __setup("notsc", notsc_setup);
+#endif
 
 static int no_sched_irq_time;
 static int no_tsc_watchdog;
@@ -1556,7 +1562,9 @@ static void __init tsc_enable_sched_clock(void)
 	/* Sanitize TSC ADJUST before cyc2ns gets initialized */
 	tsc_store_and_check_tsc_adjust(true);
 	cyc2ns_init_boot_cpu();
+#ifndef CONFIG_X86_64
 	static_branch_enable(&__use_tsc);
+#endif
 }
 
 void __init tsc_early_init(void)

