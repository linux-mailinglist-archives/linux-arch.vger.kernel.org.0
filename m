Return-Path: <linux-arch+bounces-1023-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEBC81243D
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 02:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC881C20F37
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 01:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DAE642;
	Thu, 14 Dec 2023 01:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="luqCGhKQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF2EDB
	for <linux-arch@vger.kernel.org>; Wed, 13 Dec 2023 17:03:22 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77f552d4179so350543285a.1
        for <linux-arch@vger.kernel.org>; Wed, 13 Dec 2023 17:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702515802; x=1703120602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kotqopmhql9RPm3S4FTj2FqpufLgCsxyuc5LZys4ifw=;
        b=luqCGhKQ+HP7bttcW5BLW+u5dk+GyIIWBl0ddK26FJ5ASe25ubZVhh2CbsNPQ351sd
         BoiQHVRT9Tc752acgKTKH+r7XksL2Mj7rCZRygP7dPCnACHCS8G8b/Qg7RLeJfOjATAr
         uF/HcQbao4P5ACi9/OpaaXIv56FzEfqnC5t00tx+wEhCkzQhSaxr+d9EbQNDrMk0vGP0
         zY0hhe1aCmDEZPUfCkHSqHztn7oumkiiJSdRgXps66ygKaCYyK0svKWRpceyXUihGVEO
         cAhhpqbee4qU1bQTDjabLqAzys4/6CqQGcjjXQGpFe3skYZwoNnECpWbsvv1FH0zAWlw
         FQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702515802; x=1703120602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kotqopmhql9RPm3S4FTj2FqpufLgCsxyuc5LZys4ifw=;
        b=EprAEgXcL53JQs4Bl9hqH8o/211v5+vtstgDDxNNcs08CzTu6FtGu/F1x5aI6sZT9e
         NSaZecfQXdTPPadqbRXVmuc+S5pZbFiF43/N6LJBkJt+CigoZMclpLwM70awxLSro3TH
         BSPkVpOTuCXtjPkCmUzMVQhqFWXZpm5achBo6ZH24KMx6ZabVxROrnAiIyDebfIZBi+j
         QmqWofecERZyDxUsG/SibrECrjiievRdJi/d4Se1E/1PzsKCNlKgoyN94HNyQt4R0wk3
         ptYBo0See9ssLIBcUwebH22oJOPI4j28tcUV8gaOE6dpzYPp9NIjHRTpKvTGMKqMLcef
         hDvw==
X-Gm-Message-State: AOJu0YzmpJnzRNhjwV2x7aR3qqxxcbcYcVp2QWxikQ4f7b6by2H6Ksfl
	IvcuJ3hLoa/dXJgo0zzVpgMqdd7IlyZlh/+u0PaX3w==
X-Google-Smtp-Source: AGHT+IFjYn4/wlSclY9FQAk7x1h05GKodk6C3zlVMTJ3BbOMNQ8WP5BrWLxO1hQ2sob52mgNqAJxdQ==
X-Received: by 2002:a05:620a:1034:b0:77f:2734:4c5d with SMTP id a20-20020a05620a103400b0077f27344c5dmr9834012qkk.130.1702515801849;
        Wed, 13 Dec 2023 17:03:21 -0800 (PST)
Received: from ?IPV6:2600:1700:2000:b002:a1d1:dd74:a6de:fdf? ([2600:1700:2000:b002:a1d1:dd74:a6de:fdf])
        by smtp.gmail.com with ESMTPSA id ul9-20020a05620a6d0900b0077f0d3bac3bsm4896980qkn.76.2023.12.13.17.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 17:03:21 -0800 (PST)
Message-ID: <7ed20fcf-8a9d-40d5-b913-b5d2da443cd6@sifive.com>
Date: Wed, 13 Dec 2023 19:03:20 -0600
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/12] drm/amd/display: Use
 ARCH_HAS_KERNEL_FPU_SUPPORT
Content-Language: en-US
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, Christoph Hellwig <hch@infradead.org>,
 Timothy Pearson <tpearson@raptorengineering.com>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-11-samuel.holland@sifive.com>
 <87h6kpdj20.fsf@mail.lhotse>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <87h6kpdj20.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-11 6:23 AM, Michael Ellerman wrote:
> Hi Samuel,
> 
> Thanks for trying to clean all this up.
> 
> One problem below.
> 
> Samuel Holland <samuel.holland@sifive.com> writes:
>> Now that all previously-supported architectures select
>> ARCH_HAS_KERNEL_FPU_SUPPORT, this code can depend on that symbol instead
>> of the existing list of architectures. It can also take advantage of the
>> common kernel-mode FPU API and method of adjusting CFLAGS.
>>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ...
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
>> index 4ae4720535a5..b64f917174ca 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
>> @@ -87,20 +78,9 @@ void dc_fpu_begin(const char *function_name, const int line)
>>  	WARN_ON_ONCE(!in_task());
>>  	preempt_disable();
>>  	depth = __this_cpu_inc_return(fpu_recursion_depth);
>> -
>>  	if (depth == 1) {
>> -#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
>> +		BUG_ON(!kernel_fpu_available());
>>  		kernel_fpu_begin();
>> -#elif defined(CONFIG_PPC64)
>> -		if (cpu_has_feature(CPU_FTR_VSX_COMP))
>> -			enable_kernel_vsx();
>> -		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
>> -			enable_kernel_altivec();
>  
> Note altivec.
> 
>> -		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
>> -			enable_kernel_fp();
>> -#elif defined(CONFIG_ARM64)
>> -		kernel_neon_begin();
>> -#endif
>>  	}
>>  
>>  	TRACE_DCN_FPU(true, function_name, line, depth);
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> index ea7d60f9a9b4..5aad0f572ba3 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> @@ -25,40 +25,8 @@
>>  # It provides the general basic services required by other DAL
>>  # subcomponents.
>>  
>> -ifdef CONFIG_X86
>> -dml_ccflags-$(CONFIG_CC_IS_GCC) := -mhard-float
>> -dml_ccflags := $(dml_ccflags-y) -msse
>> -endif
>> -
>> -ifdef CONFIG_PPC64
>> -dml_ccflags := -mhard-float -maltivec
>> -endif
> 
> And altivec is enabled in the flags there.
> 
> That doesn't match your implementation for powerpc in patch 7, which
> only deals with float.
> 
> I suspect the AMD driver actually doesn't need altivec enabled, but I
> don't know that for sure. It compiles without it, but I don't have a GPU
> to actually test. I've added Timothy on Cc who added the support for
> powerpc to the driver originally, hopefully he has a test system.

I tested this series on a POWER9 system with an AMD Radeon RX 6400 GPU (which
requires this FPU code to initialize), and got functioning graphics output.

> Anyway if that's true that it doesn't need altivec we should probably do
> a lead-up patch that drops altivec from the AMD driver explicitly, eg.
> as below.

That makes sense to me. Do you want to provide your Signed-off-by so I can send
this patch with your authorship?

Regards,
Samuel

> cheers
> 
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> index 4ae4720535a5..0de16796466b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> @@ -92,11 +92,7 @@ void dc_fpu_begin(const char *function_name, const int line)
>  #if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
>  		kernel_fpu_begin();
>  #elif defined(CONFIG_PPC64)
> -		if (cpu_has_feature(CPU_FTR_VSX_COMP))
> -			enable_kernel_vsx();
> -		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
> -			enable_kernel_altivec();
> -		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
> +		if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
>  			enable_kernel_fp();
>  #elif defined(CONFIG_ARM64)
>  		kernel_neon_begin();
> @@ -125,11 +121,7 @@ void dc_fpu_end(const char *function_name, const int line)
>  #if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
>  		kernel_fpu_end();
>  #elif defined(CONFIG_PPC64)
> -		if (cpu_has_feature(CPU_FTR_VSX_COMP))
> -			disable_kernel_vsx();
> -		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
> -			disable_kernel_altivec();
> -		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
> +		if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
>  			disable_kernel_fp();
>  #elif defined(CONFIG_ARM64)
>  		kernel_neon_end();
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index 6042a5a6a44f..554c39024a40 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -31,7 +31,7 @@ dml_ccflags := $(dml_ccflags-y) -msse
>  endif
>  
>  ifdef CONFIG_PPC64
> -dml_ccflags := -mhard-float -maltivec
> +dml_ccflags := -mhard-float
>  endif
>  
>  ifdef CONFIG_ARM64
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/Makefile b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
> index acff3449b8d7..7b51364084b5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
> @@ -30,7 +30,7 @@ dml2_ccflags := $(dml2_ccflags-y) -msse
>  endif
>  
>  ifdef CONFIG_PPC64
> -dml2_ccflags := -mhard-float -maltivec
> +dml2_ccflags := -mhard-float
>  endif
>  
>  ifdef CONFIG_ARM64


