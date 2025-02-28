Return-Path: <linux-arch+bounces-10466-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AF7A49D8F
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 16:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804C0171C58
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 15:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C1718FDAF;
	Fri, 28 Feb 2025 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vKo+YcgI"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD92B18BB8E
	for <linux-arch@vger.kernel.org>; Fri, 28 Feb 2025 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756803; cv=none; b=GLru3DhBDQuxNxiYhLJTkxPqtqVgZlixE4xGB7wGY5Do1xAe6wRFc0HBsYuPySkZDpZYWOqymsYkSySP4Fl1AlYvBIpQ1R8IwbbQt+IDHm4USMrc6WpoIEY/1nrR0gpGxr1eNmQ0KQSoAstYHxZTl1KV9WmNUp6ZQbPW383IXIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756803; c=relaxed/simple;
	bh=uP5cllxHcBAkoxx0Kn4W8H9CqjahWgT+m4heApmQscU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tos45K/OOlJLnje4MDf0qljECclhoo05gpZeBo+L7od+JPVOF97qr+txSOl/6rnZm1DReB05HxOGNKUKpuHW4PVTnXUyfvZ79P2ONGe1AJtfVvTqY6I95Bb2RY0lp24LX8Z1oE6NuFWzNnpsKRn5F2nFk/XPg+5azSeV6FpreQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vKo+YcgI; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 28 Feb 2025 15:32:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740756788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n9eLJrzvCc/jZ3rhdLc/8pJEkV1JMKG56goBetbpxb4=;
	b=vKo+YcgI7v6lDON+yTHR9woNAvbankK+1SDMyOP89t52IYlLrAIepafV5H3+8AgeYWL/pp
	TS1LqRGd7URb1EH84E98UhU8R08SptbuJvlIbJ9mZtK4wuupGbI0JiYANqWOM+DDaj9sTC
	yy53IqVA9z5qtTyqinZcyR4dcB12SbQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Brendan Jackman <jackmanb@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	linux-efi@vger.kernel.org
Subject: Re: [PATCH RFC v2 25/29] mm: asi: Restricted execution fore
 bare-metal processes
Message-ID: <Z8HXJnhMPFPyDJW5@google.com>
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
 <20250110-asi-rfc-v2-v2-25-8419288bc805@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110-asi-rfc-v2-v2-25-8419288bc805@google.com>
X-Migadu-Flow: FLOW_OUT

(Trimming the CC list as my email server refuses the number of CCs)

On Fri, Jan 10, 2025 at 06:40:51PM +0000, Brendan Jackman wrote:
> Now userspace gets a restricted address space too. The critical section
> begins on exit to userspace and ends when it makes a system call.
> Other entries from userspace just interrupt the critical section via
> asi_intr_enter().
> 
> The reason why system calls have to actually asi_relax() (i.e. fully
> terminate the critical section instead of just interrupting it) is that
> system calls are the type of kernel entry that can lead to transition
> into a _different_ ASI domain, namely the KVM one: it is not supported
> to transition into a different domain while a critical section exists
> (i.e. while asi_state.target is not NULL), even if it has been paused by
> asi_intr_enter() (i.e. even if asi_state.intr_nest_depth is nonzero) -
> there must be an asi_relax() between any two asi_enter()s.
> 
> The restricted address space for bare-metal tasks naturally contains the
> entire userspace address region, although the task's own memory is still
> missing from the direct map.
> 
> This implementation creates new userspace-specific APIs for asi_init(),
> asi_destroy() and asi_enter(), which seems a little ugly, maybe this
> suggest a general rework of these APIs given that the "generic" version
> only has one caller. For RFC code this seems good enough though.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  arch/x86/include/asm/asi.h   |  8 ++++++--
>  arch/x86/mm/asi.c            | 49 ++++++++++++++++++++++++++++++++++++++++----
>  include/asm-generic/asi.h    |  9 +++++++-
>  include/linux/entry-common.h | 11 ++++++++++
>  init/main.c                  |  2 ++
>  kernel/entry/common.c        |  1 +
>  kernel/fork.c                |  4 +++-
>  7 files changed, 76 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
> index e925d7d2cfc85bca8480c837548654e7a5a7009e..c3c1a57f0147ae9bd11d89c8bf7c8a4477728f51 100644
> --- a/arch/x86/include/asm/asi.h
> +++ b/arch/x86/include/asm/asi.h
> @@ -140,19 +140,23 @@ DECLARE_PER_CPU_ALIGNED(struct asi *, curr_asi);
>  
>  void asi_check_boottime_disable(void);
>  
> -void asi_init_mm_state(struct mm_struct *mm);
> +int asi_init_mm_state(struct mm_struct *mm);
>  
>  int asi_init_class(enum asi_class_id class_id, struct asi_taint_policy *taint_policy);
> +void asi_init_userspace_class(void);
>  void asi_uninit_class(enum asi_class_id class_id);
>  const char *asi_class_name(enum asi_class_id class_id);
>  
>  int asi_init(struct mm_struct *mm, enum asi_class_id class_id, struct asi **out_asi);
>  void asi_destroy(struct asi *asi);
> +void asi_destroy_userspace(struct mm_struct *mm);
>  void asi_clone_user_pgtbl(struct mm_struct *mm, pgd_t *pgdp);
>  
>  /* Enter an ASI domain (restricted address space) and begin the critical section. */
>  void asi_enter(struct asi *asi);
>  
> +void asi_enter_userspace(void);
> +
>  /*
>   * Leave the "tense" state if we are in it, i.e. end the critical section. We
>   * will stay relaxed until the next asi_enter.
> @@ -294,7 +298,7 @@ void asi_handle_switch_mm(void);
>   */
>  static inline bool asi_maps_user_addr(enum asi_class_id class_id)
>  {
> -	return false;
> +	return class_id == ASI_CLASS_USERSPACE;
>  }
>  
>  #endif /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
> diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
> index 093103c1bc2677c81d68008aca064fab53b73a62..1e9dc568e79e8686a4dbf47f765f2c2535d025ec 100644
> --- a/arch/x86/mm/asi.c
> +++ b/arch/x86/mm/asi.c
> @@ -25,6 +25,7 @@ const char *asi_class_names[] = {
>  #if IS_ENABLED(CONFIG_KVM)
>  	[ASI_CLASS_KVM] = "KVM",
>  #endif
> +	[ASI_CLASS_USERSPACE] = "userspace",
>  };
>  
>  DEFINE_PER_CPU_ALIGNED(struct asi *, curr_asi);
> @@ -67,6 +68,32 @@ int asi_init_class(enum asi_class_id class_id, struct asi_taint_policy *taint_po
>  }
>  EXPORT_SYMBOL_GPL(asi_init_class);
>  
> +void __init asi_init_userspace_class(void)
> +{
> +	static struct asi_taint_policy policy = {
> +		/*
> +		 * Prevent going to userspace with sensitive data potentially
> +		 * left in sidechannels by code running in the unrestricted
> +		 * address space, or another MM. Note we don't check for guest
> +		 * data here. This reflects the assumption that the guest trusts
> +		 * its VMM (absent fancy HW features, which are orthogonal).
> +		 */
> +		.protect_data = ASI_TAINT_KERNEL_DATA | ASI_TAINT_OTHER_MM_DATA,
> +		/*
> +		 * Don't go into userspace with control flow state controlled by
> +		 * other processes, or any KVM guest the process is running.
> +		 * Note this bit is about protecting userspace from other parts
> +		 * of the system, while data_taints is about protecting other
> +		 * parts of the system from the guest.
> +		 */
> +		.prevent_control = ASI_TAINT_GUEST_CONTROL | ASI_TAINT_OTHER_MM_CONTROL,
> +		.set = ASI_TAINT_USER_CONTROL | ASI_TAINT_USER_DATA,
> +	};
> +	int err = asi_init_class(ASI_CLASS_USERSPACE, &policy);
> +
> +	WARN_ON(err);
> +}
> +
>  void asi_uninit_class(enum asi_class_id class_id)
>  {
>  	if (!boot_cpu_has(X86_FEATURE_ASI))
> @@ -385,7 +412,8 @@ int asi_init(struct mm_struct *mm, enum asi_class_id class_id, struct asi **out_
>  	int err = 0;
>  	uint i;
>  
> -	*out_asi = NULL;
> +	if (out_asi)
> +		*out_asi = NULL;
>  
>  	if (!boot_cpu_has(X86_FEATURE_ASI))
>  		return 0;
> @@ -424,7 +452,7 @@ int asi_init(struct mm_struct *mm, enum asi_class_id class_id, struct asi **out_
>  exit_unlock:
>  	if (err)
>  		__asi_destroy(asi);
> -	else
> +	else if (out_asi)
>  		*out_asi = asi;
>  
>  	__asi_init_user_pgds(mm, asi);
> @@ -515,6 +543,12 @@ static __always_inline void maybe_flush_data(struct asi *next_asi)
>  	this_cpu_and(asi_taints, ~ASI_TAINTS_DATA_MASK);
>  }
>  
> +void asi_destroy_userspace(struct mm_struct *mm)
> +{
> +	VM_BUG_ON(!asi_class_initialized(ASI_CLASS_USERSPACE));
> +	asi_destroy(&mm->asi[ASI_CLASS_USERSPACE]);
> +}
> +
>  noinstr void __asi_enter(void)
>  {
>  	u64 asi_cr3;
> @@ -584,6 +618,11 @@ noinstr void asi_enter(struct asi *asi)
>  }
>  EXPORT_SYMBOL_GPL(asi_enter);
>  
> +noinstr void asi_enter_userspace(void)
> +{
> +	asi_enter(&current->mm->asi[ASI_CLASS_USERSPACE]);
> +}
> +
>  noinstr void asi_relax(void)
>  {
>  	if (static_asi_enabled()) {
> @@ -633,13 +672,15 @@ noinstr void asi_exit(void)
>  }
>  EXPORT_SYMBOL_GPL(asi_exit);
>  
> -void asi_init_mm_state(struct mm_struct *mm)
> +int asi_init_mm_state(struct mm_struct *mm)
>  {
>  	if (!boot_cpu_has(X86_FEATURE_ASI))
> -		return;
> +		return 0;
>  
>  	memset(mm->asi, 0, sizeof(mm->asi));
>  	mutex_init(&mm->asi_init_lock);
> +
> +	return asi_init(mm, ASI_CLASS_USERSPACE, NULL);

I think this call here is problematic. This can be called from
asi_global_init().

An example is:

start_kernel()
poking_init()
mm_alloc()
mm_init()
asi_init_mm_state()

But the same also happen through dup_mm(), for example:

kernel_thread()
kernel_clone()
copy_process()
copy_mm()
dup_mm()

asi_global_init() is called later from do_initcalls() (run in a kthread
by kernel_init()). In this case, asi_init() copies the kernel PGDs from
asi_global_nonsensitive_pgd, but those PGDs won't be initialized yet.

It could be fine for the current code because all these threads created
during init never enter userspace, but I am not sure if that's always
true. It also makes me a bit nervous to have partially initialized ASI
domains hanging around.

I'd rather we either:
- Move asi_global_init() earlier, but we have to be careful not to move
  it too early before some of the mappings it clones are created (or
  before we can make allocations). In this case, we should also add a
  warning in asi_init() in case the code changes and it is ever called
  before asi_global_init().

- Explicitly avoid calling asi_init_mm_state() or asi_init() in these
  cases. This may be easy-ish in the case of kthreads, but for things
  like poking_init() we would need to plump more context through.
  Alternatively we can just make asi_init() a noop if asi_global_init()
  isn't called yet, but the silent failure makes me a bit worried too.

>  }
>  
>  void asi_handle_switch_mm(void)
> diff --git a/include/asm-generic/asi.h b/include/asm-generic/asi.h
> index d103343292fad567dcd73e45e986fb3974e59898..c93f9e779ce1fa61e3df7835f5ab744cce7d667b 100644
> --- a/include/asm-generic/asi.h
> +++ b/include/asm-generic/asi.h
> @@ -15,6 +15,7 @@ enum asi_class_id {
>  #if IS_ENABLED(CONFIG_KVM)
>  	ASI_CLASS_KVM,
>  #endif
> +	ASI_CLASS_USERSPACE,
>  	ASI_MAX_NUM_CLASSES,
>  };
>  static_assert(order_base_2(X86_CR3_ASI_PCID_BITS) <= ASI_MAX_NUM_CLASSES);
> @@ -37,8 +38,10 @@ int asi_init_class(enum asi_class_id class_id,
>  
>  static inline void asi_uninit_class(enum asi_class_id class_id) { }
>  
> +static inline void asi_init_userspace_class(void) { }
> +
>  struct mm_struct;
> -static inline void asi_init_mm_state(struct mm_struct *mm) { }
> +static inline int asi_init_mm_state(struct mm_struct *mm) { return 0; }
>  
>  static inline int asi_init(struct mm_struct *mm, enum asi_class_id class_id,
>  			   struct asi **out_asi)
> @@ -48,8 +51,12 @@ static inline int asi_init(struct mm_struct *mm, enum asi_class_id class_id,
>  
>  static inline void asi_destroy(struct asi *asi) { }
>  
> +static inline void asi_destroy_userspace(struct mm_struct *mm) { }
> +
>  static inline void asi_enter(struct asi *asi) { }
>  
> +static inline void asi_enter_userspace(void) { }
> +
>  static inline void asi_relax(void) { }
>  
>  static inline bool asi_is_relaxed(void) { return true; }
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 1e50cdb83ae501467ecc30ee52f1379d409f962e..f04c4c038556f84ddf3bc09b6c1dd22a9dbd2f6b 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -191,6 +191,16 @@ static __always_inline long syscall_enter_from_user_mode(struct pt_regs *regs, l
>  {
>  	long ret;
>  
> +	/*
> +	 * End the ASI critical section for userspace. Syscalls are the only
> +	 * place this happens - all other entry from userspace is handled via
> +	 * ASI's interrupt-tracking. The reason syscalls are special is that's
> +	 * where it's possible to switch to another ASI domain within the same
> +	 * task (i.e. KVM_RUN), an asi_relax() is required here in case of an
> +	 * upcoming asi_enter().
> +	 */
> +	asi_relax();
> +
>  	enter_from_user_mode(regs);
>  
>  	instrumentation_begin();
> @@ -355,6 +365,7 @@ static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
>   */
>  static __always_inline void exit_to_user_mode(void)
>  {
> +
>  	instrumentation_begin();
>  	trace_hardirqs_on_prepare();
>  	lockdep_hardirqs_on_prepare();
> diff --git a/init/main.c b/init/main.c
> index c4778edae7972f512d5eefe8400075ac35a70d1c..d19e149d385e8321d2f3e7c28aa75802af62d09c 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -953,6 +953,8 @@ void start_kernel(void)
>  	/* Architectural and non-timekeeping rng init, before allocator init */
>  	random_init_early(command_line);
>  
> +	asi_init_userspace_class();
> +
>  	/*
>  	 * These use large bootmem allocations and must precede
>  	 * initalization of page allocator
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 5b6934e23c21d36a3238dc03e391eb9e3beb4cfb..874254ed5958d62eaeaef4fe3e8c02e56deaf5ed 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -218,6 +218,7 @@ __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
>  	__syscall_exit_to_user_mode_work(regs);
>  	instrumentation_end();
>  	exit_to_user_mode();
> +	asi_enter_userspace();
>  }
>  
>  noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
> diff --git a/kernel/fork.c b/kernel/fork.c
> index bb73758790d08112265d398b16902ff9a4c2b8fe..54068d2415939b92409ca8a45111176783c6acbd 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -917,6 +917,7 @@ void __mmdrop(struct mm_struct *mm)
>  	/* Ensure no CPUs are using this as their lazy tlb mm */
>  	cleanup_lazy_tlbs(mm);
>  
> +	asi_destroy_userspace(mm);
>  	WARN_ON_ONCE(mm == current->active_mm);
>  	mm_free_pgd(mm);
>  	destroy_context(mm);
> @@ -1297,7 +1298,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	if (mm_alloc_pgd(mm))
>  		goto fail_nopgd;
>  
> -	asi_init_mm_state(mm);
> +	if (asi_init_mm_state(mm))
> +		goto fail_nocontext;
>  
>  	if (init_new_context(p, mm))
>  		goto fail_nocontext;
> 
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 

