Return-Path: <linux-arch+bounces-14198-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D4ABF31B9
	for <lists+linux-arch@lfdr.de>; Mon, 20 Oct 2025 21:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EFD34F4097
	for <lists+linux-arch@lfdr.de>; Mon, 20 Oct 2025 19:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B01261B9E;
	Mon, 20 Oct 2025 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Q9jSzE+I"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21A81E511;
	Mon, 20 Oct 2025 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987122; cv=none; b=Qm3mdiKRSma/4ru1EXNlNgPcOz+NTx21V6eiZt2k8a76OI3e/GjRALZj90sojqDB72ZQSIQt1P9oEMa4AL/2ABM2qURDCLNALmYHB5IXDOwDWME2AnlG9aRWh+I0ibAuJ3F34HATbsYMTraoyXw1Ton6m8hODtksN0AAbLHeJFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987122; c=relaxed/simple;
	bh=k/YGnuYi1+oEiyIdu3aiAPuEkSiMIHNC7xXixsFfNow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7abs0PQ6BvwEYq8Aw+C9GGDcz0KjN7xHWY/aoxXXLqVNLwrFeCPyWfogAtWbPXjzTgNGHXqNCka0hGnRaWuMiS+ohdRyl34zr2decOboEScvd4HpY2xyc8xR+fSnweyYtAsqyvulnyez1b4aSOcdZaBaUEgiTgwE/IWfasd/Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Q9jSzE+I; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9B8B22017241;
	Mon, 20 Oct 2025 12:05:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B8B22017241
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760987120;
	bh=YkNbQ2JGZwnFnBbhOku9O15cwzbdr1Cd18AUEiHnxNw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q9jSzE+I9pwLalOPWqCW9h77biMTbAcRidXNCbivrUIXyjHWBKV27AZkQqr4G2fM9
	 wXn2IH/sRIzzh65NGo4Sfu1s1jci5OTA07wgJPzGmPF4SeK7JUEdqEHYzitOn99Sb3
	 Z3fRZJYavWBJx2gvBv2JtFd8IRfkIvc4Amypih5w=
Message-ID: <4a4fa302-18fa-ba01-ec06-d4bf0cc84032@linux.microsoft.com>
Date: Mon, 20 Oct 2025 12:05:19 -0700
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
To: Michael Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "arnd@arndb.de" <arnd@arndb.de>
References: <20251006224208.1060990-1-mrathor@linux.microsoft.com>
 <20251017223300.GB632885@liuwe-devbox-debian-v2.local>
 <20251017225732.GC632885@liuwe-devbox-debian-v2.local>
 <74e019ac-afc7-3178-0f0a-dc903af5c4ca@linux.microsoft.com>
 <SN6PR02MB4157C70EBD25315F098DB3A1D4F7A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157C70EBD25315F098DB3A1D4F7A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 19:54, Michael Kelley wrote:
> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Friday, October 17, 2025 4:58 PM
>>
>> On 10/17/25 15:57, Wei Liu wrote:
>>> On Fri, Oct 17, 2025 at 10:33:00PM +0000, Wei Liu wrote:
>>>> On Mon, Oct 06, 2025 at 03:42:02PM -0700, Mukesh Rathor wrote:
>>>> [...]
>>>>> Mukesh Rathor (6):
>>>>>   x86/hyperv: Rename guest crash shutdown function
>>>>>   hyperv: Add two new hypercall numbers to guest ABI public header
>>>>>   hyperv: Add definitions for hypervisor crash dump support
>>>>>   x86/hyperv: Add trampoline asm code to transition from hypervisor
>>>>>   x86/hyperv: Implement hypervisor RAM collection into vmcore
>>>>>   x86/hyperv: Enable build of hypervisor crashdump collection files
>>>>>
>>>>
>>>> Applied to hyperv-next. Thanks.
>>>
>>> This breaks i386 build.
>>>
>>> /work/linux-on-hyperv/linux.git/arch/x86/hyperv/hv_init.c: In function ?hyperv_init?:
>>> /work/linux-on-hyperv/linux.git/arch/x86/hyperv/hv_init.c:557:17: error: implicit declaration of function ?hv_root_crash_init? [-Werror=implicit-function-declaration]
>>>   557 |                 hv_root_crash_init();
>>>       |                 ^~~~~~~~~~~~~~~~~~
>>>
>>> That's because CONFIG_MSHV_ROOT is only available on x86_64. And the
>>> crash feature is guarded by CONFIG_MSHV_ROOT.
>>>
>>> Applying the following diff fixes the build.
>>
>>
>> Thanks. A bit surprising tho that CONFIG_MSHV_ROOT doesn't have
>> hard dependency on x86_64. It should, no?
> 
> CONFIG_MSHV_ROOT *does* have a hard dependency on X86_64.
> 
> But the problem is actually more pervasive than just 32-bit builds. Because
> of the hard dependency, 32-bit builds imply CONFIG_MSHV_ROOT=n, which is
> the real problem. In arch/x86/include/asm/mshyperv.h the declaration for
> hv_root_crash_init() is available only when CONFIG_MSHV_ROOT is defined
> (m or y). There's a stub hv_root_crash_init() if CONFIG_MSHV_ROOT is defined
> and CONFIG_CRASH_DUMP=n, but not if CONFIG_MSHV_ROOT=n. The solution
> is to add a stub when CONFIG_MSHV_ROOT=n, as below:
> 
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 76582affefa8..a5b258d268ed 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -248,6 +248,8 @@ void hv_crash_asm_end(void);
>  static inline void hv_root_crash_init(void) {}
>  #endif  /* CONFIG_CRASH_DUMP */
> 
> +#else   /* CONFIG_MSHV_ROOT */
> +static inline void hv_root_crash_init(void) {}
>  #endif  /* CONFIG_MSHV_ROOT */
> 
>  #else /* CONFIG_HYPERV */
> 
> Annoyingly, this solution duplicates the hv_root_crash_init() stub.  So
> an alternate approach that changes a few more lines of code is this:
> 
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 76582affefa8..1342d55c2545 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -237,18 +237,14 @@ static __always_inline u64 hv_raw_get_msr(unsigned int reg)
>  }
>  int hv_apicid_to_vp_index(u32 apic_id);
> 
> -#if IS_ENABLED(CONFIG_MSHV_ROOT)
> -
> -#ifdef CONFIG_CRASH_DUMP
> +#if IS_ENABLED(CONFIG_MSHV_ROOT) && IS_ENABLED(CONFIG_CRASH_DUMP)
>  void hv_root_crash_init(void);
>  void hv_crash_asm32(void);
>  void hv_crash_asm64(void);
>  void hv_crash_asm_end(void);
> -#else   /* CONFIG_CRASH_DUMP */
> +#else   /* CONFIG_MSHV_ROOT && CONFIG_CRASH_DUMP */
>  static inline void hv_root_crash_init(void) {}
> -#endif  /* CONFIG_CRASH_DUMP */
> -
> -#endif  /* CONFIG_MSHV_ROOT */
> +#endif  /* CONFIG_MSHV_ROOT && CONFIG_CRASH_DUMP */
> 
>  #else /* CONFIG_HYPERV */
>  static inline void hyperv_init(void) {}
> 
> Michael

Thanks. Yeah, either of the above two is ok. The latter does not
duplicate, so may be tiny bit better. Wei will pick one and apply
directly.

Thanks,
-Mukesh



