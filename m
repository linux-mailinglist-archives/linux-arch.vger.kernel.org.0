Return-Path: <linux-arch+bounces-9859-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A49CA19B4E
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 00:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8893AD668
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 23:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E893F1C5D74;
	Wed, 22 Jan 2025 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jLXp0xX4"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5321AF4EA;
	Wed, 22 Jan 2025 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737587108; cv=none; b=XSFf/Pk6wePjuRAsZtwrXFl4HcBBJE7dA9rxmmg79jjxbsFyh4oOpKCrQlJXfdFs3+0I19AnLgfVhComuxYREIBmAEzlwU02uUuHjurYdUhBFoZFwSwp31CypmNa5Z8vMa7uh2ou3VYGeVkOuHEZ66C+Wvwv9C1+46J+ZiCLXrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737587108; c=relaxed/simple;
	bh=fyuJydLNwfqzi01pKpAi2Zq0t/dRbXvss3mx5zL/270=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WF9uuJhySa4LDi13EYmiLQqlO2C3TiKVrp6NmBk/wzjAIsLMw0sYEM8ctjsXggQFtZTw6ksAdFiE+7rXV0ehx+NGVBW7U6Svwi5TtGI3cU7LV2DX8a9lEs5M26T5/rGtVV5DFlUpFxM0povSwk3pnbufrm9CwfooLz0REV6uaIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jLXp0xX4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.115] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id CAC672057204;
	Wed, 22 Jan 2025 15:05:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CAC672057204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737587106;
	bh=NOCH19QPQve15/xDfCMek7YUzEnwKF37VwTNG2vrby8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jLXp0xX4Ir1OjqwEMFDxcFawW3sDCvVQudelB5j3vl9twNlUGW8bXqX3vZzL+6EbW
	 cQCK/ohTqBs/+JBnP0rub4I5RDpQfQjBE4OF75X5e0ATmYu81Xl7HMLXACdhGCmReu
	 HlKE+5NSRAZOGaDjdkUbn48X6TialrDHgzFFKlnw=
Message-ID: <0da8c88c-f26d-4992-a871-9f8287eec889@linux.microsoft.com>
Date: Wed, 22 Jan 2025 15:05:06 -0800
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
 <6cf69fbd-b6a0-4e88-85a6-749a4e2dbdaa@linux.microsoft.com>
 <SN6PR02MB415783BB8A3844F5ADD142B2D4042@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415783BB8A3844F5ADD142B2D4042@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/2024 9:48 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Monday, December 9, 2024 12:20 PM
>>
>> On 12/7/2024 6:59 PM, Michael Kelley wrote:
>>> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, December 6, 2024 2:22 PM
>>>>
>>>> There are several bits of Hyper-V-related code that today live in
>>>> arch/x86 but are not really specific to x86_64 and will work on arm64
>>>> too.
>>>>
>>>> Some of these will be needed in the upcoming mshv driver code (for
>>>> Linux as root partition on Hyper-V).
>>>
>>> Previously, Linux as the root partition on Hyper-V was x86 only, which is
>>> why the code is currently under arch/x86. So evidently the mshv driver
>>> is being expanded to support both x86 and arm64, correct? Assuming
>>> that's the case, I have some thoughts about how the source code should
>>> be organized and built. It's probably best to get this right to start with so
>>> it doesn't need to be changed again.
>>
>> Yes, we plan on supporting both architectures (eventually). I completely agree
>> that it's better to sort out these issues now rather than later.
>>
>>>
>>> * Patch 2 of this series moves hv_call_deposit_pages() and
>>>    hv_call_create_vp() to common code, but does not move
>>>    hv_call_add_logical_proc(). All three are used together, so
>>>    I'm wondering why hv_call_add_logical_proc() isn't moved.
>>>
>>
>> The only reason is that in our internal tree there's no common or arm64 code
>> yet that uses it - there is no reason it can't also become common code!
> 
> Maybe I'm missing your point, but hv_call_add_logical_proc() and
> hv_call_create_vp() are called in succession in hv_smp_prepare_cpus(),
> so it seems like they very much go together. Presumably a similar
> sequence will be needed on the arm64 side when running as the
> root partition?
> 

Yes that's right, sorry I wasn't being too clear.

>>
>>> * These three functions were originally put in a separate source
>>>    code file because of being specific to running in the root partition,
>>>    and not needed for generic Linux guest support. I think there's
>>>    value in keeping them in a separate file, rather than merging them
>>>    into hv_common.c. Maybe just move the entire hv_proc.c file?
>>
>> Agreed. I think it should be renamed too - this file will eventually
>> contain some additional hypercall helper functions, some of which may also be
>> shared by the driver code. Something like "hv_call_common.c"?
> 
> I went back and looked at your patch series from a year ago [1], and
> got a better understanding of where this work is headed. I wanted
> to comment on that series back then, but got subsumed in wrapping
> things up for my retirement. :-(  I see significant portions of that
> series have been posted independently and accepted, so my further
> comments here assume the rest of the series is still the macro-level
> approach you are taking.
> 
>>From that series, you are planning three modules, controlled by
> CONFIG_MSHV, CONFIG_MSHV_ROOT, and CONFIG_MSHV_VTL.
> That makes sense, and addresses one of my top-level concerns,
> which is that normal guest kernels shouldn't include all that code.
> And apparently that code works as a module as well as built-in.
> 
> The code currently in hv_proc.c is similar to the code in hv_call.c
> and mshv_root_hv_call.c from that series -- it's a wrapper around
> Hyper-V hypercalls. But a difference is that the code in hv_proc.c
> can't be a module because it is called from hv_smp_prepare_cpus(),
> which must be built-in. So it can't be added to the proposed
> hv_call.c without making all of hv_call.c built-in. Ideally, there
> would be a separate source file just for the code that must be
> built-in. I'm not familiar enough with root partition requirements
> to understand what hv_smp_prepare_cpus() and its calls to
> hv_call_add_logical_proc() and hv_call_create_vp() are doing.
> Evidently it is related to bringing up CPUs in the root partition,
> and not related to guest VMs. But those two hv_call_* functions
> would also be used for managing guest VMs from /dev/mshv.
> 

It makes sense to keep the different kinds of functionality
separated based on where they are needed. I do wonder if it will be
cumbersome to keep all the cases in their own files - builtin/module,
root/guest, and separated into arch directories vs drivers/hv...

> As for the name, I don't really like "common", even though I'm the
> one who created "hv_common.c" back when doing the initial arm64
> support on Hyper-V. :-( My thinking is that anything that isn't under
> arch/x86 or arch/arm64 is by definition shared across architectures,
> so having "common" in the name is superfluous. Maybe just
> staying with hv_proc.c is OK.
> 

I'll stick with hv_proc.c.

>>
>>>    And then later, perhaps move the entire irqdomain.c file as well?
>> Yes, may as well move it too.
> 
> irqdomain.c is also in that category of needing to be built-in. But
> looking more closely, it is x86 specific and should stay where it is. I
> can't immediately tell whether it's feasible to make the Hyper-V
> IOMMU driver (and irqdomain.c) architecture neutral, or whether
> a separate arm64 implementation will be needed. My guess is the
> latter.
> 
>>
>>>    There's also an interesting question of whether to move them into
>>>    drivers/hv, or create a new directory virt/hyperv. Hyper-V support
>>>    started out 15 years ago structured as a driver, hence "drivers/hv".
>>>    But over the time, the support has become significantly more than
>>>    just a driver, so "virt/hyperv" might be a better location for
>>>    non-driver code that had previously been under arch/x86 but is
>>>    now common to all architectures.
>>>
>> I'd be fine with using "virt/hyperv", but I thought "virt" was only for
>> KVM.
> 
> Now that I see the bigger picture from your previous patch series,
> keeping the files in drivers/hv seems OK to me. The 'mshv' code *is*
> a driver that implements /dev/mshv. :-)
> 
>>
>> Another option would be to create subdirectories in "drivers/hv" to
>> organize the different modules more cleanly (i.e. when the /dev/mshv
>> driver code is introduced).
> 
> Putting all the mshv and "running as root partition" files in a single
> sub-directory might make sense. Multiple sub-directories might be
> overkill. But I don't have a strong opinion either way. Putting them
> all directly in drivers/hv seems OK, as does one or more sub-directories.
> 
> One thing I encountered back when first doing the arm64 support is
> that everything in the drivers/hv directory could be built as a module.
> The Hyper-V support under arch/x86 was always built-in, and the
> arch/arm64 code I added was as well. But there was no obvious place
> to put common code that must always be built-in. At the time, I thought
> about introducing virt/hyperv, but had only a single relatively small source
> code file, and introducing that new pathname with its own Makefile, etc.
> seemed like overkill. So drivers/hv/hv_common.c came into existence. I
> tweaked the existing drivers/hv/Makefile so hv_common.c is always
> built-in even when CONFIG_HYPERV=m. It's a little messy, but not too
> bad.
> 
> The difference in what can be built as a module vs. must be built-in
> might be a factor in the directory structure, along with the
> CONFIG options that control whether the root partition code
> gets built at all (see below). The details will govern what works
> well and what ends up being a bit of a mess.
> 
>>
>>> * Today, the code for running in the root partition is built along
>>>    with the rest of the Hyper-V support, and so is present in kernels
>>>    built for normal Linux guests on Hyper-V. I haven't thought about
>>>    all the implications, but perhaps there's value in having a CONFIG
>>>    option to build for the root partition, so that code can be dropped
>>>    from normal kernels. There's a significant amount of new code still
>>>    to come for mshv that could be excluded from normal guests in this
>>>    way. Also, the tests of the hv_root_partition variable could be
>>>    changed to a function the compiler detects is always "false" in a
>>>    kernel built without the CONFIG option, in which case it can drop
>>>    the code for where hv_root_partition is "true".
>>>
>> Using hv_root_partition is a good way to do it, since it won't require
>> many #ifdefs or moving the existing code around too much.
>>
>> I can certainly give it a try, and create a separate patch series
>> introducing the option. I suppose "CONFIG_HYPERV_ROOT" makes sense as a
>> name?
> 
> Now that I see you have CONFIG_MSHV, CONFIG_MSHV_ROOT, and
> CONFIG_MSHV_VTL planned, could building the hv_root_partition code
> just be under control of CONFIG_MSHV_ROOT without introducing
> another CONFIG variable? Is any of the root partition code like
> hv_proc.c and irqdomain.c needed if CONFIG_MSHV_ROOT=n?

I will experiment with it - I think we can probably do it that way, yes.

> Stubs will be needed for functions called from the generic kernel code
> when CONFIG_MSHV_ROOT=n, but those are easily supplied in
> asm/mshyperv.h. If hv_root_partition becomes a function whose
> return value is gated by CONFIG_MSHV_ROOT, then the compiler
> can know when the value is always "false" and drop even the code
> that calls the stubs. But I'm pretty sure the stubs are still needed to
> avoid compile errors, even when the compiler drops the code.
> 
> With this approach, you can avoid #ifdefs except in asm/mshyperv.h
> for the stubs, and in the hv_root_partition() function.
> 
> One more code structure topic:  In the previous patch series,
> some of the mshv code is x86 specific. There is x86 assembler
> code, and references to x86 specific registers (all the HV_X64_*
> registers). Do you plan to put architecture specific code under
> drivers/hv, or under arch/[x86/arm64]/hyperv? We've made
> drivers/hv be architecture neutral -- currently there's only one
> "cheat" with an #ifdef CONFIG_ARM64 in the hv_balloon.c driver
> that turns off some functionality.

Today in our internal tree, all the module code lives in drivers/hv.
Some of the code is arch-neutral "in-theory", but uses hypervisor
features that are not yet supported on arm64, (but may be in future.)

For such features, we use #ifdefs in drivers/hv to conditionally compile
it. Note that today we only compile test arm64, we don't actually have
a running build for it yet, so the driver will be x86_64 only at first.

There is very little driver code that actually deals with architectural
details. If necessary, I imagine we would create arch-specific files
inside drivers/hv at first, and maybe move them to arch/ if appropriate.

> 
> As we discussed previously, the new Hyper-V #include files
> provide the union of x86 and arm64 definitions, with just an
> occasional #ifdef where needed. That was justified because
> that's how the definitions come from the Windows/Hyper-V
> world. But it seems like the mshv code should be structured
> with arch specific code is under arch, not in drivers/hv with
> #ifdefs. The Makefiles in arch/[x86,arm64]/hyperv will need
> to use CONFIG_MSHV, CONFIG_MSHV_ROOT, and
> CONFIG_MSHV_VTL to decide what to build, and whether to
> build as a module vs. built-in.
> 
> Maybe putting the mshv code in a "mshv" subdirectory under
> both drivers/hv and arch/[x86,arm64]/hyperv would conceptually
> help tie together the arch neutral and arch specific portions.
> Or something like that ....
> 

I think it could evolve to that point, but it's hard to say until we
get closer.

>>
>>> * The code currently in hv_proc.c is built for x86 only, and validly
>>>    assumes the page size is 4K. But when the code moves to be
>>>    common across architectures, that assumption is no longer
>>>    valid in the general case. Perhaps the intent is that kernels for
>>>    the root partition should always be built with page size 4K on
>>>    arm64, but nothing enforces that intent. Personally, I think the code
>>>    should be made to work with page sizes other than 4K so as to not
>>>    leave technical debt. But I realize you may have other priorities. If
>>>    there were a CONFIG option for building for the root partition,
>>>    that option could be setup to enforce the 4K page size on arm64.
>>>
>> That makes sense. I suppose this can be done by selecting PAGE_SIZE_4KB
>> under HYPERV in drivers/hv/Kconfig?
> 
> Since the PAGE_SIZE value is independently selectable in the .config
> file, I'm not sure if you can override it when CONFIG_MSHV_ROOT is
> set. But you can allow CONFIG_MSHV_ROOT to be set only if
> PAGE_SIZE_4KB is selected on arm64. I'd have to look in more detail
> to figure out the best way to create an appropriate dependency.
> 
>>
>> I'm not how easy it will be to make the code work with different page
>> sizes, since we use alloc_page() and similar in a few places, assuming 4k.
> 
> alloc_page() is not the problem as it is relatively easy to break up a
> 16K or 64K page into multiple 4K pages when depositing memory.
> And you can round up the amount of deposited memory to the
> larger boundary without doing any harm. But in your previous patch
> series, I see hv_call_withdraw_memory(), wherein Hyper-V gives
> back individual 4K pages in no particular order. That's the killer, as
> it is not feasible to re-assemble a random set of 4K pages into larger
> 16K or 64K pages for free_page().
> 
> So scratch that idea. :-( The root partition must run with a page
> size that matches the size Hyper-V uses to do memory deposits to
> and from a partition, and that's 4K.

Yes that does seem to clinch it. There will have to be a dependency.

Thanks for the detailed responses, sorry it took me some time to get to.

Nuno

> 
> Michael
> 
> [1] https://lore.kernel.org/lkml/1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com/


