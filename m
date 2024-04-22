Return-Path: <linux-arch+bounces-3888-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DD08ACF0E
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 16:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F201F21819
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2E41509B3;
	Mon, 22 Apr 2024 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZI2g4Uq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C338414F9E1;
	Mon, 22 Apr 2024 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795124; cv=none; b=I8NvMLwqdlQrL69bFqT3d0w6JhCFuJp58mH4j+iwVSK+pPnEAhObe1/JB9IdQQyFcr/XF9+6A/KxCZkqFpC/Qub5zmiLdQmgANRuFdUa2gbPa3HHAySNrMS1eQhezZttUupEirvnPm2HGG6ECYIr75FhebBS0rqX21fhTWzQRLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795124; c=relaxed/simple;
	bh=63rvt2yz8r57hl8myRcuStiGVHTSpmv479F+BVPlgOk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EXwSD1gOrzC1UFPRGE5PVklfn2EoSRdpM7bDx5A8c6v9xGY92yUE7DYBMuHjcoWboURdTr2w4X7aiJpQwuRUlk6lCh0sCZljFPZTVx+fOjhme6Pl/doOqdc+R6TiLVs9/VPwgnkJtli8CrbQU9LQGi+34iQfac4+sgukfYDjUD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZI2g4Uq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAD5C32783;
	Mon, 22 Apr 2024 14:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713795123;
	bh=63rvt2yz8r57hl8myRcuStiGVHTSpmv479F+BVPlgOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XZI2g4UqcleGPHMCMSqV3/iC7oJP0tZWbpfXP00rfR9bLCRfpzFMwC9X4q54oxXMM
	 DnhZrHtKfWP5KsKR0UwBwIDd4eHpEkLzxxX7LPi42cCObWXCldmkT2ETPDxFRfwhiK
	 nyXLCvvf3mWcIJjGAf2BRpg+sGk/r9FACse9FCIZKTAIMRKChgqXwhJ7CqFLLV8oy/
	 QLrmKiFkxPB4YBmwLg/Hf4QkKGO2SUvS8pCcc0bNoMWOtMRS3u0h3n+olJg1vGec5V
	 55mbL/zgu8a6qrqHPaT4tJ+d8LCTGjRW/TTRHz6/VaV0UanNJA0VfQalKnV9xzPuaQ
	 EUKZMBGXl8nFQ==
Date: Mon, 22 Apr 2024 23:11:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, "David S. Miller"
 <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, Donald Dutile
 <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>, Heiko Carstens
 <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen
 <chenhuacai@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, Luis
 Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Nadav Amit <nadav.amit@gmail.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Russell King <linux@armlinux.org.uk>, Sam
 Ravnborg <sam@ravnborg.org>, Song Liu <song@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 bpf@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v5 14/15] kprobes: remove dependency on CONFIG_MODULES
Message-Id: <20240422231151.0d7c18ec1917887c7f323d4c@kernel.org>
In-Reply-To: <20240422094436.3625171-15-rppt@kernel.org>
References: <20240422094436.3625171-1-rppt@kernel.org>
	<20240422094436.3625171-15-rppt@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Apr 2024 12:44:35 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> kprobes depended on CONFIG_MODULES because it has to allocate memory for
> code.
> 
> Since code allocations are now implemented with execmem, kprobes can be
> enabled in non-modular kernels.
> 
> Add #ifdef CONFIG_MODULE guards for the code dealing with kprobes inside
> modules, make CONFIG_KPROBES select CONFIG_EXECMEM and drop the
> dependency of CONFIG_KPROBES on CONFIG_MODULES.

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>  arch/Kconfig                |  2 +-
>  include/linux/module.h      |  9 ++++++
>  kernel/kprobes.c            | 55 +++++++++++++++++++++++--------------
>  kernel/trace/trace_kprobe.c | 20 +++++++++++++-
>  4 files changed, 63 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 7006f71f0110..a48ce6a488b3 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -52,9 +52,9 @@ config GENERIC_ENTRY
>  
>  config KPROBES
>  	bool "Kprobes"
> -	depends on MODULES
>  	depends on HAVE_KPROBES
>  	select KALLSYMS
> +	select EXECMEM
>  	select TASKS_RCU if PREEMPTION
>  	help
>  	  Kprobes allows you to trap at almost any kernel address and
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 1153b0d99a80..ffa1c603163c 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -605,6 +605,11 @@ static inline bool module_is_live(struct module *mod)
>  	return mod->state != MODULE_STATE_GOING;
>  }
>  
> +static inline bool module_is_coming(struct module *mod)
> +{
> +        return mod->state == MODULE_STATE_COMING;
> +}
> +
>  struct module *__module_text_address(unsigned long addr);
>  struct module *__module_address(unsigned long addr);
>  bool is_module_address(unsigned long addr);
> @@ -857,6 +862,10 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr)
>  	return ptr;
>  }
>  
> +static inline bool module_is_coming(struct module *mod)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_MODULES */
>  
>  #ifdef CONFIG_SYSFS
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index ddd7cdc16edf..ca2c6cbd42d2 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1588,7 +1588,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  	}
>  
>  	/* Get module refcount and reject __init functions for loaded modules. */
> -	if (*probed_mod) {
> +	if (IS_ENABLED(CONFIG_MODULES) && *probed_mod) {
>  		/*
>  		 * We must hold a refcount of the probed module while updating
>  		 * its code to prohibit unexpected unloading.
> @@ -1603,12 +1603,13 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  		 * kprobes in there.
>  		 */
>  		if (within_module_init((unsigned long)p->addr, *probed_mod) &&
> -		    (*probed_mod)->state != MODULE_STATE_COMING) {
> +		    !module_is_coming(*probed_mod)) {
>  			module_put(*probed_mod);
>  			*probed_mod = NULL;
>  			ret = -ENOENT;
>  		}
>  	}
> +
>  out:
>  	preempt_enable();
>  	jump_label_unlock();
> @@ -2488,24 +2489,6 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
>  	return 0;
>  }
>  
> -/* Remove all symbols in given area from kprobe blacklist */
> -static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
> -{
> -	struct kprobe_blacklist_entry *ent, *n;
> -
> -	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
> -		if (ent->start_addr < start || ent->start_addr >= end)
> -			continue;
> -		list_del(&ent->list);
> -		kfree(ent);
> -	}
> -}
> -
> -static void kprobe_remove_ksym_blacklist(unsigned long entry)
> -{
> -	kprobe_remove_area_blacklist(entry, entry + 1);
> -}
> -
>  int __weak arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
>  				   char *type, char *sym)
>  {
> @@ -2570,6 +2553,25 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
>  	return ret ? : arch_populate_kprobe_blacklist();
>  }
>  
> +#ifdef CONFIG_MODULES
> +/* Remove all symbols in given area from kprobe blacklist */
> +static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
> +{
> +	struct kprobe_blacklist_entry *ent, *n;
> +
> +	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
> +		if (ent->start_addr < start || ent->start_addr >= end)
> +			continue;
> +		list_del(&ent->list);
> +		kfree(ent);
> +	}
> +}
> +
> +static void kprobe_remove_ksym_blacklist(unsigned long entry)
> +{
> +	kprobe_remove_area_blacklist(entry, entry + 1);
> +}
> +
>  static void add_module_kprobe_blacklist(struct module *mod)
>  {
>  	unsigned long start, end;
> @@ -2672,6 +2674,17 @@ static struct notifier_block kprobe_module_nb = {
>  	.priority = 0
>  };
>  
> +static int kprobe_register_module_notifier(void)
> +{
> +	return register_module_notifier(&kprobe_module_nb);
> +}
> +#else
> +static int kprobe_register_module_notifier(void)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_MODULES */
> +
>  void kprobe_free_init_mem(void)
>  {
>  	void *start = (void *)(&__init_begin);
> @@ -2731,7 +2744,7 @@ static int __init init_kprobes(void)
>  	if (!err)
>  		err = register_die_notifier(&kprobe_exceptions_nb);
>  	if (!err)
> -		err = register_module_notifier(&kprobe_module_nb);
> +		err = kprobe_register_module_notifier();
>  
>  	kprobes_initialized = (err == 0);
>  	kprobe_sysctls_init();
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 14099cc17fc9..2cb2a3951b4f 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -111,6 +111,7 @@ static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
>  	return strncmp(module_name(mod), name, len) == 0 && name[len] == ':';
>  }
>  
> +#ifdef CONFIG_MODULES
>  static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
>  {
>  	char *p;
> @@ -129,6 +130,12 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
>  
>  	return ret;
>  }
> +#else
> +static inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
> +{
> +	return false;
> +}
> +#endif
>  
>  static bool trace_kprobe_is_busy(struct dyn_event *ev)
>  {
> @@ -670,6 +677,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
>  	return ret;
>  }
>  
> +#ifdef CONFIG_MODULES
>  /* Module notifier call back, checking event on the module */
>  static int trace_kprobe_module_callback(struct notifier_block *nb,
>  				       unsigned long val, void *data)
> @@ -704,6 +712,16 @@ static struct notifier_block trace_kprobe_module_nb = {
>  	.notifier_call = trace_kprobe_module_callback,
>  	.priority = 1	/* Invoked after kprobe module callback */
>  };
> +static int trace_kprobe_register_module_notifier(void)
> +{
> +	return register_module_notifier(&trace_kprobe_module_nb);
> +}
> +#else
> +static int trace_kprobe_register_module_notifier(void)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_MODULES */
>  
>  static int count_symbols(void *data, unsigned long unused)
>  {
> @@ -1933,7 +1951,7 @@ static __init int init_kprobe_trace_early(void)
>  	if (ret)
>  		return ret;
>  
> -	if (register_module_notifier(&trace_kprobe_module_nb))
> +	if (trace_kprobe_register_module_notifier())
>  		return -EINVAL;
>  
>  	return 0;
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

