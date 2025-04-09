Return-Path: <linux-arch+bounces-11351-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8B6A82315
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 13:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED589888513
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 11:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623BB255E32;
	Wed,  9 Apr 2025 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMFcv85N"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD1218AC7;
	Wed,  9 Apr 2025 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744196837; cv=none; b=Gkm4brOtk4rnIMzBjxBozfDwmvI6deIV3nqs1uYkpnANulszs6jN+3Kr8ffdiUmxpLDsqqeqH/ODDDGsfqzDx7zIUteN1tD0/XTyTUBNpfKWY/+FVF9+1YF06iSzao9GtcUXICeuvptCeLEYTjlBX0A1SR9mfwr1KCtlYpoLPTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744196837; c=relaxed/simple;
	bh=5WALcSlXLF4jOWGCUwqVjywh8RLohDbgqlLN686J2Co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwZcMY3fOyquGo1q1bAhZF1mz63fHUto9sDVqOQfXJP15xJixsPd1P0pwe0QGyKPyEEuyFL3kQhFOPYe890y0nvUzHxmA6lhH8x9s5m14qZ921qD8v5+IYC27z5DRSIiJeNfEyL4zGBkdT32YLY3hBX5J8JlBMSFyUw/kGuxkIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMFcv85N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282B0C4CEE3;
	Wed,  9 Apr 2025 11:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744196837;
	bh=5WALcSlXLF4jOWGCUwqVjywh8RLohDbgqlLN686J2Co=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JMFcv85NoqIbs4DlNh1qTYARvZUZr7qnD6MYTCBnS1G1L2lbk2dErmODU1foLYFGu
	 MOkY1q7D5/QVRHYEdCphs9+N/wYsulyW237bRmUNa42sKemo64gxVxZgfjFE2YQDwo
	 oACNTULyMZXi1mLH3Q/VcGTwZp+URx76kspAgajXRw9G0tLGrqtyjO8gm4Slg9VDFv
	 JnuH0ZRSfSgsB5hyo51dhOaJvObq5ZxGk4JSnhdRIAz2XFkws37ZJAWaTQ2KeePD0t
	 V/7Ge0OCTeuIKR9WBwQ+3KUno9Ems9m5LJVHCUTPX5Ggn4Dc1OfE1sn8uKK7WLAPO2
	 TQlyHB/vkq4NQ==
Message-ID: <66e54eb9-58b3-4559-af32-66a77fe1ea01@kernel.org>
Date: Wed, 9 Apr 2025 13:07:11 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] percpu/x86: Enable strict percpu checks via named
 AS qualifiers
To: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org
Cc: Nadav Amit <nadav.amit@gmail.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20250127160709.80604-1-ubizjak@gmail.com>
 <20250127160709.80604-7-ubizjak@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250127160709.80604-7-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27. 01. 25, 17:05, Uros Bizjak wrote:
> This patch declares percpu variables in __seg_gs/__seg_fs named AS
> and keeps them named AS qualified until they are dereferenced with
> percpu accessor. This approach enables various compiler check
> for cross-namespace variable assignments.

So this causes modpost to fail to version some symbols:

> WARNING: modpost: EXPORT symbol "xen_vcpu_id" [vmlinux] version generation failed, symbol will not be versioned.
> Is "xen_vcpu_id" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "irq_stat" [vmlinux] version generation failed, symbol will not be versioned.
> Is "irq_stat" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "fred_rsp0" [vmlinux] version generation failed, symbol will not be versioned.
> Is "fred_rsp0" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "cpu_dr7" [vmlinux] version generation failed, symbol will not be versioned.
> Is "cpu_dr7" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "cpu_tss_rw" [vmlinux] version generation failed, symbol will not be versioned.
> Is "cpu_tss_rw" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "__tss_limit_invalid" [vmlinux] version generation failed, symbol will not be versioned.
> Is "__tss_limit_invalid" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "irq_fpu_usable" [vmlinux] version generation failed, symbol will not be versioned.
> Is "irq_fpu_usable" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "cpu_info" [vmlinux] version generation failed, symbol will not be versioned.
> Is "cpu_info" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "gdt_page" [vmlinux] version generation failed, symbol will not be versioned.
> Is "gdt_page" prototyped in <asm/asm-prototypes.h>?
 > ...

That happens both with 6.15-rc1 and today's -next. Ideas?

Config:
https://github.com/SUSE/kernel-source/blob/master/config/x86_64/default

It is enough to:
   make CC='ccache gcc-14' O=../our -j160 vmlinux
to see the above.

> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Acked-by: Nadav Amit <nadav.amit@gmail.com>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>   arch/x86/include/asm/percpu.h | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> index 27f668660abe..474d648bca9a 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -95,9 +95,18 @@
>   
>   #endif /* CONFIG_SMP */
>   
> -#define __my_cpu_type(var)	typeof(var) __percpu_seg_override
> -#define __my_cpu_ptr(ptr)	(__my_cpu_type(*(ptr))*)(__force uintptr_t)(ptr)
> -#define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
> +#if defined(CONFIG_USE_X86_SEG_SUPPORT) && defined(USE_TYPEOF_UNQUAL)
> +# define __my_cpu_type(var)	typeof(var)
> +# define __my_cpu_ptr(ptr)	(ptr)
> +# define __my_cpu_var(var)	(var)
> +
> +# define __percpu_qual		__percpu_seg_override
> +#else
> +# define __my_cpu_type(var)	typeof(var) __percpu_seg_override
> +# define __my_cpu_ptr(ptr)	(__my_cpu_type(*(ptr))*)(__force uintptr_t)(ptr)
> +# define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
> +#endif
> +
>   #define __percpu_arg(x)		__percpu_prefix "%" #x
>   #define __force_percpu_arg(x)	__force_percpu_prefix "%" #x

thanks,
-- 
js
suse labs


