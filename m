Return-Path: <linux-arch+bounces-3551-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 599058A03BB
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 00:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B24D8B21820
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 22:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38788136985;
	Wed, 10 Apr 2024 22:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="InxdgZCZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3361132818
	for <linux-arch@vger.kernel.org>; Wed, 10 Apr 2024 22:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789254; cv=none; b=uefJSt8Ag5ZEg3QiKSHEVpfL2HBgs8pYfBPRRQYcUcZRFyak6SR9/GYkU1qQjOChHIbuOiY6/Mo1S+KoDzA5QHBPuW25EhX7eitYaIkFtEL4f/bEUU41A+iXODOSLiWxI5W/nM/8IWt5UtBIY4po3jsNteaCLiF5zKKk7BIqjhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789254; c=relaxed/simple;
	bh=uDU3PtkfpbBDGwJOViI0NFiMEmcXnUAvLCRTEusiKVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWtFHjNSYEbtyl6AY9b9vaB9T3StNswU8lkk/i/aYAn48psrTBSCWoWk2T1cyjHWvlUdzYpP8u/c1f9CUJwTtVskrlogogSW7DgHLKglLN7otMjWFUDnlaq2qBC67jv1vso4SS0zUjDOEJQWJalbS719h5mQogpQLSL/iBMippE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=InxdgZCZ; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5aa28cde736so2600210eaf.1
        for <linux-arch@vger.kernel.org>; Wed, 10 Apr 2024 15:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712789250; x=1713394050; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jexQJX0oM9fCmEvziBSolme7TKZ0EEYhwHpwJAChgvs=;
        b=InxdgZCZ3tXHTxDN2HsO5Qj8K94kQvCrSlHJ4gVr0UU4P7owLbbLzxcN5yVcHFP+NH
         4Eo//eSwguEo82JBtG2Ns8sya0EkSysyHOUnfp4ou7S7LpxrV0E0/QTH2BFUeHrT3tLS
         6FK5+9wDjmXzugmO/o6KpTcqdkdPrsWKjJMeAd6xg11sz1rsdjl7+8jtGpX1iOxhUgtl
         d46yk0vjJZDHOsDg5ATxjQOZ8lpMLYa6AaflNtnBZMW50Pa4Ilw6TrhHakgd4TMArPoe
         2raTiyl9JBb+KJI0nqedu6OhGlEw5rRKcLgKbZxhizQzUJ/ANVW/8gBvTiTNVsVUK/0V
         zh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712789250; x=1713394050;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jexQJX0oM9fCmEvziBSolme7TKZ0EEYhwHpwJAChgvs=;
        b=Dy+mhLKvpf/JJ05F6Kpo2nvhe/3k3EdUx1rNHaYfgZQBc4g3kBUiVtf2LxUEZNApAN
         U3Cr/hiIIhB6muuSP/C7l31asIO59jAq18um9vBPp+iLAQYXj4fXe7CsqPvqT5AbYmhk
         Lo6uiVWwhpv5OQBLv673E3Y9twtcz9x6Y26VzuMOzhOQqdYdF3ILf0q6rNI7eRWGFbvk
         mVwY7RVCUSMKQ5KfI6bGle2m1n6VkuuJLBfQwhWhVjuLPTcD/+pudBt6N3iHhi/F806L
         +YQQQt0k43J3R0VdMreIR7CRpNSwwblPJqbLtvcw96UXI7FCf7R+FMd8fgkZWxl+wOQ7
         za9g==
X-Forwarded-Encrypted: i=1; AJvYcCXabY3Rh2DScEE3FNXEbqecaclKwEWYTDhjFum3E49sB1Trp2IOLbC1sNySRgl7pgIqihH+83OQymoh6WRxfit1J79F45Lbn0tmyg==
X-Gm-Message-State: AOJu0YyzsSNup89L26ujIL6NWOhOq09ESpAjq1fe5btICDUkxeROZn88
	ocfUEmTkk5PWoRU6XfYt9LHYGBrcw2i33DDGJfWMYg1fDLiJu4HaXFXquWHPl4Y=
X-Google-Smtp-Source: AGHT+IHLiKUoeBUB4OwLHReX4a7dcUh2Eqxld9pK8ip3FgSpidJgLmLzuSWt1Fnkq1wrPVQWu86Qjg==
X-Received: by 2002:a05:6871:80a:b0:22d:f859:2225 with SMTP id q10-20020a056871080a00b0022df8592225mr3914938oap.6.1712789249782;
        Wed, 10 Apr 2024 15:47:29 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.8.167])
        by smtp.gmail.com with ESMTPSA id lf3-20020a0568700c4300b0022eba51882fsm75970oab.53.2024.04.10.15.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 15:47:29 -0700 (PDT)
Message-ID: <75a37a4b-f516-40a3-b6b5-4aa1636f9b60@sifive.com>
Date: Wed, 10 Apr 2024 17:47:27 -0500
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
To: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-14-samuel.holland@sifive.com>
 <87wmp4oo3y.fsf@linaro.org>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <87wmp4oo3y.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Thiago,

On 2024-04-10 5:21 PM, Thiago Jung Bauermann wrote:
> Samuel Holland <samuel.holland@sifive.com> writes:
> 
>> Now that all previously-supported architectures select
>> ARCH_HAS_KERNEL_FPU_SUPPORT, this code can depend on that symbol instead
>> of the existing list of architectures. It can also take advantage of the
>> common kernel-mode FPU API and method of adjusting CFLAGS.
>>
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> 
> Unfortunately this patch causes build failures on arm with allyesconfig
> and allmodconfig. Tested with next-20240410.
> 
> Error with allyesconfig:
> 
> $ make -j 8 \
>     O=$HOME/.cache/builds/linux-cross-arm \
>     ARCH=arm \
>     CROSS_COMPILE=arm-linux-gnueabihf-
> make[1]: Entering directory '/home/bauermann/.cache/builds/linux-cross-arm'
>     ⋮
> arm-linux-gnueabihf-ld: drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.o: in function `dcn20_populate_dml_pipes_from_context':
> dcn20_fpu.c:(.text+0x20f4): undefined reference to `__aeabi_l2d'
> arm-linux-gnueabihf-ld: dcn20_fpu.c:(.text+0x210c): undefined reference to `__aeabi_l2d'
> arm-linux-gnueabihf-ld: dcn20_fpu.c:(.text+0x2124): undefined reference to `__aeabi_l2d'
> arm-linux-gnueabihf-ld: dcn20_fpu.c:(.text+0x213c): undefined reference to `__aeabi_l2d'
> arm-linux-gnueabihf-ld: drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.o: in function `pipe_ctx_to_e2e_pipe_params':
> dcn_calcs.c:(.text+0x390): undefined reference to `__aeabi_l2d'
> arm-linux-gnueabihf-ld: drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.o:dcn_calcs.c:(.text+0x3a4): more undefined references to `__aeabi_l2d' follow
> arm-linux-gnueabihf-ld: drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.o: in function `optimize_configuration':
> dml2_wrapper.c:(.text+0xcbc): undefined reference to `__aeabi_d2ulz'
> arm-linux-gnueabihf-ld: drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.o: in function `populate_dml_plane_cfg_from_plane_state':
> dml2_translation_helper.c:(.text+0x9e4): undefined reference to `__aeabi_l2d'
> arm-linux-gnueabihf-ld: dml2_translation_helper.c:(.text+0xa20): undefined reference to `__aeabi_l2d'
> arm-linux-gnueabihf-ld: dml2_translation_helper.c:(.text+0xa58): undefined reference to `__aeabi_l2d'
> arm-linux-gnueabihf-ld: dml2_translation_helper.c:(.text+0xa90): undefined reference to `__aeabi_l2d'
> make[3]: *** [/home/bauermann/src/linux/scripts/Makefile.vmlinux:37: vmlinux] Error 1
> make[2]: *** [/home/bauermann/src/linux/Makefile:1165: vmlinux] Error 2
> make[1]: *** [/home/bauermann/src/linux/Makefile:240: __sub-make] Error 2
> make[1]: Leaving directory '/home/bauermann/.cache/builds/linux-cross-arm'
> make: *** [Makefile:240: __sub-make] Error 2
> 
> The error with allmodconfig is slightly different:
> 
> $ make -j 8 \
>     O=$HOME/.cache/builds/linux-cross-arm \
>     ARCH=arm \
>     CROSS_COMPILE=arm-linux-gnueabihf-
> make[1]: Entering directory '/home/bauermann/.cache/builds/linux-cross-arm'
>     ⋮
> ERROR: modpost: "__aeabi_d2ulz" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "__aeabi_l2d" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> make[3]: *** [/home/bauermann/src/linux/scripts/Makefile.modpost:145: Module.symvers] Error 1
> make[2]: *** [/home/bauermann/src/linux/Makefile:1876: modpost] Error 2
> make[1]: *** [/home/bauermann/src/linux/Makefile:240: __sub-make] Error 2
> make[1]: Leaving directory '/home/bauermann/.cache/builds/linux-cross-arm'
> make: *** [Makefile:240: __sub-make] Error 2

In both cases, the issue is that the toolchain requires runtime support to
convert between `unsigned long long` and `double`, even when hardware FP is
enabled. There was some past discussion about GCC inlining some of these
conversions[1], but that did not get implemented.

The short-term fix would be to drop the `select ARCH_HAS_KERNEL_FPU_SUPPORT` for
32-bit arm until we can provide these runtime library functions.

Regards,
Samuel

[1]: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91970

