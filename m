Return-Path: <linux-arch+bounces-10964-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73715A6968E
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 18:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 383437A72A2
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 17:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B711DF747;
	Wed, 19 Mar 2025 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OPuKnj8n"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAB21DE884;
	Wed, 19 Mar 2025 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405500; cv=none; b=kBPqAOOn9dIyW9KOYMF4FLq3KQxmbf/5RK7wKcZ+k/+GcwJ+yj+55snO7WX97gv5/W5VNPKTH/B/ZxkZVHsthPZxbKD8UGjpIWcCtepWVZVDCoTwwW5lSI71s2PRUCL3tqA3c82xZLL/k/nwjU0cmKw/TmT1+oERurpVCteuqyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405500; c=relaxed/simple;
	bh=1krTOqoQmK+AUaaMBs+P36+1kPk82EwrMREbbAaX5hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqTcL/IiImOau7Q/O8iD8Zntdz3P0pydCGhtlpAjnozWRaiZMbkycIUcXfQHAl0clWlB2viOve6pbq9lYTYE0Gx4SSTw2mKBzynQFPC8I0AM3VLbcquX7a0agUQ1ls7CpISweCyz4VxV66eCpFepiMWQ7+eSwH+nX6EBVKRaVaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OPuKnj8n; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 033E640E01D1;
	Wed, 19 Mar 2025 17:31:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EOIBCM-ZWxOR; Wed, 19 Mar 2025 17:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742405488; bh=y4IueNFhKFDuJLhg35AaumVxylQHY1jpwsFPITe81G8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OPuKnj8nSqrVhz24YDL81CfCg2gKR9pIWbtbaHWonnfkdzAOYbC52VlJf5R+D42NL
	 p+FEyIidvNStF1js+JfxT0C7rZGoAMoejdM1WgsnqZOgssxdFq7zcrdehkdBOhwBCf
	 6qn9py1y7c1kbXSMeviUQDURN49OG5fv/WjXQdW5IkqHVFOA0DbDKfAETmttIs75Qp
	 okPexPU9CehnEmaY3d7p6wh5PbiGuNMNTVx27sDHmdjIb3Dtjbu4HRwbY4Q14i4bwJ
	 dsbkbZltr+kVU6ilR9D0zZyxFpO/sh1scDlcoWBs6e/bo71ONMVPvUCTlG7i2ceeA5
	 wLaaxTPNfgLMm+60LsvQKf3f4DtxJ37YimbXvOnTV9Uiwo+mADi/UxAjzpM0rP7ZL9
	 wo6QkkCKHUim+f+duFQ3p6m3NNZfUI/OdPhNo3Vh4zPkc4ReJUxDq/sHn7PoTceDKC
	 dFHviztK56ka7KdDhZc4xg9gEecFpX/b8YeeHYnRAAy42UF9NNurT+CJRgEvMwDn9o
	 EmwYWflsznK/wu6GRntJJGeTc65/wswB2vmGe19QbC0B8PxXLmDLJ6Gvkm3RlzDUX4
	 /qN979SHOM73h+ayNLsjM9Jni661c+WpiCH3Ao/36bsD+FjghQdcQsWiSHsw8vbL4o
	 RjebWhOYASgWk0sBPvsbIbnY=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 73B2040E015E;
	Wed, 19 Mar 2025 17:29:43 +0000 (UTC)
Date: Wed, 19 Mar 2025 18:29:35 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mike Rapoport <rppt@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, kvm@vger.kernel.org,
	linux-efi@vger.kernel.org, Junaid Shahid <junaids@google.com>,
	Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH RFC v2 04/29] mm: asi: Add infrastructure for boot-time
 enablement
Message-ID: <20250319172935.GMZ9r-_zzXhyhHBLfj@fat_crate.local>
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
 <20250110-asi-rfc-v2-v2-4-8419288bc805@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250110-asi-rfc-v2-v2-4-8419288bc805@google.com>

On Fri, Jan 10, 2025 at 06:40:30PM +0000, Brendan Jackman wrote:
> Add a boot time parameter to control the newly added X86_FEATURE_ASI.
> "asi=on" or "asi=off" can be used in the kernel command line to enable
> or disable ASI at boot time. If not specified, ASI enablement depends
> on CONFIG_ADDRESS_SPACE_ISOLATION_DEFAULT_ON, which is off by default.

I don't know yet why we need this default-on thing...

> asi_check_boottime_disable() is modeled after
> pti_check_boottime_disable().
> 
> The boot parameter is currently ignored until ASI is fully functional.
> 
> Once we have a set of ASI features checked in that we have actually
> tested, we will stop ignoring the flag. But for now let's just add the
> infrastructure so we can implement the usage code.
> 
> Ignoring checkpatch.pl CONFIG_DESCRIPTION because the _DEFAULT_ON
> Kconfig is trivial to explain.

Those last two paragraphs go...

> Checkpatch-args: --ignore CONFIG_DESCRIPTION
> Co-developed-by: Junaid Shahid <junaids@google.com>
> Signed-off-by: Junaid Shahid <junaids@google.com>
> Co-developed-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

... here as that's text not really pertaining to the contents of the patch.

>  arch/x86/Kconfig                         |  9 +++++
>  arch/x86/include/asm/asi.h               | 19 ++++++++--
>  arch/x86/include/asm/cpufeatures.h       |  1 +
>  arch/x86/include/asm/disabled-features.h |  8 ++++-
>  arch/x86/mm/asi.c                        | 61 +++++++++++++++++++++++++++-----
>  arch/x86/mm/init.c                       |  4 ++-
>  include/asm-generic/asi.h                |  4 +++
>  7 files changed, 92 insertions(+), 14 deletions(-)

...

>   * the N ASI classes.
>   */
>  
> +#define static_asi_enabled() cpu_feature_enabled(X86_FEATURE_ASI)

Yeah, as already mentioned somewhere else, whack that thing pls.

> +
>  /*
>   * ASI uses a per-CPU tainting model to track what mitigation actions are
>   * required on domain transitions. Taints exist along two dimensions:
> @@ -131,6 +134,8 @@ struct asi {
>  
>  DECLARE_PER_CPU_ALIGNED(struct asi *, curr_asi);
>  
> +void asi_check_boottime_disable(void);
> +
>  void asi_init_mm_state(struct mm_struct *mm);
>  
>  int asi_init_class(enum asi_class_id class_id, struct asi_taint_policy *taint_policy);
> @@ -155,7 +160,9 @@ void asi_exit(void);
>  /* The target is the domain we'll enter when returning to process context. */
>  static __always_inline struct asi *asi_get_target(struct task_struct *p)
>  {
> -	return p->thread.asi_state.target;
> +	return static_asi_enabled()
> +	       ? p->thread.asi_state.target
> +	       : NULL;

Waaay too fancy for old people:

	if ()
		return...
	else
		return NULL;

:-)

The others too pls.

>  static __always_inline void asi_set_target(struct task_struct *p,
> @@ -166,7 +173,9 @@ static __always_inline void asi_set_target(struct task_struct *p,
>  
>  static __always_inline struct asi *asi_get_current(void)
>  {
> -	return this_cpu_read(curr_asi);
> +	return static_asi_enabled()
> +	       ? this_cpu_read(curr_asi)
> +	       : NULL;
>  }
>  
>  /* Are we currently in a restricted address space? */
> @@ -175,7 +184,11 @@ static __always_inline bool asi_is_restricted(void)
>  	return (bool)asi_get_current();
>  }
>  
> -/* If we exit/have exited, can we stay that way until the next asi_enter? */
> +/*
> + * If we exit/have exited, can we stay that way until the next asi_enter?

What is that supposed to mean here?

> + *
> + * When ASI is disabled, this returns true.
> + */
>  static __always_inline bool asi_is_relaxed(void)
>  {
>  	return !asi_get_target(current);
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 913fd3a7bac6506141de65f33b9ee61c615c7d7d..d6a808d10c3b8900d190ea01c66fc248863f05e2 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -474,6 +474,7 @@
>  #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
>  #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
>  #define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
> +#define X86_FEATURE_ASI			(21*32+6) /* Kernel Address Space Isolation */
>  
>  /*
>   * BUG word(s)
> diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
> index c492bdc97b0595ec77f89dc9b0cefe5e3e64be41..c7964ed4fef8b9441e1c0453da587787d8008d9d 100644
> --- a/arch/x86/include/asm/disabled-features.h
> +++ b/arch/x86/include/asm/disabled-features.h
> @@ -50,6 +50,12 @@
>  # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
>  #endif
>  
> +#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
> +# define DISABLE_ASI		0
> +#else
> +# define DISABLE_ASI		(1 << (X86_FEATURE_ASI & 31))
> +#endif
> +
>  #ifdef CONFIG_MITIGATION_RETPOLINE
>  # define DISABLE_RETPOLINE	0
>  #else
> @@ -154,7 +160,7 @@
>  #define DISABLED_MASK17	0
>  #define DISABLED_MASK18	(DISABLE_IBT)
>  #define DISABLED_MASK19	(DISABLE_SEV_SNP)
> -#define DISABLED_MASK20	0
> +#define DISABLED_MASK20	(DISABLE_ASI)
>  #define DISABLED_MASK21	0
>  #define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
>  

Right, that hunk is done this way now:

diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
index e12d5b7e39a2..f219eaf664fb 100644
--- a/arch/x86/Kconfig.cpufeatures
+++ b/arch/x86/Kconfig.cpufeatures
@@ -199,3 +199,7 @@ config X86_DISABLED_FEATURE_SEV_SNP
 config X86_DISABLED_FEATURE_INVLPGB
 	def_bool y
 	depends on !BROADCAST_TLB_FLUSH
+
+config X86_DISABLED_FEATURE_ASI
+	def_bool y
+	depends on !MITIGATION_ADDRESS_SPACE_ISOLATION


> diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
> index 105cd8b43eaf5c20acc80d4916b761559fb95d74..5baf563a078f5b3a6cd4b9f5e92baaf81b0774c4 100644
> --- a/arch/x86/mm/asi.c
> +++ b/arch/x86/mm/asi.c
> @@ -4,6 +4,7 @@
>  #include <linux/percpu.h>
>  #include <linux/spinlock.h>
>  
> +#include <linux/init.h>
>  #include <asm/asi.h>
>  #include <asm/cmdline.h>
>  #include <asm/cpufeature.h>
> @@ -29,6 +30,9 @@ static inline bool asi_class_id_valid(enum asi_class_id class_id)
>  
>  static inline bool asi_class_initialized(enum asi_class_id class_id)
>  {
> +	if (!boot_cpu_has(X86_FEATURE_ASI))

check_for_deprecated_apis: WARNING: arch/x86/mm/asi.c:33: Do not use boot_cpu_has() - use cpu_feature_enabled() instead.

Check your whole set pls.

> +		return 0;
> +
>  	if (WARN_ON(!asi_class_id_valid(class_id)))
>  		return false;
>  
> @@ -51,6 +55,9 @@ EXPORT_SYMBOL_GPL(asi_init_class);
>  
>  void asi_uninit_class(enum asi_class_id class_id)
>  {
> +	if (!boot_cpu_has(X86_FEATURE_ASI))
> +		return;
> +
>  	if (!asi_class_initialized(class_id))
>  		return;
>  
> @@ -66,10 +73,36 @@ const char *asi_class_name(enum asi_class_id class_id)
>  	return asi_class_names[class_id];
>  }
>  
> +void __init asi_check_boottime_disable(void)
> +{
> +	bool enabled = IS_ENABLED(CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION_DEFAULT_ON);
> +	char arg[4];
> +	int ret;
> +
> +	ret = cmdline_find_option(boot_command_line, "asi", arg, sizeof(arg));
> +	if (ret == 3 && !strncmp(arg, "off", 3)) {
> +		enabled = false;
> +		pr_info("ASI disabled through kernel command line.\n");
> +	} else if (ret == 2 && !strncmp(arg, "on", 2)) {
> +		enabled = true;
> +		pr_info("Ignoring asi=on param while ASI implementation is incomplete.\n");
> +	} else {
> +		pr_info("ASI %s by default.\n",
> +			enabled ? "enabled" : "disabled");
> +	}
> +
> +	if (enabled)
> +		pr_info("ASI enablement ignored due to incomplete implementation.\n");

Incomplete how?

> +}
> +
>  static void __asi_destroy(struct asi *asi)
>  {
> -	lockdep_assert_held(&asi->mm->asi_init_lock);
> +	WARN_ON_ONCE(asi->ref_count <= 0);
> +	if (--(asi->ref_count) > 0)

Switch that to

include/linux/kref.h

It gives you a sanity-checking functionality too so you don't need the WARN...

> +		return;
>  
> +	free_pages((ulong)asi->pgd, PGD_ALLOCATION_ORDER);
> +	memset(asi, 0, sizeof(struct asi));

And then you can do:

	if (kref_put())
		free_pages...

and so on.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

