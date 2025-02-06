Return-Path: <linux-arch+bounces-10044-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E094A2AA58
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2025 14:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF466188921E
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2025 13:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FCE1C6FEE;
	Thu,  6 Feb 2025 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Cz1P6bFE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618CC1EA7F1
	for <linux-arch@vger.kernel.org>; Thu,  6 Feb 2025 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738849835; cv=none; b=ZhelwkdIkwInKn6P4fpJrQB+KTyVBNJgd3VOZHpZMoV3cVbw9KcjZWYdgEG31x/tZ738P1N30oxgYh4jDwzt1ZxlCJmlHeSOt/MgpQCPDNA7kdYdmm0+X9c1xjhcANUs6MsFydWDgLi6ziPeF4ANHnNsjxoSNMeSZWJU8Dnrw7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738849835; c=relaxed/simple;
	bh=eQAAGwqNOl7v+M9a4ivw00ivo+95Yco+MnJBXOwIKAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxwEIGrNzliFAx+YQDC/sY+5w84vKATJ66kgRRoN2aN+Y9JG7L+3vgdqJvxBbUU7fuyxeid+KwaPOQ78QnSy89d2C1dbTbLrFDtR3b7EdDPeJ68oZWAjTWRHpw35d9VmdenLWITEyhRqh7il/lmg5KdY/Goew3n4jC/LAZfsTas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Cz1P6bFE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38dabb11eaaso463729f8f.0
        for <linux-arch@vger.kernel.org>; Thu, 06 Feb 2025 05:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738849832; x=1739454632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZqG9Iy11y+7j3Q1qmHPl/yKVh88xdsRebgLzRhIb/28=;
        b=Cz1P6bFE92HuscbEUlQZ5N4TG2VoG7SA53cQMFhVWCFlDqez+Ygx2znFCkao7s9QVu
         DHc3L1PdWy2Ivr44FzHKhLT+iAmbNX0t8ktKGQUM1A601ARdwH8WgO4R0qtwl4xHlzl3
         yqg8QO2/dooso+d7BjaUo0sEWtb3gVZMDTIzrFGLA7ruyTYXtzvvcVi90XNrkTaTQyFA
         9YiVM9dq/PhhZe5zUKMZEtj1qdybJk51tXi1qTz3TLGprhYLS8+UajcYL+xc6xtgkHJj
         AnP5KbLXh2hiWyouT3jvO4gXSFG3M0QXzqYJqoi3kATURA0qf7JnvBq2RIKNUWACAdfD
         K+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738849832; x=1739454632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqG9Iy11y+7j3Q1qmHPl/yKVh88xdsRebgLzRhIb/28=;
        b=R4Jx2gX5fdxPNMS4IC837h8FhW7jAUkEN/jHaAJrF3o2PdLW4xQbL/a6QTjsh8tlPi
         JEmXV4E+1QTdM9ZSjQvHGHrmYUt/vcG2I1WTiDIDxycMQ4DqxSu1loAmeXMA4sQnWr0k
         af52feFP9qXrBJdJe3WfzpRFR/NdH++ZjvqkVMoCif6pZvyCv4e7LaA3KLjv3g3ahTGm
         RkoNZs+faGJtx8tq+vVamioXFF1Vc7rSusSGrkdXhmtRE/3SpKPrOL6HA/7u8AD/GzbA
         Rqb5b7xmP2vxOorJRPwnPIQXs6p+n8SXre0ObQ77KA3N8YrkEJnsnQI3K/Vsk8m3AIjd
         JbfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNcWRG4WjO7k1wwy5Iv2U8GoAHbT9Fb6SY01zkUodk83OOtDeQ2XGZnmzYhyPWPy+TRJ0N2aUsAGi7@vger.kernel.org
X-Gm-Message-State: AOJu0YxPtz63LZ6kpWyw2+5tLJJkqPbWg5zV2dCHFYDGNxjcoVNF5nQe
	srGY1sOriU9aWrIBfM1Uw0F3V3aufoK528JsnMGl1uQ6nOfQZLswhoXOnZqyrLQ=
X-Gm-Gg: ASbGnct2Sl2U7ctqdW7pPVYyxQLinLm4n14Og8CB5HZXhWMrCeHEVbC5oJB7s1QAIKB
	V52oVSMthhteLzJ+TKaSMoD5O8Kmns7rpxTW9qd6Fq/XtY+SxLuifijeXGfN+ESyqBspFuFGY6/
	yDCmyibk6MBr6gG3d3MOxUayqhsQkNFRX1+H9lNbcMSRe6Hhr+LY1izP3dNBmrSKxSA75uiBO/W
	OcTAyxELqHFq9KYp2MsrCYNmgJgVjmCvimjynoh8vt8cW0LJvCe4Iv7ppAlTlaRheluy0GCc1g7
	nDfXTMTG98cXbSjXXD1IfjSxNffUlHdhWz8MtqTKKOJxx8mXCc+xI82MwWPw
X-Google-Smtp-Source: AGHT+IEYIYIWW6J/hIRqm2Y0oUfYR4o1i/HreKUFQmuOWd+xJTMh9Ma+9XSSasA3LYOW3FeM7FN37Q==
X-Received: by 2002:adf:e5cb:0:b0:385:faec:d94d with SMTP id ffacd0b85a97d-38db4910812mr5188370f8f.51.1738849831734;
        Thu, 06 Feb 2025 05:50:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc17e278bsm1117573f8f.48.2025.02.06.05.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 05:50:31 -0800 (PST)
Message-ID: <782ef14c-e7c4-435e-adc6-9559ce3cc06d@rivosinc.com>
Date: Thu, 6 Feb 2025 14:50:29 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/26] riscv: zicfiss / zicfilp enumeration
To: Deepak Gupta <debug@rivosinc.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com,
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
 atishp@rivosinc.com, evan@rivosinc.com, alexghiti@rivosinc.com,
 samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
 <20250204-v5_user_cfi_series-v9-3-b37a49c5205c@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250204-v5_user_cfi_series-v9-3-b37a49c5205c@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/02/2025 02:21, Deepak Gupta wrote:
> This patch adds support for detecting zicfiss and zicfilp. zicfiss and
> zicfilp stands for unprivleged integer spec extension for shadow stack
> and branch tracking on indirect branches, respectively.
> 
> This patch looks for zicfiss and zicfilp in device tree and accordinlgy
> lights up bit in cpu feature bitmap. Furthermore this patch adds detection
> utility functions to return whether shadow stack or landing pads are
> supported by cpu.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/cpufeature.h | 13 +++++++++++++
>  arch/riscv/include/asm/hwcap.h      |  2 ++
>  arch/riscv/include/asm/processor.h  |  1 +
>  arch/riscv/kernel/cpufeature.c      |  2 ++
>  4 files changed, 18 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> index 569140d6e639..69007b8100ca 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -12,6 +12,7 @@
>  #include <linux/kconfig.h>
>  #include <linux/percpu-defs.h>
>  #include <linux/threads.h>
> +#include <linux/smp.h>
>  #include <asm/hwcap.h>
>  #include <asm/cpufeature-macros.h>
>  
> @@ -137,4 +138,16 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
>  	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
>  }
>  
> +static inline bool cpu_supports_shadow_stack(void)
> +{
> +	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
> +		riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICFISS));
> +}
> +
> +static inline bool cpu_supports_indirect_br_lp_instr(void)
> +{
> +	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
> +		riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICFILP));
> +}
> +
>  #endif
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 869da082252a..2dc4232bdb3e 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -100,6 +100,8 @@
>  #define RISCV_ISA_EXT_ZICCRSE		91
>  #define RISCV_ISA_EXT_SVADE		92
>  #define RISCV_ISA_EXT_SVADU		93
> +#define RISCV_ISA_EXT_ZICFILP		94
> +#define RISCV_ISA_EXT_ZICFISS		95
>  
>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
>  
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index 5f56eb9d114a..e3aba3336e63 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -13,6 +13,7 @@
>  #include <vdso/processor.h>
>  
>  #include <asm/ptrace.h>
> +#include <asm/hwcap.h>
>  
>  #define arch_get_mmap_end(addr, len, flags)			\
>  ({								\
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index c6ba750536c3..e72de12e5b99 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -333,6 +333,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts,
>  					  riscv_ext_zicboz_validate),
>  	__RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),
> +	__RISCV_ISA_EXT_SUPERSET(zicfilp, RISCV_ISA_EXT_ZICFILP, riscv_xlinuxenvcfg_exts),
> +	__RISCV_ISA_EXT_SUPERSET(zicfiss, RISCV_ISA_EXT_ZICFISS, riscv_xlinuxenvcfg_exts),

Hey Deepak,

I think these definitions can benefit from using a validation callback:

static int riscv_cfi_validate(const struct riscv_isa_ext_data *data,
				  const unsigned long *isa_bitmap)
{
	if (!IS_ENABLED(CONFIG_RISCV_USER_CFI)
		return -EINVAL;
		
	return 0;
}

__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfilp, RISCV_ISA_EXT_ZICFILP,
riscv_xlinuxenvcfg_exts, riscv_cfi_validate),
__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfiss, RISCV_ISA_EXT_ZICFISS,
riscv_xlinuxenvcfg_exts, riscv_cfi_validate),

That way, ZICFISS/ZICFILP wont be enable if the kernel does not have
builtin support for them. Additionally, this solve a bug you have with
your hwprobe patch (19/26) that exposes ZICFILP/ZICFISS unconditionally
(ie, even if the kernel does not have CONFIG_RISCV_USER_CFI).

BTW, patch 23/26 introduce CONFIG_RISCV_USER_CFI but it is used in that
patch.

Thanks,

Clément

>  	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
>  	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
>  	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
> 


