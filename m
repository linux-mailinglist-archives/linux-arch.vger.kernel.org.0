Return-Path: <linux-arch+bounces-13669-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A761EB81CA3
	for <lists+linux-arch@lfdr.de>; Wed, 17 Sep 2025 22:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FAED526074
	for <lists+linux-arch@lfdr.de>; Wed, 17 Sep 2025 20:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B9E2C08AA;
	Wed, 17 Sep 2025 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kF4TbRiJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E442C0F92;
	Wed, 17 Sep 2025 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758141449; cv=none; b=M6nIT5brlYoe9rEYzUNRiGIELnBnmEoI+0bg9jnN/kyuzVbj555A8hx7d8vIOdUrtvNgCsS3SH4KUCX3f/xU3dJbeiIULI7YEObvmotla6C/OV69wxx1FhPZiJt5w5UgrXWpJjuG/IK4iBVVmM+y3wbeNnln31VFP7rhuQc4v1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758141449; c=relaxed/simple;
	bh=AWnh0NDS/NEl3/tOmsRcC/Zo8FnKWT24coEwr6CX2WM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A5/dB+D5ITqVq4StCbbUhoJwnmCNX4lPsv0DHUFYcEo03QnJjcApASBz31bXaYljbw5Fh/dKFSr99/9eEcSsoVUJdgX/PvwV23OA9KRbcPlOaOJSuT2yky/2/or/MS5o6AOMYvWISaJKGnoyKN7SC0ohH88+hhwTSvbNB9Vfovc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kF4TbRiJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 029C32018E76;
	Wed, 17 Sep 2025 13:37:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 029C32018E76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758141446;
	bh=+4I7C7Q7CI6dsIGmNlx01sNT/RMz5ftV/bvrE7ITfI0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=kF4TbRiJ/nRP0Y9pFPSvvhykjMiKyFCCghTNptUZAw8wEPuyEuJwweRwE617btrQ3
	 rBAA3qpifxa8OGo3i0OaQHFnUlhF4Olwj5noyi4U5mgJeWySRpKKro6ARr+5Hcl8ht
	 xQGn0+AzC7V7/WHFWHMT6gbL+fh4EqP5e4VRFxO0=
Message-ID: <f5877c92-e66b-e530-3431-a91e68388899@linux.microsoft.com>
Date: Wed, 17 Sep 2025 13:37:25 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v1 5/6] x86/hyperv: Implement hypervisor ram collection
 into vmcore
Content-Language: en-US
From: Mukesh R <mrathor@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "arnd@arndb.de" <arnd@arndb.de>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-6-mrathor@linux.microsoft.com>
 <SN6PR02MB4157CD8153650CC9D379A03DD415A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87cab5ec-ab76-b1cf-4891-30314e5dace6@linux.microsoft.com>
In-Reply-To: <87cab5ec-ab76-b1cf-4891-30314e5dace6@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 18:13, Mukesh R wrote:
> On 9/15/25 10:55, Michael Kelley wrote:
>> From: Mukesh Rathor <mrathor@linux.microsoft.com> Sent: Tuesday, September 9, 2025 5:10 PM
>>>
>>> Introduce a new file to implement collection of hypervisor ram into the
>>
>> s/ram/RAM/ (multiple places)
> 
> a quick grep indicates using saying ram is common, i like ram over RAM
> 
>>> vmcore collected by linux. By default, the hypervisor ram is locked, ie,
>>> protected via hw page table. Hyper-V implements a disable hypercall which
>>
>> The terminology here is a bit confusing since you have two names for
>> the same thing: "disable" hypervisor, and "devirtualize". Is it possible to
>> just use "devirtualize" everywhere, and drop the "disable" terminology?
> 
> The concept is devirtualize and the actual hypercall was originally named
> disable. so intermixing is natural imo.

[snip]

>>> +
>>> +/*
>>> + * Setup a temporary gdt to allow the asm code to switch to the long mode.
>>> + * Since the asm code is relocated/copied to a below 4G page, it cannot use rip
>>> + * relative addressing, hence we must use trampoline_pa here. Also, save other
>>> + * info like jmp and C entry targets for same reasons.
>>> + *
>>> + * Returns: 0 on success, -1 on error
>>> + */
>>> +static int hv_crash_setup_trampdata(u64 trampoline_va)
>>> +{
>>> +	int size, offs;
>>> +	void *dest;
>>> +	struct hv_crash_tramp_data *tramp;
>>> +
>>> +	/* These must match exactly the ones in the corresponding asm file */
>>> +	BUILD_BUG_ON(offsetof(struct hv_crash_tramp_data, tramp32_cr3) != 0);
>>> +	BUILD_BUG_ON(offsetof(struct hv_crash_tramp_data, kernel_cr3) != 8);
>>> +	BUILD_BUG_ON(offsetof(struct hv_crash_tramp_data, gdtr32.limit) != 18);
>>> +	BUILD_BUG_ON(offsetof(struct hv_crash_tramp_data,
>>> +						     cs_jmptgt.address) != 40);
>>
>> It would be nice to pick up the constants from a #include file that is
>> shared with the asm code in Patch 4 of the series.
> 
> yeah, could go either way, some don't like tiny headers...  if there are
> no objections to new header for this, i could go that way too.


yeah, i experimented with creating a new header or try to add to existing.
new header doesn't make sense for just 5 #defines, adding C struct there
is not a great idea given it's scope is limited to the specific function
in the c file. adding to another header results in ifdefs for ASM/KERNEL,
so not really worth it. I think for now it is ok, we can live with it.
If arm ends up adding more declarations, we can look into it.


Thanks,
-Mukesh

[ .. deleted.. ]

