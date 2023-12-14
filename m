Return-Path: <linux-arch+bounces-1028-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB75F8125DE
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 04:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB4EB20C9E
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 03:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF8015BD;
	Thu, 14 Dec 2023 03:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="JmklQYzW"
X-Original-To: linux-arch@vger.kernel.org
X-Greylist: delayed 493 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Dec 2023 19:21:21 PST
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBABC85;
	Wed, 13 Dec 2023 19:21:21 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 454B78285335;
	Wed, 13 Dec 2023 21:13:07 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id aJF90hcXi7Us; Wed, 13 Dec 2023 21:13:03 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id C3CB28285337;
	Wed, 13 Dec 2023 21:13:03 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com C3CB28285337
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1702523583; bh=ijcDfjdAHPSkgI60gYNqmpLjOskbQcDua+7+LnRVJzY=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=JmklQYzWjHfnhGBk0Pue29Qiptfb7YADfyXDqn0JfVXKwGNbTbAmFZG3wiYCyMqNe
	 rfAr7pp8jfi9zjR0+vw1Pgwi+/hhDR84MDQViA6vnu/RRW42LYFNMaBEOFkaxVqHPr
	 jfugf/dzymBNIbcy+lefHFKr3DOfOjzhVf3hA9Vw=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vndKCEKQZBqx; Wed, 13 Dec 2023 21:13:03 -0600 (CST)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 90B9D8285335;
	Wed, 13 Dec 2023 21:13:03 -0600 (CST)
Date: Wed, 13 Dec 2023 21:13:01 -0600 (CST)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	amd-gfx <amd-gfx@lists.freedesktop.org>, 
	linux-arch <linux-arch@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	loongarch@lists.linux.dev, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, x86 <x86@kernel.org>, 
	linux-riscv@lists.infradead.org, 
	Christoph Hellwig <hch@infradead.org>, 
	Timothy Pearson <tpearson@raptorengineering.com>
Message-ID: <1124363169.403562.1702523581672.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <7ed20fcf-8a9d-40d5-b913-b5d2da443cd6@sifive.com>
References: <20231208055501.2916202-1-samuel.holland@sifive.com> <20231208055501.2916202-11-samuel.holland@sifive.com> <87h6kpdj20.fsf@mail.lhotse> <7ed20fcf-8a9d-40d5-b913-b5d2da443cd6@sifive.com>
Subject: Re: [RFC PATCH 10/12] drm/amd/display: Use
 ARCH_HAS_KERNEL_FPU_SUPPORT
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC112 (Linux)/8.5.0_GA_3042)
Thread-Topic: drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
Thread-Index: 3gIP2WGRdA0OkYkVtH266e032Oz33A==



----- Original Message -----
> From: "Samuel Holland" <samuel.holland@sifive.com>
> To: "Michael Ellerman" <mpe@ellerman.id.au>
> Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "amd-gfx" <amd-gfx@lists.freedesktop.org>, "linux-arch"
> <linux-arch@vger.kernel.org>, "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>, loongarch@lists.linux.dev,
> "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "x86" <x86@kernel.org>, linux-riscv@lists.infradead.org, "Christoph
> Hellwig" <hch@infradead.org>, "Timothy Pearson" <tpearson@raptorengineering.com>
> Sent: Wednesday, December 13, 2023 7:03:20 PM
> Subject: Re: [RFC PATCH 10/12] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT

> On 2023-12-11 6:23 AM, Michael Ellerman wrote:
>> Hi Samuel,
>> 
>> Thanks for trying to clean all this up.
>> 
>> One problem below.
>> 
>> Samuel Holland <samuel.holland@sifive.com> writes:
>>> Now that all previously-supported architectures select
>>> ARCH_HAS_KERNEL_FPU_SUPPORT, this code can depend on that symbol instead
>>> of the existing list of architectures. It can also take advantage of the
>>> common kernel-mode FPU API and method of adjusting CFLAGS.
>>>
>>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ...
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
>>> index 4ae4720535a5..b64f917174ca 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
>>> @@ -87,20 +78,9 @@ void dc_fpu_begin(const char *function_name, const int line)
>>>  	WARN_ON_ONCE(!in_task());
>>>  	preempt_disable();
>>>  	depth = __this_cpu_inc_return(fpu_recursion_depth);
>>> -
>>>  	if (depth == 1) {
>>> -#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
>>> +		BUG_ON(!kernel_fpu_available());
>>>  		kernel_fpu_begin();
>>> -#elif defined(CONFIG_PPC64)
>>> -		if (cpu_has_feature(CPU_FTR_VSX_COMP))
>>> -			enable_kernel_vsx();
>>> -		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
>>> -			enable_kernel_altivec();
>>  
>> Note altivec.
>> 
>>> -		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
>>> -			enable_kernel_fp();
>>> -#elif defined(CONFIG_ARM64)
>>> -		kernel_neon_begin();
>>> -#endif
>>>  	}
>>>  
>>>  	TRACE_DCN_FPU(true, function_name, line, depth);
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>> b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>> index ea7d60f9a9b4..5aad0f572ba3 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>> @@ -25,40 +25,8 @@
>>>  # It provides the general basic services required by other DAL
>>>  # subcomponents.
>>>  
>>> -ifdef CONFIG_X86
>>> -dml_ccflags-$(CONFIG_CC_IS_GCC) := -mhard-float
>>> -dml_ccflags := $(dml_ccflags-y) -msse
>>> -endif
>>> -
>>> -ifdef CONFIG_PPC64
>>> -dml_ccflags := -mhard-float -maltivec
>>> -endif
>> 
>> And altivec is enabled in the flags there.
>> 
>> That doesn't match your implementation for powerpc in patch 7, which
>> only deals with float.
>> 
>> I suspect the AMD driver actually doesn't need altivec enabled, but I
>> don't know that for sure. It compiles without it, but I don't have a GPU
>> to actually test. I've added Timothy on Cc who added the support for
>> powerpc to the driver originally, hopefully he has a test system.

If you would like me to test I'm happy to do so, but I am travelling until Friday so would need to wait until then.

Thanks!

