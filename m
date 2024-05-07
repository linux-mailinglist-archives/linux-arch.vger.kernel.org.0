Return-Path: <linux-arch+bounces-4256-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124C58BF317
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 02:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353E81C22868
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 00:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC3813340E;
	Tue,  7 May 2024 23:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WH1d1Zrd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C242B13329C;
	Tue,  7 May 2024 23:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715125274; cv=none; b=OkB35gfkdzPhtxtDSZ4xgBJaX+HxhZRSo/vGhdQEEV5SQ3ksd4gKg110XV6oqNBBnWG8KIrg6i0gwC28u81zkEaeCKv2aG1aTHFRZ4SGQJc6xiwi22vHHkA0ro4iKNjdg8lGoLJOKgqC9G9mHqwnUFwN3gpTLAqnx0RSIXLU52w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715125274; c=relaxed/simple;
	bh=ODKOUMcSjW/vZC3ltI6tPmb1ZIxhx2e2qI8/N+kVOFM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=t6CwqmleLwgGY8hf61vJqTDLDLKUtwOl7IzBSRD290G2mMXBMDMCx2LipMBcNV+MIlJJGXlHmZeFSZuCnSIP01uaA+ypqj6ovQ9E8BObn5JsrlczQyJPZMNFW+hJSgwjhYqdHmj6d7yuiJRfiFhF3lDHotmh5ouLRqgfEu8Km9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WH1d1Zrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7C2C2BBFC;
	Tue,  7 May 2024 23:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715125273;
	bh=ODKOUMcSjW/vZC3ltI6tPmb1ZIxhx2e2qI8/N+kVOFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WH1d1ZrdOijFn1cT49Jm2ZUSrhswkNac03IVHqq7Eohwb66eyC/upbIRg5OmSQrS5
	 590jVcfK2eY7mGIT+Mu2vfZ+2kgvT+bvvG+nO0mpjkaiB/hzuVoCqKdsgEfcB6GUI1
	 tZHVMdm8HMaoJWCDDdSEsUeSS2shrn9LwS64jApcEtp551mG5S0J2RXLfrbG59V5J/
	 HlHuUhoLZsEzbSOo52SetyHK+GisTyafXt2qQ3WQN6uI/FPqAL3Mvb4Ag0onvgsMRn
	 PVoqChvTS3nyekeTg4nrB1W8PoOH/gLtrOXEqRETwcHpFeC7NS6eZgZtaW77r3KgQl
	 SXWjnlSGSut3Q==
Date: Wed, 8 May 2024 08:41:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, "David S. Miller"
 <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, Donald Dutile
 <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>, Heiko Carstens
 <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen
 <chenhuacai@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, Liviu
 Dudau <liviu@dudau.co.uk>, Luis Chamberlain <mcgrof@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nadav Amit <nadav.amit@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Rick
 Edgecombe <rick.p.edgecombe@intel.com>, Russell King
 <linux@armlinux.org.uk>, Sam Ravnborg <sam@ravnborg.org>, Song Liu
 <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner
 <tglx@linutronix.de>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, netdev@vger.kernel.org,
 sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH RESEND v8 05/16] module: make module_memory_{alloc,free}
 more self-contained
Message-Id: <20240508084102.9e9b18a9b111d427e7cc9c94@kernel.org>
In-Reply-To: <20240505160628.2323363-6-rppt@kernel.org>
References: <20240505160628.2323363-1-rppt@kernel.org>
	<20240505160628.2323363-6-rppt@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun,  5 May 2024 19:06:17 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Move the logic related to the memory allocation and freeing into
> module_memory_alloc() and module_memory_free().
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  kernel/module/main.c | 64 +++++++++++++++++++++++++++-----------------
>  1 file changed, 39 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index e1e8a7a9d6c1..5b82b069e0d3 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1203,15 +1203,44 @@ static bool mod_mem_use_vmalloc(enum mod_mem_type type)
>  		mod_mem_type_is_core_data(type);
>  }
>  
> -static void *module_memory_alloc(unsigned int size, enum mod_mem_type type)
> +static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
>  {
> +	unsigned int size = PAGE_ALIGN(mod->mem[type].size);
> +	void *ptr;
> +
> +	mod->mem[type].size = size;
> +
>  	if (mod_mem_use_vmalloc(type))
> -		return vzalloc(size);
> -	return module_alloc(size);
> +		ptr = vmalloc(size);
> +	else
> +		ptr = module_alloc(size);
> +
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	/*
> +	 * The pointer to these blocks of memory are stored on the module
> +	 * structure and we keep that around so long as the module is
> +	 * around. We only free that memory when we unload the module.
> +	 * Just mark them as not being a leak then. The .init* ELF
> +	 * sections *do* get freed after boot so we *could* treat them
> +	 * slightly differently with kmemleak_ignore() and only grey
> +	 * them out as they work as typical memory allocations which
> +	 * *do* eventually get freed, but let's just keep things simple
> +	 * and avoid *any* false positives.
> +	 */
> +	kmemleak_not_leak(ptr);
> +
> +	memset(ptr, 0, size);
> +	mod->mem[type].base = ptr;
> +
> +	return 0;
>  }
>  
> -static void module_memory_free(void *ptr, enum mod_mem_type type)
> +static void module_memory_free(struct module *mod, enum mod_mem_type type)
>  {
> +	void *ptr = mod->mem[type].base;
> +
>  	if (mod_mem_use_vmalloc(type))
>  		vfree(ptr);
>  	else
> @@ -1229,12 +1258,12 @@ static void free_mod_mem(struct module *mod)
>  		/* Free lock-classes; relies on the preceding sync_rcu(). */
>  		lockdep_free_key_range(mod_mem->base, mod_mem->size);
>  		if (mod_mem->size)
> -			module_memory_free(mod_mem->base, type);
> +			module_memory_free(mod, type);
>  	}
>  
>  	/* MOD_DATA hosts mod, so free it at last */
>  	lockdep_free_key_range(mod->mem[MOD_DATA].base, mod->mem[MOD_DATA].size);
> -	module_memory_free(mod->mem[MOD_DATA].base, MOD_DATA);
> +	module_memory_free(mod, MOD_DATA);
>  }
>  
>  /* Free a module, remove from lists, etc. */
> @@ -2225,7 +2254,6 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>  static int move_module(struct module *mod, struct load_info *info)
>  {
>  	int i;
> -	void *ptr;
>  	enum mod_mem_type t = 0;
>  	int ret = -ENOMEM;
>  
> @@ -2234,26 +2262,12 @@ static int move_module(struct module *mod, struct load_info *info)
>  			mod->mem[type].base = NULL;
>  			continue;
>  		}
> -		mod->mem[type].size = PAGE_ALIGN(mod->mem[type].size);
> -		ptr = module_memory_alloc(mod->mem[type].size, type);
> -		/*
> -                 * The pointer to these blocks of memory are stored on the module
> -                 * structure and we keep that around so long as the module is
> -                 * around. We only free that memory when we unload the module.
> -                 * Just mark them as not being a leak then. The .init* ELF
> -                 * sections *do* get freed after boot so we *could* treat them
> -                 * slightly differently with kmemleak_ignore() and only grey
> -                 * them out as they work as typical memory allocations which
> -                 * *do* eventually get freed, but let's just keep things simple
> -                 * and avoid *any* false positives.
> -		 */
> -		kmemleak_not_leak(ptr);
> -		if (!ptr) {
> +
> +		ret = module_memory_alloc(mod, type);
> +		if (ret) {
>  			t = type;
>  			goto out_enomem;
>  		}
> -		memset(ptr, 0, mod->mem[type].size);
> -		mod->mem[type].base = ptr;
>  	}
>  
>  	/* Transfer each section which specifies SHF_ALLOC */
> @@ -2296,7 +2310,7 @@ static int move_module(struct module *mod, struct load_info *info)
>  	return 0;
>  out_enomem:
>  	for (t--; t >= 0; t--)
> -		module_memory_free(mod->mem[t].base, t);
> +		module_memory_free(mod, t);
>  	return ret;
>  }
>  
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

