Return-Path: <linux-arch+bounces-12623-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33C3AFF940
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 08:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C883171A8E
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 06:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F4428725D;
	Thu, 10 Jul 2025 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cOydII2K"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE822068D;
	Thu, 10 Jul 2025 06:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127369; cv=none; b=uPgyQ/1zj/aSee4JFmtnlaev9Y1D8VTA1Q2xqitQzDzBMfhdBadfp1GkL+G6z76Em0xnqPi2SuCHnklXggTwWbyY2/1EkW1xHFzMeRbvl2remVqWEkbGwM74N7tz28A3u+s65OorHIrcIB3MfDvvrkAPrcYACDqe+iyWk2XyW0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127369; c=relaxed/simple;
	bh=/nOlbeOrrvvxw+M9MKGzMMtoH7vcH9X0upcHMnOWn5Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=foGyrzOO76jG0yxaI1sm2CY9wInhRexOEvf7OXrFITq214Ze9vSxrJ1+IGwzrDoHmbhWNYD52cS6gLij0hDtR8Dz7KbB4uadCxV4gFNI/Lp4hbMotqABVbdiIfUlC4CFwBHdF9EwbxgnmckqaWnBYWGivCDZHtIsegrKVco23mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=cOydII2K; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56A61oVv420818
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 9 Jul 2025 23:01:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56A61oVv420818
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752127312;
	bh=FwvuqdG3hYjFpKWdCMq6tprnniSoRmedFOTBUf2WREU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=cOydII2KcDOQTmWFVW0q5/KLzpEOqFpnyHLLxS1JoRZ9+vwP74kNGSFenusS+FFcP
	 AEfl38tkTa9xogtA+khkrfI6ZWbQzsmHE0ZPh+WeUwrDPxEI/R/Coyn8N2zABaBbtD
	 M6xldWlsVv1wyMc8O1oSS9m8xb0YYaolroX+DZWm1m1XY368ArgAvAcDGe6lKada1G
	 ae563v8hzpdM5IpThABUh4dEge45JPjPxbFEu1oU1ASebBU41KVM9H7Vm+u9vRV7zM
	 42f9PNFNaiuU6dalJAnxPIEb3r1r4zxs4wAdA+dIKxB405GoBTdW4/BJMwzT6Vkmpk
	 qpTCeEG5Byz5A==
Date: Wed, 09 Jul 2025 23:01:50 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: dan.j.williams@intel.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
        linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, gregkh@linuxfoundation.org,
        Will Deacon <will@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>
CC: Yicong Yang <yangyicong@huawei.com>, linuxarm@huawei.com,
        Yushan Wang <wangyushan12@huawei.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/8=5D_generic=3A_Support_A?=
 =?US-ASCII?Q?RCH=5FHAS=5FCPU=5FCACHE=5FINVALIDATE=5FMEMREGION?=
User-Agent: K-9 Mail for Android
In-Reply-To: <686f565121ea5_1d3d100ee@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com> <20250624154805.66985-3-Jonathan.Cameron@huawei.com> <686f565121ea5_1d3d100ee@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <C8F33767-6C7F-4CDA-8B78-6857AA771AD3@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 9, 2025 10:57:37 PM PDT, dan=2Ej=2Ewilliams@intel=2Ecom wrote:
>Jonathan Cameron wrote:
>> From: Yicong Yang <yangyicong@hisilicon=2Ecom>
>>=20
>> ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION provides the mechanism for
>> invalidate certain memory regions in a cache-incoherent manner=2E
>> Currently is used by NVIDMM adn CXL memory=2E This is mainly done
>> by the system component and is implementation define per spec=2E
>> Provides a method for the platforms register their own invalidate
>> method and implement ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=2E
>
>Please run spell-check on changelogs=2E
>
>>=20
>> Architectures can opt in for this support via
>> CONFIG_GENERIC_CPU_CACHE_INVALIDATE_MEMREGION=2E
>>=20
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon=2Ecom>
>> Signed-off-by: Jonathan Cameron <Jonathan=2ECameron@huawei=2Ecom>
>> ---
>>  drivers/base/Kconfig             |  3 +++
>>  drivers/base/Makefile            |  1 +
>>  drivers/base/cache=2Ec             | 46 ++++++++++++++++++++++++++++++=
++
>
>I do not understand what any of this has to do with drivers/base/=2E
>
>See existing cache management memcpy infrastructure in lib/Kconfig=2E
>
>>  include/asm-generic/cacheflush=2Eh | 12 +++++++++
>>  4 files changed, 62 insertions(+)
>>=20
>> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
>> index 064eb52ff7e2=2E=2Ecc6df87a0a96 100644
>> --- a/drivers/base/Kconfig
>> +++ b/drivers/base/Kconfig
>> @@ -181,6 +181,9 @@ config SYS_HYPERVISOR
>>  	bool
>>  	default n
>> =20
>> +config GENERIC_CPU_CACHE_INVALIDATE_MEMREGION
>> +	bool
>> +
>>  config GENERIC_CPU_DEVICES
>>  	bool
>>  	default n
>> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
>> index 8074a10183dc=2E=2E0fbfa4300b98 100644
>> --- a/drivers/base/Makefile
>> +++ b/drivers/base/Makefile
>> @@ -26,6 +26,7 @@ obj-$(CONFIG_DEV_COREDUMP) +=3D devcoredump=2Eo
>>  obj-$(CONFIG_GENERIC_MSI_IRQ) +=3D platform-msi=2Eo
>>  obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) +=3D arch_topology=2Eo
>>  obj-$(CONFIG_GENERIC_ARCH_NUMA) +=3D arch_numa=2Eo
>> +obj-$(CONFIG_GENERIC_CPU_CACHE_INVALIDATE_MEMREGION) +=3D cache=2Eo
>>  obj-$(CONFIG_ACPI) +=3D physical_location=2Eo
>> =20
>>  obj-y			+=3D test/
>> diff --git a/drivers/base/cache=2Ec b/drivers/base/cache=2Ec
>> new file mode 100644
>> index 000000000000=2E=2E8d351657bbef
>> --- /dev/null
>> +++ b/drivers/base/cache=2Ec
>> @@ -0,0 +1,46 @@
>> +// SPDX-License-Identifier: GPL-2=2E0
>> +/*
>> + * Generic support for CPU Cache Invalidate Memregion
>> + */
>> +
>> +#include <linux/spinlock=2Eh>
>> +#include <linux/export=2Eh>
>> +#include <asm/cacheflush=2Eh>
>> +
>> +
>> +static const struct system_cache_flush_method *scfm_data;
>> +DEFINE_SPINLOCK(scfm_lock);
>> +
>> +void generic_set_sys_cache_flush_method(const struct system_cache_flus=
h_method *method)
>> +{
>> +	guard(spinlock_irqsave)(&scfm_lock);
>> +	if (scfm_data || !method || !method->invalidate_memregion)
>> +		return;
>> +
>> +	scfm_data =3D method;
>
>The lock looks unnecessary here, this is just atomic_cmpxchg()=2E
>
>> +}
>> +EXPORT_SYMBOL_GPL(generic_set_sys_cache_flush_method);
>> +
>> +void generic_clr_sys_cache_flush_method(const struct system_cache_flus=
h_method *method)
>> +{
>> +	guard(spinlock_irqsave)(&scfm_lock);
>> +	if (scfm_data && scfm_data =3D=3D method)
>> +		scfm_data =3D NULL;
>
>Same here, but really what is missing is a description of the locking
>requirements of cpu_cache_invalidate_memregion()=2E
>
>
>> +}
>> +
>> +int cpu_cache_invalidate_memregion(int res_desc, phys_addr_t start, si=
ze_t len)
>> +{
>> +	guard(spinlock_irqsave)(&scfm_lock);
>> +	if (!scfm_data)
>> +		return -EOPNOTSUPP;
>> +
>> +	return scfm_data->invalidate_memregion(res_desc, start, len);
>
>Is it really the case that you need to disable interrupts during cache
>operations? For potentially flushing 10s to 100s of gigabytes, is it
>really the case that all archs can support holding interrupts off for
>that event?
>
>A read lock (rcu or rwsem) seems sufficient to maintain registration
>until the invalidate operation completes=2E
>
>If an arch does need to disable interrupts while it manages caches that
>does not feel like something that should be enforced for everyone at
>this top-level entry point=2E
>
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cpu_cache_invalidate_memregion, "DEVMEM");
>> +
>> +bool cpu_cache_has_invalidate_memregion(void)
>> +{
>> +	guard(spinlock_irqsave)(&scfm_lock);
>> +	return !!scfm_data;
>
>Lock seems pointless here=2E
>
>More concerning is this diverges from the original intent of this
>function which was to disable physical address space manipulation from
>virtual environments=2E
>
>Now, different archs may have reason to diverge here but the fact that
>the API requirements are non-obvious points at a minimum to missing
>documentation if not missing cross-arch consensus=2E
>
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cpu_cache_has_invalidate_memregion, "DEVMEM");
>> diff --git a/include/asm-generic/cacheflush=2Eh b/include/asm-generic/c=
acheflush=2Eh
>> index 7ee8a179d103=2E=2E87e64295561e 100644
>> --- a/include/asm-generic/cacheflush=2Eh
>> +++ b/include/asm-generic/cacheflush=2Eh
>> @@ -124,4 +124,16 @@ static inline void flush_cache_vunmap(unsigned lon=
g start, unsigned long end)
>>  	} while (0)
>>  #endif
>> =20
>> +#ifdef CONFIG_GENERIC_CPU_CACHE_INVALIDATE_MEMREGION
>> +
>> +struct system_cache_flush_method {
>> +	int (*invalidate_memregion)(int res_desc,
>> +				    phys_addr_t start, size_t len);
>> +};
>
>The whole point of ARCH_HAS facilities is to resolve symbols like this
>at compile time=2E Why does this need a indirect function call at all?

Yes, blocking interrupts is much like the problem with WBINVD=2E

More or less, once user space is running, this isn't acceptable=2E

