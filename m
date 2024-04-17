Return-Path: <linux-arch+bounces-3780-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3952B8A8D95
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 23:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4611C2131E
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 21:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E168F495CB;
	Wed, 17 Apr 2024 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khHF4Kla"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E699B37163;
	Wed, 17 Apr 2024 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713388590; cv=none; b=Fb6SwUEs7UoKjBJ2QA9KQxmcSBn5xhcvGINp31msiVbRvIbFgiRL2pNF7KuI49gqPrkq4XfQXV6HiJnoqdLp/XeS/mGRv5+Db7ozOQgcI6qXw6e8PwdxP3bii+/gLB04kSuubQuPpfnpNDA9+Dh5z1gwJoj0pU80kw/PVFZLIJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713388590; c=relaxed/simple;
	bh=B8k0rdHz9AorZ8E2yhSratxIp+xQyckEI2Rmzx/g7NU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LPTiKs8f4AuOvfeUrrNb1DM34aiufJkWTygzrOoYosu1gc2ONV9C+t2FrTXjJ6xKAsQrqa+/cPxaU4xf9Qt4BJpW0KbcG3i8xwkcgQad2f7InXq5EeFxuaEaNPHm9gDxguf85voPG0J1yFv0OzohNlMAtLVvp9DAwEqnBEFmHCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khHF4Kla; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ecff9df447so246412b3a.1;
        Wed, 17 Apr 2024 14:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713388587; x=1713993387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bn6gtyCUSwijw+6XX0qI9C//f05i55ZPnAFUJjnUL90=;
        b=khHF4KlaSlUMwRvFnAXhT6aAxJ3H68ONM4EQimKS2OKWfrU1FYu0io1xoX1A9DAmAJ
         tmnkQSYsVBEOMddjskYVEcjEAKKDopw9g54KZILywLdzaC2FtRNU31+56ks3TjHoOWhh
         GwDkjYwHhxo2Tt6tZTCpGW7aQ7SXyLj2wLyvZO3CwLseY3mgTlvbe+M9nBWyJJI1Vcbo
         nSCjoqit9MzsEHoUrx+F1R+Eg30wNT+4yfI+2iNAPyM0yJ7STovIxe8svR5hEuLxWODm
         mUNEFLDU6FMGPPgU5kE28S1UkwkUy2I/Zwl+Cv2QObvDWySvkz63OiG3XVYeLP2nw/bK
         a7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713388587; x=1713993387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bn6gtyCUSwijw+6XX0qI9C//f05i55ZPnAFUJjnUL90=;
        b=M3/IA/K22jTkCMxKHWvjJkgbaURynhyohVoFjHIWq0vPni4RqWDy0lkN4f71dqIVQ/
         ZErYYIctjlUo1+wNN03dt9BLA92BN8+ZlYEyKwHKCOU9dvM8vyG0SUYfymmzDAErekah
         F1ng65h2iH/jW2CUk36p162s4BqKHt1V/gyraLwHOpryHVxrLnzZcxjrpkOcA7f87iB5
         fVRhZd+KddYvFfs0q16z3Az9MbhXmrF+J1y7DkA1rNvnfIqhyk9Qk3rta666VbJSOxhJ
         GclwCYPvkF8T6etLCmjiKbfQrZCUtNHnog3LxApaa+94K/k/3ElUtFvOJ2Nqqm8fxEWK
         8ykQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqHeWQcmAEHHGDr1dQDsAbZE/GS3Ya+mLKsQB4SJvT1+S2f+HwwvxX1ev+6fqPPqiOFO1wRN/XlfvB+52EKga7kPgfOEa2YqMw2xSEw57FnYnTLKRxAvkFmaOnWoAirAj2r6T3ivK2MnVMZwNix/iiCBEKT0xUKsgfz2S6EEWcSb+UKuvhMizS3nIz6k6Si6Vc7DkMfiPQsJhcUeUW/e7lIHtFzZnXwzihNUW332J9+v7fD9XXO7+8qSjmx1VKVAicYb3l0M9IDCjInVnarvaAr3kJDfQPggdz7txg45nd0cfFUdzCDElSMimzJKnrBi+XpOxnDXr68f+bA8D6mtisMSI0L6MrlRDR9cKF9lbe8WWhnt3kNv6ytgiecOCqRC0GdeV4lt9C3ld0QyQ=
X-Gm-Message-State: AOJu0YyjfYlFiKm9ztD6Ofy37xWf1oxygn1iqh1RnM4uyXAF8T5Z/1w2
	paOAaB33F8rnT6gjGBN2ueaB//zXiP64KK16F/2kfO1eMXiFPx2K
X-Google-Smtp-Source: AGHT+IGaiPoLXXXpVrpLOJx1iAETWJgKsjUW+rWbh5/bn42gLXIa3/rbbH0xm62Oxp9IYd0WoUIt9A==
X-Received: by 2002:aa7:8884:0:b0:6eb:1d5:6e43 with SMTP id z4-20020aa78884000000b006eb01d56e43mr962657pfe.11.1713388587052;
        Wed, 17 Apr 2024 14:16:27 -0700 (PDT)
Received: from devnote2 (113x37x226x201.ap113.ftth.ucom.ne.jp. [113.37.226.201])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00218300b006ed4aa9d48esm110372pfi.212.2024.04.17.14.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 14:16:26 -0700 (PDT)
Date: Thu, 18 Apr 2024 06:16:15 +0900
From: Masami Hiramatsu <masami.hiramatsu@gmail.com>
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
 Michael Ellerman <mpe@ellerman.id.au>, Nadav Amit <nadav.amit@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Puranjay Mohan <puranjay12@gmail.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, Russell King
 <linux@armlinux.org.uk>, Song Liu <song@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 bpf@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 14/15] kprobes: remove dependency on CONFIG_MODULES
Message-Id: <20240418061615.5fad23b954bf317c029acc4d@gmail.com>
In-Reply-To: <20240411160051.2093261-15-rppt@kernel.org>
References: <20240411160051.2093261-1-rppt@kernel.org>
	<20240411160051.2093261-15-rppt@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Mike,

On Thu, 11 Apr 2024 19:00:50 +0300
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

Thanks for this work, but this conflicts with the latest fix in v6.9-rc4.
Also, can you use IS_ENABLED(CONFIG_MODULES) instead of #ifdefs in
function body? We have enough dummy functions for that, so it should
not make a problem.

Thank you,

> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>  arch/Kconfig                |  2 +-
>  kernel/kprobes.c            | 43 +++++++++++++++++++++----------------
>  kernel/trace/trace_kprobe.c | 11 ++++++++++
>  3 files changed, 37 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index bc9e8e5dccd5..68177adf61a0 100644
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
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 047ca629ce49..90c056853e6f 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1580,6 +1580,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  		goto out;
>  	}
>  
> +#ifdef CONFIG_MODULES
>  	/* Check if 'p' is probing a module. */
>  	*probed_mod = __module_text_address((unsigned long) p->addr);
>  	if (*probed_mod) {
> @@ -1603,6 +1604,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  			ret = -ENOENT;
>  		}
>  	}
> +#endif
> +
>  out:
>  	preempt_enable();
>  	jump_label_unlock();
> @@ -2482,24 +2485,6 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
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
> @@ -2564,6 +2549,25 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
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
> @@ -2665,6 +2669,7 @@ static struct notifier_block kprobe_module_nb = {
>  	.notifier_call = kprobes_module_callback,
>  	.priority = 0
>  };
> +#endif
>  
>  void kprobe_free_init_mem(void)
>  {
> @@ -2724,8 +2729,10 @@ static int __init init_kprobes(void)
>  	err = arch_init_kprobes();
>  	if (!err)
>  		err = register_die_notifier(&kprobe_exceptions_nb);
> +#ifdef CONFIG_MODULES
>  	if (!err)
>  		err = register_module_notifier(&kprobe_module_nb);
> +#endif
>  
>  	kprobes_initialized = (err == 0);
>  	kprobe_sysctls_init();
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 14099cc17fc9..f0610137d6a3 100644
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
> @@ -704,6 +712,7 @@ static struct notifier_block trace_kprobe_module_nb = {
>  	.notifier_call = trace_kprobe_module_callback,
>  	.priority = 1	/* Invoked after kprobe module callback */
>  };
> +#endif
>  
>  static int count_symbols(void *data, unsigned long unused)
>  {
> @@ -1933,8 +1942,10 @@ static __init int init_kprobe_trace_early(void)
>  	if (ret)
>  		return ret;
>  
> +#ifdef CONFIG_MODULES
>  	if (register_module_notifier(&trace_kprobe_module_nb))
>  		return -EINVAL;
> +#endif
>  
>  	return 0;
>  }
> -- 
> 2.43.0
> 
> 


-- 
Masami Hiramatsu

