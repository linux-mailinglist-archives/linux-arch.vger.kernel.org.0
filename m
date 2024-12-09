Return-Path: <linux-arch+bounces-9327-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FCC9EA02B
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 21:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4711016651C
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 20:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D421957FC;
	Mon,  9 Dec 2024 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NsRSyzOI"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6BC1547E2;
	Mon,  9 Dec 2024 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733775617; cv=none; b=We+BSuAP+cTzRWmJS7b47EBjwaDOSL5a/kIhEQoSDi+thYVt9ecMIfyGhDml9X1bgnrfWdxUNnpHCGq1MSr0YNAf39DHjT2CRL14TDH1IS7uEwwMM/mygRdfnBmlD7NTekoLwFYKK5XcuCbsOdmpOMws4k6j8u11j20DSU8CZaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733775617; c=relaxed/simple;
	bh=jm161Sfr6vj9CpAF+l9YXeEuadaQnEK3Bmxbtti5Crs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2j/egyAnoQnDwD5aGcW4M9udbI6xTkJ1BeWjTlaQPPCqdJpVPIgc/ZqG2DyPwEGZCNUkZprLlf+WOdEZgQp/5hCLsBkTmqxCZu78Q6Xsml0cmO0qWxVrW7cZrDqiIp0+SRT5O7zgwV9AvRz1SAfz4afXHJwTTONAeRdQA4//e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NsRSyzOI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.115] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 453EB20CECB3;
	Mon,  9 Dec 2024 12:20:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 453EB20CECB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733775615;
	bh=R4826thRCnzo9UT2dSVOhBPmXdFNnd0wF4KQbWcTe4g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NsRSyzOIBWUwgsiQFGVRbC3/A2MikFgjENASO0p/8m5UcXCTUulPAsxip75CP4qsf
	 ctzkCttrkZJZRspRzV/NEZllxMRMKtIgn9G1PLU5Yvlf9XL3FuOo7TSWu7X/hCgnoq
	 ZKGVcXjSI6PhZ6rMAdjd9f15APVQTFTBH0Y/7p8k=
Message-ID: <6cf69fbd-b6a0-4e88-85a6-749a4e2dbdaa@linux.microsoft.com>
Date: Mon, 9 Dec 2024 12:20:14 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hyperv: Move some features to common code
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
 "muminulrussell@gmail.com" <muminulrussell@gmail.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "mukeshrathor@microsoft.com" <mukeshrathor@microsoft.com>
References: <1733523707-15954-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB41573F55DBAAF124CFD92840D4332@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41573F55DBAAF124CFD92840D4332@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/2024 6:59 PM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, December 6, 2024 2:22 PM
>>
>> There are several bits of Hyper-V-related code that today live in
>> arch/x86 but are not really specific to x86_64 and will work on arm64
>> too.
>>
>> Some of these will be needed in the upcoming mshv driver code (for
>> Linux as root partition on Hyper-V).
> 
> Previously, Linux as the root partition on Hyper-V was x86 only, which is
> why the code is currently under arch/x86. So evidently the mshv driver
> is being expanded to support both x86 and arm64, correct? Assuming
> that's the case, I have some thoughts about how the source code should
> be organized and built. It's probably best to get this right to start with so
> it doesn't need to be changed again.

Yes, we plan on supporting both architectures (eventually). I completely agree
that it's better to sort out these issues now rather than later.

> 
> * Patch 2 of this series moves hv_call_deposit_pages() and
>    hv_call_create_vp() to common code, but does not move
>    hv_call_add_logical_proc(). All three are used together, so
>    I'm wondering why hv_call_add_logical_proc() isn't moved.
> 

The only reason is that in our internal tree there's no common or arm64 code
yet that uses it - there is no reason it can't also become common code!

> * These three functions were originally put in a separate source
>    code file because of being specific to running in the root partition,
>    and not needed for generic Linux guest support. I think there's
>    value in keeping them in a separate file, rather than merging them
>    into hv_common.c. Maybe just move the entire hv_proc.c file?

Agreed. I think it should be renamed too - this file will eventually
contain some additional hypercall helper functions, some of which may also be
shared by the driver code. Something like "hv_call_common.c"?

>    And then later, perhaps move the entire irqdomain.c file as well?
Yes, may as well move it too.

>    There's also an interesting question of whether to move them into
>    drivers/hv, or create a new directory virt/hyperv. Hyper-V support
>    started out 15 years ago structured as a driver, hence "drivers/hv".
>    But over the time, the support has become significantly more than
>    just a driver, so "virt/hyperv" might be a better location for
>    non-driver code that had previously been under arch/x86 but is
>    now common to all architectures.
> 
I'd be fine with using "virt/hyperv", but I thought "virt" was only for
KVM.

Another option would be to create subdirectories in "drivers/hv" to
organize the different modules more cleanly (i.e. when the /dev/mshv
driver code is introduced).

> * Today, the code for running in the root partition is built along
>    with the rest of the Hyper-V support, and so is present in kernels
>    built for normal Linux guests on Hyper-V. I haven't thought about
>    all the implications, but perhaps there's value in having a CONFIG
>    option to build for the root partition, so that code can be dropped
>    from normal kernels. There's a significant amount of new code still
>    to come for mshv that could be excluded from normal guests in this
>    way. Also, the tests of the hv_root_partition variable could be
>    changed to a function the compiler detects is always "false" in a
>    kernel built without the CONFIG option, in which case it can drop
>    the code for where hv_root_partition is "true".
> 
Using hv_root_partition is a good way to do it, since it won't require
many #ifdefs or moving the existing code around too much.

I can certainly give it a try, and create a separate patch series
introducing the option. I suppose "CONFIG_HYPERV_ROOT" makes sense as a
name?

> * The code currently in hv_proc.c is built for x86 only, and validly
>    assumes the page size is 4K. But when the code moves to be
>    common across architectures, that assumption is no longer
>    valid in the general case. Perhaps the intent is that kernels for
>    the root partition should always be built with page size 4K on
>    arm64, but nothing enforces that intent. Personally, I think the code
>    should be made to work with page sizes other than 4K so as to not
>    leave technical debt. But I realize you may have other priorities. If
>    there were a CONFIG option for building for the root partition,
>    that option could be setup to enforce the 4K page size on arm64.
> 
That makes sense. I suppose this can be done by selecting PAGE_SIZE_4KB
under HYPERV in drivers/hv/Kconfig?

I'm not how easy it will be to make the code work with different page
sizes, since we use alloc_page() and similar in a few places, assuming 4k.

Thanks
Nuno

> Anyway, thinking through these decisions up front could avoid
> the need for additional moves later on.
> 
> Michael
> 
>> So this is a good time to move
>> them to hv_common.c.
>>
>> Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
>>
>> Nuno Das Neves (2):
>>   hyperv: Move hv_current_partition_id to arch-generic code
>>   hyperv: Move create_vp and deposit_pages hvcalls to hv_common.c
>>
>>  arch/arm64/hyperv/mshyperv.c    |   3 +
>>  arch/x86/hyperv/hv_init.c       |  25 +----
>>  arch/x86/hyperv/hv_proc.c       | 144 ---------------------------
>>  arch/x86/include/asm/mshyperv.h |   4 -
>>  drivers/hv/hv_common.c          | 168 ++++++++++++++++++++++++++++++++
>>  include/asm-generic/mshyperv.h  |   4 +
>>  6 files changed, 176 insertions(+), 172 deletions(-)
>>
>> --
>> 2.34.1


