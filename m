Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF19177567
	for <lists+linux-arch@lfdr.de>; Tue,  3 Mar 2020 12:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgCCLnn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Mar 2020 06:43:43 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:56549 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbgCCLnm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Mar 2020 06:43:42 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48WwBh1JC1z9sRR;
        Tue,  3 Mar 2020 22:43:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1583235820;
        bh=nOO9oToQ/xIPGPmuZ0TLmlpPQiquuVGw+6ok+mPYvBI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mjEHZigQJccxoIFnY9rOrBpmXcx5aJDmv5dwwYXNGl6pOsozTNK7xaVxXP+Vllx3a
         thlyQePEIBdFHX/6TVwh25nElPQjitJlHW3UzCp1L35wigbqpnS4QJmMeRTjuFE19I
         JUOLBdMjEvEWyaRLKgAlB72dZsFVys2IMM1o7rWoJOErrm0B38iJMRysFbFbSwBkcq
         efX10t3i9tnwUwFgTWt2kgzw9YJ+C+3coD8/zd+aqnU8GC/LZ2pTO2303w4bkGlrec
         3n2v0+CdPtMM9SOelBvYsRGCXyQrBaknMVQVx30GqGprte4snEF99U3+UmcwyrGTsA
         o6X7GjGLW5Iqg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, skiboot@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc/powernv: Wire up OPAL address lookups
In-Reply-To: <20200228031027.271510-2-npiggin@gmail.com>
References: <20200228031027.271510-1-npiggin@gmail.com> <20200228031027.271510-2-npiggin@gmail.com>
Date:   Tue, 03 Mar 2020 22:43:36 +1100
Message-ID: <87v9nlr7dj.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:
> Use ARCH_HAS_ADDRESS_LOOKUP to look up the opal symbol table. This
> allows crashes and xmon debugging to print firmware symbols.
>
>   Oops: System Reset, sig: 6 [#1]
>   LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
>   Modules linked in:
>   CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.0-rc2-dirty #903
>   NIP:  0000000030020434 LR: 000000003000378c CTR: 0000000030020414
>   REGS: c0000000fffc3d70 TRAP: 0100   Not tainted  (5.6.0-rc2-dirty)
>   MSR:  9000000002101002 <SF,HV,VEC,ME,RI>  CR: 28022284  XER: 20040000
>   CFAR: 0000000030003788 IRQMASK: 3
>   GPR00: 000000003000378c 0000000031c13c90 0000000030136200 c0000000012cfa10
>   GPR04: c0000000012cfa10 0000000000000010 0000000000000000 0000000031c10060
>   GPR08: c0000000012cfaaf 0000000030003640 0000000000000000 0000000000000001
>   GPR12: 00000000300e0000 c000000001490000 0000000000000000 c00000000139c588
>   GPR16: 0000000031c10000 c00000000125a900 0000000000000000 c0000000012076a8
>   GPR20: c0000000012a3950 0000000000000001 0000000031c10060 c0000000012cfaaf
>   GPR24: 0000000000000019 0000000030003640 0000000000000000 0000000000000000
>   GPR28: 0000000000000010 c0000000012cfa10 0000000000000000 0000000000000000
>   NIP [0000000030020434] .dummy_console_write_buffer_space+0x20/0x64 [OPAL]
>   LR [000000003000378c] opal_entry+0x14c/0x17c [OPAL]
>
> This won't unwind the firmware stack (or its Linux caller) properly if
> firmware and kernel endians don't match, but that problem could be solved
> in powerpc's unwinder.

How well does this work if we're tracing opal calls at the time we oops :)

Though it looks like that's already fishy because we don't do anything
to disable tracing of opal_console_write().

I guess I'm a bit wary of adding numerous further opal calls in the oops
path, I'm sure the opal symbol lookup code is bug free, but still.

Could we instead suck in the opal symbols early on, and search them in
Linux? I suspect you've thought of that and rejected it, but it would be
good to document why.

cheers

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 497b7d0b2d7e..4d32b02d35e8 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -115,6 +115,7 @@ config PPC
>  	# Please keep this list sorted alphabetically.
>  	#
>  	select ARCH_32BIT_OFF_T if PPC32
> +	select ARCH_HAS_ADDRESS_LOOKUP		if PPC_POWERNV
>  	select ARCH_HAS_DEBUG_VIRTUAL
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select ARCH_HAS_ELF_RANDOMIZE
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index c1f25a760eb1..c3a2a797177a 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -214,7 +214,11 @@
>  #define OPAL_SECVAR_GET				176
>  #define OPAL_SECVAR_GET_NEXT			177
>  #define OPAL_SECVAR_ENQUEUE_UPDATE		178
> -#define OPAL_LAST				178
> +#define OPAL_PHB_SET_OPTION			179
> +#define OPAL_PHB_GET_OPTION			180

Only pull in the calls you need for this patch.

> +#define OPAL_GET_SYMBOL				181
> +#define OPAL_LOOKUP_SYMBOL			182
> +#define OPAL_LAST				182
>  
>  #define QUIESCE_HOLD			1 /* Spin all calls at entry */
>  #define QUIESCE_REJECT			2 /* Fail all calls with OPAL_BUSY */
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 9986ac34b8e2..ef2d9273f06f 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -312,6 +312,9 @@ s64 opal_mpipl_query_tag(enum opal_mpipl_tags tag, u64 *addr);
>  s64 opal_signal_system_reset(s32 cpu);
>  s64 opal_quiesce(u64 shutdown_type, s32 cpu);
>  
> +int64_t opal_get_symbol(uint64_t addr, __be64 *symaddr, __be64 *symsize, char *namebuf, uint64_t buflen);
> +int64_t opal_lookup_symbol(const char *name, __be64 *symaddr, __be64 *symsize);
> +
>  /* Internal functions */
>  extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
>  				   int depth, void *data);
> diff --git a/arch/powerpc/platforms/powernv/opal-call.c b/arch/powerpc/platforms/powernv/opal-call.c
> index 5cd0f52d258f..ba11112d94df 100644
> --- a/arch/powerpc/platforms/powernv/opal-call.c
> +++ b/arch/powerpc/platforms/powernv/opal-call.c
> @@ -293,3 +293,5 @@ OPAL_CALL(opal_mpipl_query_tag,			OPAL_MPIPL_QUERY_TAG);
>  OPAL_CALL(opal_secvar_get,			OPAL_SECVAR_GET);
>  OPAL_CALL(opal_secvar_get_next,			OPAL_SECVAR_GET_NEXT);
>  OPAL_CALL(opal_secvar_enqueue_update,		OPAL_SECVAR_ENQUEUE_UPDATE);
> +OPAL_CALL(opal_get_symbol,			OPAL_GET_SYMBOL);
> +OPAL_CALL(opal_lookup_symbol,			OPAL_LOOKUP_SYMBOL);
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 2b3dfd0b6cdd..fdf6c4e6f7f9 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -107,6 +107,46 @@ void opal_configure_cores(void)
>  		cur_cpu_spec->cpu_restore();
>  }
>  
> +const char *arch_address_lookup(unsigned long addr,
> +			    unsigned long *symbolsize,
> +			    unsigned long *offset,
> +			    char **modname, char *namebuf)
> +{
> +	__be64 symaddr;
> +	__be64 symsize;
> +
> +	if (!firmware_has_feature(FW_FEATURE_OPAL))
> +		return NULL;
> +
> +	if (opal_get_symbol(addr, &symaddr, &symsize, namebuf,
> +			cpu_to_be64(KSYM_NAME_LEN)) != OPAL_SUCCESS)
> +		return NULL;
> +
> +	*symbolsize = be64_to_cpu(symsize);
> +	*offset = addr - be64_to_cpu(symaddr);
> +	*modname = "OPAL";
> +
> +	return namebuf;
> +}
> +
> +unsigned long arch_address_lookup_name(const char *name)
> +{
> +	__be64 addr;
> +	__be64 size;
> +
> +	if (!firmware_has_feature(FW_FEATURE_OPAL))
> +		return 0;
> +
> +	/* opal: prefix allows lookup of symbols that clash with kernel */
> +	if (!strncasecmp(name, "opal:", strlen("opal:")))
> +		name += strlen("opal:");
> +
> +	if (opal_lookup_symbol(name, &addr, &size) != OPAL_SUCCESS)
> +		return 0;
> +
> +	return be64_to_cpu(addr);
> +}
> +
>  int __init early_init_dt_scan_opal(unsigned long node,
>  				   const char *uname, int depth, void *data)
>  {
> -- 
> 2.23.0
