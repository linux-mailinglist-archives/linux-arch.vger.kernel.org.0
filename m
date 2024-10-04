Return-Path: <linux-arch+bounces-7711-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C89499131E
	for <lists+linux-arch@lfdr.de>; Sat,  5 Oct 2024 01:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1ADC283C16
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 23:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5491553AB;
	Fri,  4 Oct 2024 23:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VFMWUCaI"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D710154C0D;
	Fri,  4 Oct 2024 23:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084978; cv=none; b=bbe9fc6RdmkWL9P1rFA0Xj+JvcrVN8E/v0edkkkEAFJR3LxoVNplMcMHlcRidesCx58tBLdiF8AWCl6yDuZmksueOijB3a+e0ht0SZnap4Fths8xuVI7Cf52xk21dZQDrZM5p8FeRi57uPWom6fCnQkvo+jVROejpsgZWiCmrm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084978; c=relaxed/simple;
	bh=iQeWTsGfFnfHDK7LMNoqjyhkjqdxiz1+pWQDmHMP8bU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoOYocW7kxO1W/FXX+FLNd7DDYXB3JIAalFmKQJyR4JjDUdE+uhI1gQA33oC2i19t6CFx0C/WinKTajO0v9GwgRkJyRni4SNV5XxqP2j9zzVQVDTlVG9qeflgS+BWOa5NVurk7AtpFR/wuenQbnLJNa6NSIeP+Owu6mi9jW8ikU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VFMWUCaI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2A53520DB378;
	Fri,  4 Oct 2024 16:36:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A53520DB378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1728084971;
	bh=12axO/5wR11TqDYAjMUHSrOD2AfHvidYKZrZQKRTf6A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VFMWUCaIBQ8EPngTdqNePaLPH2kkoNqFcBK/p9OaD+RiCdUGSPby/3CpF48CZYHaY
	 eY/NnzTien9H0BMtpRrMbaLJvgp4vqtsKvnLlAgaJ8zjpzojV8LzZ/bwvHv8uwKT4B
	 kWIeP6x8lWVWbV3kya4o+mW+YLB+SThKWXYXNOSo=
Message-ID: <17d5a6fd-9f4e-4987-a9fd-dff45cae10a2@linux.microsoft.com>
Date: Fri, 4 Oct 2024 16:36:06 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] hyperv: Use hvhdk.h instead of hyperv-tlfs.h in
 Hyper-V code
To: Simon Horman <horms@kernel.org>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, iommu@lists.linux.dev,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, virtualization@lists.linux.dev,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 seanjc@google.com, pbonzini@redhat.com, peterz@infradead.org,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, arnd@arndb.de, sgarzare@redhat.com,
 jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mukeshrathor@microsoft.com
References: <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1727985064-18362-6-git-send-email-nunodasneves@linux.microsoft.com>
 <20241004191104.GI1310185@kernel.org>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20241004191104.GI1310185@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/2024 12:11 PM, Simon Horman wrote:
> Hi,
> 
> With this change in place I see allmodconfig x86_64 builds reporting that
> HV_REGISTER_FEATURES is undeclared.
> 
> arch/arm64/hyperv/mshyperv.c: In function 'hyperv_init':
> arch/arm64/hyperv/mshyperv.c:53:26: error: 'HV_REGISTER_FEATURES' undeclared (first use in this function); did you mean 'HV_REGISTER_FEATURES_INFO'?
>    53 |         hv_get_vpreg_128(HV_REGISTER_FEATURES, &result);
>       |                          ^~~~~~~~~~~~~~~~~~~~
>       |                          HV_REGISTER_FEATURES_INFO
> arch/arm64/hyperv/mshyperv.c:53:26: note: each undeclared identifier is reported only once for each function it appears in
> arch/arm64/hyperv/mshyperv.c:58:26: error: 'HV_REGISTER_ENLIGHTENMENTS' undeclared (first use in this function); did you mean 'HV_ACCESS_REENLIGHTENMENT'?
>    58 |         hv_get_vpreg_128(HV_REGISTER_ENLIGHTENMENTS, &result);
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                          HV_ACCESS_REENLIGHTENMENT
> 

Ah, I did forgot to check arm64. Thanks for the catch, I'll be sure to
fix it for v2.

> 
> And here too, with x86_64 allmodconfig.
> 
> In file included from ./include/linux/string.h:390,
>                  from ./include/linux/efi.h:16,
>                  from arch/x86/hyperv/hv_init.c:12:
> arch/x86/hyperv/hv_init.c: In function 'get_vtl':
> ./include/linux/overflow.h:372:23: error: invalid application of 'sizeof' to incomplete type 'struct hv_get_vp_registers_input'
>   372 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
>       |                       ^
> ./include/linux/fortify-string.h:502:42: note: in definition of macro '__fortify_memset_chk'
>   502 |         size_t __fortify_size = (size_t)(size);                         \
>       |                                          ^~~~
> arch/x86/hyperv/hv_init.c:427:9: note: in expansion of macro 'memset'
>   427 |         memset(input, 0, struct_size(input, element, 1));
>       |         ^~~~~~
> arch/x86/hyperv/hv_init.c:427:26: note: in expansion of macro 'struct_size'
>   427 |         memset(input, 0, struct_size(input, element, 1));
>       |                          ^~~~~~~~~~~
> 
> [errors trimmed for the sake of brevity]
> 
> ...
> 

Thanks

> 
> And, likewise, with this patch applied I see a number of errors when
> compiling this file. This is with allmodconfig on x86_64 with:
> 
> Modified: CONFIG_HYPERV=y (instead of m)
> Added: CONFIG_HYPERV_VTL_MODE=y
> 

Thanks again,
Ah, I wish there was a way to check these different combinations of y/m
more easily.

> arch/x86/hyperv/hv_vtl.c: In function 'hv_vtl_bringup_vcpu':
> arch/x86/hyperv/hv_vtl.c:154:34: error: 'HVCALL_ENABLE_VP_VTL' undeclared (first use in this function)
>   154 |         status = hv_do_hypercall(HVCALL_ENABLE_VP_VTL, input, NULL);
>       |                                  ^~~~~~~~~~~~~~~~~~~~
> arch/x86/hyperv/hv_vtl.c:154:34: note: each undeclared identifier is reported only once for each function it appears in
> In file included from ./include/linux/string.h:390,
>                  from ./include/linux/bitmap.h:13,
>                  from ./include/linux/cpumask.h:12,
>                  from ./arch/x86/include/asm/apic.h:5,
>                  from arch/x86/hyperv/hv_vtl.c:9:
> arch/x86/hyperv/hv_vtl.c: In function 'hv_vtl_apicid_to_vp_id':
> arch/x86/hyperv/hv_vtl.c:189:32: error: invalid application of 'sizeof' to incomplete type 'struct hv_get_vp_from_apic_id_in'
>   189 |         memset(input, 0, sizeof(*input));
>       |                                ^
> ./include/linux/fortify-string.h:502:42: note: in definition of macro '__fortify_memset_chk'
>   502 |         size_t __fortify_size = (size_t)(size);                         \
>       |                                          ^~~~
> arch/x86/hyperv/hv_vtl.c:189:9: note: in expansion of macro 'memset'
>   189 |         memset(input, 0, sizeof(*input));
>       |         ^~~~~~
> arch/x86/hyperv/hv_vtl.c:190:14: error: invalid use of undefined type 'struct hv_get_vp_from_apic_id_in'
>   190 |         input->partition_id = HV_PARTITION_ID_SELF;
>       |              ^~
> arch/x86/hyperv/hv_vtl.c:191:14: error: invalid use of undefined type 'struct hv_get_vp_from_apic_id_in'
>   191 |         input->apic_ids[0] = apic_id;
>       |              ^~
> arch/x86/hyperv/hv_vtl.c:195:45: error: 'HVCALL_GET_VP_ID_FROM_APIC_ID' undeclared (first use in this function)
>   195 |         control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
>       |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> ...

Looks like I'm missing a one or two definitions in the new headers, and the
names have changed slightly in couple of cases. I'll do some more thorough
checking and have it all fixed for v2.

I didn't know about this allmodconfig target, that will make it a bit easier!

Nuno

