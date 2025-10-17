Return-Path: <linux-arch+bounces-14189-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3C0BEC0E7
	for <lists+linux-arch@lfdr.de>; Sat, 18 Oct 2025 01:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4969F1AA7E0C
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 23:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25B0311979;
	Fri, 17 Oct 2025 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TE89wokE"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0C530E0D3;
	Fri, 17 Oct 2025 23:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745507; cv=none; b=izv2OZ/+mWIvCc/2ksJ/K/XPU03PulMLEWWdFNK30aARlQm6LsTwD19FtPQV5/pe3O++AGZpSXAzWHIoOqtt2VJVzToqvqQhOxy2j5qotDPAr7tZS2NGIcd8rY84f+qFX5RbmnZVUxfW3urLUG7s4ORValaPBhWi8J5jM0bchwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745507; c=relaxed/simple;
	bh=Lww03Tva+xGtjdVhI2TTUFdK6W+drdlLWywKD78LskA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XktNPrXjFUlYmN4CxtihgjJNlhph6P6ATzKdOBHp4SiAMOqbW1IfSwV5W7GkGCuy3XxGSEB5Gt3v8aydxbCYreLaQWoJaFA6h9wVNmbAiODEaYfaCoqxs4U2ld3CE5p0EJlAelktYBNf5Q8n1ujjX9v1eLqgAFk1vCLk3EY4gKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TE89wokE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.0.68] (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id CCBF02017268;
	Fri, 17 Oct 2025 16:58:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CCBF02017268
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760745505;
	bh=5AHvxfzuQfw+TSyUQFIlimfNHlagTkYUoXuHlICzRmw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TE89wokEuIRyE1Rpia27LQoywrQbT34nDsPxrqTZPS6wrrUxdAJD3q0AH/toKmk9o
	 FD0rvLNJAE3IvfjA+Cbd9fBwyvFuz0OT49+HKrteB/VmV2QicBDAriCz0l39eEBke6
	 S0+F/wWEAU/ry1LUuvLp/c+8FT+N4i8Rfv6QM+Nk=
Message-ID: <74e019ac-afc7-3178-0f0a-dc903af5c4ca@linux.microsoft.com>
Date: Fri, 17 Oct 2025 16:58:24 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 0/6] Hyper-V: Implement hypervisor core collection
Content-Language: en-US
To: Wei Liu <wei.liu@kernel.org>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de
References: <20251006224208.1060990-1-mrathor@linux.microsoft.com>
 <20251017223300.GB632885@liuwe-devbox-debian-v2.local>
 <20251017225732.GC632885@liuwe-devbox-debian-v2.local>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20251017225732.GC632885@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 15:57, Wei Liu wrote:
> On Fri, Oct 17, 2025 at 10:33:00PM +0000, Wei Liu wrote:
>> On Mon, Oct 06, 2025 at 03:42:02PM -0700, Mukesh Rathor wrote:
>> [...]
>>> Mukesh Rathor (6):
>>>   x86/hyperv: Rename guest crash shutdown function
>>>   hyperv: Add two new hypercall numbers to guest ABI public header
>>>   hyperv: Add definitions for hypervisor crash dump support
>>>   x86/hyperv: Add trampoline asm code to transition from hypervisor
>>>   x86/hyperv: Implement hypervisor RAM collection into vmcore
>>>   x86/hyperv: Enable build of hypervisor crashdump collection files
>>>
>>
>> Applied to hyperv-next. Thanks.
> 
> This breaks i386 build.
> 
> /work/linux-on-hyperv/linux.git/arch/x86/hyperv/hv_init.c: In function ?hyperv_init?:
> /work/linux-on-hyperv/linux.git/arch/x86/hyperv/hv_init.c:557:17: error: implicit declaration of function ?hv_root_crash_init? [-Werror=implicit-function-declaration]
>   557 |                 hv_root_crash_init();
>       |                 ^~~~~~~~~~~~~~~~~~
> 
> That's because CONFIG_MSHV_ROOT is only available on x86_64. And the
> crash feature is guarded by CONFIG_MSHV_ROOT.
> 
> Applying the following diff fixes the build.


Thanks. A bit surprising tho that CONFIG_MSHV_ROOT doesn't have 
hard dependency on x86_64. It should, no?

Thanks,
-Mukesh


> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index e28737ec7054..c1300339d2eb 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -554,7 +554,9 @@ void __init hyperv_init(void)
>                 memunmap(src);
> 
>                 hv_remap_tsc_clocksource();
> +#ifdef CONFIG_X86_64
>                 hv_root_crash_init();
> +#endif
>         } else {
>                 hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
>                 wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> 
>>
>>>  arch/x86/hyperv/Makefile        |   6 +
>>>  arch/x86/hyperv/hv_crash.c      | 642 ++++++++++++++++++++++++++++++++
>>>  arch/x86/hyperv/hv_init.c       |   1 +
>>>  arch/x86/hyperv/hv_trampoline.S | 101 +++++
>>>  arch/x86/include/asm/mshyperv.h |  13 +
>>>  arch/x86/kernel/cpu/mshyperv.c  |   5 +-
>>>  include/hyperv/hvgdk_mini.h     |   2 +
>>>  include/hyperv/hvhdk_mini.h     |  55 +++
>>>  8 files changed, 823 insertions(+), 2 deletions(-)
>>>  create mode 100644 arch/x86/hyperv/hv_crash.c
>>>  create mode 100644 arch/x86/hyperv/hv_trampoline.S
>>>
>>> -- 
>>> 2.36.1.vfs.0.0
>>>


